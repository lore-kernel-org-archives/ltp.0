Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A407C433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27E083CAAD1
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 14:11:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEA4B3CA62E
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:10:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61B361401190
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:10:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6FB01FA15
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652962256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rx7jG8PXabmeO2Fa7bAHaWJbXlg+epasrEV2izWsQ9k=;
 b=Xs40JNiC15C2mG6RZ6lelBrl+X3e5yRkxrK8Adh8SqvtclKy5KhYLiTiDG8bRnyuZAXi8R
 OJQ3ZXtTcBJR7HPTX2F49qSbs0uHDRtmLtY1PHuOft4D5y8f2OhMGyoFYqmh+V6kLTlW4M
 xZOgpILJChE1z3u+0U3MVc37jX9INu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652962256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rx7jG8PXabmeO2Fa7bAHaWJbXlg+epasrEV2izWsQ9k=;
 b=U7M6jeOC0+HUxCNtSHEkEtB+JfHzKzTzD5XDs27sGaWvdi7lAekH5U9M5FaUrAQIe97XPv
 H97/VcpqHMBqGOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9388513B1E
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id INA8I9AzhmKhfgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:10:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 19 May 2022 14:10:56 +0200
Message-Id: <20220519121056.1181-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519121056.1181-1-mdoucha@suse.cz>
References: <20220519121056.1181-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] pty04: Fix cleanup
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

If pty04 gets executed with -i0 argument, the sk file descriptor will
stay zero and cleanup() will close stdin, which can result in the parent
shell logging out. Initialize global file descriptors to -1 and only
clean up those that were left open by the test.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/pty/pty04.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 00b714c82..c2510d8fe 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -92,7 +92,7 @@ static struct ldisc_info ldiscs[] = {
 	{N_SLCAN, "N_SLCAN", CAN_MTU},
 };
 
-static int ptmx, pts, sk, mtu, no_check;
+static int ptmx = -1, pts = -1, sk = -1, mtu, no_check;
 
 static int set_ldisc(int tty, const struct ldisc_info *ldisc)
 {
@@ -455,9 +455,14 @@ static void do_test(unsigned int n)
 
 static void cleanup(void)
 {
-	ioctl(pts, TIOCVHANGUP);
-	ioctl(ptmx, TIOCVHANGUP);
-	close(sk);
+	if (pts >= 0)
+		ioctl(pts, TIOCVHANGUP);
+
+	if (ptmx >= 0)
+		ioctl(ptmx, TIOCVHANGUP);
+
+	if (sk >= 0)
+		close(sk);
 
 	tst_reap_children();
 }
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
