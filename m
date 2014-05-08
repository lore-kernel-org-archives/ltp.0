Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WiKIA-0003Mz-W9
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:03 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WiKIA-00059a-1J
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:02 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4896tCr005886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:56 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4896tL1019009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:55 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4896t9D003089
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:55 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  8 May 2014 13:06:42 +0400
Message-Id: <1399540004-14742-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/4] linux syscall numbers: removed unimplemented
	syscalls for sparc64
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

In accordance with arch/sparc/include/uapi/asm/unistd.h syscalls
with names containing '32' are not defined for sparc64.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/include/linux_syscall_numbers.h |   57 ----------------------
 testcases/kernel/include/sparc64.in              |   19 -------
 2 files changed, 0 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index a43f7ca..60caaf1 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
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
@@ -9127,9 +9103,6 @@
 # ifndef __NR_getpgrp
 #  define __NR_getpgrp 81
 # endif
-# ifndef __NR_setgroups32
-#  define __NR_setgroups32 82
-# endif
 # ifndef __NR_setitimer
 #  define __NR_setitimer 83
 # endif
@@ -9142,30 +9115,18 @@
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
@@ -9205,21 +9166,6 @@
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
@@ -9238,9 +9184,6 @@
 # ifndef __NR_sendmsg
 #  define __NR_sendmsg 114
 # endif
-# ifndef __NR_getgroups32
-#  define __NR_getgroups32 115
-# endif
 # ifndef __NR_gettimeofday
 #  define __NR_gettimeofday 116
 # endif
diff --git a/testcases/kernel/include/sparc64.in b/testcases/kernel/include/sparc64.in
index 697378f..e79ba95 100644
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
@@ -67,10 +62,7 @@ msync 65
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
@@ -80,19 +72,14 @@ mincore 78
 getgroups 79
 setgroups 80
 getpgrp 81
-setgroups32 82
 setitimer 83
 ftruncate64 84
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
@@ -106,18 +93,12 @@ rt_sigpending 104
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
-- 
1.7.1


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
