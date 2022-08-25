Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289CDC04AA5
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 10:52:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CD8B3CA4A0
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 12:52:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1472A3C144C
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 12:52:44 +0200 (CEST)
Received: from Atcsqr.andestech.com (unknown [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E118200276
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 12:52:41 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 27PAqVDp018161;
 Thu, 25 Aug 2022 18:52:31 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.12.119) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Aug 2022
 18:52:27 +0800
From: Dylan Jhong <dylan@andestech.com>
To: <ltp@lists.linux.it>
Date: Thu, 25 Aug 2022 18:52:04 +0800
Message-ID: <20220825105204.953388-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.12.119]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 27PAqVDp018161
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/semctl03: Solve kernel panic in semctl03
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
Cc: randolph@andestech.com, alankao@andestech.com, x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When using semctl() through glibc and __IPC_TIME64 is defined, glibc will
call a converted semun64_to_ksemun64() function[*1]. If the parameter of
this function is NULL, it will cause a NULL pointer dereference kernel
panic.

In semctl03.c, we need to ensure the element "struct semid_ds *buf" in 4th
parameter "union semun" in semctl() is not NULL. But the 4th parameters of
libc_semctl() and sys_semctl() are hard-coded[*2] and the element
"struct semid_ds *buf" is not given an initial value. Using va_list to pass
the correct parameters can solve the problem.

ref:
  [*1]: https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L172
  [*2]: https://github.com/linux-test-project/ltp/blob/58caa8cca507133ea92bd0ea277b91add96e72af/testcases/kernel/syscalls/ipc/semctl/semctl03.c#L45

Co-developed-by: Randolph <randolph@andestech.com>
Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 testcases/kernel/syscalls/ipc/semctl/semctl03.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index a1a4c81ce..bb25053e2 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -28,11 +28,21 @@ static union semun arg = {0};
 
 static int libc_semctl(int semid, int semnum, int cmd, ...)
 {
+	va_list ap;
+
+	va_start(ap, cmd);
+	arg = va_arg(ap, union semun);
+	va_end(ap);
 	return semctl(semid, semnum, cmd, arg);
 }
 
 static int sys_semctl(int semid, int semnum, int cmd, ...)
 {
+	va_list ap;
+
+	va_start(ap, cmd);
+	arg = va_arg(ap, union semun);
+	va_end(ap);
 	return tst_syscall(__NR_semctl, semid, semnum, cmd, arg);
 }
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
