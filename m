Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B16C71130
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 07:22:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DAF83CA330
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:22:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6BC43CA14F
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 09:12:25 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id A5CF82C4FE24
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 09:12:21 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8DxQK_SxGxoRzUkAQ--.43079S3;
 Tue, 08 Jul 2025 15:12:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJCxocLQxGxoVhIOAA--.15507S2;
 Tue, 08 Jul 2025 15:12:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: ltp@lists.linux.it
Date: Tue,  8 Jul 2025 15:12:15 +0800
Message-ID: <20250708071215.17515-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CM-TRANSID: qMiowJCxocLQxGxoVhIOAA--.15507S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFWDuw47ZrW7uryUZF1DurX_yoW7JrWkpa
 4xKa4jqay5tayjv3yxtr93Z3ySqr18Cr1aqrn8CrykZF1UGw15GF1xW3WYvw17Xr4Ykw47
 tF1DtFWvya1UArbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 08 Jul 2025 09:22:13 +0200
Subject: [LTP] [PATCH] getrlimit/getrlimit03: Skip test if __NR_getrlimit
 not implemented
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

In the Linux kernel, LoongArch uses the generic syscall table which
is defined in include/uapi/asm-generic/unistd.h, and also there is
no __ARCH_WANT_SET_GET_RLIMIT in arch/loongarch/include/asm/unistd.h,
so __NR_getrlimit is not implemented on LoongArch.

That is to say, getrlimit are superseded with prlimit64. There is no
need to compare the return value and errno about the syscall numbers
__NR_prlimit64 and __NR_getrlimit, just check this case and then skip
the test.

Without this patch:

$ /opt/ltp/testcases/bin/getrlimit03
...
getrlimit03.c:102: TFAIL: __NR_prlimit64(0) returned 0 (SUCCESS) but __NR_getrlimit(0) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(1) returned 0 (SUCCESS) but __NR_getrlimit(1) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(2) returned 0 (SUCCESS) but __NR_getrlimit(2) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(3) returned 0 (SUCCESS) but __NR_getrlimit(3) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(4) returned 0 (SUCCESS) but __NR_getrlimit(4) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(5) returned 0 (SUCCESS) but __NR_getrlimit(5) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(6) returned 0 (SUCCESS) but __NR_getrlimit(6) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(7) returned 0 (SUCCESS) but __NR_getrlimit(7) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(8) returned 0 (SUCCESS) but __NR_getrlimit(8) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(9) returned 0 (SUCCESS) but __NR_getrlimit(9) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(10) returned 0 (SUCCESS) but __NR_getrlimit(10) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(11) returned 0 (SUCCESS) but __NR_getrlimit(11) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(12) returned 0 (SUCCESS) but __NR_getrlimit(12) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(13) returned 0 (SUCCESS) but __NR_getrlimit(13) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(14) returned 0 (SUCCESS) but __NR_getrlimit(14) returned -1 (ENOSYS)
getrlimit03.c:102: TFAIL: __NR_prlimit64(15) returned 0 (SUCCESS) but __NR_getrlimit(15) returned -1 (ENOSYS)

Summary:
passed   0
failed   16
broken   0
skipped  0
warnings 0

With this patch:

$ /opt/ltp/testcases/bin/getrlimit03
...
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)

Summary:
passed   0
failed   0
broken   0
skipped  16
warnings 0

How to reproduce:

git clone https://github.com/linux-test-project/ltp.git
cd ltp
make autotools
./configure
make all
sudo make install
/opt/ltp/testcases/bin/getrlimit03

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 604082ccf..2d79057da 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -162,6 +162,11 @@ static void run(unsigned int resource)
 	errno = 0;
 	ret_ul = getrlimit_ulong(resource, &rlim_ul);
 	errno_ul = errno;
+	if (errno_ul == ENOSYS) {
+		tst_res(TCONF | TERRNO,
+			"%s not implemented", __NR_getrlimit_ulong_str);
+		return;
+	}
 
 	if (compare_retval(resource, ret_u64, errno_u64, ret_ul, errno_ul,
 			   __NR_getrlimit_ulong_str) ||
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
