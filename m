Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1966FC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F84D3CDA3F
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:16:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AABE3CDC1C
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:16:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CAB7C60BE81
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:15:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0FB221940;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E79F139FC;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id +FV9JbivZWUtTgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 09:15:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Nov 2023 10:15:23 +0100
Message-ID: <20231128091524.340808-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128091524.340808-1-pvorel@suse.cz>
References: <20231128091524.340808-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.89 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: E0FB221940
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ptrace: Build ptrace06, enable in runtest/syscalls
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

It was disabled in 91d5f18a5 due failures in RHEL 4 (kernel 2.6.9).
Although test is still in legacy API, it runs well, it should have been
enabled long time ago.

Test was also commented out in runtest/syscalls, enable it again.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            | 5 ++---
 testcases/kernel/syscalls/ptrace/.gitignore | 1 +
 testcases/kernel/syscalls/ptrace/Makefile   | 6 ++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index b7ceb25d3..06db4604e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1,4 +1,4 @@
-#DESCRIPTION:Kernel system calls
+ based Kernel)#DESCRIPTION:Kernel system calls
 abort01 abort01
 
 accept01 accept01
@@ -1076,8 +1076,7 @@ ptrace02 ptrace02
 ptrace03 ptrace03
 ptrace04 ptrace04
 ptrace05 ptrace05
-# Broken test; See: testcases/kernel/syscalls/ptrace/Makefile for more details.
-#ptrace06 ptrace06
+ptrace06 ptrace06
 ptrace07 ptrace07
 ptrace08 ptrace08
 ptrace09 ptrace09
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
index 01cbc6072..1ee6117e9 100644
--- a/testcases/kernel/syscalls/ptrace/.gitignore
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -3,6 +3,7 @@
 /ptrace03
 /ptrace04
 /ptrace05
+/ptrace06
 /ptrace07
 /ptrace08
 /ptrace09
diff --git a/testcases/kernel/syscalls/ptrace/Makefile b/testcases/kernel/syscalls/ptrace/Makefile
index 9ee7b8374..b410a54be 100644
--- a/testcases/kernel/syscalls/ptrace/Makefile
+++ b/testcases/kernel/syscalls/ptrace/Makefile
@@ -1,13 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2002-2023
 # Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-# - ptrace06 is a broken test ; it hangs the target consistently, chewing up
-#   CPU. See: `Issue 3 - ptrace06 hung for 7 hours' --
-# http://sourceforge.net/mailarchive/forum.php?thread_name=364299f40910062300s65c43c93w9cccdfe8835c2334%40mail.gmail.com&forum_name=ltp-list
 # - simple_tracer is a utility that Mike Frysinger added that shouldn't be
 #   compiled by default:
 #
@@ -29,6 +27,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 #  make: *** [testcases-all] Error 2
 #
 
-FILTER_OUT_MAKE_TARGETS	:= ptrace06 simple_tracer
+FILTER_OUT_MAKE_TARGETS	:= simple_tracer
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
