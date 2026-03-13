Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B45105F7A6
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:27:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D61443E52AF
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:27:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2B163E57A0
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 616981001195
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DC954D315;
 Fri, 13 Mar 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA50040584;
 Fri, 13 Mar 2026 14:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGrIMX8etGlfQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 14:26:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 15:26:00 +0100
Message-ID: <20260313142600.243939-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313142600.243939-1-pvorel@suse.cz>
References: <20260313142600.243939-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1DC954D315
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] du01.sh: Rewrite into shell loader
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While at it, simplify variables: ${VAR} => $VAR

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/du/du01.sh | 88 +++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 7cdb98ca16..6a51a9d0b3 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -1,15 +1,36 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
 #
+# ---
+# doc
 # Test du command with some basic options.
+# ---
+#
+# ---
+# env
+# {
+#  "tcnt": 23,
+#  "needs_tmpdir": true,
+#  "needs_cmds": [
+#     {
+#       "cmd": "dd"
+#     },
+#     {
+#       "cmd": "du"
+#     },
+#     {
+#       "cmd": "stat"
+#     }
+#  ]
+# }
+# ---
+
+. tst_loader.sh
 
-TST_CNT=23
 TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="dd du stat"
 
 setup()
 {
@@ -17,10 +38,9 @@ setup()
 	cd basedir || tst_brk TBROK "cd basedir failed"
 
 	ROD_SILENT dd if=/dev/zero of=testfile bs=1M count=10
-
 	ROD_SILENT mkdir -p testdir
-
 	ROD_SILENT ln -s ../testfile testdir/testsymlink
+	cd ..
 
 	# Display values are in units of the first available SIZE
 	# from --block-size, and the DU_BLOCK_SIZE, BLOCK_SIZE and
@@ -34,12 +54,13 @@ setup()
 
 du_test()
 {
+	cd basedir || tst_brk TBROK "cd basedir failed"
 	local test_return
 
 	$1 > ../temp 2>&1
 	test_return=$?
 
-	if [ ${test_return} -ne 0 ]; then
+	if [ $test_return -ne 0 ]; then
 		grep -q -E "unrecognized option|invalid option" ../temp
 		if [ $? -eq 0 ]; then
 			tst_res TCONF "'$1' not supported"
@@ -69,7 +90,7 @@ block_size=$((block_size / 1024))
 # So we use the approximate value to check.
 check1="^10[2-3][0-9][0-9][[:space:]]\."
 check2="^10[2-3][0-9][0-9][[:space:]]testfile"
-check3="^\(0\|${block_size}\)[[:space:]]\./testdir/testsymlink"
+check3="^\(0\|$block_size\)[[:space:]]\./testdir/testsymlink"
 check5="^20[4-6][0-9][0-9][[:space:]]\."
 check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
 check9="^10[2-3][0-9][0-9][[:space:]]total"
@@ -79,34 +100,33 @@ check16="^10[2-3][0-9][0-9][[:space:]]testdir/"
 check20="^11M[[:space:]]\."
 check23="^[0-9]\{1,2\}[[:space:]]\."
 
-do_test()
+tst_test()
 {
 	case $1 in
-	1) du_test "du" ${check1};;
-	2) du_test "du testfile" ${check2};;
-	3) du_test "du -a" ${check3};;
-	4) du_test "du --all" ${check3};;
-	5) du_test "du -B ${block_size_default}" ${check5};;
-	6) du_test "du --block-size=${block_size_default}" ${check5};;
-	7) du_test "du -b" ${check7};;
-	8) du_test "du --bytes" ${check7};;
-	9) du_test "du -c" ${check9};;
-	10) du_test "du --total" ${check9};;
-	11) du_test "du -D testdir/testsymlink" ${check11};;
-	12) du_test "du --dereference-args testdir/testsymlink" ${check11};;
-	13) du_test "du --max-depth=1" ${check1};;
-	14) du_test "du --human-readable" ${check14};;
-	15) du_test "du -k" ${check1};;
-	16) du_test "du -L testdir/" ${check16};;
-	17) du_test "du --dereference testdir/" ${check16};;
-	18) du_test "du -P" ${check1};;
-	19) du_test "du --no-dereference" ${check1};;
-	20) du_test "du --si" ${check20};;
-	21) du_test "du -s" ${check1};;
-	22) du_test "du --summarize" ${check1};;
-	23) du_test "du --exclude=testfile" ${check23};;
+	1) du_test "du" $check1;;
+	2) du_test "du testfile" $check2;;
+	3) du_test "du -a" $check3;;
+	4) du_test "du --all" $check3;;
+	5) du_test "du -B $block_size_default" $check5;;
+	6) du_test "du --block-size=$block_size_default" $check5;;
+	7) du_test "du -b" $check7;;
+	8) du_test "du --bytes" $check7;;
+	9) du_test "du -c" $check9;;
+	10) du_test "du --total" $check9;;
+	11) du_test "du -D testdir/testsymlink" $check11;;
+	12) du_test "du --dereference-args testdir/testsymlink" $check11;;
+	13) du_test "du --max-depth=1" $check1;;
+	14) du_test "du --human-readable" $check14;;
+	15) du_test "du -k" $check1;;
+	16) du_test "du -L testdir/" $check16;;
+	17) du_test "du --dereference testdir/" $check16;;
+	18) du_test "du -P" $check1;;
+	19) du_test "du --no-dereference" $check1;;
+	20) du_test "du --si" $check20;;
+	21) du_test "du -s" $check1;;
+	22) du_test "du --summarize" $check1;;
+	23) du_test "du --exclude=testfile" $check23;;
 	esac
 }
 
-. tst_test.sh
-tst_run
+. tst_run.sh
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
