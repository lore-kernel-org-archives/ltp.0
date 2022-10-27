Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E85ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 16:38:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E1CD3CA8DB
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 18:38:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F1403CA8A6
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 18:38:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id A9B8B1A010F7
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 18:38:19 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B314D6E
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 09:38:24 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.4.207])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 522EE3F7B4
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 09:38:17 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Oct 2022 17:36:54 +0100
Message-Id: <20221027163654.414017-2-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027163654.414017-1-teo.coupriediaz@arm.com>
References: <20221027163654.414017-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] regen.sh: Use intptr_t for tst_syscall return
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some syscalls directly return pointers, like brk or mmap. int is currently
used for the return value in tst_syscall but is not large enough
to guarantee that such a returned value will fit.
Instead, use intptr_t which is guaranted to be castable to (void *)
without loss of data.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
 include/lapi/syscalls/regen.sh |   2 +-
 runtest/check_tst_syscall      | 190 +++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 runtest/check_tst_syscall

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 3bf38fd03..97027e2f3 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -48,7 +48,7 @@ cat << EOF > "${output_pid}"
 #endif
 
 #define tst_syscall(NR, ...) ({ \\
-	int tst_ret; \\
+	intptr_t tst_ret; \\
 	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
 		errno = ENOSYS; \\
 		tst_ret = -1; \\
diff --git a/runtest/check_tst_syscall b/runtest/check_tst_syscall
new file mode 100644
index 000000000..7a6003593
--- /dev/null
+++ b/runtest/check_tst_syscall
@@ -0,0 +1,190 @@
+cve-2015-3290 cve-2015-3290
+cve-2016-10044 cve-2016-10044
+cve-2016-7117 cve-2016-7117
+clock_settime03 clock_settime03
+accept4_01 accept4_01
+stime_var stime_var
+rt_sigprocmask02 rt_sigprocmask02
+rt_sigprocmask01 rt_sigprocmask01
+pwritev pwritev
+perf_event_open01 perf_event_open01
+perf_event_open perf_event_open
+capset03 capset03
+capset04 capset04
+capset01 capset01
+capset02 capset02
+readahead02 readahead02
+readahead01 readahead01
+io_submit02 io_submit02
+io_submit02 io_submit02
+io_submit03 io_submit03
+io_submit03 io_submit03
+clock_adjtime clock_adjtime
+getrusage02 getrusage02
+faccessat01 faccessat01
+timer_delete01 timer_delete01
+timer_delete02 timer_delete02
+rt_sigsuspend01 rt_sigsuspend01
+renameat2 renameat2
+ppoll01 ppoll01
+connect01 connect01
+semop semop
+msgctl04 msgctl04
+semctl03 semctl03
+semctl09 semctl09
+shmctl02 shmctl02
+shmctl05 shmctl05
+migrate_pages01 migrate_pages01
+migrate_pages03 migrate_pages03
+migrate_pages02 migrate_pages02
+tkill02 tkill02
+tkill02 tkill02
+tkill01 tkill01
+tkill01 tkill01
+capget01 capget01
+capget02 capget02
+pkey pkey
+clone09 clone09
+clone08 clone08
+gettimeofday01 gettimeofday01
+gettimeofday02 gettimeofday02
+signalfd01 signalfd01
+futimesat01 futimesat01
+vhangup02 vhangup02
+vhangup01 vhangup01
+sched_setaffinity01 sched_setaffinity01
+setdomainname setdomainname
+fchownat fchownat
+timer_settime01 timer_settime01
+timer_settime02 timer_settime02
+readdir21 readdir21
+mlock202 mlock202
+mlock201 mlock201
+mlock203 mlock203
+timerfd03 timerfd03
+timerfd02 timerfd02
+compat_tst_16 compat_tst_16
+compat_16 compat_16
+sigpending02 sigpending02
+signalfd4_02 signalfd4_02
+signalfd4_01 signalfd4_01
+inotify_init1_01 inotify_init1_01
+inotify_init1_02 inotify_init1_02
+inotify_init1_01 inotify_init1_01
+inotify_init1_02 inotify_init1_02
+memfd_create_common memfd_create_common
+getcpu01 getcpu01
+tgkill tgkill
+sysctl03 sysctl03
+sysctl01 sysctl01
+sysctl04 sysctl04
+get_robust_list01 get_robust_list01
+sendmmsg_var sendmmsg_var
+copy_file_range copy_file_range
+rt_sigqueueinfo rt_sigqueueinfo
+rt_sigqueueinfo01 rt_sigqueueinfo01
+setns02 setns02
+setns01 setns01
+mprotect01 mprotect01
+delete_module02 delete_module02
+delete_module03 delete_module03
+delete_module01 delete_module01
+sched_get_priority_max02 sched_get_priority_max02
+sched_get_priority_max01 sched_get_priority_max01
+sched_get_priority_max02 sched_get_priority_max02
+mknodat mknodat
+mknodat02 mknodat02
+utimensat01 utimensat01
+syslog12 syslog12
+syslog11 syslog11
+inotify inotify
+preadv preadv
+sync_file_range01 sync_file_range01
+eventfd01 eventfd01
+sched_get_priority_min02 sched_get_priority_min02
+sched_get_priority_min01 sched_get_priority_min01
+sched_get_priority_min02 sched_get_priority_min02
+fstatat01 fstatat01
+adjtimex02 adjtimex02
+sgetmask01 sgetmask01
+setitimer02 setitimer02
+timer_getoverrun01 timer_getoverrun01
+io_cancel01 io_cancel01
+io_cancel01 io_cancel01
+exit_group01 exit_group01
+timer_create02 timer_create02
+io_getevents01 io_getevents01
+fork05 fork05
+fcntl_common fcntl_common
+fcntl31 fcntl31
+timer_gettime01 timer_gettime01
+membarrier01 membarrier01
+set_thread_area01 set_thread_area01
+swapon01 swapon01
+swapon02 swapon02
+swapon03 swapon03
+ssetmask01 ssetmask01
+eventfd2_02 eventfd2_02
+eventfd2_01 eventfd2_01
+eventfd2_03 eventfd2_03
+request_key05 request_key05
+epoll_create epoll_create
+openat openat
+remap_file_pages02 remap_file_pages02
+io_setup02 io_setup02
+io_setup02 io_setup02
+rt_sigtimedwait01 rt_sigtimedwait01
+linkat02 linkat02
+linkat01 linkat01
+cacheflush01 cacheflush01
+getdents getdents
+epoll_create1_01 epoll_create1_01
+epoll_create1_02 epoll_create1_02
+fchmodat01 fchmodat01
+userfaultfd01 userfaultfd01
+symlinkat01 symlinkat01
+socketcall02 socketcall02
+socketcall03 socketcall03
+socketcall01 socketcall01
+sysfs03 sysfs03
+sysfs04 sysfs04
+sysfs05 sysfs05
+sysfs02 sysfs02
+sysfs01 sysfs01
+select_var select_var
+newuname01 newuname01
+process_vm_readv02 process_vm_readv02
+process_vm_writev02 process_vm_writev02
+process_vm_readv03 process_vm_readv03
+process_vm_writev02 process_vm_writev02
+process_vm_readv01 process_vm01 -r
+process_vm_writev01 process_vm01 -w
+io_destroy02 io_destroy02
+getrandom04 getrandom04
+getrandom03 getrandom03
+getrandom01 getrandom01
+getrandom02 getrandom02
+swapoff02 swapoff02
+swapoff01 swapoff01
+futex2test futex2test
+ioprio ioprio
+getitimer02 getitimer02
+set_tid_address01 set_tid_address01
+getrlimit03 getrlimit03
+ustat01 ustat01
+ustat02 ustat02
+prctl04 prctl04
+prctl05 prctl05
+libclone libclone
+userns04 userns04
+userns04 userns04
+pidns30 pidns30
+pidns31 pidns31
+pidns13 pidns13
+mqns_04 mqns_04
+mqns_02 mqns_02
+mqns_01 mqns_01
+mqns_03 mqns_03
+kmsg01 kmsg01
+pt_test pt_test
+libcpuset libcpuset
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
