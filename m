Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B73C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A16E6103D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A16E6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01C693C3006
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:10:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 014073C3006
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:05 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 376C9200D36
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562604; i=@fujitsu.com;
 bh=vSmV9yXz8QeryZCGYp8morlFkjV2VxCJgiq4uxFQwAU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=cNEKpu2qJoG8Y+riPfnpyibdtJWXgDv04Cs/eHQWky/2J3zXLY+nZAiB88XZFdkrC
 sQDM5Hk8A4ReZcJJNpd6nc1HE97Ew9oLuclTKxdeF8m66fh114HtzKSe+PF4sZWYXf
 nmWNmZmqWyP/bzxXH4SPpl9C/higl0InkSjYkKQOHfM7UdhEWo47xDia3pcJeYc5A8
 5Vxcc3WXQDeXX1ID/mC9YY1Gk7UIWPF/uHZfHJvnpkF+jfDzlZ+PlpkyMw5LrK+dm3
 i1NYbeduHcrOiuroLOyr/TIPoNabIg2BEWC9K2KINLfi2fkQvDgooRkf9DCXhOrwAz
 jLDYcsUPh5VMA==
Received: from [100.112.195.206] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-a.eu-west-1.aws.symcld.net id 06/25-17094-C227D616;
 Mon, 18 Oct 2021 13:10:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRWlGSWpSXmKPExsViZ8MxVVenKDf
 R4MUqZosV33cwOjB67Pu9jjWAMYo1My8pvyKBNePMt8nsBXMlK56+2M/SwPhfpIuRk0NIoIVJ
 oq3JqouRC8jewyhxquk/I0iCTUBT4lnnAmYQW0RAQqKj4S07iM0soC6xfNIvpi5GDg5hAW+Jl
 lelICaLgKrE7q8iICavgIdE7wltkGIJAQWJKQ/fgw3hFPCUuPp6DTPEVg+Jezdvg9m8AoISJ2
 c+YYEYLiFx8MULZoheRYlLHd8YIewKiVmz2pgmMPLPQtIyC0nLAkamVYwWSUWZ6RkluYmZObq
 GBga6hoZGuoaWprpGhqZ6iVW6iXqppbrlqcUluoZ6ieXFesWVuck5KXp5qSWbGIGBmFJw+PoO
 xluvP+gdYpTkYFIS5e1Xyk0U4kvKT6nMSCzOiC8qzUktPsQow8GhJMF7Oh8oJ1iUmp5akZaZA
 4wKmLQEB4+SCG9VIVCat7ggMbc4Mx0idYpRUUqcl7UAKCEAksgozYNrg0XiJUZZKWFeRgYGBi
 GegtSi3MwSVPlXjOIcjErCvNEg43ky80rgpr8CWswEtPiqcw7I4pJEhJRUA5O3Q8SND2eOTr7
 K/9xRbtrd6XcPVAT/mVw8f0O3n+fysHdTuILk1z1fpqsq7Niqs7xQZq15VftXk/e63/7dX5bR
 WnXuyNfQdqa/f86ohhznTb9+qjvelJch3TJUPilFjq1o29YPGz8+q7AU3zN1ye9g/asaAXvyS
 g7NYr4rHLk2kfsPw76r59OPhV95ITSLSStyJfvyM347TjTyvlpz613/+0XOp3l56hb3LeURK2
 zl2rOE5wiDKsfPopCg0j5hyw/aFTZiBxxuHk0x2bqFx+Pja8m3TWv+b93+KE6BJbY3W3Wn0Y4
 7y+7N1V7j8iXi4Zva4o4XngJNaUdeb4yTsq7eIi6x8FRMTrDG8vla/6SUWIozEg21mIuKEwFf
 aiADPwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-23.tower-265.messagelabs.com!1634562603!303855!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20577 invoked from network); 18 Oct 2021 13:10:04 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-23.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:10:04 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19ID9vJ1017346
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:10:03 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:10:01 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:09:44 +0800
Message-ID: <1634562591-5830-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 04/11] syscalls/quotactl[3, 5,
 7]: Add docparse formatting
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl03.c | 13 ++++++-------
 testcases/kernel/syscalls/quotactl/quotactl05.c | 13 +++++++++++--
 testcases/kernel/syscalls/quotactl/quotactl07.c |  4 ++++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 3ec931727..9711b7f07 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -4,10 +4,9 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Test Name: quotactl03
+/*\
+ * [Description]
  *
- * Description:
  * quotactl(2) with XGETNEXTQUOTA looks for the next active quota for an user
  * equal or higher to a given ID, in this test the ID is specified to a value
  * close to UINT_MAX(max value of unsigned int). When reaching the upper limit
@@ -16,11 +15,11 @@
  *
  * This kernel bug of xfs has been fixed in:
  *
- * commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
- * Author: Eric Sandeen <sandeen@redhat.com>
- * Date:   Tue Jan 17 11:43:38 2017 -0800
+ *  commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
+ *  Author: Eric Sandeen <sandeen@redhat.com>
+ *  Date:   Tue Jan 17 11:43:38 2017 -0800
  *
- *     xfs: don't wrap ID in xfs_dq_get_next_id
+ *  xfs: don't wrap ID in xfs_dq_get_next_id
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index e811e47a4..fbc7f5924 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -2,19 +2,28 @@
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This testcase checks basic flags of quotactl(2) for project on an XFS filesystem:
  *
- * This testcase checks basic flags of quotactl(2) for project on an XFS file
- * system:
  * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
  *    for project.
+ *
  * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
  *    for project.
+ *
  * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
  *    limits for project.
+ *
  * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
  *    quota limits Cgreater than or equal to ID for project.
+ *
  * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
  *    for project.
+ *
  * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
  *    for project.
  */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index db477589b..a55416f0e 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -2,6 +2,10 @@
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
  * This is a regresstion test for kernel commit 3dd4d40b4208
  * ("xfs: Sanity check flags of Q_XQUOTARM call").
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
