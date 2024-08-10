Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E85AC52D7B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:20:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 713883D210A
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:20:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 094763CB98F
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:27 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=cel@kernel.org; receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D6D41A006F8
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:26 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8E867CE0E29;
 Sat, 10 Aug 2024 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25EEC32781;
 Sat, 10 Aug 2024 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723320021;
 bh=qOKcnQkaX10mZFAjQgmcLyscNeRuIIwIDOc8y9F/bsg=;
 h=From:To:Cc:Subject:Date:From;
 b=W9yGIITY0d+t9fudujiHz7Et7B8hWewMPqIvRub3FtE4yndHtoXvzhPbMHHPfNLXR
 KH2/4q/FBTiTkoPljLhEuDjitTYsHCgxjT1wGRPTT0+MY+P3jLQW9L9u0wjE2YmvZQ
 6pI1o3smnRJyrBmDdrJZ07JG82v73IHqHJLZjv8liPMD3if8j7HhL6FOEsOcoDZN35
 eJywZW5fv64uj+qm8JYCjiiNqFHFFNOpBZ1/LC99YkT8x2F6ZTdIV35db/jj3ljFeY
 J6fVphICe18RtapeYRHYMs6E4UXoekBdfeIM0EEkro1hEJY26M7++Cu9om9Kj0TG66
 AlCahi+PXtrvg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Date: Sat, 10 Aug 2024 15:59:51 -0400
Message-ID: <20240810200009.9882-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:42 +0200
Subject: [LTP] [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead
 of global"
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
Cc: linux-nfs@vger.kernel.org, sherry.yang@oracle.com,
 Chuck Lever <chuck.lever@oracle.com>, calum.mackay@oracle.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Chuck Lever <chuck.lever@oracle.com>

Following up on

https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/

Here is a backport series targeting origin/linux-6.1.y that closes
the information leak described in the above thread.

I started with v6.1.y because that is the most recent LTS kernel
and thus the closest to upstream. I plan to look at 5.15 and 5.10
LTS too if this series is applied to v6.1.y.

Review comments welcome.

Chuck Lever (6):
  NFSD: Refactor nfsd_reply_cache_free_locked()
  NFSD: Rename nfsd_reply_cache_alloc()
  NFSD: Replace nfsd_prune_bucket()
  NFSD: Refactor the duplicate reply cache shrinker
  NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
  NFSD: Fix frame size warning in svc_export_parse()

Jeff Layton (2):
  nfsd: move reply cache initialization into nfsd startup
  nfsd: move init of percpu reply_cache_stats counters back to
    nfsd_init_net

Josef Bacik (10):
  sunrpc: don't change ->sv_stats if it doesn't exist
  nfsd: stop setting ->pg_stats for unused stats
  sunrpc: pass in the sv_stats struct through svc_create_pooled
  sunrpc: remove ->pg_stats from svc_program
  sunrpc: use the struct net as the svc proc private
  nfsd: rename NFSD_NET_* to NFSD_STATS_*
  nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
  nfsd: make all of the nfsd stats per-network namespace
  nfsd: remove nfsd_stats, make th_cnt a global counter
  nfsd: make svc_stat per-network namespace instead of global

 fs/lockd/svc.c             |   3 -
 fs/nfs/callback.c          |   3 -
 fs/nfsd/export.c           |  32 ++++--
 fs/nfsd/export.h           |   4 +-
 fs/nfsd/netns.h            |  25 ++++-
 fs/nfsd/nfs4proc.c         |   6 +-
 fs/nfsd/nfscache.c         | 201 ++++++++++++++++++++++---------------
 fs/nfsd/nfsctl.c           |  24 ++---
 fs/nfsd/nfsd.h             |   1 +
 fs/nfsd/nfsfh.c            |   3 +-
 fs/nfsd/nfssvc.c           |  24 +++--
 fs/nfsd/stats.c            |  52 ++++------
 fs/nfsd/stats.h            |  83 ++++++---------
 fs/nfsd/trace.h            |  22 ++++
 fs/nfsd/vfs.c              |   6 +-
 include/linux/sunrpc/svc.h |   5 +-
 net/sunrpc/stats.c         |   2 +-
 net/sunrpc/svc.c           |  36 ++++---
 18 files changed, 301 insertions(+), 231 deletions(-)

-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
