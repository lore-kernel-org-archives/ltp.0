Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E336CC433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 07:23:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F1D3CA3AC
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 09:23:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B27653CA2C1
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 09:23:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EB6741400189
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 09:23:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3F9821EE7;
 Fri,  8 Jul 2022 07:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657265013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/V5YmOEFsqqgkIiCF2a4wnUEWzeY5xZgH5utSvNFA+A=;
 b=JAAtJrViM+TBP/CeVu6ET6t4NlPUAcW7ynlGqOJXEbvURu9chfOyCxo7sxxLmBxHRNRLXU
 zIG8UlWLT/5snm3nXAlrX50KXORFpgb3QUxMenh8W/JDje0yzas2Bv3wdappHhIKgqrFeH
 dOi1BGxPR66IkIdeOWtRszhm9waGZ8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657265013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/V5YmOEFsqqgkIiCF2a4wnUEWzeY5xZgH5utSvNFA+A=;
 b=OqiSJ+0XGMd/ib1b6i1p+gHusl3jHvIetXQtKKHoM5/ZshylQUIPUA3uDu8QGi81Bhq7tg
 geG3urJ+MXzRLeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F59613A7D;
 Fri,  8 Jul 2022 07:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yEYnBnTbx2KHEAAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 08 Jul 2022 07:23:32 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Jul 2022 12:53:26 +0530
Message-Id: <20220708072326.32571-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Docparse correction in C test tutorial
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 doc/c-test-tutorial-simple.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index 06d2ca55d..c09613e37 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -120,8 +120,8 @@ kernel version if necessary. I will explain what the code does below.
  * Copyright (c) 2017 Instruction Ignorer <"can't"@be.bothered.com>
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
  *
  * All tests should start with a description of _what_ we are testing.
  * Non-trivial explanations of _how_ the code works should also go here.
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
