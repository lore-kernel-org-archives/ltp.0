Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6F9C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:16:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36883CD9A5
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:16:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98A593CD997
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:16:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D308C60BE83
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:15:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5DC1F37E;
 Tue, 28 Nov 2023 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701162937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaXBZKjY2HKXc/L/CwIXt1GdHKTiQooSeDjXqi7ujc8=;
 b=m1Q4cHlWAwpMB3qVBO5e53hsC0rd+CgW9xGdrz/MJY8PGCkYKWBl3rNOAxfuPuMjQQNj+Z
 Ulf9PrppkiMoHqaFK85mNFw5hge/rWNHNzHi/g3r8aYqRVAqJjPenZ2Iy8yVrATFXqGwpV
 dH7VmA8ARW6VxurUzZ6zALyElsgxBks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701162937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaXBZKjY2HKXc/L/CwIXt1GdHKTiQooSeDjXqi7ujc8=;
 b=njnbXfvs49MM/JBPt6ECm0tgj3adFCfT/vCu+m5vC8GMRh1GFShxZV7zrZcAzZxCh5m4Lg
 9RHM7qoxP1lk6sAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E53F013B40;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id WEGANrivZWUtTgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 09:15:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Nov 2023 10:15:24 +0100
Message-ID: <20231128091524.340808-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128091524.340808-1-pvorel@suse.cz>
References: <20231128091524.340808-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [5.23 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.17)[-0.862]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 3/3] ptrace: Remove simple_tracer.c
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Legacy test from 2009, which does not even compile.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

do you see any value in this test? Should it be rewritten?  Or could it
be deleted and the goal of the test filled into issue so that we don't
forget on it? (IMHO test would need to be written from scratch).

Kind regards,
Petr

 testcases/kernel/syscalls/ptrace/Makefile     |  23 ---
 .../syscalls/ptrace/make_syscall_list.sh      |   7 -
 .../kernel/syscalls/ptrace/simple_tracer.c    | 143 ------------------
 testcases/kernel/syscalls/ptrace/syscalls.h   |  17 ---
 4 files changed, 190 deletions(-)
 delete mode 100755 testcases/kernel/syscalls/ptrace/make_syscall_list.sh
 delete mode 100644 testcases/kernel/syscalls/ptrace/simple_tracer.c
 delete mode 100644 testcases/kernel/syscalls/ptrace/syscalls.h

diff --git a/testcases/kernel/syscalls/ptrace/Makefile b/testcases/kernel/syscalls/ptrace/Makefile
index b410a54be..d7eca6837 100644
--- a/testcases/kernel/syscalls/ptrace/Makefile
+++ b/testcases/kernel/syscalls/ptrace/Makefile
@@ -6,27 +6,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-# - simple_tracer is a utility that Mike Frysinger added that shouldn't be
-#   compiled by default:
-#
-# gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-# -I//scratch/ltp-install6/include -I../../../../include
-#  -L//scratch/ltp-install6/lib   simple_tracer.c  -laio -lltp -o
-#  simple_tracer
-#  In file included from simple_tracer.c:25:
-#  syscalls.h:6:23: error: _syscalls.h: No such file or directory
-#  make[4]: *** [simple_tracer] Error 1
-#  make[4]: Leaving directory
-#  `/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/ptrace'
-#  make[3]: *** [all] Error 2
-#  make[3]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel/syscalls'
-#  make[2]: *** [all] Error 2
-#  make[2]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel'
-#  make[1]: *** [all] Error 2
-#  make[1]: Leaving directory `/scratch/ltp-dev2/ltp/testcases'
-#  make: *** [testcases-all] Error 2
-#
-
-FILTER_OUT_MAKE_TARGETS	:= simple_tracer
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ptrace/make_syscall_list.sh b/testcases/kernel/syscalls/ptrace/make_syscall_list.sh
deleted file mode 100755
index e5d6d2765..000000000
--- a/testcases/kernel/syscalls/ptrace/make_syscall_list.sh
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-set -- $( \
-	printf '#include <sys/syscall.h>' | \
-	${CC:-gcc} -E -dD - | \
-	awk '$2 ~ /^SYS_/ { sub(/SYS_/,"",$2); print $2; }'
-)
-printf 'P(%s)\n' "$@"
diff --git a/testcases/kernel/syscalls/ptrace/simple_tracer.c b/testcases/kernel/syscalls/ptrace/simple_tracer.c
deleted file mode 100644
index 43026e317..000000000
--- a/testcases/kernel/syscalls/ptrace/simple_tracer.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * simple example ptrace() code to help build basis for other tests
- *
- * Copyright (c) 2009 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later
- */
-
-#define _GNU_SOURCE
-
-#include <config.h>
-
-#include <errno.h>
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/ptrace.h>
-#include <sys/syscall.h>
-
-#include "test.h"
-#include "spawn_ptrace_child.h"
-
-#include "syscalls.h"
-
-char *TCID = "simple_tracer";
-int TST_TOTAL = 0;
-
-#define _decode(name, val) \
-({ \
-	if (sizeof(long) == 4) \
-		printf(name ":%08lx ", val); \
-	else if (sizeof(long) == 8) \
-		printf(name ":%016lx ", val); \
-	else \
-		printf(name ":%lx ", val); \
-	val; \
-})
-#define decode(reg) _decode(#reg, pt->reg)
-#define decode_user(name, offset) \
-	_decode(name, vptrace(PTRACE_PEEKUSER, pid, offset, NULL));
-#define decode_sysnum(nr) printf("%s ", get_sysnum(nr))
-static void decode_regs(struct pt_regs *pt)
-{
-#if defined(__bfin__)
-	long nr = decode_user("orig_p0", PT_ORIG_P0);
-	decode(p0);
-	decode(r0);
-	decode(r1);
-	decode(r2);
-	decode(r3);
-	decode(r4);
-	decode(r5);
-	decode_sysnum(nr);
-	puts("");
-#elif defined(__i386__)
-	long nr = decode_user("orig_eax", 4 * ORIG_EAX);
-	decode(eax);
-	decode(ebx);
-	decode(ecx);
-	decode(edx);
-	decode(esi);
-	decode(edi);
-	decode(ebp);
-	decode_sysnum(nr);
-	puts("");
-#elif defined(__x86_64__)
-	long nr = decode_user("orig_rax", 8 * ORIG_RAX);
-	decode(rax);
-	decode(rbx);
-	decode(rcx);
-	decode(rdx);
-	decode(rsi);
-	decode(rdi);
-	decode(rbp);
-	decode_sysnum(nr);
-	puts("");
-#elif defined(__sparc__)
-#define G1 u_regs[0]
-#define G2 u_regs[1]
-#define G3 u_regs[2]
-#define G4 u_regs[3]
-#define G5 u_regs[4]
-#define G6 u_regs[5]
-#define G7 u_regs[6]
-#define O0 u_regs[7]
-#define O1 u_regs[8]
-#define O2 u_regs[9]
-#define O3 u_regs[10]
-#define O4 u_regs[11]
-#define O5 u_regs[12]
-#define O6 u_regs[13]
-#define O7 u_regs[14]
-	decode(G1);
-	decode(G2);
-	decode(G3);
-	decode(G4);
-	decode(G5);
-	decode(G6);
-	decode(G7);
-	decode(O0);
-	decode(O1);
-	decode(O2);
-	decode(O3);
-	decode(O4);
-	decode(O5);
-	decode(O6);
-	decode(O7);
-	decode_sysnum(pt->G1);
-	puts("");
-#else
-#warning "no idea how to decode your arch"
-	puts("no idea how to decode your arch");
-#endif
-}
-
-int main(int argc, char *argv[])
-{
-	struct pt_regs pt_regs;
-	long ret;
-	int status;
-
-	make_a_baby(argc, argv);
-
-	while (1) {
-		ret = vptrace(PTRACE_GETREGS, pid, NULL, &pt_regs);
-		if (ret)
-			break;
-		decode_regs(&pt_regs);
-
-		ret = vptrace(PTRACE_SYSCALL, pid, NULL, NULL);
-		if (ret)
-			break;
-
-		if (waitpid(pid, &status, 0) == -1)
-			break;
-	}
-
-	/* hopefully this worked */
-	vptrace(PTRACE_KILL, pid, NULL, NULL);
-
-	tst_exit();
-}
diff --git a/testcases/kernel/syscalls/ptrace/syscalls.h b/testcases/kernel/syscalls/ptrace/syscalls.h
deleted file mode 100644
index 2d9c5ceb6..000000000
--- a/testcases/kernel/syscalls/ptrace/syscalls.h
+++ /dev/null
@@ -1,17 +0,0 @@
-const struct sysnums {
-	long nr;
-	const char *snr;
-} sysnums[] = {
-#define P(NR) { .nr = SYS_##NR, .snr = #NR, },
-#include "_syscalls.h"
-#undef P
-};
-
-const char *get_sysnum(long nr)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(sysnums); ++i)
-		if (sysnums[i].nr == nr)
-			break;
-	return i == ARRAY_SIZE(sysnums) ? "???" : sysnums[i].snr;
-}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
