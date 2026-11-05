Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DC606A32C
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=METVPj/B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fu7qatgt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793915859; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=EjghF/ZtFk3IpidE3RmS8Vsvqx/S96m77S8u+QWZ8qs=;
 b=METVPj/BQZCUIOEgzZJTXPKRgtYXynNNg5WZwUGGGjTVLfQNfg8EzYm0Ymm8SZSVIPeu1
 CBavKUJ+FgzDVO26ruxEEpiKbV+/CQ6niQnBZJIvQzexAA96FX6ocSrlUr+yo94nvOCYwvW
 fxMgXbdydtkPLH3tYNT6za/aMYIuAIw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86973CFD77
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 22:57:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60F803CE878
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 22:57:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E0C860008A
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 22:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793915836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SCQVVq3PqtOzDfXM9tFeX6Ou0kh/9qOth3AKBu8jXCo=;
 b=Fu7qatgtVPGcKP8tbKX2OfrxmaBURFetBha6UXOmUCNAyijO4xYGRkIy9Gwzao44oZbj60
 b/dX+ReUDRgpPWw3jUWD8gkp7GS8ia2SVvaS2chp0F71HJFcOMPMNYP9PJbpB71ZpCPtbI
 ZXqkms3wgcCOaXPhOyNDhLUHBM5tCM8=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-6qvuipuYPDqCQkmQqIz6FQ-1; Thu, 05 Nov 2026 16:57:14 -0500
X-MC-Unique: 6qvuipuYPDqCQkmQqIz6FQ-1
X-Mimecast-MFC-AGG-ID: 6qvuipuYPDqCQkmQqIz6FQ_1793915834
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67bf5eabb0fso1788650d50.0
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 13:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793915834; x=1794520634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SCQVVq3PqtOzDfXM9tFeX6Ou0kh/9qOth3AKBu8jXCo=;
 b=FnUReQ8HGeCvG+9Z+CT8O/lSx9kH+J5Gda0KyxHUXjs0vt7SaHQZ+xd2/XQHw3+ih/
 DFcq7TMVHyoF3ETjVTCZP6wCxydP73TcBtYOgo7BLh9TVAHh3Nz6trqptOt4G/ZFk/vp
 QH45xW1sYRY39tEtE93H1k4kdJuwzcmCv0ta7TyDQLL8aVBaiPCXTEpCi3j4MXWCL9k4
 r4ZNFtBAttH+FGCDh+gcc5lYA8AJUht3I8Pdmcltm9Y3ZO3Dz6My3pDPklvmgm2QtGgj
 tqrGyJKnIeKRaNBQe67mNUQC4K8NyY+dSbC4LpxT3aCEPGmu9mYzTqlWsWQ95SDcxdxZ
 QxFw==
X-Gm-Message-State: APuU4Z+0R61qK38loqXAkH3VVdAtEAoPtzEzocEmVihbAQpsuvqYgGkb
 b4kAWzMq1zl7VtdmGezQ9aLui+IWJaLM3julvLnpbFDdE/P40Py39gvBjBsIttVxMX67DtUNdFN
 7LuzQs+sC9/WqLS78AhgLeVs6QolCigtgQnjJRFN5kJxTwQyUWR4q1mmc6CZfufbTF1VYR9nvba
 d81nD1rWd06EDNtEGU97Lncy6B9bW2cW6bzOla
X-Gm-Gg: AYBFou3dShS8a61hbclpCjM1pLJR7AMmkUHHKL7Dv3TzUbznV+ISaiisLpplUZRhMOO
 bcq6QILLucCUQVTvzmIq3QMPCJ7+FJfXPctWv2tmdnYr/hlu6cDJpIbGZPHPde8cYHBvs/m0rQG
 2YizAVy7n4yai9ysEIzFdVxi0h0PY8xEKqVJwQbrZ03gmrwWL2IyfC1efD8A9SQCdhM9i71eMTf
 vhkLg7yyf1NQcKYJ4+DPpPBY+RlSNygYLw7/+5Qx5Hj9mfG9FAY3hq4alhj0zl7U5EBVOAYt8Qf
 QC6BF9pHskshEVlEYNbiNYgwl+MJRcnd/cbTV9fN65ZXOuJeaPLsLG7GyPOWxa0KtxqfBj39wPV
 YOinqsRDOwk5YkEh0cOzDnsY5+INuKHjBJIPl5+uMS6ZlaEibIx8C6awuJahmDAt9AeoVZHOMtv
 WV
X-Received: by 2002:a05:690e:43c5:b0:677:d05a:4800 with SMTP id
 956f58d0204a3-67c035f1b96mr1335954d50.25.1793915834194; 
 Thu, 05 Nov 2026 13:57:14 -0800 (PST)
X-Received: by 2002:a05:690e:43c5:b0:677:d05a:4800 with SMTP id
 956f58d0204a3-67c035f1b96mr1335936d50.25.1793915833432; 
 Thu, 05 Nov 2026 13:57:13 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.csb ([144.121.52.162])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c134f0ec3sm574841d50.8.2026.11.05.13.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 13:57:13 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu,  5 Nov 2026 16:55:02 -0500
Message-ID: <20261105215504.803025-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fqk2rJ8eAth8JwxYTmX6a1dJbZCBAZxhfPXkmBAmXZE_1793915834
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] memfd_create01: Reject F_SEAL_EXEC over a writable
 mapping
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>, Cursor <cursoragent@cursor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

On an executable memfd, F_SEAL_EXEC implies the write and size seals.
Adding it while a writable shared mapping exists must fail with EBUSY.
With no mapping held, the implied seals must be set.

Assisted-by: Cursor <cursoragent@cursor.com>
Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 include/lapi/fcntl.h                          |   6 +
 .../syscalls/memfd_create/memfd_create01.c    | 107 +++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index d70954ea7..d826acba5 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -65,6 +65,12 @@
 #ifndef F_SEAL_WRITE
 # define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
+#ifndef F_SEAL_FUTURE_WRITE
+# define F_SEAL_FUTURE_WRITE 0x0010  /* prevent future writes while mapped */
+#endif
+#ifndef F_SEAL_EXEC
+# define F_SEAL_EXEC     0x0020  /* prevent chmod modifying exec bits */
+#endif
 
 #ifndef F_OWNER_PGRP
 # define F_OWNER_PGRP 2
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
index 28ad04a86..64e9daa77 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2017-2020
+ * Copyright (c) Linux Test Project, 2017-2026
  * Copyright (C) 2017  Red Hat, Inc.
  * Port to LTP <jracek@redhat.com>
  */
 
 /*\
  * Test based on :kselftest:`memfd/memfd_test.c`.
+ *
+ * On an executable memfd, F_SEAL_EXEC implies F_SEAL_WRITE,
+ * F_SEAL_FUTURE_WRITE, F_SEAL_SHRINK and F_SEAL_GROW. F_SEAL_EXEC is
+ * rejected with EBUSY while a writable shared mapping exists.
  */
 
 #define _GNU_SOURCE
@@ -15,6 +19,9 @@
 #include "tst_test.h"
 #include "memfd_create_common.h"
 
+#define SEAL_EXEC_IMPLIED (F_SEAL_EXEC | F_SEAL_SHRINK | F_SEAL_GROW | \
+			   F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)
+
 /*
  * Do few basic sealing tests to see whether setting/retrieving seals works.
  */
@@ -68,6 +75,75 @@ static void test_seal_write(int fd)
 	CHECK_MFD_NON_GROWABLE_BY_WRITE(fd);
 }
 
+/*
+ * F_SEAL_EXEC is only meaningful once the kernel knows the flag. Probe a
+ * separate memfd so a missing flag does not seal the caller's fd.
+ * Returns 1 when F_ADD_SEALS accepts F_SEAL_EXEC, 0 when the kernel rejects
+ * the flag with EINVAL.
+ */
+static int seal_exec_supported(void)
+{
+	static int supported = -1;
+	int fd;
+
+	if (supported >= 0)
+		return supported;
+
+	fd = sys_memfd_create("ltp_memfd_seal_exec", MFD_ALLOW_SEALING);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "memfd_create() for F_SEAL_EXEC probe");
+
+	TEST(fcntl(fd, F_ADD_SEALS, F_SEAL_EXEC));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET == 0)
+		supported = 1;
+	else if (TST_ERR == EINVAL)
+		supported = 0;
+	else
+		tst_brk(TBROK | TTERRNO, "fcntl(F_ADD_SEALS, F_SEAL_EXEC)");
+
+	return supported;
+}
+
+/* F_SEAL_EXEC implies F_SEAL_WRITE only when the file mode is executable. */
+static int memfd_is_executable(int fd)
+{
+	struct stat st;
+
+	SAFE_FSTAT(fd, &st);
+
+	return !!(st.st_mode & 0111);
+}
+
+/*
+ * Test SEAL_EXEC
+ * On an executable memfd, F_SEAL_EXEC implies the write and size seals.
+ */
+static void test_seal_exec(int fd)
+{
+	if (!memfd_is_executable(fd)) {
+		tst_res(TCONF,
+			"no execute bit, F_SEAL_EXEC does not imply F_SEAL_WRITE");
+		return;
+	}
+
+	if (!seal_exec_supported()) {
+		tst_res(TCONF, "F_SEAL_EXEC is not supported");
+		return;
+	}
+
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_EXEC);
+	CHECK_MFD_HAS_SEALS(fd, SEAL_EXEC_IMPLIED);
+
+	CHECK_MFD_READABLE(fd);
+	CHECK_MFD_NON_WRITEABLE(fd);
+	CHECK_MFD_NON_SHRINKABLE(fd);
+	CHECK_MFD_NON_GROWABLE(fd);
+	CHECK_MFD_NON_GROWABLE_BY_WRITE(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -164,12 +240,34 @@ static void test_share_mmap(int fd)
 
 	CHECK_MFD_HAS_SEALS(fd, 0);
 
-	/* shared/writable ref prevents sealing WRITE, but allows others */
+	/*
+	 * A shared writable mapping blocks F_SEAL_WRITE. F_SEAL_EXEC is
+	 * blocked too when it would imply F_SEAL_WRITE. Other seals, such
+	 * as F_SEAL_SHRINK, are still allowed.
+	 */
 	p = SAFE_MMAP(NULL, MFD_DEF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
 		fd, 0);
 
 	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_WRITE);
 	CHECK_MFD_HAS_SEALS(fd, 0);
+
+	if (memfd_is_executable(fd) && seal_exec_supported()) {
+		TST_EXP_FAIL(fcntl(fd, F_ADD_SEALS, F_SEAL_EXEC), EBUSY,
+			"F_SEAL_EXEC while a writable mapping exists");
+		if (!TST_PASS) {
+			SAFE_MUNMAP(p, MFD_DEF_SIZE);
+			return;
+		}
+
+		CHECK_MFD_HAS_SEALS(fd, 0);
+
+		*(volatile char *)p = 'x';
+		if (*(volatile char *)p != 'x')
+			tst_res(TFAIL, "writable mapping did not retain the write");
+		else
+			tst_res(TPASS, "writable mapping remained writable");
+	}
+
 	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SHRINK);
 	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK);
 	SAFE_MUNMAP(p, MFD_DEF_SIZE);
@@ -221,6 +319,7 @@ static const struct tcase {
 	{0,                 &test_no_sealing_without_flag, "Disabled sealing"},
 
 	{MFD_ALLOW_SEALING, &test_seal_write, "Write seal"},
+	{MFD_ALLOW_SEALING, &test_seal_exec, "Exec seal implies write seals"},
 	{MFD_ALLOW_SEALING, &test_seal_shrink, "Shrink seal"},
 	{MFD_ALLOW_SEALING, &test_seal_grow, "Grow seal"},
 	{MFD_ALLOW_SEALING, &test_seal_resize, "Resize seal"},
@@ -264,4 +363,8 @@ static struct tst_test test = {
 	.test = verify_memfd_create,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3b041514cb6e"},
+		{}
+	},
 };
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
