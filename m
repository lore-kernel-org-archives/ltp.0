Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37767C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 16:23:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17D7D3C88D2
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 18:23:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4F3E3C039E
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 18:23:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AEA521000F59
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 18:23:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99A811F8BB;
 Thu, 16 Jun 2022 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655396623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ezJkwsJFppcMTZU6WVbbMfZ7ud5s4n+VNrC8xpgHsqI=;
 b=gj2TPTc86aMFaRY5pDFZ+zfgrWLG2uKOhmePrL7+rJDQbB7gGupRv0zhdqcECnG1xqzzQu
 syNP/oT5pBi/DL/IxBaQJJyxW1OCYPnDIa4CsmFPMDKHeeNjmjG+YRqwE3O8kLYFbXyyZN
 YnF/ZwwgFuMqiX0d7lMoEfm7WItDwVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655396623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ezJkwsJFppcMTZU6WVbbMfZ7ud5s4n+VNrC8xpgHsqI=;
 b=7fWn+EbkENMwCnfaG59V/mRLfD9IBn5BTnzZEDHnj0WEsA6GQpcZyUbvaDrInmC9MR9rS0
 LSP6SEEFNuLDhXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C7B213A70;
 Thu, 16 Jun 2022 16:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uUNXGA9Zq2JMVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 16:23:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Jun 2022 18:23:39 +0200
Message-Id: <20220616162339.19322-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] nfs05_make_tree: Restore 5 min timeout
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

nfs05_make_tree is a long running test. The previous default timeout 5
min was enough after reducing runtime in 05be61cf6.

But the new default 30 sec introduced in the concept of max runtime is
definitely not enough. Restore the previous timeout 5 min.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs05_make_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index fdc13bd5d..5456c1bf0 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -215,4 +215,5 @@ static struct tst_test test = {
 	.options = opts,
 	.test_all = do_test,
 	.setup = setup,
+	.max_runtime = 300,
 };
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
