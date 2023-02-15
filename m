Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233D7C636D7
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:55:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1FF03CC427
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:55:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A9D13CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 263A3200ACA
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:50 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F755150C
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:55:31 -0800 (PST)
Received: from e126380.cambridge.arm.com (unknown [10.1.196.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 516EA3F703
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:54:48 -0800 (PST)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 14:54:40 +0000
Message-Id: <20230215145440.78482-4-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215145440.78482-1-teo.coupriediaz@arm.com>
References: <20230215145440.78482-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ipc/msgstress03: Assume all forks will run
 concurently
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
---
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
