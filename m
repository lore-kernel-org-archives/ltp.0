Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2760DC6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 16:05:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E9CC3CE2EF
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 17:05:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D37963C010E
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:05:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 2AA45601169
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:04:58 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D981FB;
 Thu, 23 Mar 2023 09:05:40 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.53.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCAB23F766;
 Thu, 23 Mar 2023 09:04:55 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 23 Mar 2023 16:04:42 +0000
Message-Id: <20230323160442.671164-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ipc/msgstress03: Assume all forks will run concurently
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It appears that msgstress03 doesn't account for all PIDs that its children
can use, as it expects the tasks will terminate quickly and not reach
the PID limit.
On some systems, this assumption can be invalid and the PID limit
will be hit.
Change the limit to account for all possible children at once, knowning
that each child will fork as well.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
This patch was already reviewed as part of a larger series[0]. The rest of
the series needs a large rework to be merged, but I felt this patch was a
simple and independnt enough to warrant a resend.
No changes were made.

CI Build: https://github.com/Teo-CD/ltp/actions/runs/4502197808

[0]: https://lists.linux.it/pipermail/ltp/2023-February/033007.html

 testcases/kernel/syscalls/ipc/msgstress/msgstress03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index 3cb70ab18..0c46927b8 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -109,7 +109,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	free_pids = tst_get_free_pids(cleanup);
+	free_pids = tst_get_free_pids(cleanup) / 2;
 	if (nprocs >= free_pids) {
 		tst_resm(TINFO,
 			 "Requested number of processes higher than limit (%d > %d), "
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
