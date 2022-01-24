Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C1DC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 17:37:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF5A43C928D
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 18:37:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E4D13C8840
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:37:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C2B96005F3
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:37:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 877181F37D;
 Mon, 24 Jan 2022 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643045836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5V/lct0cH3QJjONlLWxCLiU0PY/Can4t0fk2Jgw7Kpc=;
 b=Mf7th9hcUtOc1AtzA4La2e4xGqn8FTRYa/wnahZ/FgawFYJdIXF/bI24ALRVki0xSl4IV9
 Gnfr7SVPDSKvXe7vWA4eKkv4hlB/GniiH2i0j3HfBwSGnb5JU9+m+Cp45AkxybcfkfeLDu
 /bmzpupUQ2HIpsTWq+CEz2lQlxAkR54=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 4DAE5A3B8C;
 Mon, 24 Jan 2022 17:37:16 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 24 Jan 2022 17:36:50 +0000
Message-Id: <20220124173651.652-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124173651.652-1-rpalethorpe@suse.com>
References: <20220124173651.652-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] memcontrol02: Fix anon memory comparison
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

All memory is being compared with the size malloc'ed instead of just
anon.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 411f5aea6..0d144cf2d 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -68,7 +68,7 @@ static void alloc_anon_50M_check(void)
 
 	TST_EXP_EXPR(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
 	TST_EXP_EXPR(values_close(size, current, 3),
-		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, current);
+		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, anon);
 	TST_EXP_EXPR(values_close(anon, current, 3),
 		     "(memory.current=%zd) ~= (memory.stat.anon=%zd)",
 		     current, anon);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
