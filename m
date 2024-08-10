Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF17C52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:20:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8B623D2112
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:20:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C762C3D1CA3
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:29 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=cel@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3219F1A006F8
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:28 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DD40A60C25;
 Sat, 10 Aug 2024 20:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9168C32781;
 Sat, 10 Aug 2024 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723320026;
 bh=Q3dqFd0Y6AQeyGpivTbPl4KuVEVT05lnQE8LKV5pVns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F0dk5EpWb6IeH5nZN22SqpuAMFtsFpiMjOm7OpYoKd9rKXgs5mr/AugZvb9Ob8s5c
 4O104m+dzTDfuirgJeTFj9dtynHmD0+uMjSIeik2y0X96bnugWVGLqyDEpgBisuGhA
 sUBeacwEccc8Sgij81XGbvgXzwFZDwOC6q8v6FYl6fC/Hc447undapL96PquFPgW5h
 TJW9LVCyDW67qXh5WUso4KZxZTvyy0xLHjOeLwwjCZjPkBXNvv0zV2lXAKOtYUfSEP
 mzWWdenCztfmCtCWS9WPR7HxqwbXiDCPUcMwO/PUfy1gQo6h8sI+dGsjWHq1IPEwH2
 Mvuca1r40iuDw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Date: Sat, 10 Aug 2024 15:59:52 -0400
Message-ID: <20240810200009.9882-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:42 +0200
Subject: [LTP] [PATCH 6.1.y 01/18] nfsd: move reply cache initialization
 into nfsd startup
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
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 sherry.yang@oracle.com, Dai Ngo <dai.ngo@oracle.com>, calum.mackay@oracle.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit f5f9d4a314da88c0a5faa6d168bf69081b7a25ae ]

There's no need to start the reply cache before nfsd is up and running,
and doing so means that we register a shrinker for every net namespace
instead of just the ones where nfsd is running.

Move it to the per-net nfsd startup instead.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: ed9ab7346e90 ("nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |  8 --------
 fs/nfsd/nfssvc.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 76a60e7a7509..f6637dbb9e18 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1453,16 +1453,11 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
-	retval = nfsd_reply_cache_init(nn);
-	if (retval)
-		goto out_cache_error;
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
 	return 0;
 
-out_cache_error:
-	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1471,9 +1466,6 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	nfsd_reply_cache_shutdown(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a8190caf77f1..d07ee284100f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -427,16 +427,23 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	ret = nfsd_file_cache_start_net(net);
 	if (ret)
 		goto out_lockd;
-	ret = nfs4_state_start_net(net);
+
+	ret = nfsd_reply_cache_init(nn);
 	if (ret)
 		goto out_filecache;
 
+	ret = nfs4_state_start_net(net);
+	if (ret)
+		goto out_reply_cache;
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
 
+out_reply_cache:
+	nfsd_reply_cache_shutdown(nn);
 out_filecache:
 	nfsd_file_cache_shutdown_net(net);
 out_lockd:
@@ -454,6 +461,7 @@ static void nfsd_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfs4_state_shutdown_net(net);
+	nfsd_reply_cache_shutdown(nn);
 	nfsd_file_cache_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
