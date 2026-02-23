Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734FBEA4FA0
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771844364; h=message-id :
 mime-version : references : in-reply-to : date : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rthsznYsvLhyGreapEiS/n49Oci4uCZcLou+E0dBxh8=;
 b=jt4rvRYtfQsD8eqC/swGqwqVfOApjoxVrl48myMfSgYC1Sv9NBQYpO9MHcl+UOYBNPRcw
 kHlRHtiQJXOjC7wKHe54sNLaAp0tI8l/Q4A5VXZGrKTJxXC/CatcxJz77HiUjNUw/6xBS3y
 rM8ITcFILSUgo+UuqtIUKdUf+QNy/K0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7F8B3C00AF
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:59:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7B83CBBE1
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:41 +0100 (CET)
Received: from lf-1-129.ptr.blmpb.com (lf-1-129.ptr.blmpb.com
 [103.149.242.129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60EAF2000D2
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1771816707; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rRbhea4LMmEAHRhOUn5PiESHZVazMDVQ3GSgP27y2is=;
 b=eT+ORxOFi/I0H+MjCIp2bNg8x2XqZ3QYt1ngPfQlCis7DD2nQUui0CKhw4Jhn9wkNUHuX6
 M1Dl5Msjc7faxo7AAigLBdKRAPuueSfBLU1T7B0B9NtM4LjlSLjk8N53tccEkk3GP+gDnc
 ZmF8Hu1OpacbTN3YP9GZQmMrbTNgS2vzruVaPMGFISo4Ezfa/sWlEqh2cs2M6X/WFaIpDX
 2ynfLlXpHptzvhsSnmgVnVf/w75ydl+a1/ZLDEd6Kl9HJuqqIV90+YjWamwTLc3zYxp0mp
 PGbRIgXzHCA62s74E+RtgS8DfMiCTZyggSUCzjj3bgVR2p702TY1znQq493UMg==
Message-Id: <20260223031903.4037526-3-weiguixiong@bytedance.com>
Mime-Version: 1.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
References: <20260223031903.4037526-1-weiguixiong@bytedance.com>
In-Reply-To: <20260223031903.4037526-1-weiguixiong@bytedance.com>
Date: Mon, 23 Feb 2026 11:19:01 +0800
X-Lms-Return-Path: <lba+2699bc701+7d2b0a+lists.linux.it+weiguixiong@bytedance.com>
To: <ltp@lists.linux.it>
X-Mailer: git-send-email 2.20.1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:57:56 +0100
Subject: [LTP] [PATCH 2/4] syscalls/ipc: shmctl04: Require full fscanf match
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

Stop parsing /proc/sysvipc/shm when fscanf() does not match all
expected fields, to avoid using stale values from previous iterations.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 908cd2926..967e5d4b2 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -68,7 +68,7 @@ static void parse_proc_sysvipc(struct shm_info *info)
 	 * size.
 	 */
 	while (fscanf(f, "%*i %i %*i %lu %*i %*i %*i %*i %*i %*i %*i %*i %*i %*i %i %i",
-			&shmid, &size, &rss, &swap) > 0) {
+			&shmid, &size, &rss, &swap) == 4) {
 		used_ids++;
 		shm_rss += rss/page_size;
 		shm_swp += swap/page_size;
-- 
2.20.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
