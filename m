Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCA6C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:21:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CA6B3CEE25
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:21:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F33EB3CE5CE
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B200204B42
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:09 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE17B1F7D6;
 Thu, 14 Dec 2023 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWvpXRNDygZ3AaX/nKii0BxfyGM5SvD2L1DAz0K9buU=;
 b=GNOLXITDXtd2Hdo24kY0lt07xjxRKrF6iA4SGfHD9WiuagT/fIiNNmA2FnW0A7r7hbTkCb
 mVwiFWtNOjd64cavdGc2RI1vcfskn+X6tk0QjEHyZSMOaWqaLtRFMG4r2jdMk3N6FgUeDF
 ATvNOfiW9lXSjK92PuWaTEz7xLQ+QIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWvpXRNDygZ3AaX/nKii0BxfyGM5SvD2L1DAz0K9buU=;
 b=6iwOfQhM66s1pjh8fahtnCNh13HIuBy6xSqE7HZaMw4SOaJ9UqtfraOiO+owCYI9QM4PoY
 eldN0YZLrVipQ+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWvpXRNDygZ3AaX/nKii0BxfyGM5SvD2L1DAz0K9buU=;
 b=pZbabM6qh0ewHGPwPZtrykpsae7KsP3crhJ7RGDhDwGh3tabTOt8PqVQLEo+8E9rzTdksW
 GW5+1x4c/DSecvrCq2Rm+bfn7sBzHJXSeT7GX1ZX4nozhudC98PSRJAkG4QbQ0V0j0cEsb
 mav8COIZwk4LPJvs/uNIGcHWJw18Omg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWvpXRNDygZ3AaX/nKii0BxfyGM5SvD2L1DAz0K9buU=;
 b=hpcjRCulSHzUarP/2C8mgkqLtbWjIv9NPuaueyI5gdUUv8tiUl9Bq9VhRm71ggG1mImNsp
 ACnC7e9OExyHKVDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 89A62134B0;
 Thu, 14 Dec 2023 15:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mGsAECUde2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:20:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:50 +0100
Message-ID: <20231214151954.840244-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.974]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[41.03%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 06/10] can_rcv_own_msgs: Rename option -D => -d
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

-D will be used for enabling debug info.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/can/filter-tests/can_rcv_own_msgs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index 6bb2619f4..ba40666dc 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -134,7 +134,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"D:", &can_dev_name, "CAN device name"},
+		{"d:", &can_dev_name, "CAN device name"},
 		{}
 	},
 	.setup = setup,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
