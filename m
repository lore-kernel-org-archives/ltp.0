Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E962C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 18:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDDCD3CE96C
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 19:38:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BF1C3CC7DF
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 19:37:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46E531002051
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 19:37:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 704F8211C3;
 Fri,  3 Nov 2023 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699036668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pN306hGdwaFYbw/tO26X+IJri5bh758LIeKRVuDkeNY=;
 b=QF5/BopljWGa91A7EXt3Bc+gwjcJ1VQD0G2BkkgrjcH58FYDbgYnSh63BXJyL5yT0mB6Oo
 7M0SQk0ShmZyISxGvR4wHjU6+tea3D3LbkiUuFq8SQwOjrCQlCZIpzdaJBshlns6wgnMSs
 OaTPAYCf3j/wJ1j6BjDQklScOIqHsBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699036668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pN306hGdwaFYbw/tO26X+IJri5bh758LIeKRVuDkeNY=;
 b=BMD4iJEqfpSJsukQIxSyHUwyah6KX7TFv/3sA70Duzdacr+1SNs2hK5AJrINRqDmV2/XJ0
 DB/Pkx8Na/SMoqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 218F913907;
 Fri,  3 Nov 2023 18:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kRFWBPw9RWUsAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 18:37:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  3 Nov 2023 19:37:44 +0100
Message-ID: <20231103183744.1114929-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lib/tst_kernel.c: Reuse
 tst_check_builtin_driver()
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
changes v1->v2:
* Remove invalid ';'

 lib/tst_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 4b75ceadb..51e4daa09 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -193,7 +193,7 @@ int tst_check_builtin_driver(const char *driver)
 int tst_check_driver(const char *driver)
 {
 	if (!tst_search_driver(driver, "modules.dep") ||
-		!tst_search_driver(driver, "modules.builtin"))
+		!tst_check_builtin_driver(driver))
 		return 0;
 
 	return -1;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
