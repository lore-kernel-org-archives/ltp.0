Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB12CDB463
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F29D03D004A
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 18:24:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00C33C8B68
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:24:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E28DA10009B6
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:24:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 915A21FF03;
 Wed, 11 Oct 2023 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697041473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BX4chxgcFhxZ2klS5Z/jDsRZ687zfBGQXh2uFYx6MQ=;
 b=SCbPA8ff5IrckV83W0g7eDHBLzL7H+NSq6xYHOPLne30UzSvFoYv/A0cNuYskFtEJOGPoW
 mA+DrBSFY6MRb6vg4nmygnqVJKYcx1u1QFoIrQ1HZ/v3N+7qTNJDHTPolZTEuVrtx44k5b
 gzoQv0zZAqzbM+OOIIKeQ3cRy6+fOIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697041473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BX4chxgcFhxZ2klS5Z/jDsRZ687zfBGQXh2uFYx6MQ=;
 b=sWyKO9qfFU0jM/Zu2tv+CsFCAPHulgUFWK+/tcSKrOIVzSGti4IIlypb91gNXSwFOkM39L
 74G90xsB71S8QoBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D5A113A7A;
 Wed, 11 Oct 2023 16:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EB7yDEHMJmVIKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 16:24:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:24:28 +0200
Message-ID: <20231011162428.583911-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011162428.583911-1-pvorel@suse.cz>
References: <20231011162428.583911-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] swapon01: Simplify code, add copyright
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

Remove  ambiguous comment with -i option during swapoff,
it's needed for a test cleanup anyway.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I wonder which command's -i option is meant. runltp -i ? swapon does not
have -i option.

Kind regards,
Petr

 testcases/kernel/syscalls/swapon/swapon01.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 6b7f96cf7..9286751a3 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
  */
 
 /*\
@@ -21,18 +22,11 @@
 
 static void verify_swapon(void)
 {
-	TEST(tst_syscall(__NR_swapon, SWAP_FILE, 0));
+	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
 
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "Failed to turn on swapfile");
-	} else {
-		tst_res(TPASS, "Succeeded to turn on swapfile");
-		/*we need to turn this swap file off for -i option */
-		if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
-			tst_brk(TBROK | TERRNO, "Failed to turn off swapfile,"
-				" system reboot after execution of LTP "
-				"test suite is recommended.");
-		}
+	if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
+		tst_brk(TBROK | TERRNO,
+				"Failed to turn off swapfile, system reboot recommended");
 	}
 }
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
