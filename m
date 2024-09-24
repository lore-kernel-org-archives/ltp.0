Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C929CCF9C71
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 08:08:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642D23C4CD3
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 10:08:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CAA43C4C0C
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDE92600952
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70F511FBDE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqukEYEYwlSHTbk/Z6alvy/6fXtqqA2HLOglcX4aAd4=;
 b=HTraA5WEyo7bkZj0h0vd1wPt6kathprlCjwXHUT+RvIBKRE1rXEntXBc1JUz/jTqYbS4hx
 aI+CoKNziixx/U8GO0aXCRl6MGCImlrObPNoC2d+RmgbOU/cnDbC103bRgHpZYOYz41+SI
 YJDJfjaMHgZyuDj6LQBx2JSOMJEb/aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqukEYEYwlSHTbk/Z6alvy/6fXtqqA2HLOglcX4aAd4=;
 b=NTR6EPZlJaWMAdGBRjjzEOrIrOQGrWFMSOpwDPdvvKy1c2XoOfsWS+ZX86TelDOVgO4iRZ
 m3fu1kqRRjCQb2Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqukEYEYwlSHTbk/Z6alvy/6fXtqqA2HLOglcX4aAd4=;
 b=HTraA5WEyo7bkZj0h0vd1wPt6kathprlCjwXHUT+RvIBKRE1rXEntXBc1JUz/jTqYbS4hx
 aI+CoKNziixx/U8GO0aXCRl6MGCImlrObPNoC2d+RmgbOU/cnDbC103bRgHpZYOYz41+SI
 YJDJfjaMHgZyuDj6LQBx2JSOMJEb/aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqukEYEYwlSHTbk/Z6alvy/6fXtqqA2HLOglcX4aAd4=;
 b=NTR6EPZlJaWMAdGBRjjzEOrIrOQGrWFMSOpwDPdvvKy1c2XoOfsWS+ZX86TelDOVgO4iRZ
 m3fu1kqRRjCQb2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF3DD13AE2
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ONo5MRtz8mYVcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Sep 2024 10:06:29 +0200
MIME-Version: 1.0
Message-Id: <20240924-generate_syscalls-v1-4-941507a9cdac@suse.com>
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
In-Reply-To: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727165211; l=900118;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=os+mWuRcYvNOwT+RQwhjDLHLtG7RDFXtRS8C6JKPNGw=;
 b=bczzW/Gg6I9BYTuAbo1VIh5vAb1o328HzFAoP+vynCVxDU7+5xYg2Aq1lStEKSjRgb3he2Mps
 4OBOwjcPmiaAffY3eXIc0PPOf/zK0qhNi05KRKwCMplUzY8muq7PLen
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=7.0 tests=DKIM_SIGNED,DKIM_VALID,
 DKIM_VALID_AU,DKIM_VALID_EF,DMARC_PASS,SPF_HELO_NONE,SPF_PASS
 shortcircuit=no autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on in-2.smtp.seeweb.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] Save syscalls.h inside repo
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/.gitignore |     1 -
 include/lapi/syscalls.h | 34272 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 34272 insertions(+), 1 deletion(-)

diff --git a/include/lapi/.gitignore b/include/lapi/.gitignore
deleted file mode 100644
index 9867b3f25..000000000
--- a/include/lapi/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-syscalls.h
diff --git a/include/lapi/syscalls.h b/include/lapi/syscalls.h
new file mode 100644
index 000000000..bf26dd84c
--- /dev/null
+++ b/include/lapi/syscalls.h
@@ -0,0 +1,34272 @@
+
+/************************************************
+ * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
+ *  change your arch specific .in file instead  *
+ ************************************************/
+
+/*
+ * Here we stick all the ugly *fallback* logic for linux
+ * system call numbers (those __NR_ thingies).
+ *
+ * Licensed under the GPLv2 or later, see the COPYING file.
+ */
+
+#ifndef LAPI_SYSCALLS_H__
+#define LAPI_SYSCALLS_H__
+
+#include <errno.h>
+#include <sys/syscall.h>
+#include <asm/unistd.h>
+
+#ifdef TST_TEST_H__
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \
+	tst_brk(TCONF, \
+		"syscall(%d) " SNR " not supported on your arch", NR); \
+})
+#else
+inline static void dummy_cleanup(void) {}
+
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \
+	tst_brkm(TCONF, dummy_cleanup, \
+		"syscall(%d) " SNR " not supported on your arch", NR); \
+})
+#endif
+
+#define tst_syscall(NR, ...) ({ \
+	intptr_t tst_ret; \
+	if (NR == __LTP__NR_INVALID_SYSCALL) { \
+		errno = ENOSYS; \
+		tst_ret = -1; \
+	} else { \
+		tst_ret = syscall(NR, ##__VA_ARGS__); \
+	} \
+	if (tst_ret == -1 && errno == ENOSYS) { \
+		TST_SYSCALL_BRK__(NR, #NR); \
+	} \
+	tst_ret; \
+})
+
+#define __LTP__NR_INVALID_SYSCALL -1
+
+#ifdef __aarch64__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __arc__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __arm__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __hppa__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __i386__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __ia64__
+# ifndef __NR__llseek
+#  define __NR__llseek 
+# endif
+# ifndef __NR__newselect
+#  define __NR__newselect 
+# endif
+# ifndef __NR__sysctl
+#  define __NR__sysctl 1150
+# endif
+# ifndef __NR_accept
+#  define __NR_accept 1194
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 1334
+# endif
+# ifndef __NR_access
+#  define __NR_access 1049
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 1064
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 1271
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 1131
+# endif
+# ifndef __NR_alarm
+#  define __NR_alarm 
+# endif
+# ifndef __NR_arc_gettls
+#  define __NR_arc_gettls 
+# endif
+# ifndef __NR_arc_settls
+#  define __NR_arc_settls 
+# endif
+# ifndef __NR_arc_usr_cmpxchg
+#  define __NR_arc_usr_cmpxchg 
+# endif
+# ifndef __NR_arch_prctl
+#  define __NR_arch_prctl 
+# endif
+# ifndef __NR_arm_fadvise64_64
+#  define __NR_arm_fadvise64_64 
+# endif
+# ifndef __NR_atomic_barrier
+#  define __NR_atomic_barrier 
+# endif
+# ifndef __NR_atomic_cmpxchg_32
+#  define __NR_atomic_cmpxchg_32 
+# endif
+# ifndef __NR_bdflush
+#  define __NR_bdflush 1138
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 1191
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 1341
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 1060
+# endif
+# ifndef __NR_cachectl
+#  define __NR_cachectl 
+# endif
+# ifndef __NR_cacheflush
+#  define __NR_cacheflush 
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 1475
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 1185
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 1186
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 1034
+# endif
+# ifndef __NR_chmod
+#  define __NR_chmod 1038
+# endif
+# ifndef __NR_chown
+#  define __NR_chown 1039
+# endif
+# ifndef __NR_chown32
+#  define __NR_chown32 
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 1068
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 1328
+# endif
+# ifndef __NR_clock_adjtime64
+#  define __NR_clock_adjtime64 
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 1255
+# endif
+# ifndef __NR_clock_getres_time64
+#  define __NR_clock_getres_time64 
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 1254
+# endif
+# ifndef __NR_clock_gettime64
+#  define __NR_clock_gettime64 
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 1256
+# endif
+# ifndef __NR_clock_nanosleep_time64
+#  define __NR_clock_nanosleep_time64 
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 1253
+# endif
+# ifndef __NR_clock_settime64
+#  define __NR_clock_settime64 
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 1128
+# endif
+# ifndef __NR_clone2
+#  define __NR_clone2 1213
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 
+# endif
+# ifndef __NR_close
+#  define __NR_close 1029
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 1460
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 1192
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 1347
+# endif
+# ifndef __NR_creat
+#  define __NR_creat 1030
+# endif
+# ifndef __NR_create_module
+#  define __NR_create_module 
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 1134
+# endif
+# ifndef __NR_dipc
+#  define __NR_dipc 
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 1057
+# endif
+# ifndef __NR_dup2
+#  define __NR_dup2 1070
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 1316
+# endif
+# ifndef __NR_epoll_create
+#  define __NR_epoll_create 1243
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 1315
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 1244
+# endif
+# ifndef __NR_epoll_ctl_old
+#  define __NR_epoll_ctl_old 
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 1305
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 1465
+# endif
+# ifndef __NR_epoll_wait
+#  define __NR_epoll_wait 1245
+# endif
+# ifndef __NR_epoll_wait_old
+#  define __NR_epoll_wait_old 
+# endif
+# ifndef __NR_eventfd
+#  define __NR_eventfd 1309
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 1314
+# endif
+# ifndef __NR_exec_with_loader
+#  define __NR_exec_with_loader 
+# endif
+# ifndef __NR_execv
+#  define __NR_execv 
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 1033
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 1342
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 1025
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 1236
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 1293
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 1463
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 1234
+# endif
+# ifndef __NR_fadvise64_64
+#  define __NR_fadvise64_64 
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 1303
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 1323
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 1324
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 1035
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 1099
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 1292
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 1476
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 1100
+# endif
+# ifndef __NR_fchown32
+#  define __NR_fchown32 
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 1284
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 1066
+# endif
+# ifndef __NR_fcntl64
+#  define __NR_fcntl64 
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 1052
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 1222
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 1335
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 1225
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 1145
+# endif
+# ifndef __NR_fork
+#  define __NR_fork 
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 1228
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 1455
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 1219
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 1456
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 1454
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 1457
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 1212
+# endif
+# ifndef __NR_fstat64
+#  define __NR_fstat64 
+# endif
+# ifndef __NR_fstatat64
+#  define __NR_fstatat64 
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 1104
+# endif
+# ifndef __NR_fstatfs64
+#  define __NR_fstatfs64 1257
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 1051
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 1098
+# endif
+# ifndef __NR_ftruncate64
+#  define __NR_ftruncate64 
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 1230
+# endif
+# ifndef __NR_futex_time64
+#  define __NR_futex_time64 
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 1473
+# endif
+# ifndef __NR_futimesat
+#  define __NR_futimesat 1285
+# endif
+# ifndef __NR_get_kernel_syms
+#  define __NR_get_kernel_syms 
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 1260
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 1299
+# endif
+# ifndef __NR_get_thread_area
+#  define __NR_get_thread_area 
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 1304
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 1184
+# endif
+# ifndef __NR_getdents
+#  define __NR_getdents 1144
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 1214
+# endif
+# ifndef __NR_getdomainname
+#  define __NR_getdomainname 
+# endif
+# ifndef __NR_getdtablesize
+#  define __NR_getdtablesize 
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 1063
+# endif
+# ifndef __NR_getegid32
+#  define __NR_getegid32 
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 1047
+# endif
+# ifndef __NR_geteuid32
+#  define __NR_geteuid32 
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 1062
+# endif
+# ifndef __NR_getgid32
+#  define __NR_getgid32 
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 1077
+# endif
+# ifndef __NR_getgroups32
+#  define __NR_getgroups32 
+# endif
+# ifndef __NR_gethostname
+#  define __NR_gethostname 
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 1119
+# endif
+# ifndef __NR_getpagesize
+#  define __NR_getpagesize 
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 1196
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 1079
+# endif
+# ifndef __NR_getpgrp
+#  define __NR_getpgrp 
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 1041
+# endif
+# ifndef __NR_getpmsg
+#  define __NR_getpmsg 1188
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 1042
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 1101
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 1339
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 1075
+# endif
+# ifndef __NR_getresgid32
+#  define __NR_getresgid32 
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 1073
+# endif
+# ifndef __NR_getresuid32
+#  define __NR_getresuid32 
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 1085
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 1086
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 1082
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 1195
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 1204
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 1105
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 1087
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 1046
+# endif
+# ifndef __NR_getuid32
+#  define __NR_getuid32 
+# endif
+# ifndef __NR_getunwind
+#  define __NR_getunwind 1215
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 1220
+# endif
+# ifndef __NR_getxgid
+#  define __NR_getxgid 
+# endif
+# ifndef __NR_getxpid
+#  define __NR_getxpid 
+# endif
+# ifndef __NR_getxuid
+#  define __NR_getxuid 
+# endif
+# ifndef __NR_idle
+#  define __NR_idle 
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 1133
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 1278
+# endif
+# ifndef __NR_inotify_init
+#  define __NR_inotify_init 1277
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 1318
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 1279
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 1242
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1239
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 1240
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 1351
+# endif
+# ifndef __NR_io_pgetevents_time64
+#  define __NR_io_pgetevents_time64 
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 1238
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 1241
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 1450
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 1451
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 1449
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 1065
+# endif
+# ifndef __NR_ioperm
+#  define __NR_ioperm 
+# endif
+# ifndef __NR_iopl
+#  define __NR_iopl 
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 1275
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 1274
+# endif
+# ifndef __NR_ipc
+#  define __NR_ipc 
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 1345
+# endif
+# ifndef __NR_kern_features
+#  define __NR_kern_features 
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 1268
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 1273
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 1053
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 1469
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 1468
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 1470
+# endif
+# ifndef __NR_lchown
+#  define __NR_lchown 1124
+# endif
+# ifndef __NR_lchown32
+#  define __NR_lchown32 
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 1221
+# endif
+# ifndef __NR_link
+#  define __NR_link 1031
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 1289
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 1193
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 1223
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 1224
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 1237
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 1227
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 1040
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 1218
+# endif
+# ifndef __NR_lstat
+#  define __NR_lstat 1211
+# endif
+# ifndef __NR_lstat64
+#  define __NR_lstat64 
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 1209
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 1259
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 1344
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 1340
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 
+# endif
+# ifndef __NR_memory_ordering
+#  define __NR_memory_ordering 
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 1280
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 1208
+# endif
+# ifndef __NR_mkdir
+#  define __NR_mkdir 1055
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 1282
+# endif
+# ifndef __NR_mknod
+#  define __NR_mknod 1037
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 1283
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 1153
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 1346
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 1154
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 1151
+# endif
+# ifndef __NR_mmap2
+#  define __NR_mmap2 1172
+# endif
+# ifndef __NR_modify_ldt
+#  define __NR_modify_ldt 
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 1043
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 1466
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 1453
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 1276
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 1155
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 1267
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 1266
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 1262
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 1265
+# endif
+# ifndef __NR_mq_timedreceive_time64
+#  define __NR_mq_timedreceive_time64 
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 1264
+# endif
+# ifndef __NR_mq_timedsend_time64
+#  define __NR_mq_timedsend_time64 
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 1263
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 1156
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 1112
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 1109
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 1111
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 1110
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 1157
+# endif
+# ifndef __NR_multiplexer
+#  define __NR_multiplexer 
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 1158
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 1159
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 1152
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 1326
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 1168
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 1286
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 1169
+# endif
+# ifndef __NR_nice
+#  define __NR_nice 
+# endif
+# ifndef __NR_old_adjtimex
+#  define __NR_old_adjtimex 
+# endif
+# ifndef __NR_old_getpagesize
+#  define __NR_old_getpagesize 1171
+# endif
+# ifndef __NR_oldfstat
+#  define __NR_oldfstat 
+# endif
+# ifndef __NR_oldlstat
+#  define __NR_oldlstat 
+# endif
+# ifndef __NR_oldolduname
+#  define __NR_oldolduname 
+# endif
+# ifndef __NR_oldstat
+#  define __NR_oldstat 
+# endif
+# ifndef __NR_oldumount
+#  define __NR_oldumount 
+# endif
+# ifndef __NR_olduname
+#  define __NR_olduname 
+# endif
+# ifndef __NR_open
+#  define __NR_open 1028
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 1327
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 1452
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 1281
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 1461
+# endif
+# ifndef __NR_or1k_atomic
+#  define __NR_or1k_atomic 
+# endif
+# ifndef __NR_osf_adjtime
+#  define __NR_osf_adjtime 
+# endif
+# ifndef __NR_osf_afs_syscall
+#  define __NR_osf_afs_syscall 
+# endif
+# ifndef __NR_osf_alt_plock
+#  define __NR_osf_alt_plock 
+# endif
+# ifndef __NR_osf_alt_setsid
+#  define __NR_osf_alt_setsid 
+# endif
+# ifndef __NR_osf_alt_sigpending
+#  define __NR_osf_alt_sigpending 
+# endif
+# ifndef __NR_osf_asynch_daemon
+#  define __NR_osf_asynch_daemon 
+# endif
+# ifndef __NR_osf_audcntl
+#  define __NR_osf_audcntl 
+# endif
+# ifndef __NR_osf_audgen
+#  define __NR_osf_audgen 
+# endif
+# ifndef __NR_osf_chflags
+#  define __NR_osf_chflags 
+# endif
+# ifndef __NR_osf_execve
+#  define __NR_osf_execve 
+# endif
+# ifndef __NR_osf_exportfs
+#  define __NR_osf_exportfs 
+# endif
+# ifndef __NR_osf_fchflags
+#  define __NR_osf_fchflags 
+# endif
+# ifndef __NR_osf_fdatasync
+#  define __NR_osf_fdatasync 
+# endif
+# ifndef __NR_osf_fpathconf
+#  define __NR_osf_fpathconf 
+# endif
+# ifndef __NR_osf_fstat
+#  define __NR_osf_fstat 
+# endif
+# ifndef __NR_osf_fstatfs
+#  define __NR_osf_fstatfs 
+# endif
+# ifndef __NR_osf_fstatfs64
+#  define __NR_osf_fstatfs64 
+# endif
+# ifndef __NR_osf_fuser
+#  define __NR_osf_fuser 
+# endif
+# ifndef __NR_osf_getaddressconf
+#  define __NR_osf_getaddressconf 
+# endif
+# ifndef __NR_osf_getdirentries
+#  define __NR_osf_getdirentries 
+# endif
+# ifndef __NR_osf_getdomainname
+#  define __NR_osf_getdomainname 
+# endif
+# ifndef __NR_osf_getfh
+#  define __NR_osf_getfh 
+# endif
+# ifndef __NR_osf_getfsstat
+#  define __NR_osf_getfsstat 
+# endif
+# ifndef __NR_osf_gethostid
+#  define __NR_osf_gethostid 
+# endif
+# ifndef __NR_osf_getitimer
+#  define __NR_osf_getitimer 
+# endif
+# ifndef __NR_osf_getlogin
+#  define __NR_osf_getlogin 
+# endif
+# ifndef __NR_osf_getmnt
+#  define __NR_osf_getmnt 
+# endif
+# ifndef __NR_osf_getrusage
+#  define __NR_osf_getrusage 
+# endif
+# ifndef __NR_osf_getsysinfo
+#  define __NR_osf_getsysinfo 
+# endif
+# ifndef __NR_osf_gettimeofday
+#  define __NR_osf_gettimeofday 
+# endif
+# ifndef __NR_osf_kloadcall
+#  define __NR_osf_kloadcall 
+# endif
+# ifndef __NR_osf_kmodcall
+#  define __NR_osf_kmodcall 
+# endif
+# ifndef __NR_osf_lstat
+#  define __NR_osf_lstat 
+# endif
+# ifndef __NR_osf_memcntl
+#  define __NR_osf_memcntl 
+# endif
+# ifndef __NR_osf_mincore
+#  define __NR_osf_mincore 
+# endif
+# ifndef __NR_osf_mount
+#  define __NR_osf_mount 
+# endif
+# ifndef __NR_osf_mremap
+#  define __NR_osf_mremap 
+# endif
+# ifndef __NR_osf_msfs_syscall
+#  define __NR_osf_msfs_syscall 
+# endif
+# ifndef __NR_osf_msleep
+#  define __NR_osf_msleep 
+# endif
+# ifndef __NR_osf_mvalid
+#  define __NR_osf_mvalid 
+# endif
+# ifndef __NR_osf_mwakeup
+#  define __NR_osf_mwakeup 
+# endif
+# ifndef __NR_osf_naccept
+#  define __NR_osf_naccept 
+# endif
+# ifndef __NR_osf_nfssvc
+#  define __NR_osf_nfssvc 
+# endif
+# ifndef __NR_osf_ngetpeername
+#  define __NR_osf_ngetpeername 
+# endif
+# ifndef __NR_osf_ngetsockname
+#  define __NR_osf_ngetsockname 
+# endif
+# ifndef __NR_osf_nrecvfrom
+#  define __NR_osf_nrecvfrom 
+# endif
+# ifndef __NR_osf_nrecvmsg
+#  define __NR_osf_nrecvmsg 
+# endif
+# ifndef __NR_osf_nsendmsg
+#  define __NR_osf_nsendmsg 
+# endif
+# ifndef __NR_osf_ntp_adjtime
+#  define __NR_osf_ntp_adjtime 
+# endif
+# ifndef __NR_osf_ntp_gettime
+#  define __NR_osf_ntp_gettime 
+# endif
+# ifndef __NR_osf_old_creat
+#  define __NR_osf_old_creat 
+# endif
+# ifndef __NR_osf_old_fstat
+#  define __NR_osf_old_fstat 
+# endif
+# ifndef __NR_osf_old_getpgrp
+#  define __NR_osf_old_getpgrp 
+# endif
+# ifndef __NR_osf_old_killpg
+#  define __NR_osf_old_killpg 
+# endif
+# ifndef __NR_osf_old_lstat
+#  define __NR_osf_old_lstat 
+# endif
+# ifndef __NR_osf_old_open
+#  define __NR_osf_old_open 
+# endif
+# ifndef __NR_osf_old_sigaction
+#  define __NR_osf_old_sigaction 
+# endif
+# ifndef __NR_osf_old_sigblock
+#  define __NR_osf_old_sigblock 
+# endif
+# ifndef __NR_osf_old_sigreturn
+#  define __NR_osf_old_sigreturn 
+# endif
+# ifndef __NR_osf_old_sigsetmask
+#  define __NR_osf_old_sigsetmask 
+# endif
+# ifndef __NR_osf_old_sigvec
+#  define __NR_osf_old_sigvec 
+# endif
+# ifndef __NR_osf_old_stat
+#  define __NR_osf_old_stat 
+# endif
+# ifndef __NR_osf_old_vadvise
+#  define __NR_osf_old_vadvise 
+# endif
+# ifndef __NR_osf_old_vtrace
+#  define __NR_osf_old_vtrace 
+# endif
+# ifndef __NR_osf_old_wait
+#  define __NR_osf_old_wait 
+# endif
+# ifndef __NR_osf_oldquota
+#  define __NR_osf_oldquota 
+# endif
+# ifndef __NR_osf_pathconf
+#  define __NR_osf_pathconf 
+# endif
+# ifndef __NR_osf_pid_block
+#  define __NR_osf_pid_block 
+# endif
+# ifndef __NR_osf_pid_unblock
+#  define __NR_osf_pid_unblock 
+# endif
+# ifndef __NR_osf_plock
+#  define __NR_osf_plock 
+# endif
+# ifndef __NR_osf_priocntlset
+#  define __NR_osf_priocntlset 
+# endif
+# ifndef __NR_osf_profil
+#  define __NR_osf_profil 
+# endif
+# ifndef __NR_osf_proplist_syscall
+#  define __NR_osf_proplist_syscall 
+# endif
+# ifndef __NR_osf_reboot
+#  define __NR_osf_reboot 
+# endif
+# ifndef __NR_osf_revoke
+#  define __NR_osf_revoke 
+# endif
+# ifndef __NR_osf_sbrk
+#  define __NR_osf_sbrk 
+# endif
+# ifndef __NR_osf_security
+#  define __NR_osf_security 
+# endif
+# ifndef __NR_osf_select
+#  define __NR_osf_select 
+# endif
+# ifndef __NR_osf_set_program_attributes
+#  define __NR_osf_set_program_attributes 
+# endif
+# ifndef __NR_osf_set_speculative
+#  define __NR_osf_set_speculative 
+# endif
+# ifndef __NR_osf_sethostid
+#  define __NR_osf_sethostid 
+# endif
+# ifndef __NR_osf_setitimer
+#  define __NR_osf_setitimer 
+# endif
+# ifndef __NR_osf_setlogin
+#  define __NR_osf_setlogin 
+# endif
+# ifndef __NR_osf_setsysinfo
+#  define __NR_osf_setsysinfo 
+# endif
+# ifndef __NR_osf_settimeofday
+#  define __NR_osf_settimeofday 
+# endif
+# ifndef __NR_osf_shmat
+#  define __NR_osf_shmat 
+# endif
+# ifndef __NR_osf_signal
+#  define __NR_osf_signal 
+# endif
+# ifndef __NR_osf_sigprocmask
+#  define __NR_osf_sigprocmask 
+# endif
+# ifndef __NR_osf_sigsendset
+#  define __NR_osf_sigsendset 
+# endif
+# ifndef __NR_osf_sigstack
+#  define __NR_osf_sigstack 
+# endif
+# ifndef __NR_osf_sigwaitprim
+#  define __NR_osf_sigwaitprim 
+# endif
+# ifndef __NR_osf_sstk
+#  define __NR_osf_sstk 
+# endif
+# ifndef __NR_osf_stat
+#  define __NR_osf_stat 
+# endif
+# ifndef __NR_osf_statfs
+#  define __NR_osf_statfs 
+# endif
+# ifndef __NR_osf_statfs64
+#  define __NR_osf_statfs64 
+# endif
+# ifndef __NR_osf_subsys_info
+#  define __NR_osf_subsys_info 
+# endif
+# ifndef __NR_osf_swapctl
+#  define __NR_osf_swapctl 
+# endif
+# ifndef __NR_osf_swapon
+#  define __NR_osf_swapon 
+# endif
+# ifndef __NR_osf_syscall
+#  define __NR_osf_syscall 
+# endif
+# ifndef __NR_osf_sysinfo
+#  define __NR_osf_sysinfo 
+# endif
+# ifndef __NR_osf_table
+#  define __NR_osf_table 
+# endif
+# ifndef __NR_osf_uadmin
+#  define __NR_osf_uadmin 
+# endif
+# ifndef __NR_osf_usleep_thread
+#  define __NR_osf_usleep_thread 
+# endif
+# ifndef __NR_osf_uswitch
+#  define __NR_osf_uswitch 
+# endif
+# ifndef __NR_osf_utc_adjtime
+#  define __NR_osf_utc_adjtime 
+# endif
+# ifndef __NR_osf_utc_gettime
+#  define __NR_osf_utc_gettime 
+# endif
+# ifndef __NR_osf_utimes
+#  define __NR_osf_utimes 
+# endif
+# ifndef __NR_osf_utsname
+#  define __NR_osf_utsname 
+# endif
+# ifndef __NR_osf_wait4
+#  define __NR_osf_wait4 
+# endif
+# ifndef __NR_osf_waitid
+#  define __NR_osf_waitid 
+# endif
+# ifndef __NR_pause
+#  define __NR_pause 
+# endif
+# ifndef __NR_pciconfig_iobase
+#  define __NR_pciconfig_iobase 
+# endif
+# ifndef __NR_pciconfig_read
+#  define __NR_pciconfig_read 1173
+# endif
+# ifndef __NR_pciconfig_write
+#  define __NR_pciconfig_write 1174
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 1352
+# endif
+# ifndef __NR_perfctr
+#  define __NR_perfctr 
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 1140
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 1462
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 1458
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 1448
+# endif
+# ifndef __NR_pipe
+#  define __NR_pipe 1058
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 1317
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 1207
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 1355
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 1356
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 1354
+# endif
+# ifndef __NR_poll
+#  define __NR_poll 1090
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 1295
+# endif
+# ifndef __NR_ppoll_time64
+#  define __NR_ppoll_time64 
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 1170
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 1148
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 1319
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 1348
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 1325
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 1464
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 1472
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 1332
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 1333
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 1294
+# endif
+# ifndef __NR_pselect6_time64
+#  define __NR_pselect6_time64 
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 1048
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 1149
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 1320
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 1349
+# endif
+# ifndef __NR_query_module
+#  define __NR_query_module 
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 1137
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 1467
+# endif
+# ifndef __NR_read
+#  define __NR_read 1026
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 1216
+# endif
+# ifndef __NR_readdir
+#  define __NR_readdir 
+# endif
+# ifndef __NR_readlink
+#  define __NR_readlink 1092
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 1291
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 1146
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 1096
+# endif
+# ifndef __NR_recv
+#  define __NR_recv 1200
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 1201
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 1322
+# endif
+# ifndef __NR_recvmmsg_time64
+#  define __NR_recvmmsg_time64 
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 1206
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 1125
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 1226
+# endif
+# ifndef __NR_rename
+#  define __NR_rename 1054
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 1288
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 1338
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 1272
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 1246
+# endif
+# ifndef __NR_riscv_flush_icache
+#  define __NR_riscv_flush_icache 
+# endif
+# ifndef __NR_riscv_hwprobe
+#  define __NR_riscv_hwprobe 
+# endif
+# ifndef __NR_rmdir
+#  define __NR_rmdir 1056
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 1357
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 1177
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 1178
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 1179
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 1180
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 1181
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 1182
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 1183
+# endif
+# ifndef __NR_rt_sigtimedwait_time64
+#  define __NR_rt_sigtimedwait_time64 
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 1321
+# endif
+# ifndef __NR_rtas
+#  define __NR_rtas 
+# endif
+# ifndef __NR_s390_guarded_storage
+#  define __NR_s390_guarded_storage 
+# endif
+# ifndef __NR_s390_pci_mmio_read
+#  define __NR_s390_pci_mmio_read 
+# endif
+# ifndef __NR_s390_pci_mmio_write
+#  define __NR_s390_pci_mmio_write 
+# endif
+# ifndef __NR_s390_runtime_instr
+#  define __NR_s390_runtime_instr 
+# endif
+# ifndef __NR_s390_sthyi
+#  define __NR_s390_sthyi 
+# endif
+# ifndef __NR_sched_get_affinity
+#  define __NR_sched_get_affinity 
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 1165
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 1166
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 1232
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 1337
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 1160
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 1162
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 1167
+# endif
+# ifndef __NR_sched_rr_get_interval_time64
+#  define __NR_sched_rr_get_interval_time64 
+# endif
+# ifndef __NR_sched_set_affinity
+#  define __NR_sched_set_affinity 
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 1231
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 1336
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 1161
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 1163
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 1164
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 1353
+# endif
+# ifndef __NR_select
+#  define __NR_select 1089
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 1108
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 1106
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 1107
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 1247
+# endif
+# ifndef __NR_semtimedop_time64
+#  define __NR_semtimedop_time64 
+# endif
+# ifndef __NR_send
+#  define __NR_send 1198
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 1187
+# endif
+# ifndef __NR_sendfile64
+#  define __NR_sendfile64 
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 1331
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 1205
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 1199
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 1261
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 1474
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 1298
+# endif
+# ifndef __NR_set_thread_area
+#  define __NR_set_thread_area 
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 1233
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 1129
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 1143
+# endif
+# ifndef __NR_setfsgid32
+#  define __NR_setfsgid32 
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 1142
+# endif
+# ifndef __NR_setfsuid32
+#  define __NR_setfsuid32 
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 1061
+# endif
+# ifndef __NR_setgid32
+#  define __NR_setgid32 
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 1078
+# endif
+# ifndef __NR_setgroups32
+#  define __NR_setgroups32 
+# endif
+# ifndef __NR_sethae
+#  define __NR_sethae 
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 1083
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 1118
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 1330
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 1080
+# endif
+# ifndef __NR_setpgrp
+#  define __NR_setpgrp 
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 1102
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 1072
+# endif
+# ifndef __NR_setregid32
+#  define __NR_setregid32 
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 1076
+# endif
+# ifndef __NR_setresgid32
+#  define __NR_setresgid32 
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 1074
+# endif
+# ifndef __NR_setresuid32
+#  define __NR_setresuid32 
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 1071
+# endif
+# ifndef __NR_setreuid32
+#  define __NR_setreuid32 
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 1084
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 1081
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 1203
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 1088
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 1045
+# endif
+# ifndef __NR_setuid32
+#  define __NR_setuid32 
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 1217
+# endif
+# ifndef __NR_sgetmask
+#  define __NR_sgetmask 
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 1114
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 1116
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 1115
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 1113
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 1202
+# endif
+# ifndef __NR_sigaction
+#  define __NR_sigaction 
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 1176
+# endif
+# ifndef __NR_signal
+#  define __NR_signal 
+# endif
+# ifndef __NR_signalfd
+#  define __NR_signalfd 1307
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 1313
+# endif
+# ifndef __NR_sigpending
+#  define __NR_sigpending 
+# endif
+# ifndef __NR_sigprocmask
+#  define __NR_sigprocmask 
+# endif
+# ifndef __NR_sigreturn
+#  define __NR_sigreturn 
+# endif
+# ifndef __NR_sigsuspend
+#  define __NR_sigsuspend 
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 1190
+# endif
+# ifndef __NR_socketcall
+#  define __NR_socketcall 
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 1197
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 1297
+# endif
+# ifndef __NR_spu_create
+#  define __NR_spu_create 
+# endif
+# ifndef __NR_spu_run
+#  define __NR_spu_run 
+# endif
+# ifndef __NR_ssetmask
+#  define __NR_ssetmask 
+# endif
+# ifndef __NR_stat
+#  define __NR_stat 1210
+# endif
+# ifndef __NR_stat64
+#  define __NR_stat64 
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 1103
+# endif
+# ifndef __NR_statfs64
+#  define __NR_statfs64 1258
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 1350
+# endif
+# ifndef __NR_stime
+#  define __NR_stime 
+# endif
+# ifndef __NR_subpage_prot
+#  define __NR_subpage_prot 
+# endif
+# ifndef __NR_swapcontext
+#  define __NR_swapcontext 
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 1095
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 1094
+# endif
+# ifndef __NR_switch_endian
+#  define __NR_switch_endian 
+# endif
+# ifndef __NR_symlink
+#  define __NR_symlink 1091
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 1290
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 1050
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 1300
+# endif
+# ifndef __NR_sync_file_range2
+#  define __NR_sync_file_range2 
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 1329
+# endif
+# ifndef __NR_sys_debug_setcontext
+#  define __NR_sys_debug_setcontext 
+# endif
+# ifndef __NR_syscall
+#  define __NR_syscall 
+# endif
+# ifndef __NR_sysfs
+#  define __NR_sysfs 1139
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 1127
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 1117
+# endif
+# ifndef __NR_sysmips
+#  define __NR_sysmips 
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 1301
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 1235
+# endif
+# ifndef __NR_time
+#  define __NR_time 
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 1248
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 1252
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 1251
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 1250
+# endif
+# ifndef __NR_timer_gettime64
+#  define __NR_timer_gettime64 
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 1249
+# endif
+# ifndef __NR_timer_settime64
+#  define __NR_timer_settime64 
+# endif
+# ifndef __NR_timerfd
+#  define __NR_timerfd 1308
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 1310
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 1312
+# endif
+# ifndef __NR_timerfd_gettime64
+#  define __NR_timerfd_gettime64 
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 1311
+# endif
+# ifndef __NR_timerfd_settime64
+#  define __NR_timerfd_settime64 
+# endif
+# ifndef __NR_times
+#  define __NR_times 1059
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 1229
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 1097
+# endif
+# ifndef __NR_truncate64
+#  define __NR_truncate64 
+# endif
+# ifndef __NR_ugetrlimit
+#  define __NR_ugetrlimit 
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 1067
+# endif
+# ifndef __NR_umount
+#  define __NR_umount 1044
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 1044
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 1130
+# endif
+# ifndef __NR_unlink
+#  define __NR_unlink 1032
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 1287
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 1296
+# endif
+# ifndef __NR_uselib
+#  define __NR_uselib 1093
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 1343
+# endif
+# ifndef __NR_ustat
+#  define __NR_ustat 1069
+# endif
+# ifndef __NR_utime
+#  define __NR_utime 
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 1306
+# endif
+# ifndef __NR_utimensat_time64
+#  define __NR_utimensat_time64 
+# endif
+# ifndef __NR_utimes
+#  define __NR_utimes 1036
+# endif
+# ifndef __NR_utrap_install
+#  define __NR_utrap_install 
+# endif
+# ifndef __NR_vfork
+#  define __NR_vfork 
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 1123
+# endif
+# ifndef __NR_vm86
+#  define __NR_vm86 
+# endif
+# ifndef __NR_vm86old
+#  define __NR_vm86old 
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 1302
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 1126
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 1270
+# endif
+# ifndef __NR_waitpid
+#  define __NR_waitpid 
+# endif
+# ifndef __NR_write
+#  define __NR_write 1027
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 1147
+# endif
+#endif
+
+
+#ifdef __loongarch__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#if defined(__mips__) && defined(_ABIN32)
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#if defined(__mips__) && defined(_ABI64)
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __powerpc__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __s390x__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#if defined(__s390__) && !defined(__s390x__)
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __sh__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#if defined(__sparc__) && defined(__arch64__)
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#if defined(__sparc__) && !defined(__arch64__)
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+#ifdef __x86_64__
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf 280
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat 451
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 435
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range 436
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range 285
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 441
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat 281
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 439
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 452
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module 273
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig 431
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount 432
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen 430
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick 433
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue 456
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait 455
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv 449
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake 454
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 278
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents 292
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter 426
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register 427
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup 425
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp 272
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load 294
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule 445
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset 444
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self 446
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount 458
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr 459
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules 461
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr 460
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack 453
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier 283
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create 279
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret 447
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 284
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr 442
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount 429
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal 462
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat 79
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree 428
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 437
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd 438
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open 434
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal 424
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc 289
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free 290
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect 288
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 286
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise 440
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease 448
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv 270
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev 271
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 287
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd 443
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 276
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq 293
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr 275
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr 274
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp 277
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node 450
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount 457
+# endif
+# ifndef __NR_statx
+#  define __NR_statx 291
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd 282
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+#endif
+
+
+/* Common stubs */
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR__llseek
+#  define __NR__llseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR__newselect
+#  define __NR__newselect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR__sysctl
+#  define __NR__sysctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_access
+#  define __NR_access __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_alarm
+#  define __NR_alarm __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_arc_gettls
+#  define __NR_arc_gettls __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_arc_settls
+#  define __NR_arc_settls __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_arc_usr_cmpxchg
+#  define __NR_arc_usr_cmpxchg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_arch_prctl
+#  define __NR_arch_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_arm_fadvise64_64
+#  define __NR_arm_fadvise64_64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_atomic_barrier
+#  define __NR_atomic_barrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_atomic_cmpxchg_32
+#  define __NR_atomic_cmpxchg_32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bdflush
+#  define __NR_bdflush __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachectl
+#  define __NR_cachectl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cacheflush
+#  define __NR_cacheflush __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chmod
+#  define __NR_chmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chown
+#  define __NR_chown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chown32
+#  define __NR_chown32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime64
+#  define __NR_clock_adjtime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres_time64
+#  define __NR_clock_getres_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime64
+#  define __NR_clock_gettime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep_time64
+#  define __NR_clock_nanosleep_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime64
+#  define __NR_clock_settime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone2
+#  define __NR_clone2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_creat
+#  define __NR_creat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_create_module
+#  define __NR_create_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dipc
+#  define __NR_dipc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup2
+#  define __NR_dup2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create
+#  define __NR_epoll_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl_old
+#  define __NR_epoll_ctl_old __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_wait
+#  define __NR_epoll_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_wait_old
+#  define __NR_epoll_wait_old __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd
+#  define __NR_eventfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exec_with_loader
+#  define __NR_exec_with_loader __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execv
+#  define __NR_execv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64_64
+#  define __NR_fadvise64_64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown32
+#  define __NR_fchown32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl64
+#  define __NR_fcntl64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fork
+#  define __NR_fork __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat64
+#  define __NR_fstat64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatat64
+#  define __NR_fstatat64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs64
+#  define __NR_fstatfs64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate64
+#  define __NR_ftruncate64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_time64
+#  define __NR_futex_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futimesat
+#  define __NR_futimesat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_kernel_syms
+#  define __NR_get_kernel_syms __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_thread_area
+#  define __NR_get_thread_area __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents
+#  define __NR_getdents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdomainname
+#  define __NR_getdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdtablesize
+#  define __NR_getdtablesize __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid32
+#  define __NR_getegid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid32
+#  define __NR_geteuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid32
+#  define __NR_getgid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups32
+#  define __NR_getgroups32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gethostname
+#  define __NR_gethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpagesize
+#  define __NR_getpagesize __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgrp
+#  define __NR_getpgrp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpmsg
+#  define __NR_getpmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid32
+#  define __NR_getresgid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid32
+#  define __NR_getresuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid32
+#  define __NR_getuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getunwind
+#  define __NR_getunwind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxgid
+#  define __NR_getxgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxpid
+#  define __NR_getxpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxuid
+#  define __NR_getxuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_idle
+#  define __NR_idle __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init
+#  define __NR_inotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents_time64
+#  define __NR_io_pgetevents_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioperm
+#  define __NR_ioperm __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_iopl
+#  define __NR_iopl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ipc
+#  define __NR_ipc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kern_features
+#  define __NR_kern_features __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lchown
+#  define __NR_lchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lchown32
+#  define __NR_lchown32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_link
+#  define __NR_link __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lstat
+#  define __NR_lstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lstat64
+#  define __NR_lstat64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memory_ordering
+#  define __NR_memory_ordering __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdir
+#  define __NR_mkdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknod
+#  define __NR_mknod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap2
+#  define __NR_mmap2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_modify_ldt
+#  define __NR_modify_ldt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive_time64
+#  define __NR_mq_timedreceive_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend_time64
+#  define __NR_mq_timedsend_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_multiplexer
+#  define __NR_multiplexer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nice
+#  define __NR_nice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_old_adjtimex
+#  define __NR_old_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_old_getpagesize
+#  define __NR_old_getpagesize __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_oldfstat
+#  define __NR_oldfstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_oldlstat
+#  define __NR_oldlstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_oldolduname
+#  define __NR_oldolduname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_oldstat
+#  define __NR_oldstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_oldumount
+#  define __NR_oldumount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_olduname
+#  define __NR_olduname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open
+#  define __NR_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_or1k_atomic
+#  define __NR_or1k_atomic __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_adjtime
+#  define __NR_osf_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_afs_syscall
+#  define __NR_osf_afs_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_alt_plock
+#  define __NR_osf_alt_plock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_alt_setsid
+#  define __NR_osf_alt_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_alt_sigpending
+#  define __NR_osf_alt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_asynch_daemon
+#  define __NR_osf_asynch_daemon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_audcntl
+#  define __NR_osf_audcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_audgen
+#  define __NR_osf_audgen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_chflags
+#  define __NR_osf_chflags __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_execve
+#  define __NR_osf_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_exportfs
+#  define __NR_osf_exportfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fchflags
+#  define __NR_osf_fchflags __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fdatasync
+#  define __NR_osf_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fpathconf
+#  define __NR_osf_fpathconf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fstat
+#  define __NR_osf_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fstatfs
+#  define __NR_osf_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fstatfs64
+#  define __NR_osf_fstatfs64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_fuser
+#  define __NR_osf_fuser __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getaddressconf
+#  define __NR_osf_getaddressconf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getdirentries
+#  define __NR_osf_getdirentries __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getdomainname
+#  define __NR_osf_getdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getfh
+#  define __NR_osf_getfh __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getfsstat
+#  define __NR_osf_getfsstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_gethostid
+#  define __NR_osf_gethostid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getitimer
+#  define __NR_osf_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getlogin
+#  define __NR_osf_getlogin __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getmnt
+#  define __NR_osf_getmnt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getrusage
+#  define __NR_osf_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_getsysinfo
+#  define __NR_osf_getsysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_gettimeofday
+#  define __NR_osf_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_kloadcall
+#  define __NR_osf_kloadcall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_kmodcall
+#  define __NR_osf_kmodcall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_lstat
+#  define __NR_osf_lstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_memcntl
+#  define __NR_osf_memcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_mincore
+#  define __NR_osf_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_mount
+#  define __NR_osf_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_mremap
+#  define __NR_osf_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_msfs_syscall
+#  define __NR_osf_msfs_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_msleep
+#  define __NR_osf_msleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_mvalid
+#  define __NR_osf_mvalid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_mwakeup
+#  define __NR_osf_mwakeup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_naccept
+#  define __NR_osf_naccept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_nfssvc
+#  define __NR_osf_nfssvc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_ngetpeername
+#  define __NR_osf_ngetpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_ngetsockname
+#  define __NR_osf_ngetsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_nrecvfrom
+#  define __NR_osf_nrecvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_nrecvmsg
+#  define __NR_osf_nrecvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_nsendmsg
+#  define __NR_osf_nsendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_ntp_adjtime
+#  define __NR_osf_ntp_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_ntp_gettime
+#  define __NR_osf_ntp_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_creat
+#  define __NR_osf_old_creat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_fstat
+#  define __NR_osf_old_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_getpgrp
+#  define __NR_osf_old_getpgrp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_killpg
+#  define __NR_osf_old_killpg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_lstat
+#  define __NR_osf_old_lstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_open
+#  define __NR_osf_old_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_sigaction
+#  define __NR_osf_old_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_sigblock
+#  define __NR_osf_old_sigblock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_sigreturn
+#  define __NR_osf_old_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_sigsetmask
+#  define __NR_osf_old_sigsetmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_sigvec
+#  define __NR_osf_old_sigvec __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_stat
+#  define __NR_osf_old_stat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_vadvise
+#  define __NR_osf_old_vadvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_vtrace
+#  define __NR_osf_old_vtrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_old_wait
+#  define __NR_osf_old_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_oldquota
+#  define __NR_osf_oldquota __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_pathconf
+#  define __NR_osf_pathconf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_pid_block
+#  define __NR_osf_pid_block __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_pid_unblock
+#  define __NR_osf_pid_unblock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_plock
+#  define __NR_osf_plock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_priocntlset
+#  define __NR_osf_priocntlset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_profil
+#  define __NR_osf_profil __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_proplist_syscall
+#  define __NR_osf_proplist_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_reboot
+#  define __NR_osf_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_revoke
+#  define __NR_osf_revoke __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sbrk
+#  define __NR_osf_sbrk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_security
+#  define __NR_osf_security __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_select
+#  define __NR_osf_select __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_set_program_attributes
+#  define __NR_osf_set_program_attributes __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_set_speculative
+#  define __NR_osf_set_speculative __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sethostid
+#  define __NR_osf_sethostid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_setitimer
+#  define __NR_osf_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_setlogin
+#  define __NR_osf_setlogin __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_setsysinfo
+#  define __NR_osf_setsysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_settimeofday
+#  define __NR_osf_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_shmat
+#  define __NR_osf_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_signal
+#  define __NR_osf_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sigprocmask
+#  define __NR_osf_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sigsendset
+#  define __NR_osf_sigsendset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sigstack
+#  define __NR_osf_sigstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sigwaitprim
+#  define __NR_osf_sigwaitprim __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sstk
+#  define __NR_osf_sstk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_stat
+#  define __NR_osf_stat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_statfs
+#  define __NR_osf_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_statfs64
+#  define __NR_osf_statfs64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_subsys_info
+#  define __NR_osf_subsys_info __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_swapctl
+#  define __NR_osf_swapctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_swapon
+#  define __NR_osf_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_syscall
+#  define __NR_osf_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_sysinfo
+#  define __NR_osf_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_table
+#  define __NR_osf_table __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_uadmin
+#  define __NR_osf_uadmin __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_usleep_thread
+#  define __NR_osf_usleep_thread __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_uswitch
+#  define __NR_osf_uswitch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_utc_adjtime
+#  define __NR_osf_utc_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_utc_gettime
+#  define __NR_osf_utc_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_utimes
+#  define __NR_osf_utimes __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_utsname
+#  define __NR_osf_utsname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_wait4
+#  define __NR_osf_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_osf_waitid
+#  define __NR_osf_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pause
+#  define __NR_pause __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pciconfig_iobase
+#  define __NR_pciconfig_iobase __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pciconfig_read
+#  define __NR_pciconfig_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pciconfig_write
+#  define __NR_pciconfig_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perfctr
+#  define __NR_perfctr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe
+#  define __NR_pipe __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_poll
+#  define __NR_poll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll_time64
+#  define __NR_ppoll_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6_time64
+#  define __NR_pselect6_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_query_module
+#  define __NR_query_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readdir
+#  define __NR_readdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlink
+#  define __NR_readlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recv
+#  define __NR_recv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg_time64
+#  define __NR_recvmmsg_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rename
+#  define __NR_rename __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_riscv_flush_icache
+#  define __NR_riscv_flush_icache __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_riscv_hwprobe
+#  define __NR_riscv_hwprobe __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rmdir
+#  define __NR_rmdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait_time64
+#  define __NR_rt_sigtimedwait_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rtas
+#  define __NR_rtas __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_s390_guarded_storage
+#  define __NR_s390_guarded_storage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_s390_pci_mmio_read
+#  define __NR_s390_pci_mmio_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_s390_pci_mmio_write
+#  define __NR_s390_pci_mmio_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_s390_runtime_instr
+#  define __NR_s390_runtime_instr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_s390_sthyi
+#  define __NR_s390_sthyi __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_affinity
+#  define __NR_sched_get_affinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval_time64
+#  define __NR_sched_rr_get_interval_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_set_affinity
+#  define __NR_sched_set_affinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_select
+#  define __NR_select __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop_time64
+#  define __NR_semtimedop_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_send
+#  define __NR_send __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile64
+#  define __NR_sendfile64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_thread_area
+#  define __NR_set_thread_area __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid32
+#  define __NR_setfsgid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid32
+#  define __NR_setfsuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid32
+#  define __NR_setgid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups32
+#  define __NR_setgroups32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethae
+#  define __NR_sethae __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgrp
+#  define __NR_setpgrp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid32
+#  define __NR_setregid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid32
+#  define __NR_setresgid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid32
+#  define __NR_setresuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid32
+#  define __NR_setreuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid32
+#  define __NR_setuid32 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sgetmask
+#  define __NR_sgetmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaction
+#  define __NR_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signal
+#  define __NR_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd
+#  define __NR_signalfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigpending
+#  define __NR_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigprocmask
+#  define __NR_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigreturn
+#  define __NR_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigsuspend
+#  define __NR_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketcall
+#  define __NR_socketcall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_spu_create
+#  define __NR_spu_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_spu_run
+#  define __NR_spu_run __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ssetmask
+#  define __NR_ssetmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_stat
+#  define __NR_stat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_stat64
+#  define __NR_stat64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs64
+#  define __NR_statfs64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_stime
+#  define __NR_stime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_subpage_prot
+#  define __NR_subpage_prot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapcontext
+#  define __NR_swapcontext __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_switch_endian
+#  define __NR_switch_endian __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlink
+#  define __NR_symlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range2
+#  define __NR_sync_file_range2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sys_debug_setcontext
+#  define __NR_sys_debug_setcontext __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syscall
+#  define __NR_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysfs
+#  define __NR_sysfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysmips
+#  define __NR_sysmips __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_time
+#  define __NR_time __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime64
+#  define __NR_timer_gettime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime64
+#  define __NR_timer_settime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd
+#  define __NR_timerfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime64
+#  define __NR_timerfd_gettime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime64
+#  define __NR_timerfd_settime64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate64
+#  define __NR_truncate64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ugetrlimit
+#  define __NR_ugetrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount
+#  define __NR_umount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlink
+#  define __NR_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uselib
+#  define __NR_uselib __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ustat
+#  define __NR_ustat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utime
+#  define __NR_utime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat_time64
+#  define __NR_utimensat_time64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimes
+#  define __NR_utimes __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utrap_install
+#  define __NR_utrap_install __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vfork
+#  define __NR_vfork __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vm86
+#  define __NR_vm86 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vm86old
+#  define __NR_vm86old __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitpid
+#  define __NR_waitpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_acct
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bind
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_bpf
+#  define __NR_bpf __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_brk
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_cachestat
+#  define __NR_cachestat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capget
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_capset
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clone3
+#  define __NR_clone3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_close_range
+#  define __NR_close_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_connect
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_copy_file_range
+#  define __NR_copy_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_epoll_pwait2
+#  define __NR_epoll_pwait2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execve
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_execveat
+#  define __NR_execveat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_faccessat2
+#  define __NR_faccessat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchmodat2
+#  define __NR_fchmodat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_finit_module
+#  define __NR_finit_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_flock
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsconfig
+#  define __NR_fsconfig __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsmount
+#  define __NR_fsmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsopen
+#  define __NR_fsopen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fspick
+#  define __NR_fspick __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_requeue
+#  define __NR_futex_requeue __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wait
+#  define __NR_futex_wait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_waitv
+#  define __NR_futex_waitv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_futex_wake
+#  define __NR_futex_wake __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_pgetevents
+#  define __NR_io_pgetevents __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_setup
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_enter
+#  define __NR_io_uring_enter __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_register
+#  define __NR_io_uring_register __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_io_uring_setup
+#  define __NR_io_uring_setup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kcmp
+#  define __NR_kcmp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_file_load
+#  define __NR_kexec_file_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_kill
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_add_rule
+#  define __NR_landlock_add_rule __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_create_ruleset
+#  define __NR_landlock_create_ruleset __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_landlock_restrict_self
+#  define __NR_landlock_restrict_self __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listen
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listmount
+#  define __NR_listmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_get_self_attr
+#  define __NR_lsm_get_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_list_modules
+#  define __NR_lsm_list_modules __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_lsm_set_self_attr
+#  define __NR_lsm_set_self_attr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_map_shadow_stack
+#  define __NR_map_shadow_stack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_membarrier
+#  define __NR_membarrier __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_create
+#  define __NR_memfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_memfd_secret
+#  define __NR_memfd_secret __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlock2
+#  define __NR_mlock2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mount_setattr
+#  define __NR_mount_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_mount
+#  define __NR_move_mount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_mseal
+#  define __NR_mseal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_msync
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_newfstatat
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_tree
+#  define __NR_open_tree __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_openat2
+#  define __NR_openat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_personality
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_getfd
+#  define __NR_pidfd_getfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_open
+#  define __NR_pidfd_open __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pidfd_send_signal
+#  define __NR_pidfd_send_signal __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_alloc
+#  define __NR_pkey_alloc __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_free
+#  define __NR_pkey_free __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pkey_mprotect
+#  define __NR_pkey_mprotect __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_preadv2
+#  define __NR_preadv2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_madvise
+#  define __NR_process_madvise __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_mrelease
+#  define __NR_process_mrelease __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_readv
+#  define __NR_process_vm_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_process_vm_writev
+#  define __NR_process_vm_writev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_pwritev2
+#  define __NR_pwritev2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_quotactl_fd
+#  define __NR_quotactl_fd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_read
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_readv
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_renameat2
+#  define __NR_renameat2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rseq
+#  define __NR_rseq __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getattr
+#  define __NR_sched_getattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setattr
+#  define __NR_sched_setattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_seccomp
+#  define __NR_seccomp __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semget
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semop
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_mempolicy_home_node
+#  define __NR_set_mempolicy_home_node __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socket
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_splice
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statmount
+#  define __NR_statmount __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_statx
+#  define __NR_statx __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tee
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_times
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umask
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_uname
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_userfaultfd
+#  define __NR_userfaultfd __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_write
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_writev
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
+# endif
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
