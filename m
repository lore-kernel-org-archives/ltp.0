Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C46CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:49:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CCCE3CD3EA
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:49:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAF963C8DBE
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 40BA11A02368
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64297219C0;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697183289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qR/hHNWoqXVpuClSz6a6F1Bnh/g35klcKFUaDRVwv1g=;
 b=t87b8W595tqs/dhVTqlQGiFaPdlPY4HBOhaRTxMdo+b9/DNNyoPmYEFsffQzCuNUzGcfJy
 poUtgDBeKRztBZQRnEuyYfisW3pyCyguBLFcB2t7hJPRIeMs+4x9B132kwwDPIiOxh62u2
 EVqaM+ideu8lA7ziuLG0f3etn1VYf78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697183289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qR/hHNWoqXVpuClSz6a6F1Bnh/g35klcKFUaDRVwv1g=;
 b=hgWVZZG0chp/AhUwNjSMJ+Qjk7xBn5lh+1aOGS/r2gE+oMkXyvMQxvmxO5kGUr0QgPydLR
 jSxNam3ByIpG8gDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40E4213ADB;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GEHZDjn2KGVqXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 07:48:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 09:47:47 +0200
Message-ID: <20231013074748.702214-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013074748.702214-1-pvorel@suse.cz>
References: <20231013074748.702214-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[42.60%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] can_bcm01: Move vcan to .modprobe
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/can/cve/can_bcm01.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index d9a835b03..ec98db133 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -41,14 +41,6 @@ static void setup(void)
 {
 	struct sockaddr_can addr = { .can_family = AF_CAN };
 
-	/*
-	 * Older kernels require explicit modprobe of vcan. Newer kernels
-	 * will load the modules automatically and support CAN in network
-	 * namespace which would eliminate the need for running the test
-	 * with root privileges.
-	 */
-	tst_cmd((const char*[]){"modprobe", "vcan", NULL}, NULL, NULL, 0);
-
 	NETDEV_ADD_DEVICE(LTP_DEVICE, "vcan");
 	NETDEV_SET_STATE(LTP_DEVICE, 1);
 	addr.can_ifindex = NETDEV_INDEX_BY_NAME(LTP_DEVICE);
@@ -143,10 +135,19 @@ static struct tst_test test = {
 	.skip_in_compat = 1,
 	.max_runtime = 30,
 	.needs_drivers = (const char *const[]) {
-		"vcan",
 		"can-bcm",
 		NULL
 	},
+	/*
+	 * Older kernels require explicit modprobe of vcan. Newer kernels
+	 * will load the modules automatically and support CAN in network
+	 * namespace which would eliminate the need for running the test
+	 * with root privileges.
+	 */
+	.modprobe = (const char *const[]) {
+		"vcan",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d5f9023fa61e"},
 		{"CVE", "2021-3609"},
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
