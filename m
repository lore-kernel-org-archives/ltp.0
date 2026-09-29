Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87376CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 11:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD1313E5859
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 13:16:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5883A3C2169
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:15:53 +0200 (CEST)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C10D600A3E
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:15:50 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0828225|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0101661-9.33026e-05-0.989741;
 FP=76618393954639341|1|1|2|0|-1|-1|-1; HT=maildocker-contentspam033032062159;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.jROY1n8_1790680540; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jROY1n8_1790680540 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 29 Sep 2026 19:15:47 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Tue, 29 Sep 2026 19:15:27 +0800
Message-ID: <20260929111527.43833-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap10: Treat fd 0 as valid in cleanup
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
Cc: ltp@lists.linux.it, LTP review agent <linuxtestproject.agent@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

File descriptor 0 is valid when stdin is closed. The check in
per_iteration_cleanup() skips it and leaks the hugetlbfs file.

Initialize both map_fd slots to -1 and close any descriptor other than
-1. Initializing the slots also prevents cleanup from closing an unused
slot, which would otherwise start at zero.

Reported-by: LTP review agent <linuxtestproject.agent@gmail.com>
Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index bbbdc82ae..0ffd68962 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -37,7 +37,7 @@ static char *private_noreserve_opt;
 #define NR_SLOTS	2
 #define SL_SETUP	0
 #define SL_TEST		1
-static int map_fd[NR_SLOTS];
+static int map_fd[NR_SLOTS] = { -1, -1 };
 static char *map_addr[NR_SLOTS];
 static unsigned long map_size[NR_SLOTS];
 static unsigned int touched[NR_SLOTS];
@@ -494,7 +494,7 @@ static void per_iteration_cleanup(void)
 	for (nr = 0; nr < NR_SLOTS; nr++) {
 		if (map_addr[nr])
 			SAFE_MUNMAP(map_addr[nr], map_size[nr]);
-		if (map_fd[nr] > 0)
+		if (map_fd[nr] != -1)
 			SAFE_CLOSE(map_fd[nr]);
 	}
 }
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
