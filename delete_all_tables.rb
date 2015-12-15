# TODO research how to run this on a rails console environment
Enrollment.destroy_all
raise RuntimeError, "At least one regid needed" unless Enrollment.all.size == 0
Student.destroy_all
raise RuntimeError, "At least one regid needed" unless Student.all.size == 0
