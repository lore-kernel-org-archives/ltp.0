Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F03C3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 08:40:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE72D3D21C1
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:40:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 929D03D1E86
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:11 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 471F91400124
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:09 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 05F0FCE194E;
 Thu, 15 Aug 2024 08:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94BAC32786;
 Thu, 15 Aug 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723711205;
 bh=aD8QnPYSFtJoZ32wDdVzVqgK+aJzqUR1q3Xh+O1heA8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=lwTMzC6SxyToARVMCO2yPou1Wb2S0KLak2bsdD91LJ2FFn16oNupmStE9ZpapOZdp
 mz9M+ICqiP0cha88En9gK+rp8IUMrp7eqDihwZIaBwYPRcAxbYslDqafh76yZyTkr6
 QUblRqIihPe2Ocb6SZnb2kR74BLZ1iyYcUZjFwiw=
To: calum.mackay@oracle.com, cel@kernel.org, chuck.lever@oracle.com,
 gregkh@linuxfoundation.org, jlayton@kernel.org, josef@toxicpanda.com,
 kernel-team@fb.com, ltp@lists.linux.it, pvorel@suse.cz, sherry.yang@oracle.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 15 Aug 2024 10:39:56 +0200
In-Reply-To: <20240810200009.9882-16-cel@kernel.org>
Message-ID: <2024081556-arrest-pretext-1dd3@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Patch "nfsd: expose /proc/net/sunrpc/nfsd in net namespaces"
 has been added to the 6.1-stable tree
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

    nfsd: expose /proc/net/sunrpc/nfsd in net namespaces

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nfsd-expose-proc-net-sunrpc-nfsd-in-net-namespaces.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66336-greg=kroah.com@vger.kernel.org Sat Aug 10 22:01:25 2024
From: cel@kernel.org
Date: Sat, 10 Aug 2024 16:00:06 -0400
Subject: nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>, pvorel@suse.cz, sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it, Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Message-ID: <20240810200009.9882-16-cel@kernel.org>

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 93483ac5fec62cc1de166051b219d953bb5e4ef4 ]

We are running nfsd servers inside of containers with their own network
namespace, and we want to monitor these services using the stats found
in /proc.  However these are not exposed in the proc inside of the
container, so we have to bind mount the host /proc into our containers
to get at this information.

Separate out the stat counters init and the proc registration, and move
the proc registration into the pernet operations entry and exit points
so that these stats can be exposed inside of network namespaces.

This is an intermediate step, this just exposes the global counters in
the network namespace.  Subsequent patches will move these counters into
the per-network namespace container.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfsctl.c |    8 +++++---
 fs/nfsd/stats.c  |   21 ++++++---------------
 fs/nfsd/stats.h  |    6 ++++--
 3 files changed, 15 insertions(+), 20 deletions(-)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1458,6 +1458,7 @@ static __net_init int nfsd_init_net(stru
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
+	nfsd_proc_stat_init(net);
 
 	return 0;
 
@@ -1473,6 +1474,7 @@ static __net_exit void nfsd_exit_net(str
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_proc_stat_shutdown(net);
 	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
@@ -1496,7 +1498,7 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_stat_init();	/* Statistics */
+	retval = nfsd_stat_counters_init();	/* Statistics */
 	if (retval)
 		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
@@ -1532,7 +1534,7 @@ out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
 out_free_stat:
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1549,7 +1551,7 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -106,31 +106,22 @@ void nfsd_percpu_counters_destroy(struct
 		percpu_counter_destroy(&counters[i]);
 }
 
-static int nfsd_stat_counters_init(void)
+int nfsd_stat_counters_init(void)
 {
 	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-static void nfsd_stat_counters_destroy(void)
+void nfsd_stat_counters_destroy(void)
 {
 	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-int nfsd_stat_init(void)
+void nfsd_proc_stat_init(struct net *net)
 {
-	int err;
-
-	err = nfsd_stat_counters_init();
-	if (err)
-		return err;
-
-	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
-
-	return 0;
+	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
 }
 
-void nfsd_stat_shutdown(void)
+void nfsd_proc_stat_shutdown(struct net *net)
 {
-	nfsd_stat_counters_destroy();
-	svc_proc_unregister(&init_net, "nfsd");
+	svc_proc_unregister(net, "nfsd");
 }
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -39,8 +39,10 @@ extern struct svc_stat		nfsd_svcstats;
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-int nfsd_stat_init(void);
-void nfsd_stat_shutdown(void);
+int nfsd_stat_counters_init(void);
+void nfsd_stat_counters_destroy(void);
+void nfsd_proc_stat_init(struct net *net);
+void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(void)
 {


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
