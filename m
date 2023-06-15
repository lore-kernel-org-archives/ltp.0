Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6F7EB64D9
	for <ltp@archiver.kernel.org>; Thu, 15 Jun 2023 09:40:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87B253CC5C2
	for <ltp@archiver.kernel.org>; Thu, 15 Jun 2023 11:40:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 143B13CA927
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 11:39:53 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 390696006D1
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 11:39:50 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 35F9dcfN080659;
 Thu, 15 Jun 2023 17:39:38 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 15 Jun 2023
 17:39:36 +0800
From: Dylan Jhong <dylan@andestech.com>
To: <ltp@lists.linux.it>
Date: Thu, 15 Jun 2023 17:39:33 +0800
Message-ID: <20230615093933.3185297-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 35F9dcfN080659
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc variant
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
Cc: minachou@andestech.com, tim609@andestech.com, x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When testing hugeshmctl02 under the 32bit architecture, a segmentation fault
will occur. This patch will skip EFAULT tests for libc variant.

Hugeshmctl02 will intentionally pass "(struct shmid_ds *)-1" to shmctl(), but
glibc will perform an additional conversion function when the architecture is
32bit, which will try to copy all items in (struct shmid_ds *) to another
structure[*1]. In the process of copying, it is necessary to dereference
"(struct shmid_ds *)-1", resulting in segmentation fault.

The LTP also has similar problems before, this patch is reference from the
shmctl03 patch[*2].

[*1]: https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/shmctl.c#L37
[*2]: https://github.com/linux-test-project/ltp/commit/a5a80aa8485a7cb017f96aba8d7b5ea79f1ba4d4

Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 0bc9ffd74..e9c2e9fc8 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -27,6 +27,7 @@
 #include <pwd.h>
 #include <limits.h>
 #include "hugetlb.h"
+#include "lapi/syscalls.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -50,9 +51,37 @@ struct tcase {
 	{&shm_id_2, -1, &buf, EINVAL},
 };
 
+static int libc_shmctl(int shmid, int cmd, void *buf)
+{
+	return shmctl(shmid, cmd, buf);
+}
+
+static int sys_shmctl(int shmid, int cmd, void *buf)
+{
+	return tst_syscall(__NR_shmctl, shmid, cmd, buf);
+}
+
+static struct test_variants
+{
+	int (*shmctl)(int shmid, int cmd, void *buf);
+	char *desc;
+} variants[] = {
+	{ .shmctl = libc_shmctl, .desc = "libc shmctl()"},
+#if (__NR_shmctl != __LTP__NR_INVALID_SYSCALL)
+	{ .shmctl = sys_shmctl,  .desc = "__NR_shmctl syscall"},
+#endif
+};
+
 static void test_hugeshmctl(unsigned int i)
 {
-	TEST(shmctl(*(tcases[i].shmid), tcases[i].cmd, tcases[i].sbuf));
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (tcases[i].error == EFAULT && tv->shmctl == libc_shmctl) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
+
+	TEST(tv->shmctl(*(tcases[i].shmid), tcases[i].cmd, tcases[i].sbuf));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "shmctl succeeded unexpectedly");
 		return;
@@ -70,8 +99,11 @@ static void test_hugeshmctl(unsigned int i)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	long hpage_size;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "No enough hugepages for testing.");
 
@@ -101,6 +133,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test = test_hugeshmctl,
+	.test_variants = ARRAY_SIZE(variants),
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
