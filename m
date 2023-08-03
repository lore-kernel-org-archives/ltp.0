Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97175C00528
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 10:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DBEB3CD71B
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 12:30:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82F263CC397
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:30:28 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 309581A009B3
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:30:24 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 373AUGg4064327
 for <ltp@lists.linux.it>; Thu, 3 Aug 2023 18:30:16 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 3 Aug 2023
 18:30:12 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <ltp@lists.linux.it>
Date: Thu, 3 Aug 2023 18:30:04 +0800
Message-ID: <20230803103004.2429973-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 373AUGg4064327
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] hugeshmat04: Restore the correct shmmax value
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
Cc: cynthia@andestech.com, patrick@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The type of shmmax is unsinged long in Linux kernel and the default value
is ((~0UL) - (1UL << 24)). If we try to access this value with %ld format
string in scanf-like function, we end up getting different incorrect values
depends on the implementation of different libc.

Fix this by accessing shmmax with the correct %lu format string.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 50efa8a52..b3e7c272a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -83,12 +83,12 @@ static void setup(void)
 	long hpage_size, orig_hugepages;
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
-	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &new_shmmax);
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &orig_shmmax);
+	SAFE_FILE_PRINTF(PATH_SHMMAX, "%lu", (long)SIZE);
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
 
 	if (new_shmmax < SIZE)
-		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
+		tst_brk(TCONF,	"shmmax too low, have: %lu", new_shmmax);
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -99,7 +99,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (orig_shmmax != -1)
-		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
+		SAFE_FILE_PRINTF(PATH_SHMMAX, "%lu", orig_shmmax);
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
