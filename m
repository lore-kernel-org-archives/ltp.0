Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837ABEA4FA1
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771844343; h=to :
 message-id : references : in-reply-to : date : mime-version : subject
 : list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8i+9spDgANL4SL5/yivz1g/1ueMTBzbdhbdKei3W6SQ=;
 b=lEzwM05JDfKehHSEnXf0MG9LpWwP2riDwZTt9Vrsq80GBx3DoDO7MHB1XRqx8AvCUhmd+
 u61p7eDyaTGLeTo84kZ5r6bH5wZdvnSCXbt9t9plPgmpZHHH9GI5DpQYsr8LkWPQkhiN26u
 ZCi+Y/ULUBIIx+KMwd2PO9Vo8RvO0PY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12EE93D00A7
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:59:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37B1F3CBBE1
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:39 +0100 (CET)
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com
 [103.149.242.128])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BCBB71A00142
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1771816712; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3Jqv1J878PeKRegBxQN8B7FN0/VUtsafCVJl9menxgw=;
 b=Si8v/ORq+CvqEvJmAWvsLGiXhbGFwAWIKulj8KVXQjQkXkseFZA4xH164tA/tK7LDGp4sc
 qTprCyFd/5oGqW6MfDslpEVaIewpeyThL3VpjK6T56Bzvp5teTzXNag6YtJSu3vDSWIBEv
 JmtE5v0yviSg4UE3fFyD/EeEyEZ/IA0+coQP6PtZVhJjzHb25smL4RHDHFRjrW/gYXif9p
 saelFyjg6uTd9AXMFcJTfnq0SzmdUeQNyfhI7o3MCmOwyLPsndC5BtQVWXXB6k8P8ykMSg
 QuVY8xYGTUgKgnzCU75UJi0vCEZNNSe8H4pQD+20SrbPKnR3rsPGW3zZZ3dfvg==
X-Lms-Return-Path: <lba+2699bc706+2687d0+lists.linux.it+weiguixiong@bytedance.com>
To: <ltp@lists.linux.it>
Message-Id: <20260223031903.4037526-4-weiguixiong@bytedance.com>
References: <20260223031903.4037526-1-weiguixiong@bytedance.com>
In-Reply-To: <20260223031903.4037526-1-weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.20.1
Date: Mon, 23 Feb 2026 11:19:02 +0800
Mime-Version: 1.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:57:56 +0100
Subject: [LTP] [PATCH 3/4] syscalls/ipc: shmctl04: Use SAFE_FOPEN for /proc
 parsing
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

Use SAFE_FOPEN/SAFE_FCLOSE when reading /proc/sysvipc/shm.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 967e5d4b2..97e84efb6 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -22,6 +22,7 @@
 #include <stdio.h>
 #include <pwd.h>
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 #include "lapi/shm.h"
@@ -42,7 +43,7 @@ static struct tcases {
 static void parse_proc_sysvipc(struct shm_info *info)
 {
 	int page_size = getpagesize();
-	FILE *f = fopen("/proc/sysvipc/shm", "r");
+	FILE *f = SAFE_FOPEN("/proc/sysvipc/shm", "r");
 	int used_ids = 0;
 	int shmid_max = 0;
 	unsigned long shm_rss = 0;
@@ -105,7 +106,7 @@ static void parse_proc_sysvipc(struct shm_info *info)
 		tst_res(TPASS, "shm_tot = %li", shm_tot);
 	}
 
-	fclose(f);
+	SAFE_FCLOSE(f);
 }
 
 static void verify_shminfo(unsigned int n)
-- 
2.20.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
