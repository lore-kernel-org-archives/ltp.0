Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627EEC761A6
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 10:31:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 007933CCC84
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 12:31:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F08013CA2FE
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:30:52 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ACC882003A7
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1679913050; i=@fujitsu.com;
 bh=ioqG+G0kNxqYhbmcFuhnhd3HjvoungDXfwgdLkxAvQc=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ucAl1jyH/Rw6BN+LFDxyjF134LPVXx560WDuYelaQDXu3Z4Ojm0h8KDbwpRbcJ+l0
 tg9Dnf1zm2wplHre4AEkoV5cnlWGNrprZF0NXC/chc638qmhLpANcWb1mc6p+ygrCC
 dJ6QEzNnsLHq4Ibo5fy8ZdoRfkEaZoJmVJvTalg7E+d4gIrpq55d4Vt9r6V3Hr+b30
 GeqBxxdz1T+RKVxBbjk3Zlph0e/OexYlrUAeyVAyvzo6ifuNCQEtzNlH0fGYZxDH8J
 o5X5uAhWvm9ueLMd1+gDX8xe45RwqwJLGi0tnU5AYsfAKIJBxNvv0ayvPBSgvH+gP8
 RIvecj7Ncy5JQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRWlGSWpSXmKPExsViZ8MxSTeqQDH
 FoGemsMWK7zsYHRg99v1exxrAGMWamZeUX5HAmvHix3mmgjPCFY079rA3MB4W7GLk4hASOMso
 cf7oMzYI5wCTxM9TDawQzl5GiTmzNjB1MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6B
 VYjLGAusWr5elYQm0VAVWLZ3c1gNq+Ah8SazlUsILaEgILElIfvmSHighInZz5hgZgjIXHwxQ
 tmiBolibbWK6wQdoVE4/RDTBC2msTVc5uYJzDyz0LSPgtJ+wJGplWMZsWpRWWpRbpmeklFmek
 ZJbmJmTl6iVW6iXqppbp5+UUlGbqGeonlxXqpxcV6xZW5yTkpenmpJZsYgeGYUpzweAfjvL6/
 eocYJTmYlER5+zkVU4T4kvJTKjMSizPii0pzUosPMcpwcChJ8ErmAOUEi1LTUyvSMnOAsQGTl
 uDgURLhLU0DSvMWFyTmFmemQ6ROMepyLOy/updZiCUvPy9VSpzXLB+oSACkKKM0D24ELE4vMc
 pKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmjcoDmsKTmVcCt+kV0BFMQEd8K1AAOaIkESEl1cC
 UcfP6hyAv1zar8Hetn+24L796M6/ZVaay7PMecVPBps1XFLRT1V3mP5Tm0DhwbJLF84RNxmuL
 clWm/1HoMj04f1W94YNrC9ynKRSe2/iK0fXc1sXqwe7vyrZ7no8R6v9xOFhr3ZSn776o1jFsY
 Dti8vL6ncjFMpOXfD2x4r1nJxfnacdp8ZYTAksLGrwKjLdKntq8sUbkW7+yY8iSwOqFWfpKUS
 e/fN+3fnWgjqfNyry2GwYMiRbGlZyvXTYlivGLVJ3Y0rRCtftZ5l1j5+Dp71Mq9gu7FV3yerP
 euKDe4Eg306R3dZyCFzw4t/fFTCkPKtRv0//qoWlyJtbd0fIp/33OFzKbvVfMkdO4X6vEUpyR
 aKjFXFScCADMWXm5TgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-732.messagelabs.com!1679913049!247895!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14889 invoked from network); 27 Mar 2023 10:30:50 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-13.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Mar 2023 10:30:50 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A750C1000FE
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 11:30:49 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 9A0BF1000EE
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 11:30:49 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 27 Mar 2023 11:30:48 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 27 Mar 2023 18:30:40 +0800
Message-ID: <1679913040-4675-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RESEND PATCH] runtest/cve: sort by cve number
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
 runtest/cve | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index cdbb5bc5f..f9a449fe7 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -5,9 +5,9 @@ cve-2011-2496 vma03
 cve-2012-0957 uname04
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
+cve-2015-3290 cve-2015-3290
 cve-2015-7550 keyctl02
 cve-2016-4470 keyctl01.sh
-cve-2015-3290 cve-2015-3290
 cve-2016-4997 setsockopt03
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
@@ -19,6 +19,7 @@ cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2636 pty05
 cve-2017-2671 cve-2017-2671
+cve-2017-5754 meltdown
 cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
@@ -31,19 +32,18 @@ cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
 cve-2017-15649 fanout01
 cve-2017-15951 request_key03 -b cve-2017-15951
+cve-2017-16939 cve-2017-16939
+cve-2017-16995 bpf_prog03
+cve-2017-17052 cve-2017-17052
+cve-2017-17053 cve-2017-17053
 cve-2017-17712 sendmsg03
 cve-2017-17805 af_alg02
 cve-2017-17806 af_alg01
 cve-2017-17807 request_key04
-cve-2017-1000364 stack_clash
-cve-2017-5754 meltdown
-cve-2017-17052 cve-2017-17052
-cve-2017-16939 cve-2017-16939
-cve-2017-16995 bpf_prog03
-cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
 cve-2017-1000111 setsockopt07
 cve-2017-1000112 setsockopt05
+cve-2017-1000364 stack_clash
 cve-2017-1000380 snd_timer01
 cve-2017-1000405 thp04
 cve-2018-5803 sctp_big_chunk
@@ -51,15 +51,15 @@ cve-2018-7566 snd_seq01
 cve-2018-8897 ptrace09
 cve-2018-9568 connect02
 cve-2018-10124 kill13
-cve-2018-1000001 realpath01
-cve-2018-1000199 ptrace08
-cve-2018-1000204 ioctl_sg01
 cve-2018-12896 timer_settime03
 cve-2018-13405 creat09
 cve-2018-18445 bpf_prog04
 cve-2018-18559 bind06
 cve-2018-18955 userns08
 cve-2018-19854 crypto_user01
+cve-2018-1000001 realpath01
+cve-2018-1000199 ptrace08
+cve-2018-1000204 ioctl_sg01
 cve-2019-8912 af_alg07
 cve-2020-11494 pty04
 cve-2020-14386 sendto03
@@ -72,10 +72,10 @@ cve-2021-4034 execve06
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 cve-2021-22600 setsockopt09
+cve-2021-38604 mq_notify03
 cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
-cve-2021-38604 mq_notify03
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
-cve-2022-4378 cve-2022-4378
 cve-2022-0185 fsconfig03
+cve-2022-4378 cve-2022-4378
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
