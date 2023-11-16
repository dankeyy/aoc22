(defun split-string (string separator)
  (loop with len = (length string)
        with sep-len = (length separator)
        for start = 0 then (incf end sep-len)
        for end = (search separator string :start2 start)
        collect (subseq string start (or end len))
        while end))


(defstruct monkey
  items
  func
  inspected)

(defvar monkeys-prod 1)


;; parsing helper macro
(defmacro advance-and-parse-into (var keyword parser)
  `(progn
     (setq start (+ end 1))
     (setq end (or (position #\Newline text :start start) (length text)))
     (setq ,var (funcall ,parser (subseq text
                                         (+ (search ,keyword text :start2 start :end2 end)
                                            (length ,keyword))
                                         end)))))

;; parsers
(defun parse-items (s)
  (let ((items (mapcar #'parse-integer (split-string s ", "))))
    (make-array (length items)
                :initial-contents items
                :adjustable t
                :fill-pointer (length items))))


(defun parse-operation (operation-parts)
  (destructuring-bind (op1 op op3) (split-string operation-parts " ")
    `(,(intern op) ,(read-from-string op1) ,(read-from-string op3))))


(defun parse-monkey (text divide-by-3?)
  (let
    ((monkey (make-monkey))
     (end (position #\Newline text))
     start items operation divisible-by true-target false-target)

    (advance-and-parse-into items         "Starting items: "            #'parse-items)
    (advance-and-parse-into operation     "Operation: new = "           #'parse-operation)
    (advance-and-parse-into divisible-by  "Test: divisible by "         #'parse-integer)
    (advance-and-parse-into true-target   "If true: throw to monkey "   #'parse-integer)
    (advance-and-parse-into false-target  "If false: throw to monkey "  #'parse-integer)

    ;; monkey inspected items count
    (setf (monkey-inspected monkey) 0)

    ;; monkey initial items
    (setf (monkey-items monkey) items)

    (setf monkeys-prod (* divisible-by monkeys-prod))

    ;; monkey driving function
    (setf (monkey-func monkey)
          (eval
          `(lambda (old)
              (let ((worry-level (if ,divide-by-3?
                                     (truncate (/ ,operation 3))
                                     (mod ,operation ,monkeys-prod))))
                (if (zerop (rem worry-level ,divisible-by))
                  (list worry-level ,true-target)
                  (list worry-level ,false-target))))))

    monkey))


(defun parse-monkeys (text divide-by-3?)
  (loop for monkey-text in (split-string text "

")
        collect (parse-monkey monkey-text divide-by-3?)))


;; solve
(defvar *file-contents* nil)
(with-open-file (stream "11test.txt")
  (let ((contents (make-string (file-length stream))))
    (read-sequence contents stream)
    (setf *file-contents* contents)))

(defun monkeys-after-n-rounds (monkeys rounds)
  (let* ((inspection-result nil)
         (pass-item-to nil)
         (item-value nil))

    (loop for _ from 0 below rounds do
      (loop for monkey in monkeys do

        (loop for item across (monkey-items monkey) do
          (setf inspection-result (funcall (monkey-func monkey) item))
          (setf item-value (first inspection-result))
          (setf pass-item-to (second inspection-result))
          (vector-push-extend item-value (monkey-items (nth pass-item-to monkeys)))
          (setf (monkey-inspected monkey) (1+ (monkey-inspected monkey))))

        (setf (fill-pointer (monkey-items monkey)) 0)))

    monkeys))


(defun mul-max-two-inspected (monkeys)
  (loop for monkey in monkeys
        collect (slot-value monkey 'inspected) into inspected-values
        finally (return (reduce #'* (subseq (sort inspected-values #'>) 0 2)))))


(defun solve (&key (filename "11test.txt") (rounds 20) (divide-by-3? t) (return-monkeys? nil))
  (with-open-file (stream filename)
    (let* ((monkeys nil)
           (text (make-string (file-length stream))))
      (read-sequence text stream)
      (setf monkeys (parse-monkeys text divide-by-3?))
      (setf monkeys (monkeys-after-n-rounds monkeys rounds))
      (if return-monkeys?
          monkeys
          (mul-max-two-inspected monkeys)))))

;; part 1:
;; (solve :filename "11.txt")
;;
;; part 2:
;; (solve :filename "11.txt" :rounds 10000 :divide-by-3? nil)
