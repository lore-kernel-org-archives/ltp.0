Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14598C52D7B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:24:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7BB63D2144
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:24:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 857293D1CA3
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:01:31 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=cel@kernel.org; receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D4722005DB
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:01:29 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0A6DACE1024;
 Sat, 10 Aug 2024 20:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7BC4AF0D;
 Sat, 10 Aug 2024 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723320087;
 bh=UVvGKjNkfbegLXzdyWRN4cGHbBWTIrLb9AIOOzEp/d4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ctTWWYCow39Q1QirBTFEeg7hNPHRG5cME2PdJxqXlyUjbKJkM45kF4cQV6hBiF6fI
 oZC/f0cRb1VfVWWDAcGSEHG41k1V1h43bQ9HQfHVNfQ2OhKVeM9yZEmtUCG0C8zRwv
 Bm8dIwyCfHzkdaDUfA0nJpsaemnoJ2MMVo489McgsdwltNwN8ikyMQHLbi10zWVa3Y
 wODWbKz7Je8W+fx0C0WmQ+pRX0WWKGvFF9VV7N7aywd4HCxNVUfEGGMZoYMiwH5eK+
 dbsHX4nYdvCufVmnJrPJ5iNGwfwv/PQQIyuklsx4xtqRpU8897esTVLR4WB9BZiaQy
 9IiJF0eneLYBA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Date: Sat, 10 Aug 2024 16:00:09 -0400
Message-ID: <20240810200009.9882-19-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:43 +0200
Subject: [LTP] [PATCH 6.1.y 18/18] nfsd: make svc_stat per-network namespace
 instead of global
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

[ Upstream commit 16fb9808ab2c99979f081987752abcbc5b092eac ]

The final bit of stats that is global is the rpc svc_stat.  Move this
into the nfsd_net struct and use that everywhere instead of the global
struct.  Remove the unused global struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h  |  4 ++++
 fs/nfsd/nfsctl.c |  2 ++
 fs/nfsd/nfssvc.c |  2 +-
 fs/nfsd/stats.c  | 10 ++++------
 fs/nfsd/stats.h  |  2 --
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 55ab92326384..548422b24a7d 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
+#include <linux/sunrpc/stats.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -183,6 +184,9 @@ struct nfsd_net {
 	/* Per-netns stats counters */
 	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
+	/* sunrpc svc stats */
+	struct svc_stat          nfsd_svcstats;
+
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d7a481aa1dac..813ae75e7128 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1453,6 +1453,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
+	nn->nfsd_svcstats.program = &nfsd_program;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8b944620d798..9eb529969b22 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -657,7 +657,7 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index cd5e48382fba..36f1373bbe3f 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,10 +27,6 @@
 
 #include "nfsd.h"
 
-struct svc_stat		nfsd_svcstats = {
-	.program	= &nfsd_program,
-};
-
 static int nfsd_show(struct seq_file *seq, void *v)
 {
 	struct net *net = pde_data(file_inode(seq->file));
@@ -56,7 +52,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "\nra 0 0 0 0 0 0 0 0 0 0 0 0\n");
 
 	/* show my rpc info */
-	svc_seq_show(seq, &nfsd_svcstats);
+	svc_seq_show(seq, &nn->nfsd_svcstats);
 
 #ifdef CONFIG_NFSD_V4
 	/* Show count for individual nfsv4 operations */
@@ -119,7 +115,9 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 
 void nfsd_proc_stat_init(struct net *net)
 {
-	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b22b1ae929f..14525e854cba 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,8 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-extern struct svc_stat		nfsd_svcstats;
-
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
