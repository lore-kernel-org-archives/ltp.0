From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 16:54:58 +0200
Subject: [LTP] [PATCH 1/1] configure.ac: Sort alphabetically custom
	autotools functions
Message-ID: <20190412145458.4790-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

tired by the need to manually resolve conflicts when rebase branches
which added custom autotools functions (we all add them to the end).

Kind regards,
Petr
---
 configure.ac | 77 ++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/configure.ac b/configure.ac
index de1249982..fad8f8396 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,63 +190,62 @@ AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
 
 AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
 
-# END testsuites knobs
-LTP_CHECK_FORTIFY_SOURCE
-LTP_CHECK_CC_WARN_OLDSTYLE
-LTP_CHECK_MKDTEMP
+# custom functions
+LTP_CHECK_ACL_SUPPORT
+LTP_CHECK_ATOMIC_MEMORY_MODEL
+LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_CAPABILITY_SUPPORT
+LTP_CHECK_CC_WARN_OLDSTYLE
+LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_CRYPTO
+LTP_CHECK_FIDEDUPE
+LTP_CHECK_FORTIFY_SOURCE
+LTP_CHECK_FS_IOC_FLAGS
+LTP_CHECK_FTS_H
+LTP_CHECK_IF_LINK
+LTP_CHECK_IOVEC
+LTP_CHECK_KCMP_TYPE
+LTP_CHECK_KERNEL_DEVEL
+LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LINUX_PTRACE
+LTP_CHECK_LINUXRANDOM
+LTP_CHECK_MADVISE
+LTP_CHECK_MKDTEMP
+LTP_CHECK_MMSGHDR
+LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_NOMMU_LINUX
+LTP_CHECK_PERF_EVENT
 LTP_CHECK_PRCTL_SUPPORT
+LTP_CHECK_RLIMIT64
 LTP_CHECK_SECUREBITS
 LTP_CHECK_SELINUX
 LTP_CHECK_SIGNAL
+LTP_CHECK_STATX
+LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_SYSCALL_EVENTFD
+LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_MODIFY_LDT
+
+if test "x$with_numa" = xyes; then
+	LTP_CHECK_SYSCALL_NUMA
+	numa_error_msg="test requires libnuma >= 2 and it's development packages"
+else
+	numa_error_msg="NUMA support was disabled during build"
+fi
+AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
+
+LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
 LTP_CHECK_TIME
-LTP_CHECK_MADVISE
-LTP_CHECK_ACL_SUPPORT
-LTP_CHECK_FS_IOC_FLAGS
-LTP_CHECK_MREMAP_FIXED
-LTP_CHECK_KERNEL_DEVEL
-LTP_CHECK_XFS_QUOTACTL
-LTP_CHECK_CLONE_SUPPORTS_7_ARGS
-LTP_CHECK_STATX
-LTP_CHECK_SYSCALL_FCNTL
-LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
-if test "x$with_tirpc" = xyes; then
-LTP_CHECK_TIRPC
-fi
 LTP_CHECK_TIMERFD
-LTP_CHECK_IOVEC
-LTP_CHECK_LINUXRANDOM
-LTP_CHECK_IF_LINK
-LTP_CHECK_KCMP_TYPE
-LTP_CHECK_KEYUTILS_SUPPORT
-LTP_CHECK_SYNC_ADD_AND_FETCH
-LTP_CHECK_BUILTIN_CLEAR_CACHE
-LTP_CHECK_MMSGHDR
+test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
+LTP_CHECK_TPACKET_V3
 LTP_CHECK_UNAME_DOMAINNAME
+LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_X_TABLES
-LTP_CHECK_ATOMIC_MEMORY_MODEL
-LTP_CHECK_TPACKET_V3
-LTP_CHECK_RLIMIT64
 LTP_DETECT_HOST_CPU
-LTP_CHECK_PERF_EVENT
-LTP_CHECK_FTS_H
-LTP_CHECK_FIDEDUPE
-
-if test "x$with_numa" = xyes; then
-	LTP_CHECK_SYSCALL_NUMA
-	numa_error_msg="test requires libnuma >= 2 and it's development packages"
-else
-	numa_error_msg="NUMA support was disabled during build"
-fi
-AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
 
 AC_OUTPUT
-- 
2.20.1

