Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F7CD54B8
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 11:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C343CE471
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 13:47:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 103CE3CA6BC
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 13:47:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E5A71400B76
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 13:47:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D287F21BB9
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695124022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbHIPDqObycvd26GBf97bUSLZhHsMggImvneR94OWDE=;
 b=lHpTyKupLu6lrmOgewBjrjrdt/MPGmaPUJaOTWWNEbo6mb7vwsx6w1IzXrQdyUJ2Dv8dLI
 ceWBwvPaVVyVeXOl5t9mR6U68KoRSvpur804IAB3Aff/GkIy699zhFTmumxhSsViMRLd+/
 /Gqd5eeYZE+7Vp6rrAxHLkFKSNwX52M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695124022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbHIPDqObycvd26GBf97bUSLZhHsMggImvneR94OWDE=;
 b=joM6UVv8+NK3wTFE9dOz3IkrGnQfe9H2Dzcjd9bDAqqd+LjyCXIQ5vorIaBWTufex22wlr
 PeZHURuRvf6GwbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C12C0134F3
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wNRkLjaKCWX8eAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:47:02 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 13:46:58 +0200
Message-ID: <20230919114701.15327-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919114701.15327-1-mdoucha@suse.cz>
References: <20230919114701.15327-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] nfs03.sh: Wait for all files to be removed
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

A race condition between the two parallel calls of rm_files may cause
NFS unmount to fail and then the NFS client will get confused by remote
filesystem change which leads to strange failures. Make sure both
rm_files calls finish before returning from the main test function.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs03.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs03.sh b/testcases/network/nfs/nfs_stress/nfs03.sh
index e5f4de67c..e9ef5fb78 100755
--- a/testcases/network/nfs/nfs_stress/nfs03.sh
+++ b/testcases/network/nfs/nfs_stress/nfs03.sh
@@ -66,11 +66,13 @@ do_test()
 	cd ../dir1
 	wait $pid1
 	rm_files &
+	pid3=$!
 
 	tst_res TINFO "cd dir2 & removing files"
 	cd ../dir2
 	wait $pid2
 	rm_files
+	wait $pid3
 
 	tst_res TPASS "test done"
 }
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
