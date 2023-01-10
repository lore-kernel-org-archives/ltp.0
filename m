Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38281C46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 14:17:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FEFF3CCB2A
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 15:17:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85A1B3CA6C2
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 15:17:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E8B9E600792
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 15:17:13 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 72A4833B91;
 Tue, 10 Jan 2023 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673360232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZAmqTYMDvwJ1lkST1HK7tyzSQbZOBmyLIfEet6K4r0=;
 b=Lv4UpIskwlV6hKElStw7JVENm51JSyBP/QhVUmS5QEE6/VuGviENXdiPeblH8DQmhpuUHg
 fyc3/aKSgoQ4arSByO0jG10p6oPT3PBqvmLYke0LMoeHFB0U9+edM8Hst8AALgUmocrQna
 T1Nc4C6vJBpotiCKtwbKdNLkNCZi/nQ=
Received: from g78.cable.virginm.net (unknown [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id 7E6ED2C141;
 Tue, 10 Jan 2023 14:17:10 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 10 Jan 2023 14:16:16 +0000
Message-Id: <20230110141616.1449-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110141616.1449-1-rpalethorpe@suse.com>
References: <20230110141616.1449-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] fcntl{34,
 36}: Always use 64-bit flock struct to avoid EINVAL
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Recently we switched to using struct fcntl with _FILE_OFFSET_BITS
instead of the transitional type fcntl64 which has been removed from
some libcs.

This broke testing with 32-bit executables on a 64bit kernel when
FILE_OFFSET_BITS was not set to 64. Because the fcntl64 syscall does
not exist on 64 bit kernels.

The reason we are making the syscall directly is because of old
glibc's which don't do any conversion.

So we now do a conversion unconditionally and call fcntl64 if the
kernel is 32-bit.

When we no longer support old glibcs we can drop this compat function
altogether.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c     |  8 +-
 testcases/kernel/syscalls/fcntl/fcntl36.c     |  8 +-
 .../kernel/syscalls/fcntl/fcntl_common.h      | 79 +++++++++++++------
 3 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 8d5e22b72..45e693fe6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -10,10 +10,8 @@
 #include <pthread.h>
 #include <sched.h>
 
-#include "lapi/fcntl.h"
-#include "tst_safe_pthread.h"
-#include "tst_test.h"
 #include "fcntl_common.h"
+#include "tst_safe_pthread.h"
 
 static int thread_cnt;
 static const int max_thread_cnt = 32;
@@ -62,13 +60,13 @@ void *thread_fn_01(void *arg)
 
 	for (i = 0; i < writes_num; ++i) {
 		lck.l_type = F_WRLCK;
-		my_fcntl(fd, F_OFD_SETLKW, &lck);
+		FCNTL_COMPAT(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, 0, SEEK_END);
 		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, write_size);
 
 		lck.l_type = F_UNLCK;
-		my_fcntl(fd, F_OFD_SETLKW, &lck);
+		FCNTL_COMPAT(fd, F_OFD_SETLKW, &lck);
 
 		sched_yield();
 	}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 067eaee64..e84b7ed0c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -84,13 +84,13 @@ static void *fn_ofd_w(void *arg)
 		memset(buf, wt, pa->length);
 
 		lck.l_type = F_WRLCK;
-		my_fcntl(fd, F_OFD_SETLKW, &lck);
+		FCNTL_COMPAT(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
 		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, pa->length);
 
 		lck.l_type = F_UNLCK;
-		my_fcntl(fd, F_OFD_SETLKW, &lck);
+		FCNTL_COMPAT(fd, F_OFD_SETLKW, &lck);
 
 		wt++;
 		if (wt >= 255)
@@ -163,7 +163,7 @@ static void *fn_ofd_r(void *arg)
 		memset(buf, 0, pa->length);
 
 		lck.l_type = F_RDLCK;
-		my_fcntl(fd, F_OFD_SETLKW, &lck);
+		FCNTL_COMPAT(fd, F_OFD_SETLKW, &lck);
 
 		/* rlock acquired */
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
@@ -194,7 +194,7 @@ static void *fn_ofd_r(void *arg)
 		}
 
 		lck.l_type = F_UNLCK;
-		my_fcntl(fd, F_OFD_SETLK, &lck);
+		FCNTL_COMPAT(fd, F_OFD_SETLK, &lck);
 
 		sched_yield();
 	}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
index abb82c96f..734b57af2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
+++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
@@ -1,38 +1,71 @@
 #ifndef FCNTL_COMMON_H__
 #define FCNTL_COMMON_H__
 
+#include <inttypes.h>
+
+#include "tst_test.h"
+#include "tst_kernel.h"
+
 #include "lapi/syscalls.h"
 #include "lapi/abisize.h"
+#include "lapi/fcntl.h"
+
+struct my_flock64 {
+	int16_t l_type;
+	int16_t l_whence;
+	int64_t l_start;
+	int64_t l_len;
+	int32_t l_pid;
+#if defined(__sparc__)
+	int16_t padding;
+#endif
+};
 
 /*
- * glibc commit:
- *   06ab719d30b0 ("Fix Linux fcntl OFD locks for non-LFS architectures (BZ#20251)")
- * changed behavior of arg parameter for OFD commands. It is no
- * longer passing arg directly to syscall, but expects it to be
- * 'struct flock'.
+ * F_OFD_* commands always require flock64 struct. Older GLibc (pre 2.29) would
+ * pass the flock sturct directly to the kernel even if it had 32-bit
+ * offsets.
  *
- * On 64-bit or _FILE_OFFSET_BITS == 64 we can use fcntl() and
- * struct flock64 with any glibc version. struct flock and flock64
- * should be identical.
+ * Also, if and only if, we are on 32-bit kernel we need to use the
+ * fcntl64 compat syscall.
  *
- * On 32-bit, older glibc would pass arg directly, recent one treats
- * it as 'struct flock' and converts it to 'struct flock64'.
- * So, to support both version, on 32-bit we use fcntl64 syscall
- * directly with struct flock64.
+ * See:
+ * glibc: 06ab719d30 Fix Linux fcntl OFD locks for non-LFS architectures (BZ#20251)
+ * kernel: fs/fcntl.c
  */
-#if defined(TST_ABI64) || _FILE_OFFSET_BITS == 64
-static int my_fcntl(int fd, int cmd, void *lck)
-{
-	return SAFE_FCNTL(fd, cmd, lck);
-}
-#else
-static int my_fcntl(int fd, int cmd, void *lck)
+static inline int fcntl_compat(const char *file, const int line, const char *cmd_name,
+			       int fd, int cmd, struct flock *lck)
 {
-	int ret = tst_syscall(__NR_fcntl64, fd, cmd, lck);
-	if (ret == -1)
-		tst_brk(TBROK|TERRNO, "fcntl64");
+	struct my_flock64 l64 = {
+		.l_type = lck->l_type,
+		.l_whence = lck->l_whence,
+		.l_start = lck->l_start,
+		.l_len = lck->l_len,
+		.l_pid = lck->l_pid,
+	};
+	const long sysno = tst_kernel_bits() > 32 ? __NR_fcntl : __NR_fcntl64;
+	const int ret = tst_syscall(sysno, fd, cmd, &l64);
+
+	lck->l_type = l64.l_type;
+	lck->l_whence = l64.l_whence;
+	lck->l_start = l64.l_start;
+	lck->l_len = l64.l_len;
+	lck->l_pid = l64.l_pid;
+
+	if (ret != -1)
+		return ret;
+
+	tst_brk_(file, line, TBROK | TERRNO,
+		 "%s(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
+		 tst_kernel_bits() > 32 ? "fcntl" : "fcntl64",
+		 fd,
+		 cmd_name,
+		 l64.l_type, l64.l_whence, l64.l_start, l64.l_len, l64.l_pid);
+
 	return ret;
 }
-#endif
+
+#define FCNTL_COMPAT(fd, cmd, flock) \
+	fcntl_compat(__FILE__, __LINE__, #cmd, fd, cmd, flock)
 
 #endif /* FCNTL_COMMON_H__ */
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
