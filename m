Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25D606A329
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=oLvSb+wZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A+ew07kW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794841781; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SMWAH+fRtyRaBisINH4Si2wtAlz+XUizXbw2NGdKujw=;
 b=oLvSb+wZtLJ8EeJXT2mZ5hyZ6yYKYFQCrYe+vJRhmV9E/j6ypqjucywcoTyoWwA8tFneP
 pgD+4M+SiuMtSe3X7hBXJQxmjTbeQJx66JTiavccHl0kN7mzO66NDpw/XL3METF/5atBb3c
 ig1f/D/XwkoxO+z7PfiUSxbGuWFvrb8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29503EAA30
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 16:09:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC2D53EA9E1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 16:09:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 167DF10007BD
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 16:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794841759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bik/y74KbB0J2zMw2PYL/BidmA61/3kfVyFhqJIVqjM=;
 b=A+ew07kWqy6K03Z5w02fGQkxsvmS/5r0Vi8ok6HOW0YPXUEHkLbad3os5pQRQSHuTXN7YH
 ZMM5LFLV3Haiqzrgn0pMvVK0d+ZgNc75hPWXSFb4WIfs4ImSr6K4Gqs13Sk4iQuinxVkut
 GqQcZi40rXnfzNY6TjEdZ2zXd7z9zfQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-T-GMybR8MaW7NnQb0zFNyw-1; Mon, 16 Nov 2026 10:09:17 -0500
X-MC-Unique: T-GMybR8MaW7NnQb0zFNyw-1
X-Mimecast-MFC-AGG-ID: T-GMybR8MaW7NnQb0zFNyw_1794841757
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91ea71789d8so85501076d6.0
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 07:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841757; x=1795446557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bik/y74KbB0J2zMw2PYL/BidmA61/3kfVyFhqJIVqjM=;
 b=TAWD0br06OsEfFMXoo4JdKw2ZI1MK7PF7dn4F/9O+MlTchoX5Qb4e5M8mxhpWk2uGL
 Da0Ruw15b74XCyVJeRIeEW1vxckgsTFvg3zCr+hrtIZx904q5Xop4Dz3JsIBsD48kgPL
 uSgoOkEXiMVkTsIyf4cdHGGfuM56jqAaO2TTUxx3fuB3gL5XwtRYSricmL62s3TF3wOW
 4QXI2az5j9/1fbxA3ZV/5wD9WUc4GntSxJwa4JfCm4OdzyvJudRSJmSoJ9k8Gck2h4Hi
 ksLonu32wa3DqPkJoww+Oa8r+XKR6yRqBsfIob97ruhP++MxZqcx41KqFf8GjdaFMo/b
 lsSA==
X-Gm-Message-State: APuU4Z9RW//2WNc2Hf+t0A4/6cJZtNnXvhfLGDZ7+NpGqibVsnTxriOJ
 M+YCDXnNyy2x0vGHzxEk9ZYhjq3xewuvxTV9zAc8y9tfG0ISXL2Ccpx+gZJOxBYK5IUUEgqBb4P
 450omy2CFbPUGE0FUaZls56QC8q8D1SO8j5eNadvv6Sh/m789262qo9+rDxSt3WmRm12Xy/MOs1
 bh4GOirTdmm4JNkxFiV6KEkBRMov3ea/pFxYE2
X-Gm-Gg: AZFdTZcjFtJFUDopkD8EPVcJlC0KbLE554Tc5z380GuYO4qDh2uKc5JfNSwxvQwzEYS
 oIckdq9oiKCaPLr1PwfnMDJF5ugyeW/VW5XFzsJItOa7tEC0yQkn08zozyuhW0jYDzA8Mdu7Pk4
 Tt22KcQcjR6Dtf9sVN9F5Zr6b8GbhU7fdcWhT1Zk9uKxirGbpROJUG2snx3ceRHK3UtZPfJHY1a
 WRJHVxEmxtwxMFUWA+SihRQukEnWnEotjnpVQM8J6d5acyiWjyF9xW2QIguhsKaswyT2ydiQHnf
 X488IkT4ohX0eGPvfZSxyVbH6dRK26QAhfrNogXThxF+ZirX5FORSaWe7swDyn3pXOy2lE8+Hs4
 xKbtxVj0MSKQMEsi6ghiwRVB7Yt+uGVIGs2X4H7Uual0iLVswqavcV7cjDrBsnTMMT1LGqMDAH9
 9hh/o=
X-Received: by 2002:a05:6214:5f01:b0:91e:bc7f:313b with SMTP id
 6a1803df08f44-91f24202effmr177802586d6.38.1794841757115; 
 Mon, 16 Nov 2026 07:09:17 -0800 (PST)
X-Received: by 2002:a05:6214:5f01:b0:91e:bc7f:313b with SMTP id
 6a1803df08f44-91f24202effmr177801636d6.38.1794841756385; 
 Mon, 16 Nov 2026 07:09:16 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.redhat.corp ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d458fdsm87956106d6.9.2026.11.16.07.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:09:15 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 10:09:10 -0500
Message-ID: <20261116150911.667095-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113194640.2925318-1-sbertram@redhat.com>
References: <20261113194640.2925318-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: trQti3VuhNu0cMT_qlVzH1QL7wtfG37a3N6GXbkHtPw_1794841757
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] crypto/af_alg09: Test CVE-2026-52972
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
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

Add a regression test for the missing cap on the AEAD associated data
length.  Kernel commit e4c06479d705 ("crypto: af_alg - Cap AEAD AD
length to 0x80000000") rejects ALG_SET_AEAD_ASSOCLEN values greater
than or equal to 0x80000000; without it af_alg_sendmsg() accepts any
32-bit value.

The test opens an AF_ALG AEAD request socket, sets ALG_OP_DECRYPT and
ALG_SET_AEAD_ASSOCLEN to 0x7fffffff, which must be accepted, and to
0x80000000 and 0xffffffff, which must fail with EINVAL.  It does not
call recvmsg(), so the test only depends on the control-message
validation.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 runtest/crypto                     |   1 +
 runtest/cve                        |   1 +
 testcases/kernel/crypto/.gitignore |   1 +
 testcases/kernel/crypto/af_alg09.c | 107 +++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg09.c

diff --git a/runtest/crypto b/runtest/crypto
index a8330db9f..082b906c1 100644
--- a/runtest/crypto
+++ b/runtest/crypto
@@ -6,6 +6,7 @@ af_alg05 af_alg05
 af_alg06 af_alg06
 af_alg07 af_alg07
 af_alg08 af_alg08
+af_alg09 af_alg09
 pcrypt_aead01 pcrypt_aead01
 crypto_user01 crypto_user01
 crypto_user02 crypto_user02
diff --git a/runtest/cve b/runtest/cve
index 0fe25cd83..ccd7e3db3 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -89,6 +89,7 @@ cve-2023-0461 setsockopt10
 cve-2023-31248 nft02
 cve-2023-52879 fanotify25
 cve-2026-43499 ghostlock
+cve-2026-52972 af_alg09
 cve-2026-53362 setsockopt11
 cve-2026-64600 refluxfs
 cve-2026-99999 pwnescape
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index aca016b62..e1890d975 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -6,6 +6,7 @@ af_alg05
 af_alg06
 af_alg07
 af_alg08
+af_alg09
 pcrypt_aead01
 crypto_user01
 crypto_user02
diff --git a/testcases/kernel/crypto/af_alg09.c b/testcases/kernel/crypto/af_alg09.c
new file mode 100644
index 000000000..f91c27ee5
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg09.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Test for CVE-2026-52972.
+ *
+ * Verify that the AF_ALG AEAD interface rejects an associated data length
+ * greater than or equal to 0x80000000 with EINVAL.
+ *
+ * Before kernel commit e4c06479d705 ("crypto: af_alg - Cap AEAD AD length to
+ * 0x80000000") af_alg_sendmsg() accepted any 32-bit ALG_SET_AEAD_ASSOCLEN
+ * value.
+ */
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+#include "lapi/socket.h"
+
+#define ASSOCLEN_LIMIT 0x80000000U
+#define SEND_SIZE 16
+
+static int algfd = -1;
+
+/*
+ * Send SEND_SIZE bytes with ALG_SET_AEAD_ASSOCLEN set to assoclen and
+ * ALG_SET_OP set to ALG_OP_DECRYPT.  Return the sendmsg() return value, with
+ * errno from sendmsg() preserved.
+ */
+static ssize_t send_assoclen(int reqfd, uint32_t assoclen)
+{
+	char data[SEND_SIZE] = {0};
+	char control[CMSG_SPACE(sizeof(uint32_t)) * 2];
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	struct cmsghdr *cmsg;
+	uint32_t op = ALG_OP_DECRYPT;
+
+	memset(control, 0, sizeof(control));
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_OP;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(op));
+	memcpy(CMSG_DATA(cmsg), &op, sizeof(op));
+
+	cmsg = CMSG_NXTHDR(&msg, cmsg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(assoclen));
+	memcpy(CMSG_DATA(cmsg), &assoclen, sizeof(assoclen));
+
+	return sendmsg(reqfd, &msg, 0);
+}
+
+static const uint32_t assoclens[] = {
+	0x7fffffff,
+	ASSOCLEN_LIMIT,
+	0xffffffff,
+};
+
+static void run(unsigned int i)
+{
+	int reqfd = tst_alg_accept(algfd);
+
+	if (assoclens[i] < ASSOCLEN_LIMIT) {
+		TST_EXP_VAL(send_assoclen(reqfd, assoclens[i]), SEND_SIZE,
+			"assoclen=%#x", assoclens[i]);
+	} else {
+		TST_EXP_FAIL2(send_assoclen(reqfd, assoclens[i]), EINVAL,
+			"assoclen=%#x", assoclens[i]);
+	}
+
+	SAFE_CLOSE(reqfd);
+}
+
+static void setup(void)
+{
+	algfd = tst_alg_setup("aead", "gcm(aes)", NULL, 16);
+}
+
+static void cleanup(void)
+{
+	if (algfd != -1)
+		SAFE_CLOSE(algfd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(assoclens),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e4c06479d7059888adf2f22bc1ebcf053bf691a2"},
+		{"CVE", "2026-52972"},
+		{}
+	},
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
