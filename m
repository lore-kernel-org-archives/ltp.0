Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11829C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 01:47:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D01F3CAFCC
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 03:47:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EB503C9179
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:11 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93FEA600685
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:08 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKXN1RdczpWhL
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:43:48 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:47:04 +0800
To: <ltp@lists.linux.it>
Date: Mon, 17 Oct 2022 09:43:28 +0800
Message-ID: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] signal:Rewrite using new LTP API
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
From: Luo xiaoyu via ltp <ltp@lists.linux.it>
Reply-To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rewrite the first five signal cases.

Luo xiaoyu (5):
  signal01.c: Rewrite using new LTP API
  signal02.c: Rewrite using new LTP API
  signal03.c: Rewrite using new LTP API
  signal04.c: Rewrite using new LTP API
  signal05.c: Rewrite using new LTP API

 testcases/kernel/syscalls/signal/signal01.c | 197 +++++---------------
 testcases/kernel/syscalls/signal/signal02.c | 144 ++------------
 testcases/kernel/syscalls/signal/signal03.c | 161 ++--------------
 testcases/kernel/syscalls/signal/signal04.c | 179 +++---------------
 testcases/kernel/syscalls/signal/signal05.c | 159 ++--------------
 5 files changed, 121 insertions(+), 719 deletions(-)

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
