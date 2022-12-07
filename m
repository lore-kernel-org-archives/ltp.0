Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E827C352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 08:40:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556AA3CC0FB
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 09:40:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C94753CAEDD
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 09:40:15 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BF6E2001DA
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 09:40:12 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRrLF2kP7zRpdL
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 16:39:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 16:40:07 +0800
To: <ltp@lists.linux.it>
Date: Wed, 7 Dec 2022 16:37:09 +0800
Message-ID: <20221207083709.164984-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_lib.sh: Update 'PAGESIZES' for 6.1 kernel
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

Post 6.1 kernel updates stat in batch (> 64 pages) every time
since commit 1813e51eece0ad6f4aacaeb738e7cced46feb470.

Update 'PAGESIZES' for 6.1 kernel, otherwise the testcase
memcg_max_usage_in_bytes_test.sh will fail and report:

memcg_max_usage_in_bytes_test 1 TINFO: timeout per run is 0h 5m 0s
memcg_max_usage_in_bytes_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_max_usage_in_bytes_test 1 TINFO: Test memory.max_usage_in_bytes
memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 17808
memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 17808
memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4456448, 4206592-4341760 expected
memcg_max_usage_in_bytes_test 2 TINFO: Test memory.memsw.max_usage_in_bytes
memcg_max_usage_in_bytes_test 2 TPASS: echo 8388608 > memory.limit_in_bytes passed as expected
memcg_max_usage_in_bytes_test 2 TPASS: echo 8388608 > memory.memsw.limit_in_bytes passed as expected
memcg_max_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 2 TINFO: Warming up pid: 17828
memcg_max_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 17828
memcg_max_usage_in_bytes_test 2 TFAIL: memory.memsw.max_usage_in_bytes is 4456448, 4206592-4341760 expected
memcg_max_usage_in_bytes_test 3 TINFO: Test reset memory.max_usage_in_bytes
memcg_max_usage_in_bytes_test 3 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 3 TINFO: Warming up pid: 17844
memcg_max_usage_in_bytes_test 3 TINFO: Process is still here after warm up: 17844
memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 4456448, 4206592-4341760 expected
memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 262144, 0-135168 expected
memcg_max_usage_in_bytes_test 4 TINFO: Test reset memory.memsw.max_usage_in_bytes
memcg_max_usage_in_bytes_test 4 TPASS: echo 8388608 > memory.limit_in_bytes passed as expected
memcg_max_usage_in_bytes_test 4 TPASS: echo 8388608 > memory.memsw.limit_in_bytes passed as expected
memcg_max_usage_in_bytes_test 4 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 4 TINFO: Warming up pid: 17863
memcg_max_usage_in_bytes_test 4 TINFO: Process is still here after warm up: 17863
memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 4456448, 4206592-4341760 expected
memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 262144, 0-135168 expected
memcg_max_usage_in_bytes_test 5 TINFO: SELinux enabled in enforcing mode, this may affect test results
memcg_max_usage_in_bytes_test 5 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
memcg_max_usage_in_bytes_test 5 TWARN: test interrupted
memcg_max_usage_in_bytes_test 5 TINFO: loaded SELinux profiles: kill

Summary:
passed   4
failed   6
broken   0
skipped  0
warnings 1

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index a89e24485..004946456 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -402,7 +402,12 @@ if [ $? -ne 0 ]; then
 fi

 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
-PAGESIZES=$(($PAGESIZE * 33))
+# Post 6.1 kernel updates stat in batch (> 64 pages) every time
+if tst_kvcmp -lt "6.1"; then
+	PAGESIZES=$(($PAGESIZE * 33))
+else
+	PAGESIZES=$(($PAGESIZE * 65))
+fi

 # On recent Linux kernels (at least v5.4) updating stats happens in batches
 # (PAGESIZES) and also might depend on workload and number of CPUs.  The kernel
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
