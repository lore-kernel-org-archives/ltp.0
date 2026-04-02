Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9277DD6AB05
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 20:05:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E78393E4ED0
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 22:05:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BDED3E4E79
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 22:04:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71A0C60079B
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 22:04:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA6034D32F;
 Thu,  2 Apr 2026 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775160283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3HmAi44bte2xXLu48NL4WSz/hv5iTMJK2fp1BmPntOk=;
 b=fxhg5ipEpc99bN3KszDotHKC0dfMLUkOJdoEiUmgZl5GtNexD8dq/o4j47qu3rSzBl6O8Y
 8KF83rSPSPsSVPx8FiFKQCZh923208RT9g7UT2XttGhBmbMiR/XWm+1yASuxDGxAunfyPP
 E/Y8fLzkYiI+ZDYUHEIMP2zu5JCBPZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775160283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3HmAi44bte2xXLu48NL4WSz/hv5iTMJK2fp1BmPntOk=;
 b=C/s+Sj8U9Brea4uNAL3FcXsjOTC3U7/DdYTUstx+TXm1mZNDhQ0khY+EddBMj5neaX2uKm
 rujcOpu6kyJ79PBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775160283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3HmAi44bte2xXLu48NL4WSz/hv5iTMJK2fp1BmPntOk=;
 b=fxhg5ipEpc99bN3KszDotHKC0dfMLUkOJdoEiUmgZl5GtNexD8dq/o4j47qu3rSzBl6O8Y
 8KF83rSPSPsSVPx8FiFKQCZh923208RT9g7UT2XttGhBmbMiR/XWm+1yASuxDGxAunfyPP
 E/Y8fLzkYiI+ZDYUHEIMP2zu5JCBPZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775160283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3HmAi44bte2xXLu48NL4WSz/hv5iTMJK2fp1BmPntOk=;
 b=C/s+Sj8U9Brea4uNAL3FcXsjOTC3U7/DdYTUstx+TXm1mZNDhQ0khY+EddBMj5neaX2uKm
 rujcOpu6kyJ79PBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E11E84A0B0;
 Thu,  2 Apr 2026 20:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zCGeM9rLzmnoaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Apr 2026 20:04:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 22:04:31 +0200
Message-ID: <20260402200431.157875-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Remove s390x test
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
Cc: Elif Aslan <elas@linux.vnet.ibm.com>,
 Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

vmcp_m.sh is a pure user space test (out of LTP scope). While test
claims testing vmcp tool and module IMHO it's mainly testing vmcp basic
usage (-h, -v), exit codes on error. The only real use is 'vmcp q dasd'.

s390-tools maintainers confirmed they have internal CI and are working
on to be part of s390-tools on GitHub [1]. Another reason to remove.

Remove also runtest/s390x_tests, which contained only this test.

[1] https://github.com/ibm-s390-linux/s390-tools/issues/201

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/s390x_tests               |  2 --
 testcases/commands/vmcp/Makefile  | 10 -------
 testcases/commands/vmcp/vmcp_m.sh | 48 -------------------------------
 3 files changed, 60 deletions(-)
 delete mode 100644 runtest/s390x_tests
 delete mode 100644 testcases/commands/vmcp/Makefile
 delete mode 100644 testcases/commands/vmcp/vmcp_m.sh

diff --git a/runtest/s390x_tests b/runtest/s390x_tests
deleted file mode 100644
index 0c2bf05a5b..0000000000
--- a/runtest/s390x_tests
+++ /dev/null
@@ -1,2 +0,0 @@
-# Those tests are designed to be executed in s390x environment (zVM or LPAR)
-vmcp vmcp_m.sh
diff --git a/testcases/commands/vmcp/Makefile b/testcases/commands/vmcp/Makefile
deleted file mode 100644
index 544b044407..0000000000
--- a/testcases/commands/vmcp/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2026
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
deleted file mode 100644
index 3924a6e112..0000000000
--- a/testcases/commands/vmcp/vmcp_m.sh
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# vmcp tool and module test
-#
-# The tool allows Linux users to send commands to the z/VM control program (CP).
-# The normal usage is to invoke vmcp with the command you want to execute.
-#
-# The test case contains one shell script:
-#
-# basically executes the vmcp tool with different parameters and verifies that
-# output and exitcodes are as expected
-
-TST_CNT=2
-TST_TESTFUNC=vmcp_main
-TST_NEEDS_CMDS="vmcp"
-
-vmcp_run()
-{
-
-        $2
-        if [ $? -eq $1 ]; then
-            tst_res TPASS "'$2' returned '$1'"
-        else
-            tst_res TFAIL "'$2' did not return '$1'"
-        fi
-}
-
-vmcp_main1()
-{
-        tst_res TINFO "Verify basic VMCP commands"
-        vmcp_run 0 "vmcp --version";
-        vmcp_run 0 "vmcp --help";
-        vmcp_run 0 "vmcp -v";
-        vmcp_run 0 "vmcp -h";
-        vmcp_run 0 "vmcp q dasd";
-}
-
-vmcp_main2()
-{
-        tst_res TINFO "Verify error conditions"
-        vmcp_run 4 "vmcp -L"
-        vmcp_run 4 "vmcp -m q dasd"
-        vmcp_run 1 "vmcp dasddasddasd"
-}
-
-. tst_test.sh
-tst_run
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
