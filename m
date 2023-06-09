Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6BAC7EE29
	for <ltp@archiver.kernel.org>; Fri,  9 Jun 2023 01:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1431C3CBB6A
	for <ltp@archiver.kernel.org>; Fri,  9 Jun 2023 03:28:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F25533C9BD3
 for <ltp@lists.linux.it>; Fri,  9 Jun 2023 03:28:13 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 1B7741400FBC
 for <ltp@lists.linux.it>; Fri,  9 Jun 2023 03:28:09 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.185])
 by gateway (Coremail) with SMTP id _____8CxPuskgIJkvtQAAA--.2706S3;
 Fri, 09 Jun 2023 09:28:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxK8oTgIJkw10JAA--.20505S2; 
 Fri, 09 Jun 2023 09:28:04 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Cyril Hrubis <chrubis@suse.cz>,
	Petr Vorel <petr.vorel@gmail.com>
Date: Fri,  9 Jun 2023 09:27:40 +0800
Message-Id: <20230609012740.19097-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8DxK8oTgIJkw10JAA--.20505S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAQB2SAc4EZjwAFsT
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1DZF47XFW3Wr43WF1xWFX_yoW8Gw4kpF
 1fC3yDK3Z0qFnrCa1xC3Z0yr10va45XF48uFZxC3WDZrZxJa15CF18Jrs8JFyjqr1YgFyY
 ka4xCwsruasrJFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZUUUUU=
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpuset_memory_spread: change lowerlimit to 5000kb
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
the result as SUCCESS.After my testing, 5000kb is a reasonable value.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 .../cpuset_memory_spread_test/cpuset_memory_spread_testset.sh   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index e2767ef05..d33468525 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -38,7 +38,7 @@ nr_mems=$N_NODES
 # on which it is running. The other nodes' slab space has littler change.(less
 # than 1000 kb).
 upperlimit=10000
-lowerlimit=2000
+lowerlimit=5000
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
