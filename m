Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204A3C433FE
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 16:33:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 223C33C8C96
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 17:33:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC3623C8AAF
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 17:33:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47FB86008A6
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 17:33:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61B0D210FB;
 Fri, 11 Mar 2022 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647016387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Zo2EcT9gMKYsM1zrZ/YeD7U/sDYwyJPS+E8VQPNJuak=;
 b=B4oJWp0MkFwaqw54SaBpN7pvoYxVhMLgqddLIAZvk4wsJIFazhPT0YtDtAmCFgUFOqu1zK
 D2WLmZDTT3qCfwIYZvgGiRlYaOmz1/z1RiwnidUZJa3PiVRiF4E5WSsAIFJS+y/Mj1SbXU
 SVwrYuLu781hswZxupNR5E37kagn/iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647016387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Zo2EcT9gMKYsM1zrZ/YeD7U/sDYwyJPS+E8VQPNJuak=;
 b=+UMYwfqwSOBLkCJ3BVEdLrsedMm5TSIZvg+ij8FIelkbODYzKUrCubTSl3gtJLDMjFUc3B
 JJfKvSeTMCo1meDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48BB213A89;
 Fri, 11 Mar 2022 16:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hO/AEMN5K2JGLAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Mar 2022 16:33:07 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>,
	ltp@lists.linux.it
Date: Fri, 11 Mar 2022 17:33:05 +0100
Message-Id: <20220311163306.17416-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hello Xu, try whether these two patches properly detect the kernel crash
in timer. The patches are mutually exclusive and the second one includes
all the changes from the first one. Merging only the first patch is preferred
if it works.

 .../kernel/syscalls/setsockopt/setsockopt09.c      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 4b1ce2e92..f715bbc91 100644
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
@@ -85,6 +90,14 @@ static void run(void)
 	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
 	SAFE_CLOSE(sock);
 
+	/* Wait for socket timer to expire just in case */
+	usleep(req.tp_retire_blk_tov * 3000);
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
+
 	tst_res(TPASS, "Nothing bad happened, probably");
 }
 
@@ -111,6 +124,7 @@ static struct tst_test test = {
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
