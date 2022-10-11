Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9894C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:19:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F14C83CAEB5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:19:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4EE3CAE72
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:19:47 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 204B41A00279
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:19:45 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mmvq64CxczHtsm
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 20:14:42 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 20:19:41 +0800
To: <ltp@lists.linux.it>
Date: Tue, 11 Oct 2022 20:16:04 +0800
Message-ID: <20221011121607.55575-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] new test for madvise(MADV_DONTNEED)
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

1. verify that after a successful MADV_DONTNEED operation, it will
   result in zero-fill-on-demand pages for anonymous private mappings.
2. Test cases for madvise(2) system call, verify that MADV_DONTNEED
   cannot be applied to Huge TLB pages.
3. Verify that when MADV_DONTNEED applied to shared mappings, it will
   lead to the resident set size(RSS) of the calling process reduced
   immediately.

Changes in v2:
  - Modify the test adn split the test into two as suggestion
  - Add a new test for madvise

Zhao Gongyi (3):
  syscalls/madvise03: new test for madvise(MADV_DONTNEED)
  syscalls/madvise04: new test for madvise(MADV_DONTNEED)
  syscalls/madvise11: new test for madvise(MADV_DONTNEED)

 runtest/syscalls                              |  3 +
 testcases/kernel/syscalls/madvise/.gitignore  |  3 +
 testcases/kernel/syscalls/madvise/madvise03.c | 69 ++++++++++++++++
 testcases/kernel/syscalls/madvise/madvise04.c | 48 ++++++++++++
 testcases/kernel/syscalls/madvise/madvise11.c | 78 +++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise03.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise04.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
