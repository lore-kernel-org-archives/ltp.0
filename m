Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B37CEB64DD
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 03:36:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027383C25C1
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 05:36:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 970143C25C1
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 05:36:00 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5C8F60065E
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 05:35:57 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3773ZmSA099366;
 Mon, 7 Aug 2023 11:35:48 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 7 Aug 2023
 11:35:49 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <ltp@lists.linux.it>
Date: Mon, 7 Aug 2023 11:35:36 +0800
Message-ID: <20230807033536.1927020-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3773ZmSA099366
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [v2,
 1/1] hugeshmat04: make use of save_restore to simplify code
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

The type of shmmax is unsinged long in Linux kernel.
We should access it with the correct %lu format string.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 50efa8a52..8ad745d5b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -27,7 +27,6 @@
 
 static long huge_free;
 static long huge_free2;
-static long orig_shmmax = -1, new_shmmax;
 
 static void shared_hugepage(void);
 
@@ -81,14 +80,13 @@ static void shared_hugepage(void)
 static void setup(void)
 {
 	long hpage_size, orig_hugepages;
+	unsigned long new_shmmax;
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
-	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &new_shmmax);
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
 
 	if (new_shmmax < SIZE)
-		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
+		tst_brk(TCONF,	"shmmax too low, have: %lu", new_shmmax);
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -96,12 +94,6 @@ static void setup(void)
 	tst_reserve_hugepages(&hp);
 }
 
-static void cleanup(void)
-{
-	if (orig_shmmax != -1)
-		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
-}
-
 static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c5c99429fa57"},
@@ -114,6 +106,9 @@ static struct tst_test test = {
 	.test = test_hugeshmat,
 	.min_mem_avail = 2048,
 	.setup = setup,
-	.cleanup = cleanup,
 	.hugepages = {1, TST_NEEDS},
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_SHMMAX, "1073741824", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
+		{}
+	},
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
