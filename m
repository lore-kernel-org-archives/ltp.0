Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA3C77B7C
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 13:15:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B0653CBA6F
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 15:15:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2020F3CB7CB
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02B796008F7
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC7131FEAE;
 Thu,  4 May 2023 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683206044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iyzeLzCsMCdsmJwHyVbIHUwIBHNpy11fYoEtMxyvpk=;
 b=MrqPBCr5EfDFZVab1pxQk0gOd64vBZVkRx7JlLS/d6Ka6wVU5Dg9r0H0kYKKngtJZtyjaP
 o+L8bmavB3xdAR+szk0AEVfBsHbxP5mDlCG3O7QNZGCBmnjRkBB3r58LIpLeeQxjriTMm3
 SPEeJ8K7sXpKcDV5ls1oztZKW2BY7Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683206044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iyzeLzCsMCdsmJwHyVbIHUwIBHNpy11fYoEtMxyvpk=;
 b=Dw/Ow6bW49kqOGHzAv27rgCkvZ7IIZg+496bKYPP54N1gDq4GahFpRDdfMMdgYWaXda5bD
 BzKj5Q2fLm6O4bBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F83113444;
 Thu,  4 May 2023 13:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4MwUG5yvU2TXVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 May 2023 15:14:11 +0200
Message-Id: <20230504131414.3826283-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504131414.3826283-1-pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/5] nfs_lib.sh: Unexport on proper side on netns
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

f6b267055 changed exportfs run locally on netns, therefore unexporting
should be also run at the same namespace. This is not problematic now,
but will be a problem with TST_ALL_FILESYSTEMS=1, which is sensitive for
timing.

Fixes: f6b267055 ("nfs_lib.sh: run exportfs at "server side" in LTP_NETNS case")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 1b5604ab5..042fea5e4 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -215,8 +215,16 @@ nfs_cleanup()
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		remote_dir="$(get_remote_dir $i $type)"
-		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
-		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+
+		if tst_net_use_netns; then
+			if test -d $remote_dir; then
+				exportfs -u *:$remote_dir
+				rm -rf $remote_dir
+			fi
+		else
+			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+		fi
 		n=$(( n + 1 ))
 	done
 }
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
