Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FBAC433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 07:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3D503C7ACE
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 08:44:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1B0D3C585E
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 08:43:40 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BCC6201016
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 08:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639035819; i=@fujitsu.com;
 bh=2gctoFKzB94FexQBsIBitbGhh2ZMkLG7UDqJaNkwpGE=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=CmraRW1dIbPwahx9N8xw0OnQH2OgVsoUKlINhX0fIcn5L03mclfAhJAWcpOYWDgAy
 XskFIQ2k7cU0QoIzJ2s5PXx9ynLP1RnQncyS+M3LlQJ6c9Rw3lBnJtVZ8BoHfB8yrh
 ELk14VsPtQVHpLvAcSYsqnW/vLrpZZyvHi61Li4p15PBrTOqtrpCe4Iswwg78Xx/pS
 DDOOk73/zcS79mYvfU9qyL70Uq+7O+8utT0gR4P/seihtsLpH2xG49m1kcyBgK0dH6
 tH7/37d872/eV1St912MTCclx0c2xr0/fO+/+woH/NIUIOpOOHRcmshwgs2Ie0N+3p
 tIhLOsA+SLwIw==
Received: from [100.115.67.185] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-central-1.aws.ess.symcld.net id 4D/91-11258-BA3B1B16;
 Thu, 09 Dec 2021 07:43:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRWlGSWpSXmKPExsViZ8MxSXf15o2
 JBtfXs1us+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBm/99xiLDjIUbHjkHkD4zT2LkYuDiGBs4wS
 GxctYYRwdjJJPF85gQXC2c0oseH/GaAyTg42AU2JZ50LmEFsEQEJiY6Gt2BxZgF1ieWTfjGB2
 MICrhLPP9xmAbFZBFQk5i16wNbFyMHBK+AhceN/EkhYQkBBYsrD92BjeAUEJU7OfMICMUZC4u
 CLF8wQNYoSlzq+MULYFRKzZrUxQdhqElfPbWKewMg/C0n7LCTtCxiZVjHaJRVlpmeU5CZm5ug
 aGhjoGhqa6pqZ6BqZmOolVukm6qWW6ian5pUUJQKl9RLLi/VSi4v1iitzk3NS9PJSSzYxAkMz
 pdjh6w7G430/9Q4xSnIwKYny3li8MVGILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG//RqCcYFFqe
 mpFWmYOME5g0hIcPEoivJKbgNK8xQWJucWZ6RCpU4yKUuK8LiAJAZBERmkeXBssNi8xykoJ8z
 IyMDAI8RSkFuVmlqDKv2IU52BUEuZ1AJnCk5lXAjf9FdBiJqDFzi3rQRaXJCKkpBqYeER3+yR
 eeZxUnG8Rw92sEX+iwvnKoa+JYt90JK6fqbAImXrewa7xU8U3rfeGrz7fLWksTWvPuvjhslrf
 wpQ/6a/P3OKT/F3rF/7GtJmxxWvJ3ZXz8jnCYrzuOd5/UzOLo0+RfbHstcIUoVXzv96OKQiMi
 poktiv9P8Pq0CXPnG/Lf9i/6Ta77reUoysunKnY2eyiICpU+vqsoWh39+63ZnoLp7nJl39nXa
 w0859q26P+H+HHpP9Mu6Up/3zBQrcF7MW6KfNLZYSPlTX93LGsVfTvzx4hycqmrq+MImoW53S
 VPvM0TneZXcjOeUfszQeensebagTUXszWdUs3ixO+NtcjhaX79ZxO+cM/lU8qsRRnJBpqMRcV
 JwIASvsdvkgDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-532.messagelabs.com!1639035818!74014!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23607 invoked from network); 9 Dec 2021 07:43:39 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-22.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Dec 2021 07:43:39 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 395F2100353
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 07:43:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 2BE0810033A
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 07:43:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 9 Dec 2021 07:43:15 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 9 Dec 2021 15:43:41 +0800
Message-ID: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] swapping01: skip test if zram-swap is being used
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

For the swapping test we attempt to allocate 130% of the available RAM and
we make sure that the overflow would fit the swap, but as long as swap is
backed by RAM this obviously false. So skip it if zram-swap is being used.

Fixes: #888
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 392b79d65..29c1e0443 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -67,6 +67,11 @@ static void test_swapping(void)
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
+	int ret;
+
+	ret = tst_system("zramctl | grep SWAP");
+	if (!ret)
+		tst_brk(TCONF, "zram-swap is being used!");
 
 	init_meminfo();
 
@@ -155,4 +160,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.test_all = test_swapping,
+	.needs_cmds = (const char *[]) {
+		"zramctl",
+		NULL
+	}
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
