Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBE7C52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:23:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BA593D210F
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:23:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 143FE3D20DB
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:01:15 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=cel@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6526A2009D9
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:01:14 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BBE6760C71;
 Sat, 10 Aug 2024 20:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98AC4AF0E;
 Sat, 10 Aug 2024 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723320072;
 bh=tOT5mmEIpuJJFHkMTBmFbjBjEyyWUNbGT2SCPe7LUaE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GhR1d/VBGdh9U0agnMGc6QxnlOXZdCFU3EetLxJqNfgsXFUexUfadqBaX43eA62LX
 f8pnmTfEukwqdr/aR8m45YSEpQbViuK1qzoVq4FVoiEiTz4pL+K6keIEUWb3hIk5BT
 apy0a5A5zFu2NeblJpsVf/lWRIVEyw8YP8NFFXIzebVqtWYFCqjoPMgAfzngvtXgp3
 gKjLm0RL+cGIC2eTA1wmZLR/oRNgEeB+Zb3iTgibhRzmsH50ezigGQiPo4+Iyd3V3j
 tfoLErUsUUGi2CaELSdAPRE0M9k+gFFaK91f+vLQaAjh/S+OAMXo7tdNGNWCth+UQw
 vsST2K0czvMNw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Date: Sat, 10 Aug 2024 16:00:02 -0400
Message-ID: <20240810200009.9882-12-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:43 +0200
Subject: [LTP] [PATCH 6.1.y 11/18] sunrpc: pass in the sv_stats struct
 through svc_create_pooled
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
 sherry.yang@oracle.com, Josef Bacik <josef@toxicpanda.com>,
 calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit f094323867668d50124886ad884b665de7319537 ]

Since only one service actually reports the rpc stats there's not much
of a reason to have a pointer to it in the svc_program struct.  Adjust
the svc_create_pooled function to take the sv_stats as an argument and
pass the struct through there as desired instead of getting it from the
svc_program->pg_stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v6.1.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           |  3 ++-
 include/linux/sunrpc/svc.h |  4 +++-
 net/sunrpc/svc.c           | 12 +++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e1a07cfdab23..34d5906b844b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -657,7 +657,8 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
+	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 88de45491376..3290b805f749 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -493,7 +493,9 @@ void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
-struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
+struct svc_serv *  svc_create_pooled(struct svc_program *prog,
+				     struct svc_stat *stats,
+				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 35c0651cc002..9ae85347ab39 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -453,8 +453,8 @@ __svc_init_bc(struct svc_serv *serv)
  * Create an RPC service
  */
 static struct svc_serv *
-__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
-	     int (*threadfn)(void *data))
+__svc_create(struct svc_program *prog, struct svc_stat *stats,
+	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
 	unsigned int vers;
@@ -466,7 +466,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
 	kref_init(&serv->sv_refcnt);
-	serv->sv_stats     = prog->pg_stats;
+	serv->sv_stats     = stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
 	serv->sv_max_payload = bufsize? bufsize : 4096;
@@ -528,26 +528,28 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
 			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, bufsize, 1, threadfn);
+	return __svc_create(prog, NULL, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
 /**
  * svc_create_pooled - Create an RPC service with pooled threads
  * @prog: the RPC program the new service will handle
+ * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
  *
  * Returns an instantiated struct svc_serv object or NULL.
  */
 struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   struct svc_stat *stats,
 				   unsigned int bufsize,
 				   int (*threadfn)(void *data))
 {
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, bufsize, npools, threadfn);
+	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	return serv;
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
