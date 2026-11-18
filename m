Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA4606A31C
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=duJXCdwp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HhERhEaS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795042337; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4JE25bqx7Us7rlYG0b2rVW5xNeiJdN4DO0Zl7yHeTZE=;
 b=duJXCdwpGpo+pH0i14Aq93hx8GSdAmDecA9h33TNehZRs8LyvENrqsCxs4mwp16QovCNZ
 3D/uHlmmTKmpO3cGlh4/mJnuDecaAqBIa2Z8c6PBOb33OHrA5qNS8NxwrTs+Ow7iLKD4Jml
 YDuWr+BzVOlizCOsmUdm3YYFXLF7B/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 594273EB2DA
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 23:52:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 094903E9326
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 23:51:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 31E8810001A3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 23:51:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795042314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZZAz6b7ivgAK65ISh1uE14m1lpa8oHCjFlTBeCW23I=;
 b=HhERhEaS75m5KDjolOANnSn6anyD0ndf2lwKNhIICBI87MAJACDYJpBXPA0+SbnyOWUKMc
 DrZ6Ht+gqySE9ZaTjAINt0E/cbYmBh1Muu9gAdtPyECCeUUtFGbMZp7CxGIcSsaF3yN1FF
 yDqkXPO10bOWLLSVQOajPlMEkukYfbE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Vg6GReMtNFCRwzQjIvvhDA-1; Wed, 18 Nov 2026 17:51:52 -0500
X-MC-Unique: Vg6GReMtNFCRwzQjIvvhDA-1
X-Mimecast-MFC-AGG-ID: Vg6GReMtNFCRwzQjIvvhDA_1795042312
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55c644cea0bso30962241cf.0
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 14:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795042312; x=1795647112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZZZAz6b7ivgAK65ISh1uE14m1lpa8oHCjFlTBeCW23I=;
 b=BQbG/YB0WDYvNP/3MM/U7zEfHI4l8t77KfjGJqbbPSBrODGdmpK0UJ3+W7Zk4/+6s4
 hcpFxD4uNIVyYKK80FmQye1ij3fn+f7WKNDt/gXVbOA88mdUzi3pgTUCFdpa+48b0Je2
 SH/dyw4zNGvLU/gTYGWFYMWuiiz9We6/gVIwnC3ENRKL36N8SbEbyImWYi5RgxANsAMW
 bdHOnGe6y7vk9+2rz1TPisLC4NafXfy3N6Qcbftam9DTJm3TN2FzRIxBAmfC/wSv1uIi
 627//2uUqLOAnNbXchahVXHbpX/GBa1Ilb3EXlqIPqWfauwHcSebK+FFlkd5EyAe/w2S
 6Y6g==
X-Gm-Message-State: APuU4Z+xGSd0G8i9x0pcMopvHy7FWWtcrIOwMwumbzAP1fK/Arx3JZVz
 TH4v010fWt6W2nwf59tpMrfOAPFVLn8sKID6t1Ymghgck5rQ3Ys9VuuGyQd+v+5O+ZISCLlJkT4
 /13JIchV3D09KqTTW+lWLbQ8mTQ89mneYWlVqDcE5ai58bcJYI/0TLJKLCE9I8zQ/uk3bQqIs7V
 NQiMfHDUhBag29kuEjiDLiu/ikVgazeDFrneQM
X-Gm-Gg: AYBFou0C0ASqyBV7f9KDaOp4fcoP4lLXBAeOFO4rZSq6Y34DwusBINbj4m/ZyRX7Jxf
 nF2D+RhQa6+5oj/0guvA/dNkTQcp4YzxFL3N/2jGO4ZjBuppjvTqoWHHnOPtYqll/+0bQNJq0VJ
 1zxBTgHEr92qxPUtqWEzdp7scvBlXVYAwaoCBSeVXF17zIO5yspBLHExKduCn7QkPDr8eyXDJwW
 2M3hxdX5W4UgVD4vKp9cT8BtFvbW3kIwCFxb7/Cmh2MpITdVH0W+pCE65akMkOlF8sOB8/zpGBW
 GsvkmiB9H6YqcQKaMmwhV0sCMOJyiH2Y0HdvvtP5aNGgMzuG+DBRfGO49z4W9Aaot8BUJaCqzug
 LV0HJ/AP0fCtjCEuZ5wHZ9NPrsFU9kR+uR7WMx1jqcw2ifwu2T8PahdflBiR7sQv7bvIoPIn1Ld
 CIlUHx
X-Received: by 2002:a05:622a:a0b:b0:55c:cff6:5683 with SMTP id
 d75a77b69052e-55d5a3087d5mr64359561cf.1.1795042311599; 
 Wed, 18 Nov 2026 14:51:51 -0800 (PST)
X-Received: by 2002:a05:622a:a0b:b0:55c:cff6:5683 with SMTP id
 d75a77b69052e-55d5a3087d5mr64359181cf.1.1795042310993; 
 Wed, 18 Nov 2026 14:51:50 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.redhat.corp ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d66b75823sm10395601cf.13.2026.11.18.14.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 14:51:50 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 18 Nov 2026 17:51:43 -0500
Message-ID: <20261118225144.411166-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116150911.667095-1-sbertram@redhat.com>
References: <20261116150911.667095-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i0U-WwoyrwFqN9FYQP3MJwF8bAMQTF43HQ8aKzxV8no_1795042312
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] crypto/af_alg09: Test CVE-2026-52972
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

Since Linux 7.3, /proc/sys/crypto/af_alg_restrict defaults to 1 and bind()
of gcm(aes) fails with ENOENT. When that file exists and is writable, the
test sets it to 0 for the run and restores the previous value.

Assisted-by: Cursor:Grok-4.7
Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 runtest/crypto                     |   1 +
 runtest/cve                        |   1 +
 testcases/kernel/crypto/.gitignore |   1 +
 testcases/kernel/crypto/af_alg09.c | 112 +++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
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
index 000000000..423eee431
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg09.c
@@ -0,0 +1,112 @@
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
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/crypto/af_alg_restrict", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e4c06479d7059888adf2f22bc1ebcf053bf691a2"},
+		{"CVE", "2026-52972"},
+		{}
+	},
+};
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
