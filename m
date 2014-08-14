Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XHqRC-0000PC-5d
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 08:31:10 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHqR8-0001hO-WC
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 08:31:09 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s7E8V0Jk015586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Aug 2014 08:31:01 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s7E8UxLC029912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Aug 2014 08:31:00 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s7E8Uxge029881
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Aug 2014 08:30:59 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Aug 2014 12:30:51 +0400
Message-Id: <1408005051-22700-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] sparc64 syscall definitions' fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

1. Changed '__sparc64__' to 'defined(__sparc__) && defined(__arch64__)'
2. Removed non-implemented syscall numbers from sparc64.in (in accordance
   to linux-stable/arch/sparc/include/uapi/asm/unistd.h)
2. Re-executed regen.sh

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Hi!

I forgot to send it with earlier "SPARC fixes" series.

I will be more than happy, if it gets reviewed before the forthcoming release.

Thanks.

 testcases/kernel/include/linux_syscall_numbers.h |   76 +---------------------
 testcases/kernel/include/regen.sh                |    6 ++-
 testcases/kernel/include/sparc64.in              |   24 -------
 3 files changed, 7 insertions(+), 99 deletions(-)

diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 03664ce..332cddd 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -8880,7 +8880,7 @@
 #endif
 
 
-#ifdef __sparc64__
+#if defined(__sparc__) && defined(__arch64__)
 # ifndef __NR_restart_syscall
 #  define __NR_restart_syscall 0
 # endif
@@ -8974,21 +8974,12 @@
 # ifndef __NR_utime
 #  define __NR_utime 30
 # endif
-# ifndef __NR_lchown32
-#  define __NR_lchown32 31
-# endif
-# ifndef __NR_fchown32
-#  define __NR_fchown32 32
-# endif
 # ifndef __NR_access
 #  define __NR_access 33
 # endif
 # ifndef __NR_nice
 #  define __NR_nice 34
 # endif
-# ifndef __NR_chown32
-#  define __NR_chown32 35
-# endif
 # ifndef __NR_sync
 #  define __NR_sync 36
 # endif
@@ -9013,9 +9004,6 @@
 # ifndef __NR_times
 #  define __NR_times 43
 # endif
-# ifndef __NR_getuid32
-#  define __NR_getuid32 44
-# endif
 # ifndef __NR_umount2
 #  define __NR_umount2 45
 # endif
@@ -9037,9 +9025,6 @@
 # ifndef __NR_acct
 #  define __NR_acct 51
 # endif
-# ifndef __NR_getgid32
-#  define __NR_getgid32 53
-# endif
 # ifndef __NR_memory_ordering
 #  define __NR_memory_ordering 52
 # endif
@@ -9088,18 +9073,9 @@
 # ifndef __NR_pwrite64
 #  define __NR_pwrite64 68
 # endif
-# ifndef __NR_geteuid32
-#  define __NR_geteuid32 69
-# endif
-# ifndef __NR_getegid32
-#  define __NR_getegid32 70
-# endif
 # ifndef __NR_mmap
 #  define __NR_mmap 71
 # endif
-# ifndef __NR_setreuid32
-#  define __NR_setreuid32 72
-# endif
 # ifndef __NR_munmap
 #  define __NR_munmap 73
 # endif
@@ -9112,9 +9088,6 @@
 # ifndef __NR_vhangup
 #  define __NR_vhangup 76
 # endif
-# ifndef __NR_truncate64
-#  define __NR_truncate64 77
-# endif
 # ifndef __NR_mincore
 #  define __NR_mincore 78
 # endif
@@ -9127,45 +9100,27 @@
 # ifndef __NR_getpgrp
 #  define __NR_getpgrp 81
 # endif
-# ifndef __NR_setgroups32
-#  define __NR_setgroups32 82
-# endif
 # ifndef __NR_setitimer
 #  define __NR_setitimer 83
 # endif
-# ifndef __NR_ftruncate64
-#  define __NR_ftruncate64 84
-# endif
 # ifndef __NR_swapon
 #  define __NR_swapon 85
 # endif
 # ifndef __NR_getitimer
 #  define __NR_getitimer 86
 # endif
-# ifndef __NR_setuid32
-#  define __NR_setuid32 87
-# endif
 # ifndef __NR_sethostname
 #  define __NR_sethostname 88
 # endif
-# ifndef __NR_setgid32
-#  define __NR_setgid32 89
-# endif
 # ifndef __NR_dup2
 #  define __NR_dup2 90
 # endif
-# ifndef __NR_setfsuid32
-#  define __NR_setfsuid32 91
-# endif
 # ifndef __NR_fcntl
 #  define __NR_fcntl 92
 # endif
 # ifndef __NR_select
 #  define __NR_select 93
 # endif
-# ifndef __NR_setfsgid32
-#  define __NR_setfsgid32 94
-# endif
 # ifndef __NR_fsync
 #  define __NR_fsync 95
 # endif
@@ -9205,21 +9160,6 @@
 # ifndef __NR_rt_sigsuspend
 #  define __NR_rt_sigsuspend 107
 # endif
-# ifndef __NR_setresuid32
-#  define __NR_setresuid32 108
-# endif
-# ifndef __NR_getresuid32
-#  define __NR_getresuid32 109
-# endif
-# ifndef __NR_setresgid32
-#  define __NR_setresgid32 110
-# endif
-# ifndef __NR_getresgid32
-#  define __NR_getresgid32 111
-# endif
-# ifndef __NR_setregid32
-#  define __NR_setregid32 112
-# endif
 # ifndef __NR_setresuid
 #  define __NR_setresuid 108
 # endif
@@ -9238,9 +9178,6 @@
 # ifndef __NR_sendmsg
 #  define __NR_sendmsg 114
 # endif
-# ifndef __NR_getgroups32
-#  define __NR_getgroups32 115
-# endif
 # ifndef __NR_gettimeofday
 #  define __NR_gettimeofday 116
 # endif
@@ -9358,9 +9295,6 @@
 # ifndef __NR_getdents64
 #  define __NR_getdents64 154
 # endif
-# ifndef __NR_fcntl64
-#  define __NR_fcntl64 155
-# endif
 # ifndef __NR_inotify_rm_watch
 #  define __NR_inotify_rm_watch 156
 # endif
@@ -9583,12 +9517,6 @@
 # ifndef __NR_setfsgid
 #  define __NR_setfsgid 229
 # endif
-# ifndef __NR_time
-#  define __NR_time 231
-# endif
-# ifndef __NR_time
-#  define __NR_time 231
-# endif
 # ifndef __NR_splice
 #  define __NR_splice 232
 # endif
@@ -9883,7 +9811,7 @@
 #endif
 
 
-#ifdef __sparc__
+#if defined(__sparc__) && !defined(__arch64__)
 # ifndef __NR_restart_syscall
 #  define __NR_restart_syscall 0
 # endif
diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index 3e9f0e7..c01bf1a 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -59,7 +59,11 @@ for arch in $(cat "${srcdir}/order") ; do
 
 	(
 	echo
-	echo "#ifdef __${arch}__"
+	case ${arch} in
+		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
+		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
+		*) echo "#ifdef __${arch}__" ;;
+	esac
 	while read line ; do
 		set -- ${line}
 		nr="__NR_$1"
diff --git a/testcases/kernel/include/sparc64.in b/testcases/kernel/include/sparc64.in
index 697378f..83c1792 100644
--- a/testcases/kernel/include/sparc64.in
+++ b/testcases/kernel/include/sparc64.in
@@ -29,11 +29,8 @@ alarm 27
 sigaltstack 28
 pause 29
 utime 30
-lchown32 31
-fchown32 32
 access 33
 nice 34
-chown32 35
 sync 36
 kill 37
 stat 38
@@ -42,7 +39,6 @@ lstat 40
 dup 41
 pipe 42
 times 43
-getuid32 44
 umount2 45
 setgid 46
 getgid 47
@@ -50,7 +46,6 @@ signal 48
 geteuid 49
 getegid 50
 acct 51
-getgid32 53
 memory_ordering 52
 ioctl 54
 reboot 55
@@ -67,32 +62,22 @@ msync 65
 vfork 66
 pread64 67
 pwrite64 68
-geteuid32 69
-getegid32 70
 mmap 71
-setreuid32 72
 munmap 73
 mprotect 74
 madvise 75
 vhangup 76
-truncate64 77
 mincore 78
 getgroups 79
 setgroups 80
 getpgrp 81
-setgroups32 82
 setitimer 83
-ftruncate64 84
 swapon 85
 getitimer 86
-setuid32 87
 sethostname 88
-setgid32 89
 dup2 90
-setfsuid32 91
 fcntl 92
 select 93
-setfsgid32 94
 fsync 95
 setpriority 96
 socket 97
@@ -106,18 +91,12 @@ rt_sigpending 104
 rt_sigtimedwait 105
 rt_sigqueueinfo 106
 rt_sigsuspend 107
-setresuid32 108
-getresuid32 109
-setresgid32 110
-getresgid32 111
-setregid32 112
 setresuid 108
 getresuid 109
 setresgid 110
 getresgid 111
 recvmsg 113
 sendmsg 114
-getgroups32 115
 gettimeofday 116
 getrusage 117
 getsockopt 118
@@ -157,7 +136,6 @@ inotify_init 151
 inotify_add_watch 152
 poll 153
 getdents64 154
-fcntl64 155
 inotify_rm_watch 156
 statfs 157
 fstatfs 158
@@ -232,8 +210,6 @@ sysfs 226
 afs_syscall 227
 setfsuid 228
 setfsgid 229
-time 231
-time 231
 splice 232
 stime 233
 statfs64 234
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
