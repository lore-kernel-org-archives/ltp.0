Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCEDC433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:51:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B3A73CAED6
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:51:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CD983CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:09 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BE9D10009A3
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:07 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mp9m30x8Vz1P79R
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 21:46:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:51:02 +0800
To: <ltp@lists.linux.it>
Date: Thu, 13 Oct 2022 21:47:24 +0800
Message-ID: <20221013134728.49609-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013134728.49609-1-zhaogongyi@huawei.com>
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] new test for madvise(MADV_DONTNEED/MADV_REMOVE)
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

1. Check that madvise(2) MADV_DONTNEED operation applied to Huge TLB
   pages successfully after kernel version 5.18, and will result in
   zero-fill-on-demand pages for anonymous private mappings
2. Check that madvise(2) MADV_DONTNEED applied to shared mappings will
   lead to the resident set size(RSS) of the calling process reduced
   immediately
3. Check that after a successful madvise(2) MADV_REMOVE operation,
   subsequent accesses in the specified address range will see bytes
   containing zero
4. Check that in madvise(2) MADV_REMOVE operation, the specified address
   range must be mapped shared and writable and this flag cannot be
   applied to locked pages

Changes in v4:
  - Modify madvise04.c and madvise11.c according to suggestions
  - Add madvise12.c and madvise13.c for madvise(MADV_REMOVE) to this
    patch set since the dependencies of the patches

Changes in v3:
  - Modify madvise04.c according to suggestions

Changes in v2:
  - Modify the test adn split the test into two as suggestion
  - Add a new test for madvise

Zhao Gongyi (4):
  syscalls/madvise04: new test for madvise(MADV_DONTNEED)
  syscalls/madvise11: new test for madvise(MADV_DONTNEED)
  syscalls/madvise12: new test for madvise(MADV_REMOVE)
  syscalls/madvise13: new test for madvise(MADV_REMOVE)

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/madvise/.gitignore  |  4 +
 testcases/kernel/syscalls/madvise/madvise04.c | 62 ++++++++++++++
 testcases/kernel/syscalls/madvise/madvise11.c | 82 ++++++++++++++++++
 testcases/kernel/syscalls/madvise/madvise12.c | 85 +++++++++++++++++++
 testcases/kernel/syscalls/madvise/madvise13.c | 80 +++++++++++++++++
 6 files changed, 317 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise04.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise12.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
