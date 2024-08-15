Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56680C3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 08:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A66E3D21FE
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:44:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F18AD3D21C4
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2E2991000965
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:40:49 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A94CB61AB3;
 Thu, 15 Aug 2024 08:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E02C32786;
 Thu, 15 Aug 2024 08:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723711248;
 bh=p54KPTEc1MHk5mkB8HHjZJuweZ2f3tSp/tLp+YXfwDE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Bv/bxaRTqNy4XLQMCiYYk0LvQekibWOMAQxEykkn3jGJu6YjkbDtCOkCkCjfz2deu
 1Y5/rjOD9sQiemg5AESxftHt1qBGgLzVF0c+7AXobPiuWcvFf9Hls6j6Y2sHgtVSkr
 6M4lK9QTT0sK+/EoYP9sujLSqQsZ37CBV4HiJFo0=
To: calum.mackay@oracle.com, cel@kernel.org, chuck.lever@oracle.com,
 gregkh@linuxfoundation.org, jlayton@kernel.org, josef@toxicpanda.com,
 kernel-team@fb.com, ltp@lists.linux.it, pvorel@suse.cz, sherry.yang@oracle.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 15 Aug 2024 10:40:00 +0200
In-Reply-To: <20240810200009.9882-11-cel@kernel.org>
Message-ID: <2024081500-never-buddhism-bcbf@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Patch "nfsd: stop setting ->pg_stats for unused stats" has
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

    nfsd: stop setting ->pg_stats for unused stats

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nfsd-stop-setting-pg_stats-for-unused-stats.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66331-greg=kroah.com@vger.kernel.org Sat Aug 10 22:01:12 2024
From: cel@kernel.org
Date: Sat, 10 Aug 2024 16:00:01 -0400
Subject: nfsd: stop setting ->pg_stats for unused stats
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>, pvorel@suse.cz, sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it, Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Message-ID: <20240810200009.9882-11-cel@kernel.org>

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a2214ed588fb3c5b9824a21cff870482510372bb ]

A lot of places are setting a blank svc_stats in ->pg_stats and never
utilizing these stats.  Remove all of these extra structs as we're not
reporting these stats anywhere.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/lockd/svc.c    |    3 ---
 fs/nfs/callback.c |    3 ---
 fs/nfsd/nfssvc.c  |    5 -----
 3 files changed, 11 deletions(-)

--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -759,8 +759,6 @@ static const struct svc_version *nlmsvc_
 #endif
 };
 
-static struct svc_stat		nlmsvc_stats;
-
 #define NLM_NRVERS	ARRAY_SIZE(nlmsvc_version)
 static struct svc_program	nlmsvc_program = {
 	.pg_prog		= NLM_PROGRAM,		/* program number */
@@ -768,7 +766,6 @@ static struct svc_program	nlmsvc_program
 	.pg_vers		= nlmsvc_version,	/* version table */
 	.pg_name		= "lockd",		/* service name */
 	.pg_class		= "nfsd",		/* share authentication with nfsd */
-	.pg_stats		= &nlmsvc_stats,	/* stats table */
 	.pg_authenticate	= &lockd_authenticate,	/* export authentication */
 	.pg_init_request	= svc_generic_init_request,
 	.pg_rpcbind_set		= svc_generic_rpcbind_set,
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -407,15 +407,12 @@ static const struct svc_version *nfs4_ca
 	[4] = &nfs4_callback_version4,
 };
 
-static struct svc_stat nfs4_callback_stats;
-
 static struct svc_program nfs4_callback_program = {
 	.pg_prog = NFS4_CALLBACK,			/* RPC service number */
 	.pg_nvers = ARRAY_SIZE(nfs4_callback_version),	/* Number of entries */
 	.pg_vers = nfs4_callback_version,		/* version table */
 	.pg_name = "NFSv4 callback",			/* service name */
 	.pg_class = "nfs",				/* authentication class */
-	.pg_stats = &nfs4_callback_stats,
 	.pg_authenticate = nfs_callback_authenticate,
 	.pg_init_request = svc_generic_init_request,
 	.pg_rpcbind_set	= svc_generic_rpcbind_set,
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -89,7 +89,6 @@ unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-static struct svc_stat	nfsd_acl_svcstats;
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
 	[2] = &nfsd_acl_version2,
@@ -108,15 +107,11 @@ static struct svc_program	nfsd_acl_progr
 	.pg_vers		= nfsd_acl_version,
 	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
-	.pg_stats		= &nfsd_acl_svcstats,
 	.pg_authenticate	= &svc_set_client,
 	.pg_init_request	= nfsd_acl_init_request,
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 };
 
-static struct svc_stat	nfsd_acl_svcstats = {
-	.program	= &nfsd_acl_program,
-};
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {


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
