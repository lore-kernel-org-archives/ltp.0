Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA9C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 06:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 465ED3D206A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 08:58:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 245A83D204D
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 08:57:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73B3A1400DB7
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 08:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723100262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mZkq6n/2g5SlH/BR5UWF8kmYmH0/0pgMQORmYatHwh0=;
 b=aykzQkmKYFJUx8yyXzHv5NO7/US6jZuWPyBZMN9M+WHv8wDWJHOKF10Em/dBkJlxz6Tw1S
 xFosXJTX/UeDUoTLWczYzGTKn8Cx6YqRiJw+/iruNyDUfCJCfZr19T1dh0QwpASTP0NgcB
 wSgZvoX0OYBtMUfR7tTGxEQbPLsaXf4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-Ma0Fh8_sOp-t3pUw3iwh4g-1; Thu,
 08 Aug 2024 02:57:41 -0400
X-MC-Unique: Ma0Fh8_sOp-t3pUw3iwh4g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C4CD1944B33
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 06:57:40 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68081953BBD
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 06:57:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  8 Aug 2024 14:57:32 +0800
Message-ID: <20240808065732.64328-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pkey01: Adding test for PKEY_DISABLE_EXECUTE
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

The pkey_test function now includes a code snippet to test execute
permissions, ensuring proper handling of execution rights in memory
protection keys.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/pkey.h                      |  4 ++
 testcases/kernel/syscalls/pkeys/pkey01.c | 50 ++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/lapi/pkey.h b/include/lapi/pkey.h
index 398e3be5f..eb9bf7fb4 100644
--- a/include/lapi/pkey.h
+++ b/include/lapi/pkey.h
@@ -17,6 +17,10 @@
 # define PKEY_DISABLE_WRITE  0x2
 #endif
 
+#ifndef PKEY_DISABLE_EXECUTE
+# define PKEY_DISABLE_EXECUTE 0x4
+#endif
+
 #ifndef HAVE_PKEY_MPROTECT
 inline int pkey_mprotect(void *addr, size_t len, int prot, int pkey)
 {
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index f1ecfec0b..70fdffe48 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 Red Hat, Inc.
+ * Copyright (c) 2019-2024 Red Hat, Inc.
  */
 
 /*\
@@ -41,6 +41,7 @@
 #define PATH_VM_NRHPS "/proc/sys/vm/nr_hugepages"
 
 static int size;
+static int execute_supported = 1;
 
 static struct tcase {
 	unsigned long flags;
@@ -49,14 +50,26 @@ static struct tcase {
 } tcases[] = {
 	{0, PKEY_DISABLE_ACCESS, "PKEY_DISABLE_ACCESS"},
 	{0, PKEY_DISABLE_WRITE, "PKEY_DISABLE_WRITE"},
+	{0, PKEY_DISABLE_EXECUTE, "PKEY_DISABLE_EXECUTE"},
 };
 
 static void setup(void)
 {
-	int i, fd;
+	int i, fd, pkey;
 
 	check_pkey_support();
 
+	pkey = pkey_alloc(0, PKEY_DISABLE_EXECUTE);
+	if (pkey == -1) {
+		if (errno == EINVAL) {
+			tst_res(TINFO, "PKEY_DISABLE_EXECUTE hasn't implement.");
+			execute_supported = 0;
+		} else {
+			tst_brk(TBROK | TERRNO, "pkey_alloc failed");
+		}
+	}
+	pkey_free(pkey);
+
 	if (tst_hugepages == test.hugepages.number)
 		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	else
@@ -130,12 +143,28 @@ static char *flag_to_str(int flags)
 	}
 }
 
+static size_t function_size(void (*func)(void))
+{
+	unsigned char *start = (unsigned char *)func;
+	unsigned char *end = start;
+
+	while (*end != 0xC3 && *end != 0xC2)
+		end++;
+
+	return (size_t)(end - start + 1);
+}
+
 static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 {
 	pid_t pid;
 	char *buffer;
 	int pkey, status;
 	int fd = mpa->fd;
+	size_t (*func)();
+	size_t func_size = -1;
+
+	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE))
+		tst_brk(TCONF, "skip PKEY_DISABLE_EXECUTE test");
 
 	if (!tst_hugepages && (mpa->flags & MAP_HUGETLB)) {
 		tst_res(TINFO, "Skip test on (%s) buffer", flag_to_str(mpa->flags));
@@ -147,6 +176,11 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 
 	buffer = SAFE_MMAP(NULL, size, mpa->prot, mpa->flags, fd, 0);
 
+	if (mpa->prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
+		func_size = function_size((void (*)(void))function_size);
+		memcpy(buffer, (void *)function_size, func_size);
+	}
+
 	pkey = pkey_alloc(tc->flags, tc->access_rights);
 	if (pkey == -1)
 		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
@@ -169,6 +203,10 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 			tst_res(TFAIL | TERRNO,
 				"Write buffer success, buffer[0] = %d", *buffer);
 		break;
+		case PKEY_DISABLE_EXECUTE:
+			func = (size_t (*)())buffer;;
+			tst_res(TFAIL | TERRNO, "Excute buffer result = %lu", func(func));
+		break;
 		}
 		exit(0);
 	}
@@ -193,10 +231,16 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 		tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
 	break;
 	case PROT_READ | PROT_WRITE:
-	case PROT_READ | PROT_WRITE | PROT_EXEC:
 		*buffer = 'a';
 		tst_res(TPASS, "Read & Write buffer success, buffer[0] = %d", *buffer);
 	break;
+	case PROT_READ | PROT_WRITE | PROT_EXEC:
+		func = (size_t (*)())buffer;;
+		if (func_size == func(func))
+			tst_res(TPASS, "Execute buffer success, result = %lu", func_size);
+		else
+			tst_res(TFAIL, "Execute buffer with unexpected result: %lu", func(func));
+	break;
 	}
 
 	if (fd >= 0)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
