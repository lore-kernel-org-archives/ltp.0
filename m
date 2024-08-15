Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A063C52D7D
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 08:42:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 377B33D21D1
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:42:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC40B3D21BB
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:31 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A4B3760081C
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:30 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1D39E61A3E;
 Thu, 15 Aug 2024 08:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D8CC32786;
 Thu, 15 Aug 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723711228;
 bh=bjsPa5LWmVQ3d6tc3rpmk69k3qYw8zzill5jXOwLCzg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=eSqO4wjU6FRJ+GUtxOaZBU2G0nHOK+BFXt5CNt6UmzJl5rkvtubeRNcUTb120GXZF
 oMfA3/xBQ+pV1mIqfuhRpncIpKhwKWB0kyg+gMsAgmVf7w7pE4Fqtpv7m556uFVkG9
 IHrdlw1Gltytu126NsGQRFoc2ACyHDfNe4o+QK5Q=
To: calum.mackay@oracle.com, cel@kernel.org, chuck.lever@oracle.com,
 gregkh@linuxfoundation.org, jlayton@kernel.org, kernel-team@fb.com,
 ltp@lists.linux.it, pvorel@suse.cz, sherry.yang@oracle.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 15 Aug 2024 10:39:58 +0200
In-Reply-To: <20240810200009.9882-7-cel@kernel.org>
Message-ID: <2024081558-habitable-python-5e96@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Patch "NFSD: Refactor the duplicate reply cache shrinker" has
 been added to the 6.1-stable tree
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
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


This is a note to let you know that I've just added the patch titled

    NFSD: Refactor the duplicate reply cache shrinker

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nfsd-refactor-the-duplicate-reply-cache-shrinker.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66327-greg=kroah.com@vger.kernel.org Sat Aug 10 22:00:59 2024
From: cel@kernel.org
Date: Sat, 10 Aug 2024 15:59:57 -0400
Subject: NFSD: Refactor the duplicate reply cache shrinker
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>, pvorel@suse.cz, sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Message-ID: <20240810200009.9882-7-cel@kernel.org>

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c135e1269f34dfdea4bd94c11060c83a3c0b3c12 ]

Avoid holding the bucket lock while freeing cache entries. This
change also caps the number of entries that are freed when the
shrinker calls to reduce the shrinker's impact on the cache's
effectiveness.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v6.1.y -- this one might not be necessary ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfscache.c |   83 ++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -310,67 +310,62 @@ nfsd_prune_bucket_locked(struct nfsd_net
 	}
 }
 
-static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
-			 unsigned int max)
+/**
+ * nfsd_reply_cache_count - count_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Returns the total number of entries in the duplicate reply cache. To
+ * keep things simple and quick, this is not the number of expired entries
+ * in the cache (ie, the number that would be removed by a call to
+ * nfsd_reply_cache_scan).
+ */
+static unsigned long
+nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct svc_cacherep *rp, *tmp;
-	long freed = 0;
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_reply_cache_shrinker);
 
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
+	return atomic_read(&nn->num_drc_entries);
 }
 
-/*
- * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
- * Also prune the oldest ones when the total exceeds the max number of entries.
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
  */
-static long
-prune_cache_entries(struct nfsd_net *nn)
+static unsigned long
+nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_reply_cache_shrinker);
+	unsigned long freed = 0;
+	LIST_HEAD(dispose);
 	unsigned int i;
-	long freed = 0;
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
 
 		if (list_empty(&b->lru_head))
 			continue;
+
 		spin_lock(&b->cache_lock);
-		freed += prune_bucket(b, nn, 0);
+		nfsd_prune_bucket_locked(nn, b, 0, &dispose);
 		spin_unlock(&b->cache_lock);
-	}
-	return freed;
-}
-
-static unsigned long
-nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
-{
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
 
-	return atomic_read(&nn->num_drc_entries);
-}
-
-static unsigned long
-nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
-{
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+		freed += nfsd_cacherep_dispose(&dispose);
+		if (freed > sc->nr_to_scan)
+			break;
+	}
 
-	return prune_cache_entries(nn);
+	trace_nfsd_drc_gc(nn, freed);
+	return freed;
 }
 
 /**


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/nfsd-remove-nfsd_stats-make-th_cnt-a-global-counter.patch
queue-6.1/nfsd-move-reply-cache-initialization-into-nfsd-startup.patch
queue-6.1/sunrpc-remove-pg_stats-from-svc_program.patch
queue-6.1/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.1/nfsd-rename-nfsd_reply_cache_alloc.patch
queue-6.1/nfsd-make-all-of-the-nfsd-stats-per-network-namespace.patch
queue-6.1/mptcp-pass-addr-to-mptcp_pm_alloc_anno_list.patch
queue-6.1/nfsd-move-init-of-percpu-reply_cache_stats-counters-back-to-nfsd_init_net.patch
queue-6.1/nfsd-replace-nfsd_prune_bucket.patch
queue-6.1/nfsd-stop-setting-pg_stats-for-unused-stats.patch
queue-6.1/sunrpc-don-t-change-sv_stats-if-it-doesn-t-exist.patch
queue-6.1/nfsd-make-svc_stat-per-network-namespace-instead-of-global.patch
queue-6.1/nfsd-fix-frame-size-warning-in-svc_export_parse.patch
queue-6.1/nfsd-rename-nfsd_net_-to-nfsd_stats_.patch
queue-6.1/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.1/nfsd-refactor-nfsd_reply_cache_free_locked.patch
queue-6.1/mptcp-fully-established-after-add_addr-echo-on-mpj.patch
queue-6.1/sunrpc-use-the-struct-net-as-the-svc-proc-private.patch
queue-6.1/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.1/sunrpc-pass-in-the-sv_stats-struct-through-svc_create_pooled.patch
queue-6.1/mptcp-pm-reduce-indentation-blocks.patch
queue-6.1/nfsd-rewrite-synopsis-of-nfsd_percpu_counters_init.patch
queue-6.1/nfsd-expose-proc-net-sunrpc-nfsd-in-net-namespaces.patch
queue-6.1/nfsd-refactor-the-duplicate-reply-cache-shrinker.patch

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
