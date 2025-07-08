Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1DC8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7FDD3CA3F1
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 13:28:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E39C03CA066
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 13:28:18 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 8B2A345C2630
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 13:28:14 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8BxjazMAG1ooVokAQ--.44623S3;
 Tue, 08 Jul 2025 19:28:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJAxE+TKAG1oC0wOAA--.17047S2;
 Tue, 08 Jul 2025 19:28:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: ltp@lists.linux.it
Date: Tue,  8 Jul 2025 19:28:10 +0800
Message-ID: <20250708112810.3298-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CM-TRANSID: qMiowJAxE+TKAG1oC0wOAA--.17047S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrWUXw18Wr4fXr1Duw45Jwc_yoWrCFy7p3
 4xGa4jkFW5ta42yw18trWfZayfXr18Cr43trs8CrykZF4UGw15G3Wxu3WFvw17Xry5J3y7
 tF1ktFWqya1UArbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit_ulong not implemented
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

In the LTP code, __NR_getrlimit_ulong is defined as __NR_ugetrlimit
or __NR_getrlimit.

In the Linux kernel, LoongArch uses the generic syscall table
which is defined in include/uapi/asm-generic/unistd.h. We can
see that __NR_ugetrlimit is not defined in the generic header,
and also there is no __ARCH_WANT_SET_GET_RLIMIT definition in
the arch specific header arch/loongarch/include/asm/unistd.h,
so both __NR_ugetrlimit and __NR_getrlimit are not implemented
on LoongArch.

That is to say, no need to compare the return value and errno
about the syscall numbers __NR_prlimit64 and __NR_{u}getrlimit,
just check this case and then skip the test.

While at it, modify the value of test.tcnt as 1 to skip only
once if the errno of getrlimit_ulong() or getrlimit_long() is
ENOSYS.

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
getrlimit03.c:166: TCONF: __NR_getrlimit not implemented: ENOSYS (38)

Summary:
passed   0
failed   0
broken   0
skipped  1
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
Reviewed-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 604082ccf..bb6160c2b 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -162,6 +162,12 @@ static void run(unsigned int resource)
 	errno = 0;
 	ret_ul = getrlimit_ulong(resource, &rlim_ul);
 	errno_ul = errno;
+	if (errno_ul == ENOSYS) {
+		tst_res(TCONF | TERRNO,
+			"%s not implemented", __NR_getrlimit_ulong_str);
+		test.tcnt = 1;
+		return;
+	}
 
 	if (compare_retval(resource, ret_u64, errno_u64, ret_ul, errno_ul,
 			   __NR_getrlimit_ulong_str) ||
@@ -181,6 +187,7 @@ static void run(unsigned int resource)
 	if (errno_l == ENOSYS) {
 		tst_res(TCONF | TERRNO,
 			"__NR_getrlimit(%d) not implemented", __NR_getrlimit);
+		test.tcnt = 1;
 		return;
 	}
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
