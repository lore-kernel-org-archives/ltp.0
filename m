Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8480ECAAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 14:43:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 068353CACCF
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 16:43:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 937093C91A6
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 16:42:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 214001400991
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 16:42:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2036321F82;
 Mon, 19 Sep 2022 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1663598577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8q+JSfGs0o5s5dxkLKapNpZSSyHllGfNWIopPQEXGPo=;
 b=JkCfknqG1qMuOZOMQ77dyOdJhQ0yGO/2gWnGF081YJFuoq0H5Zm8rnFeObIaEBwms1oq28
 uAShLYtp0hALl29K7WgJuE2aTBmdpYy7AtkgSTo2Nfz39VewmIxhtraDvNWk2wVuoVphX4
 rszaG/Z9x/Xy7XSqBQ9HWkQHecc8Cvw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 774CC13ABD;
 Mon, 19 Sep 2022 14:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WBAbF/B/KGO3ZgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 19 Sep 2022 14:42:56 +0000
To: ltp@lists.linux.it
Date: Mon, 19 Sep 2022 16:41:54 +0200
Message-Id: <20220919144154.20623-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Remove obsolete LTPROOT usage in math runtest file
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/math | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/runtest/math b/runtest/math
index 110c41e73..6915ebe05 100644
--- a/runtest/math
+++ b/runtest/math
@@ -3,11 +3,11 @@ abs01 abs01
 
 atof01 atof01
 
-float_bessel cd $LTPROOT/testcases/bin; float_bessel -v
-float_exp_log cd $LTPROOT/testcases/bin; float_exp_log -v
-float_iperb cd $LTPROOT/testcases/bin; float_iperb -v
-float_power cd $LTPROOT/testcases/bin; float_power -v
-float_trigo cd $LTPROOT/testcases/bin; float_trigo -v
+float_bessel float_bessel -v
+float_exp_log float_exp_log -v
+float_iperb float_iperb -v
+float_power float_power -v
+float_trigo float_trigo -v
 
 fptest01 fptest01
 fptest02 fptest02
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
