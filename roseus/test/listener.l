#!/usr/bin/env runeus
;;;
;;; euslisp version of ros_tutorials/rospy_tutorials/001_talker_listener
;;;
(unless (find "roseus/euslisp/" *load-path* :test #'substringp)
  (pushnew (format nil "~A/euslisp/"
                   (read-line (piped-fork "rospack find roseus")))
           *load-path* :test #'equal))
(load "roseus.l")
;;(setq ros::*compile-message* t) ;; comment out if you want to compile msg and srv
;; when msgs and srvs are compiled, all msgs and srvs should be loaded.
(roseus-add-msgs "roslib")
(roseus-add-msgs "std_msgs")
;;;

;;;
;;;
(roseus "listener")
;;(setq sys::*gc-hook* #'(lambda (a b) (format t ";; gc ~A ~A~%" a b)))

;; callback function
;(defun string-cb (msg) (print (list 'cb (sys::thread-self) (send msg :data))))
;(ros::subscribe "chatter" std_msgs::string #'string-cb)

; lambda function
;(ros::subscribe "chatter" std_msgs::string
;                #'(lambda (msg) (ros::rosinfo 
;                                 (format nil "I heard ~A" (send msg :data)))))

;; method call
(defclass string-cb-class
  :super propertied-object
  :slots ())
(defmethod string-cb-class
  (:init () (ros::subscribe "chatter" std_msgs::string #'send self :string-cb))
  (:string-cb (msg) (print (list 'cb self (send msg :data)))))
(setq m (instance string-cb-class :init))

(do-until-key
 (ros::spin-once)
 ;;(sys::gc)
)
;(ros::spin)













