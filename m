Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B47EC433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:11:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B02E3CAAEC
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 14:11:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6C2F3CA62E
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:10:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3A9A91A011DF
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:10:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9338A21B63
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652962256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qzNZQgN0Dwf9UXxmZDWFHCenheYWjugBR0QZje76o10=;
 b=kbq7rqKD80yCko/yI1db6vNHDoXbmzEg1QVH3df1QKupjPHu9k5rHkrJgjMHKQ05Bq/kBS
 nhbywACA31MKpXxhs7oSY7n9fWyhNCd15X3mzA1SAOBLwFxRAXg65ao00YuEo/38QS/K5S
 61mEr+k+GFphhC4H5EFch2GRkAKsUXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652962256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qzNZQgN0Dwf9UXxmZDWFHCenheYWjugBR0QZje76o10=;
 b=pKS0eQGt5ziEV+eij8kG5+DCAqVDpKmj4Vn9axnu6DRL8gRu1DX5zCfIOD06tRE2c62THM
 gXK4ssQUyqWCg0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 827A913456
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jN78HtAzhmKhfgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:10:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 19 May 2022 14:10:55 +0200
Message-Id: <20220519121056.1181-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] pty07: Resize console to the same size as before
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

Resizing console to 1x1 breaks some QA automation systems. Keep the original
console dimensions throughout the test.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/pty/pty07.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index c63b71c89..ae600b692 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -40,6 +40,7 @@ static int test_tty_port = 8;
 static int fd = -1;
 static struct tst_fzsync_pair fzp;
 
+static struct vt_consize consize;
 static unsigned short vt_active;
 
 static void *open_close(void *unused)
@@ -60,13 +61,12 @@ static void *open_close(void *unused)
 
 static void do_test(void)
 {
-	struct vt_consize sz = { 0x1, 0x1, 0x1, 0x1, 0x1, 0x1 };
 
 	tst_fzsync_pair_reset(&fzp, open_close);
 
 	while (tst_fzsync_run_a(&fzp)) {
 		tst_fzsync_start_race_a(&fzp);
-		ioctl(fd, VT_RESIZEX, &sz);
+		ioctl(fd, VT_RESIZEX, &consize);
 		tst_fzsync_end_race_a(&fzp);
 		if (tst_taint_check()) {
 			tst_res(TFAIL, "Kernel is buggy");
@@ -79,6 +79,7 @@ static void do_test(void)
 static void setup(void)
 {
 	struct vt_stat stat;
+	struct winsize wsize;
 
 	sprintf(tty_path, "/dev/tty%d", test_tty_port);
 	if (access(tty_path, F_OK))
@@ -90,6 +91,9 @@ static void setup(void)
 
 	tst_res(TINFO, "Saving active console %i", vt_active);
 
+	SAFE_IOCTL(fd, TIOCGWINSZ, &wsize);
+	consize.v_rows = wsize.ws_row;
+	consize.v_cols = wsize.ws_col;
 	tst_fzsync_pair_init(&fzp);
 }
 
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
