From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Mar 2017 14:53:46 +0200
Subject: [LTP] [PATCH 1/1] gitignore: Add run.sh files from open posix
	testsuite
Message-ID: <20170329125346.8182-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/.gitignore | 1 +
 testcases/open_posix_testsuite/conformance/behavior/timers/.gitignore    | 1 +
 testcases/open_posix_testsuite/conformance/definitions/aio_h/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/definitions/errno_h/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/definitions/mqueue_h/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/definitions/pthread_h/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/definitions/sched_h/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/definitions/signal_h/.gitignore     | 1 +
 testcases/open_posix_testsuite/conformance/definitions/time_h/.gitignore | 1 +
 .../open_posix_testsuite/conformance/definitions/unistd_h/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_cancel/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_error/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_fsync/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_read/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_return/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_suspend/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/aio_write/.gitignore     | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/asctime/.gitignore | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore   | 1 +
 .../conformance/interfaces/clock_getcpuclockid/.gitignore                | 1 +
 .../open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore | 1 +
 .../conformance/interfaces/clock_nanosleep/.gitignore                    | 1 +
 .../open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore | 1 +
 .../conformance/interfaces/clock_settime/speculative/.gitignore          | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/ctime/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/difftime/.gitignore      | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/fork/.gitignore    | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/fsync/.gitignore   | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/getpid/.gitignore  | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/gmtime/.gitignore  | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/kill/.gitignore    | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/killpg/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/interfaces/lio_listio/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/localtime/.gitignore     | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/mktime/.gitignore  | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore   | 1 +
 .../conformance/interfaces/mlock/speculative/.gitignore                  | 1 +
 .../open_posix_testsuite/conformance/interfaces/mlockall/.gitignore      | 1 +
 .../conformance/interfaces/mlockall/speculative/.gitignore               | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_close/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore    | 1 +
 .../conformance/interfaces/mq_getattr/speculative/.gitignore             | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore     | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/mq_open/.gitignore | 1 +
 .../conformance/interfaces/mq_open/speculative/.gitignore                | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore    | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/mq_send/.gitignore | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore    | 1 +
 .../conformance/interfaces/mq_timedreceive/.gitignore                    | 1 +
 .../conformance/interfaces/mq_timedreceive/speculative/.gitignore        | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_timedsend/.gitignore  | 1 +
 .../conformance/interfaces/mq_timedsend/speculative/.gitignore           | 1 +
 .../open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore     | 1 +
 .../conformance/interfaces/mq_unlink/speculative/.gitignore              | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore | 1 +
 .../open_posix_testsuite/conformance/interfaces/munlockall/.gitignore    | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore     | 1 +
 .../conformance/interfaces/pthread_atfork/.gitignore                     | 1 +
 .../conformance/interfaces/pthread_attr_destroy/.gitignore               | 1 +
 .../conformance/interfaces/pthread_attr_getdetachstate/.gitignore        | 1 +
 .../conformance/interfaces/pthread_attr_getinheritsched/.gitignore       | 1 +
 .../conformance/interfaces/pthread_attr_getschedparam/.gitignore         | 1 +
 .../conformance/interfaces/pthread_attr_getschedpolicy/.gitignore        | 1 +
 .../conformance/interfaces/pthread_attr_getscope/.gitignore              | 1 +
 .../conformance/interfaces/pthread_attr_getstack/.gitignore              | 1 +
 .../conformance/interfaces/pthread_attr_getstacksize/.gitignore          | 1 +
 .../conformance/interfaces/pthread_attr_init/.gitignore                  | 1 +
 .../conformance/interfaces/pthread_attr_setdetachstate/.gitignore        | 1 +
 .../conformance/interfaces/pthread_attr_setinheritsched/.gitignore       | 1 +
 .../conformance/interfaces/pthread_attr_setschedparam/.gitignore         | 1 +
 .../interfaces/pthread_attr_setschedparam/speculative/.gitignore         | 1 +
 .../conformance/interfaces/pthread_attr_setschedpolicy/.gitignore        | 1 +
 .../conformance/interfaces/pthread_attr_setscope/.gitignore              | 1 +
 .../conformance/interfaces/pthread_attr_setstack/.gitignore              | 1 +
 .../conformance/interfaces/pthread_attr_setstacksize/.gitignore          | 1 +
 .../conformance/interfaces/pthread_barrier_destroy/.gitignore            | 1 +
 .../conformance/interfaces/pthread_barrier_init/.gitignore               | 1 +
 .../conformance/interfaces/pthread_barrier_wait/.gitignore               | 1 +
 .../conformance/interfaces/pthread_barrierattr_destroy/.gitignore        | 1 +
 .../conformance/interfaces/pthread_barrierattr_getpshared/.gitignore     | 1 +
 .../conformance/interfaces/pthread_barrierattr_init/.gitignore           | 1 +
 .../conformance/interfaces/pthread_barrierattr_setpshared/.gitignore     | 1 +
 .../conformance/interfaces/pthread_cancel/.gitignore                     | 1 +
 .../conformance/interfaces/pthread_cleanup_pop/.gitignore                | 1 +
 .../conformance/interfaces/pthread_cleanup_push/.gitignore               | 1 +
 .../conformance/interfaces/pthread_cond_broadcast/.gitignore             | 1 +
 .../conformance/interfaces/pthread_cond_destroy/.gitignore               | 1 +
 .../conformance/interfaces/pthread_cond_destroy/speculative/.gitignore   | 1 +
 .../conformance/interfaces/pthread_cond_init/.gitignore                  | 1 +
 .../conformance/interfaces/pthread_cond_signal/.gitignore                | 1 +
 .../conformance/interfaces/pthread_cond_timedwait/.gitignore             | 1 +
 .../conformance/interfaces/pthread_cond_wait/.gitignore                  | 1 +
 .../conformance/interfaces/pthread_condattr_destroy/.gitignore           | 1 +
 .../conformance/interfaces/pthread_condattr_getclock/.gitignore          | 1 +
 .../conformance/interfaces/pthread_condattr_getpshared/.gitignore        | 1 +
 .../conformance/interfaces/pthread_condattr_init/.gitignore              | 1 +
 .../conformance/interfaces/pthread_condattr_setclock/.gitignore          | 1 +
 .../conformance/interfaces/pthread_condattr_setpshared/.gitignore        | 1 +
 .../conformance/interfaces/pthread_create/.gitignore                     | 1 +
 .../conformance/interfaces/pthread_detach/.gitignore                     | 1 +
 .../open_posix_testsuite/conformance/interfaces/pthread_equal/.gitignore | 1 +
 .../open_posix_testsuite/conformance/interfaces/pthread_exit/.gitignore  | 1 +
 .../conformance/interfaces/pthread_getcpuclockid/.gitignore              | 1 +
 .../conformance/interfaces/pthread_getcpuclockid/speculative/.gitignore  | 1 +
 .../conformance/interfaces/pthread_getschedparam/.gitignore              | 1 +
 .../conformance/interfaces/pthread_getspecific/.gitignore                | 1 +
 .../open_posix_testsuite/conformance/interfaces/pthread_join/.gitignore  | 1 +
 .../conformance/interfaces/pthread_join/speculative/.gitignore           | 1 +
 .../conformance/interfaces/pthread_key_create/.gitignore                 | 1 +
 .../conformance/interfaces/pthread_key_create/speculative/.gitignore     | 1 +
 .../conformance/interfaces/pthread_key_delete/.gitignore                 | 1 +
 .../open_posix_testsuite/conformance/interfaces/pthread_kill/.gitignore  | 1 +
 .../conformance/interfaces/pthread_mutex_destroy/.gitignore              | 1 +
 .../conformance/interfaces/pthread_mutex_destroy/speculative/.gitignore  | 1 +
 .../conformance/interfaces/pthread_mutex_getprioceiling/.gitignore       | 1 +
 .../conformance/interfaces/pthread_mutex_init/.gitignore                 | 1 +
 .../conformance/interfaces/pthread_mutex_init/speculative/.gitignore     | 1 +
 .../conformance/interfaces/pthread_mutex_lock/.gitignore                 | 1 +
 .../conformance/interfaces/pthread_mutex_setprioceiling/.gitignore       | 1 +
 .../conformance/interfaces/pthread_mutex_timedlock/.gitignore            | 1 +
 .../conformance/interfaces/pthread_mutex_trylock/.gitignore              | 1 +
 .../conformance/interfaces/pthread_mutex_unlock/.gitignore               | 1 +
 .../conformance/interfaces/pthread_mutexattr_destroy/.gitignore          | 1 +
 .../conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore   | 1 +
 .../conformance/interfaces/pthread_mutexattr_getprotocol/.gitignore      | 1 +
 .../conformance/interfaces/pthread_mutexattr_getpshared/.gitignore       | 1 +
 .../conformance/interfaces/pthread_mutexattr_gettype/.gitignore          | 1 +
 .../interfaces/pthread_mutexattr_gettype/speculative/.gitignore          | 1 +
 .../conformance/interfaces/pthread_mutexattr_init/.gitignore             | 1 +
 .../conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore   | 1 +
 .../conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore      | 1 +
 .../conformance/interfaces/pthread_mutexattr_setpshared/.gitignore       | 1 +
 .../conformance/interfaces/pthread_mutexattr_settype/.gitignore          | 1 +
 .../open_posix_testsuite/conformance/interfaces/pthread_once/.gitignore  | 1 +
 .../conformance/interfaces/pthread_rwlock_destroy/.gitignore             | 1 +
 .../conformance/interfaces/pthread_rwlock_init/.gitignore                | 1 +
 .../conformance/interfaces/pthread_rwlock_rdlock/.gitignore              | 1 +
 .../conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore         | 1 +
 .../conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore         | 1 +
 .../conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore           | 1 +
 .../conformance/interfaces/pthread_rwlock_trywrlock/.gitignore           | 1 +
 .../interfaces/pthread_rwlock_trywrlock/speculative/.gitignore           | 1 +
 .../conformance/interfaces/pthread_rwlock_unlock/.gitignore              | 1 +
 .../conformance/interfaces/pthread_rwlock_wrlock/.gitignore              | 1 +
 .../conformance/interfaces/pthread_rwlockattr_destroy/.gitignore         | 1 +
 .../conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore      | 1 +
 .../conformance/interfaces/pthread_rwlockattr_init/.gitignore            | 1 +
 .../conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/pthread_self/.gitignore  | 1 +
 .../conformance/interfaces/pthread_setcancelstate/.gitignore             | 1 +
 .../conformance/interfaces/pthread_setcanceltype/.gitignore              | 1 +
 .../conformance/interfaces/pthread_setschedparam/.gitignore              | 1 +
 .../conformance/interfaces/pthread_setschedprio/.gitignore               | 1 +
 .../conformance/interfaces/pthread_setspecific/.gitignore                | 1 +
 .../conformance/interfaces/pthread_sigmask/.gitignore                    | 1 +
 .../conformance/interfaces/pthread_spin_destroy/.gitignore               | 1 +
 .../conformance/interfaces/pthread_spin_init/.gitignore                  | 1 +
 .../conformance/interfaces/pthread_spin_lock/.gitignore                  | 1 +
 .../conformance/interfaces/pthread_spin_trylock/.gitignore               | 1 +
 .../conformance/interfaces/pthread_spin_unlock/.gitignore                | 1 +
 .../conformance/interfaces/pthread_testcancel/.gitignore                 | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/raise/.gitignore   | 1 +
 .../conformance/interfaces/sched_get_priority_max/.gitignore             | 1 +
 .../conformance/interfaces/sched_get_priority_min/.gitignore             | 1 +
 .../conformance/interfaces/sched_getparam/.gitignore                     | 1 +
 .../conformance/interfaces/sched_getparam/speculative/.gitignore         | 1 +
 .../conformance/interfaces/sched_getscheduler/.gitignore                 | 1 +
 .../conformance/interfaces/sched_rr_get_interval/.gitignore              | 1 +
 .../conformance/interfaces/sched_rr_get_interval/speculative/.gitignore  | 1 +
 .../conformance/interfaces/sched_setparam/.gitignore                     | 1 +
 .../conformance/interfaces/sched_setscheduler/.gitignore                 | 1 +
 .../open_posix_testsuite/conformance/interfaces/sched_yield/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_close/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_destroy/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_getvalue/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_init/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_open/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_post/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_timedwait/.gitignore | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_unlink/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/sem_wait/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/shm_open/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigaction/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigaddset/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigaltstack/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigdelset/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigemptyset/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigfillset/.gitignore    | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/sighold/.gitignore | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigignore/.gitignore     | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigismember/.gitignore   | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/signal/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigpause/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigpending/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigprocmask/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigqueue/.gitignore      | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigrelse/.gitignore      | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/sigset/.gitignore  | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigsuspend/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigtimedwait/.gitignore  | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/sigwait/.gitignore | 1 +
 .../open_posix_testsuite/conformance/interfaces/sigwaitinfo/.gitignore   | 1 +
 .../open_posix_testsuite/conformance/interfaces/strftime/.gitignore      | 1 +
 testcases/open_posix_testsuite/conformance/interfaces/time/.gitignore    | 1 +
 .../open_posix_testsuite/conformance/interfaces/timer_create/.gitignore  | 1 +
 .../conformance/interfaces/timer_create/speculative/.gitignore           | 1 +
 .../open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore  | 1 +
 .../conformance/interfaces/timer_delete/speculative/.gitignore           | 1 +
 .../conformance/interfaces/timer_getoverrun/.gitignore                   | 1 +
 .../conformance/interfaces/timer_getoverrun/speculative/.gitignore       | 1 +
 .../open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore | 1 +
 .../conformance/interfaces/timer_gettime/speculative/.gitignore          | 1 +
 .../open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore | 1 +
 .../conformance/interfaces/timer_settime/speculative/.gitignore          | 1 +
 testcases/open_posix_testsuite/functional/mqueues/.gitignore             | 1 +
 testcases/open_posix_testsuite/functional/semaphores/.gitignore          | 1 +
 testcases/open_posix_testsuite/functional/threads/condvar/.gitignore     | 1 +
 testcases/open_posix_testsuite/functional/threads/pi_test/.gitignore     | 1 +
 testcases/open_posix_testsuite/functional/threads/schedule/.gitignore    | 1 +
 testcases/open_posix_testsuite/stress/mqueues/.gitignore                 | 1 +
 testcases/open_posix_testsuite/stress/signals/.gitignore                 | 1 +
 225 files changed, 225 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/behavior/timers/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/aio_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/errno_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/mqueue_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/pthread_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/sched_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/signal_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/time_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/definitions/unistd_h/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_error/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_read/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_return/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_write/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/asctime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock_settime/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/ctime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/fork/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/fsync/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/getpid/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/gmtime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/kill/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/killpg/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/lio_listio/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/localtime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mktime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_close/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_open/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_open/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_send/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setclock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_create/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_getspecific/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_join/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprotocol/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_once/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_self/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_setcancelstate/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_setcanceltype/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedprio/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_testcancel/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/raise/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_yield/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_close/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_open/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_post/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sem_wait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigaction/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigaddset/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigdelset/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigemptyset/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigfillset/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sighold/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigignore/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigismember/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/signal/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigpause/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigpending/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigqueue/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigrelse/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigset/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigwait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/strftime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/time/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/.gitignore
 create mode 100644 testcases/open_posix_testsuite/functional/mqueues/.gitignore
 create mode 100644 testcases/open_posix_testsuite/functional/semaphores/.gitignore
 create mode 100644 testcases/open_posix_testsuite/functional/threads/condvar/.gitignore
 create mode 100644 testcases/open_posix_testsuite/functional/threads/pi_test/.gitignore
 create mode 100644 testcases/open_posix_testsuite/functional/threads/schedule/.gitignore
 create mode 100644 testcases/open_posix_testsuite/stress/mqueues/.gitignore
 create mode 100644 testcases/open_posix_testsuite/stress/signals/.gitignore

diff --git a/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/.gitignore b/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/behavior/timers/.gitignore b/testcases/open_posix_testsuite/conformance/behavior/timers/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/behavior/timers/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/aio_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/aio_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/aio_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/errno_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/errno_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/errno_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/mqueue_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/mqueue_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/mqueue_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/pthread_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/pthread_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/pthread_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/sched_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/sched_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/sched_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/signal_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/signal_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/signal_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/time_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/time_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/time_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/definitions/unistd_h/.gitignore b/testcases/open_posix_testsuite/conformance/definitions/unistd_h/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/definitions/unistd_h/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/asctime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/asctime/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/asctime/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore
index 4a6df0523..08513b3e8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore
@@ -1 +1,2 @@
 /clock_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore
index 28d40ab7a..df1d28f7b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore
@@ -1,2 +1,3 @@
 /clock_getres_2-1.sh
 /clock_getres_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore
index 43f7ffd93..37ea870eb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore
@@ -1 +1,2 @@
 /clock_gettime_6-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore
index 288d394cd..d280a43b7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore
@@ -4,3 +4,4 @@
 /clock_nanosleep_5-1.sh
 /clock_nanosleep_6-1.sh
 /clock_nanosleep_8-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore
index 3979d474c..06c2a5e4c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore
@@ -2,3 +2,4 @@
 /clock_settime_16-1.sh
 /clock_settime_18-1.sh
 /clock_settime_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/ctime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/ctime/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/ctime/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore
index d51196393..322cf90fe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore
@@ -1 +1,2 @@
 /difftime_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/fork/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fsync/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/fsync/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fsync/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/getpid/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/getpid/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/getpid/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/gmtime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/gmtime/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/gmtime/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/kill/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/killpg/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/killpg/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/killpg/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/localtime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/localtime/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/localtime/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mktime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mktime/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mktime/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore
index c80cefc18..16e3df28d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore
@@ -1,3 +1,4 @@
 /mlock_2-1.sh
 /mlock_4-1.sh
 /mlock_7-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore
index 055812d3c..f40e14aeb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore
@@ -1,3 +1,4 @@
 /mlockall_2-1.sh
 /mlockall_7-1.sh
 /mlockall_9-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore
index 8bcf176a6..2041be03a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore
@@ -1,3 +1,4 @@
 /mmap_16-1.sh
 /mmap_17-1.sh
 /mmap_20-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore
index 60d360923..9e3a976c0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore
@@ -1,3 +1,4 @@
 /mq_getattr_1-1.sh
 /mq_getattr_5-1.sh
 /mq_getattr_6-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore
index 97beef33f..5d662d910 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore
@@ -1,2 +1,3 @@
 /mq_notify_6-1.sh
 /mq_notify_7-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore
index 23b50615d..ee6131c29 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore
@@ -1,2 +1,3 @@
 /mq_receive_4-1.sh
 /mq_receive_9-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore
index f667012e8..b7f75c8a8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore
@@ -1,2 +1,3 @@
 /mq_setattr_3-1.sh
 /mq_setattr_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore
index f42967fc7..c3b49ec9e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore
@@ -1,3 +1,4 @@
 /mq_timedreceive_12-1.sh
 /mq_timedreceive_16-1.sh
 /mq_timedreceive_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore
index 31b0772fa..c7978ff52 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore
@@ -1,2 +1,3 @@
 /mq_unlink_3-1.sh
 /mq_unlink_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore
index da9ead088..e05d70b09 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore
@@ -1,2 +1,3 @@
 /munlock_2-1.sh
 /munlock_9-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore
index 04c5506e9..227b2effc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore
@@ -1 +1,2 @@
 /munlockall_6-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore
index f3c55989a..e7d93f020 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore
@@ -1,2 +1,3 @@
 /munmap_10-1.sh
 /munmap_7-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore
index 09b1d6e5a..277dc7b50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore
@@ -1 +1,2 @@
 /nanosleep_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore
index ca13f8f6d..a7a41e2ca 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore
@@ -1 +1,2 @@
 /pthread_atfork_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_destroy/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_destroy/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore
index 7428995f0..259ab2a0a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_getdetachstate_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore
index 5b2bed528..9368b386a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_getinheritsched_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore
index 4416ddb69..9b86c03f0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_getschedparam_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore
index ccbef321f..27854c201 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore
@@ -1,2 +1,3 @@
 /pthread_attr_getschedpolicy_1-1.sh
 /pthread_attr_getschedpolicy_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore
index 0349bb6fd..e3dac74f7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_getscope_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore
index ceca4252f..cbdeb9cdc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_getstack_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore
index c4544c25c..d57f6ebc4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_getstacksize_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore
index 84add55af..3705a8638 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_setdetachstate_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore
index fa7e08abb..e18ad2750 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_setinheritsched_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore
index a3a947395..c4d5ccd38 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_setschedparam_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore
index 4a7f237c7..72d907a3e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_setschedpolicy_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore
index 4b3819ec4..310fb305f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_setscope_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore
index 2224722f1..f36bd5d55 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore
@@ -1,2 +1,3 @@
 /pthread_attr_setstack_3-1.sh
 /pthread_attr_setstack_5-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore
index 9d0bec773..245a464da 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore
@@ -1 +1,2 @@
 /pthread_attr_setstacksize_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore
index f02c694bb..b383a9eea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore
@@ -1 +1,2 @@
 /pthread_barrier_destroy_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore
index 16de50bdc..cab6f0ed8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore
@@ -1 +1,2 @@
 /pthread_barrier_init_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore
index 0d08226c5..cecfc03b2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore
@@ -1,2 +1,3 @@
 /pthread_barrier_wait_4-1.sh
 /pthread_barrier_wait_5-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore
index 1f4b9dad8..cb056f796 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore
@@ -1 +1,2 @@
 /pthread_barrierattr_destroy_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore
index ce5b8a4ba..780cb4e71 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore
@@ -1 +1,2 @@
 /pthread_barrierattr_getpshared_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore
index 831c1c829..bb1abbeef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore
@@ -1 +1,2 @@
 /pthread_barrierattr_init_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore
index 8c0de4add..2a495ca22 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore
@@ -1 +1,2 @@
 /pthread_barrierattr_setpshared_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore
index 57a85c696..b5c02413b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore
@@ -1 +1,2 @@
 /pthread_cleanup_pop_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore
index 2d1610e76..a547ec97c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore
@@ -1 +1,2 @@
 /pthread_cleanup_push_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore
index 0012d6994..24d2aab9d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore
@@ -1 +1,2 @@
 /pthread_condattr_getclock_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore
index 3a8f85180..b68829d30 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore
@@ -1 +1,2 @@
 /pthread_condattr_getpshared_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_init/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_init/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setclock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setclock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setclock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setpshared/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_setpshared/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore
index b17b4b7c7..b5a01f7bc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore
@@ -1 +1,2 @@
 /pthread_getcpuclockid_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getspecific/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getspecific/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getspecific/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore
index 06e2a9923..968c8e644 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore
@@ -1 +1,2 @@
 /pthread_key_delete_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_destroy/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore
index af52c0529..773c27ff1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore
@@ -1 +1,2 @@
 /pthread_mutexattr_getprioceiling_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprotocol/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprotocol/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprotocol/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore
index 135b19902..629bfe1ca 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore
@@ -1 +1,2 @@
 /pthread_mutexattr_getpshared_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_gettype/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_init/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_init/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore
index 843a650c7..407081235 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore
@@ -1 +1,2 @@
 /pthread_mutexattr_setprioceiling_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore
index e35313f23..2731331e5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore
@@ -1 +1,2 @@
 /pthread_mutexattr_setprotocol_2-2.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore
index d1d506c40..9252b0330 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore
@@ -1 +1,2 @@
 /pthread_mutexattr_settype_6-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore
index fdc1d6601..fd9674f74 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlock_destroy_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore
index b9230fd71..0a30ac678 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlock_init_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore
index 2d0b23fb0..8b8f001c9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlock_rdlock_6-2.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore
index 81636866f..2c75baaf6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore
@@ -1,2 +1,3 @@
 /pthread_rwlock_timedrdlock_4-1.sh
 /pthread_rwlock_timedrdlock_7-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore
index d1cf120ac..b1009ee4d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore
@@ -1,2 +1,3 @@
 /pthread_rwlock_timedwrlock_4-1.sh
 /pthread_rwlock_timedwrlock_7-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore
index ac0bdbb81..2c535c517 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore
@@ -1,2 +1,3 @@
 /pthread_rwlock_tryrdlock_2-1.sh
 /pthread_rwlock_tryrdlock_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore
index 19982b8e1..2f62d21e1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlock_trywrlock_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore
index f6ca54e04..629fddad4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlockattr_destroy_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore
index 9d8fce513..0008df0cb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlockattr_getpshared_5-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore
index 5a82d49fe..67c77ca56 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlockattr_init_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore
index 001f0061e..b91dd6c8a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore
@@ -1 +1,2 @@
 /pthread_rwlockattr_setpshared_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_self/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_self/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_self/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setcancelstate/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setcancelstate/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setcancelstate/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setcanceltype/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setcanceltype/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setcanceltype/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedprio/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedprio/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedprio/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore
index cc109b05b..c0bb9f331 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore
@@ -1 +1,2 @@
 /pthread_setspecific_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore
index f0c7e6446..f1f0b821c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore
@@ -1 +1,2 @@
 /pthread_spin_destroy_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore
index 0baadaf68..243cfd658 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore
@@ -1 +1,2 @@
 /pthread_spin_init_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore
index c3915c772..7761fa885 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore
@@ -1 +1,2 @@
 /pthread_spin_lock_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore
index f1d783b9e..cc1390742 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore
@@ -1,2 +1,3 @@
 /pthread_spin_trylock_2-1.sh
 /pthread_spin_trylock_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore
index 12cb77db7..214ef9260 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore
@@ -1 +1,2 @@
 /pthread_spin_unlock_2-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_testcancel/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_testcancel/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_testcancel/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/raise/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/raise/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/raise/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore
index d1c5d4fbc..159b1416c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore
@@ -1 +1,2 @@
 /sched_get_priority_max_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore
index d273571b6..18800aeee 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore
@@ -1 +1,2 @@
 /sched_get_priority_min_3-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore
index fe18d40e1..bc54c4cec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore
@@ -1 +1,2 @@
 /sched_getparam_5-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore
index ef46b934f..c31a72799 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore
@@ -1 +1,2 @@
 /sched_getscheduler_6-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore
index 53e0fc194..974f6d5a9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore
@@ -1 +1,2 @@
 /sched_rr_get_interval_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore
index 66e6c6843..1a1447a5b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore
@@ -1,3 +1,4 @@
 /sched_setparam_11-1.sh
 /sched_setparam_24-1.sh
 /sched_setparam_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore
index ccff04604..45877d68e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore
@@ -1,3 +1,4 @@
 /sched_setscheduler_18-1.sh
 /sched_setscheduler_3-1.sh
 /sched_setscheduler_8-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_close/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_close/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_close/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_init/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_init/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore
index fd533e817..f11fc37c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore
@@ -4,3 +4,4 @@
 /shm_open_31-1.sh
 /shm_open_35-1.sh
 /shm_open_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore
index f54142f40..d1e626372 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore
@@ -1,2 +1,3 @@
 /shm_unlink_4-1.sh
 /shm_unlink_7-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaddset/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigaddset/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaddset/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigdelset/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigdelset/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigdelset/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigemptyset/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigemptyset/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigemptyset/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigfillset/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigfillset/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigfillset/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sighold/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sighold/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sighold/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigignore/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigignore/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigignore/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigismember/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigismember/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigismember/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/signal/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigpause/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigpause/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigpause/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigpending/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigpending/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigpending/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigset/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strftime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/strftime/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strftime/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/time/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/time/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/time/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore
index 0fe9bfdc6..ea91a47ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore
@@ -2,3 +2,4 @@
 /timer_create_14-1.sh
 /timer_create_4-1.sh
 /timer_create_6-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore
index cc167df27..fa3375bd5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore
@@ -1,3 +1,4 @@
 /timer_delete_2-1.sh
 /timer_delete_3-1.sh
 /timer_delete_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore
index b834ea0f6..3930017fa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore
@@ -1,2 +1,3 @@
 /timer_getoverrun_4-1.sh
 /timer_getoverrun_5-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore
index 294f1e82f..f714966ed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore
@@ -1,2 +1,3 @@
 /timer_gettime_4-1.sh
 /timer_gettime_5-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore
index 0c68edb63..c3f9ba5ce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore
@@ -1,3 +1,4 @@
 /timer_settime_10-1.sh
 /timer_settime_11-1.sh
 /timer_settime_4-1.sh
+/run.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/functional/mqueues/.gitignore b/testcases/open_posix_testsuite/functional/mqueues/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/mqueues/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/functional/semaphores/.gitignore b/testcases/open_posix_testsuite/functional/semaphores/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/semaphores/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/.gitignore b/testcases/open_posix_testsuite/functional/threads/condvar/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/.gitignore b/testcases/open_posix_testsuite/functional/threads/pi_test/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/.gitignore b/testcases/open_posix_testsuite/functional/threads/schedule/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/stress/mqueues/.gitignore b/testcases/open_posix_testsuite/stress/mqueues/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/stress/mqueues/.gitignore
@@ -0,0 +1 @@
+/run.sh
diff --git a/testcases/open_posix_testsuite/stress/signals/.gitignore b/testcases/open_posix_testsuite/stress/signals/.gitignore
new file mode 100644
index 000000000..628946d84
--- /dev/null
+++ b/testcases/open_posix_testsuite/stress/signals/.gitignore
@@ -0,0 +1 @@
+/run.sh
-- 
2.12.0

