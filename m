Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD64C77B61
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 21:08:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1FD73CE9F5
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 23:08:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEF813CB304
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 23:08:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C1006005CB
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 23:08:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD4471FD94;
 Mon, 24 Apr 2023 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682370492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iyzeLzCsMCdsmJwHyVbIHUwIBHNpy11fYoEtMxyvpk=;
 b=U4rmdr9cQT6ujltj2tGLrrVOw4jfXby9gVqC3Y/2kt2QWKiZyS7aSE3YO7ugrgT7sNrTHE
 AJHDhorMu0bFVoH7Qp5Y7PVKJAC8TTpjtv4JinVAPJpG8V3h42wNqrtUAiyjikjuaJm4O8
 jjgZTpK2tjAt8CVXjkKf4Qw2RbWahIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682370492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iyzeLzCsMCdsmJwHyVbIHUwIBHNpy11fYoEtMxyvpk=;
 b=1N8e7Zb00xKsGhfSvd7jIk0ZAjyMLFWhAKO8aDc7cXMQy76YH1AFXNkSK6W4z/O55LLTO5
 qcaJpgR6QzuyGjAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D0A61390E;
 Mon, 24 Apr 2023 21:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iMLlELzvRmSzIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 21:08:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Apr 2023 23:08:17 +0200
Message-Id: <20230424210818.2885479-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424210818.2885479-1-pvorel@suse.cz>
References: <20230424210818.2885479-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] nfs_lib.sh: Unexport on proper side on netns
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
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
