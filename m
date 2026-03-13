Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B3105F79D
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 310B83E48F9
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:49:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 942213E5798
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 187381000A13
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1B104D3B9;
 Fri, 13 Mar 2026 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVGrDWijow4o8jERkUOGbf/B4Z+NSIodU+38SbKY6AQ=;
 b=Ukh1Hx3Cs1+UXBMPNyfD7ateceHWrDfTO2imLQqSqANfv+n/0dVzWTu5L6fduZ4p+Oy+rA
 NCZSOf9Z65kKBagDyn6iZWl8a+j1OR8arai8lKhPrrUcv5YYgXq7e4C8iPauazx+bW7XZT
 1YqxjYSdyeLstqrP2MuwzQM2VQ70gXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVGrDWijow4o8jERkUOGbf/B4Z+NSIodU+38SbKY6AQ=;
 b=pjWy4oR4xCd5QFb036SEpRopqSOJ/+Oup75pew2C0h+YnhqNTl1sRciKXyMl8g7J9q+cz2
 W7jwe14tMluUb6AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ukh1Hx3C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pjWy4oR4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVGrDWijow4o8jERkUOGbf/B4Z+NSIodU+38SbKY6AQ=;
 b=Ukh1Hx3Cs1+UXBMPNyfD7ateceHWrDfTO2imLQqSqANfv+n/0dVzWTu5L6fduZ4p+Oy+rA
 NCZSOf9Z65kKBagDyn6iZWl8a+j1OR8arai8lKhPrrUcv5YYgXq7e4C8iPauazx+bW7XZT
 1YqxjYSdyeLstqrP2MuwzQM2VQ70gXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVGrDWijow4o8jERkUOGbf/B4Z+NSIodU+38SbKY6AQ=;
 b=pjWy4oR4xCd5QFb036SEpRopqSOJ/+Oup75pew2C0h+YnhqNTl1sRciKXyMl8g7J9q+cz2
 W7jwe14tMluUb6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FE64404E8;
 Fri, 13 Mar 2026 11:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CItRJYT5s2lZGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:48:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:48:19 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v2-1-38384fae9b1f@suse.com>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
In-Reply-To: <20260313-listns-v2-0-38384fae9b1f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773402500; l=14444;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3EFkkKx/SzB0k3NMjUGSDsC5tdhQu9SyEzdf0NuHKk4=;
 b=oUvlvOUOtty5TazS7Mr9gerBWJKuNVBKU5XVPLuxkvmVIe3LDYf5YvlXqMv24QYOlYymGPibO
 jqwSpOgnAVgCldNthR98VEV4Vv3/StVyqtqM2LFPavXn0aspRoEBP3a
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C1B104D3B9
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] Update architectures syscalls identifiers
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
 include/lapi/syscalls/arc.in         |   2 +
 include/lapi/syscalls/arm.in         |   3 +-
 include/lapi/syscalls/arm64.in       |   2 +
 include/lapi/syscalls/i386.in        |   3 +-
 include/lapi/syscalls/loongarch64.in |   3 ++
 include/lapi/syscalls/mips64.in      |   4 +-
 include/lapi/syscalls/mips64n32.in   |   4 +-
 include/lapi/syscalls/mipso32.in     |   4 +-
 include/lapi/syscalls/parisc.in      |   3 +-
 include/lapi/syscalls/powerpc.in     |   3 +-
 include/lapi/syscalls/powerpc64.in   |   3 +-
 include/lapi/syscalls/s390.in        | 102 +++++++++--------------------------
 include/lapi/syscalls/s390x.in       |   4 +-
 include/lapi/syscalls/sh.in          |   3 +-
 include/lapi/syscalls/sparc.in       |   4 +-
 include/lapi/syscalls/sparc64.in     |   4 +-
 include/lapi/syscalls/x86_64.in      |   4 +-
 17 files changed, 61 insertions(+), 94 deletions(-)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 0f0fbef6be74d06abbf4f1bbf77eeaf72a1e6b71..89b04af1caf54e9b93b84c1e2bc1372f03a5d2a6 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -347,3 +347,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index d0238dec5ecbf3849dff3b2c91ec88866dfb440c..72e07584b9fe5e09ff8661cf88db3dffcfd89720 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -109,7 +109,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -420,3 +419,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index c76930e20df02905c9c640a749b4ec2df421c665..46dc7bbfbbce035effd41274fd4757a116a07a03 100644
--- a/include/lapi/syscalls/arm64.in
+++ b/include/lapi/syscalls/arm64.in
@@ -323,3 +323,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 38ea71fb282d9dc69914b863cba352349fd1c9b9..8905d7f43073f275f571846e900d48abe959c6d2 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -145,7 +145,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -454,3 +453,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index 5407b86eaf738354f645f894bd95900ff614b3e1..60f77a7d1c84059f119bc1d988e9b6b89569e2f5 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -297,6 +297,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
@@ -319,3 +320,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index 436d5c681c21f32623d779268b9c3daaaac5b5e0..0375503686461386e70637f6a3cc3b69a48cf235 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -150,7 +150,6 @@ mlockall 5148
 munlockall 5149
 vhangup 5150
 pivot_root 5151
-_sysctl 5152
 prctl 5153
 adjtimex 5154
 setrlimit 5155
@@ -272,7 +271,6 @@ ioprio_set 5273
 ioprio_get 5274
 utimensat 5275
 signalfd 5276
-timerfd 5277
 eventfd 5278
 fallocate 5279
 timerfd_create 5280
@@ -369,3 +367,5 @@ removexattrat 5466
 open_tree_attr 5467
 file_getattr 5468
 file_setattr 5469
+listns 5470
+rseq_slice_yield 5471
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 860a19c8b62866aeaf5b03c5c45ef5d6d58cab0f..0998b2bd8b0e318af44178762766a2e7cc7a2b63 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -150,7 +150,6 @@ mlockall 6148
 munlockall 6149
 vhangup 6150
 pivot_root 6151
-_sysctl 6152
 prctl 6153
 adjtimex 6154
 setrlimit 6155
@@ -276,7 +275,6 @@ ioprio_set 6277
 ioprio_get 6278
 utimensat 6279
 signalfd 6280
-timerfd 6281
 eventfd 6282
 fallocate 6283
 timerfd_create 6284
@@ -393,3 +391,5 @@ removexattrat 6466
 open_tree_attr 6467
 file_getattr 6468
 file_setattr 6469
+listns 6470
+rseq_slice_yield 6471
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 5e53e46ce1e47c4618ceeeda03130cbdd621b180..75ac1ef1e0d431fd154ca507dbb8cef07c3226b4 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -144,7 +144,6 @@ cachectl 4148
 sysmips 4149
 getsid 4151
 fdatasync 4152
-_sysctl 4153
 mlock 4154
 munlock 4155
 mlockall 4156
@@ -307,7 +306,6 @@ ioprio_set 4314
 ioprio_get 4315
 utimensat 4316
 signalfd 4317
-timerfd 4318
 eventfd 4319
 fallocate 4320
 timerfd_create 4321
@@ -433,3 +431,5 @@ removexattrat 4466
 open_tree_attr 4467
 file_getattr 4468
 file_setattr 4469
+listns 4470
+rseq_slice_yield 4471
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 238756694d9a03bcb063c21d3644aaa2af47f3fc..8007565f571ec3a7673adbf20246ee335c221067 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -142,7 +142,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -402,3 +401,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 6911f9af96247739a1ba7020aa3df77ef70ef55a..02a91ac46c6d6149282d2a2ec5fe8fd50a466ba6 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -145,7 +145,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -444,3 +443,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 98190ba266a1c7a6c3dbca1346e9d5e55783e271..931b95f69e7c1c150ef54d63956d42511ffabb50 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -145,7 +145,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -416,3 +415,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index a6cb85da805bec2540433783be9445645ab913ab..978092202738cd97f345fe9757d5b7355814d893 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -10,17 +10,12 @@ link 9
 unlink 10
 execve 11
 chdir 12
-time 13
 mknod 14
 chmod 15
-lchown 16
 lseek 19
 getpid 20
 mount 21
 umount 22
-setuid 23
-getuid 24
-stime 25
 ptrace 26
 alarm 27
 pause 29
@@ -36,11 +31,7 @@ dup 41
 pipe 42
 times 43
 brk 45
-setgid 46
-getgid 47
 signal 48
-geteuid 49
-getegid 50
 acct 51
 umount2 52
 ioctl 54
@@ -54,18 +45,13 @@ getppid 64
 getpgrp 65
 setsid 66
 sigaction 67
-setreuid 70
-setregid 71
 sigsuspend 72
 sigpending 73
 sethostname 74
 setrlimit 75
-getrlimit 76
 getrusage 77
 gettimeofday 78
 settimeofday 79
-getgroups 80
-setgroups 81
 symlink 83
 readlink 85
 uselib 86
@@ -77,12 +63,10 @@ munmap 91
 truncate 92
 ftruncate 93
 fchmod 94
-fchown 95
 getpriority 96
 setpriority 97
 statfs 99
 fstatfs 100
-ioperm 101
 socketcall 102
 syslog 103
 setitimer 104
@@ -115,18 +99,14 @@ fchdir 133
 sysfs 135
 personality 136
 afs_syscall 137
-setfsuid 138
-setfsgid 139
-_llseek 140
 getdents 141
-_newselect 142
+select 142
 flock 143
 msync 144
 readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -141,13 +121,9 @@ sched_get_priority_min 160
 sched_rr_get_interval 161
 nanosleep 162
 mremap 163
-setresuid 164
-getresuid 165
 query_module 167
 poll 168
 nfsservctl 169
-setresgid 170
-getresgid 171
 prctl 172
 rt_sigreturn 173
 rt_sigaction 174
@@ -158,7 +134,6 @@ rt_sigqueueinfo 178
 rt_sigsuspend 179
 pread64 180
 pwrite64 181
-chown 182
 getcwd 183
 capget 184
 capset 185
@@ -167,39 +142,31 @@ sendfile 187
 getpmsg 188
 putpmsg 189
 vfork 190
-ugetrlimit 191
-mmap2 192
-truncate64 193
-ftruncate64 194
-stat64 195
-lstat64 196
-fstat64 197
-lchown32 198
-getuid32 199
-getgid32 200
-geteuid32 201
-getegid32 202
-setreuid32 203
-setregid32 204
-getgroups32 205
-setgroups32 206
-fchown32 207
-setresuid32 208
-getresuid32 209
-setresgid32 210
-getresgid32 211
-chown32 212
-setuid32 213
-setgid32 214
-setfsuid32 215
-setfsgid32 216
+getrlimit 191
+lchown 198
+getuid 199
+getgid 200
+geteuid 201
+getegid 202
+setreuid 203
+setregid 204
+getgroups 205
+setgroups 206
+fchown 207
+setresuid 208
+getresuid 209
+setresgid 210
+getresgid 211
+chown 212
+setuid 213
+setgid 214
+setfsuid 215
+setfsgid 216
 pivot_root 217
 mincore 218
 madvise 219
 getdents64 220
-fcntl64 221
 readahead 222
-sendfile64 223
 setxattr 224
 lsetxattr 225
 fsetxattr 226
@@ -238,7 +205,6 @@ clock_settime 259
 clock_gettime 260
 clock_getres 261
 clock_nanosleep 262
-fadvise64_64 264
 statfs64 265
 fstatfs64 266
 remap_file_pages 267
@@ -267,7 +233,7 @@ mkdirat 289
 mknodat 290
 fchownat 291
 futimesat 292
-fstatat64 293
+newfstatat 293
 unlinkat 294
 renameat 295
 linkat 296
@@ -291,7 +257,6 @@ utimes 313
 fallocate 314
 utimensat 315
 signalfd 316
-timerfd 317
 eventfd 318
 timerfd_create 319
 timerfd_settime 320
@@ -361,6 +326,7 @@ rseq 383
 pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
+semtimedop 392
 semget 393
 semctl 394
 shmget 395
@@ -371,26 +337,6 @@ msgget 399
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
@@ -437,3 +383,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 31f3ec5532c8c3017188b60907f7666b41f44102..978092202738cd97f345fe9757d5b7355814d893 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -107,7 +107,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -258,7 +257,6 @@ utimes 313
 fallocate 314
 utimensat 315
 signalfd 316
-timerfd 317
 eventfd 318
 timerfd_create 319
 timerfd_settime 320
@@ -385,3 +383,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index ac281acf81ffe6770fa0d941d406714fbdce1bbd..e3cef0e77632f5c76af781384fa39406727ae826 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -128,7 +128,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -431,3 +430,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index ffc0d9f7abdaa8873ec73ed1a5e0ec98b5f8b1d7..20d58a5999172674c78585d0d1435024a65d0119 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -246,7 +246,6 @@ sched_get_priority_min 247
 sched_rr_get_interval 248
 nanosleep 249
 mremap 250
-_sysctl 251
 getsid 252
 fdatasync 253
 nfsservctl 254
@@ -402,6 +401,7 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
@@ -435,3 +435,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 992bd307deb07d50ff814c603406842b5aedb431..49419ef5d65d7f9bfb4cbc715bc671d2d387deef 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -228,7 +228,6 @@ sched_get_priority_min 247
 sched_rr_get_interval 248
 nanosleep 249
 mremap 250
-_sysctl 251
 getsid 252
 fdatasync 253
 nfsservctl 254
@@ -365,6 +364,7 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
@@ -398,3 +398,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index e9c0d0599e25e3fa408686544c5d80c5a3e876d7..a253bcfd7d2461634e0a3a1c1e1c312fef682a66 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -154,7 +154,6 @@ munlockall 152
 vhangup 153
 modify_ldt 154
 pivot_root 155
-_sysctl 156
 prctl 157
 arch_prctl 158
 adjtimex 159
@@ -334,6 +333,7 @@ statx 332
 io_pgetevents 333
 rseq 334
 uretprobe 335
+uprobe 336
 pidfd_send_signal 424
 io_uring_setup 425
 io_uring_enter 426
@@ -380,3 +380,5 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
