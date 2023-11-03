Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52938C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F0903CC816
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 17:04:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5CFA3CB4DB
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:03:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2304D14052F7
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:03:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC28F1F45F;
 Fri,  3 Nov 2023 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699027434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WmaY7C5YtnyEzuof2TCVZE0UUGgd2ny/1fWnJunNtmU=;
 b=QpNuR7SRijn870GvADxStDgUXW38T1cn/m55/bRbx1pbxKZMhj5lsUlsy1C3As7UDFI/7m
 BZev0SkV9q5iN9qC/LWnbHXcartTKx/AHWiB9gM0oOOx0zHlcDLolN2l1REBJLS7GM1VVs
 9tD47nbo8t+lGoTjRB4TISxcLczFfhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699027434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WmaY7C5YtnyEzuof2TCVZE0UUGgd2ny/1fWnJunNtmU=;
 b=vd+MFW2udqC3deq7MdGKi4waTDGoG4AwmeGv2JMSle4Kf5DGNJTPlrsZcqFG9S5uUEXQdb
 bewuy6SugwY/xQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 020C813907;
 Fri,  3 Nov 2023 16:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JYUAOukZRWU0PwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 16:03:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  3 Nov 2023 17:03:50 +0100
Message-ID: <20231103160350.1096410-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib/tst_module.c: Replace "rmmod" with "modprobe
 -r"
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

"modprobe -r" will remove also the dependencies loaded for kernel
modules.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_module.c b/lib/tst_module.c
index 9bd443623..e52bb6e00 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -105,7 +105,7 @@ void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name)
 {
 	int i, rc;
 
-	const char *const argv[] = { "rmmod", mod_name, NULL };
+	const char *const argv[] = { "modprobe", "-r", mod_name, NULL };
 
 	rc = 1;
 	for (i = 0; i < 50; i++) {
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
