Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE2C433F5
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 08:24:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CB561213
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 08:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18CB561213
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E99F3C8812
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 09:24:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF6D93C80BC
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 09:24:01 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7664600044
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 09:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637137440; i=@fujitsu.com;
 bh=vtTymRc2ixBDzPO4aosHcs2c1C5+9KKbRT+ItMV3JIA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=oDGxsJAiRTcxXzB5IzpY2rxvqG1tJnx869bFa8vfbrEOP5/vsLNhWXZP/e9w4Y0s1
 NF6R9I03AGhfHKpNPEcC0JeQmp+AUtWPgQiLIb0WAyJhyOibdhABq/xGwzE6v8s/6z
 StlexpfKmetDKg5y1WmUWcGYb6BW3+KTsqMtkA45crq9pwDls4GOKK8R0oBxs24zYs
 4UH+jqZTO3eZnANsAPDvsxhUvVab3SSPST6fJOX58Im2UBX9oOeBZxDabDGHbWOmeL
 trVx+RNbap2Esjf8EqvWD1mdKk5Zl/pZaibz9oH/JpvgRHcFQvgH4Bp9jzSlRC17j7
 6MZeXhwbybR9g==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-central-1.aws.symcld.net id A6/C8-30139-02CB4916;
 Wed, 17 Nov 2021 08:24:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRWlGSWpSXmKPExsViZ8MxRVd+z5R
 Egwt7TCxWfN/B6MDose/3OtYAxijWzLyk/IoE1ozNt26wFpxgr9h0ZA9bA+M+ti5GLg4hgSYm
 iWkblkM5exglXv2bxd7FyMnBJqAp8axzATOILSIgIdHR8BYsziygLrF80i+mLkYODmEBX4lfB
 1RAwiwCqhKP5x5iBLF5BTwlJv2ZyQJiSwgoSEx5+J4ZIi4ocXLmExaIMRISB1+8YIaoUZS41P
 GNEcKukJg1q41pAiPvLCQts5C0LGBkWsVomVSUmZ5RkpuYmaNraGCga2horGuua2RqpJdYpZu
 kl1qqm5yaV1KUCJTVSywv1iuuzE3OSdHLSy3ZxAgMsJRC9j87GK+//qB3iFGSg0lJlPdp75RE
 Ib6k/JTKjMTijPii0pzU4kOMMhwcShK8JTuAcoJFqempFWmZOcBgh0lLcPAoifBm7AJK8xYXJ
 OYWZ6ZDpE4xKkqJ8zKCJARAEhmleXBtsAi7xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYNw
 ZkO09mXgnc9FdAi5mAFstengyyuCQRISXVwHRlsof5vKMN1oUTRLNPqUnFKOlnqwftuyotev+
 q79Pyk8a+JpelandO35F0fb7lyxL5Wufg0y84H9y3qV8YWhOSs+aVygvLqYHJJwQ6/ySxfGV5
 pvwp4tVcgUQX9+6pU19y2v9h9hDb2yVeV/Br2Z0wbwWBzZvvS23X+y/i9Pn14hm3bj7QtA8/q
 cZ1coXq+Ten/+yKT6p25qp8l5PL/vqVWaF+S9du2VPGTN1Sz9m+Xvq/L+Rc16xzgREn9z/PPL
 DBd3Knp7u03tHt25cWxNy92p17qEg+fHmbY/PixYcOGTc+fJMcrzN7hp5L0X2R7f9i9n6RjKm
 WbWbYy3gtP7h08eZSi3XNITnsGgwHdiuxFGckGmoxFxUnAgB6ylFWKwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-245.messagelabs.com!1637137439!369458!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16657 invoked from network); 17 Nov 2021 08:23:59 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-22.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 17 Nov 2021 08:23:59 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1AH8Ns5R003993
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:23:59 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 17 Nov 2021 08:23:51 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 17 Nov 2021 16:24:29 +0800
Message-ID: <1637137469-13184-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/finit_module02: Add ETXTBSY error for
 read-write fd
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
 testcases/kernel/syscalls/finit_module/finit_module02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 47b5edbfb..b3437b5d0 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -72,6 +72,8 @@ static struct tcase tcases[] = {
 		NULL},
 	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, EBADF, 0,
 		NULL},
+	{"file-readwrite", &fd, "", O_RDWR | O_CLOEXEC, 0, 0, ETXTBSY, 0,
+		NULL},
 	{"directory", &fd_dir, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, 0, dir_setup},
 };
 
@@ -134,6 +136,7 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "032146cda855"},
+		{"linux-git", "39d637af5aa7"},
 		{}
 	},
 	.test = run,
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
