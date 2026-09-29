Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A34C9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:17:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89DF3E5849
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:17:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B01E03C57AC
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:17:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B903960042D
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:17:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05C891F449;
 Tue, 29 Sep 2026 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790691427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OBDym3N+l1DzjAl2p8hOu0bC16Qne+rTvI2D7MAPvIQ=;
 b=1XjedkgLL91ie0FiaWkE8wKGIKVOKMiPZ/Q9uSAgv7TAjmYpEHFoeazLY2YISziVk6yPJ2
 O4oPcsmowpqp9MjrcT+XXuScHgTcF730bNdtVxbWaIyVxGriFnm6TroVGwnybaiAASE7UF
 mhOgxpi2jbgxntuoihPAa5Rmk4XQ0Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790691427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OBDym3N+l1DzjAl2p8hOu0bC16Qne+rTvI2D7MAPvIQ=;
 b=IX/dML/0CIQMVVWbJJanzOD+5sYnJZbvDvGnKLjZKbpCZPJ3lcwSKVqlC7PhP5XMfLGlUq
 wnH6BJJI8hrAZxBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790691423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OBDym3N+l1DzjAl2p8hOu0bC16Qne+rTvI2D7MAPvIQ=;
 b=eGySUPq6hXRqsLnxx/1lSQw4DBmyabEUMN489yvGtaa6i5+Vsz38IIMCYNHKBIvEEgxBCP
 O4gku9tgA0QVwqq7INhnz6VKBxHUgWSKmRJqrqFe9jtN7U8cToNibqn3WqplGW/qaPJ12u
 r8IyAFEh+u8aYsqiE4WSLSl7DQhO7RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790691423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OBDym3N+l1DzjAl2p8hOu0bC16Qne+rTvI2D7MAPvIQ=;
 b=Zls+ujEvSn4rOyWPU/nsUWDNB98WHb6oF6CtXsK0UCEOr2FqA4vKRbGCFX6KUA8CzULjD7
 xiTRE3bI6PovtOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8685B133F1;
 Tue, 29 Sep 2026 14:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B5rVFF7Iu2o3UgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 14:17:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 29 Sep 2026 16:16:59 +0200
Message-ID: <20260929141659.2513510-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linaro.org:email,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lapi: Update syscalls numbers to v7.3-rc5
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

Updating syscalls should help fixing issue with sparc not working on
tst_clone().

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
It should be safe, but do we dare to merge before LTP release?

This tries to avoid workaround for sparc()
https://patchwork.kernel.org/project/ltp/patch/20260929084253.3093742-1-anders.roxell@linaro.org/
https://lore.kernel.org/ltp/20260929084253.3093742-1-anders.roxell@linaro.org/

 include/lapi/syscalls/arc.in         |   3 +
 include/lapi/syscalls/arm.in         |   4 +-
 include/lapi/syscalls/arm64.in       |   3 +
 include/lapi/syscalls/i386.in        |   4 +-
 include/lapi/syscalls/loongarch64.in |   3 +
 include/lapi/syscalls/mips64.in      |   5 +-
 include/lapi/syscalls/mips64n32.in   |   5 +-
 include/lapi/syscalls/mipso32.in     |   5 +-
 include/lapi/syscalls/parisc.in      |   4 +-
 include/lapi/syscalls/powerpc.in     |   4 +-
 include/lapi/syscalls/powerpc64.in   |   4 +-
 include/lapi/syscalls/s390.in        | 103 +++++++--------------------
 include/lapi/syscalls/s390x.in       |   5 +-
 include/lapi/syscalls/sh.in          |   4 +-
 include/lapi/syscalls/sparc.in       |   5 +-
 include/lapi/syscalls/sparc64.in     |   5 +-
 include/lapi/syscalls/x86_64.in      |   5 +-
 17 files changed, 77 insertions(+), 94 deletions(-)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 0f0fbef6be..96b14c1b98 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -347,3 +347,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index d0238dec5e..1583509765 100644
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
@@ -420,3 +419,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index c76930e20d..26a61e8303 100644
--- a/include/lapi/syscalls/arm64.in
+++ b/include/lapi/syscalls/arm64.in
@@ -323,3 +323,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 38ea71fb28..ee229b567b 100644
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
@@ -454,3 +453,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index a1dfce79ef..88e77ef8a6 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -320,3 +320,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index 436d5c681c..d1087e0492 100644
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
@@ -369,3 +367,6 @@ removexattrat 5466
 open_tree_attr 5467
 file_getattr 5468
 file_setattr 5469
+listns 5470
+rseq_slice_yield 5471
+fchroot 5472
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 860a19c8b6..2a38831987 100644
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
@@ -393,3 +391,6 @@ removexattrat 6466
 open_tree_attr 6467
 file_getattr 6468
 file_setattr 6469
+listns 6470
+rseq_slice_yield 6471
+fchroot 6472
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 5e53e46ce1..0d682d072a 100644
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
@@ -433,3 +431,6 @@ removexattrat 4466
 open_tree_attr 4467
 file_getattr 4468
 file_setattr 4469
+listns 4470
+rseq_slice_yield 4471
+fchroot 4472
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 238756694d..71d40f7b23 100644
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
@@ -402,3 +401,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 6911f9af96..85d7aec9af 100644
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
@@ -444,3 +443,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 98190ba266..def01478d9 100644
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
@@ -416,3 +415,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index a6cb85da80..357b04ceb1 100644
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
@@ -437,3 +383,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 31f3ec5532..357b04ceb1 100644
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
@@ -385,3 +383,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index ac281acf81..584d36a4ea 100644
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
@@ -431,3 +430,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index ffc0d9f7ab..a48c5b365e 100644
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
@@ -435,3 +435,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 992bd307de..9f3e825a97 100644
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
@@ -398,3 +398,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index e9c0d0599e..1996c26b87 100644
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
@@ -380,3 +380,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
