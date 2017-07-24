From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 24 Jul 2017 17:38:45 +0200
Subject: [LTP] [RFC PATCH 2/3] Rename linux_syscall_numbers.h to
	lapi/syscalls.h
In-Reply-To: <20170724153846.18840-1-rpalethorpe@suse.com>
References: <20170724153846.18840-1-rpalethorpe@suse.com>
Message-ID: <20170724153846.18840-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 configure.ac                                                      | 3 +--
 doc/style-guide.txt                                               | 2 +-
 include/lapi/.gitignore                                           | 1 +
 include/lapi/fallocate.h                                          | 2 +-
 include/lapi/mkdirat.h                                            | 2 +-
 include/lapi/personality.h                                        | 2 +-
 include/lapi/readlinkat.h                                         | 2 +-
 include/lapi/renameat.h                                           | 2 +-
 include/lapi/sched.h                                              | 2 +-
 include/lapi/splice.h                                             | 2 +-
 include/lapi/syscalls/regen.sh                                    | 8 ++++----
 include/lapi/tee.h                                                | 2 +-
 include/lapi/timerfd.h                                            | 2 +-
 include/lapi/vmsplice.h                                           | 2 +-
 testcases/cve/cve-2016-10044.c                                    | 2 +-
 testcases/cve/cve-2016-7117.c                                     | 2 +-
 testcases/cve/cve-2017-6951.c                                     | 2 +-
 testcases/kernel/containers/libclone/libclone.h                   | 2 +-
 testcases/kernel/containers/mqns/mqns_helper.h                    | 2 +-
 testcases/kernel/containers/netns/netns_helper.h                  | 2 +-
 testcases/kernel/containers/pidns/pidns30.c                       | 2 +-
 testcases/kernel/containers/pidns/pidns31.c                       | 2 +-
 testcases/kernel/containers/share/ns_exec.c                       | 2 +-
 testcases/kernel/containers/share/setns_check.c                   | 2 +-
 testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c        | 2 +-
 testcases/kernel/include/.gitignore                               | 1 -
 testcases/kernel/lib/numa_helper.c                                | 2 +-
 testcases/kernel/logging/kmsg/kmsg01.c                            | 2 +-
 testcases/kernel/module/delete_module/delete_module01.c           | 2 +-
 testcases/kernel/module/delete_module/delete_module02.c           | 2 +-
 testcases/kernel/module/delete_module/delete_module03.c           | 2 +-
 testcases/kernel/syscalls/accept4/accept4_01.c                    | 2 +-
 testcases/kernel/syscalls/add_key/add_key01.c                     | 2 +-
 testcases/kernel/syscalls/add_key/add_key02.c                     | 2 +-
 testcases/kernel/syscalls/bdflush/bdflush01.c                     | 2 +-
 testcases/kernel/syscalls/cacheflush/cacheflush01.c               | 2 +-
 testcases/kernel/syscalls/capget/capget01.c                       | 2 +-
 testcases/kernel/syscalls/capget/capget02.c                       | 2 +-
 testcases/kernel/syscalls/capset/capset01.c                       | 2 +-
 testcases/kernel/syscalls/capset/capset02.c                       | 2 +-
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c     | 2 +-
 testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c  | 2 +-
 testcases/kernel/syscalls/clone/clone08.c                         | 2 +-
 testcases/kernel/syscalls/clone/clone09.c                         | 2 +-
 testcases/kernel/syscalls/copy_file_range/copy_file_range01.c     | 2 +-
 testcases/kernel/syscalls/dup3/dup3_01.c                          | 2 +-
 testcases/kernel/syscalls/dup3/dup3_02.c                          | 2 +-
 testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c        | 2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h               | 2 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c                     | 2 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_01.c                  | 2 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_02.c                  | 2 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_03.c                  | 2 +-
 testcases/kernel/syscalls/exit_group/exit_group01.c               | 2 +-
 testcases/kernel/syscalls/faccessat/faccessat01.c                 | 2 +-
 testcases/kernel/syscalls/fadvise/posix_fadvise01.c               | 2 +-
 testcases/kernel/syscalls/fadvise/posix_fadvise02.c               | 2 +-
 testcases/kernel/syscalls/fadvise/posix_fadvise03.c               | 2 +-
 testcases/kernel/syscalls/fadvise/posix_fadvise04.c               | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify.h                     | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify01.c                   | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify02.c                   | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify03.c                   | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify04.c                   | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify05.c                   | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify06.c                   | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify07.c                   | 2 +-
 testcases/kernel/syscalls/fchmodat/fchmodat01.c                   | 2 +-
 testcases/kernel/syscalls/fchownat/fchownat.h                     | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl31.c                         | 2 +-
 testcases/kernel/syscalls/fstatat/fstatat01.c                     | 2 +-
 testcases/kernel/syscalls/futimesat/futimesat01.c                 | 2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c         | 2 +-
 testcases/kernel/syscalls/get_robust_list/get_robust_list01.c     | 2 +-
 testcases/kernel/syscalls/getdents/getdents.h                     | 2 +-
 testcases/kernel/syscalls/getrandom/getrandom01.c                 | 2 +-
 testcases/kernel/syscalls/getrandom/getrandom02.c                 | 2 +-
 testcases/kernel/syscalls/getrandom/getrandom03.c                 | 2 +-
 testcases/kernel/syscalls/getrandom/getrandom04.c                 | 2 +-
 testcases/kernel/syscalls/inotify/inotify01.c                     | 2 +-
 testcases/kernel/syscalls/inotify/inotify02.c                     | 2 +-
 testcases/kernel/syscalls/inotify/inotify03.c                     | 2 +-
 testcases/kernel/syscalls/inotify/inotify04.c                     | 2 +-
 testcases/kernel/syscalls/inotify/inotify05.c                     | 2 +-
 testcases/kernel/syscalls/inotify/inotify06.c                     | 2 +-
 testcases/kernel/syscalls/inotify_init/inotify_init1_01.c         | 2 +-
 testcases/kernel/syscalls/inotify_init/inotify_init1_02.c         | 2 +-
 testcases/kernel/syscalls/kcmp/kcmp.h                             | 2 +-
 testcases/kernel/syscalls/keyctl/keyctl01.c                       | 2 +-
 testcases/kernel/syscalls/linkat/linkat01.c                       | 2 +-
 testcases/kernel/syscalls/linkat/linkat02.c                       | 2 +-
 testcases/kernel/syscalls/mbind/mbind01.c                         | 2 +-
 testcases/kernel/syscalls/memfd_create/memfd_create_common.c      | 2 +-
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c         | 2 +-
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c         | 2 +-
 testcases/kernel/syscalls/mknodat/mknodat.h                       | 2 +-
 testcases/kernel/syscalls/newuname/newuname01.c                   | 2 +-
 testcases/kernel/syscalls/openat/openat.h                         | 2 +-
 testcases/kernel/syscalls/perf_event_open/perf_event_open01.c     | 2 +-
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c     | 2 +-
 testcases/kernel/syscalls/pipe2/pipe2_01.c                        | 2 +-
 testcases/kernel/syscalls/pipe2/pipe2_02.c                        | 2 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c                         | 2 +-
 testcases/kernel/syscalls/preadv/preadv.h                         | 2 +-
 testcases/kernel/syscalls/pwritev/pwritev.h                       | 2 +-
 testcases/kernel/syscalls/readahead/readahead01.c                 | 2 +-
 testcases/kernel/syscalls/readahead/readahead02.c                 | 2 +-
 testcases/kernel/syscalls/readdir/readdir21.c                     | 2 +-
 testcases/kernel/syscalls/readlinkat/readlinkat02.c               | 2 +-
 testcases/kernel/syscalls/renameat2/renameat2.h                   | 2 +-
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c           | 2 +-
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c           | 2 +-
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c           | 2 +-
 testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c       | 2 +-
 testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c       | 2 +-
 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c     | 2 +-
 testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c         | 2 +-
 testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c | 2 +-
 testcases/kernel/syscalls/sched_getattr/sched_getattr01.c         | 2 +-
 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c         | 2 +-
 testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c | 2 +-
 testcases/kernel/syscalls/set_thread_area/set_thread_area.h       | 2 +-
 testcases/kernel/syscalls/set_tid_address/set_tid_address01.c     | 2 +-
 testcases/kernel/syscalls/setns/setns01.c                         | 2 +-
 testcases/kernel/syscalls/setns/setns02.c                         | 2 +-
 testcases/kernel/syscalls/sgetmask/sgetmask01.c                   | 2 +-
 testcases/kernel/syscalls/signal/signal06.c                       | 2 +-
 testcases/kernel/syscalls/signalfd/signalfd01.c                   | 2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_01.c                | 2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_02.c                | 2 +-
 testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c             | 2 +-
 testcases/kernel/syscalls/ssetmask/ssetmask01.c                   | 2 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c                     | 2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c                     | 2 +-
 testcases/kernel/syscalls/swapon/swapon01.c                       | 2 +-
 testcases/kernel/syscalls/swapon/swapon02.c                       | 2 +-
 testcases/kernel/syscalls/swapon/swapon03.c                       | 2 +-
 testcases/kernel/syscalls/switch/endian_switch01.c                | 2 +-
 testcases/kernel/syscalls/symlinkat/symlinkat01.c                 | 2 +-
 testcases/kernel/syscalls/sync_file_range/sync_file_range01.c     | 2 +-
 testcases/kernel/syscalls/syscall/syscall01.c                     | 2 +-
 testcases/kernel/syscalls/sysfs/sysfs01.c                         | 2 +-
 testcases/kernel/syscalls/sysfs/sysfs02.c                         | 2 +-
 testcases/kernel/syscalls/sysfs/sysfs03.c                         | 2 +-
 testcases/kernel/syscalls/sysfs/sysfs04.c                         | 2 +-
 testcases/kernel/syscalls/sysfs/sysfs05.c                         | 2 +-
 testcases/kernel/syscalls/sysfs/sysfs06.c                         | 2 +-
 testcases/kernel/syscalls/tee/tee01.c                             | 2 +-
 testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c   | 2 +-
 testcases/kernel/syscalls/timer_gettime/timer_gettime01.c         | 2 +-
 testcases/kernel/syscalls/timerfd/timerfd01.c                     | 2 +-
 testcases/kernel/syscalls/timerfd/timerfd02.c                     | 2 +-
 testcases/kernel/syscalls/timerfd/timerfd03.c                     | 2 +-
 testcases/kernel/syscalls/tkill/tkill01.c                         | 2 +-
 testcases/kernel/syscalls/tkill/tkill02.c                         | 2 +-
 testcases/kernel/syscalls/unlinkat/unlinkat01.c                   | 2 +-
 testcases/kernel/syscalls/utils/compat_16.h                       | 2 +-
 testcases/kernel/syscalls/utimensat/utimensat01.c                 | 2 +-
 testcases/kernel/syscalls/utimes/utimes01.c                       | 2 +-
 testcases/kernel/syscalls/vmsplice/vmsplice01.c                   | 2 +-
 testcases/kernel/syscalls/vmsplice/vmsplice02.c                   | 2 +-
 testcases/kernel/syscalls/waitid/waitid02.c                       | 2 +-
 testcases/kernel/timers/include/common_timers.h                   | 4 ++--
 163 files changed, 166 insertions(+), 167 deletions(-)
 create mode 100644 include/lapi/.gitignore
 delete mode 100644 testcases/kernel/include/.gitignore

diff --git a/configure.ac b/configure.ac
index 421b8b0f3..c0e39ad64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -134,8 +134,7 @@ fi
 
 AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
 
-AC_CONFIG_COMMANDS([linux_syscall_headers.h],
-		   [cd testcases/kernel/include; ./regen.sh])
+AC_CONFIG_COMMANDS([syscalls.h], [cd include/lapi/syscalls; ./regen.sh])
 
 # END testsuites knobs
 LTP_CHECK_FORTIFY_SOURCE
diff --git a/doc/style-guide.txt b/doc/style-guide.txt
index 08f126cfa..b853fa8dc 100644
--- a/doc/style-guide.txt
+++ b/doc/style-guide.txt
@@ -109,7 +109,7 @@ the testcase occurred.
 8. Don't roll your own syscall numbers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Header +linux_syscall_numbers.h+ exists for this purpose and does a pretty
+Header +lapi/syscalls.h+ exists for this purpose and does a pretty
 dang good job.
 
 9. Keep errors as short and sweet as possible
diff --git a/include/lapi/.gitignore b/include/lapi/.gitignore
new file mode 100644
index 000000000..9867b3f25
--- /dev/null
+++ b/include/lapi/.gitignore
@@ -0,0 +1 @@
+syscalls.h
diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
index 83a798659..3c711bdfa 100644
--- a/include/lapi/fallocate.h
+++ b/include/lapi/fallocate.h
@@ -22,7 +22,7 @@
 #include "config.h"
 #include "lapi/abisize.h"
 #include "lapi/seek.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #ifndef FALLOC_FL_KEEP_SIZE
 # define FALLOC_FL_KEEP_SIZE 0x01
diff --git a/include/lapi/mkdirat.h b/include/lapi/mkdirat.h
index d01b2b287..d61e56e35 100644
--- a/include/lapi/mkdirat.h
+++ b/include/lapi/mkdirat.h
@@ -20,7 +20,7 @@
 #define __MKDIRAT_H__
 
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/fcntl.h"
 
 #ifndef HAVE_MKDIRAT
diff --git a/include/lapi/personality.h b/include/lapi/personality.h
index 275df425e..11d2fc08b 100644
--- a/include/lapi/personality.h
+++ b/include/lapi/personality.h
@@ -30,7 +30,7 @@
 #endif
 
 #ifndef HAVE_SYS_PERSONALITY_H
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static int personality(unsigned long persona)
 {
diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
index 83e159376..155f62064 100644
--- a/include/lapi/readlinkat.h
+++ b/include/lapi/readlinkat.h
@@ -20,7 +20,7 @@
 #define __READLINKAT_H__
 
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/fcntl.h"
 
 #ifndef HAVE_READLINKAT
diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
index b0ec5bc71..fe84e9df6 100644
--- a/include/lapi/renameat.h
+++ b/include/lapi/renameat.h
@@ -22,7 +22,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_RENAMEAT)
 int renameat(int olddirfd, const char *oldpath, int newdirfd,
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index a0efbb0d5..057662dae 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -19,7 +19,7 @@
 #ifndef __SCHED_H__
 #define __SCHED_H__
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include <stdint.h>
 #include <inttypes.h>
 
diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index 4e243fdbc..ffc0fd6d0 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -22,7 +22,7 @@
 #define SPLICE_H
 
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_SPLICE)
 ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 929a3f805..8ef96e660 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-output="linux_syscall_numbers.h"
+output="syscalls.h"
 rm -f "${output}".[1-9]*
 output_pid="${output}.$$"
 
@@ -27,8 +27,8 @@ cat << EOF > "${output_pid}"
  * Licensed under the GPLv2 or later, see the COPYING file.
  */
 
-#ifndef __LINUX_SYSCALL_NUMBERS_H__
-#define __LINUX_SYSCALL_NUMBERS_H__
+#ifndef __LAPI_SYSCALLS_H__
+#define __LAPI_SYSCALLS_H__
 
 #include <errno.h>
 #include <sys/syscall.h>
@@ -123,6 +123,6 @@ printf "Combining them all ... "
 for arch in $(cat "${srcdir}/order") _footer ; do
 	cat "${output_pid}.${arch}"
 done >> "${output_pid}"
-mv "${output_pid}" "${output}"
+mv "${output_pid}" "../${output}"
 rm -f "${output_pid}"*
 echo "OK!"
diff --git a/include/lapi/tee.h b/include/lapi/tee.h
index 0ba10a67e..fe79a8f0a 100644
--- a/include/lapi/tee.h
+++ b/include/lapi/tee.h
@@ -21,7 +21,7 @@
 #define TEE_H
 
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_TEE)
 ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags)
diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
index f574ecfb9..467cd15c1 100644
--- a/include/lapi/timerfd.h
+++ b/include/lapi/timerfd.h
@@ -20,7 +20,7 @@
 
 #include <time.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #ifdef HAVE_SYS_TIMERFD_H
 #include <sys/timerfd.h>
diff --git a/include/lapi/vmsplice.h b/include/lapi/vmsplice.h
index 9dde9d6a1..5842d1749 100644
--- a/include/lapi/vmsplice.h
+++ b/include/lapi/vmsplice.h
@@ -22,7 +22,7 @@
 #define VMSPLICE_H
 
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #include "lapi/iovec.h"
 
diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 2cf87937c..ffbe44fdc 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -26,7 +26,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <string.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 #include "tst_personality.h"
 #include "tst_safe_stdio.h"
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 42e90da10..deb667761 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -56,7 +56,7 @@
 #include "tst_fuzzy_sync.h"
 
 /* The bug was present in the kernel before recvmmsg was exposed by glibc */
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #include "config.h"
 
diff --git a/testcases/cve/cve-2017-6951.c b/testcases/cve/cve-2017-6951.c
index 12cfe3e87..028e25f1d 100644
--- a/testcases/cve/cve-2017-6951.c
+++ b/testcases/cve/cve-2017-6951.c
@@ -26,7 +26,7 @@
 #include <sys/syscall.h>
 
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define ATTEMPTS 0x100
 
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index 70d52e0b0..b8740f1bc 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -26,7 +26,7 @@
 #include <libgen.h>
 #include <sys/syscall.h>
 #include <signal.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "lapi/namespaces_constants.h"
 
diff --git a/testcases/kernel/containers/mqns/mqns_helper.h b/testcases/kernel/containers/mqns/mqns_helper.h
index 1c7132b32..605378d48 100644
--- a/testcases/kernel/containers/mqns/mqns_helper.h
+++ b/testcases/kernel/containers/mqns/mqns_helper.h
@@ -21,7 +21,7 @@
 #include <sys/types.h>
 #include <mqueue.h>
 #include "../libclone/libclone.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 #include "test.h"
 
diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
index 7df6dcb39..8b876454f 100644
--- a/testcases/kernel/containers/netns/netns_helper.h
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -24,7 +24,7 @@
 #include <sched.h>
 #include "config.h"
 #include "libclone.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 849240c3f..5781b2493 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -51,7 +51,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <mqueue.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "pidns_helper.h"
 #include "test.h"
 
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index aaf0c0fa7..935b63533 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -53,7 +53,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <mqueue.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "pidns_helper.h"
 #include "test.h"
 
diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
index ddf13824a..c492165f0 100644
--- a/testcases/kernel/containers/share/ns_exec.c
+++ b/testcases/kernel/containers/share/ns_exec.c
@@ -30,7 +30,7 @@
 #include <string.h>
 #include <errno.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/namespaces_constants.h"
 #include "ns_common.h"
 
diff --git a/testcases/kernel/containers/share/setns_check.c b/testcases/kernel/containers/share/setns_check.c
index 7ba891c69..75aad17f3 100644
--- a/testcases/kernel/containers/share/setns_check.c
+++ b/testcases/kernel/containers/share/setns_check.c
@@ -19,7 +19,7 @@
  */
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "setns_check";
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index e46bd2e57..b38289679 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -48,7 +48,7 @@
 #include "cpuset.h"
 #include "common.h"
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "config.h"
 #if HAVE_LINUX_MEMPOLICY_H
 #include <linux/mempolicy.h>
diff --git a/testcases/kernel/include/.gitignore b/testcases/kernel/include/.gitignore
deleted file mode 100644
index dae4c8cf6..000000000
--- a/testcases/kernel/include/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-linux_syscall_numbers.h
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 7cee7037b..a852f152f 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -34,7 +34,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "numa_helper.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 unsigned long get_max_node(void)
 {
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 5287ddbca..b20704551 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -44,7 +44,7 @@
 #include <unistd.h>
 #include "config.h"
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define MSG_PREFIX "LTP kmsg01 "
 #define MAX_MSGSIZE 4096
diff --git a/testcases/kernel/module/delete_module/delete_module01.c b/testcases/kernel/module/delete_module/delete_module01.c
index da5b08bc7..a159de83c 100644
--- a/testcases/kernel/module/delete_module/delete_module01.c
+++ b/testcases/kernel/module/delete_module/delete_module01.c
@@ -28,7 +28,7 @@
 #include "test.h"
 #include "old_module.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define MODULE_NAME	"dummy_del_mod"
 #define MODULE_NAME_KO	"dummy_del_mod.ko"
diff --git a/testcases/kernel/module/delete_module/delete_module02.c b/testcases/kernel/module/delete_module/delete_module02.c
index 0e60645bb..edfe63864 100644
--- a/testcases/kernel/module/delete_module/delete_module02.c
+++ b/testcases/kernel/module/delete_module/delete_module02.c
@@ -42,7 +42,7 @@
 #include <sys/mman.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define NULLMODNAME	""
 #define BASEMODNAME	"dummy"
diff --git a/testcases/kernel/module/delete_module/delete_module03.c b/testcases/kernel/module/delete_module/delete_module03.c
index cf58ded95..cbf9ff631 100644
--- a/testcases/kernel/module/delete_module/delete_module03.c
+++ b/testcases/kernel/module/delete_module/delete_module03.c
@@ -28,7 +28,7 @@
 #include "test.h"
 #include "old_module.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define DUMMY_MOD		"dummy_del_mod"
 #define DUMMY_MOD_KO		"dummy_del_mod.ko"
diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index a49b23c91..dec4ef93b 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -33,7 +33,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define PORT_NUM 33333
 
diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index f193f71e9..ac561d727 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -29,7 +29,7 @@
 # include <linux/keyctl.h>
 #endif
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void verify_add_key(void)
 {
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 979f668b1..a74282455 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -37,7 +37,7 @@
 # include <linux/keyctl.h>
 #endif
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #ifdef HAVE_LINUX_KEYCTL_H
 struct tcase {
diff --git a/testcases/kernel/syscalls/bdflush/bdflush01.c b/testcases/kernel/syscalls/bdflush/bdflush01.c
index a529ba947..1323cc4e4 100644
--- a/testcases/kernel/syscalls/bdflush/bdflush01.c
+++ b/testcases/kernel/syscalls/bdflush/bdflush01.c
@@ -83,7 +83,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "bdflush01";
 int testno;
diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index f9e0d1e4b..29cf2014a 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -45,7 +45,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if __NR_cacheflush != __LTP__NR_INVALID_SYSCALL
 #include <asm/cachectl.h>
diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index d0304225a..8a2a8921a 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -65,7 +65,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #include <linux/capability.h>
 
diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index 7a1727937..e8d237779 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -74,7 +74,7 @@
 
 #include <errno.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 /**************************************************************************/
 /*                                                                        */
diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index 517fd1455..9c61773bb 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -69,7 +69,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 /**************************************************************************/
 /*                                                                        */
diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index d08878e00..381ab75f8 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -81,7 +81,7 @@
 #include <string.h>
 #include <unistd.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 /**************************************************************************/
 /*                                                                        */
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 20a54dc87..9ddc9a7d8 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -22,7 +22,7 @@
 
 #include <limits.h>
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "tst_sig_proc.h"
 #include "tst_timer.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
index d40ca8e18..3d8288c2a 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
@@ -26,7 +26,7 @@
 #include <sys/syscall.h>
 
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define NSEC_IN_SEC 1000000000
 
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index ccad502b8..58f9be0e2 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -25,7 +25,7 @@
 
 #include "tst_test.h"
 #include "clone_platform.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static pid_t ptid, ctid, tgid;
 static void *child_stack;
diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index 629e6c4e4..1528be4aa 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -22,7 +22,7 @@
 
 #include "tst_test.h"
 #include "clone_platform.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/namespaces_constants.h"
 
 static void *child_stack;
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index 1a2e039ce..25c701f27 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_FILE_1 "copy_file_range_ltp01.txt"
 #define TEST_FILE_2 "copy_file_range_ltp02.txt"
diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index be3f4d814..6a44ec809 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -60,7 +60,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "dup3_01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
index f33690473..e49ec3575 100644
--- a/testcases/kernel/syscalls/dup3/dup3_02.c
+++ b/testcases/kernel/syscalls/dup3/dup3_02.c
@@ -35,7 +35,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index 436a489f9..85f14c4dc 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -32,7 +32,7 @@
 #include <sys/epoll.h>
 #include "tst_test.h"
 #include "lapi/epoll.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void verify_epoll_create1(void)
 {
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h
index 572cedb5d..344ff2072 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h
@@ -22,7 +22,7 @@
 #include <sys/types.h>
 #include <signal.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_EPOLL_PWAIT)
 int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index c622197f8..37cca7d53 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -59,7 +59,7 @@
 
 #include "test.h"
 #define CLEANUP cleanup
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #ifdef HAVE_LIBAIO_H
 #include <libaio.h>
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
index 96b1e1417..a4af38858 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
@@ -61,7 +61,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define EFD_CLOEXEC O_CLOEXEC
 
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index b2be520e2..151edb841 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -58,7 +58,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define EFD_NONBLOCK O_NONBLOCK
 
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index eb3d0e751..4c26b654e 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -36,7 +36,7 @@
 #include <inttypes.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "eventfd2_03";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 787331631..3726b0652 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -25,7 +25,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "exit_group01";
 int testno;
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index def7fa755..807ab917b 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -43,7 +43,7 @@
 #include <signal.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_CASES 6
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index 835c3ca94..fd21f46fd 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -43,7 +43,7 @@
 
 #include "test.h"
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
 #define _FILE_OFFSET_BITS 32
 #endif
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
index 73ca31125..0b6b3553d 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
@@ -41,7 +41,7 @@
 #include <errno.h>
 #include "test.h"
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
 #define _FILE_OFFSET_BITS 32
 #endif
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 25c57be55..161074dfb 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -42,7 +42,7 @@
 #include <limits.h>
 #include "test.h"
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
 #define _FILE_OFFSET_BITS 32
 #endif
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
index af33cf233..f466e6f32 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -40,7 +40,7 @@
 #include <signal.h>
 #include <errno.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
 #define _FILE_OFFSET_BITS 32
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 518d05ef3..f5f7df25e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -39,7 +39,7 @@
 /* fanotify(7) wrappers */
 
 #include <stdint.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static int fanotify_init(unsigned int flags, unsigned int event_f_flags)
 {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 1df3a69b2..4799d5432 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -36,7 +36,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 5a48e6502..29dbe4f18 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -36,7 +36,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 4dc55c9bf..2aca2e19f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -39,7 +39,7 @@
 #include <signal.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index bffa3e508..dca52f0d6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -37,7 +37,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 735b41561..6063764c9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -35,7 +35,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index cc20cc197..d7fef6dbe 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -45,7 +45,7 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 79ff45586..54e5a1f4d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -47,7 +47,7 @@
 #include <signal.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 7856ed3fa..369f80eb2 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -43,7 +43,7 @@
 #include <signal.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_CASES 6
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/fchownat/fchownat.h b/testcases/kernel/syscalls/fchownat/fchownat.h
index 9040544e6..a95c26f93 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat.h
+++ b/testcases/kernel/syscalls/fchownat/fchownat.h
@@ -22,7 +22,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 
 #if !defined(HAVE_FCHOWNAT)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index 804d0abac..52b4932fa 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -35,7 +35,7 @@
 
 #include "test.h"
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 840d7b60e..b5fa83735 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -35,7 +35,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_CASES 6
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 514cfcfcb..e3b1011e8 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -34,7 +34,7 @@
 #include <signal.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_CASES 5
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index c96fb33c4..cca50288f 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -58,7 +58,7 @@
 #include <numaif.h>
 #endif
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "include_j_h.h"
 #include "common_j_h.c"
 #include "numa_helper.h"
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index 2efed9a79..6aa776f6a 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -51,7 +51,7 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "get_robust_list01";
 int TST_TOTAL = 5;
diff --git a/testcases/kernel/syscalls/getdents/getdents.h b/testcases/kernel/syscalls/getdents/getdents.h
index abea65587..702b0bd28 100644
--- a/testcases/kernel/syscalls/getdents/getdents.h
+++ b/testcases/kernel/syscalls/getdents/getdents.h
@@ -22,7 +22,7 @@
 
 #include <stdint.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 /*
  * See fs/compat.c struct compat_linux_dirent
diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index 4af85e2f1..8bc026901 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -27,7 +27,7 @@
  */
 
 #include "lapi/getrandom.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 
 static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index 4eef7518c..cc7b0b814 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -28,7 +28,7 @@
  */
 
 #include "lapi/getrandom.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 
 static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index 53a8ed711..55c287257 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -31,7 +31,7 @@
  */
 
 #include "lapi/getrandom.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 
 #define MAX_SIZE 256
diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index 41bcf0d19..8a3faf94d 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -32,7 +32,7 @@
 
 #include <sys/resource.h>
 #include "lapi/getrandom.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 
 static void verify_getrandom(void)
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 58dfe1467..7f08a8f95 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -38,7 +38,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "inotify.h"
 
 #if defined(HAVE_SYS_INOTIFY_H)
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 4c51d2b22..991342656 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -40,7 +40,7 @@
 #include <sys/syscall.h>
 #include <limits.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "inotify.h"
 
 #if defined(HAVE_SYS_INOTIFY_H)
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index d3007b0cb..ec2f5d2bc 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -42,7 +42,7 @@
 #include <sys/syscall.h>
 #include <signal.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "inotify.h"
 
 char *TCID = "inotify03";
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 1a18341c5..87ef9c3b3 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -45,7 +45,7 @@
 #include <errno.h>
 #include <string.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "inotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index cd48f4085..b5265217c 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -35,7 +35,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "inotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 71f7596cc..7ac579495 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -42,7 +42,7 @@
 #include <sys/syscall.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "inotify.h"
 #include "safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
index 45928f952..f1203a495 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
@@ -61,7 +61,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define IN_CLOEXEC O_CLOEXEC
 
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
index 2d68eaa41..b074214f7 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
@@ -58,7 +58,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define IN_NONBLOCK O_NONBLOCK
 
diff --git a/testcases/kernel/syscalls/kcmp/kcmp.h b/testcases/kernel/syscalls/kcmp/kcmp.h
index ab50d4b64..59371fc07 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp.h
+++ b/testcases/kernel/syscalls/kcmp/kcmp.h
@@ -21,7 +21,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_ENUM_KCMP_TYPE)
 
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 30503ffe9..6af8001e2 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -35,7 +35,7 @@
 #endif
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "keyctl01";
 int testno;
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 6772a6b74..cde0910e1 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -56,7 +56,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 6766b5a38..292d9f57a 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -31,7 +31,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index aeefd28d2..d5c93f203 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -60,7 +60,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "include_j_h.h"
 #include "numa_helper.h"
 
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index 79fc02e0f..8f959e270 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -30,7 +30,7 @@
 #include "lapi/fcntl.h"
 #include "lapi/memfd.h"
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #include "memfd_create_common.h"
 
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 4a972b3e0..88a37219c 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -44,7 +44,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "numa_helper.h"
 #include "migrate_pages_common.h"
 
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 2caa4e75d..4b1126eaf 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -48,7 +48,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "numa_helper.h"
 #include "migrate_pages_common.h"
 
diff --git a/testcases/kernel/syscalls/mknodat/mknodat.h b/testcases/kernel/syscalls/mknodat/mknodat.h
index ac141572f..577d5ac9c 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat.h
+++ b/testcases/kernel/syscalls/mknodat/mknodat.h
@@ -22,7 +22,7 @@
 #define MKNODAT_H
 
 #include <sys/types.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_MKNODAT)
 int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index 1c5cb48f9..ebf2fcc10 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -45,7 +45,7 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "newuname01";
 int testno;
diff --git a/testcases/kernel/syscalls/openat/openat.h b/testcases/kernel/syscalls/openat/openat.h
index fce4e3f1f..9b5568bda 100644
--- a/testcases/kernel/syscalls/openat/openat.h
+++ b/testcases/kernel/syscalls/openat/openat.h
@@ -23,7 +23,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_OPENAT)
 int openat(int dirfd, const char *pathname, int flags, mode_t mode)
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 926f84b04..5c814b60c 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -43,7 +43,7 @@
 #endif
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 
 char *TCID = "perf_event_open01";
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 6bb6cd08c..7d54cbd52 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -71,7 +71,7 @@ The -v flag makes it print out the values of each counter.
 
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "perf_event_open02";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
index 38d257f07..5f3ad8f0f 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
@@ -69,7 +69,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "pipe2_01";
 int testno;
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
index e130f4038..39f02ff8c 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_02.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
@@ -60,7 +60,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "pipe2_02";
 int testno;
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 0dcda7fcb..5bfab254d 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -26,7 +26,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "ltp_signal.h"
 #include "tst_sig_proc.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
index f3ac30db3..73466a9aa 100644
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ b/testcases/kernel/syscalls/preadv/preadv.h
@@ -19,7 +19,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_PREADV)
 int preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
index 4970036ef..833160ddb 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -19,7 +19,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_PWRITEV)
 int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index 5f829bd83..f35019488 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -38,7 +38,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "readahead01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 77862cf41..7e51cd314 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -45,7 +45,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "readahead02";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/readdir/readdir21.c b/testcases/kernel/syscalls/readdir/readdir21.c
index ced8fa76d..205e0715b 100644
--- a/testcases/kernel/syscalls/readdir/readdir21.c
+++ b/testcases/kernel/syscalls/readdir/readdir21.c
@@ -40,7 +40,7 @@
 #include <sys/mman.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/readdir.h"
 
 char *TCID = "readdir21";
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat02.c b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
index cd83bc3b9..d30c1917a 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat02.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
@@ -35,7 +35,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/readlinkat.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_FILE	"test_file"
 #define SYMLINK_FILE	"symlink_file"
diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
index dd0c2f7f4..b04558d14 100644
--- a/testcases/kernel/syscalls/renameat2/renameat2.h
+++ b/testcases/kernel/syscalls/renameat2/renameat2.h
@@ -21,7 +21,7 @@
 
 #include <sys/types.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if !defined(HAVE_RENAMEAT2)
 int renameat2(int olddirfd, const char *oldpath, int newdirfd,
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 5cf89cc87..be9e9abb7 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -37,7 +37,7 @@
 #include <string.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigaction01";
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index a1da74396..2c4d8799b 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -33,7 +33,7 @@
 #include <string.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigaction02";
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 175d220d2..823fbe6c2 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -33,7 +33,7 @@
 #include <string.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/rt_sigaction.h"
 
 #define INVAL_SIGSETSIZE -1
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 74e5a61b6..202e85386 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -44,7 +44,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigprocmask01";
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index cbc4f7e51..5c8c36b74 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -56,7 +56,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "ltp_signal.h"
 
 char *TCID = "rt_sigprocmask02";
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
index 60757dd3c..9d0cff96d 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -49,7 +49,7 @@
 #include <string.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "rt_sigqueueinfo01";
 int testno;
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 95b582746..19e2eb66a 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -28,7 +28,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigsuspend01";
diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index 9d6a81a57..7e1146532 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -50,7 +50,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "sched_getaffinity01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index 62faeca0f..2a2c13a40 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -26,7 +26,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/sched.h"
 
 char *TCID = "sched_getattr01";
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index 5db994297..2d7e15a47 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -35,7 +35,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/sched.h"
 
 char *TCID = "sched_getattr02";
diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
index 70fda2c9f..43f8efc9f 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
@@ -41,7 +41,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "sched_setaffinity.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "sched_setaffinity01";
 
diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area.h b/testcases/kernel/syscalls/set_thread_area/set_thread_area.h
index 8d3f4b1c8..2bd2469d5 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area.h
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area.h
@@ -3,7 +3,7 @@
 
 /* Harness Specific Include Files. */
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "config.h"
 
 #if defined HAVE_ASM_LDT_H
diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index b7aea1bc5..20974a9e7 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -42,7 +42,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "set_tid_address01";
 int testno;
diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
index 6409582e0..5d8a49117 100644
--- a/testcases/kernel/syscalls/setns/setns01.c
+++ b/testcases/kernel/syscalls/setns/setns01.c
@@ -34,7 +34,7 @@
 #include <string.h>
 #include "config.h"
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 
 char *TCID = "setns01";
diff --git a/testcases/kernel/syscalls/setns/setns02.c b/testcases/kernel/syscalls/setns/setns02.c
index fc2fc7426..58a02a65b 100644
--- a/testcases/kernel/syscalls/setns/setns02.c
+++ b/testcases/kernel/syscalls/setns/setns02.c
@@ -42,7 +42,7 @@
 #include <string.h>
 #include "config.h"
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 
 #define CHILD_STACK_SIZE (1024*1024)
diff --git a/testcases/kernel/syscalls/sgetmask/sgetmask01.c b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
index 7114856f5..2b482f385 100644
--- a/testcases/kernel/syscalls/sgetmask/sgetmask01.c
+++ b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
@@ -53,7 +53,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "sgetmask01";
 int testno;
diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
index 1f1b31c9d..64f886ee3 100644
--- a/testcases/kernel/syscalls/signal/signal06.c
+++ b/testcases/kernel/syscalls/signal/signal06.c
@@ -48,7 +48,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "signal06";
 int TST_TOTAL = 5;
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 48c929291..985952430 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -83,7 +83,7 @@ int main(int argc, char **argv)
 
 #else
 #if defined USE_OWNIMPL
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 int signalfd(int fd, const sigset_t * mask, int flags)
 {
 	/* Taken from GLIBC. */
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index 4dc60d2fa..9f859735f 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -63,7 +63,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "ltp_signal.h"
 
 #define SFD_CLOEXEC O_CLOEXEC
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
index 800687d7a..ddf8b8c3d 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
@@ -58,7 +58,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "ltp_signal.h"
 
 #define SFD_NONBLOCK O_NONBLOCK
diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 1cc391856..35acd67c4 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -26,7 +26,7 @@
 #include "../utils/include_j_h.h"
 #include "../utils/common_j_h.c"
 #include <limits.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define SUCCEED_OR_DIE(syscall, message, ...)				 \
 	(errno = 0,							 \
diff --git a/testcases/kernel/syscalls/ssetmask/ssetmask01.c b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
index d0246969e..336a9be3f 100644
--- a/testcases/kernel/syscalls/ssetmask/ssetmask01.c
+++ b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
@@ -44,7 +44,7 @@
 #include <signal.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "ssetmask01";
 int testno;
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index b612e2387..a63e661a5 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -24,7 +24,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 8ad6afcfe..b5c6312a1 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -31,7 +31,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 28276993a..32538f82b 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -23,7 +23,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "libswapon.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 50f2f7fe1..4af5105c6 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -33,7 +33,7 @@
 #include <sys/utsname.h>
 #include <signal.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 #include "libswapon.h"
 
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 9693befb8..d3f73b044 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -37,7 +37,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "swaponoff.h"
 #include "libswapon.h"
 
diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index 98584bade..86aed8910 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -51,7 +51,7 @@
 #include <fcntl.h>
 #include <sys/utsname.h>
 #include <unistd.h>
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #if defined (__powerpc64__) || (__powerpc__)
 static void setup();
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 14b781efa..8c9e148e9 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -43,7 +43,7 @@
 #include <signal.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define MYRETCODE -999
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index ea0519552..0a9fb8e81 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -92,7 +92,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #ifndef SYNC_FILE_RANGE_WAIT_BEFORE
 #define SYNC_FILE_RANGE_WAIT_BEFORE 1
diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 728f538cc..1173c31ae 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -28,7 +28,7 @@
 #include <sys/types.h>
 
 #include "tst_test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void verify_getpid(void)
 {
diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c b/testcases/kernel/syscalls/sysfs/sysfs01.c
index 9d9a08253..85052dc2b 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs01.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
@@ -70,7 +70,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void setup();
 static void cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs02.c b/testcases/kernel/syscalls/sysfs/sysfs02.c
index 6c94b1e7c..e9065dda7 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs02.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs02.c
@@ -68,7 +68,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void setup();
 static void cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs03.c b/testcases/kernel/syscalls/sysfs/sysfs03.c
index b49b99e9c..98bd5c692 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs03.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs03.c
@@ -68,7 +68,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void setup();
 static void cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs04.c b/testcases/kernel/syscalls/sysfs/sysfs04.c
index b1131e442..6356a89c8 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs04.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs04.c
@@ -71,7 +71,7 @@
 #include <errno.h>
 #include  <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define INVALID_OPTION 100
 static void setup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c b/testcases/kernel/syscalls/sysfs/sysfs05.c
index 36bc78649..8f8bb356e 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs05.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
@@ -72,7 +72,7 @@
 #include <errno.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void setup();
 static void cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs06.c b/testcases/kernel/syscalls/sysfs/sysfs06.c
index e16946234..d9a8cd51c 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs06.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs06.c
@@ -73,7 +73,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 static void setup();
 static void cleanup();
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 6e1f46f47..ee337f868 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -34,7 +34,7 @@
 #include <sys/syscall.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 #include "lapi/tee.h"
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index a017f9dfe..2bb38ea7a 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -27,7 +27,7 @@
 #include <sys/syscall.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "timer_getoverrun01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
index 57d23fc32..1c75f1cf0 100644
--- a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
+++ b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
@@ -27,7 +27,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "timer_gettime01";
 int TST_TOTAL = 3;
diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 4a3cf2fcf..868fbe271 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -43,7 +43,7 @@
 #include <time.h>
 #include <errno.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define cleanup tst_exit
 
diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index 006ef165f..c54440660 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -63,7 +63,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TFD_CLOEXEC O_CLOEXEC
 
diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
index dc8efd46f..e288251b3 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd03.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
@@ -59,7 +59,7 @@
 
 #include "test.h"
 #include "lapi/fcntl.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TFD_NONBLOCK O_NONBLOCK
 
diff --git a/testcases/kernel/syscalls/tkill/tkill01.c b/testcases/kernel/syscalls/tkill/tkill01.c
index d4100dcc4..20c28f1bc 100644
--- a/testcases/kernel/syscalls/tkill/tkill01.c
+++ b/testcases/kernel/syscalls/tkill/tkill01.c
@@ -49,7 +49,7 @@
 #include <sys/types.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "tkill01";
 int testno;
diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index cc0d4f5c6..48431755b 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -33,7 +33,7 @@
 #include <sys/syscall.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "tkill02";
 int testno;
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index cfc9c4dc7..76566e85a 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -35,7 +35,7 @@
 #include <signal.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define TEST_CASES 7
 #ifndef AT_FDCWD
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index df045b25b..f0bc3265b 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -32,7 +32,7 @@
 
 #include "compat_gid.h"
 #include "compat_uid.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 int setresuid(uid_t ruid, uid_t euid, uid_t suid);
 int setresgid(gid_t rgid, gid_t egid, gid_t sgid);
diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 3ff9483e6..264ca1e15 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -40,7 +40,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "utimensat01";
 int TST_TOTAL = 0;
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 6cade0eae..b2450d2b7 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -50,7 +50,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #define MNTPOINT "mntpoint"
 #define TESTFILE1 "testfile1"
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 1519efcf3..ef3d80bb1 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -34,7 +34,7 @@
 #include <sys/poll.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 #include "lapi/splice.h"
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index f8af0ac7e..730b0fa64 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -37,7 +37,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 #include "lapi/fcntl.h"
 #include "lapi/vmsplice.h"
 
diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index db7e88307..431e91060 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -48,7 +48,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 struct testcase_t {
 	const char *msg;
diff --git a/testcases/kernel/timers/include/common_timers.h b/testcases/kernel/timers/include/common_timers.h
index 30d2dca25..313cd4120 100644
--- a/testcases/kernel/timers/include/common_timers.h
+++ b/testcases/kernel/timers/include/common_timers.h
@@ -9,7 +9,7 @@
 
 #define CLEANUP cleanup
 #include "config.h"
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #ifndef NSEC_PER_SEC
 #define NSEC_PER_SEC (1000000000L)
@@ -59,7 +59,7 @@ const char *get_clock_str(const int clock_id)
 	}
 }
 
-#include "linux_syscall_numbers.h"
+#include "lapi/syscalls.h"
 
 #include <time.h>
 #include <unistd.h>
-- 
2.13.3

