Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CAEC873A
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 15:52:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED09B3CE9AB
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 17:51:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C15C3CBAB8
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 17:51:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 472BF140051D
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 17:51:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE70D1F88D;
 Thu,  7 Sep 2023 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694101908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c2j2e3L0KtSbmMPUYbqZ5sHeQ4wrdvV59EzRZM8loQ=;
 b=fy3H42HOXLa+/tM49usZOULiZItUcjtKP7ZcY3LssHacge5qE/HUMkBy4bhvwky1j6NixQ
 kEjov0GIuYzL2mx8RLzDePADeeV9FS629NwYf1oG8ZeJ7oXansjtyT08pxffRv8kLYMxww
 /z0ENQvNIwT+e+Wjhmn32Dp5recl70g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694101908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c2j2e3L0KtSbmMPUYbqZ5sHeQ4wrdvV59EzRZM8loQ=;
 b=7O0WMFKwfp4TM88t7Y0eIshea2/TUWVcwZ9StMN4EwbQPV1nEiRbP3AYWKnRbsLFH2blS/
 jAyxqhHn3K0QLHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA12913ADD;
 Thu,  7 Sep 2023 15:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eOSZLJTx+WReCwAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 07 Sep 2023 15:51:48 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 17:51:43 +0200
Message-ID: <20230907155144.21697-4-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907155144.21697-1-mkittler@suse.de>
References: <20230907155144.21697-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] Make checks for termio flags more strict
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

The checks for termio flags can actually use a `!=` check to
also fail when any unexpected flags are present.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 72a446f99..6b0924c65 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -224,24 +224,21 @@ static int chk_tty_parms(void)
 		}
 	}
 
-	if (!
-	    (termio.c_lflag
-	     & (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
+	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
+		 | NOFLSH)) {
 		tst_res(TINFO, "lflag has incorrect value. %o",
 			 termio.c_lflag);
 		flag++;
 	}
 
-	if (!
-	    (termio.c_iflag
-	     & (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
-		 | IXOFF))) {
+	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
+		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
 		tst_res(TINFO, "iflag has incorrect value. %o",
 			 termio.c_iflag);
 		flag++;
 	}
 
-	if (!(termio.c_oflag & (OPOST | OLCUC | ONLCR | ONOCR))) {
+	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
 		tst_res(TINFO, "oflag has incorrect value. %o",
 			 termio.c_oflag);
 		flag++;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
