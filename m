Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC5C83F33
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:30:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 686043CB7AE
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:30:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADEEB3CB78F
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:30:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A68CD1A010F9
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:30:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D6D951F85D;
 Tue,  5 Sep 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693906223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSrpRfjNAGgh7K9JBbPeEROPYyZr3utSBC0CR5kVhEU=;
 b=e8Sk3Ab3RkmWg3dcC76P0sJPzIWJrlbTAPX+p4zhI+RE5D3v9lckFXVPiUbLS2cAwBe8Ph
 AysDCGtQ7KhBK1ANaz9g418OQkZyJyk8yRsUS0ZclYdB50gdH9Qd3riqMP79WuAeUDMUbK
 W+491TiyjNvJTCBYtVEuiWUdq5x7aBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693906223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSrpRfjNAGgh7K9JBbPeEROPYyZr3utSBC0CR5kVhEU=;
 b=YtUgpIRSugdbMAywQ6BB/LxmQTS5f49/E2ziqa1W96aLd2ToC/FCIqL5Skrg1f9zWZKk9q
 BDz9BPY4P/fmfdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2DAF13911;
 Tue,  5 Sep 2023 09:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wB6sLi/19mSIMAAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 05 Sep 2023 09:30:23 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 11:30:19 +0200
Message-ID: <20230905093019.13881-3-mkittler@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905093019.13881-1-mkittler@suse.de>
References: <20230905093019.13881-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Detangle test cases for termio and termios
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

As suggested in the review it is clearer to separate the test
cases for termio and termios into separate entries in the
`tcases` array.
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 25 +++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 983208925..d552746f8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -36,35 +36,34 @@ static struct termios termios;
 
 static struct tcase {
 	int *fd;
-	int request_tio;
-	int request_tios;
-	struct termio *s_tio;
-	struct termios *s_tios;
+	int request;
+	void *s_tio;
 	int error;
 } tcases[] = {
 	/* file descriptor is invalid */
-	{&bfd, TCGETA, TCGETS, &termio, &termios, EBADF},
+	{&bfd, TCGETA, &termio, EBADF},
+	{&bfd, TCGETS, &termios, EBADF},
 	/* termio address is invalid */
-	{&fd, TCGETA, TCGETS, (struct termio *)-1, (struct termios *)-1, EFAULT},
+	{&fd, TCGETA, (struct termio *)-1, EFAULT},
+	{&fd, TCGETS, (struct termios *)-1, EFAULT},
 	// /* command is invalid */
 	/* This errno value was changed from EINVAL to ENOTTY
 	 * by kernel commit 07d106d0 and bbb63c51
 	 */
-	{&fd, INVAL_IOCTL, INVAL_IOCTL, &termio, &termios, ENOTTY},
+	{&fd, INVAL_IOCTL, &termio, ENOTTY},
+	{&fd, INVAL_IOCTL, &termios, ENOTTY},
 	/* file descriptor is for a regular file */
-	{&fd_file, TCGETA, TCGETS, &termio, &termios, ENOTTY},
+	{&fd_file, TCGETA, &termio, ENOTTY},
+	{&fd_file, TCGETS, &termios, ENOTTY},
 	/* termio is NULL */
-	{&fd, TCGETA, TCGETS, NULL, NULL, EFAULT}
+	{&fd, TCGETA, NULL, EFAULT}
 };
 
 static char *device;
 
 static void verify_ioctl(unsigned int i)
 {
-	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tio, tcases[i].s_tio),
-		     tcases[i].error);
-
-	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tios, tcases[i].s_tios),
+	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
 		     tcases[i].error);
 }
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
