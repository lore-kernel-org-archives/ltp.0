Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E203AC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:20:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D2613C93F2
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 08:20:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66D4F3C2465
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 08:20:32 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7302B140004F
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 08:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641885630; i=@fujitsu.com;
 bh=RPyO7FQRSOJif1iXrFxCeD8Rp7m+hEewt4FS7YabuoI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=CoEKq72YtWT9WJ41g/cvtsnNxfzoanIT5rGVIBApOqpQK6L9p0Q9/x+Ky6p+1lzRD
 ZK5FV8GSY62GE14tRBvP5zJ8EWntk0/Euo//8nubxl9r3A06+fK+DWnFVsGrI0zAJl
 9y+mFsU7jLOGTQIVMsCqzGf8767pLoa3Mtne8LTo8nwq2kHPdTth+afA0//mr9AxKG
 Wym6aEkPU0L9uDKFSMwPEK6GB8TyP2HLOYLrLGw3K6MvFeP/oi6x1XhdHnuyBs2Io6
 Vk9D4w6KxRYddFK6QUwgiXXc6tcQ29PhfgGLa6D6Hgyx8hdmTm6xNcX7nfM+gNQc9z
 KhasndqjfvkWA==
Received: from [100.115.1.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 58/C9-10124-EBF2DD16;
 Tue, 11 Jan 2022 07:20:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8MxSXef/t1
 Eg65PTBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8arSZvZClYzV0zdPouxgfETUxcjF4eQwFlG
 iT/r9rFAODuZJN59f8kM4exhlNi8egF7FyMnB5uApsSzzgXMILaIgIRER8NbsDizgLrE8km/m
 EBsYQFbiRePfoLVsAioSky9d4oFxOYV8JDY0gQxR0JAQWLKw/fMEHFBiZMzn7BAzJGQOPjiBT
 NEjaLEpY5vjBB2hcSsWW1MELaaxNVzm5gnMPLPQtI+C0n7AkamVYxWSUWZ6RkluYmZObqGBga
 6hoamukDS1EQvsUo3US+1VLc8tbhE11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMwLFOKGWbtYJzV
 91PvEKMkB5OSKO9GrbuJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4a3WBcoJFqempFWmZOcAYg
 UlLcPAoifAa6wGleYsLEnOLM9MhUqcYFaXEeSVBEgIgiYzSPLg2WFxeYpSVEuZlZGBgEOIpSC
 3KzSxBlX/FKM7BqCTMOxFkCk9mXgnc9FdAi5mAFidz3AZZXJKIkJJqYIrQKS5QiXvAvm1qpsy
 /CdILPk1bWXOXuWPyFNez3nzFR8O81DvOLd4zwyna6Q6H6fn04xvYOG2Xf3qhFe14efHW/lOZ
 2jL1D8orbi1z+bGK3ayuToDvpqaOzbn7nu5m4oF/7++wmJ+zfVPKZZWOvc8/idi0fLE5s26Lt
 1vI6jU3b2801N+9P2nKqdz1KfcrnCM3m25bfWMa20/Ve7c6g62zT0bMjKtM4Uydc3t9/YM/S7
 OCm/c/Y5rl0yzbLXFHai1/8awik+jyRk7Ffbu2dhR4HuHQk1BYpLUiO2sKZ0Wd29P0JYwrz+1
 XaVx/arPO4xymiuVM9VcL3grPkC8pi3jtE3LXo3jFi05z63x3dyWW4oxEQy3mouJEAJFDU3BG
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-587.messagelabs.com!1641885629!67054!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24591 invoked from network); 11 Jan 2022 07:20:30 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-6.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 07:20:30 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 95C4E10044C
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:20:29 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 88DE2100353
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:20:29 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 07:20:07 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 15:20:46 +0800
Message-ID: <1641885646-3339-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] runtest/syscalls: Add missing fanotify22
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
 runtest/syscalls | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fbfea14cd..a0ca84b36 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -607,6 +607,7 @@ fanotify18 fanotify18
 fanotify19 fanotify19
 fanotify20 fanotify20
 fanotify21 fanotify21
+fanotify22 fanotify22
 
 ioperm01 ioperm01
 ioperm02 ioperm02
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
