Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929B6CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046D33CE4DA
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:35:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DBAD3CA907
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:35:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 867B361DF07
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:35:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EB4321B09;
 Mon, 18 Sep 2023 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695036928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FkUz+RsqvkO04E4/hzoYUOFGMrPMnBowKOeSN6TGFRo=;
 b=adcUOKx8pKeJ/lUxn6+vo62Etr/bOZ90RSGUvDsJ0Wh1k23IrOM/DhiuqI4Hotupt9TZ4Y
 wAvSr/vxJ3AmSF+Dyj6r/VZ3lejUHy5539F4SLwkBOdBh5LRPyjJ8bveCcrSiNv5OacIDb
 f9UBLXrOp5YBB1J4Ttu7Szq9Dtjv5uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695036928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FkUz+RsqvkO04E4/hzoYUOFGMrPMnBowKOeSN6TGFRo=;
 b=CpMyfzY28RlOqfvF3RcLFa6ssEnMYjDu5AfVx2N1Z/v8tSmIpEjAeWSelRUzfkIMpM27Uv
 ny3/rjtsUxBDA/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33E4413480;
 Mon, 18 Sep 2023 11:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id okQZCwA2CGUnWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 11:35:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 13:35:24 +0200
Message-ID: <20230918113524.17908-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [KIRK][PATCH 1/1] Makefile: Fix symlink order
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

kirk is the target, runltp-ng is the link name.

Fixes: 666a2bd ("Symlink kirk with runltp-ng in LTP installation")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
If you agree with this change, I'll merge it to
https://github.com/linux-test-project/kirk
And we will need v6 for 
[1] "Replace runltp-ng with kirk framework" patch
(or update the has in first commit).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20230918110737.1922-2-andrea.cervesato@suse.de/

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0bc7ffc..cd7a025 100644
--- a/Makefile
+++ b/Makefile
@@ -15,6 +15,6 @@ install:
 	install -m 00644 $(top_srcdir)/tools/kirk/libkirk/*.py $(BASE_DIR)/libkirk
 	install -m 00775 $(top_srcdir)/tools/kirk/kirk $(BASE_DIR)/kirk
 
-	ln -sf $(BASE_DIR)/runltp-ng $(BASE_DIR)/kirk
+	ln -sf $(BASE_DIR)/kirk $(BASE_DIR)/runltp-ng
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
