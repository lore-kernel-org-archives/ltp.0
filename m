Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AE8C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:37:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 737523C922B
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 03:37:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD5F53C0BA7
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:37:26 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB84D200AF3
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:37:25 +0100 (CET)
Received: by mail-yb1-xb4a.google.com with SMTP id
 d205-20020a251dd6000000b0060977416ad4so13593275ybd.16
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=cl5LTremNZzk8DR5nFJSWNIEB1OQKaewgz61mNa7uYs=;
 b=mFnOCx31n+FWdMhmRMMNn6AeXkMxwJufIyuuaK5YDWvro61mkrmldbdxK1ssfvaxxj
 D1iw9UX6jF0LuvvPIKfbyrhe6DW+l3VajtYSXwlHPYKC250QbZ/VKggp4h6kQzjjk13E
 0hPdNN0k/Nxen/HCF0y0V5ls0+I3G8MBKQgp1dPDDhqJC8otEVIYZdGR01XW48gPFX3w
 auRrTjK98iQRWMDQJtHR+U7h8y0Pkf4m9iCNegIKbLA8BzV0LTxH8Ac8IIfd1GARrYMt
 R8OBb1cMSrX14dfA/UEuJKd4Tj1x7RL+lWDkGb2YV8fn3Itq0QNz2saEzujdJXjC5Fn9
 FoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=cl5LTremNZzk8DR5nFJSWNIEB1OQKaewgz61mNa7uYs=;
 b=IqaGTit7NrEMctfKo1OZILzlYuy+4Esx08o4Pd/chNfsWQRjUHbFrGLDSxbeSERoaV
 ZjC6Me58f2Xs+vEcGdyGS3a7wEghh7J3Il02OwB7M3sxdioIPvtypr+FF5Aw32L+Xuyn
 UjqMiIF0hYN/7/Mhqi46sio2JTreVDtkK/aAm55FjIUd+GaiUA71TESX/waOJcK6xIhv
 /zANJsaMuEPeUbZQx35hb8QUr56+rOI2SKyXZ/MEqBD1w3/v1wRdTuav6pYclO40+nLV
 I7jtujP43K3erXQn1kSi1/FPxMRI+eAaBPGgJo6loZfykWxC7QMFhTWjvTWFSM5rhyyF
 nLIA==
X-Gm-Message-State: AOAM531/QczhFt2TGH1Dny5x0ZIYpzOIgOmcSX/9Z/Cpg+SrFZz611O9
 JzUNe4vZgxjxncPFA1nt4sTqVUrYdUU3JoUVGX3riT2wtAGHmpSmL5NugyUxMDtvOdEb/z7Dqv4
 E5Cemrqhb1QPlkjqDucRXHh8v5ZDbRTc+iLftVe+k5VXpcGl1Jrai1Q==
X-Google-Smtp-Source: ABdhPJxWVp+XQ48P6kBCzEmgwkN96raX6pZnynRYdFqfqo0vcZ72FuBTxda6pC0XhA6ieMcFPZwRDtY+Kw==
X-Received: from yaelt.nyc.corp.google.com
 ([2620:0:1003:415:6895:67ef:fc6:e479])
 (user=yaelt job=sendgmr) by 2002:a25:a427:: with SMTP id
 f36mr1536706ybi.245.1640054244243; 
 Mon, 20 Dec 2021 18:37:24 -0800 (PST)
Date: Mon, 20 Dec 2021 21:37:21 -0500
Message-Id: <20211221023721.129689-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
From: Yael Tiomkin via ltp <ltp@lists.linux.it>
Reply-To: Yael Tiomkin <yaelt@google.com>
Cc: linux-integrity@vger.kernel.org, Yael Tiomkin <yaelt@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test that encrypted keys can be instantiated using
both user-provided decrypted data
(https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
or kernel-generated numbers.

Signed-off-by: Yael Tiomkin <yaelt@google.com>
---

Notes:
    v -> v2: added key revocation and made styling changes.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl09.c | 58 +++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bcf3d56c9..ccea1ddbd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -643,6 +643,7 @@ keyctl05 keyctl05
 keyctl06 keyctl06
 keyctl07 keyctl07
 keyctl08 keyctl08
+keyctl09 keyctl09
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 3544ac79c..f9948c176 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -6,3 +6,4 @@
 /keyctl06
 /keyctl07
 /keyctl08
+/keyctl09
diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
new file mode 100644
index 000000000..507cd5628
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Google, Inc.
+ */
+
+/*\
+ * [Description]
+ * Test that encrypted keys can be instantiated using user-provided decrypted
+ * data (plaintext), and separately, using kernel-generated key material.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+#define ENCRYPTED_KEY_1_PAYLOAD	"new enc32 user:masterkey 32 plaintext12345678901234567890123"
+#define ENCRYPTED_KEY_2_PAYLOAD	"new enc32 user:masterkey 32"
+
+static void do_test(void)
+{
+	key_serial_t masterkey;
+	key_serial_t encryptedkey1;
+	key_serial_t encryptedkey2;
+	char buffer[128];
+
+	masterkey = add_key("user", "user:masterkey", "foo", 3,
+			    KEY_SPEC_PROCESS_KEYRING);
+	if (masterkey == -1)
+		tst_brk(TBROK | TERRNO, "Failed to add user key");
+
+	encryptedkey1 = add_key("encrypted", "ltptestkey1", ENCRYPTED_KEY_1_PAYLOAD,
+				60, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey1 == -1)
+		tst_brk(TFAIL, "Failed to instantiate encrypted key using payload decrypted data");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey1");
+
+	encryptedkey2 = add_key("encrypted", "ltptestkey2", ENCRYPTED_KEY_2_PAYLOAD,
+				27, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey2 == -1)
+		tst_brk(TFAIL,
+			"Failed to instantiate encrypted key using kernel-generated key material");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey2");
+
+	tst_res(TPASS, "Encrypted keys were successfully instantiated and read");
+
+	keyctl(KEYCTL_REVOKE, encryptedkey1);
+	keyctl(KEYCTL_REVOKE, encryptedkey2);
+	keyctl(KEYCTL_REVOKE, masterkey);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.34.1.307.g9b7440fafd-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
