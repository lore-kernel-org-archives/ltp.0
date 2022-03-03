Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26594C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 08:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B57DB3CA343
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 09:54:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3CE3C9FE6
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 09:54:17 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EAE03140110C
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 09:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1646297656; i=@fujitsu.com;
 bh=Uuv9+JkvF05MjsJOCRB2Z54jo+CQ5IhBmc835Y6Y39Q=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=KqdroAXoG5LUmWObPX0Cx0KT/9xMfksEUCt0mDidaWTHQOeGVMdvkdH/65n4pUPmD
 sdIjTPGf5HOGQpChe//6SG7rQ2co33ddvVRyg6k53yPv/cH9fVNRyFdx06rGQJZZ6Q
 Smz9HMPqyESyk81xe1JRlYxCI9miGlrxyaFcUT184bioBX8XoS7pvTNqDtqo7iGEEu
 cy2D/Gz75R2DEdKpYJgBxPHrfQWMdk5mIvsGcYs6Ufkjvjm6zrr/Tlkct0kgNlmWIC
 J5NhsHvg0J2d8tFw34KOMMS1+g9627fsMh0NrCrK04UIqjIlREsAQQmtLL6L7MinAs
 EBaUQqgcDWEJw==
Received: from [100.115.1.77] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id D1/17-21232-73280226;
 Thu, 03 Mar 2022 08:54:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8ORqGvepJB
 k0LpKw2LF9x2MDowe+36vYw1gjGLNzEvKr0hgzXhz8SVLwSSuiu0fZjA3MF7n6GLk4hASOMso
 8evFBhYIZyeTxOS/h9kgnN2MEof3X2PuYuTkYBPQlHjWuQDMFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFrCV+HnwKlANBweLgIrExTWpIGFeAQ+JGTMPsoLYEgIKElMevmeGiAtKnJz5hAVijITEwR
 cvmCFqFCUudXxjhLArJGbNamOCsNUkrp7bxDyBkX8WkvZZSNoXMDKtYrRKKspMzyjJTczM0TU
 0MNA1NDTVNdM1NLPUS6zSTdRLLdUtTy0u0TXUSywv1kstLtYrrsxNzknRy0st2cQIDMqUYraV
 OxhX9v3UO8QoycGkJMo7J0EhSYgvKT+lMiOxOCO+qDQntfgQowwHh5IE79saoJxgUWp6akVaZ
 g4wQmDSEhw8SiK8b0uA0rzFBYm5xZnpEKlTjMYcV69c2cvMcQNECrHk5eelSonzvm0AKhUAKc
 0ozYMbBIvcS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeZ1ApvBk5pXA7XsFdAoT0ClbPeR
 ATilJREhJNTC1dDHFvw1Oev8lb+uyn08Kl8/Rf3kwJ0Lpx4UW7k8Pv+u01O6/4TMhoubTs3Uu
 Nnq3oxL6Z927wWyxSthrX9uqmy9WbOVdIscZ59G1TE/HqGLahBezK24/3rln6eanD9OmbTk+R
 6Tk89aqtycCt13t/m/MztQerSD/7/2TK6p7rRnjNm9SCVPj+jrp6dta19LbXt/3+zafmF7wvq
 +3LPwRi8SvpVvnF9taPK2ta0zT7K7rdHEL5nT6GOX2/9b14J9nRP+Wyduv3KUzR5ZVcUH+jA1
 Twr9XHli8/POt+o8eFYVLf/6+KHOkovrdd/6zRfxvdp5bL5dSuUAwR/Xp5QPHvq7ov2jfYvBM
 54jxk/5JSUosxRmJhlrMRcWJAI3mlG1XAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1646297655!86420!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19170 invoked from network); 3 Mar 2022 08:54:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Mar 2022 08:54:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 16BC11001A2
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 08:54:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0A3D810019B
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 08:54:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Thu, 3 Mar 2022 08:53:57 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 3 Mar 2022 16:54:38 +0800
Message-ID: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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

On centos7.9ga, I still hit another crash problem because of use-after-free in
prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
case will crash after we print TPASS info.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt09.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 2fc66ebbc..62c6dea07 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -19,6 +19,17 @@
  *
  *  net/packet: rx_owner_map depends on pg_vec
  *
+ * It also triggers another use-after-free problem in
+ * prb_retire_rx_blk_timer_expired.
+ *
+ * Kernel crash fixed in:
+ *
+ * commit c800aaf8d869f2b9b47b10c5c312fe19f0a94042
+ * Author: WANG Cong <xiyou.wangcong@gmail.com>
+ * Date:   Mon Jul 24 10:07:32 2017 -0700
+ *
+ * packet: fix use-after-free in prb_retire_rx_blk_timer_expired()
+ *
  */
 
 #define _GNU_SOURCE
@@ -110,6 +121,7 @@ static struct tst_test test = {
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
+		{"linux-git", "c800aaf8d869"},
 		{"linux-git", "ec6af094ea28"},
 		{"CVE", "2021-22600"},
 		{}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
