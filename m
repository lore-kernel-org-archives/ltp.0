Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA12C4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 09:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB11A3CAEB8
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 11:19:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E413C075E
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 11:19:05 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6C891401108
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 11:19:03 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MnRpF3JWBzpVTF
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 17:15:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 17:19:00 +0800
To: <ltp@lists.linux.it>
Date: Wed, 12 Oct 2022 17:15:24 +0800
Message-ID: <20221012091526.35373-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Optimization reference to needs_root
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

1. Add checking of needs_root on the phase of do_setup.
2. Add setting of needs_root for tests that reference to /dev
   or /proc/.

Zhao Gongyi (2):
  lib: Add checking of needs_root
  needs_root: Add setting of needs_root

 lib/tst_test.c                                               | 5 +++++
 testcases/kernel/syscalls/bind/bind06.c                      | 1 +
 testcases/kernel/syscalls/cma/process_vm_readv02.c           | 1 +
 testcases/kernel/syscalls/cma/process_vm_readv03.c           | 1 +
 testcases/kernel/syscalls/cma/process_vm_writev02.c          | 1 +
 .../kernel/syscalls/copy_file_range/copy_file_range01.c      | 1 +
 testcases/kernel/syscalls/ipc/msgget/msgget03.c              | 1 +
 testcases/kernel/syscalls/preadv/preadv03.c                  | 1 +
 testcases/kernel/syscalls/pwritev/pwritev03.c                | 1 +
 testcases/kernel/syscalls/sendto/sendto03.c                  | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt05.c          | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt06.c          | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt07.c          | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt08.c          | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt09.c          | 1 +
 testcases/kernel/syscalls/swapon/swapon01.c                  | 1 +
 16 files changed, 20 insertions(+)

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
