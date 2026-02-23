Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9E2EA4FA1
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771844386; h=date :
 message-id : in-reply-to : references : to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=040yvxdya2/AOF5ezyqFiuzd3/eQw8M1hPKYZwG64Eg=;
 b=TUYmV+vQ5errpjt6BDdxZCFM45mD+0kUFuGF381SQQ8XxGRXt42c8kcMGujuJ4VUt+XL1
 cr36N1JMRSizVb6tPn8OBw4GVYBQIDj0x0CMv4o4ODJrGgNx9TURgv2CsMJpt+PgLpm6WWY
 /Iw06q83vtfFWAZkufLmIxEILpq9XBE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F92D3C2746
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:59:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7C23D066D
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:45 +0100 (CET)
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com
 [103.149.242.128])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76B4C2000D2
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1771816717; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=t0pdGuUkXJpizz+Yw8QvTNxJ19e8DkTjaYaZByI20FU=;
 b=oh8P27+aV/d3KZgRzVpZAIgOFhxRcqoLB40Y8lZgLrpUoLBddAJ60/0O1W2F5Ug3v6XS5D
 +66RJsQK1+o6Gbbv30m8rWWdjZTJydJ3ERE9hymBqgyjwb49s7gqDBlShuindN3PBXdHxk
 4L3nc15SBzrMYlEbc6bu932HIgczLma5BFiQDNBuaD5WZB5aqCJZQcoSBpsq21wVMzFUyr
 2BTpMftp7748oPWKN9IHDYOFABqPEQ2hlDkK8Tb/xI5htszX+oTlp+NZrZolPexcbFujL/
 2Rhhgdgh/FUyVEhED2j9dgdSsQ/+2hmOqnUCaKdbH+sSAxrcnnlY2hGt3TWOZg==
Date: Mon, 23 Feb 2026 11:19:03 +0800
Message-Id: <20260223031903.4037526-5-weiguixiong@bytedance.com>
In-Reply-To: <20260223031903.4037526-1-weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+2699bc70b+7b3caa+lists.linux.it+weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
References: <20260223031903.4037526-1-weiguixiong@bytedance.com>
To: <ltp@lists.linux.it>
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:57:56 +0100
Subject: [LTP] [PATCH 4/4] syscalls/ipc: shmctl04: Fix shm_info print formats
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
From: Guixiong Wei via ltp <ltp@lists.linux.it>
Reply-To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use %lu when printing unsigned long counters parsed from /proc and
cast shm_info fields to match the format specifiers.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 97e84efb6..f436e763d 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -86,24 +86,24 @@ static void parse_proc_sysvipc(struct shm_info *info)
 	}
 
 	if (info->shm_rss != shm_rss) {
-		tst_res(TFAIL, "shm_rss = %li, expected %li",
+		tst_res(TFAIL, "shm_rss = %lu, expected %lu",
 			info->shm_rss, shm_rss);
 	} else {
-		tst_res(TPASS, "shm_rss = %li", shm_rss);
+		tst_res(TPASS, "shm_rss = %lu", shm_rss);
 	}
 
 	if (info->shm_swp != shm_swp) {
-		tst_res(TFAIL, "shm_swp = %li, expected %li",
+		tst_res(TFAIL, "shm_swp = %lu, expected %lu",
 			info->shm_swp, shm_swp);
 	} else {
-		tst_res(TPASS, "shm_swp = %li", shm_swp);
+		tst_res(TPASS, "shm_swp = %lu", shm_swp);
 	}
 
 	if (info->shm_tot != shm_tot) {
-		tst_res(TFAIL, "shm_tot = %li, expected %li",
+		tst_res(TFAIL, "shm_tot = %lu, expected %lu",
 			info->shm_tot, shm_tot);
 	} else {
-		tst_res(TPASS, "shm_tot = %li", shm_tot);
+		tst_res(TPASS, "shm_tot = %lu", shm_tot);
 	}
 
 	SAFE_FCLOSE(f);
-- 
2.20.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
