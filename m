Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC43E7717F
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9523E9472
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 01:14:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F12DA3E9465
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 01:14:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D1CD218ECB
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 01:14:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B135B1F38F;
 Wed, 11 Dec 2024 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733876062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U9JlBO7cpf6NMr24//QP7mTaKd6pioptwUii4L9msNk=;
 b=fDuBi10XUp38SFEHxdZDXAQJ0RIcM1RMLpzaT7xcC19/2CVPZ8A6b6B0dSOpUx/ScYGp9k
 Gwti+IT3cyfSfSBvikqGEOdKJzFTtYCO1Kv19PQ4m5WmLKtmynI2w5c+NR8zEGaLKMh4CN
 E3RGS0d609voC8TBizo3RRAfvUZuuq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733876062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U9JlBO7cpf6NMr24//QP7mTaKd6pioptwUii4L9msNk=;
 b=4R+1dPjx4hSuBhmf+cLpOoI+7Qkh6ll5G2ah1+k3neyXyyySVFYCUtjshInqTN9NvFDkAX
 SMGK5+uK57BJVqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733876062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U9JlBO7cpf6NMr24//QP7mTaKd6pioptwUii4L9msNk=;
 b=fDuBi10XUp38SFEHxdZDXAQJ0RIcM1RMLpzaT7xcC19/2CVPZ8A6b6B0dSOpUx/ScYGp9k
 Gwti+IT3cyfSfSBvikqGEOdKJzFTtYCO1Kv19PQ4m5WmLKtmynI2w5c+NR8zEGaLKMh4CN
 E3RGS0d609voC8TBizo3RRAfvUZuuq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733876062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U9JlBO7cpf6NMr24//QP7mTaKd6pioptwUii4L9msNk=;
 b=4R+1dPjx4hSuBhmf+cLpOoI+7Qkh6ll5G2ah1+k3neyXyyySVFYCUtjshInqTN9NvFDkAX
 SMGK5+uK57BJVqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 360E71344A;
 Wed, 11 Dec 2024 00:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A4G5CF7ZWGclPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 00:14:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Dec 2024 01:14:18 +0100
Message-ID: <20241211001418.392890-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix TBROK => TWARN evaluation
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

./nfs10.sh -v 3 -t udp
nfs10 1 TINFO: Running: nfs10.devel.sh -v 3 -t udp
nfs10 1 TINFO: Tested kernel: Linux ts 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64 x86_64 x86_64 GNU/Linux
nfs10 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfs10 1 TINFO: add local addr 10.0.0.2/24
nfs10 1 TINFO: add local addr fd00:1:1:1::2/64
nfs10 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfs10 1 TINFO: add remote addr 10.0.0.1/24
nfs10 1 TINFO: add remote addr fd00:1:1:1::1/64
nfs10 1 TINFO: Network config (local -- remote):
nfs10 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfs10 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfs10 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
nfs10 1 TINFO: Using /tmp/LTP_nfs10.fMhZnmFim0 as tmpdir (tmpfs filesystem)
tst_device.c:299: TWARN: Failed to create test_dev.img: ENOSPC (28)

Usage:
tst_device acquire [size [filename]]
tst_device release /path/to/device
tst_device clear /path/to/device

nfs10 1 TWARN: Failed to acquire device
=> This should be TBROK, but it wasn't due TST_CLEANUP being defined in tst_brk()
(any test with TST_CLEANUP=1 did not exit when tst_brk TBROK was called
from tst_test.sh due failure in early phase).

Fixing it by splitting $TST_DO_CLEANUP variable into two functions:

* $TST_DO_CLEANUP is a guarder for running cleanup function only once
  (similar to $TST_DO_EXIT).
* Introduce new variable $TST_TEST_STARTED to indicate that test was
  started. Previously $TST_DO_CLEANUP was misused for this because the
  name suggests it (regression in 5c36ae3e30).

Also print TWARN when cleanup function is not found due '. tst_test.sh'
(or other shell library which loads it) is not at the end of the test
(before tst_run). After 04021637f4 all tests load library late enough,
but it's better to keep this check.

Fixes: 5c36ae3e30 ("tst_test.sh: Call cleanup function only after test start")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index cfdae02300..eddb38a80b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2022
+# Copyright (c) Linux Test Project, 2014-2024
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -26,15 +26,20 @@ trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
 _tst_do_cleanup()
 {
-	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
-		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
-			TST_DO_CLEANUP=
-			$TST_CLEANUP
-		else
-			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
-		fi
+	# run cleanup only once, when not requested by user to skip
+	if [ -n "$TST_DO_CLEANUP" ] || [ -z "$LTP_NO_CLEANUP" ]; then
+		return 0
+	fi
+
+	TST_DO_CLEANUP=1
+
+	if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
+		$TST_CLEANUP
+	elif [ -z "$TST_TEST_STARTED" ]; then
+		tst_res TWARN "Attempt to run cleanup function before test has started => '. tst_test.sh' should be at the end of the file"
+	else
+		tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or command not found)"
 	fi
-	TST_DO_CLEANUP=
 }
 
 _tst_do_exit()
@@ -128,9 +133,8 @@ tst_brk()
 	shift
 
 	# TBROK => TWARN on cleanup or exit
-	if [ "$res" = TBROK ] && [ "$TST_DO_EXIT" = 1 -o -z "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" ]; then
+	if [ "$res" = TBROK ] && [ "$TST_DO_EXIT" = 1 -o "$TST_DO_CLEANUP" = 1 ]; then
 		tst_res TWARN "$@"
-		TST_DO_CLEANUP=
 		return
 	fi
 
@@ -798,7 +802,7 @@ _tst_run_iterations()
 
 	if [ -n "$TST_SETUP" ]; then
 		if command -v $TST_SETUP >/dev/null 2>/dev/null; then
-			TST_DO_CLEANUP=1
+			TST_TEST_STARTED=1
 			$TST_SETUP
 		else
 			tst_brk TBROK "TST_SETUP=$TST_SETUP declared, but function not defined (or cmd not found)"
@@ -834,7 +838,7 @@ _tst_run_tests()
 	local _tst_data="$1"
 	local _tst_i
 
-	TST_DO_CLEANUP=1
+	TST_TEST_STARTED=1
 	for _tst_i in $(seq ${TST_CNT:-1}); do
 		if command -v ${TST_TESTFUNC}1 > /dev/null 2>&1; then
 			_tst_run_test "$TST_TESTFUNC$_tst_i" $_tst_i "$_tst_data"
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
