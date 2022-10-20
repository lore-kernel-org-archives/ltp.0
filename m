Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714A4C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:01:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD8333CB163
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:01:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED4A43CA31F
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:01:21 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF5991A0113E
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:01:19 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtSQX0t0zzHv4n
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 21:01:08 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:01:15 +0800
To: <ltp@lists.linux.it>
Date: Thu, 20 Oct 2022 20:57:45 +0800
Message-ID: <20221020125747.231509-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] new test for nice()
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1. Verify that user of root can decrease the nice value of
   the process successfully by passing a lower increment
   value (< min. applicable limits) to nice() system call.
2. Verify that the errno is zero when callling of nice
   legitimately return -1.

Changes in v2:
  - Adapt the number of testcases
  - Modify the description of patch 2/2

Zhao Gongyi (2):
  syscalls/nice06: new test for nice()
  syscalls/nice07: new test for nice()

 runtest/syscalls                          |  2 +
 testcases/kernel/syscalls/nice/.gitignore |  2 +
 testcases/kernel/syscalls/nice/nice06.c   | 54 +++++++++++++++++++++++
 testcases/kernel/syscalls/nice/nice07.c   | 46 +++++++++++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 testcases/kernel/syscalls/nice/nice06.c
 create mode 100644 testcases/kernel/syscalls/nice/nice07.c

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
