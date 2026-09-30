Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14A8CA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:33:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9ECF3E55B4
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:33:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E04F3E55F2
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:32:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3180B1A01076
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:32:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8EC1F8BA;
 Wed, 30 Sep 2026 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790757161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaWQZrhr+Dc5nsrH42lmNTzfDxB0Dqg2FbfGI0tUeqs=;
 b=hXvXr7qBpzojyrc9kFQT/8f5bcF8hCG+RCFJ8UlXmu8rVJu3SXeal6C67dZzluIFDNGp2p
 LJ+55npT90zPdy5HsGFjE4/dhpbq7QqoPnir6z6xECbiB9mPLyzEpzXcWFH1++dmxQihDl
 bDsYp3k/kuS3peqEtlasSOgYMV8Ndn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790757161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaWQZrhr+Dc5nsrH42lmNTzfDxB0Dqg2FbfGI0tUeqs=;
 b=QtrqUuB+5DlQVEOgrgoIHRLw3GZMWNowb/c0C2ZPMD6w/J1z75YOWrgdvb4LFHH0UHjk7K
 TrspsaZx+TEMfJDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0p411v7q;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=awRsgtQ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790757157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaWQZrhr+Dc5nsrH42lmNTzfDxB0Dqg2FbfGI0tUeqs=;
 b=0p411v7qSEdLXz5Ek9dpgDNqobxcpMVQuK8VU2dQH4Z9fxOBHZ5XO4y6AO037COJNA3WxB
 1huZKkqCtOkxP/mWoYpxHVCvolNljcS/JInjw54ZN32/NE848tRNEHIrXHR2kzi3cg+1Gh
 s6Fp1eWLxibAjYHorz5pr/Gv8svGMFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790757157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaWQZrhr+Dc5nsrH42lmNTzfDxB0Dqg2FbfGI0tUeqs=;
 b=awRsgtQ8Z9dKubuQM7Qfk9DNX2iU4K4WArChIZnRiYES28sgiyC0Z/VOR4lr9yvfEgTYy9
 y6BJaLL/PM0IPBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F5113A91;
 Wed, 30 Sep 2026 08:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 409TLSTJvGpCfQAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Sep 2026 08:32:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 10:32:35 +0200
MIME-Version: 1.0
Message-Id: <20260930-fix_generate_syscalls-v1-2-fccaef437fa1@suse.com>
References: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
In-Reply-To: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790757156; l=10003;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AnbX1lYfTB3lOxTQV8DXrghDQU9oXczDjkFImvJ9PKQ=;
 b=C3KztpBiuifceUzHdPEVGq2UcLTjxG+hW8bYuMlZv8NPaZMcH5n9seMiTohcXUoNsHDhPJBZ/
 eB0POlIX4WhBvHZfxZDkUAtwneGG7+Myh9Ov9RP+O2+SVayRsvwo5AX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6F8EC1F8BA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls: Update numbers to Linux v7.3-rc5
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

Update architecture syscall tables up to Linux v7.3-rc5 using the
updated generate_arch.sh script. This adds clone3 on sparc/sparc64,
uprobe on x86_64, and new generic syscalls (listns, rseq_slice_yield,
fchroot), while preserving legacy syscall numbers.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/arc.in         | 3 +++
 include/lapi/syscalls/arm.in         | 4 ++++
 include/lapi/syscalls/arm64.in       | 3 +++
 include/lapi/syscalls/i386.in        | 6 ++++++
 include/lapi/syscalls/loongarch64.in | 3 +++
 include/lapi/syscalls/mips64.in      | 3 +++
 include/lapi/syscalls/mips64n32.in   | 3 +++
 include/lapi/syscalls/mipso32.in     | 7 +++++--
 include/lapi/syscalls/parisc.in      | 4 ++++
 include/lapi/syscalls/powerpc.in     | 7 +++++++
 include/lapi/syscalls/powerpc64.in   | 7 +++++++
 include/lapi/syscalls/s390x.in       | 4 ++++
 include/lapi/syscalls/sh.in          | 4 ++++
 include/lapi/syscalls/sparc.in       | 5 +++++
 include/lapi/syscalls/sparc64.in     | 5 +++++
 include/lapi/syscalls/x86_64.in      | 4 ++++
 16 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 0f0fbef6b..96b14c1b9 100644
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
index d0238dec5..5b6047bd2 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -96,6 +96,7 @@ delete_module 129
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 setfsuid 138
@@ -420,3 +421,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index c76930e20..26a61e830 100644
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
index 38ea71fb2..b13d3f056 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -111,6 +111,7 @@ olduname 109
 iopl 110
 vhangup 111
 idle 112
+vm86old 113
 wait4 114
 swapoff 115
 sysinfo 116
@@ -131,6 +132,7 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -162,6 +164,7 @@ nanosleep 162
 mremap 163
 setresuid 164
 getresuid 165
+vm86 166
 query_module 167
 poll 168
 nfsservctl 169
@@ -454,3 +457,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index a1dfce79e..88e77ef8a 100644
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
index 436d5c681..3c19066b8 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -369,3 +369,6 @@ removexattrat 5466
 open_tree_attr 5467
 file_getattr 5468
 file_setattr 5469
+listns 5470
+rseq_slice_yield 5471
+fchroot 5472
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 860a19c8b..0c539bd62 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -393,3 +393,6 @@ removexattrat 6466
 open_tree_attr 6467
 file_getattr 6468
 file_setattr 6469
+listns 6470
+rseq_slice_yield 6471
+fchroot 6472
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 5e53e46ce..5284389b8 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -55,7 +55,6 @@ fcntl 4055
 mpx 4056
 setpgid 4057
 ulimit 4058
-unused59 4059
 umask 4060
 chroot 4061
 ustat 4062
@@ -103,10 +102,10 @@ getitimer 4105
 stat 4106
 lstat 4107
 fstat 4108
-unused109 4109
 iopl 4110
 vhangup 4111
 idle 4112
+vm86 4113
 wait4 4114
 swapoff 4115
 sysinfo 4116
@@ -127,6 +126,7 @@ get_kernel_syms 4130
 quotactl 4131
 getpgid 4132
 fchdir 4133
+bdflush 4134
 sysfs 4135
 personality 4136
 afs_syscall 4137
@@ -433,3 +433,6 @@ removexattrat 4466
 open_tree_attr 4467
 file_getattr 4468
 file_setattr 4469
+listns 4470
+rseq_slice_yield 4471
+fchroot 4472
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 238756694..5ba23a2b6 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -129,6 +129,7 @@ delete_module 129
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 setfsuid 138
@@ -402,3 +403,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 6911f9af9..20d803efc 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -111,6 +111,7 @@ olduname 109
 iopl 110
 vhangup 111
 idle 112
+vm86 113
 wait4 114
 swapoff 115
 sysinfo 116
@@ -131,6 +132,7 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -197,6 +199,7 @@ fstat64 197
 pciconfig_read 198
 pciconfig_write 199
 pciconfig_iobase 200
+multiplexer 201
 getdents64 202
 pivot_root 203
 fcntl64 204
@@ -250,6 +253,7 @@ statfs64 252
 fstatfs64 253
 fadvise64_64 254
 rtas 255
+sys_debug_setcontext 256
 migrate_pages 258
 mbind 259
 get_mempolicy 260
@@ -444,3 +448,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 98190ba26..125b86b17 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -111,6 +111,7 @@ olduname 109
 iopl 110
 vhangup 111
 idle 112
+vm86 113
 wait4 114
 swapoff 115
 sysinfo 116
@@ -131,6 +132,7 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -191,6 +193,7 @@ readahead 191
 pciconfig_read 198
 pciconfig_write 199
 pciconfig_iobase 200
+multiplexer 201
 getdents64 202
 pivot_root 203
 madvise 205
@@ -241,6 +244,7 @@ utimes 251
 statfs64 252
 fstatfs64 253
 rtas 255
+sys_debug_setcontext 256
 migrate_pages 258
 mbind 259
 get_mempolicy 260
@@ -416,3 +420,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 31f3ec553..b5ae79c75 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -96,6 +96,7 @@ get_kernel_syms 130
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 afs_syscall 137
@@ -385,3 +386,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index ac281acf8..f4071df0c 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -115,6 +115,7 @@ delete_module 129
 quotactl 131
 getpgid 132
 fchdir 133
+bdflush 134
 sysfs 135
 personality 136
 setfsuid 138
@@ -431,3 +432,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index ffc0d9f7a..64143daaa 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -221,6 +221,7 @@ create_module 221
 delete_module 222
 get_kernel_syms 223
 getpgid 224
+bdflush 225
 sysfs 226
 afs_syscall 227
 setfsuid 228
@@ -402,6 +403,7 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
@@ -435,3 +437,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 992bd307d..631034c97 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -204,6 +204,7 @@ create_module 221
 delete_module 222
 get_kernel_syms 223
 getpgid 224
+bdflush 225
 sysfs 226
 afs_syscall 227
 setfsuid 228
@@ -365,6 +366,7 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
@@ -398,3 +400,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index e9c0d0599..fd381114f 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -334,6 +334,7 @@ statx 332
 io_pgetevents 333
 rseq 334
 uretprobe 335
+uprobe 336
 pidfd_send_signal 424
 io_uring_setup 425
 io_uring_enter 426
@@ -380,3 +381,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
