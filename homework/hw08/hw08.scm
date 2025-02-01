(define (ascending? s)
  (if (or (null? s) (= 1 (length s)))
      #t
      (and (<= (car s) (car (cdr s)))
           (ascending? (cdr s)))))

(define (my-filter pred s)
  (if (null? s)
      ()
      (if (pred (car s))
          (cons (car s) (my-filter pred (cdr s)))
          (my-filter pred (cdr s)))))

(define (interleave lst1 lst2)
  (cond 
    ((null? lst1)
     lst2)
    ((null? lst2)
     lst1)
    (else
     (append (list (car lst1) (car lst2))
             (interleave (cdr lst1) (cdr lst2))))))

(define (no-repeats s)
  (cond 
    ((null? s)
     s)
    (else
     (cons (car s)
           (no-repeats
            (filter (lambda (x) (not (= x (car s)))) (cdr s)))))))
