Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00715C4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 17:53:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B66B3CDD76
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 18:53:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1E713CDD6E
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 18:52:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1140600683
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 18:52:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 334F61F920;
 Thu, 10 Nov 2022 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668102762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAACcGneFGyGgIPC02bJ/t5qrxKAD3M4c5i4g9pJCTo=;
 b=VW2Cs3UtXJP4KvzJRiYXX4TnzG9rUN9DQvVBfSuJK/Gidx6QRVz/Nu4RY2P0aBbyQpYi5Y
 9sUWWANPIQXC6eeuDFMI0zTO/M3ecAFexxjzlNygZEWd7AkVQQ9BeoTxVJ9EtJkXsFRlIU
 cPiQJzOl7WMHILuFdYHlzdq3AeelpPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668102762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAACcGneFGyGgIPC02bJ/t5qrxKAD3M4c5i4g9pJCTo=;
 b=OXxHXCLwCxw8HpHuWRCgYLT1jBH9xB6f4R5o8ezUWAkfmlH/9apMFdusvnL1qaSmHEzx5s
 MHUaBpaoi/jQsYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A013A13B58;
 Thu, 10 Nov 2022 17:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EL9iI2k6bWM0GgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Nov 2022 17:52:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Nov 2022 18:52:35 +0100
Message-Id: <20221110175236.32094-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221110175236.32094-1-pvorel@suse.cz>
References: <20221110175236.32094-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib/tst_device: Remove unused count_match_len()
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>,
 Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: e1b1ae66b ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

obviously correct, but not merging it without ack there are changes and
function is actually needed.

Kind regards,
Petr

 lib/tst_device.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index db5c2ab8f..48d7e3ab6 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -510,16 +510,6 @@ unsigned long tst_dev_bytes_written(const char *dev)
 	return dev_bytes_written;
 }
 
-static int count_match_len(const char *first, const char *second)
-{
-	int len = 0;
-
-	while (*first && *first++ == *second++)
-		len++;
-
-	return len;
-}
-
 __attribute__((nonnull))
 void tst_find_backing_dev(const char *path, char *dev)
 {
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
