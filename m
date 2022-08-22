Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A19C28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 15:47:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69773CA31C
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 17:47:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53F1C3C2A8C
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 17:47:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AC1001A00918
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 17:47:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EB693503C
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661183256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wGpAzbOtJFQM2j+t20EVg5Ln7T92VyvXYDx5+ZV+GE=;
 b=Pbruo43ynyHEKnIrzLfK9JGX8PUVexTLihwq0MMK8jJLRSWWcMXff97BqDsldtWLOiAW1D
 lN4Qx3Mq2Jwa4xUgZhYplYOgGQhS0Am83WcspbHdgjj7CEvK09RUcf/OLJlMIakbpJfayM
 zEtCaB40hP4XlUZHWu2YPt8D5jUV7WA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661183256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wGpAzbOtJFQM2j+t20EVg5Ln7T92VyvXYDx5+ZV+GE=;
 b=YEd0wFO93u6WW+NTmoSS/B/Qa5pu4Gr3K5tqhy2tRSp6eSJ/DwVD+ZOcny8AqTu8Bg1fks
 k0fWHhkmZ8P5elAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CE791332D
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZbOAERilA2NgIAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:47:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 22 Aug 2022 17:47:35 +0200
Message-Id: <20220822154735.26680-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] snd_timer01: Add missing tst_fzsync_start_race_*()
 calls
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The missing start_race() calls made the test essentially useless. Now it
works correctly, tested on SLE-12SP2 GM kernel which was vulnerable.

 testcases/kernel/sound/snd_timer01.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index 3d8e715e3..123d1a2cb 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -50,15 +50,11 @@ static void *ioctl_thread(void *unused)
 	tp.filter = 0xf;
 
 	while (tst_fzsync_run_b(&fzsync_pair)) {
-
+		tst_fzsync_start_race_b(&fzsync_pair);
 		ioctl(snd_fd, SNDRV_TIMER_IOCTL_TREAD, &tread_arg);
-
 		ioctl(snd_fd, SNDRV_TIMER_IOCTL_SELECT, &ts);
-
 		ioctl(snd_fd, SNDRV_TIMER_IOCTL_PARAMS, &tp);
-
 		ioctl(snd_fd, SNDRV_TIMER_IOCTL_START, 0);
-
 		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 	return unused;
@@ -101,8 +97,9 @@ static void run(void)
 	while (tst_fzsync_run_a(&fzsync_pair)) {
 		nz = 0;
 		memset(read_buf, 0, sizeof(read_buf));
-		size = readv(snd_fd, &iov, 1);
 
+		tst_fzsync_start_race_a(&fzsync_pair);
+		size = readv(snd_fd, &iov, 1);
 		tst_fzsync_end_race_a(&fzsync_pair);
 
 		/* check if it could be a valid ioctl result */
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
