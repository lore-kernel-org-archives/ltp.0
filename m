Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3610C6FA8F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 11:11:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FD833CC4DE
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 13:11:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5C7C3CC4D3
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:11:34 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC0C0200742
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:11:33 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="117572367"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; d="scan'208";a="117572367"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:11:31 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 84FC4DB3B1
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:11:27 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id CCBFBCF7D6
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:11:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B9C985D84;
 Thu, 24 Aug 2023 20:11:25 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 19:11:19 +0800
Message-Id: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27832.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27832.006
X-TMASE-Result: 10--5.672500-10.000000
X-TMASE-MatchedRID: a6UZ3YjwObAKK0r2G9VU7k7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOJqR
 wQQ91eVspsX84hgxtpp3oCF5IgP2qR8TzIzimOwPruuVAw9Gg4LEQdG7H66TyH4gKq42LRYkVnw
 r7upJwB6PVN+zMheqZcYbnijqufvtjDxjAM1PZFV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] hugeshmctl01: Mark struct tcase as static
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To follow LTP conventions.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 11cd69050..8cacde7cd 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -53,7 +53,7 @@ static void func_set(void);
 static void func_rmid(void);
 static void *set_shmat(void);
 
-struct tcase {
+static struct tcase {
 	int cmd;
 	void (*func_test) (void);
 	void (*func_setup) (void);
@@ -90,7 +90,7 @@ static void test_hugeshmctl(unsigned int i)
 /*
  * set_shmat() - Attach the shared memory and return the pointer.
  */
-void *set_shmat(void)
+static void *set_shmat(void)
 {
 	void *rval;
 
@@ -279,7 +279,7 @@ static void func_rmid(void)
 	shm_id_1 = -1;
 }
 
-void setup(void)
+static void setup(void)
 {
 	long hpage_size;
 
@@ -293,7 +293,7 @@ void setup(void)
 	shmkey = getipckey();
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	rm_shm(shm_id_1);
 }
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
