Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0654C7113B
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 11:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01C3C3CC4BC
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 13:11:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E931C3CB9B3
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:11:32 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5824A1A00E06
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:11:31 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="108759574"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; d="scan'208";a="108759574"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:11:30 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F144BC9442
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:11:27 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 423D0CF7D6
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:11:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AD8487038;
 Thu, 24 Aug 2023 20:11:26 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 19:11:20 +0800
Message-Id: <1692875480-22494-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27832.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27832.006
X-TMASE-Result: 10--3.517500-10.000000
X-TMASE-MatchedRID: 53L3gibb0joKK0r2G9VU7k7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOBUl
 FfwzsqyWj/os4F7akNn0SV7CRnVQRDcpdZ3fQiLdFEUknJ/kEl5q8/xv2Um1avoLR4+zsDTtB00
 /kkeBTwBYxPdn7vfkRt0RrKuj0zhaATt3Dopl1AMRTtzWDagGnw/tmJ7blzYOnNMe5DmGdOlF8u
 cRiMf+cwNQosDE6LmkUSRo4gE5q0byDBYNCJzj6s+YAJ5mo7zlOKgonZY9TFMtLgAQ4uO3AA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] hugeshmctl03: Mark struct tcase as static
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
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 21ec6bf78..61e9704bb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -44,7 +44,7 @@ static struct shmid_ds buf;
 static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
-struct tcase {
+static struct tcase {
 	int *shmid;
 	int cmd;
 	struct shmid_ds *sbuf;
@@ -97,7 +97,7 @@ static void do_child(void)
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
 	long hpage_size;
 
@@ -118,7 +118,7 @@ void setup(void)
 	ltp_uid = getuserid(ltp_user);
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
