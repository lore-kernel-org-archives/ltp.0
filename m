Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31455C4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 09:19:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC823CAEA3
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 11:19:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BAFC3CAE90
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 11:19:07 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0816601231
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 11:19:06 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MnRpJ5wQ0zpVZF
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 17:15:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 17:19:03 +0800
To: <ltp@lists.linux.it>
Date: Wed, 12 Oct 2022 17:15:26 +0800
Message-ID: <20221012091526.35373-3-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221012091526.35373-1-zhaogongyi@huawei.com>
References: <20221012091526.35373-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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

Add setting of  needs_root, otherwise run the test without root
will fail and report EACCESS or EPERM.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/bind/bind06.c                       | 1 +
 testcases/kernel/syscalls/cma/process_vm_readv02.c            | 1 +
 testcases/kernel/syscalls/cma/process_vm_readv03.c            | 1 +
 testcases/kernel/syscalls/cma/process_vm_writev02.c           | 1 +
 testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
 testcases/kernel/syscalls/ipc/msgget/msgget03.c               | 1 +
 testcases/kernel/syscalls/preadv/preadv03.c                   | 1 +
 testcases/kernel/syscalls/pwritev/pwritev03.c                 | 1 +
 testcases/kernel/syscalls/sendto/sendto03.c                   | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt05.c           | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt06.c           | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt07.c           | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt08.c           | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt09.c           | 1 +
 testcases/kernel/syscalls/swapon/swapon01.c                   | 1 +
 15 files changed, 15 insertions(+)

diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 618cfce46..3b6e1c99e 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -100,6 +100,7 @@ static void run(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.max_runtime = 300,
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index 2bd66a49f..97a1595e3 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -116,6 +116,7 @@ static void run(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 4caafe867..e2fc84e06 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -189,6 +189,7 @@ static void run(unsigned int i)

 static struct tst_test test = {
 	.test = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 991110d24..794b9d04f 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -116,6 +116,7 @@ static void run(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index bbcb0ca3b..edcd5c368 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -225,6 +225,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.setup = setup,
+	.needs_root = 1,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 2257ae0f9..d3e4bbc59 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -72,6 +72,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.needs_tmpdir = 1,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_msgget,
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 00b25c549..7b69c77f9 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -128,6 +128,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_direct_preadv,
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 91a5e3c54..ded3c9b7a 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -127,6 +127,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_direct_pwritev,
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 5d2c1e112..49dded5bb 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -208,6 +208,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.test = run,
+	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 651583fb6..cfff4b970 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -93,6 +93,7 @@ static void run(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 9c818646b..7daf293b1 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -120,6 +120,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.max_runtime = 270,
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 616159a90..417fcd077 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -134,6 +134,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.max_runtime = 150,
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 563444635..ce9409521 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -144,6 +144,7 @@ void run(void)

 static struct tst_test test = {
 	.setup = setup,
+	.needs_root = 1,
 	.test_all = run,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 98f7fd00e..08d07dd44 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -115,6 +115,7 @@ static void cleanup(void)

 static struct tst_test test = {
 	.test_all = run,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index c334ae246..98dc92079 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -41,6 +41,7 @@ static void setup(void)

 static struct tst_test test = {
 	.needs_tmpdir = 1,
+	.needs_root = 1,
 	.test_all = verify_swapon,
 	.setup = setup
 };
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
