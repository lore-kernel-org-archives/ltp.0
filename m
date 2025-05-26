Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA25C5AD49
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 14:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83C8B3C2EFA
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 16:47:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56E393C0414
 for <ltp@lists.linux.it>; Mon, 26 May 2025 16:47:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B85201000BDD
 for <ltp@lists.linux.it>; Mon, 26 May 2025 16:47:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DABA31F893;
 Mon, 26 May 2025 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748270850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1CmSUiFMICXaMnxH96ouhIJF1rVvD3QUCAwQkYmWuh4=;
 b=cGhSUhrXPbCqdZX3dfOELU1EkaIQSoJSFrC4bj1UtUwSF2jlnBWy96pcSiMaLfNHmDsp3M
 +JvWpsIEELcM5sSGTBPbVYdl2KvGxUm7MZr9Pig9AiNSkAlsd0VTHhnNTcfCVeeCE4TvQX
 gGtG8IMMlGTuE31yAeck+KYarsKHvDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748270850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1CmSUiFMICXaMnxH96ouhIJF1rVvD3QUCAwQkYmWuh4=;
 b=YrLRAPDLPAlowmJdXiZeGUrRpLCp5H0hsi/84Kg4uMtFPvL0dsbpXbP1yrY3EDjSZtwgiC
 C1dvH5ChAbSPSECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748270849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1CmSUiFMICXaMnxH96ouhIJF1rVvD3QUCAwQkYmWuh4=;
 b=mXHi3WaBKhR+ybwDEVT1AlMP/6+TymkTv3OUN5Le9D84MPsQRqrk7AJDdKgkQ/Cot+8gyx
 1TPHRrePMgIbEqDy3v0O8W8Cr6a8+n5vpV7t5aO/ovHapNgiC/rp/vSJlbvZZDoT8yH8B1
 sxxH5bM8PUTN9a78jGo3Z27P4QG5yMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748270849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1CmSUiFMICXaMnxH96ouhIJF1rVvD3QUCAwQkYmWuh4=;
 b=ZJs0XVAR+7rhWge7MbsN51dtjfktfO9KOfaLnZ+gMoe7hiUvW+P16KLrNm93w8By7fw3/1
 HtynfxBw8cB6qaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B549013964;
 Mon, 26 May 2025 14:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dMgwKwF/NGjcUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 26 May 2025 14:47:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 26 May 2025 16:47:21 +0200
Message-ID: <20250526144721.144011-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] test_controllers: Remove cpuacct
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

cpuacct has been rewritten in 1bdfee68c9 to old shell API (and later
into new shell API) + moved into runtest/controllers. Old
run_cpuacct_test.sh was deleted.

Fixes: 1bdfee68c9 ("controllers/cpuacct: rewrote testcases")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Candidate for a release.

Kind regards,
Petr

 testcases/kernel/controllers/test_controllers.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/testcases/kernel/controllers/test_controllers.sh b/testcases/kernel/controllers/test_controllers.sh
index 7aa974ff25..587192ccde 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -47,8 +47,6 @@ then
 	IOTHROTTLE_CONTROLLER_VALUE=`grep -w blockio /proc/cgroups | cut -f4`;
 	FREEZER=`grep -w freezer /proc/cgroups | cut -f1`;
 	FREEZER_VALUE=`grep -w freezer /proc/cgroups | cut -f4`;
-	CPUACCOUNT_CONTROLLER=`grep -w cpuacct /proc/cgroups | cut -f1`
-	CPUACCOUNT_CONTROLLER_VALUE=`grep -w cpuacct /proc/cgroups | cut -f4`
 
 	if [ "$CPU_CONTROLLER" = "cpu" ] && [ "$CPU_CONTROLLER_VALUE" = "1" ]
 	then
@@ -100,16 +98,6 @@ then
 		echo "Kernel does not support freezer controller";
 		echo "Skipping all freezer testcases....";
 	fi
-	if [ "$CPUACCOUNT_CONTROLLER" = "cpuacct" ] && [ "$CPUACCOUNT_CONTROLLER_VALUE" = "1" ]
-        then
-                $LTPROOT/testcases/bin/run_cpuacct_test.sh 1;
-                $LTPROOT/testcases/bin/run_cpuacct_test.sh 2;
-        else
-                echo "Could not start cpu accounting controller test";
-		echo "Either Kernel does not support for cpu accounting controller or functionality is not enabled";
-                echo "usage: run_cpuacct_test.sh $TEST_NUM ";
-                echo "Skipping the cpu accounting controller test...";
-        fi
 else
 	echo "CONTROLLERS TESTCASES: WARNING"
 	echo "Kernel does not support any controller";
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
