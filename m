Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFE4C83F01
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 06:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E27A3CC025
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 08:43:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1C273C62DB
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 08:43:01 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id EDB6660122B
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 08:42:57 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.176])
 by gateway (Coremail) with SMTP id _____8AxEvDw5O5k7gEdAA--.58476S3;
 Wed, 30 Aug 2023 14:42:56 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.180.13.176])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiPs5O5ksQZnAA--.12794S2; 
 Wed, 30 Aug 2023 14:42:56 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 30 Aug 2023 14:42:50 +0800
Message-Id: <20230830064250.31904-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8AxjiPs5O5ksQZnAA--.12794S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQATB2TuwbQAkgAFs9
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1Dtr4rJr4DCFWxWw13ZFc_yoW8Cr1UpF
 ySka9Fyrn5JFnxCa1xC3Z8Ar10va48XF4UWrZxCw1kZrnxAa15CF18Gr4rtFyjqryFgFy5
 Ka4rC3yDua4DJFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cpuset_memory_spread: set lowerlimit according to
 pagesize
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
Cc: ltp@lists.linux.it, Hongchen Zhang <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When I test the cpuset_memory_spread case,this case FAIL too often.
After dig into the code, I find out that the fowlloing things trigger
the FAIL:
1) random events,the probability is very small and can be ignored
2) get_meminfo which before send signal to test_pid
3) account_memsinfo before result_check

About 2) and 3), we can increase the value of lowerlimit to keep
the result as SUCCESS.

After discussing with Richard, we all agree to use the following
formula to calculate the lowerlimit:
lowerlimit(kb) = pagesize(byte) * 512 / 1024

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 .../cpuset_memory_spread_testset.sh                    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index e2767ef05..f7230a4ea 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -38,7 +38,15 @@ nr_mems=$N_NODES
 # on which it is running. The other nodes' slab space has littler change.(less
 # than 1000 kb).
 upperlimit=10000
-lowerlimit=2000
+
+# set lowerlimit according to pagesize
+# pagesize(bytes)  | lowerlimit(kb)
+# ------------------------------------
+#  4096            | 2048
+#  16384           | 8192
+
+PAGE_SIZE=`tst_getconf PAGESIZE`
+lowerlimit=$((PAGE_SIZE * 512 / 1024))
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"

base-commit: 020f3985a5ca86c8bbece27eef8fb0315a10463e
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
