Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A136C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 16:33:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 381733C8C9A
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 17:33:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFD093C8C82
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 17:33:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55CEC14010E0
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 17:33:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 855C31F37F;
 Fri, 11 Mar 2022 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647016387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSYoTqfkf1ITGD0MECXguQmrfiyK3C7vSkB0/aqvt84=;
 b=e7yq/kdOCcIfVb3lRZZykR5U+j1XwzxR7dcw9qNLi3R63w/Tt8XtvCqoYA50FlVXWud28t
 aPc9u+GD6pECvQSKJ3eNK7Q6JpToJ9rFXctQYpotCfUphVD1Yfd2SLwPv4Mluaapvf/GBM
 RLPLG7M4yft9FoT6QhHKC8lRPx+wyZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647016387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSYoTqfkf1ITGD0MECXguQmrfiyK3C7vSkB0/aqvt84=;
 b=2/SNLaT9SJEh1XwySTauQjBRC1kK1hVskfZdq7vw76w3818JSLmn+CdI1IkHP9u4hVzMPV
 R6ScOaf2du3ApiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6397D13FA6;
 Fri, 11 Mar 2022 16:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ABlXF8N5K2JGLAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Mar 2022 16:33:07 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>,
	ltp@lists.linux.it
Date: Fri, 11 Mar 2022 17:33:06 +0100
Message-Id: <20220311163306.17416-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311163306.17416-1-mdoucha@suse.cz>
References: <20220311163306.17416-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/setsockopt09: Test use-after-free in socket
 timer
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

setsockopt09 may also trigger kernel crash in socket timer. Add git hash
for the timer fix and add taint check to detect this failure variant.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setsockopt/setsockopt09.c | 68 ++++++++++++-------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 4b1ce2e92..3047ec0ff 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -19,6 +19,11 @@
  *
  *  net/packet: rx_owner_map depends on pg_vec
  *
+ *  commit c800aaf8d869f2b9b47b10c5c312fe19f0a94042
+ *  Author: WANG Cong <xiyou.wangcong@gmail.com>
+ *  Date:   Mon Jul 24 10:07:32 2017 -0700
+ *
+ *  packet: fix use-after-free in prb_retire_rx_blk_timer_expired()
  */
 
 #define _GNU_SOURCE
@@ -50,41 +55,55 @@ static void setup(void)
 
 static void run(void)
 {
-	unsigned int version = TPACKET_V3;
+	unsigned int i, version = TPACKET_V3;
 	struct tpacket_req3 req = {
 		.tp_block_size = 4 * pagesize,
-		.tp_block_nr = 256,
 		.tp_frame_size = TPACKET_ALIGNMENT << 7,
 		.tp_retire_blk_tov = 64,
 		.tp_feature_req_word = TP_FT_REQ_FILL_RXHASH
 	};
 
-	req.tp_frame_nr = req.tp_block_size * req.tp_block_nr;
-	req.tp_frame_nr /= req.tp_frame_size;
-
-	sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, 0);
-	TEST(setsockopt(sock, SOL_PACKET, PACKET_VERSION, &version,
-		sizeof(version)));
+	for (i = 0; i < 5; i++) {
+		req.tp_block_nr = 256;
+		req.tp_frame_nr = req.tp_block_size * req.tp_block_nr;
+		req.tp_frame_nr /= req.tp_frame_size;
+
+		sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, 0);
+		TEST(setsockopt(sock, SOL_PACKET, PACKET_VERSION, &version,
+			sizeof(version)));
+
+		if (TST_RET == -1 && TST_ERR == EINVAL)
+			tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
+
+		if (TST_RET) {
+			tst_brk(TBROK | TTERRNO,
+				"setsockopt(PACKET_VERSION, TPACKET_V3)");
+		}
+
+		/* Allocate owner map and then free it again */
+		SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req,
+			sizeof(req));
+		req.tp_block_nr = 0;
+		req.tp_frame_nr = 0;
+		SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req,
+			sizeof(req));
+
+		/* Switch packet version and trigger double free of owner map */
+		SAFE_SETSOCKOPT_INT(sock, SOL_PACKET, PACKET_VERSION,
+			TPACKET_V2);
+		SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req,
+			sizeof(req));
+		SAFE_CLOSE(sock);
 
-	if (TST_RET == -1 && TST_ERR == EINVAL)
-		tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
+		/* Wait for socket timer to expire just in case */
+		usleep(req.tp_retire_blk_tov * 3000);
 
-	if (TST_RET) {
-		tst_brk(TBROK | TTERRNO,
-			"setsockopt(PACKET_VERSION, TPACKET_V3)");
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable");
+			return;
+		}
 	}
 
-	/* Allocate owner map and then free it again */
-	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
-	req.tp_block_nr = 0;
-	req.tp_frame_nr = 0;
-	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
-
-	/* Switch interface version and trigger double free of owner map */
-	SAFE_SETSOCKOPT_INT(sock, SOL_PACKET, PACKET_VERSION, TPACKET_V2);
-	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
-	SAFE_CLOSE(sock);
-
 	tst_res(TPASS, "Nothing bad happened, probably");
 }
 
@@ -111,6 +130,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ec6af094ea28"},
+		{"linux-git", "c800aaf8d869"},
 		{"CVE", "2021-22600"},
 		{}
 	}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
