Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C335C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 05:55:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6ED43CB7ED
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 06:55:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3542C3CAEE6
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 06:55:14 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2538C20033D
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 06:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1678427711; i=@fujitsu.com;
 bh=m6OT3eLYgOGXAhLYsy2YTo3WACPuWZSWWsFn3RMXwcU=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=bs2hsCXzCFANMHqcddNeKV2u0X+YmjAkzOWS4ZyBCbqtMZ31BTYyvuRyHZmlOuyVi
 Pxm8G9eI2RXs+qgFUS1wedSnnO8W1rX/ff64TRQVLgnxMjjuujlJo+7KdczZ3d4ccF
 NjL16ziCeghF5KnQx1+23WqqtdL5zZAyQu4aZFdh/A9TXcYWOxD06+PGn6M6RNt08J
 5rlzoPY2yQ+tfn6x+3/lT6/11k1QE9e7MxuTAxAf/+I4SoHXgBRqNuQ3x7w2g64MMb
 rLPoUXt9k2osf5InnTrizMLcKqwRMJgn4CTTkIkTMnhUtIKFCO/QZzoCO+QSVzbCnx
 m6rtweM+TASTA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRWlGSWpSXmKPExsViZ8OxWdfuGFe
 KwfT5UhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aWG5wF1zkr+ub/Y29gPMzRxcjFISRwklHi
 2Of3bBDOHiaJxR9aWboYOYGcvYwSC/r8QWw2AU2JZ50LmEFsEQEJiY6Gt+wgNrOAusTySb+YQ
 GxhAVOJh7eeMnYxcnCwCKhKPG1PAwnzCnhK7Np8HKxcQkBBYsrD98wQcUGJkzOfsECMkZA4+O
 IFM0SNkkRb6xVWCLtConH6ISYIW03i6rlNzBMY+WchaZ+FpH0BI9MqRtPi1KKy1CJdE72kosz
 0jJLcxMwcvcQq3US91FLd8tTiEl1DvcTyYr3U4mK94src5JwUvbzUkk2MwDBMKWZ9u4Pxf+9f
 vUOMkhxMSqK8yqlcKUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeP0PAOUEi1LTUyvSMnOAMQGTl
 uDgURLhZd0BlOYtLkjMLc5Mh0idYjTmWNtwYC8zx6Z9XQeYhVjy8vNSpcR5ZY4ClQqAlGaU5s
 ENgsXqJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvKmHgabwZOaVwO17BXQKE9Apu7ZwgJx
 SkoiQkmpgUtq0tnDanX69H8zcgpa+j9++NFI47eutsPEse7xBoXztBNfvCedOLXkpwbM0fsHt
 QF5jrpRDXt5iO/z+yEpL9p1jN/inpH9rWlhAtPX8A/FfpxX11SxTPxYsM6fhfe7qVbJzD1Szm
 27PX8dXLPCJ4fn9cKPE363zlklGOvIZd9hPOuN+couPEN+XxrvGx2UkX2woffLrx741DyT6Jr
 2x1g09fMzQOfauffThBJ3XS2Y3ShQuyvH6GMRQWbluQsWCGZ+bX5mK+C/63GQ84e3yoHSp/pY
 M2w7di4I7FtRtrduUs6iv7dqNwkLLBQEaN+Vb+8UmPFzYVrhm68o1ee+/XK5ZcbnvR98jMYm1
 Bzh/KLEUZyQaajEXFScCAGCSiIZQAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-591.messagelabs.com!1678427710!606299!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.103.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23075 invoked from network); 10 Mar 2023 05:55:10 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-12.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Mar 2023 05:55:10 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 1394873
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 05:55:10 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 06F427B
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 05:55:10 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 10 Mar 2023 05:55:08 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 10 Mar 2023 13:54:55 +0800
Message-ID: <1678427695-12871-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_lib.sh: Add fallback for RHEL8
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

As the same as RHEL9, this kernel patch has been merged on RHEL8. You can
see it in url[1], to avoid false report, so add a fallback for this.

[1]http://www.rpmfind.net/linux/RPM/centos/8-stream/baseos/x86_64/Packages/kernel-4.18.0-448.el8.x86_64.html

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index dbb61e6b1..5efede9cf 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -404,8 +404,8 @@ fi
 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
 # Post 6.1 kernel updates stat in batch (> 64 pages) every time
 # 1813e51eece0ad6 ("memcg: increase MEMCG_CHARGE_BATCH to 64")
-# has been merged since 5.14.0-191.el9.
-if tst_kvcmp -lt "6.1 RHEL9:5.14.0-191" ; then
+# has been merged since 5.14.0-191.el9 and 4.18.0-438.el8.
+if tst_kvcmp -lt "6.1 RHEL9:5.14.0-191 RHEL8:4.18.0-438" ; then
 	PAGESIZES=$(($PAGESIZE * 33))
 else
 	PAGESIZES=$(($PAGESIZE * 65))
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
