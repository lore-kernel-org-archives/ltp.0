From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Feb 2021 16:24:47 +0100
Subject: [LTP] [PATCH] include/lapi: Change functions to static inline
Message-ID: <20210217152447.15459-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are a few function left in the lapi/rt_sigaction.h since we
actually store pointers to them and store them in the sigaction
structure.

Fixes #781

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/execveat.h          |  6 +++---
 include/lapi/fsmount.h           | 19 ++++++++++---------
 include/lapi/init_module.h       |  2 +-
 include/lapi/mkdirat.h           |  2 +-
 include/lapi/openat2.h           |  5 +++--
 include/lapi/pidfd_open.h        |  2 +-
 include/lapi/pidfd_send_signal.h |  4 ++--
 include/lapi/preadv2.h           |  4 ++--
 include/lapi/pwritev2.h          |  4 ++--
 include/lapi/readlinkat.h        |  3 ++-
 include/lapi/renameat.h          |  4 ++--
 include/lapi/sched.h             | 11 ++++-------
 include/lapi/setns.h             |  2 +-
 include/lapi/splice.h            |  4 ++--
 include/lapi/syncfs.h            |  2 +-
 include/lapi/tee.h               |  3 ++-
 include/lapi/timerfd.h           |  9 +++++----
 include/lapi/vmsplice.h          |  4 ++--
 18 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/include/lapi/execveat.h b/include/lapi/execveat.h
index a7406f7c0..7a7032288 100644
--- a/include/lapi/execveat.h
+++ b/include/lapi/execveat.h
@@ -11,9 +11,9 @@
 #include "lapi/syscalls.h"
 
 #if !defined(HAVE_EXECVEAT)
-int execveat(int dirfd, const char *pathname,
-			char *const argv[], char *const envp[],
-			int flags)
+static inline int execveat(int dirfd, const char *pathname,
+			   char *const argv[], char *const envp[],
+			   int flags)
 {
 	return tst_syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
 }
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 09a2c1611..d6ebed9b4 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -16,37 +16,38 @@
 #include "lapi/syscalls.h"
 
 #ifndef HAVE_FSOPEN
-int fsopen(const char *fsname, unsigned int flags)
+static inline int fsopen(const char *fsname, unsigned int flags)
 {
 	return tst_syscall(__NR_fsopen, fsname, flags);
 }
 #endif /* HAVE_FSOPEN */
 
 #ifndef HAVE_FSCONFIG
-int fsconfig(int fd, unsigned int cmd, const char *key,
-	     const void *value, int aux)
+static inline int fsconfig(int fd, unsigned int cmd, const char *key,
+                           const void *value, int aux)
 {
 	return tst_syscall(__NR_fsconfig, fd, cmd, key, value, aux);
 }
 #endif /* HAVE_FSCONFIG */
 
 #ifndef HAVE_FSMOUNT
-int fsmount(int fd, unsigned int flags, unsigned int mount_attrs)
+static inline int fsmount(int fd, unsigned int flags, unsigned int mount_attrs)
 {
 	return tst_syscall(__NR_fsmount, fd, flags, mount_attrs);
 }
 #endif /* HAVE_FSMOUNT */
 
 #ifndef HAVE_FSPICK
-int fspick(int dirfd, const char *pathname, unsigned int flags)
+static inline int fspick(int dirfd, const char *pathname, unsigned int flags)
 {
 	return tst_syscall(__NR_fspick, dirfd, pathname, flags);
 }
 #endif /* HAVE_FSPICK */
 
 #ifndef HAVE_MOVE_MOUNT
-int move_mount(int from_dirfd, const char *from_pathname, int to_dirfd,
-	       const char *to_pathname, unsigned int flags)
+static inline int move_mount(int from_dirfd, const char *from_pathname,
+                             int to_dirfd, const char *to_pathname,
+                             unsigned int flags)
 {
 	return tst_syscall(__NR_move_mount, from_dirfd, from_pathname, to_dirfd,
 			   to_pathname, flags);
@@ -54,7 +55,7 @@ int move_mount(int from_dirfd, const char *from_pathname, int to_dirfd,
 #endif /* HAVE_MOVE_MOUNT */
 
 #ifndef HAVE_OPEN_TREE
-int open_tree(int dirfd, const char *pathname, unsigned int flags)
+static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
 {
 	return tst_syscall(__NR_open_tree, dirfd, pathname, flags);
 }
@@ -130,7 +131,7 @@ enum fsconfig_command {
 
 #endif /* OPEN_TREE_CLONE */
 
-void fsopen_supported_by_kernel(void)
+static inline void fsopen_supported_by_kernel(void)
 {
 	if ((tst_kvercmp(5, 2, 0)) < 0) {
 		/* Check if the syscall is backported on an older kernel */
diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
index 9e79e11b8..14eaabee6 100644
--- a/include/lapi/init_module.h
+++ b/include/lapi/init_module.h
@@ -22,7 +22,7 @@ static inline int finit_module(int fd, const char *param_values, int flags)
 	return tst_syscall(__NR_finit_module, fd, param_values, flags);
 }
 
-void finit_module_supported_by_kernel(void)
+static inline void finit_module_supported_by_kernel(void)
 {
        if ((tst_kvercmp(3, 8, 0)) < 0) {
                /* Check if the syscall is backported on an older kernel */
diff --git a/include/lapi/mkdirat.h b/include/lapi/mkdirat.h
index bb8c6d869..ae2c7284b 100644
--- a/include/lapi/mkdirat.h
+++ b/include/lapi/mkdirat.h
@@ -11,7 +11,7 @@
 #include "lapi/fcntl.h"
 
 #ifndef HAVE_MKDIRAT
-int mkdirat(int dirfd, const char *dirname, int mode)
+static inline int mkdirat(int dirfd, const char *dirname, int mode)
 {
 	return ltp_syscall(__NR_mkdirat, dirfd, dirname, mode);
 }
diff --git a/include/lapi/openat2.h b/include/lapi/openat2.h
index 62da1a04c..d4154c26e 100644
--- a/include/lapi/openat2.h
+++ b/include/lapi/openat2.h
@@ -47,7 +47,8 @@ struct open_how {
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
 
-int openat2(int dfd, const char *pathname, struct open_how *how, size_t size)
+static inline int openat2(int dfd, const char *pathname,
+                          struct open_how *how, size_t size)
 {
 	return tst_syscall(__NR_openat2, dfd, pathname, how, size);
 }
@@ -59,7 +60,7 @@ struct open_how_pad {
 	uint64_t pad;
 };
 
-void openat2_supported_by_kernel(void)
+static inline void openat2_supported_by_kernel(void)
 {
 	if ((tst_kvercmp(5, 6, 0)) < 0) {
 		/* Check if the syscall is backported on an older kernel */
diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
index 9f532f86e..2b0c5b073 100644
--- a/include/lapi/pidfd_open.h
+++ b/include/lapi/pidfd_open.h
@@ -15,7 +15,7 @@
 #include "config.h"
 
 #ifndef HAVE_PIDFD_OPEN
-int pidfd_open(pid_t pid, unsigned int flags)
+static inline int pidfd_open(pid_t pid, unsigned int flags)
 {
 	return tst_syscall(__NR_pidfd_open, pid, flags);
 }
diff --git a/include/lapi/pidfd_send_signal.h b/include/lapi/pidfd_send_signal.h
index 8352d2adf..512174def 100644
--- a/include/lapi/pidfd_send_signal.h
+++ b/include/lapi/pidfd_send_signal.h
@@ -17,8 +17,8 @@ static inline void pidfd_send_signal_supported(void)
 }
 
 #ifndef HAVE_PIDFD_SEND_SIGNAL
-static int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
-				 unsigned int flags)
+static inline int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+                                    unsigned int flags)
 {
 	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
 }
diff --git a/include/lapi/preadv2.h b/include/lapi/preadv2.h
index 538ed7218..19ac589f3 100644
--- a/include/lapi/preadv2.h
+++ b/include/lapi/preadv2.h
@@ -19,8 +19,8 @@
 /* LO_HI_LONG taken from glibc */
 # define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val)) >> 32)
 
-ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
-		int flags)
+static inline ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt,
+                              off_t offset, int flags)
 {
 	return tst_syscall(__NR_preadv2, fd, iov, iovcnt,
 			   LO_HI_LONG(offset), flags);
diff --git a/include/lapi/pwritev2.h b/include/lapi/pwritev2.h
index 305e48e02..a93f017c6 100644
--- a/include/lapi/pwritev2.h
+++ b/include/lapi/pwritev2.h
@@ -15,8 +15,8 @@
 /* LO_HI_LONG taken from glibc */
 # define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val)) >> 32)
 
-ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
-		int flags)
+static inline ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt,
+                               off_t offset, int flags)
 {
 	return tst_syscall(__NR_pwritev2, fd, iov, iovcnt,
 			   LO_HI_LONG(offset), flags);
diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
index 5a3a7b2d6..4205d0070 100644
--- a/include/lapi/readlinkat.h
+++ b/include/lapi/readlinkat.h
@@ -11,7 +11,8 @@
 #include "lapi/fcntl.h"
 
 #ifndef HAVE_READLINKAT
-int readlinkat(int dirfd, const char *pathname, char *buf, size_t bufsiz)
+static inline int readlinkat(int dirfd, const char *pathname,
+                             char *buf, size_t bufsiz)
 {
 	return ltp_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
 }
diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
index 66d3e2140..c92b30a9a 100644
--- a/include/lapi/renameat.h
+++ b/include/lapi/renameat.h
@@ -12,8 +12,8 @@
 #include "lapi/syscalls.h"
 
 #if !defined(HAVE_RENAMEAT)
-int renameat(int olddirfd, const char *oldpath, int newdirfd,
-			const char *newpath)
+static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
+                           const char *newpath)
 {
 	return ltp_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
 					newpath);
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 26fe445e9..ee38c3a1c 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -28,17 +28,14 @@ struct sched_attr {
 	uint64_t sched_period;
 };
 
-int sched_setattr(pid_t pid,
-	const struct sched_attr *attr,
-	unsigned int flags)
+static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+                                unsigned int flags)
 {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
 
-int sched_getattr(pid_t pid,
-	struct sched_attr *attr,
-	unsigned int size,
-	unsigned int flags)
+static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
+                                unsigned int size, unsigned int flags)
 {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
diff --git a/include/lapi/setns.h b/include/lapi/setns.h
index 7b0a7afc4..2d0be8846 100644
--- a/include/lapi/setns.h
+++ b/include/lapi/setns.h
@@ -11,7 +11,7 @@
 #include <sched.h>
 
 #ifndef HAVE_SETNS
-int setns(int fd, int nstype)
+static inline int setns(int fd, int nstype)
 {
 	return tst_syscall(__NR_setns, fd, nstype);
 }
diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index 0cd6f55d2..76ac7084a 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -11,8 +11,8 @@
 #include "lapi/syscalls.h"
 
 #if !defined(HAVE_SPLICE)
-ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
-	loff_t *off_out, size_t len, unsigned int flags)
+static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
+                             loff_t *off_out, size_t len, unsigned int flags)
 {
 	return tst_syscall(__NR_splice, fd_in, off_in,
 		fd_out, off_out, len, flags);
diff --git a/include/lapi/syncfs.h b/include/lapi/syncfs.h
index e5d29fa96..d3c0c8a2a 100644
--- a/include/lapi/syncfs.h
+++ b/include/lapi/syncfs.h
@@ -12,7 +12,7 @@
 #include "lapi/syscalls.h"
 
 #if !defined(HAVE_SYNCFS)
-int syncfs(int fd)
+static inline int syncfs(int fd)
 {
 	return tst_syscall(__NR_syncfs, fd);
 }
diff --git a/include/lapi/tee.h b/include/lapi/tee.h
index 422e81177..237f4e1e0 100644
--- a/include/lapi/tee.h
+++ b/include/lapi/tee.h
@@ -11,7 +11,8 @@
 #include "lapi/syscalls.h"
 
 #if !defined(HAVE_TEE)
-ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags)
+static inline ssize_t tee(int fd_in, int fd_out,
+                          size_t len, unsigned int flags)
 {
 	return tst_syscall(__NR_tee, fd_in, fd_out, len, flags);
 }
diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
index 50e09726b..91773ff72 100644
--- a/include/lapi/timerfd.h
+++ b/include/lapi/timerfd.h
@@ -16,15 +16,16 @@
 #endif
 
 #if !defined(HAVE_TIMERFD_CREATE)
-int timerfd_create(int clockid, int flags)
+static inline int timerfd_create(int clockid, int flags)
 {
 	return ltp_syscall(__NR_timerfd_create, clockid, flags);
 }
 #endif
 
 #if !defined(HAVE_TIMERFD_GETTIME)
-int timerfd_settime(int fd, int flags, const struct itimerspec *new_value,
-		    struct itimerspec *old_value)
+static inline int timerfd_settime(int fd, int flags,
+                                  const struct itimerspec *new_value,
+                                  struct itimerspec *old_value)
 {
 	return ltp_syscall(__NR_timerfd_settime, fd, flags, new_value,
 			   old_value);
@@ -32,7 +33,7 @@ int timerfd_settime(int fd, int flags, const struct itimerspec *new_value,
 #endif
 
 #if !defined(HAVE_TIMERFD_SETTIME)
-int timerfd_gettime(int fd, struct itimerspec *curr_value)
+static inline int timerfd_gettime(int fd, struct itimerspec *curr_value)
 {
 	return ltp_syscall(__NR_timerfd_gettime, fd, curr_value);
 }
diff --git a/include/lapi/vmsplice.h b/include/lapi/vmsplice.h
index ba0fcca27..96b32f3fa 100644
--- a/include/lapi/vmsplice.h
+++ b/include/lapi/vmsplice.h
@@ -13,8 +13,8 @@
 #include "lapi/iovec.h"
 
 #if !defined(HAVE_VMSPLICE)
-ssize_t vmsplice(int fd, const struct iovec *iov,
-	         unsigned long nr_segs, unsigned int flags)
+static inline ssize_t vmsplice(int fd, const struct iovec *iov,
+	                       unsigned long nr_segs, unsigned int flags)
 {
 	return tst_syscall(__NR_vmsplice, fd, iov, nr_segs, flags);
 }
-- 
2.26.2

