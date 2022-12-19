Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E6C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 06:16:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BD2E3CBAEA
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 07:16:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A4B23CBADA
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 07:16:06 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66C1E6005E3
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 07:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671430564; i=@fujitsu.com;
 bh=ivz3qzD+PzSjNYtJmmLwGjtDTxZhTAZl9JoVMyxbO0k=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=sqeoxYQ06KKS6SYLwIUIlYn0nR8cXfS95uZ1AuAPYiKKvMMaZBmN3bMXluDpZ3l+4
 cjuKUMxx867AUxPloz/w7JCyZYX7MOAm5BdfyGHwk5bL45q7+oicL5kUNPvk02Ad8U
 9mEK1L01zeHtXMeKVYUWe6seuS5CyZug+h08IaAUAQEhEyD/5v1YdxQQHUeRM0IMSH
 wyzvp7dSM9EwzAgPqe/bAyS3OPh1ncuVaMSmNaDNmibWq8Koy+3O6RmOBA04BSDmoa
 rJ4euo3yqyiSh4qZLKtZi5RIEp75oBQMQFqN51fUpDHIXV9w+u7C919dkJi1pFPkOk
 wF4cyHMLKn/8A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8OxWXcx44J
 kgyNPFS0mHU612LxnHYvFiu87GB2YPfb9Xsfq8X7fVbYApijWzLyk/IoE1ozda+4yF9zgqDjb
 MZ+1gfEKexcjF4eQwEZGiftvvgM5nEDOYiaJBxMLIRJ7GCV2bngOlmAT0JR41rmAGcQWEZCQ6
 Gh4CxTn4GAWCJH4dNsRJCwsYCnxou0kK4jNIqAqseVbGxOIzSvgIbHkRh8biC0hoCAx5eF7sD
 GcAp4SX3ffZoHY6yHR9Xc6M0S9oMTJmU/A4sxAqw6+eMEM0asocanjGyOEXSExaxbEfAkBNYm
 r5zYxT2AUnIWkfRaS9gWMTKsYzYtTi8pSi3QNTfWSijLTM0pyEzNz9BKrdBP1Ukt18/KLSjJ0
 DfUSy4v1UouL9Yorc5NzUvTyUks2MQIDO6U4gXsH46Nlf/QOMUpyMCmJ8vL8m58sxJeUn1KZk
 VicEV9UmpNafIhRhoNDSYJ3xm+gnGBRanpqRVpmDjDKYNISHDxKIryf/wKleYsLEnOLM9MhUq
 cYjTnWNhzYy8yxaV/XAWYhlrz8vFQpcd4qhgXJQgIgpRmleXCDYNF/iVFWSpiXkYGBQYinILU
 oN7MEVf4VozgHo5Iw7zmQhTyZeSVw+14BncIEdMqhS3NBTilJREhJNTA1LH8WVX5D3n3u4fnb
 m3RbHCvlu1RbjJ/cuvx07/O0zgusp2+vOCt5S8hB1F9TjWnxFLm8UG3NSaIRiUv+Zjo5qers2
 fPG9VDAlsqzBhbWqqazVsz+0/rWfNr6a0caI1I//pyv/49V1+KFxY+NMdV+hyc8XSrg37D/4F
 RjyeclNYs3P5CUW1m9s/iXZ3/B2dOrqy6Fb705hd05eK/svSnFq99+jdvvnpdt82/Slo/Hb3n
 E3pmYoGwfc+Lj0mOXgg5+uxl8Zva/P8dnnfNO7RadpJ/51/N1yBXJHMUXXEp1T+bbRFrEcTW6
 WhhfcVReoHZXzGKlldRW9fD6KzMWrctvW1focpZt9q9VUV2hq4qeKLEUZyQaajEXFScCAG63I
 Ph5AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-745.messagelabs.com!1671430563!258601!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31008 invoked from network); 19 Dec 2022 06:16:03 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-12.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 19 Dec 2022 06:16:03 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id D6938142;
 Mon, 19 Dec 2022 06:16:02 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id CA50D73;
 Mon, 19 Dec 2022 06:16:02 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 19 Dec 2022 06:16:00 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 19 Dec 2022 15:16:27 +0800
Message-ID: <1671434187-2038-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] memcg_lib.sh: Add fallback for RHEL9
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

The kernel patch has been merged on RHEL9. You can see it
in url[1], to avoid false report, so add a fallback for this.

[1]http://www.rpmfind.net/linux/RPM/centos-stream/9/baseos/x86_64/kernel-5.14.0-205.el9.x86_64.html
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 004946456..dbb61e6b1 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -403,7 +403,9 @@ fi
 
 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
 # Post 6.1 kernel updates stat in batch (> 64 pages) every time
-if tst_kvcmp -lt "6.1"; then
+# 1813e51eece0ad6 ("memcg: increase MEMCG_CHARGE_BATCH to 64")
+# has been merged since 5.14.0-191.el9.
+if tst_kvcmp -lt "6.1 RHEL9:5.14.0-191" ; then
 	PAGESIZES=$(($PAGESIZE * 33))
 else
 	PAGESIZES=$(($PAGESIZE * 65))
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
