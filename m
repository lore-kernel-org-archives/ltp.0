From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Mar 2017 17:51:05 +0100
Subject: [LTP] [PATCH 1/1] gitignore: add gitignore for posix and realtime
	test suites
Message-ID: <20170308165105.3981-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These are needed, when configured with non-default
--with-open-posix-testsuite --with-realtime-testsuite switches.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../open_posix_testsuite/conformance/interfaces/clock/.gitignore  | 1 +
 .../conformance/interfaces/clock_getres/.gitignore                | 2 ++
 .../conformance/interfaces/clock_gettime/.gitignore               | 1 +
 .../conformance/interfaces/clock_nanosleep/.gitignore             | 6 ++++++
 .../conformance/interfaces/clock_settime/.gitignore               | 4 ++++
 .../conformance/interfaces/difftime/.gitignore                    | 1 +
 .../open_posix_testsuite/conformance/interfaces/mlock/.gitignore  | 3 +++
 .../conformance/interfaces/mlockall/.gitignore                    | 3 +++
 .../open_posix_testsuite/conformance/interfaces/mmap/.gitignore   | 3 +++
 .../conformance/interfaces/mq_getattr/.gitignore                  | 3 +++
 .../conformance/interfaces/mq_notify/.gitignore                   | 2 ++
 .../conformance/interfaces/mq_receive/.gitignore                  | 2 ++
 .../conformance/interfaces/mq_setattr/.gitignore                  | 2 ++
 .../conformance/interfaces/mq_timedreceive/.gitignore             | 3 +++
 .../conformance/interfaces/mq_unlink/.gitignore                   | 2 ++
 .../conformance/interfaces/munlock/.gitignore                     | 2 ++
 .../conformance/interfaces/munlockall/.gitignore                  | 1 +
 .../open_posix_testsuite/conformance/interfaces/munmap/.gitignore | 2 ++
 .../conformance/interfaces/nanosleep/.gitignore                   | 1 +
 .../conformance/interfaces/pthread_atfork/.gitignore              | 1 +
 .../conformance/interfaces/pthread_attr_getdetachstate/.gitignore | 1 +
 .../interfaces/pthread_attr_getinheritsched/.gitignore            | 1 +
 .../conformance/interfaces/pthread_attr_getschedparam/.gitignore  | 1 +
 .../conformance/interfaces/pthread_attr_getschedpolicy/.gitignore | 2 ++
 .../conformance/interfaces/pthread_attr_getscope/.gitignore       | 1 +
 .../conformance/interfaces/pthread_attr_getstack/.gitignore       | 1 +
 .../conformance/interfaces/pthread_attr_getstacksize/.gitignore   | 1 +
 .../conformance/interfaces/pthread_attr_setdetachstate/.gitignore | 1 +
 .../interfaces/pthread_attr_setinheritsched/.gitignore            | 1 +
 .../conformance/interfaces/pthread_attr_setschedparam/.gitignore  | 1 +
 .../conformance/interfaces/pthread_attr_setschedpolicy/.gitignore | 1 +
 .../conformance/interfaces/pthread_attr_setscope/.gitignore       | 1 +
 .../conformance/interfaces/pthread_attr_setstack/.gitignore       | 2 ++
 .../conformance/interfaces/pthread_attr_setstacksize/.gitignore   | 1 +
 .../conformance/interfaces/pthread_barrier_destroy/.gitignore     | 1 +
 .../conformance/interfaces/pthread_barrier_init/.gitignore        | 1 +
 .../conformance/interfaces/pthread_barrier_wait/.gitignore        | 2 ++
 .../conformance/interfaces/pthread_barrierattr_destroy/.gitignore | 1 +
 .../interfaces/pthread_barrierattr_getpshared/.gitignore          | 1 +
 .../conformance/interfaces/pthread_barrierattr_init/.gitignore    | 1 +
 .../interfaces/pthread_barrierattr_setpshared/.gitignore          | 1 +
 .../conformance/interfaces/pthread_cleanup_pop/.gitignore         | 1 +
 .../conformance/interfaces/pthread_cleanup_push/.gitignore        | 1 +
 .../conformance/interfaces/pthread_condattr_getclock/.gitignore   | 1 +
 .../conformance/interfaces/pthread_condattr_getpshared/.gitignore | 1 +
 .../conformance/interfaces/pthread_getcpuclockid/.gitignore       | 1 +
 .../conformance/interfaces/pthread_key_delete/.gitignore          | 1 +
 .../interfaces/pthread_mutexattr_getprioceiling/.gitignore        | 1 +
 .../interfaces/pthread_mutexattr_getpshared/.gitignore            | 1 +
 .../interfaces/pthread_mutexattr_setprioceiling/.gitignore        | 1 +
 .../interfaces/pthread_mutexattr_setprotocol/.gitignore           | 1 +
 .../conformance/interfaces/pthread_mutexattr_settype/.gitignore   | 1 +
 .../conformance/interfaces/pthread_rwlock_destroy/.gitignore      | 1 +
 .../conformance/interfaces/pthread_rwlock_init/.gitignore         | 1 +
 .../conformance/interfaces/pthread_rwlock_rdlock/.gitignore       | 1 +
 .../conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore  | 2 ++
 .../conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore  | 2 ++
 .../conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore    | 2 ++
 .../conformance/interfaces/pthread_rwlock_trywrlock/.gitignore    | 1 +
 .../conformance/interfaces/pthread_rwlockattr_destroy/.gitignore  | 1 +
 .../interfaces/pthread_rwlockattr_getpshared/.gitignore           | 1 +
 .../conformance/interfaces/pthread_rwlockattr_init/.gitignore     | 1 +
 .../interfaces/pthread_rwlockattr_setpshared/.gitignore           | 1 +
 .../conformance/interfaces/pthread_setspecific/.gitignore         | 1 +
 .../conformance/interfaces/pthread_spin_destroy/.gitignore        | 1 +
 .../conformance/interfaces/pthread_spin_init/.gitignore           | 1 +
 .../conformance/interfaces/pthread_spin_lock/.gitignore           | 1 +
 .../conformance/interfaces/pthread_spin_trylock/.gitignore        | 2 ++
 .../conformance/interfaces/pthread_spin_unlock/.gitignore         | 1 +
 .../conformance/interfaces/sched_get_priority_max/.gitignore      | 1 +
 .../conformance/interfaces/sched_get_priority_min/.gitignore      | 1 +
 .../conformance/interfaces/sched_getparam/.gitignore              | 1 +
 .../conformance/interfaces/sched_getscheduler/.gitignore          | 1 +
 .../conformance/interfaces/sched_rr_get_interval/.gitignore       | 1 +
 .../conformance/interfaces/sched_setparam/.gitignore              | 3 +++
 .../conformance/interfaces/sched_setscheduler/.gitignore          | 3 +++
 .../conformance/interfaces/shm_open/.gitignore                    | 6 ++++++
 .../conformance/interfaces/shm_unlink/.gitignore                  | 2 ++
 .../conformance/interfaces/timer_create/.gitignore                | 4 ++++
 .../conformance/interfaces/timer_delete/.gitignore                | 3 +++
 .../conformance/interfaces/timer_getoverrun/.gitignore            | 2 ++
 .../conformance/interfaces/timer_gettime/.gitignore               | 2 ++
 .../conformance/interfaces/timer_settime/.gitignore               | 3 +++
 testcases/realtime/.gitignore                                     | 2 ++
 testcases/realtime/func/async_handler/.gitignore                  | 3 +++
 testcases/realtime/func/gtod_latency/.gitignore                   | 2 ++
 testcases/realtime/func/hrtimer-prio/.gitignore                   | 1 +
 testcases/realtime/func/matrix_mult/.gitignore                    | 1 +
 testcases/realtime/func/measurement/.gitignore                    | 2 ++
 testcases/realtime/func/periodic_cpu_load/.gitignore              | 2 ++
 testcases/realtime/func/pi-tests/.gitignore                       | 8 ++++++++
 testcases/realtime/func/pi_perf/.gitignore                        | 1 +
 testcases/realtime/func/prio-preempt/.gitignore                   | 1 +
 testcases/realtime/func/prio-wake/.gitignore                      | 1 +
 testcases/realtime/func/pthread_kill_latency/.gitignore           | 1 +
 testcases/realtime/func/rt-migrate/.gitignore                     | 1 +
 testcases/realtime/func/sched_football/.gitignore                 | 1 +
 testcases/realtime/func/sched_jitter/.gitignore                   | 1 +
 testcases/realtime/func/sched_latency/.gitignore                  | 1 +
 testcases/realtime/func/thread_clock/.gitignore                   | 1 +
 testcases/realtime/include/.gitignore                             | 2 ++
 testcases/realtime/m4/.gitignore                                  | 1 +
 testcases/realtime/perf/latency/.gitignore                        | 2 ++
 testcases/realtime/stress/pi-tests/.gitignore                     | 2 ++
 104 files changed, 171 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore
 create mode 100644 testcases/realtime/func/async_handler/.gitignore
 create mode 100644 testcases/realtime/func/gtod_latency/.gitignore
 create mode 100644 testcases/realtime/func/hrtimer-prio/.gitignore
 create mode 100644 testcases/realtime/func/matrix_mult/.gitignore
 create mode 100644 testcases/realtime/func/measurement/.gitignore
 create mode 100644 testcases/realtime/func/periodic_cpu_load/.gitignore
 create mode 100644 testcases/realtime/func/pi-tests/.gitignore
 create mode 100644 testcases/realtime/func/pi_perf/.gitignore
 create mode 100644 testcases/realtime/func/prio-preempt/.gitignore
 create mode 100644 testcases/realtime/func/prio-wake/.gitignore
 create mode 100644 testcases/realtime/func/pthread_kill_latency/.gitignore
 create mode 100644 testcases/realtime/func/rt-migrate/.gitignore
 create mode 100644 testcases/realtime/func/sched_football/.gitignore
 create mode 100644 testcases/realtime/func/sched_jitter/.gitignore
 create mode 100644 testcases/realtime/func/sched_latency/.gitignore
 create mode 100644 testcases/realtime/func/thread_clock/.gitignore
 create mode 100644 testcases/realtime/include/.gitignore
 create mode 100644 testcases/realtime/m4/.gitignore
 create mode 100644 testcases/realtime/perf/latency/.gitignore
 create mode 100644 testcases/realtime/stress/pi-tests/.gitignore

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore
new file mode 100644
index 000000000..4a6df0523
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock/.gitignore
@@ -0,0 +1 @@
+/clock_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore
new file mode 100644
index 000000000..28d40ab7a
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/.gitignore
@@ -0,0 +1,2 @@
+/clock_getres_2-1.sh
+/clock_getres_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore
new file mode 100644
index 000000000..43f7ffd93
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/.gitignore
@@ -0,0 +1 @@
+/clock_gettime_6-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore
new file mode 100644
index 000000000..288d394cd
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/.gitignore
@@ -0,0 +1,6 @@
+/clock_nanosleep_1-2.sh
+/clock_nanosleep_15-1.sh
+/clock_nanosleep_4-1.sh
+/clock_nanosleep_5-1.sh
+/clock_nanosleep_6-1.sh
+/clock_nanosleep_8-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore
new file mode 100644
index 000000000..3979d474c
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/.gitignore
@@ -0,0 +1,4 @@
+/clock_settime_15-1.sh
+/clock_settime_16-1.sh
+/clock_settime_18-1.sh
+/clock_settime_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore
new file mode 100644
index 000000000..d51196393
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/difftime/.gitignore
@@ -0,0 +1 @@
+/difftime_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore
new file mode 100644
index 000000000..c80cefc18
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/.gitignore
@@ -0,0 +1,3 @@
+/mlock_2-1.sh
+/mlock_4-1.sh
+/mlock_7-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore
new file mode 100644
index 000000000..055812d3c
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/.gitignore
@@ -0,0 +1,3 @@
+/mlockall_2-1.sh
+/mlockall_7-1.sh
+/mlockall_9-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore
new file mode 100644
index 000000000..8bcf176a6
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/.gitignore
@@ -0,0 +1,3 @@
+/mmap_16-1.sh
+/mmap_17-1.sh
+/mmap_20-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore
new file mode 100644
index 000000000..60d360923
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_getattr/.gitignore
@@ -0,0 +1,3 @@
+/mq_getattr_1-1.sh
+/mq_getattr_5-1.sh
+/mq_getattr_6-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore
new file mode 100644
index 000000000..97beef33f
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_notify/.gitignore
@@ -0,0 +1,2 @@
+/mq_notify_6-1.sh
+/mq_notify_7-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore
new file mode 100644
index 000000000..23b50615d
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/.gitignore
@@ -0,0 +1,2 @@
+/mq_receive_4-1.sh
+/mq_receive_9-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore
new file mode 100644
index 000000000..f667012e8
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_setattr/.gitignore
@@ -0,0 +1,2 @@
+/mq_setattr_3-1.sh
+/mq_setattr_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore
new file mode 100644
index 000000000..f42967fc7
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/.gitignore
@@ -0,0 +1,3 @@
+/mq_timedreceive_12-1.sh
+/mq_timedreceive_16-1.sh
+/mq_timedreceive_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore
new file mode 100644
index 000000000..31b0772fa
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/.gitignore
@@ -0,0 +1,2 @@
+/mq_unlink_3-1.sh
+/mq_unlink_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore
new file mode 100644
index 000000000..da9ead088
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlock/.gitignore
@@ -0,0 +1,2 @@
+/munlock_2-1.sh
+/munlock_9-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore
new file mode 100644
index 000000000..04c5506e9
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlockall/.gitignore
@@ -0,0 +1 @@
+/munlockall_6-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore
new file mode 100644
index 000000000..f3c55989a
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/.gitignore
@@ -0,0 +1,2 @@
+/munmap_10-1.sh
+/munmap_7-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore
new file mode 100644
index 000000000..09b1d6e5a
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/.gitignore
@@ -0,0 +1 @@
+/nanosleep_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore
new file mode 100644
index 000000000..ca13f8f6d
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/.gitignore
@@ -0,0 +1 @@
+/pthread_atfork_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore
new file mode 100644
index 000000000..7428995f0
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getdetachstate/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_getdetachstate_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore
new file mode 100644
index 000000000..5b2bed528
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getinheritsched/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_getinheritsched_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore
new file mode 100644
index 000000000..4416ddb69
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedparam/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_getschedparam_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore
new file mode 100644
index 000000000..ccbef321f
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/.gitignore
@@ -0,0 +1,2 @@
+/pthread_attr_getschedpolicy_1-1.sh
+/pthread_attr_getschedpolicy_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore
new file mode 100644
index 000000000..0349bb6fd
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getscope/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_getscope_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore
new file mode 100644
index 000000000..ceca4252f
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstack/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_getstack_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore
new file mode 100644
index 000000000..c4544c25c
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getstacksize/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_getstacksize_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore
new file mode 100644
index 000000000..84add55af
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_setdetachstate_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore
new file mode 100644
index 000000000..fa7e08abb
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_setinheritsched_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore
new file mode 100644
index 000000000..a3a947395
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_setschedparam_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore
new file mode 100644
index 000000000..4a7f237c7
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_setschedpolicy_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore
new file mode 100644
index 000000000..4b3819ec4
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setscope/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_setscope_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore
new file mode 100644
index 000000000..2224722f1
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstack/.gitignore
@@ -0,0 +1,2 @@
+/pthread_attr_setstack_3-1.sh
+/pthread_attr_setstack_5-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore
new file mode 100644
index 000000000..9d0bec773
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/.gitignore
@@ -0,0 +1 @@
+/pthread_attr_setstacksize_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore
new file mode 100644
index 000000000..f02c694bb
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/.gitignore
@@ -0,0 +1 @@
+/pthread_barrier_destroy_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore
new file mode 100644
index 000000000..16de50bdc
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/.gitignore
@@ -0,0 +1 @@
+/pthread_barrier_init_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore
new file mode 100644
index 000000000..0d08226c5
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/.gitignore
@@ -0,0 +1,2 @@
+/pthread_barrier_wait_4-1.sh
+/pthread_barrier_wait_5-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore
new file mode 100644
index 000000000..1f4b9dad8
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_destroy/.gitignore
@@ -0,0 +1 @@
+/pthread_barrierattr_destroy_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore
new file mode 100644
index 000000000..ce5b8a4ba
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/.gitignore
@@ -0,0 +1 @@
+/pthread_barrierattr_getpshared_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore
new file mode 100644
index 000000000..831c1c829
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/.gitignore
@@ -0,0 +1 @@
+/pthread_barrierattr_init_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore
new file mode 100644
index 000000000..8c0de4add
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_setpshared/.gitignore
@@ -0,0 +1 @@
+/pthread_barrierattr_setpshared_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore
new file mode 100644
index 000000000..57a85c696
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/.gitignore
@@ -0,0 +1 @@
+/pthread_cleanup_pop_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore
new file mode 100644
index 000000000..2d1610e76
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_push/.gitignore
@@ -0,0 +1 @@
+/pthread_cleanup_push_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore
new file mode 100644
index 000000000..0012d6994
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getclock/.gitignore
@@ -0,0 +1 @@
+/pthread_condattr_getclock_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore
new file mode 100644
index 000000000..3a8f85180
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_getpshared/.gitignore
@@ -0,0 +1 @@
+/pthread_condattr_getpshared_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore
new file mode 100644
index 000000000..b17b4b7c7
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getcpuclockid/.gitignore
@@ -0,0 +1 @@
+/pthread_getcpuclockid_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore
new file mode 100644
index 000000000..06e2a9923
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/.gitignore
@@ -0,0 +1 @@
+/pthread_key_delete_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore
new file mode 100644
index 000000000..af52c0529
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getprioceiling/.gitignore
@@ -0,0 +1 @@
+/pthread_mutexattr_getprioceiling_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore
new file mode 100644
index 000000000..135b19902
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_getpshared/.gitignore
@@ -0,0 +1 @@
+/pthread_mutexattr_getpshared_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore
new file mode 100644
index 000000000..843a650c7
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprioceiling/.gitignore
@@ -0,0 +1 @@
+/pthread_mutexattr_setprioceiling_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore
new file mode 100644
index 000000000..e35313f23
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setprotocol/.gitignore
@@ -0,0 +1 @@
+/pthread_mutexattr_setprotocol_2-2.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore
new file mode 100644
index 000000000..d1d506c40
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/.gitignore
@@ -0,0 +1 @@
+/pthread_mutexattr_settype_6-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore
new file mode 100644
index 000000000..fdc1d6601
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_destroy/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlock_destroy_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore
new file mode 100644
index 000000000..b9230fd71
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlock_init_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore
new file mode 100644
index 000000000..2d0b23fb0
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlock_rdlock_6-2.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore
new file mode 100644
index 000000000..81636866f
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/.gitignore
@@ -0,0 +1,2 @@
+/pthread_rwlock_timedrdlock_4-1.sh
+/pthread_rwlock_timedrdlock_7-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore
new file mode 100644
index 000000000..d1cf120ac
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/.gitignore
@@ -0,0 +1,2 @@
+/pthread_rwlock_timedwrlock_4-1.sh
+/pthread_rwlock_timedwrlock_7-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore
new file mode 100644
index 000000000..ac0bdbb81
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/.gitignore
@@ -0,0 +1,2 @@
+/pthread_rwlock_tryrdlock_2-1.sh
+/pthread_rwlock_tryrdlock_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore
new file mode 100644
index 000000000..19982b8e1
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlock_trywrlock_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore
new file mode 100644
index 000000000..f6ca54e04
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_destroy/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlockattr_destroy_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore
new file mode 100644
index 000000000..9d8fce513
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlockattr_getpshared_5-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore
new file mode 100644
index 000000000..5a82d49fe
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_init/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlockattr_init_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore
new file mode 100644
index 000000000..001f0061e
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/.gitignore
@@ -0,0 +1 @@
+/pthread_rwlockattr_setpshared_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore
new file mode 100644
index 000000000..cc109b05b
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setspecific/.gitignore
@@ -0,0 +1 @@
+/pthread_setspecific_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore
new file mode 100644
index 000000000..f0c7e6446
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/.gitignore
@@ -0,0 +1 @@
+/pthread_spin_destroy_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore
new file mode 100644
index 000000000..0baadaf68
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/.gitignore
@@ -0,0 +1 @@
+/pthread_spin_init_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore
new file mode 100644
index 000000000..c3915c772
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/.gitignore
@@ -0,0 +1 @@
+/pthread_spin_lock_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore
new file mode 100644
index 000000000..f1d783b9e
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_trylock/.gitignore
@@ -0,0 +1,2 @@
+/pthread_spin_trylock_2-1.sh
+/pthread_spin_trylock_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore
new file mode 100644
index 000000000..12cb77db7
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/.gitignore
@@ -0,0 +1 @@
+/pthread_spin_unlock_2-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore
new file mode 100644
index 000000000..d1c5d4fbc
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_max/.gitignore
@@ -0,0 +1 @@
+/sched_get_priority_max_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore
new file mode 100644
index 000000000..d273571b6
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_get_priority_min/.gitignore
@@ -0,0 +1 @@
+/sched_get_priority_min_3-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore
new file mode 100644
index 000000000..fe18d40e1
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/.gitignore
@@ -0,0 +1 @@
+/sched_getparam_5-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore
new file mode 100644
index 000000000..ef46b934f
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/.gitignore
@@ -0,0 +1 @@
+/sched_getscheduler_6-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore
new file mode 100644
index 000000000..53e0fc194
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/.gitignore
@@ -0,0 +1 @@
+/sched_rr_get_interval_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore
new file mode 100644
index 000000000..66e6c6843
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/.gitignore
@@ -0,0 +1,3 @@
+/sched_setparam_11-1.sh
+/sched_setparam_24-1.sh
+/sched_setparam_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore
new file mode 100644
index 000000000..ccff04604
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/.gitignore
@@ -0,0 +1,3 @@
+/sched_setscheduler_18-1.sh
+/sched_setscheduler_3-1.sh
+/sched_setscheduler_8-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore
new file mode 100644
index 000000000..fd533e817
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/.gitignore
@@ -0,0 +1,6 @@
+/shm_open_13-2.sh
+/shm_open_14-1.sh
+/shm_open_30-1.sh
+/shm_open_31-1.sh
+/shm_open_35-1.sh
+/shm_open_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore
new file mode 100644
index 000000000..f54142f40
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/.gitignore
@@ -0,0 +1,2 @@
+/shm_unlink_4-1.sh
+/shm_unlink_7-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore
new file mode 100644
index 000000000..0fe9bfdc6
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/.gitignore
@@ -0,0 +1,4 @@
+/timer_create_13-1.sh
+/timer_create_14-1.sh
+/timer_create_4-1.sh
+/timer_create_6-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore
new file mode 100644
index 000000000..cc167df27
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/.gitignore
@@ -0,0 +1,3 @@
+/timer_delete_2-1.sh
+/timer_delete_3-1.sh
+/timer_delete_4-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore
new file mode 100644
index 000000000..b834ea0f6
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/.gitignore
@@ -0,0 +1,2 @@
+/timer_getoverrun_4-1.sh
+/timer_getoverrun_5-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore
new file mode 100644
index 000000000..294f1e82f
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/.gitignore
@@ -0,0 +1,2 @@
+/timer_gettime_4-1.sh
+/timer_gettime_5-1.sh
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore
new file mode 100644
index 000000000..0c68edb63
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/.gitignore
@@ -0,0 +1,3 @@
+/timer_settime_10-1.sh
+/timer_settime_11-1.sh
+/timer_settime_4-1.sh
diff --git a/testcases/realtime/.gitignore b/testcases/realtime/.gitignore
index 376dbfcfd..05b9d5539 100644
--- a/testcases/realtime/.gitignore
+++ b/testcases/realtime/.gitignore
@@ -9,3 +9,5 @@
 /include/realtime_config.h.in
 
 /m4/Makefile.in
+/config.log
+/config.status
diff --git a/testcases/realtime/func/async_handler/.gitignore b/testcases/realtime/func/async_handler/.gitignore
new file mode 100644
index 000000000..22b3bad80
--- /dev/null
+++ b/testcases/realtime/func/async_handler/.gitignore
@@ -0,0 +1,3 @@
+/async_handler
+/async_handler_jk
+/async_handler_tsc
diff --git a/testcases/realtime/func/gtod_latency/.gitignore b/testcases/realtime/func/gtod_latency/.gitignore
new file mode 100644
index 000000000..17615e3f3
--- /dev/null
+++ b/testcases/realtime/func/gtod_latency/.gitignore
@@ -0,0 +1,2 @@
+/gtod_infinite
+/gtod_latency
diff --git a/testcases/realtime/func/hrtimer-prio/.gitignore b/testcases/realtime/func/hrtimer-prio/.gitignore
new file mode 100644
index 000000000..a26ef13d3
--- /dev/null
+++ b/testcases/realtime/func/hrtimer-prio/.gitignore
@@ -0,0 +1 @@
+/hrtimer-prio
diff --git a/testcases/realtime/func/matrix_mult/.gitignore b/testcases/realtime/func/matrix_mult/.gitignore
new file mode 100644
index 000000000..0bff0a55b
--- /dev/null
+++ b/testcases/realtime/func/matrix_mult/.gitignore
@@ -0,0 +1 @@
+/matrix_mult
diff --git a/testcases/realtime/func/measurement/.gitignore b/testcases/realtime/func/measurement/.gitignore
new file mode 100644
index 000000000..26c7cafd5
--- /dev/null
+++ b/testcases/realtime/func/measurement/.gitignore
@@ -0,0 +1,2 @@
+/preempt_timing
+/rdtsc-latency
diff --git a/testcases/realtime/func/periodic_cpu_load/.gitignore b/testcases/realtime/func/periodic_cpu_load/.gitignore
new file mode 100644
index 000000000..221d453ac
--- /dev/null
+++ b/testcases/realtime/func/periodic_cpu_load/.gitignore
@@ -0,0 +1,2 @@
+/periodic_cpu_load
+/periodic_cpu_load_single
diff --git a/testcases/realtime/func/pi-tests/.gitignore b/testcases/realtime/func/pi-tests/.gitignore
new file mode 100644
index 000000000..ee1935419
--- /dev/null
+++ b/testcases/realtime/func/pi-tests/.gitignore
@@ -0,0 +1,8 @@
+/sbrk_mutex
+/testpi-0
+/testpi-1
+/testpi-2
+/testpi-4
+/testpi-5
+/testpi-6
+/testpi-7
diff --git a/testcases/realtime/func/pi_perf/.gitignore b/testcases/realtime/func/pi_perf/.gitignore
new file mode 100644
index 000000000..2d30ac1c1
--- /dev/null
+++ b/testcases/realtime/func/pi_perf/.gitignore
@@ -0,0 +1 @@
+/pi_perf
diff --git a/testcases/realtime/func/prio-preempt/.gitignore b/testcases/realtime/func/prio-preempt/.gitignore
new file mode 100644
index 000000000..5ae49c94b
--- /dev/null
+++ b/testcases/realtime/func/prio-preempt/.gitignore
@@ -0,0 +1 @@
+/prio-preempt
diff --git a/testcases/realtime/func/prio-wake/.gitignore b/testcases/realtime/func/prio-wake/.gitignore
new file mode 100644
index 000000000..f179a6930
--- /dev/null
+++ b/testcases/realtime/func/prio-wake/.gitignore
@@ -0,0 +1 @@
+/prio-wake
diff --git a/testcases/realtime/func/pthread_kill_latency/.gitignore b/testcases/realtime/func/pthread_kill_latency/.gitignore
new file mode 100644
index 000000000..0b9003234
--- /dev/null
+++ b/testcases/realtime/func/pthread_kill_latency/.gitignore
@@ -0,0 +1 @@
+/pthread_kill_latency
diff --git a/testcases/realtime/func/rt-migrate/.gitignore b/testcases/realtime/func/rt-migrate/.gitignore
new file mode 100644
index 000000000..05fb26744
--- /dev/null
+++ b/testcases/realtime/func/rt-migrate/.gitignore
@@ -0,0 +1 @@
+/rt-migrate
diff --git a/testcases/realtime/func/sched_football/.gitignore b/testcases/realtime/func/sched_football/.gitignore
new file mode 100644
index 000000000..03606ceef
--- /dev/null
+++ b/testcases/realtime/func/sched_football/.gitignore
@@ -0,0 +1 @@
+/sched_football
diff --git a/testcases/realtime/func/sched_jitter/.gitignore b/testcases/realtime/func/sched_jitter/.gitignore
new file mode 100644
index 000000000..cb177b76e
--- /dev/null
+++ b/testcases/realtime/func/sched_jitter/.gitignore
@@ -0,0 +1 @@
+/sched_jitter
diff --git a/testcases/realtime/func/sched_latency/.gitignore b/testcases/realtime/func/sched_latency/.gitignore
new file mode 100644
index 000000000..e4e67a96a
--- /dev/null
+++ b/testcases/realtime/func/sched_latency/.gitignore
@@ -0,0 +1 @@
+/sched_latency
diff --git a/testcases/realtime/func/thread_clock/.gitignore b/testcases/realtime/func/thread_clock/.gitignore
new file mode 100644
index 000000000..76a87f82b
--- /dev/null
+++ b/testcases/realtime/func/thread_clock/.gitignore
@@ -0,0 +1 @@
+/tc-2
diff --git a/testcases/realtime/include/.gitignore b/testcases/realtime/include/.gitignore
new file mode 100644
index 000000000..517b54da6
--- /dev/null
+++ b/testcases/realtime/include/.gitignore
@@ -0,0 +1,2 @@
+/realtime_config.h
+/stamp-h1
diff --git a/testcases/realtime/m4/.gitignore b/testcases/realtime/m4/.gitignore
new file mode 100644
index 000000000..5fc607b9e
--- /dev/null
+++ b/testcases/realtime/m4/.gitignore
@@ -0,0 +1 @@
+/Makefile
diff --git a/testcases/realtime/perf/latency/.gitignore b/testcases/realtime/perf/latency/.gitignore
new file mode 100644
index 000000000..9042047e4
--- /dev/null
+++ b/testcases/realtime/perf/latency/.gitignore
@@ -0,0 +1,2 @@
+/pthread_cond_latency
+/pthread_cond_many
diff --git a/testcases/realtime/stress/pi-tests/.gitignore b/testcases/realtime/stress/pi-tests/.gitignore
new file mode 100644
index 000000000..4cc2e90dd
--- /dev/null
+++ b/testcases/realtime/stress/pi-tests/.gitignore
@@ -0,0 +1,2 @@
+/lookup_pi_state
+/testpi-3
-- 
2.12.0

