Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8366AC52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:21:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D08E3D2112
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:21:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56FC3CB98F
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:55 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=cel@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 326192005DB
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:54 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 63A7560C69;
 Sat, 10 Aug 2024 20:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D203C32781;
 Sat, 10 Aug 2024 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723320053;
 bh=44buz1+lp5M1C+A8lSIF/iKBxTScCdyb4ZmhlHtXaSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bAUSLgtW9h0QvSf1zDZ7KhpRPcIoPpeUP6heINx5pB1CloFiM0u6tIVRkjRfISzAD
 hioa+/nP5HLiZfWSDVV1G09UCwHqy5NbxpHd+dsTpNG7/UVlDVs63ScJeeyb+mQXkH
 /T54CobDnGfVfp5VHsqNHh2ep3sc0wp1AgqXxsdrHUAJx9OMd/xTu6PSa/ZkjLAQaQ
 kZw3gXC2A3tvWkRPnU8MHUOcYHbHAmJRAMyKb8r8Z9g2XMEc7+IfEZUzo+ENpRCjlN
 xQFQGBWRQpFNG0O4Vqb5FOSyZ3zKBE+xxmqD2DDy3pqy9xqmt3EvZBLCYBwX+6BUgQ
 mMzPb95/g5/lw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Date: Sat, 10 Aug 2024 15:59:57 -0400
Message-ID: <20240810200009.9882-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:43 +0200
Subject: [LTP] [PATCH 6.1.y 06/18] NFSD: Refactor the duplicate reply cache
 shrinker
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
 sherry.yang@oracle.com, Chuck Lever <chuck.lever@oracle.com>,
 calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c135e1269f34dfdea4bd94c11060c83a3c0b3c12 ]

Avoid holding the bucket lock while freeing cache entries. This
change also caps the number of entries that are freed when the
shrinker calls to reduce the shrinker's impact on the cache's
effectiveness.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v6.1.y -- this one might not be necessary ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 85 ++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index b553f2cece58..049565bbef2d 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -310,51 +310,16 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 	}
 }
 
-static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
-			 unsigned int max)
-{
-	struct svc_cacherep *rp, *tmp;
-	long freed = 0;
-
-	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
-		/*
-		 * Don't free entries attached to calls that are still
-		 * in-progress, but do keep scanning the list.
-		 */
-		if (rp->c_state == RC_INPROG)
-			continue;
-		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
-		    time_before(jiffies, rp->c_timestamp + RC_EXPIRE))
-			break;
-		nfsd_reply_cache_free_locked(b, rp, nn);
-		if (max && freed++ > max)
-			break;
-	}
-	return freed;
-}
-
-/*
- * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
- * Also prune the oldest ones when the total exceeds the max number of entries.
+/**
+ * nfsd_reply_cache_count - count_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Returns the total number of entries in the duplicate reply cache. To
+ * keep things simple and quick, this is not the number of expired entries
+ * in the cache (ie, the number that would be removed by a call to
+ * nfsd_reply_cache_scan).
  */
-static long
-prune_cache_entries(struct nfsd_net *nn)
-{
-	unsigned int i;
-	long freed = 0;
-
-	for (i = 0; i < nn->drc_hashsize; i++) {
-		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
-
-		if (list_empty(&b->lru_head))
-			continue;
-		spin_lock(&b->cache_lock);
-		freed += prune_bucket(b, nn, 0);
-		spin_unlock(&b->cache_lock);
-	}
-	return freed;
-}
-
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -364,13 +329,43 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 	return atomic_read(&nn->num_drc_entries);
 }
 
+/**
+ * nfsd_reply_cache_scan - scan_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Free expired entries on each bucket's LRU list until we've released
+ * nr_to_scan freed objects. Nothing will be released if the cache
+ * has not exceeded it's max_drc_entries limit.
+ *
+ * Returns the number of entries released by this call.
+ */
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct nfsd_net *nn = container_of(shrink,
 				struct nfsd_net, nfsd_reply_cache_shrinker);
+	unsigned long freed = 0;
+	LIST_HEAD(dispose);
+	unsigned int i;
 
-	return prune_cache_entries(nn);
+	for (i = 0; i < nn->drc_hashsize; i++) {
+		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
+
+		if (list_empty(&b->lru_head))
+			continue;
+
+		spin_lock(&b->cache_lock);
+		nfsd_prune_bucket_locked(nn, b, 0, &dispose);
+		spin_unlock(&b->cache_lock);
+
+		freed += nfsd_cacherep_dispose(&dispose);
+		if (freed > sc->nr_to_scan)
+			break;
+	}
+
+	trace_nfsd_drc_gc(nn, freed);
+	return freed;
 }
 
 /**
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
