Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB80FC47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:10:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B28B23CE6EC
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:10:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4E943CD2B8
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:10:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9449B60110D
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:10:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 682511F805;
 Thu,  4 Jan 2024 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ktc6noVUgqt/ohF7v9LZuM/vHXXvawmFlAwfBqp+J1w=;
 b=MV12nOf1stYUXUmLBXcOddoxResYY6rOA/39Ov+XOczQUrYjaCMiPTqBZsZv9OCU0DziWW
 tBXuN1mRlGWLAyY272EdNGmMbTHAWqEWgG4nD1mpqfUKDLaTmc2kBBPDIaDpHm3KIrMCZ1
 FOttT/4ujIrBaHpfXZdHQgbbmj9KvQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ktc6noVUgqt/ohF7v9LZuM/vHXXvawmFlAwfBqp+J1w=;
 b=mHM7ZlcyqxL+reDq4XEe12dFsAdUZehy193U7HNCNMb88CzvrTBVeqJcgpR9YIEKcs/f53
 LfmBcluW6DemJwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ktc6noVUgqt/ohF7v9LZuM/vHXXvawmFlAwfBqp+J1w=;
 b=MV12nOf1stYUXUmLBXcOddoxResYY6rOA/39Ov+XOczQUrYjaCMiPTqBZsZv9OCU0DziWW
 tBXuN1mRlGWLAyY272EdNGmMbTHAWqEWgG4nD1mpqfUKDLaTmc2kBBPDIaDpHm3KIrMCZ1
 FOttT/4ujIrBaHpfXZdHQgbbmj9KvQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ktc6noVUgqt/ohF7v9LZuM/vHXXvawmFlAwfBqp+J1w=;
 b=mHM7ZlcyqxL+reDq4XEe12dFsAdUZehy193U7HNCNMb88CzvrTBVeqJcgpR9YIEKcs/f53
 LfmBcluW6DemJwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 643F9137E8;
 Thu,  4 Jan 2024 12:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iC6uFSaglmUzEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:10:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 13:10:01 +0100
Message-ID: <20240104121001.1155491-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MV12nOf1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mHM7Zlcy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 682511F805
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] net: tst_netload_compare(): Ignore performance
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

But until it happens, allow to ignore performance failure with
environment variable LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* Ignoring performance requires setting LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1
(previously it was ignored by default, Martin), therefore rename the variable.
* Variable uses LTP_ prefix (user defined), thus no need to whitelist it
in tst_net.sh.

Martin also pointed out that message can be printed multiple times, but I
don't think this is a problem (it's better that tester sees it).

 testcases/lib/tst_net.sh    | 19 +++++++++++++++----
 testcases/network/README.md |  4 ++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 2ed0e787f..6cf7f2fcb 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2016-2023 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2016-2024 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 [ -n "$TST_LIB_NET_LOADED" ] && return 0
@@ -863,22 +863,33 @@ tst_netload()
 # TIME: time that is compared to the base one
 # THRESHOD_LOW: lower limit for TFAIL
 # THRESHOD_HIGH: upper limit for TWARN
+#
+# Slow performance can be ignored with setting environment variable
+# LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1
 tst_netload_compare()
 {
 	local base_time=$1
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
+		if [ "$LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE" = 1 ]; then
+			ttype='TINFO';
+			tst_res_ TINFO "WARNING: slow performance is not treated as error due LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1"
+		else
+			tst_res_ TINFO "Following slow performance can be ignored with LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1"
+		fi
+		tst_res_ $ttype "$msg < threshold ${threshold_low}%"
 		return
 	fi
 
diff --git a/testcases/network/README.md b/testcases/network/README.md
index a0a1d3d95..e1b1296d6 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -84,6 +84,10 @@ Where
 Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
 Network stress parameters are documented in `testcases/network/stress/README`.
 
+Tests which use `tst_netload_compare()` test also performance. They can fail on
+overloaded SUT.  To ignore performance failure and test only the network functionality,
+set `LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1` environment variable.
+
 ## Debugging
 Both single and two host configurations support debugging via
 `TST_NET_RHOST_RUN_DEBUG=1` environment variable.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
