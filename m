Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD5FC3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 08:41:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D12EB3D21B2
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:41:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4F63D21BD
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:23 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B88A10007D8
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:22 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 454C1CE1795;
 Thu, 15 Aug 2024 08:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B4CC32786;
 Thu, 15 Aug 2024 08:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723711218;
 bh=Fv7QtCCtRe7WC0eitE115W6AJyanb/O9poMt3VP03Yw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=ZnZ+OemcVxPf/lcVxQ7er5/wkqomq1M1UuCoAewJURaKc+WUo/b2buX4Zlio5qAoz
 jZlshsw8w/hgyi1qTJ0TfGe2ZYMcybjkbOTD+/oEJj0xajBiZjNKisfjdPKh8WNRAd
 M6AAbEZm4jgA3oth+r+vbi95HkL23ObncrDwqPGY=
To: calum.mackay@oracle.com, cel@kernel.org, chuck.lever@oracle.com,
 efuller@redhat.com, gregkh@linuxfoundation.org, jlayton@kernel.org,
 kernel-team@fb.com, ltp@lists.linux.it, pvorel@suse.cz, sherry.yang@oracle.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 15 Aug 2024 10:39:57 +0200
In-Reply-To: <20240810200009.9882-3-cel@kernel.org>
Message-ID: <2024081557-number-bullfrog-c97f@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Patch "nfsd: move init of percpu reply_cache_stats counters
 back to nfsd_init_net" has been added to the 6.1-stable tree
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

    nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nfsd-move-init-of-percpu-reply_cache_stats-counters-back-to-nfsd_init_net.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66323-greg=kroah.com@vger.kernel.org Sat Aug 10 22:00:38 2024
From: cel@kernel.org
Date: Sat, 10 Aug 2024 15:59:53 -0400
Subject: nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>, pvorel@suse.cz, sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it, Jeff Layton <jlayton@kernel.org>, Eirik Fuller <efuller@redhat.com>
Message-ID: <20240810200009.9882-3-cel@kernel.org>

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit ed9ab7346e908496816cffdecd46932035f66e2e ]

Commit f5f9d4a314da ("nfsd: move reply cache initialization into nfsd
startup") moved the initialization of the reply cache into nfsd startup,
but didn't account for the stats counters, which can be accessed before
nfsd is ever started. The result can be a NULL pointer dereference when
someone accesses /proc/fs/nfsd/reply_cache_stats while nfsd is still
shut down.

This is a regression and a user-triggerable oops in the right situation:

- non-x86_64 arch
- /proc/fs/nfsd is mounted in the namespace
- nfsd is not started in the namespace
- unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"

Although this is easy to trigger on some arches (like aarch64), on
x86_64, calling this_cpu_ptr(NULL) evidently returns a pointer to the
fixed_percpu_data. That struct looks just enough like a newly
initialized percpu var to allow nfsd_reply_cache_stats_show to access
it without Oopsing.

Move the initialization of the per-net+per-cpu reply-cache counters
back into nfsd_init_net, while leaving the rest of the reply cache
allocations to be done at nfsd startup time.

Kudos to Eirik who did most of the legwork to track this down.

Cc: stable@vger.kernel.org # v6.3+
Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")
Reported-and-tested-by: Eirik Fuller <efuller@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2215429
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/cache.h    |    2 ++
 fs/nfsd/nfscache.c |   25 ++++++++++++++-----------
 fs/nfsd/nfsctl.c   |   10 +++++++++-
 3 files changed, 25 insertions(+), 12 deletions(-)

--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -80,6 +80,8 @@ enum {
 
 int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
+int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
+void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -148,12 +148,23 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+/**
+ * nfsd_net_reply_cache_init - per net namespace reply cache set-up
+ * @nn: nfsd_net being initialized
+ *
+ * Returns zero on succes; otherwise a negative errno is returned.
+ */
+int nfsd_net_reply_cache_init(struct nfsd_net *nn)
 {
 	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
 
-static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+/**
+ * nfsd_net_reply_cache_destroy - per net namespace reply cache tear-down
+ * @nn: nfsd_net being freed
+ *
+ */
+void nfsd_net_reply_cache_destroy(struct nfsd_net *nn)
 {
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
@@ -169,17 +180,13 @@ int nfsd_reply_cache_init(struct nfsd_ne
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	status = nfsd_reply_cache_stats_init(nn);
-	if (status)
-		goto out_nomem;
-
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
 				   "nfsd-reply:%s", nn->nfsd_name);
 	if (status)
-		goto out_stats_destroy;
+		return status;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -195,9 +202,6 @@ int nfsd_reply_cache_init(struct nfsd_ne
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
-out_stats_destroy:
-	nfsd_reply_cache_stats_destroy(nn);
-out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -217,7 +221,6 @@ void nfsd_reply_cache_shutdown(struct nf
 									rp, nn);
 		}
 	}
-	nfsd_reply_cache_stats_destroy(nn);
 
 	kvfree(nn->drc_hashtbl);
 	nn->drc_hashtbl = NULL;
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1450,6 +1450,9 @@ static __net_init int nfsd_init_net(stru
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_net_reply_cache_init(nn);
+	if (retval)
+		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
@@ -1458,6 +1461,8 @@ static __net_init int nfsd_init_net(stru
 
 	return 0;
 
+out_repcache_error:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1466,9 +1471,12 @@ out_export_error:
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
-	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd_netns_free_versions(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {


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
