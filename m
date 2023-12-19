Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC149C41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 12:37:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 028A93CF300
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 13:37:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2F093CAB62
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 13:37:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29BBC200750
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 13:37:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1E721F7C6;
 Tue, 19 Dec 2023 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702989433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEGVLfl7XU6D5IeurTkkOgS1iv91eECYrW1Y+i5CFOc=;
 b=Ia6EFgUDNyvI2U61rhCtsPq1hNqTExl0lqnWufLmloe7u1bq/o8Bi9AdKEL3pMR27g5C48
 tCU6f8n9UcqDmgYgDo4AvMkK2JZU2tFWz6fcLWFWpJpt//LjI9Sq6ILIoxKNq8hzGBEjZo
 4qVQ3LVZ7PTpWGohkRGtTFCe0j3MTc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702989433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEGVLfl7XU6D5IeurTkkOgS1iv91eECYrW1Y+i5CFOc=;
 b=KWsu075EN8rvJ9XhUFKz/h5oM2G4mp3NRzfJ4SVXulMMj3RLYBFTgBrTBYROY85iHGIvwn
 J5qXO+wYlfu+U4CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702989433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEGVLfl7XU6D5IeurTkkOgS1iv91eECYrW1Y+i5CFOc=;
 b=Ia6EFgUDNyvI2U61rhCtsPq1hNqTExl0lqnWufLmloe7u1bq/o8Bi9AdKEL3pMR27g5C48
 tCU6f8n9UcqDmgYgDo4AvMkK2JZU2tFWz6fcLWFWpJpt//LjI9Sq6ILIoxKNq8hzGBEjZo
 4qVQ3LVZ7PTpWGohkRGtTFCe0j3MTc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702989433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEGVLfl7XU6D5IeurTkkOgS1iv91eECYrW1Y+i5CFOc=;
 b=KWsu075EN8rvJ9XhUFKz/h5oM2G4mp3NRzfJ4SVXulMMj3RLYBFTgBrTBYROY85iHGIvwn
 J5qXO+wYlfu+U4CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B48E13BF1;
 Tue, 19 Dec 2023 12:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id zu1oD3mOgWWZXwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 19 Dec 2023 12:37:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 19 Dec 2023 13:37:09 +0100
Message-ID: <20231219123709.339435-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ia6EFgUD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KWsu075E
X-Rspamd-Queue-Id: A1E721F7C6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] net: tst_netload_compare(): Ignore performance
 failures
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

Performance failures in tests which use tst_netload_compare() (tests in
runtest/net.features) can hide a real error (e.g. test fails due missing
required kernel module). Best solution would be to have feature tests
(likely written in C API) and performance tests (the current ones).

But until it happens, just disable performance failure by default,
print TINFO message instead unless TST_NET_FEATURES_TEST_PERFORMANCE=1
environment variable is set.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh    | 12 +++++++++---
 testcases/lib/tst_test.sh   |  5 +++--
 testcases/network/README.md |  4 ++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index e47ee9676..46d49c266 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -869,16 +869,22 @@ tst_netload_compare()
 	local new_time=$2
 	local threshold_low=$3
 	local threshold_hi=$4
+	local ttype='TFAIL'
+	local msg res
 
 	if [ -z "$base_time" -o -z "$new_time" -o -z "$threshold_low" ]; then
 		tst_brk_ TBROK "tst_netload_compare: invalid argument(s)"
 	fi
 
-	local res=$(((base_time - new_time) * 100 / base_time))
-	local msg="performance result is ${res}%"
+	res=$(((base_time - new_time) * 100 / base_time))
+	msg="performance result is ${res}%"
 
 	if [ "$res" -lt "$threshold_low" ]; then
-		tst_res_ TFAIL "$msg < threshold ${threshold_low}%"
+		if [ -z "$TST_NET_FEATURES_TEST_PERFORMANCE" ]; then
+			ttype='TINFO';
+			tst_res_ TINFO "WARNING: slow performance is not treated as error, change it with TST_NET_FEATURES_TEST_PERFORMANCE=1"
+		fi
+		tst_res_ $ttype "$msg < threshold ${threshold_low}%"
 		return
 	fi
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 5f178a1be..06ee6005a 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2022
+# Copyright (c) Linux Test Project, 2014-2023
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -681,7 +681,8 @@ tst_run()
 			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
-			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
+			NETLOAD_CLN_NUMBER|NET_DATAROOT|NET_FEATURES_TEST_PERFORMANCE);;
+			NET_MAX_PKT|NET_RHOST_RUN_DEBUG);;
 			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
 			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
diff --git a/testcases/network/README.md b/testcases/network/README.md
index a0a1d3d95..0547c3f9f 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -84,6 +84,10 @@ Where
 Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
 Network stress parameters are documented in `testcases/network/stress/README`.
 
+Tests which use `tst_netload_compare()` test just basic functionality,
+performance failure is just printed with 'TINFO'. To enable also performance
+testing, set `TST_NET_FEATURES_TEST_PERFORMANCE=1` environment variable.
+
 ## Debugging
 Both single and two host configurations support debugging via
 `TST_NET_RHOST_RUN_DEBUG=1` environment variable.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
