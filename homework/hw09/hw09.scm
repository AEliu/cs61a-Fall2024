(define (curry-cook formals body) 
  ; (if (= 1 (length formals))
  ;   `(lambda (,(car formals)) ,body)
  ;   `(lambda (,(car formals)) (lambda ,(cdr formals) ,body)))
  (if (null? formals)
    body
    `(lambda (,(car formals)) ,(curry-cook (cdr formals) body)))
)

(define (curry-consume curry args)
  (if (null? args)
    curry
    (curry-consume (curry (car args)) (cdr args)))
  
)

(define-macro (switch expr options)
  (switch-to-cond (list 'switch expr options)))

(define (switch-to-cond switch-expr)
  (cons _________
        (map (lambda (option)
               (cons _______________ (cdr option)))
             (car (cdr (cdr switch-expr))))))
