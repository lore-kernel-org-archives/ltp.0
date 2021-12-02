Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF7FC433F5
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 01:59:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 281CB3C8FF7
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 02:59:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABC093C6F5D
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 02:59:09 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FF1E6010DD
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 02:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638410347; i=@fujitsu.com;
 bh=DTeuxx9Vum+uUhWN48dyFCcIXm7kW1Hga1DcE/7l2Ds=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=m3f5Yac5/442PXfwZv2xIcTx9dwDi/RgQwvFJ8YaJQdWjRmdQa5WrPccd8FwP8k8c
 pBKeoA1vooUAg/uKdOjHoek9XHuOmp7W1OKJb+2jgE07EiLpvy7v5m1Bv36p7RDa7C
 irdwDwMCDD4WJoLHd+oNzT/YMcTSxsImSctr32V7J7drhSQvwpv0DEagQiRv4J3N4W
 A2h44PHmeJORpD2E1KXa+41BdFd3pAx9RjHZtRDEjE1Q9aMiix2r5i3hxGIAQCBa94
 ZFbYJk9G2qE31gEuTH0UxqecuhXLUFy88eK7WeKqRNC/0IbrYgWjqXSnXMaWhNsBU+
 OT/tFZgFPbiug==
Received: from [100.113.7.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 2C/67-25178-A6828A16;
 Thu, 02 Dec 2021 01:59:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8ORqJulsSL
 RoPmdiMWK7zsYHRg99v1exxrAGMWamZeUX5HAmnH6wRu2ghMsFV/edjI1MP5i7mLk5BASOMso
 cfSRbhcjF5C9k0ni5rO/jBDObkaJFwe/soBUsQloSjzrXADWISIgIdHR8JYdxGYWUJdYPukXE
 4gtLOAt0dY8BayeRUBFYl/vJaAaDg5eAQ+Jn6fKQcISAgoSUx6+BxvDKeAp8ejRV3aIIzwkfh
 yaxgpi8woISpyc+YQFYryExMEXL5ghehUlLnV8Y4SwKyRmzWpjgrDVJK6e28Q8gVFwFpL2WUj
 aFzAyrWK0TCrKTM8oyU3MzNE1NDDQNTQ01jXRNTQ20Eus0k3SSy3VTU7NKylKBMrqJZYX6xVX
 5ibnpOjlpZZsYgQGcEohS9MOxt+vPugdYpTkYFIS5X3FsiJRiC8pP6UyI7E4I76oNCe1+BCjD
 AeHkgSvvxpQTrAoNT21Ii0zBxhNMGkJDh4lEd4+VaA0b3FBYm5xZjpE6hSjopQ4r5o6UEIAJJ
 FRmgfXBovgS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEea1ApvBk5pXATX8FtJgJaPHhWct
 BFpckIqSkGpiS5/qET78dqsodn5uiqB3h8P/wu3MqeySDJ7m/PbFMjDP+vti0uFlLZhc/aHA4
 5fbZ+b2YqLDQdSZpRcXJvp6KGZvlMmf95vzwbj7LIoXZj34+Ygt22xZzYedGH4/pD8oTpyxr5
 uC/rbN+p/mCiQoZETf0D4dFLfmX41VywTbcfrf0LQ/z9vupvktOiMjs9565vl7rqM87b54fN2
 e1xAurhttF55cpqwh/7y3q/ZbfuMWB92dDxTOus++tD7nbNZ+/e6yVSSuz415uXqfU1s8/1i/
 OND+RcMtgpvRroVyJfT0Ndy4+q2b143ArOuIon749t0pt3b41ty236tdnMn+Y7nfy5oYPF5bN
 eyvBs0eJpTgj0VCLuag4EQCyS9jKWwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-245.messagelabs.com!1638410346!289597!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22060 invoked from network); 2 Dec 2021 01:59:06 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 2 Dec 2021 01:59:06 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id D6F9A1009EE
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 01:59:05 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id CBF1510025B
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 01:59:05 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 2 Dec 2021 01:58:47 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 2 Dec 2021 09:58:54 +0800
Message-ID: <1638410334-2279-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638410334-2279-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1638410334-2279-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED 2/2] syscalls/shmctl: Remove useless ltpipc in
 Makefile
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
 testcases/kernel/syscalls/ipc/shmctl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 06d72d968..f79ffa6dc 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc ltpnewipc
+LTPLIBS = ltpnewipc
 
 shmctl05: CFLAGS += -pthread
 shmctl05: LDLIBS += -lrt
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
