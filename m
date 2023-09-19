Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F575CD54B0
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 10:25:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0C623CE451
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 12:25:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 556EF3CA6BC
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 12:24:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 759FA1000233
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 12:24:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 183212296D;
 Tue, 19 Sep 2023 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695119088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpZsfbF/QvlUjeb5fD/2m6G4RNHSySiz/UJT8MOVGcE=;
 b=BZLh0RBdZEcyPBiQaqG4cYRmxiETZob2z6enDfbv5A5vYS5gwLi6hoyEQKwLaV3KI+Lv4c
 cFaha8MJPFmnTyQd4fgoY/p+L37R279aDoaV5sEzrqp/xOMRcbBq4oiV9U/4NQePFVmzJt
 +WShi+b4PwKwM8+C/ELfnmyQnMs8kO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695119088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpZsfbF/QvlUjeb5fD/2m6G4RNHSySiz/UJT8MOVGcE=;
 b=gAdPPtz1fc9XeUis7I+w4lPmzCK8oG8MKWoftlth0mV2Ht2S8XmkNT1NbLlN316foJjFkC
 f+3MRKCHSauOdvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01F6D13458;
 Tue, 19 Sep 2023 10:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8A/3Ou92CWXOSAAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 19 Sep 2023 10:24:47 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 12:24:43 +0200
Message-ID: <20230919102445.23934-3-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919102445.23934-1-mkittler@suse.de>
References: <20230919102445.23934-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/4] Make checks for termio flags more strict
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
index d9427dbe4..b7548b4b3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -182,24 +182,21 @@ static int chk_tty_parms(void)
 		}
 	}
 
-	if (!
-	    (termio.c_lflag
-	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
+	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
+		 | NOFLSH)) {
 		tst_res(TINFO, "lflag has incorrect value. %o",
 			 termio.c_lflag);
 		flag++;
 	}
 
-	if (!
-	    (termio.c_iflag
-	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
-		 | IXOFF))) {
+	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
+		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
 		tst_res(TINFO, "iflag has incorrect value. %o",
 			 termio.c_iflag);
 		flag++;
 	}
 
-	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
+	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
 		tst_res(TINFO, "oflag has incorrect value. %o",
 			 termio.c_oflag);
 		flag++;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
