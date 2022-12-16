Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B5C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 04:01:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09E033CBCEC
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 05:01:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EDBA3CBCFC
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:16 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8911C1A006BC
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671163274; i=@fujitsu.com;
 bh=OoEAQe8z8B2DMzg+O0ctopCnZGQfmwXMxYFaQj+8Ln0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=oQpep1c7H1mIjSx5x9oDwzTkLbMFt3I088G2FM1tlbDZTSEezFQgNz9AAHfX62ApR
 LuIuHcPNqh5rzbvsNSbZqPU4+JThY1LLyWPe/bQeVL66Std3qyV5EV7l3aChRWVVkV
 +KULudxB8aSUAOXUSV8AUOsx+nT3BZFRmVmymBUUXRT8U/wqdNJnnyMsTFwOHQnBVA
 VQUBPujtQqNVqj86QUtfl6SoLuwY48IV0rEEqnnnFADPNzobTplbcFTrFcdtZWgDeb
 zA6x3YIOtW/qoEXyD/3/lTC/IItAo3fuLEeERXygTMqIsjzL2SNLlHWqutLONEqO4D
 RBJUpzFL9AWzg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8OxWbfz7ex
 kg6c7TCxWfN/B6MDose/3OtYAxijWzLyk/IoE1oyr31ewFXzgqLjYfoGtgXE/excjF4eQwClG
 iacblzJDOHuZJNb3nmCFcPYwShx69Z6pi5GTg01AU+JZ5wJmEFtEQEKio+EtO4jNLKAusXzSL
 7AaYQE9ifmPZoHFWQRUJR6/XsgIYvMKeEjcur0SLC4hoCAx5eF7oDkcHJwCnhKPjzmDmEJAJe
 /+1UNUC0qcnPmEBWK6hMTBFy+YIToVJS51fGOEsCskZs1qY4Kw1SSuntvEPIFRcBaS9llI2hc
 wMq1iNCtOLSpLLdI110sqykzPKMlNzMzRS6zSTdRLLdXNyy8qydA11EssL9ZLLS7WK67MTc5J
 0ctLLdnECAzdlOKEnzsYNy77o3eIUZKDSUmUV3/57GQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKE
 ryVr4FygkWp6akVaZk5wDiCSUtw8CiJ8G65AJTmLS5IzC3OTIdInWJUlBLnXfkKKCEAksgozY
 Nrg8XuJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvBdeAk3hycwrgZv+CmgxE9BimXszQRa
 XJCKkpBqYMovf/shJMHbSujfvsrzqlUaHf9NCo1c+3xjKyL5mQY26gYaWw/Hv65dlM1vp33Hw
 4m6/qaRVvZb71vZFbVYRxbv7phqW+NY06lz3cuUWabr1YRHPhy/l1zb0d6eeXdh8Wm0v464f9
 Wt2vjO6ynLFm1ty0qFLj+4rHlHsTe1jEJPm5Qla8PF+GccS0Q9HnY4XeHLZrdT6rjT7ycFK28
 LnJ+MaX+/kiHl6b0ae+vxbP6J38jvHs8/5ZXHS81aA2OnbNRxVH9oSL8uF2KwUj/27+Y9g3qv
 lRu8PSz1Wffvo3Pyjt9V63h64pHnMKkL5t/biyjCLhK0LC/4fT10S8sa9nf3Mq+LrTH2WTEe0
 VuR8VmIpzkg01GIuKk4EAFnzwA9YAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-728.messagelabs.com!1671163273!68348!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15742 invoked from network); 16 Dec 2022 04:01:13 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-8.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Dec 2022 04:01:13 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 5114F154
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 4477C150
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:13 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 16 Dec 2022 04:01:11 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 16 Dec 2022 13:02:00 +0800
Message-ID: <1671166923-2173-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] doc/shell-test-api.txt
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

Update tst_kvcmp usage.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 73c9eff91..f35561e54 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -652,13 +652,15 @@ tst_kvcmp
 +++++++++
 
 This command compares the currently running kernel version given conditions
-with syntax similar to the shell test command.
+with syntax similar to the shell test command. Now, the oldest supported kernel
+version for ltp is 3.0, so we don't need this if comparing with very old version
+ie 2.6.8 .
 
 [source,sh]
 -------------------------------------------------------------------------------
-# Exit the test if kernel version is older or equal to 2.6.8
-if tst_kvcmp -le 2.6.8; then
-	tst_brk TCONF "Kernel newer than 2.6.8 is needed"
+# Exit the test if kernel version is older or equal to 4.0.0
+if tst_kvcmp -le 4.0.0; then
+	tst_brk TCONF "Kernel newer than 4.0.0 is needed"
 fi
 
 # Exit the test if kernel is newer than 3.8 and older than 4.0.1
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
