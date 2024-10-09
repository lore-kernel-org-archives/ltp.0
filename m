Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27505CEFC5D
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 09:47:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FB0A3C274A
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:47:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17D503C279C
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:45:40 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EE96600972
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:45:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D02D81FB93
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728467128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DJjjffejymW8pq1NWHXTZFvu5z3voWMu/FbF/LATD0=;
 b=V9PoiRENb/IoGmgnpH/1OhHQDSSoiI0Cn/JR+fn1dBPhhnF9NoQNhT9PMxk+Iv56//C3jJ
 do3eP4xjM7nFuVZ7GjjoQOG6dS816xOvlaa5aCq2IzAi11ZZLIN4wSieLeHnPO2HKTkWqc
 A5wEf+iXio1ZGEaheVyD9Big5vzTJM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728467128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DJjjffejymW8pq1NWHXTZFvu5z3voWMu/FbF/LATD0=;
 b=Pn8VOFF/+LAsCB4eOcV7Be/3MxD8RKZqeAsMjyKObymlmPo7qX4QAlQywdnJhITLdODjpT
 klq1XA0gCVg5urCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728467128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DJjjffejymW8pq1NWHXTZFvu5z3voWMu/FbF/LATD0=;
 b=V9PoiRENb/IoGmgnpH/1OhHQDSSoiI0Cn/JR+fn1dBPhhnF9NoQNhT9PMxk+Iv56//C3jJ
 do3eP4xjM7nFuVZ7GjjoQOG6dS816xOvlaa5aCq2IzAi11ZZLIN4wSieLeHnPO2HKTkWqc
 A5wEf+iXio1ZGEaheVyD9Big5vzTJM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728467128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DJjjffejymW8pq1NWHXTZFvu5z3voWMu/FbF/LATD0=;
 b=Pn8VOFF/+LAsCB4eOcV7Be/3MxD8RKZqeAsMjyKObymlmPo7qX4QAlQywdnJhITLdODjpT
 klq1XA0gCVg5urCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B1A813A58
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 09:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8I/SDLhQBmfRZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 09:45:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 11:45:19 +0200
MIME-Version: 1.0
Message-Id: <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728467126; l=50470;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=aiTUtjvgXqeeAiURKzhvL3sfaEOLiLA8cp1C5YOHdWM=;
 b=GwFPiJfmkVwxuuJaPw2/K9wYFzueMMmbTAT5wGePPbM9zGRNFyyGxH4NCu+IE0boG1vHkvw1D
 7LCZgkncfkEDnGXSQIjT31dKaM2Y1e69Jli+CQjjll8jMcTeKSrvKLc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] Update syscalls files
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Update syscalls .in files to the newest kernel development branch at
commit 75b607fab38d.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/arc.in         |  41 +-
 include/lapi/syscalls/arm.in         | 819 ++++++++++++++++++-----------------
 include/lapi/syscalls/arm64.in       |  18 +-
 include/lapi/syscalls/i386.in        |  18 +-
 include/lapi/syscalls/ia64.in        |  10 +-
 include/lapi/syscalls/loongarch64.in |  16 +-
 include/lapi/syscalls/mips64.in      |  13 +-
 include/lapi/syscalls/mips64n32.in   |  13 +-
 include/lapi/syscalls/mipso32.in     |  19 +-
 include/lapi/syscalls/parisc.in      | 373 +++++++++++++++-
 include/lapi/syscalls/powerpc.in     |  19 +-
 include/lapi/syscalls/powerpc64.in   |  47 +-
 include/lapi/syscalls/s390.in        |  15 +-
 include/lapi/syscalls/s390x.in       |  15 +-
 include/lapi/syscalls/sh.in          |  15 +-
 include/lapi/syscalls/sparc.in       |  14 +-
 include/lapi/syscalls/sparc64.in     |  16 +-
 include/lapi/syscalls/x86_64.in      |  51 +--
 18 files changed, 989 insertions(+), 543 deletions(-)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 752cc54fd..f680d4119 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -23,7 +23,7 @@ epoll_ctl 21
 epoll_pwait 22
 dup 23
 dup3 24
-fcntl 25
+fcntl64 25
 inotify_init1 26
 inotify_add_watch 27
 inotify_rm_watch 28
@@ -41,10 +41,10 @@ umount2 39
 mount 40
 pivot_root 41
 nfsservctl 42
-statfs 43
-fstatfs 44
-truncate 45
-ftruncate 46
+statfs64 43
+fstatfs64 44
+truncate64 45
+ftruncate64 46
 fallocate 47
 faccessat 48
 chdir 49
@@ -60,7 +60,7 @@ vhangup 58
 pipe2 59
 quotactl 60
 getdents64 61
-lseek 62
+llseek 62
 read 63
 write 64
 readv 65
@@ -69,7 +69,7 @@ pread64 67
 pwrite64 68
 preadv 69
 pwritev 70
-sendfile 71
+sendfile64 71
 pselect6 72
 ppoll 73
 signalfd4 74
@@ -77,12 +77,11 @@ vmsplice 75
 splice 76
 tee 77
 readlinkat 78
-fstatat 79
-fstat 80
+fstatat64 79
+fstat64 80
 sync 81
 fsync 82
 fdatasync 83
-sync_file_range2 84
 sync_file_range 84
 timerfd_create 85
 timerfd_settime 86
@@ -221,8 +220,8 @@ request_key 218
 keyctl 219
 clone 220
 execve 221
-mmap 222
-fadvise64 223
+mmap2 222
+fadvise64_64 223
 swapon 224
 swapoff 225
 mprotect 226
@@ -261,6 +260,11 @@ sendmmsg 269
 process_vm_readv 270
 process_vm_writev 271
 kcmp 272
+finit_module 273
+sched_setattr 274
+sched_getattr 275
+renameat2 276
+seccomp 277
 getrandom 278
 memfd_create 279
 bpf 280
@@ -314,12 +318,25 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 84203ca4d..32e48b215 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -1,404 +1,415 @@
-restart_syscall (__NR_SYSCALL_BASE+  0)
-exit (__NR_SYSCALL_BASE+  1)
-fork (__NR_SYSCALL_BASE+  2)
-read (__NR_SYSCALL_BASE+  3)
-write (__NR_SYSCALL_BASE+  4)
-open (__NR_SYSCALL_BASE+  5)
-close (__NR_SYSCALL_BASE+  6)
-creat (__NR_SYSCALL_BASE+  8)
-link (__NR_SYSCALL_BASE+  9)
-unlink (__NR_SYSCALL_BASE+ 10)
-execve (__NR_SYSCALL_BASE+ 11)
-chdir (__NR_SYSCALL_BASE+ 12)
-mknod (__NR_SYSCALL_BASE+ 14)
-chmod (__NR_SYSCALL_BASE+ 15)
-lchown (__NR_SYSCALL_BASE+ 16)
-lseek (__NR_SYSCALL_BASE+ 19)
-getpid (__NR_SYSCALL_BASE+ 20)
-mount (__NR_SYSCALL_BASE+ 21)
-setuid (__NR_SYSCALL_BASE+ 23)
-getuid (__NR_SYSCALL_BASE+ 24)
-ptrace (__NR_SYSCALL_BASE+ 26)
-pause (__NR_SYSCALL_BASE+ 29)
-access (__NR_SYSCALL_BASE+ 33)
-nice (__NR_SYSCALL_BASE+ 34)
-sync (__NR_SYSCALL_BASE+ 36)
-kill (__NR_SYSCALL_BASE+ 37)
-rename (__NR_SYSCALL_BASE+ 38)
-mkdir (__NR_SYSCALL_BASE+ 39)
-rmdir (__NR_SYSCALL_BASE+ 40)
-dup (__NR_SYSCALL_BASE+ 41)
-pipe (__NR_SYSCALL_BASE+ 42)
-times (__NR_SYSCALL_BASE+ 43)
-brk (__NR_SYSCALL_BASE+ 45)
-setgid (__NR_SYSCALL_BASE+ 46)
-getgid (__NR_SYSCALL_BASE+ 47)
-geteuid (__NR_SYSCALL_BASE+ 49)
-getegid (__NR_SYSCALL_BASE+ 50)
-acct (__NR_SYSCALL_BASE+ 51)
-umount2 (__NR_SYSCALL_BASE+ 52)
-ioctl (__NR_SYSCALL_BASE+ 54)
-fcntl (__NR_SYSCALL_BASE+ 55)
-setpgid (__NR_SYSCALL_BASE+ 57)
-umask (__NR_SYSCALL_BASE+ 60)
-chroot (__NR_SYSCALL_BASE+ 61)
-ustat (__NR_SYSCALL_BASE+ 62)
-dup2 (__NR_SYSCALL_BASE+ 63)
-getppid (__NR_SYSCALL_BASE+ 64)
-getpgrp (__NR_SYSCALL_BASE+ 65)
-setsid (__NR_SYSCALL_BASE+ 66)
-sigaction (__NR_SYSCALL_BASE+ 67)
-setreuid (__NR_SYSCALL_BASE+ 70)
-setregid (__NR_SYSCALL_BASE+ 71)
-sigsuspend (__NR_SYSCALL_BASE+ 72)
-sigpending (__NR_SYSCALL_BASE+ 73)
-sethostname (__NR_SYSCALL_BASE+ 74)
-setrlimit (__NR_SYSCALL_BASE+ 75)
-getrusage (__NR_SYSCALL_BASE+ 77)
-gettimeofday (__NR_SYSCALL_BASE+ 78)
-settimeofday (__NR_SYSCALL_BASE+ 79)
-getgroups (__NR_SYSCALL_BASE+ 80)
-setgroups (__NR_SYSCALL_BASE+ 81)
-symlink (__NR_SYSCALL_BASE+ 83)
-readlink (__NR_SYSCALL_BASE+ 85)
-uselib (__NR_SYSCALL_BASE+ 86)
-swapon (__NR_SYSCALL_BASE+ 87)
-reboot (__NR_SYSCALL_BASE+ 88)
-munmap (__NR_SYSCALL_BASE+ 91)
-truncate (__NR_SYSCALL_BASE+ 92)
-ftruncate (__NR_SYSCALL_BASE+ 93)
-fchmod (__NR_SYSCALL_BASE+ 94)
-fchown (__NR_SYSCALL_BASE+ 95)
-getpriority (__NR_SYSCALL_BASE+ 96)
-setpriority (__NR_SYSCALL_BASE+ 97)
-statfs (__NR_SYSCALL_BASE+ 99)
-fstatfs (__NR_SYSCALL_BASE+100)
-syslog (__NR_SYSCALL_BASE+103)
-setitimer (__NR_SYSCALL_BASE+104)
-getitimer (__NR_SYSCALL_BASE+105)
-stat (__NR_SYSCALL_BASE+106)
-lstat (__NR_SYSCALL_BASE+107)
-fstat (__NR_SYSCALL_BASE+108)
-vhangup (__NR_SYSCALL_BASE+111)
-wait4 (__NR_SYSCALL_BASE+114)
-swapoff (__NR_SYSCALL_BASE+115)
-sysinfo (__NR_SYSCALL_BASE+116)
-fsync (__NR_SYSCALL_BASE+118)
-sigreturn (__NR_SYSCALL_BASE+119)
-clone (__NR_SYSCALL_BASE+120)
-setdomainname (__NR_SYSCALL_BASE+121)
-uname (__NR_SYSCALL_BASE+122)
-adjtimex (__NR_SYSCALL_BASE+124)
-mprotect (__NR_SYSCALL_BASE+125)
-sigprocmask (__NR_SYSCALL_BASE+126)
-init_module (__NR_SYSCALL_BASE+128)
-delete_module (__NR_SYSCALL_BASE+129)
-quotactl (__NR_SYSCALL_BASE+131)
-getpgid (__NR_SYSCALL_BASE+132)
-fchdir (__NR_SYSCALL_BASE+133)
-bdflush (__NR_SYSCALL_BASE+134)
-sysfs (__NR_SYSCALL_BASE+135)
-personality (__NR_SYSCALL_BASE+136)
-setfsuid (__NR_SYSCALL_BASE+138)
-setfsgid (__NR_SYSCALL_BASE+139)
-_llseek (__NR_SYSCALL_BASE+140)
-getdents (__NR_SYSCALL_BASE+141)
-_newselect (__NR_SYSCALL_BASE+142)
-flock (__NR_SYSCALL_BASE+143)
-msync (__NR_SYSCALL_BASE+144)
-readv (__NR_SYSCALL_BASE+145)
-writev (__NR_SYSCALL_BASE+146)
-getsid (__NR_SYSCALL_BASE+147)
-fdatasync (__NR_SYSCALL_BASE+148)
-_sysctl (__NR_SYSCALL_BASE+149)
-mlock (__NR_SYSCALL_BASE+150)
-munlock (__NR_SYSCALL_BASE+151)
-mlockall (__NR_SYSCALL_BASE+152)
-munlockall (__NR_SYSCALL_BASE+153)
-sched_setparam (__NR_SYSCALL_BASE+154)
-sched_getparam (__NR_SYSCALL_BASE+155)
-sched_setscheduler (__NR_SYSCALL_BASE+156)
-sched_getscheduler (__NR_SYSCALL_BASE+157)
-sched_yield (__NR_SYSCALL_BASE+158)
-sched_get_priority_max (__NR_SYSCALL_BASE+159)
-sched_get_priority_min (__NR_SYSCALL_BASE+160)
-sched_rr_get_interval (__NR_SYSCALL_BASE+161)
-nanosleep (__NR_SYSCALL_BASE+162)
-mremap (__NR_SYSCALL_BASE+163)
-setresuid (__NR_SYSCALL_BASE+164)
-getresuid (__NR_SYSCALL_BASE+165)
-poll (__NR_SYSCALL_BASE+168)
-nfsservctl (__NR_SYSCALL_BASE+169)
-setresgid (__NR_SYSCALL_BASE+170)
-getresgid (__NR_SYSCALL_BASE+171)
-prctl (__NR_SYSCALL_BASE+172)
-rt_sigreturn (__NR_SYSCALL_BASE+173)
-rt_sigaction (__NR_SYSCALL_BASE+174)
-rt_sigprocmask (__NR_SYSCALL_BASE+175)
-rt_sigpending (__NR_SYSCALL_BASE+176)
-rt_sigtimedwait (__NR_SYSCALL_BASE+177)
-rt_sigqueueinfo (__NR_SYSCALL_BASE+178)
-rt_sigsuspend (__NR_SYSCALL_BASE+179)
-pread64 (__NR_SYSCALL_BASE+180)
-pwrite64 (__NR_SYSCALL_BASE+181)
-chown (__NR_SYSCALL_BASE+182)
-getcwd (__NR_SYSCALL_BASE+183)
-capget (__NR_SYSCALL_BASE+184)
-capset (__NR_SYSCALL_BASE+185)
-sigaltstack (__NR_SYSCALL_BASE+186)
-sendfile (__NR_SYSCALL_BASE+187)
-vfork (__NR_SYSCALL_BASE+190)
-ugetrlimit (__NR_SYSCALL_BASE+191)
-mmap2 (__NR_SYSCALL_BASE+192)
-truncate64 (__NR_SYSCALL_BASE+193)
-ftruncate64 (__NR_SYSCALL_BASE+194)
-stat64 (__NR_SYSCALL_BASE+195)
-lstat64 (__NR_SYSCALL_BASE+196)
-fstat64 (__NR_SYSCALL_BASE+197)
-lchown32 (__NR_SYSCALL_BASE+198)
-getuid32 (__NR_SYSCALL_BASE+199)
-getgid32 (__NR_SYSCALL_BASE+200)
-geteuid32 (__NR_SYSCALL_BASE+201)
-getegid32 (__NR_SYSCALL_BASE+202)
-setreuid32 (__NR_SYSCALL_BASE+203)
-setregid32 (__NR_SYSCALL_BASE+204)
-getgroups32 (__NR_SYSCALL_BASE+205)
-setgroups32 (__NR_SYSCALL_BASE+206)
-fchown32 (__NR_SYSCALL_BASE+207)
-setresuid32 (__NR_SYSCALL_BASE+208)
-getresuid32 (__NR_SYSCALL_BASE+209)
-setresgid32 (__NR_SYSCALL_BASE+210)
-getresgid32 (__NR_SYSCALL_BASE+211)
-chown32 (__NR_SYSCALL_BASE+212)
-setuid32 (__NR_SYSCALL_BASE+213)
-setgid32 (__NR_SYSCALL_BASE+214)
-setfsuid32 (__NR_SYSCALL_BASE+215)
-setfsgid32 (__NR_SYSCALL_BASE+216)
-getdents64 (__NR_SYSCALL_BASE+217)
-pivot_root (__NR_SYSCALL_BASE+218)
-mincore (__NR_SYSCALL_BASE+219)
-madvise (__NR_SYSCALL_BASE+220)
-fcntl64 (__NR_SYSCALL_BASE+221)
-gettid (__NR_SYSCALL_BASE+224)
-readahead (__NR_SYSCALL_BASE+225)
-setxattr (__NR_SYSCALL_BASE+226)
-lsetxattr (__NR_SYSCALL_BASE+227)
-fsetxattr (__NR_SYSCALL_BASE+228)
-getxattr (__NR_SYSCALL_BASE+229)
-lgetxattr (__NR_SYSCALL_BASE+230)
-fgetxattr (__NR_SYSCALL_BASE+231)
-listxattr (__NR_SYSCALL_BASE+232)
-llistxattr (__NR_SYSCALL_BASE+233)
-flistxattr (__NR_SYSCALL_BASE+234)
-removexattr (__NR_SYSCALL_BASE+235)
-lremovexattr (__NR_SYSCALL_BASE+236)
-fremovexattr (__NR_SYSCALL_BASE+237)
-tkill (__NR_SYSCALL_BASE+238)
-sendfile64 (__NR_SYSCALL_BASE+239)
-futex (__NR_SYSCALL_BASE+240)
-sched_setaffinity (__NR_SYSCALL_BASE+241)
-sched_getaffinity (__NR_SYSCALL_BASE+242)
-io_setup (__NR_SYSCALL_BASE+243)
-io_destroy (__NR_SYSCALL_BASE+244)
-io_getevents (__NR_SYSCALL_BASE+245)
-io_submit (__NR_SYSCALL_BASE+246)
-io_cancel (__NR_SYSCALL_BASE+247)
-exit_group (__NR_SYSCALL_BASE+248)
-lookup_dcookie (__NR_SYSCALL_BASE+249)
-epoll_create (__NR_SYSCALL_BASE+250)
-epoll_ctl (__NR_SYSCALL_BASE+251)
-epoll_wait (__NR_SYSCALL_BASE+252)
-remap_file_pages (__NR_SYSCALL_BASE+253)
-set_tid_address (__NR_SYSCALL_BASE+256)
-timer_create (__NR_SYSCALL_BASE+257)
-timer_settime (__NR_SYSCALL_BASE+258)
-timer_gettime (__NR_SYSCALL_BASE+259)
-timer_getoverrun (__NR_SYSCALL_BASE+260)
-timer_delete (__NR_SYSCALL_BASE+261)
-clock_settime (__NR_SYSCALL_BASE+262)
-clock_gettime (__NR_SYSCALL_BASE+263)
-clock_getres (__NR_SYSCALL_BASE+264)
-clock_nanosleep (__NR_SYSCALL_BASE+265)
-statfs64 (__NR_SYSCALL_BASE+266)
-fstatfs64 (__NR_SYSCALL_BASE+267)
-tgkill (__NR_SYSCALL_BASE+268)
-utimes (__NR_SYSCALL_BASE+269)
-arm_fadvise64_64 (__NR_SYSCALL_BASE+270)
-pciconfig_iobase (__NR_SYSCALL_BASE+271)
-pciconfig_read (__NR_SYSCALL_BASE+272)
-pciconfig_write (__NR_SYSCALL_BASE+273)
-mq_open (__NR_SYSCALL_BASE+274)
-mq_unlink (__NR_SYSCALL_BASE+275)
-mq_timedsend (__NR_SYSCALL_BASE+276)
-mq_timedreceive (__NR_SYSCALL_BASE+277)
-mq_notify (__NR_SYSCALL_BASE+278)
-mq_getsetattr (__NR_SYSCALL_BASE+279)
-waitid (__NR_SYSCALL_BASE+280)
-socket (__NR_SYSCALL_BASE+281)
-bind (__NR_SYSCALL_BASE+282)
-connect (__NR_SYSCALL_BASE+283)
-listen (__NR_SYSCALL_BASE+284)
-accept (__NR_SYSCALL_BASE+285)
-getsockname (__NR_SYSCALL_BASE+286)
-getpeername (__NR_SYSCALL_BASE+287)
-socketpair (__NR_SYSCALL_BASE+288)
-send (__NR_SYSCALL_BASE+289)
-sendto (__NR_SYSCALL_BASE+290)
-recv (__NR_SYSCALL_BASE+291)
-recvfrom (__NR_SYSCALL_BASE+292)
-shutdown (__NR_SYSCALL_BASE+293)
-setsockopt (__NR_SYSCALL_BASE+294)
-getsockopt (__NR_SYSCALL_BASE+295)
-sendmsg (__NR_SYSCALL_BASE+296)
-recvmsg (__NR_SYSCALL_BASE+297)
-semop (__NR_SYSCALL_BASE+298)
-semget (__NR_SYSCALL_BASE+299)
-semctl (__NR_SYSCALL_BASE+300)
-msgsnd (__NR_SYSCALL_BASE+301)
-msgrcv (__NR_SYSCALL_BASE+302)
-msgget (__NR_SYSCALL_BASE+303)
-msgctl (__NR_SYSCALL_BASE+304)
-shmat (__NR_SYSCALL_BASE+305)
-shmdt (__NR_SYSCALL_BASE+306)
-shmget (__NR_SYSCALL_BASE+307)
-shmctl (__NR_SYSCALL_BASE+308)
-add_key (__NR_SYSCALL_BASE+309)
-request_key (__NR_SYSCALL_BASE+310)
-keyctl (__NR_SYSCALL_BASE+311)
-semtimedop (__NR_SYSCALL_BASE+312)
-vserver (__NR_SYSCALL_BASE+313)
-ioprio_set (__NR_SYSCALL_BASE+314)
-ioprio_get (__NR_SYSCALL_BASE+315)
-inotify_init (__NR_SYSCALL_BASE+316)
-inotify_add_watch (__NR_SYSCALL_BASE+317)
-inotify_rm_watch (__NR_SYSCALL_BASE+318)
-mbind (__NR_SYSCALL_BASE+319)
-get_mempolicy (__NR_SYSCALL_BASE+320)
-set_mempolicy (__NR_SYSCALL_BASE+321)
-openat (__NR_SYSCALL_BASE+322)
-mkdirat (__NR_SYSCALL_BASE+323)
-mknodat (__NR_SYSCALL_BASE+324)
-fchownat (__NR_SYSCALL_BASE+325)
-futimesat (__NR_SYSCALL_BASE+326)
-fstatat64 (__NR_SYSCALL_BASE+327)
-unlinkat (__NR_SYSCALL_BASE+328)
-renameat (__NR_SYSCALL_BASE+329)
-linkat (__NR_SYSCALL_BASE+330)
-symlinkat (__NR_SYSCALL_BASE+331)
-readlinkat (__NR_SYSCALL_BASE+332)
-fchmodat (__NR_SYSCALL_BASE+333)
-faccessat (__NR_SYSCALL_BASE+334)
-pselect6 (__NR_SYSCALL_BASE+335)
-ppoll (__NR_SYSCALL_BASE+336)
-unshare (__NR_SYSCALL_BASE+337)
-set_robust_list (__NR_SYSCALL_BASE+338)
-get_robust_list (__NR_SYSCALL_BASE+339)
-splice (__NR_SYSCALL_BASE+340)
-arm_sync_file_range (__NR_SYSCALL_BASE+341)
-sync_file_range2 __NR_arm_sync_file_range
-tee (__NR_SYSCALL_BASE+342)
-vmsplice (__NR_SYSCALL_BASE+343)
-move_pages (__NR_SYSCALL_BASE+344)
-getcpu (__NR_SYSCALL_BASE+345)
-epoll_pwait (__NR_SYSCALL_BASE+346)
-kexec_load (__NR_SYSCALL_BASE+347)
-utimensat (__NR_SYSCALL_BASE+348)
-signalfd (__NR_SYSCALL_BASE+349)
-timerfd_create (__NR_SYSCALL_BASE+350)
-eventfd (__NR_SYSCALL_BASE+351)
-fallocate (__NR_SYSCALL_BASE+352)
-timerfd_settime (__NR_SYSCALL_BASE+353)
-timerfd_gettime (__NR_SYSCALL_BASE+354)
-signalfd4 (__NR_SYSCALL_BASE+355)
-eventfd2 (__NR_SYSCALL_BASE+356)
-epoll_create1 (__NR_SYSCALL_BASE+357)
-dup3 (__NR_SYSCALL_BASE+358)
-pipe2 (__NR_SYSCALL_BASE+359)
-inotify_init1 (__NR_SYSCALL_BASE+360)
-preadv (__NR_SYSCALL_BASE+361)
-pwritev (__NR_SYSCALL_BASE+362)
-rt_tgsigqueueinfo (__NR_SYSCALL_BASE+363)
-perf_event_open (__NR_SYSCALL_BASE+364)
-recvmmsg (__NR_SYSCALL_BASE+365)
-accept4 (__NR_SYSCALL_BASE+366)
-fanotify_init (__NR_SYSCALL_BASE+367)
-fanotify_mark (__NR_SYSCALL_BASE+368)
-prlimit64 (__NR_SYSCALL_BASE+369)
-name_to_handle_at (__NR_SYSCALL_BASE+370)
-open_by_handle_at (__NR_SYSCALL_BASE+371)
-clock_adjtime (__NR_SYSCALL_BASE+372)
-syncfs (__NR_SYSCALL_BASE+373)
-sendmmsg (__NR_SYSCALL_BASE+374)
-setns (__NR_SYSCALL_BASE+375)
-process_vm_readv (__NR_SYSCALL_BASE+376)
-process_vm_writev (__NR_SYSCALL_BASE+377)
-kcmp (__NR_SYSCALL_BASE+378)
-finit_module (__NR_SYSCALL_BASE+379)
-sched_setattr (__NR_SYSCALL_BASE+380)
-sched_getattr (__NR_SYSCALL_BASE+381)
-renameat2 (__NR_SYSCALL_BASE+382)
-seccomp (__NR_SYSCALL_BASE+383)
-getrandom (__NR_SYSCALL_BASE+384)
-memfd_create (__NR_SYSCALL_BASE+385)
-bpf (__NR_SYSCALL_BASE+386)
-execveat (__NR_SYSCALL_BASE+387)
-userfaultfd (__NR_SYSCALL_BASE+388)
-membarrier (__NR_SYSCALL_BASE+389)
-mlock2 (__NR_SYSCALL_BASE+390)
-copy_file_range (__NR_SYSCALL_BASE+391)
-preadv2 (__NR_SYSCALL_BASE+392)
-pwritev2 (__NR_SYSCALL_BASE+393)
-pkey_mprotect (__NR_SYSCALL_BASE+394)
-pkey_alloc (__NR_SYSCALL_BASE+395)
-pkey_free (__NR_SYSCALL_BASE+396)
-statx (__NR_SYSCALL_BASE+397)
-rseq (__NR_SYSCALL_BASE+398)
-io_pgetevents (__NR_SYSCALL_BASE+399)
-migrate_pages (__NR_SYSCALL_BASE+400)
-kexec_file_load (__NR_SYSCALL_BASE+401)
-clock_gettime64 (__NR_SYSCALL_BASE+403)
-clock_settime64 (__NR_SYSCALL_BASE+404)
-clock_adjtime64 (__NR_SYSCALL_BASE+405)
-clock_getres_time64 (__NR_SYSCALL_BASE+406)
-clock_nanosleep_time64 (__NR_SYSCALL_BASE+407)
-timer_gettime64 (__NR_SYSCALL_BASE+408)
-timer_settime64 (__NR_SYSCALL_BASE+409)
-timerfd_gettime64 (__NR_SYSCALL_BASE+410)
-timerfd_settime64 (__NR_SYSCALL_BASE+411)
-utimensat_time64 (__NR_SYSCALL_BASE+412)
-pselect6_time64 (__NR_SYSCALL_BASE+413)
-ppoll_time64 (__NR_SYSCALL_BASE+414)
-io_pgetevents_time64 (__NR_SYSCALL_BASE+416)
-recvmmsg_time64 (__NR_SYSCALL_BASE+417)
-mq_timedsend_time64 (__NR_SYSCALL_BASE+418)
-mq_timedreceive_time64 (__NR_SYSCALL_BASE+419)
-semtimedop_time64 (__NR_SYSCALL_BASE+420)
-rt_sigtimedwait_time64 (__NR_SYSCALL_BASE+421)
-futex_time64 (__NR_SYSCALL_BASE+422)
-sched_rr_get_interval_time64 (__NR_SYSCALL_BASE+423)
-pidfd_send_signal (__NR_SYSCALL_BASE+424)
-io_uring_setup (__NR_SYSCALL_BASE+425)
-io_uring_enter (__NR_SYSCALL_BASE+426)
-io_uring_register (__NR_SYSCALL_BASE+427)
-open_tree (__NR_SYSCALL_BASE+428)
-move_mount (__NR_SYSCALL_BASE+429)
-fsopen (__NR_SYSCALL_BASE+430)
-fsconfig (__NR_SYSCALL_BASE+431)
-fsmount (__NR_SYSCALL_BASE+432)
-fspick (__NR_SYSCALL_BASE+433)
-pidfd_open (__NR_SYSCALL_BASE+434)
-clone3 (__NR_SYSCALL_BASE+435)
-close_range (__NR_SYSCALL_BASE+436)
-openat2 (__NR_SYSCALL_BASE+437)
-pidfd_getfd (__NR_SYSCALL_BASE+438)
-faccessat2 (__NR_SYSCALL_BASE+439)
-epoll_pwait2 (__NR_SYSCALL_BASE+441)
-quotactl_fd (__NR_SYSCALL_BASE+443)
-landlock_create_ruleset (__NR_SYSCALL_BASE+444)
-landlock_add_rule (__NR_SYSCALL_BASE+445)
-landlock_restrict_self (__NR_SYSCALL_BASE+446)
-memfd_secret (__NR_SYSCALL_BASE+447)
-futex_waitv (__NR_SYSCALL_BASE+449)
-cachestat (__NR_SYSCALL_BASE+451)
-fchmodat2 (__NR_SYSCALL_BASE+452)
-mseal (__NR_SYSCALL_BASE+462)
+restart_syscall 0
+exit 1
+fork 2
+read 3
+write 4
+open 5
+close 6
+creat 8
+link 9
+unlink 10
+execve 11
+chdir 12
+mknod 14
+chmod 15
+lchown 16
+lseek 19
+getpid 20
+mount 21
+setuid 23
+getuid 24
+ptrace 26
+pause 29
+access 33
+nice 34
+sync 36
+kill 37
+rename 38
+mkdir 39
+rmdir 40
+dup 41
+pipe 42
+times 43
+brk 45
+setgid 46
+getgid 47
+geteuid 49
+getegid 50
+acct 51
+umount2 52
+ioctl 54
+fcntl 55
+setpgid 57
+umask 60
+chroot 61
+ustat 62
+dup2 63
+getppid 64
+getpgrp 65
+setsid 66
+sigaction 67
+setreuid 70
+setregid 71
+sigsuspend 72
+sigpending 73
+sethostname 74
+setrlimit 75
+getrusage 77
+gettimeofday 78
+settimeofday 79
+getgroups 80
+setgroups 81
+symlink 83
+readlink 85
+uselib 86
+swapon 87
+reboot 88
+munmap 91
+truncate 92
+ftruncate 93
+fchmod 94
+fchown 95
+getpriority 96
+setpriority 97
+statfs 99
+fstatfs 100
+syslog 103
+setitimer 104
+getitimer 105
+stat 106
+lstat 107
+fstat 108
+vhangup 111
+wait4 114
+swapoff 115
+sysinfo 116
+fsync 118
+sigreturn 119
+clone 120
+setdomainname 121
+uname 122
+adjtimex 124
+mprotect 125
+sigprocmask 126
+init_module 128
+delete_module 129
+quotactl 131
+getpgid 132
+fchdir 133
+sysfs 135
+personality 136
+setfsuid 138
+setfsgid 139
+_llseek 140
+getdents 141
+_newselect 142
+flock 143
+msync 144
+readv 145
+writev 146
+getsid 147
+fdatasync 148
+_sysctl 149
+mlock 150
+munlock 151
+mlockall 152
+munlockall 153
+sched_setparam 154
+sched_getparam 155
+sched_setscheduler 156
+sched_getscheduler 157
+sched_yield 158
+sched_get_priority_max 159
+sched_get_priority_min 160
+sched_rr_get_interval 161
+nanosleep 162
+mremap 163
+setresuid 164
+getresuid 165
+poll 168
+nfsservctl 169
+setresgid 170
+getresgid 171
+prctl 172
+rt_sigreturn 173
+rt_sigaction 174
+rt_sigprocmask 175
+rt_sigpending 176
+rt_sigtimedwait 177
+rt_sigqueueinfo 178
+rt_sigsuspend 179
+pread64 180
+pwrite64 181
+chown 182
+getcwd 183
+capget 184
+capset 185
+sigaltstack 186
+sendfile 187
+vfork 190
+ugetrlimit 191
+mmap2 192
+truncate64 193
+ftruncate64 194
+stat64 195
+lstat64 196
+fstat64 197
+lchown32 198
+getuid32 199
+getgid32 200
+geteuid32 201
+getegid32 202
+setreuid32 203
+setregid32 204
+getgroups32 205
+setgroups32 206
+fchown32 207
+setresuid32 208
+getresuid32 209
+setresgid32 210
+getresgid32 211
+chown32 212
+setuid32 213
+setgid32 214
+setfsuid32 215
+setfsgid32 216
+getdents64 217
+pivot_root 218
+mincore 219
+madvise 220
+fcntl64 221
+gettid 224
+readahead 225
+setxattr 226
+lsetxattr 227
+fsetxattr 228
+getxattr 229
+lgetxattr 230
+fgetxattr 231
+listxattr 232
+llistxattr 233
+flistxattr 234
+removexattr 235
+lremovexattr 236
+fremovexattr 237
+tkill 238
+sendfile64 239
+futex 240
+sched_setaffinity 241
+sched_getaffinity 242
+io_setup 243
+io_destroy 244
+io_getevents 245
+io_submit 246
+io_cancel 247
+exit_group 248
+lookup_dcookie 249
+epoll_create 250
+epoll_ctl 251
+epoll_wait 252
+remap_file_pages 253
+set_tid_address 256
+timer_create 257
+timer_settime 258
+timer_gettime 259
+timer_getoverrun 260
+timer_delete 261
+clock_settime 262
+clock_gettime 263
+clock_getres 264
+clock_nanosleep 265
+statfs64 266
+fstatfs64 267
+tgkill 268
+utimes 269
+arm_fadvise64_64 270
+pciconfig_iobase 271
+pciconfig_read 272
+pciconfig_write 273
+mq_open 274
+mq_unlink 275
+mq_timedsend 276
+mq_timedreceive 277
+mq_notify 278
+mq_getsetattr 279
+waitid 280
+socket 281
+bind 282
+connect 283
+listen 284
+accept 285
+getsockname 286
+getpeername 287
+socketpair 288
+send 289
+sendto 290
+recv 291
+recvfrom 292
+shutdown 293
+setsockopt 294
+getsockopt 295
+sendmsg 296
+recvmsg 297
+semop 298
+semget 299
+semctl 300
+msgsnd 301
+msgrcv 302
+msgget 303
+msgctl 304
+shmat 305
+shmdt 306
+shmget 307
+shmctl 308
+add_key 309
+request_key 310
+keyctl 311
+semtimedop 312
+vserver 313
+ioprio_set 314
+ioprio_get 315
+inotify_init 316
+inotify_add_watch 317
+inotify_rm_watch 318
+mbind 319
+get_mempolicy 320
+set_mempolicy 321
+openat 322
+mkdirat 323
+mknodat 324
+fchownat 325
+futimesat 326
+fstatat64 327
+unlinkat 328
+renameat 329
+linkat 330
+symlinkat 331
+readlinkat 332
+fchmodat 333
+faccessat 334
+pselect6 335
+ppoll 336
+unshare 337
+set_robust_list 338
+get_robust_list 339
+splice 340
+arm_sync_file_range 341
+sync_file_range2 341
+tee 342
+vmsplice 343
+move_pages 344
+getcpu 345
+epoll_pwait 346
+kexec_load 347
+utimensat 348
+signalfd 349
+timerfd_create 350
+eventfd 351
+fallocate 352
+timerfd_settime 353
+timerfd_gettime 354
+signalfd4 355
+eventfd2 356
+epoll_create1 357
+dup3 358
+pipe2 359
+inotify_init1 360
+preadv 361
+pwritev 362
+rt_tgsigqueueinfo 363
+perf_event_open 364
+recvmmsg 365
+accept4 366
+fanotify_init 367
+fanotify_mark 368
+prlimit64 369
+name_to_handle_at 370
+open_by_handle_at 371
+clock_adjtime 372
+syncfs 373
+sendmmsg 374
+setns 375
+process_vm_readv 376
+process_vm_writev 377
+kcmp 378
+finit_module 379
+sched_setattr 380
+sched_getattr 381
+renameat2 382
+seccomp 383
+getrandom 384
+memfd_create 385
+bpf 386
+execveat 387
+userfaultfd 388
+membarrier 389
+mlock2 390
+copy_file_range 391
+preadv2 392
+pwritev2 393
+pkey_mprotect 394
+pkey_alloc 395
+pkey_free 396
+statx 397
+rseq 398
+io_pgetevents 399
+migrate_pages 400
+kexec_file_load 401
+clock_gettime64 403
+clock_settime64 404
+clock_adjtime64 405
+clock_getres_time64 406
+clock_nanosleep_time64 407
+timer_gettime64 408
+timer_settime64 409
+timerfd_gettime64 410
+timerfd_settime64 411
+utimensat_time64 412
+pselect6_time64 413
+ppoll_time64 414
+io_pgetevents_time64 416
+recvmmsg_time64 417
+mq_timedsend_time64 418
+mq_timedreceive_time64 419
+semtimedop_time64 420
+rt_sigtimedwait_time64 421
+futex_time64 422
+sched_rr_get_interval_time64 423
+pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
+pidfd_open 434
+clone3 435
+close_range 436
+openat2 437
+pidfd_getfd 438
+faccessat2 439
+process_madvise 440
+epoll_pwait2 441
+mount_setattr 442
+quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
+process_mrelease 448
+futex_waitv 449
+set_mempolicy_home_node 450
+cachestat 451
+fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
+mseal 462
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index 61d4450bf..be7e9df64 100644
--- a/include/lapi/syscalls/arm64.in
+++ b/include/lapi/syscalls/arm64.in
@@ -77,12 +77,11 @@ vmsplice 75
 splice 76
 tee 77
 readlinkat 78
-fstatat 79
+newfstatat 79
 fstat 80
 sync 81
 fsync 82
 fdatasync 83
-sync_file_range2 84
 sync_file_range 84
 timerfd_create 85
 timerfd_settime 86
@@ -294,13 +293,26 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
-_sysctl 1078
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index f6e8c7258..13f72e795 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -111,7 +111,6 @@ olduname 109
 iopl 110
 vhangup 111
 idle 112
-vm86old 113
 wait4 114
 swapoff 115
 sysinfo 116
@@ -132,7 +131,6 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
-bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -164,7 +162,6 @@ nanosleep 162
 mremap 163
 setresuid 164
 getresuid 165
-vm86 166
 query_module 167
 poll 168
 nfsservctl 169
@@ -218,7 +215,6 @@ setfsgid32 216
 pivot_root 217
 mincore 218
 madvise 219
-madvise1 219
 getdents64 220
 fcntl64 221
 gettid 224
@@ -428,12 +424,26 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 8f55029a9..b958d4cd9 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -18,6 +18,7 @@ lseek 1040
 getpid 1041
 getppid 1042
 mount 1043
+umount 1044
 umount2 1044
 setuid 1045
 getuid 1046
@@ -109,7 +110,6 @@ quotactl 1137
 bdflush 1138
 sysfs 1139
 personality 1140
-afs_syscall 1141
 setfsuid 1142
 setfsgid 1143
 getdents 1144
@@ -143,7 +143,6 @@ old_getpagesize 1171
 mmap2 1172
 pciconfig_read 1173
 pciconfig_write 1174
-perfmonctl 1175
 sigaltstack 1176
 rt_sigaction 1177
 rt_sigpending 1178
@@ -157,7 +156,6 @@ capget 1185
 capset 1186
 sendfile 1187
 getpmsg 1188
-putpmsg 1189
 socket 1190
 bind 1191
 connect 1192
@@ -237,7 +235,6 @@ mq_timedreceive 1265
 mq_notify 1266
 mq_getsetattr 1267
 kexec_load 1268
-vserver 1269
 waitid 1270
 add_key 1271
 request_key 1272
@@ -341,12 +338,15 @@ close_range 1460
 openat2 1461
 pidfd_getfd 1462
 faccessat2 1463
+process_madvise 1464
 epoll_pwait2 1465
+mount_setattr 1466
 quotactl_fd 1467
 landlock_create_ruleset 1468
 landlock_add_rule 1469
 landlock_restrict_self 1470
+process_mrelease 1472
 futex_waitv 1473
+set_mempolicy_home_node 1474
 cachestat 1475
 fchmodat2 1476
-mseal 1486
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index 3df354fce..2c1ecd7ae 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -36,7 +36,6 @@ mkdirat 34
 unlinkat 35
 symlinkat 36
 linkat 37
-renameat 38
 umount2 39
 mount 40
 pivot_root 41
@@ -77,12 +76,11 @@ vmsplice 75
 splice 76
 tee 77
 readlinkat 78
-fstatat 79
+newfstatat 79
 fstat 80
 sync 81
 fsync 82
 fdatasync 83
-sync_file_range2 84
 sync_file_range 84
 timerfd_create 85
 timerfd_settime 86
@@ -162,8 +160,6 @@ setgroups 159
 uname 160
 sethostname 161
 setdomainname 162
-getrlimit 163
-setrlimit 164
 getrusage 165
 umask 166
 prctl 167
@@ -301,10 +297,18 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
-memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index c34a85bbe..8be734158 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -175,7 +175,6 @@ nfsservctl 5173
 getpmsg 5174
 putpmsg 5175
 afs_syscall 5176
-reserved177 5177
 gettid 5178
 readahead 5179
 setxattr 5180
@@ -191,7 +190,6 @@ removexattr 5189
 lremovexattr 5190
 fremovexattr 5191
 tkill 5192
-reserved193 5193
 futex 5194
 sched_setaffinity 5195
 sched_getaffinity 5196
@@ -349,7 +347,18 @@ quotactl_fd 5443
 landlock_create_ruleset 5444
 landlock_add_rule 5445
 landlock_restrict_self 5446
+process_mrelease 5448
 futex_waitv 5449
+set_mempolicy_home_node 5450
 cachestat 5451
 fchmodat2 5452
+map_shadow_stack 5453
+futex_wake 5454
+futex_wait 5455
+futex_requeue 5456
+statmount 5457
+listmount 5458
+lsm_get_self_attr 5459
+lsm_set_self_attr 5460
+lsm_list_modules 5461
 mseal 5462
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index d85c567c7..153fe50bf 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -175,7 +175,6 @@ nfsservctl 6173
 getpmsg 6174
 putpmsg 6175
 afs_syscall 6176
-reserved177 6177
 gettid 6178
 readahead 6179
 setxattr 6180
@@ -191,7 +190,6 @@ removexattr 6189
 lremovexattr 6190
 fremovexattr 6191
 tkill 6192
-reserved193 6193
 futex 6194
 sched_setaffinity 6195
 sched_getaffinity 6196
@@ -373,7 +371,18 @@ quotactl_fd 6443
 landlock_create_ruleset 6444
 landlock_add_rule 6445
 landlock_restrict_self 6446
+process_mrelease 6448
 futex_waitv 6449
+set_mempolicy_home_node 6450
 cachestat 6451
 fchmodat2 6452
+map_shadow_stack 6453
+futex_wake 6454
+futex_wait 6455
+futex_requeue 6456
+statmount 6457
+listmount 6458
+lsm_get_self_attr 6459
+lsm_set_self_attr 6460
+lsm_list_modules 6461
 mseal 6462
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 10d77787b..1ed74c1ec 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -16,7 +16,6 @@ mknod 4014
 chmod 4015
 lchown 4016
 break 4017
-unused18 4018
 lseek 4019
 getpid 4020
 mount 4021
@@ -26,7 +25,6 @@ getuid 4024
 stime 4025
 ptrace 4026
 alarm 4027
-unused28 4028
 pause 4029
 utime 4030
 stty 4031
@@ -80,9 +78,7 @@ gettimeofday 4078
 settimeofday 4079
 getgroups 4080
 setgroups 4081
-reserved82 4082
 symlink 4083
-unused84 4084
 readlink 4085
 uselib 4086
 swapon 4087
@@ -111,7 +107,6 @@ unused109 4109
 iopl 4110
 vhangup 4111
 idle 4112
-vm86 4113
 wait4 4114
 swapoff 4115
 sysinfo 4116
@@ -132,7 +127,6 @@ get_kernel_syms 4130
 quotactl 4131
 getpgid 4132
 fchdir 4133
-bdflush 4134
 sysfs 4135
 personality 4136
 afs_syscall 4137
@@ -148,7 +142,6 @@ writev 4146
 cacheflush 4147
 cachectl 4148
 sysmips 4149
-unused150 4150
 getsid 4151
 fdatasync 4152
 _sysctl 4153
@@ -219,7 +212,6 @@ mincore 4217
 madvise 4218
 getdents64 4219
 fcntl64 4220
-reserved221 4221
 gettid 4222
 readahead 4223
 setxattr 4224
@@ -419,7 +411,18 @@ quotactl_fd 4443
 landlock_create_ruleset 4444
 landlock_add_rule 4445
 landlock_restrict_self 4446
+process_mrelease 4448
 futex_waitv 4449
+set_mempolicy_home_node 4450
 cachestat 4451
 fchmodat2 4452
+map_shadow_stack 4453
+futex_wake 4454
+futex_wait 4455
+futex_requeue 4456
+statmount 4457
+listmount 4458
+lsm_get_self_attr 4459
+lsm_set_self_attr 4460
+lsm_list_modules 4461
 mseal 4462
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 8240c69ce..662bfea44 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -1,33 +1,362 @@
+restart_syscall 0
+exit 1
+fork 2
+read 3
+write 4
+open 5
+close 6
+waitpid 7
+creat 8
+link 9
+unlink 10
+execve 11
+chdir 12
+time 13
+mknod 14
+chmod 15
+lchown 16
+socket 17
+stat 18
+lseek 19
+getpid 20
+mount 21
+bind 22
+setuid 23
+getuid 24
+stime 25
+ptrace 26
+alarm 27
+fstat 28
+pause 29
+utime 30
+connect 31
+listen 32
+access 33
+nice 34
+accept 35
+sync 36
+kill 37
+rename 38
+mkdir 39
+rmdir 40
+dup 41
+pipe 42
+times 43
+getsockname 44
+brk 45
+setgid 46
+getgid 47
+signal 48
+geteuid 49
+getegid 50
+acct 51
+umount2 52
+getpeername 53
+ioctl 54
+fcntl 55
+socketpair 56
+setpgid 57
+send 58
+uname 59
+umask 60
+chroot 61
+ustat 62
+dup2 63
+getppid 64
+getpgrp 65
+setsid 66
+pivot_root 67
+sgetmask 68
+ssetmask 69
+setreuid 70
+setregid 71
+mincore 72
+sigpending 73
+sethostname 74
+setrlimit 75
+getrlimit 76
+getrusage 77
+gettimeofday 78
+settimeofday 79
+getgroups 80
+setgroups 81
+sendto 82
+symlink 83
+lstat 84
+readlink 85
+uselib 86
+swapon 87
+reboot 88
+mmap2 89
+mmap 90
+munmap 91
+truncate 92
+ftruncate 93
+fchmod 94
+fchown 95
+getpriority 96
+setpriority 97
+recv 98
+statfs 99
+fstatfs 100
+stat64 101
+syslog 103
+setitimer 104
+getitimer 105
+capget 106
+capset 107
+pread64 108
+pwrite64 109
+getcwd 110
+vhangup 111
+fstat64 112
+vfork 113
+wait4 114
+swapoff 115
+sysinfo 116
+shutdown 117
+fsync 118
+madvise 119
+clone 120
+setdomainname 121
+sendfile 122
+recvfrom 123
+adjtimex 124
+mprotect 125
+sigprocmask 126
+init_module 128
+delete_module 129
+quotactl 131
+getpgid 132
+fchdir 133
+sysfs 135
+personality 136
+setfsuid 138
+setfsgid 139
+_llseek 140
+getdents 141
+_newselect 142
+flock 143
+msync 144
+readv 145
+writev 146
+getsid 147
+fdatasync 148
 _sysctl 149
+mlock 150
+munlock 151
+mlockall 152
+munlockall 153
+sched_setparam 154
+sched_getparam 155
+sched_setscheduler 156
+sched_getscheduler 157
+sched_yield 158
+sched_get_priority_max 159
+sched_get_priority_min 160
+sched_rr_get_interval 161
+nanosleep 162
+mremap 163
+setresuid 164
+getresuid 165
+sigaltstack 166
+poll 168
+setresgid 170
+getresgid 171
+prctl 172
+rt_sigreturn 173
+rt_sigaction 174
+rt_sigprocmask 175
+rt_sigpending 176
+rt_sigtimedwait 177
+rt_sigqueueinfo 178
+rt_sigsuspend 179
+chown 180
+setsockopt 181
+getsockopt 182
+sendmsg 183
+recvmsg 184
+semop 185
+semget 186
+semctl 187
+msgsnd 188
+msgrcv 189
+msgget 190
+msgctl 191
+shmat 192
+shmdt 193
+shmget 194
+shmctl 195
+lstat64 198
+truncate64 199
+ftruncate64 200
+getdents64 201
+fcntl64 202
+gettid 206
+readahead 207
+tkill 208
+sendfile64 209
+futex 210
+sched_setaffinity 211
+sched_getaffinity 212
+io_setup 215
+io_destroy 216
+io_getevents 217
+io_submit 218
+io_cancel 219
+exit_group 222
+lookup_dcookie 223
+epoll_create 224
+epoll_ctl 225
+epoll_wait 226
+remap_file_pages 227
+semtimedop 228
+mq_open 229
+mq_unlink 230
+mq_timedsend 231
+mq_timedreceive 232
+mq_notify 233
+mq_getsetattr 234
+waitid 235
+fadvise64_64 236
+set_tid_address 237
+setxattr 238
+lsetxattr 239
+fsetxattr 240
+getxattr 241
+lgetxattr 242
+fgetxattr 243
+listxattr 244
+llistxattr 245
+flistxattr 246
+removexattr 247
+lremovexattr 248
+fremovexattr 249
+timer_create 250
+timer_settime 251
+timer_gettime 252
+timer_getoverrun 253
+timer_delete 254
+clock_settime 255
+clock_gettime 256
+clock_getres 257
+clock_nanosleep 258
+tgkill 259
+mbind 260
+get_mempolicy 261
+set_mempolicy 262
+add_key 264
+request_key 265
+keyctl 266
+ioprio_set 267
+ioprio_get 268
+inotify_init 269
+inotify_add_watch 270
+inotify_rm_watch 271
+migrate_pages 272
+pselect6 273
+ppoll 274
 openat 275
-mkdirat (__NR_openat + 1)
-mknodat (__NR_openat + 2)
-fchownat (__NR_openat + 3)
-futimesat (__NR_openat + 4)
-newfstatat (__NR_openat + 5)
-fstatat64 (__NR_openat + 5)
-unlinkat (__NR_openat + 6)
-renameat (__NR_openat + 7)
-linkat (__NR_openat + 8)
-symlinkat (__NR_openat + 9)
-readlinkat (__NR_openat + 10)
-fchmodat (__NR_openat + 11)
-faccessat (__NR_openat + 12)
+mkdirat 276
+mknodat 277
+fchownat 278
+futimesat 279
+fstatat64 280
+unlinkat 281
+renameat 282
+linkat 283
+symlinkat 284
+readlinkat 285
+fchmodat 286
+faccessat 287
+unshare 288
+set_robust_list 289
+get_robust_list 290
 splice 291
+sync_file_range 292
 tee 293
 vmsplice 294
+move_pages 295
+getcpu 296
+epoll_pwait 297
+statfs64 298
+fstatfs64 299
+kexec_load 300
+utimensat 301
+signalfd 302
+eventfd 304
+fallocate 305
+timerfd_create 306
+timerfd_settime 307
+timerfd_gettime 308
+signalfd4 309
+eventfd2 310
+epoll_create1 311
+dup3 312
+pipe2 313
+inotify_init1 314
+preadv 315
+pwritev 316
+rt_tgsigqueueinfo 317
+perf_event_open 318
+recvmmsg 319
+accept4 320
+prlimit64 321
+fanotify_init 322
+fanotify_mark 323
+clock_adjtime 324
+name_to_handle_at 325
+open_by_handle_at 326
 syncfs 327
 setns 328
+sendmmsg 329
 process_vm_readv 330
 process_vm_writev 331
+kcmp 332
+finit_module 333
+sched_setattr 334
+sched_getattr 335
+utimes 336
+renameat2 337
+seccomp 338
+getrandom 339
 memfd_create 340
-membarrier 343
+bpf 341
 execveat 342
+membarrier 343
+userfaultfd 344
 mlock2 345
 copy_file_range 346
 preadv2 347
 pwritev2 348
+statx 349
 io_pgetevents 350
+pkey_mprotect 351
+pkey_alloc 352
+pkey_free 353
+rseq 354
+kexec_file_load 355
+cacheflush 356
+clock_gettime64 403
+clock_settime64 404
+clock_adjtime64 405
+clock_getres_time64 406
+clock_nanosleep_time64 407
+timer_gettime64 408
+timer_settime64 409
+timerfd_gettime64 410
+timerfd_settime64 411
+utimensat_time64 412
+pselect6_time64 413
+ppoll_time64 414
+io_pgetevents_time64 416
+recvmmsg_time64 417
+mq_timedsend_time64 418
+mq_timedreceive_time64 419
+semtimedop_time64 420
+rt_sigtimedwait_time64 421
+futex_time64 422
+sched_rr_get_interval_time64 423
 pidfd_send_signal 424
 io_uring_setup 425
 io_uring_enter 426
@@ -39,14 +368,30 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
+openat2 437
+pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index af3ae5c90..faaa75883 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -111,7 +111,6 @@ olduname 109
 iopl 110
 vhangup 111
 idle 112
-vm86 113
 wait4 114
 swapoff 115
 sysinfo 116
@@ -132,7 +131,6 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
-bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -199,7 +197,6 @@ fstat64 197
 pciconfig_read 198
 pciconfig_write 199
 pciconfig_iobase 200
-multiplexer 201
 getdents64 202
 pivot_root 203
 fcntl64 204
@@ -253,7 +250,6 @@ statfs64 252
 fstatfs64 253
 fadvise64_64 254
 rtas 255
-sys_debug_setcontext 256
 migrate_pages 258
 mbind 259
 get_mempolicy 260
@@ -287,7 +283,6 @@ mkdirat 287
 mknodat 288
 fchownat 289
 futimesat 290
-newfstatat 291
 fstatat64 291
 unlinkat 292
 renameat 293
@@ -374,7 +369,6 @@ pkey_free 385
 pkey_mprotect 386
 rseq 387
 io_pgetevents 388
-semtimedop 392
 semget 393
 semctl 394
 shmget 395
@@ -421,12 +415,25 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index af3ae5c90..23b65e784 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -111,7 +111,6 @@ olduname 109
 iopl 110
 vhangup 111
 idle 112
-vm86 113
 wait4 114
 swapoff 115
 sysinfo 116
@@ -132,7 +131,6 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
-bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -190,19 +188,11 @@ putpmsg 188
 vfork 189
 ugetrlimit 190
 readahead 191
-mmap2 192
-truncate64 193
-ftruncate64 194
-stat64 195
-lstat64 196
-fstat64 197
 pciconfig_read 198
 pciconfig_write 199
 pciconfig_iobase 200
-multiplexer 201
 getdents64 202
 pivot_root 203
-fcntl64 204
 madvise 205
 mincore 206
 gettid 207
@@ -223,7 +213,6 @@ futex 221
 sched_setaffinity 222
 sched_getaffinity 223
 tuxcall 225
-sendfile64 226
 io_setup 227
 io_destroy 228
 io_getevents 229
@@ -251,9 +240,7 @@ tgkill 250
 utimes 251
 statfs64 252
 fstatfs64 253
-fadvise64_64 254
 rtas 255
-sys_debug_setcontext 256
 migrate_pages 258
 mbind 259
 get_mempolicy 260
@@ -288,7 +275,6 @@ mknodat 288
 fchownat 289
 futimesat 290
 newfstatat 291
-fstatat64 291
 unlinkat 292
 renameat 293
 linkat 294
@@ -385,26 +371,6 @@ msgget 399
 msgsnd 400
 msgrcv 401
 msgctl 402
-clock_gettime64 403
-clock_settime64 404
-clock_adjtime64 405
-clock_getres_time64 406
-clock_nanosleep_time64 407
-timer_gettime64 408
-timer_settime64 409
-timerfd_gettime64 410
-timerfd_settime64 411
-utimensat_time64 412
-pselect6_time64 413
-ppoll_time64 414
-io_pgetevents_time64 416
-recvmmsg_time64 417
-mq_timedsend_time64 418
-mq_timedreceive_time64 419
-semtimedop_time64 420
-rt_sigtimedwait_time64 421
-futex_time64 422
-sched_rr_get_interval_time64 423
 pidfd_send_signal 424
 io_uring_setup 425
 io_uring_enter 426
@@ -421,12 +387,25 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index e8e7fff0b..69d7408b7 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -112,7 +112,6 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
-bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -408,12 +407,26 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 0ee3bd897..fa98054c7 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -96,7 +96,6 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
-bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -356,12 +355,26 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 5701f2285..2e584253c 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -115,7 +115,6 @@ delete_module 129
 quotactl 131
 getpgid 132
 fchdir 133
-bdflush 134
 sysfs 135
 personality 136
 setfsuid 138
@@ -357,6 +356,7 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 rseq 387
+sync_file_range2 388
 semget 393
 semctl 394
 shmget 395
@@ -402,12 +402,25 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 172969f60..fcdb9b812 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -221,7 +221,6 @@ create_module 221
 delete_module 222
 get_kernel_syms 223
 getpgid 224
-bdflush 225
 sysfs 226
 afs_syscall 227
 setfsuid 228
@@ -407,12 +406,25 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 5b667f10f..4256aaf77 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -29,8 +29,6 @@ alarm 27
 sigaltstack 28
 pause 29
 utime 30
-lchown32 31
-fchown32 32
 access 33
 nice 34
 sync 36
@@ -206,7 +204,6 @@ create_module 221
 delete_module 222
 get_kernel_syms 223
 getpgid 224
-bdflush 225
 sysfs 226
 afs_syscall 227
 setfsuid 228
@@ -372,12 +369,25 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 1993f343a..e6c0a3b40 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -333,6 +333,7 @@ pkey_free 331
 statx 332
 io_pgetevents 333
 rseq 334
+uretprobe 335
 pidfd_send_signal 424
 io_uring_setup 425
 io_uring_enter 426
@@ -349,48 +350,26 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 faccessat2 439
+process_madvise 440
 epoll_pwait2 441
+mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
+process_mrelease 448
 futex_waitv 449
+set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
+map_shadow_stack 453
+futex_wake 454
+futex_wait 455
+futex_requeue 456
+statmount 457
+listmount 458
+lsm_get_self_attr 459
+lsm_set_self_attr 460
+lsm_list_modules 461
 mseal 462
-rt_sigaction 512
-rt_sigreturn 513
-ioctl 514
-readv 515
-writev 516
-recvfrom 517
-sendmsg 518
-recvmsg 519
-execve 520
-ptrace 521
-rt_sigpending 522
-rt_sigtimedwait 523
-rt_sigqueueinfo 524
-sigaltstack 525
-timer_create 526
-mq_notify 527
-kexec_load 528
-waitid 529
-set_robust_list 530
-get_robust_list 531
-vmsplice 532
-move_pages 533
-preadv 534
-pwritev 535
-rt_tgsigqueueinfo 536
-recvmmsg 537
-sendmmsg 538
-process_vm_readv 539
-process_vm_writev 540
-setsockopt 541
-getsockopt 542
-io_setup 543
-io_submit 544
-execveat 545
-preadv2 546
-pwritev2 547

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
