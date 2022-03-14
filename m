Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D62C433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 19:21:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 614EB3CA807
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 20:21:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DA5C3C90D9
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 20:21:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D4011400767
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 20:21:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 977E42110B;
 Mon, 14 Mar 2022 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647285681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=etQ/Hpd16gtbT7evD0nKJkMl0XkEyiMl9+QBSzvx2cM=;
 b=ANllwdP1gjNxgot17IYpIGTxmzW3COAxZgse393oYkJ+bndQjj9VZmCdNFy06UTAunkKGG
 Br7cvtS/HVaw/gOYJZ3nC1ic/j2FSlCtLwFw0PULr7LVl4Ffqi/+jPGZ6IH5MjKCT+BlKs
 jxyDKpYWLC4lUnjmN1oRiqKHhiYFsHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647285681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=etQ/Hpd16gtbT7evD0nKJkMl0XkEyiMl9+QBSzvx2cM=;
 b=u+XhGDG0LrklD/5hEN1NOntuLXop7MPbEtCqcYfGEkcAYGX+lWuK44b/kLGznbiG8VA+DU
 VduQ0DQBT32OnuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B99C13B3D;
 Mon, 14 Mar 2022 19:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8HDLELGVL2JucAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 14 Mar 2022 19:21:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 14 Mar 2022 20:21:17 +0100
Message-Id: <20220314192117.14692-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] doc: Mention places for environment variables
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/library-api-writing-guidelines.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
index c820536814..52e37d8c28 100644
--- a/doc/library-api-writing-guidelines.txt
+++ b/doc/library-api-writing-guidelines.txt
@@ -18,6 +18,10 @@ Library tests are in 'lib/newlib_tests' directory.
 
 Don't forget to update docs when you change the API.
 
+Environment variables should be listed in
+https://github.com/linux-test-project/ltp/wiki/User-Guidelines[LTP User Guidelines]
+and in help output (`-h`) for both C and shell API.
+
 2. C API
 --------
 
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
