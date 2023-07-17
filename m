Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F0EB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 09:06:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A7333CEB7B
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 11:06:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 285AE3C1812
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 11:06:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 58B7E60076C
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 11:06:02 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45B7AD75;
 Mon, 17 Jul 2023 02:06:43 -0700 (PDT)
Received: from disclose.cambridge.arm.com (disclose.cambridge.arm.com
 [10.1.196.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 877233F73F;
 Mon, 17 Jul 2023 02:05:59 -0700 (PDT)
From: Zachary Leaf <zachary.leaf@arm.com>
To: ltp@lists.linux.it
Date: Mon, 17 Jul 2023 10:05:39 +0100
Message-Id: <20230717090539.371142-1-zachary.leaf@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] bpf: use consistent log size
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

Currently the log size for bpf_prog01 + bpf_prog02 is set to BUFSIZ
which is defined by the libc in stdio.h. In glibc, this is set to the
constant 8192. In other libc's this may be different, e.g. in Musl this
is set to 1024. For bpf_prog02, a log size of 1024 is not large enough
to store the verifier log resulting in the following test breakage:

[...] bpf_common.c:123: TBROK: Failed verification: ENOSPC (28)

This error is returned from kernel/bpf/verifier.c when the verifier log
exceeds the user supplied buffer.

Align bpf_prog01 + bpf_prog02 with other bpf tests and set the buffer
size explicitly to 8192 in bpf_common.h. Since all tests use this value,
use a common definition instead of redefining it in each test.

Signed-off-by: Zachary Leaf <zachary.leaf@arm.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.h | 1 +
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 2 +-
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 4 ++--
 testcases/kernel/syscalls/bpf/bpf_prog04.c | 1 -
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog06.c | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog07.c | 2 --
 7 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index 39764ba1f..a0800d19b 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -13,6 +13,7 @@
 #include "lapi/socket.h"
 
 #define BPF_MEMLOCK_ADD (2*1024*1024)
+#define BUFSIZE 8192
 
 /* map[array_indx] = reg_to_save
  *
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index e2fc80a9f..de4f68cef 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -63,7 +63,7 @@ int load_prog(int fd)
 		BPF_EXIT_INSN(),		         /* return r0 */
 	};
 
-	bpf_init_prog_attr(attr, PROG, sizeof(PROG), log, BUFSIZ);
+	bpf_init_prog_attr(attr, PROG, sizeof(PROG), log, BUFSIZE);
 	return bpf_load_prog(attr, log);
 }
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index b40ea0f1d..fd3e535c1 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -64,7 +64,7 @@ static int load_prog(int fd)
 		BPF_EXIT_INSN(),		        /* 26: return r0 */
 	};
 
-	bpf_init_prog_attr(attr, insn, sizeof(insn), log, BUFSIZ);
+	bpf_init_prog_attr(attr, insn, sizeof(insn), log, BUFSIZE);
 	return bpf_load_prog(attr, log);
 }
 
@@ -117,7 +117,7 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&key, .size = sizeof(*key)},
 		{&val, .size = sizeof(*val)},
-		{&log, .size = BUFSIZ},
+		{&log, .size = BUFSIZE},
 		{&attr, .size = sizeof(*attr)},
 		{&msg, .size = sizeof(MSG)},
 		{},
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog04.c b/testcases/kernel/syscalls/bpf/bpf_prog04.c
index ebee26cbc..cf3bb1254 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog04.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog04.c
@@ -28,7 +28,6 @@
 #include "tst_capability.h"
 #include "bpf_common.h"
 
-#define BUFSIZE 8192
 #define CHECK_BPF_RET(x) ((x) >= 0 || ((x) == -1 && errno != EACCES))
 
 static const char MSG[] = "Ahoj!";
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index 2be5a2cc9..742beab0b 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -52,8 +52,6 @@
 #include "tst_capability.h"
 #include "bpf_common.h"
 
-#define BUFSIZE 8192
-
 static const char MSG[] = "Ahoj!";
 static char *msg;
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog06.c b/testcases/kernel/syscalls/bpf/bpf_prog06.c
index c38dd8239..cee9616cf 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog06.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog06.c
@@ -46,8 +46,6 @@
 #include "lapi/bpf.h"
 #include "bpf_common.h"
 
-#define BUFSIZE 8192
-
 static const char MSG[] = "Ahoj!";
 static char *msg;
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog07.c b/testcases/kernel/syscalls/bpf/bpf_prog07.c
index 50ff6eed0..dab5bb8ad 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog07.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog07.c
@@ -46,8 +46,6 @@
 #include "lapi/bpf.h"
 #include "bpf_common.h"
 
-#define BUFSIZE 8192
-
 static const char MSG[] = "Ahoj!";
 static char *msg;
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
