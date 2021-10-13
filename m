Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899D3C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 01:14:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C1160E94
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 01:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1C1160E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37AC93C12F6
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 03:14:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B2813C0EB8
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 03:13:59 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DFCFC1A00612
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 03:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634087636; i=@fujitsu.com;
 bh=oh1eeXragSUd5fA2skwHz1J/nzDQbXVHKHMhZj2yE78=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ybv+VYmF+mv6Fteit1QXg7/mLJqU/6oHjpSOiYk0h0akCM7/MR33x80EJ7apTkwYX
 YtJhq7u68fcmOb6lRP6CSn5FfdzZPcRaqB5IiMKJLA8oLTgcWiIqSpNheo6DURJkKj
 aNywE9AbjEsoGYVm0aSF8S8PWtH56Zc5rRnTKSY4HoBs6tM2xsFPweXObkSAKsFaqH
 itQN20Z1W4nJTVeFYdJw4DNvriea0CMcjb+PaBnj4WJMFqGRbefrerXDWUWidj33za
 869BgpeyPbyqfShJiqJ2lmYSuSUNyni19PeZ1OSgM8SuaNijRhyEzEWKcNrjUbS8vk
 Auki5GDMj51mA==
Received: from [100.113.6.246] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 1C/A0-01506-4D236616;
 Wed, 13 Oct 2021 01:13:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRWlGSWpSXmKPExsViZ8ORqHvZKC3
 RYOUJK4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNeNo60LmglfMFd8/72RvYPzL1MXIxSEkcJZR
 4lf7KVYIZyeTxM2Zv9kgnD2MEvM+XGXvYuTkYBPQlHjWuYAZxBYRkJDoaHgLFmcWUJdYPukX0
 CgODmEBS4nr8y1AwiwCqhKfVn9kBwnzCnhIrH6iDRKWEFCQmPLwPdgUXgFBiZMzn7BATJGQOP
 jiBTNEjaLEpY5vjBB2hcSsWW1MELaaxNVzm5gnMPLPQtI+C0n7AkamVYyWSUWZ6RkluYmZObq
 GBga6hobGuia6hsYGeolVukl6qaW6yal5JUWJQFm9xPJiveLK3OScFL281JJNjMCATClkadrB
 +PvVB71DjJIcTEqivHYLUxOF+JLyUyozEosz4otKc1KLDzHKcHAoSfCyGKYlCgkWpaanVqRl5
 gCjAyYtwcGjJMI7FyTNW1yQmFucmQ6ROsWoKCXOKwWSEABJZJTmwbXBIvISo6yUMC8jAwODEE
 9BalFuZgmq/CtGcQ5GJWFeTi2gKTyZeSVw018BLWYCWhwYlQKyuCQRISXVwCQcFPvz+qd1E+w
 //nJ5JTHj5LWFLBc2ym86prhve6rEC67Zm96Z72Gwub4qya3mwuGyPosrO6XORtol3Xf8bXw9
 6rzoqciAR/tP7LitHN3+5eyvzfu7NM/eZ3h2PKC4UtPnmdZU9bYbN591ZJqneW37NfW2mkTHu
 rPSyzT7Zyv7fN3BqPvobdQJpnqxcinBr3/NFIJ766t3MawxDWu+c9s16Mm0vKVP5VXqSx0VTj
 +dEFJu0VWTobfjPnu6gK/6Ao6wJ2mWWs8Nm07tL9JRPX9Js0k9d93s7PJNs/+KFpRkPN1z+1q
 Ek54C56a1USb3eWTCSnZX7M+aH8VnsmmFz/N57pNkbs4Wu2HkK/04wV2JpTgj0VCLuag4EQDf
 hKPeQwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-238.messagelabs.com!1634087635!945629!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5934 invoked from network); 13 Oct 2021 01:13:55 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-19.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Oct 2021 01:13:55 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6A4361009CF
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 02:13:55 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 5DC34100250
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 02:13:55 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 13 Oct 2021 02:13:48 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 13 Oct 2021 09:14:08 +0800
Message-ID: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] kernel/Makefile: Add irq to Makefile
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

Fixes: f8fb073708 ("kernel/irq: Add irqbalance01")
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index f3a608f38..4604f1f38 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -28,6 +28,7 @@ SUBDIRS			+= connectors \
 			   input \
 			   io \
 			   ipc \
+			   irq \
 			   logging \
 			   mem \
 			   numa \
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
