Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB3606A332
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Iaolgp4C;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WHETyQC/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794599234; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=tJfGRdtvdONDkYpClzzM25OV2rza7wfbyiixKdPQuLI=;
 b=Iaolgp4Cyo9l5NZUTUxgZFuTqs3ZG8J0JARQ4Mu5NGp9HNQKdTjubY1/SigeYOSYoGbOW
 RLJ2LQ1wweXb3qYFjz0enJbJmILUUMmKn4dFTp5HoB9j4R4Af53Hr6p7wddA2kh3J9q9yzf
 JzFwAn9yLnDWL54TgJbqtz5689nGfw4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 245EB3EA090
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 20:47:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B47E93EA06C
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 20:46:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D9A7600BE9
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 20:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794599209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6RYZatkCaDrS6/UrHw9VYiTqAbbZVCVGq+itTHPZ6H0=;
 b=WHETyQC/4m8i8pyl9P94X20p17KSAE5P+GqdyHGYC0xrU83Vq1mNCnxPadXwdkvdyszRO+
 XFolQOh4gq0XnmN9mwLJZw/4Tawf9/iW6eBn79bGaGl9v9XHHfou5iTJyI2rPnuuNP9x9a
 wjnMkrlQQsmOVoU7rsOVJVvWL+Y9shk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-eMHUv6sBM8W_od1TtiyzSg-1; Fri, 13 Nov 2026 14:46:47 -0500
X-MC-Unique: eMHUv6sBM8W_od1TtiyzSg-1
X-Mimecast-MFC-AGG-ID: eMHUv6sBM8W_od1TtiyzSg_1794599207
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf7856ffso283979985a.3
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 11:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599207; x=1795204007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6RYZatkCaDrS6/UrHw9VYiTqAbbZVCVGq+itTHPZ6H0=;
 b=l92QnUWViHIiMZyHr892Z50ycXrvGRGqoR6vDf3Uv9RVoiIHvlsP6T6pmsDsrPhIFO
 UoIsw4qWlHIWeaizqI0ARiayNDbFKv04dOw7CuhJVZPTSHbqwegTetWgZmiIOvZK8l+u
 jsOTABiLD8EmyNM1Wnc+o0OXiUVL2da5l1YqlJIF+zNzZ0gZ01MfEe//dBuk/6f9RAcg
 TZayGBKE/9jdQE+cA1nJKo6/EWa+MGkv2ko8iBjui72HPdb2WJDCEQnKBZoem90vt4l7
 qDeftP2IBqcdYEQziU+5yK9IUcXgRbZ4oJI4laX8ijHWT/OPxTqXidnsKZGmtBN0OA/7
 UePw==
X-Gm-Message-State: APuU4Z95s+auhpHf9fM0zq5S1ptlnvZ+TeHA/E59OXvjtng2MreNyeku
 n7+soOIg4LdR0tHfMkoq/fB9lFQqHmVQMOGS+CftqB/Hy6Z06FFIuJngg/SlbxvRWDv50HYg9iS
 7H3z3lAWJoInpFHmhn51YQXC3mX18nwy14WFaa4in2iubqBH1C8+7Cgc+TpnmkYkMGfMNXNe+2t
 jKjMqhZrbOYoHZmvqyZFwI4i2G2948ziDvOJwj
X-Gm-Gg: AYBFou1I59m54pZirCCdmQEeJdtgRpP6tEVg/zJy/Vs/7TYYRDERfjMMfdib2pTEp35
 8vfCSOHwIJvgYGI99DPRfnReVRSLpsQ8qddVkOr3aYVwQkyQLJFYCGAbV5MZIb9mi9rZW1VC6JS
 3VonY+22oKuJmL/JK1/887/zCl25LHEH/f7y6mw1/SfHWA9nCkUfEuqXRuQSOXMIIYGkupVb2EH
 F16KPTUAaOQF2JvkOT7krJ06uKyIPAub1n5Fwe4TcQhzfL/2+bKfVcCPn9SjxzMwX2VdkClA/Hp
 M9ZJSeCcjmAM8yMhkUHK5/NZEL5ARaZUuW4OHpqAEsoqtay4AO0NgPGGgTYZut/cUI2OtsoGu6d
 w7cZ1UkrzbWJXam3Uixu4trGw64ERxfRJYDGt27iQcCv2Wc/zAQ7tPPBEK6lJZNUBO4vF8sqoUQ
 ==
X-Received: by 2002:a05:620a:2843:b0:93e:d051:8f19 with SMTP id
 af79cd13be357-9494bc18a88mr608694685a.40.1794599206974; 
 Fri, 13 Nov 2026 11:46:46 -0800 (PST)
X-Received: by 2002:a05:620a:2843:b0:93e:d051:8f19 with SMTP id
 af79cd13be357-9494bc18a88mr608691185a.40.1794599206365; 
 Fri, 13 Nov 2026 11:46:46 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.csb ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c439ea1sm259351085a.0.2026.11.13.11.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:46:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 14:46:30 -0500
Message-ID: <20261113194640.2925318-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ypfjW3IIjy3YnK1N5RlRqRyHoGYeDznBQ2qPg79KUuU_1794599207
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] crypto/af_alg09: Test CVE-2026-52972
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
 testcases/kernel/crypto/.gitignore |   1 +
 testcases/kernel/crypto/af_alg09.c | 131 +++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
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
index 000000000..4c3f13270
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg09.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Test for CVE-2026-52972.
+ *
+ * [Description]
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
+static void run(void)
+{
+	static const uint32_t assoclens[] = {
+		0x7fffffff,
+		ASSOCLEN_LIMIT,
+		0xffffffff,
+	};
+	size_t i;
+	int reqfd;
+
+	for (i = 0; i < ARRAY_SIZE(assoclens); i++) {
+		reqfd = tst_alg_accept(algfd);
+
+		TEST(send_assoclen(reqfd, assoclens[i]));
+
+		if (assoclens[i] < ASSOCLEN_LIMIT) {
+			if (TST_RET == SEND_SIZE) {
+				tst_res(TPASS, "sendmsg() accepted assoclen=%#x",
+					assoclens[i]);
+			} else if (TST_RET < 0) {
+				tst_res(TFAIL | TTERRNO,
+					"sendmsg() failed for valid assoclen=%#x",
+					assoclens[i]);
+			} else {
+				tst_res(TFAIL,
+					"sendmsg() returned %ld for valid assoclen=%#x",
+					TST_RET, assoclens[i]);
+			}
+		} else if (TST_RET >= 0) {
+			tst_res(TFAIL, "sendmsg() accepted assoclen=%#x",
+				assoclens[i]);
+		} else if (TST_ERR != EINVAL) {
+			tst_res(TFAIL | TTERRNO,
+				"sendmsg() failed for assoclen=%#x with unexpected error",
+				assoclens[i]);
+		} else {
+			tst_res(TPASS, "sendmsg() rejected assoclen=%#x with EINVAL",
+				assoclens[i]);
+		}
+
+		SAFE_CLOSE(reqfd);
+	}
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
+	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e4c06479d7059888adf2f22bc1ebcf053bf691a2"},
+		{"CVE", "2026-52972"},
+		{}
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
