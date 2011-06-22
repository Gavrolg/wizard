
(require 'RESTAS)
(require 'CLOSURE-TEMPLATE)
(require 'RESTAS-DIRECTORY-PUBLISHER)

(restas:define-module #:WIZARD
  (:use #:CL #:ITER ))

(in-package #:WIZARD)

(load "src/lib.lisp")

;; Containers

(defparameter *USER*                        (make-hash-table :test #'equal))
(defparameter *OFFER*                       (make-hash-table :test #'equal))
(defparameter *OFFER-RESOURCE*              (make-hash-table :test #'equal))
(defparameter *SALE*                        (make-hash-table :test #'equal))
(defparameter *SUPPLIER-RESOURCE-PRICE*     (make-hash-table :test #'equal))
(defparameter *CATEGORY*                    (make-hash-table :test #'equal))
(defparameter *RESOURCE*                    (make-hash-table :test #'equal))
(defparameter *TENDER*                      (make-hash-table :test #'equal))
(defparameter *DOCUMENT*                    (make-hash-table :test #'equal))

;; Classes


(defclass ADMIN (entity)
((LOGIN                  :initarg :LOGIN               :initform nil :accessor A-LOGIN)
(PASSWORD               :initarg :PASSWORD            :initform nil :accessor A-PASSWORD)))

(defmethod view ((object ADMIN) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Логин : ~A" (LOGIN object))
  (format t "~%Пароль : ~A" (PASSWORD object)))


(defclass EXPERT (entity)
((LOGIN                  :initarg :LOGIN               :initform nil :accessor A-LOGIN)
(PASSWORD               :initarg :PASSWORD            :initform nil :accessor A-PASSWORD)
(NAME                   :initarg :NAME                :initform nil :accessor A-NAME)))

(defmethod initialize-instance :after ((object EXPERT) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *USER*) *USER*) object))

(defmethod view ((object EXPERT) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Логин : ~A" (LOGIN object))
  (format t "~%Пароль : ~A" (PASSWORD object))
  (format t "~%ФИО : ~A" (NAME object)))


(defclass SUPPLIER (entity)
((LOGIN                  :initarg :LOGIN               :initform nil :accessor A-LOGIN)
(PASSWORD               :initarg :PASSWORD            :initform nil :accessor A-PASSWORD)
(NAME                   :initarg :NAME                :initform nil :accessor A-NAME)
(REFERAL                :initarg :REFERAL             :initform nil :accessor A-REFERAL)
(STATUS                 :initarg :STATUS              :initform nil :accessor A-STATUS)
(JURIDICAL-ADDRESS      :initarg :JURIDICAL-ADDRESS   :initform nil :accessor A-JURIDICAL-ADDRESS)
(ACTUAL-ADDRESS         :initarg :ACTUAL-ADDRESS      :initform nil :accessor A-ACTUAL-ADDRESS)
(CONTACTS               :initarg :CONTACTS            :initform nil :accessor A-CONTACTS)
(EMAIL                  :initarg :EMAIL               :initform nil :accessor A-EMAIL)
(SITE                   :initarg :SITE                :initform nil :accessor A-SITE)
(HEADS                  :initarg :HEADS               :initform nil :accessor A-HEADS)
(INN                    :initarg :INN                 :initform nil :accessor A-INN)
(KPP                    :initarg :KPP                 :initform nil :accessor A-KPP)
(OGRN                   :initarg :OGRN                :initform nil :accessor A-OGRN)
(BANK-NAME              :initarg :BANK-NAME           :initform nil :accessor A-BANK-NAME)
(BIK                    :initarg :BIK                 :initform nil :accessor A-BIK)
(CORRESP-ACCOUNT        :initarg :CORRESP-ACCOUNT     :initform nil :accessor A-CORRESP-ACCOUNT)
(CLIENT-ACCOUNT         :initarg :CLIENT-ACCOUNT      :initform nil :accessor A-CLIENT-ACCOUNT)
(ADDRESSES              :initarg :ADDRESSES           :initform nil :accessor A-ADDRESSES)
(CONTACT-PERSON         :initarg :CONTACT-PERSON      :initform nil :accessor A-CONTACT-PERSON)
(RESOURCES              :initarg :RESOURCES           :initform nil :accessor A-RESOURCES)
(SALE                   :initarg :SALE                :initform nil :accessor A-SALE)
(OFFERS                 :initarg :OFFERS              :initform nil :accessor A-OFFERS)))

(defmethod initialize-instance :after ((object SUPPLIER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *USER*) *USER*) object))

(defmethod view ((object SUPPLIER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Логин : ~A" (LOGIN object))
  (format t "~%Пароль : ~A" (PASSWORD object))
  (format t "~%Название организации : ~A" (NAME object))
  (format t "~%Реферал : ~A" (REFERAL object))
  (format t "~%Статус : ~A" (STATUS object))
  (format t "~%Юридический адрес : ~A" (JURIDICAL-ADDRESS object))
  (format t "~%Фактический адрес : ~A" (ACTUAL-ADDRESS object))
  (format t "~%Контактные телефоны : ~A" (CONTACTS object))
  (format t "~%Email : ~A" (EMAIL object))
  (format t "~%Сайт организации : ~A" (SITE object))
  (format t "~%Руководство : ~A" (HEADS object))
  (format t "~%Инн : ~A" (INN object))
  (format t "~%КПП : ~A" (KPP object))
  (format t "~%ОГРН : ~A" (OGRN object))
  (format t "~%Название банка : ~A" (BANK-NAME object))
  (format t "~%Банковский идентификационный код : ~A" (BIK object))
  (format t "~%Корреспондентский счет) : ~A" (CORRESP-ACCOUNT object))
  (format t "~%Рассчетный счет : ~A" (CLIENT-ACCOUNT object))
  (format t "~%Адреса офисов и магазинов : ~A" (ADDRESSES object))
  (format t "~%Контактное лицо : ~A" (CONTACT-PERSON object))
  (format t "~%Поставляемые ресурсы : ~A" (RESOURCES object))
  (format t "~%Скидки и акции : ~A" (SALE object))
  (format t "~%Посланные заявки на тендеры : ~A" (OFFERS object)))


(defclass OFFER (entity)
((OWNER                  :initarg :OWNER               :initform nil :accessor A-OWNER)
(TENDER                 :initarg :TENDER              :initform nil :accessor A-TENDER)
(RESOURCES              :initarg :RESOURCES           :initform nil :accessor A-RESOURCES)))

(defmethod initialize-instance :after ((object OFFER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *OFFER*) *OFFER*) object))

(defmethod view ((object OFFER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Поставщик ресурсов : ~A" (OWNER object))
  (format t "~%Тендер : ~A" (TENDER object))
  (format t "~%Ресурсы заявки : ~A" (RESOURCES object)))


(defclass OFFER-RESOURCE (entity)
((OWNER                  :initarg :OWNER               :initform nil :accessor A-OWNER)
(OFFER                  :initarg :OFFER               :initform nil :accessor A-OFFER)
(RESOURCE               :initarg :RESOURCE            :initform nil :accessor A-RESOURCE)
(PRICE                  :initarg :PRICE               :initform nil :accessor A-PRICE)))

(defmethod initialize-instance :after ((object OFFER-RESOURCE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *OFFER-RESOURCE*) *OFFER-RESOURCE*) object))

(defmethod view ((object OFFER-RESOURCE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Поставщик : ~A" (OWNER object))
  (format t "~%Заявка : ~A" (OFFER object))
  (format t "~%Ресурс : ~A" (RESOURCE object))
  (format t "~%Цена поставщика : ~A" (PRICE object)))


(defclass SALE (entity)
((OWNER                  :initarg :OWNER               :initform nil :accessor A-OWNER)
(RESOURCE               :initarg :RESOURCE            :initform nil :accessor A-RESOURCE)
(PROCENT                :initarg :PROCENT             :initform nil :accessor A-PROCENT)
(PRICE                  :initarg :PRICE               :initform nil :accessor A-PRICE)
(NOTES                  :initarg :NOTES               :initform nil :accessor A-NOTES)))

(defmethod initialize-instance :after ((object SALE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *SALE*) *SALE*) object))

(defmethod view ((object SALE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Поставщик : ~A" (OWNER object))
  (format t "~%Ресурс : ~A" (RESOURCE object))
  (format t "~%Процент скидки : ~A" (PROCENT object))
  (format t "~%Цена со скидкой : ~A" (PRICE object))
  (format t "~%Дополнительные условия : ~A" (NOTES object)))


(defclass SUPPLIER-RESOURCE-PRICE (entity)
((OWNER                  :initarg :OWNER               :initform nil :accessor A-OWNER)
(RESOURCE               :initarg :RESOURCE            :initform nil :accessor A-RESOURCE)
(PRICE                  :initarg :PRICE               :initform nil :accessor A-PRICE)))

(defmethod initialize-instance :after ((object SUPPLIER-RESOURCE-PRICE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *SUPPLIER-RESOURCE-PRICE*) *SUPPLIER-RESOURCE-PRICE*) object))

(defmethod view ((object SUPPLIER-RESOURCE-PRICE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Поставщик : ~A" (OWNER object))
  (format t "~%Ресурс : ~A" (RESOURCE object))
  (format t "~%Цена поставщика : ~A" (PRICE object)))


(defclass BUILDER (entity)
((LOGIN                  :initarg :LOGIN               :initform nil :accessor A-LOGIN)
(PASSWORD               :initarg :PASSWORD            :initform nil :accessor A-PASSWORD)
(NAME                   :initarg :NAME                :initform nil :accessor A-NAME)
(JURIDICAL-ADDRESS      :initarg :JURIDICAL-ADDRESS   :initform nil :accessor A-JURIDICAL-ADDRESS)
(INN                    :initarg :INN                 :initform nil :accessor A-INN)
(KPP                    :initarg :KPP                 :initform nil :accessor A-KPP)
(OGRN                   :initarg :OGRN                :initform nil :accessor A-OGRN)
(BANK-NAME              :initarg :BANK-NAME           :initform nil :accessor A-BANK-NAME)
(BIK                    :initarg :BIK                 :initform nil :accessor A-BIK)
(CORRESP-ACCOUNT        :initarg :CORRESP-ACCOUNT     :initform nil :accessor A-CORRESP-ACCOUNT)
(CLIENT-ACCOUNT         :initarg :CLIENT-ACCOUNT      :initform nil :accessor A-CLIENT-ACCOUNT)
(TENDERS                :initarg :TENDERS             :initform nil :accessor A-TENDERS)
(RATING                 :initarg :RATING              :initform nil :accessor A-RATING)))

(defmethod initialize-instance :after ((object BUILDER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *USER*) *USER*) object))

(defmethod view ((object BUILDER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Логин : ~A" (LOGIN object))
  (format t "~%Пароль : ~A" (PASSWORD object))
  (format t "~%Организация-застройщик : ~A" (NAME object))
  (format t "~%Юридический адрес : ~A" (JURIDICAL-ADDRESS object))
  (format t "~%Инн : ~A" (INN object))
  (format t "~%КПП : ~A" (KPP object))
  (format t "~%ОГРН : ~A" (OGRN object))
  (format t "~%Название банка : ~A" (BANK-NAME object))
  (format t "~%Банковский идентификационный код : ~A" (BIK object))
  (format t "~%Корреспондентский счет) : ~A" (CORRESP-ACCOUNT object))
  (format t "~%Рассчетный счет : ~A" (CLIENT-ACCOUNT object))
  (format t "~%Тендеры : ~A" (TENDERS object))
  (format t "~%Рейтинг : ~A" (RATING object)))


(defclass CATEGORY (entity)
((NAME                   :initarg :NAME                :initform nil :accessor A-NAME)
(PARENT                 :initarg :PARENT              :initform nil :accessor A-PARENT)
(CHILD-CATEGORYES       :initarg :CHILD-CATEGORYES    :initform nil :accessor A-CHILD-CATEGORYES)
(RESOURCES              :initarg :RESOURCES           :initform nil :accessor A-RESOURCES)))

(defmethod initialize-instance :after ((object CATEGORY) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *CATEGORY*) *CATEGORY*) object))

(defmethod view ((object CATEGORY) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Имя : ~A" (NAME object))
  (format t "~%Родительская категория : ~A" (PARENT object))
  (format t "~%Дочерние категории : ~A" (CHILD-CATEGORYES object))
  (format t "~%Ресурсы : ~A" (RESOURCES object)))


(defclass RESOURCE (entity)
((NAME                   :initarg :NAME                :initform nil :accessor A-NAME)
(CATEGORY               :initarg :CATEGORY            :initform nil :accessor A-CATEGORY)
(RESOURCE-TYPE          :initarg :RESOURCE-TYPE       :initform nil :accessor A-RESOURCE-TYPE)
(UNIT                   :initarg :UNIT                :initform nil :accessor A-UNIT)
(SUPPLIERS              :initarg :SUPPLIERS           :initform nil :accessor A-SUPPLIERS)))

(defmethod initialize-instance :after ((object RESOURCE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *RESOURCE*) *RESOURCE*) object))

(defmethod view ((object RESOURCE) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Наименование : ~A" (NAME object))
  (format t "~%Категория : ~A" (CATEGORY object))
  (format t "~%Тип : ~A" (RESOURCE-TYPE object))
  (format t "~%Единица измерения : ~A" (UNIT object))
  (format t "~%Поставляющие организации : ~A" (SUPPLIERS object)))


(defclass TENDER (entity)
((NAME                   :initarg :NAME                :initform nil :accessor A-NAME)
(STATUS                 :initarg :STATUS              :initform nil :accessor A-STATUS)
(OWNER                  :initarg :OWNER               :initform nil :accessor A-OWNER)
(ACTIVE-DATE            :initarg :ACTIVE-DATE         :initform nil :accessor A-ACTIVE-DATE)
(ALL                    :initarg :ALL                 :initform nil :accessor A-ALL)
(CLAIM                  :initarg :CLAIM               :initform nil :accessor A-CLAIM)
(ANALIZE                :initarg :ANALIZE             :initform nil :accessor A-ANALIZE)
(INTERVIEW              :initarg :INTERVIEW           :initform nil :accessor A-INTERVIEW)
(RESULT                 :initarg :RESULT              :initform nil :accessor A-RESULT)
(WINNER                 :initarg :WINNER              :initform nil :accessor A-WINNER)
(PRICE                  :initarg :PRICE               :initform nil :accessor A-PRICE)
(RESOURCES              :initarg :RESOURCES           :initform nil :accessor A-RESOURCES)
(DOCUMENTS              :initarg :DOCUMENTS           :initform nil :accessor A-DOCUMENTS)
(SUPPLIERS              :initarg :SUPPLIERS           :initform nil :accessor A-SUPPLIERS)
(OFFERTS                :initarg :OFFERTS             :initform nil :accessor A-OFFERTS)))

(defmethod initialize-instance :after ((object TENDER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *TENDER*) *TENDER*) object))

(defmethod view ((object TENDER) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Название : ~A" (NAME object))
  (format t "~%Статус : ~A" (STATUS object))
  (format t "~%Заказчик : ~A" (OWNER object))
  (format t "~%Дата активации : ~A" (ACTIVE-DATE object))
  (format t "~%Срок проведения : ~A" (ALL object))
  (format t "~%Срок подачи заявок : ~A" (CLAIM object))
  (format t "~%Срок рассмотрения заявок : ~A" (ANALIZE object))
  (format t "~%Срок проведения интервью : ~A" (INTERVIEW object))
  (format t "~%Срок подведения итогов : ~A" (RESULT object))
  (format t "~%Победитель тендера : ~A" (WINNER object))
  (format t "~%Рекомендуемая стоимость : ~A" (PRICE object))
  (format t "~%Ресурсы : ~A" (RESOURCES object))
  (format t "~%Документы : ~A" (DOCUMENTS object))
  (format t "~%Поставщики : ~A" (SUPPLIERS object))
  (format t "~%Откликнувшиеся поставщики : ~A" (OFFERTS object)))


(defclass DOCUMENT (entity)
((NAME                   :initarg :NAME                :initform nil :accessor A-NAME)
(FILENAME               :initarg :FILENAME            :initform nil :accessor A-FILENAME)
(TENDER                 :initarg :TENDER              :initform nil :accessor A-TENDER)))

(defmethod initialize-instance :after ((object DOCUMENT) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Запись в контейнер
  (setf (gethash (hash-table-count *DOCUMENT*) *DOCUMENT*) object))

(defmethod view ((object DOCUMENT) &key)
  ;; Здесь будет проверка прав
  ;; ...
  ;; Печать
  (format t "~%Название : ~A" (NAME object))
  (format t "~%Имя файла : ~A" (FILENAME object))
  (format t "~%Тендер : ~A" (TENDER object)))


;; Init objects
(load "src/init.lisp")


(restas:define-route main-page ("/")
  (let ((acts (list 
               (list :perm ':ALL 
                     :title "Главная страница"
                     :val (lambda () NIL)
                     :fields (list ))))) 
    (show-acts acts)))

(restas:define-route main-page/post ("/" :method :post)
  (let ((acts `())) 
       (activate acts)))

(restas:define-route admin-page ("/admin")
  (let ((acts (list 
               (list :perm ':ADMIN 
                     :title "Изменить пароль"
                     :val (lambda () (CUR-USER))
                     :fields (list 
                          (list :fld "LOGIN" :perm 111 :typedata '(STR) :name "Логин")
                          (list :fld "PASSWORD" :perm 111 :typedata '(PSWD) :name "Пароль")
                          (list :btn "B3121" :perm 111 :value "Изменить пароль")))
               (list :perm ':ADMIN 
                     :title "Создать аккаунт эксперта"
                     :val (lambda () NIL)
                     :fields (list 
                          (list :fld "LOGIN" :perm 111 :typedata '(STR) :name "Логин")
                          (list :fld "PASSWORD" :perm 111 :typedata '(PSWD) :name "Пароль")
                          (list :btn "B3122" :perm 111 :value "Создать новый аккаунт эксперта")))
               (list :perm ':ADMIN 
                     :title "Эксперты"
                     :val (lambda () (REMOVE-IF-NOT #'(LAMBDA (X) (EQUAL 'EXPERT (TYPE-OF X)))
               (LOOP :FOR OBJ :BEING THE :HASH-VALUES :IN *USER*
                     :COLLECT OBJ)))
                     :fields (list 
                          (list :fld "NAME" :perm 111 :typedata '(STR) :name "ФИО")
                          (list :fld "LOGIN" :perm 111 :typedata '(STR) :name "Логин")
                          (list :btn "B3123" :perm 111 :value "Удалить эксперта")
                          (list :btn "B3124" :perm 111 :value "Сменить пароль эксперта")))
               (list :perm ':ADMIN 
                     :title "Заявки поставщиков на добросовестность"
                     :val (lambda () (REMOVE-IF-NOT
 #'(LAMBDA (X)
     (AND (EQUAL 'SUPPLIER (TYPE-OF X)) (EQUAL (A-STATUS X) :REQUEST)))
 (LOOP :FOR OBJ :BEING THE :HASH-VALUES :IN *USER*
       :COLLECT OBJ)))
                     :fields (list 
                          (list :fld "NAME" :perm 111 :typedata '(STR) :name "ФИО")
                          (list :fld "LOGIN" :perm 111 :typedata '(STR) :name "Логин")
                          (list :btn "B3125" :perm 111 :value "Подтвердить заявку")))))) 
    (show-acts acts)))

(restas:define-route admin-page/post ("/admin" :method :post)
  (let ((acts `(
("B3125" . ,(lambda () NIL))
("B3124" . ,(lambda () NIL))
("B3123" . ,(lambda () NIL))
("B3122" . ,(lambda () (CREATE-EXPERT)))
("B3121" . ,(lambda () (CHANGE-ADMIN-PASSWORD)))))) 
       (activate acts)))

(restas:define-route supplier-page ("/supplier")
  (let ((acts (list 
               (list :perm '(AND :SELF :UNFAIR) 
                     :title "Отправить заявку на добросовестность"
                     :val (lambda () NIL)
                     :fields (list 
                          (list :btn "B3126" :perm 111 :value "Отправить заявку на добросовестность")))
               (list :perm ':SELF 
                     :title "Изменить список ресурсов"
                     :val (lambda () :COLLECTION)
                     :fields (list 
                          (list :fld "OWNER" :perm 111 :typedata '(LINK
                                                                   SUPPLIER) :name "Поставщик")
                          (list :fld "RESOURCE" :perm 111 :typedata '(LINK
                                                                      RESOURCE) :name "Ресурс")
                          (list :fld "PRICE" :perm 111 :typedata '(NUM) :name "Цена поставщика")
                          (list :btn "B3127" :perm 111 :value "Добавить ресурс")
                          (list :btn "B3128" :perm 111 :value "Удалить ресурс")
                          (list :btn "B3129" :perm 111 :value "Изменить ресурс")))
               (list :perm ':SELF 
                     :title "Заявки на тендеры"
                     :val (lambda () :COLLECTION)
                     :fields (list 
                          (list :fld "TENDER" :perm 111 :typedata '(LINK TENDER) :name "Тендер")))))) 
    (show-acts acts)))

(restas:define-route supplier-page/post ("/supplier" :method :post)
  (let ((acts `(
("B3129" . ,(lambda () NIL))
("B3128" . ,(lambda () NIL))
("B3127" . ,(lambda () NIL))
("B3126" . ,(lambda () (SUPPLIER-REQUEST-FAIR USER)))))) 
       (activate acts)))

(restas:define-route tender-page ("/tender")
  (let ((acts (list 
               (list :perm '(AND :ACTIVE :FAIR) 
                     :title "Ответить заявкой на тендер"
                     :val (lambda () NIL)
                     :fields (list 
                          (list :fld "NAME" :perm 111 :typedata '(STR) :name "Название")
                          (list :fld "STATUS" :perm 111 :typedata '(LIST-OF-KEYS
                                                                    TENDER-STATUS) :name "Статус")
                          (list :fld "OWNER" :perm 111 :typedata '(LINK BUILDER) :name "Заказчик")
                          (list :fld "ACTIVE-DATE" :perm 111 :typedata '(DATE) :name "Дата активации")
                          (list :fld "ALL" :perm 111 :typedata '(INTERVAL) :name "Срок проведения")
                          (list :fld "CLAIM" :perm 111 :typedata '(INTERVAL) :name "Срок подачи заявок")
                          (list :fld "ANALIZE" :perm 111 :typedata '(INTERVAL) :name "Срок рассмотрения заявок")
                          (list :fld "INTERVIEW" :perm 111 :typedata '(INTERVAL) :name "Срок проведения интервью")
                          (list :fld "RESULT" :perm 111 :typedata '(INTERVAL) :name "Срок подведения итогов")
                          (list :fld "WINNER" :perm 111 :typedata '(LINK
                                                                    SUPPLIER) :name "Победитель тендера")
                          (list :fld "PRICE" :perm 111 :typedata '(NUM) :name "Рекомендуемая стоимость")
                          (list :fld "RESOURCES" :perm 111 :typedata '(LIST-OF-LINKS
                                                                       RESOURCE) :name "Ресурсы")
                          (list :fld "DOCUMENTS" :perm 111 :typedata '(LIST-OF-LINKS
                                                                       DOCUMENT) :name "Документы")
                          (list :fld "SUPPLIERS" :perm 111 :typedata '(LIST-OF-LINKS
                                                                       SUPPLIER) :name "Поставщики")
                          (list :fld "OFFERTS" :perm 111 :typedata '(LIST-OF-LINKS
                                                                     SUPPLIER) :name "Откликнувшиеся поставщики")
                          (list :btn "B3130" :perm 111 :value "Ответить заявкой на тендер")))
               (list :perm ':OWNER 
                     :title "Отменить тендер"
                     :val (lambda () NIL)
                     :fields (list 
                          (list :btn "B3131" :perm 111 :value "Отменить тендер")))))) 
    (show-acts acts)))

(restas:define-route tender-page/post ("/tender" :method :post)
  (let ((acts `(
("B3131" . ,(lambda () '((CAPTION Действительно отменить? PERM OWNER ENTITY
                          TENDER FIELDS
                          '(BTN Подтверждаю отмену ACT
                            (CANCEL-TENDER USER ROW))))))
("B3130" . ,(lambda () NIL))))) 
       (activate acts)))

(restas:define-route builder-page ("/builder")
  (let ((acts (list 
               (list :perm ':SELF 
                     :title "Застройщик такой-то (name object)"
                     :val (lambda () NIL)
                     :fields (list 
                          (list :fld "NAME" :perm 111 :typedata '(STR) :name "Организация-застройщик")
                          (list :fld "JURIDICAL-ADDRESS" :perm 111 :typedata '(STR) :name "Юридический адрес")
                          (list :fld "INN" :perm 111 :typedata '(STR) :name "Инн")
                          (list :fld "KPP" :perm 111 :typedata '(STR) :name "КПП")
                          (list :fld "OGRN" :perm 111 :typedata '(STR) :name "ОГРН")
                          (list :fld "BANK-NAME" :perm 111 :typedata '(STR) :name "Название банка")
                          (list :fld "BIK" :perm 111 :typedata '(STR) :name "Банковский идентификационный код")
                          (list :fld "CORRESP-ACCOUNT" :perm 111 :typedata '(STR) :name "Корреспондентский счет)")
                          (list :fld "CLIENT-ACCOUNT" :perm 111 :typedata '(STR) :name "Рассчетный счет")
                          (list :fld "TENDERS" :perm 111 :typedata '(LIST-OF-LINK
                                                                     TENDER) :name "Тендеры")
                          (list :fld "RATING" :perm 111 :typedata '(NUM) :name "Рейтинг")))
               (list :perm ':SELF 
                     :title "Объявить новый тендер"
                     :val (lambda () NIL)
                     :fields (list 
                          (list :fld "NAME" :perm 111 :typedata '(STR) :name "Название")
                          (list :fld "ALL" :perm 111 :typedata '(INTERVAL) :name "Срок проведения")
                          (list :fld "CLAIM" :perm 111 :typedata '(INTERVAL) :name "Срок подачи заявок")
                          (list :fld "ANALIZE" :perm 111 :typedata '(INTERVAL) :name "Срок рассмотрения заявок")
                          (list :fld "INTERVIEW" :perm 111 :typedata '(INTERVAL) :name "Срок проведения интервью")
                          (list :fld "RESULT" :perm 111 :typedata '(INTERVAL) :name "Срок подведения итогов")
                          (list :fld "RESOURCES" :perm 111 :typedata '(LIST-OF-LINKS
                                                                       RESOURCE) :name "Ресурсы")
                          (list :fld "DOCUMENTS" :perm 111 :typedata '(LIST-OF-LINKS
                                                                       DOCUMENT) :name "Документы")
                          (list :fld "PRICE" :perm 111 :typedata '(NUM) :name "Рекомендуемая стоимость")
                          (list :fld "SUPPLIERS" :perm 111 :typedata '(LIST-OF-LINKS
                                                                       SUPPLIER) :name "Поставщики")
                          (list :btn "B3132" :perm 111 :value "Объявить тендер")))))) 
    (show-acts acts)))

(restas:define-route builder-page/post ("/builder" :method :post)
  (let ((acts `(
("B3132" . ,(lambda () NIL))))) 
       (activate acts)))

(restas:define-route suppliers-page ("/suppliers")
  (let ((acts (list 
               (list :perm '"<?>" 
                     :title "Организации-поставщики"
                     :val (lambda () (REMOVE-IF-NOT #'(LAMBDA (X) (EQUAL 'SUPPLIER (TYPE-OF X)))
               (LOOP :FOR OBJ :BEING THE :HASH-VALUES :IN *USER*
                     :COLLECT OBJ)))
                     :fields (list 
                          (list :fld "NAME" :perm 111 :typedata '(STR) :name "Название организации")
                          (list :fld "LOGIN" :perm 111 :typedata '(STR) :name "Логин")))))) 
    (show-acts acts)))

(restas:define-route suppliers-page/post ("/suppliers" :method :post)
  (let ((acts `())) 
       (activate acts)))