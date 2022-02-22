Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41882C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 18:11:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28153C0E9D
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 19:11:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8A183C0E9D
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 19:10:57 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B22860042F
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 19:10:57 +0100 (CET)
Received: by mail-yb1-xb49.google.com with SMTP id
 w1-20020a05690204e100b006244315a721so13522172ybs.0
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=I13G/NGnXK2R+yMCHPeUw1HIDrFT/dYlk/r65ZQP80k=;
 b=AFW4G5Vozy99N1QGPrwAymuPpido6XEARzIXCKz2GBhuRaDW2bCkbmtAp5yP0HAsFL
 ZQNt5WtaAEVGXac3sMhrHuksQDDS2tbW46vD8wygGUpwDMX6EBGio12uB4/5+SzW++V1
 vPOMl0vCo+7vl5BiuZ5KCn07XN80pND6kNnnC1q+CDVwRszhN1Wt32w0u5EGKoCmRsa4
 HGcGwRakPog2QwpHrfkL0H5jl+c/4+ydcURg/fz58lejnl+N7njwX3k0oY+jlGlT+IpI
 NG3oWvd+tcYKxnsyH9hLyf0JFVG4WKyvwTPVnsXGtevb35lKA1hRftjp+QebLJtTSLk9
 IYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=I13G/NGnXK2R+yMCHPeUw1HIDrFT/dYlk/r65ZQP80k=;
 b=swgSV7dtt7VhxpJ+j7tvlW7ozNVXA8u3b76ZIoNtVe7A0Nmwsyzxgg/gwXrhR0TOP0
 cggxpF8Zg//slijix6ScjwKU34d8Jvvwbk48powATGu2K89qsMNnLeXtSCY/tOYyu9hM
 q1Vhmep8d0Pgh0ssDoqF2i+4xJF671uqIgRjDZ9xuVDHDnDO8o+qs/15xH+hb1WROicq
 xoYCyxa9x1eLEkvuH30Yq54dA/oq/Gh6zM0x+23EK9738O0Dqr2wXfYzMG1bhIwVjEWg
 UdjT4Bby6TiZAJ1zKfn00NU63ZfR/+X5sTg3yfxNclPdSY6x6bMCcPAmp9IVBkpWKvol
 siVA==
X-Gm-Message-State: AOAM532KbguVcAQO+2l82sViZF7xxZJu1ZtdguiwmfB+KBjk3ljkEVBU
 MRTa6eV3SR2vFKd+4dlJfuKr6vWbWaBoDSkwpgstwxUfujlJNAsTzCb7q9G5MMJJR4qCqqtVWCX
 Buf6CP/2qY3WLq7xHC1mgwWuaRzTeQKLi8ZPhpUteq3Gqz3xDcdQT5Q==
X-Google-Smtp-Source: ABdhPJysP0JS7CSF/8hrjD15N4FHwwa7jB6FWJNu6UWctDUQyU201t8H935zFfUUhiRYi+IZNQdQqx7BEw==
X-Received: from yaelt.nyc.corp.google.com
 ([2620:0:1003:415:7f1a:cf67:32ef:c972])
 (user=yaelt job=sendgmr) by 2002:a5b:7c6:0:b0:60b:a0ce:19b with SMTP id
 t6-20020a5b07c6000000b0060ba0ce019bmr23928108ybq.407.1645553455362; Tue, 22
 Feb 2022 10:10:55 -0800 (PST)
Date: Tue, 22 Feb 2022 13:10:34 -0500
Message-Id: <20220222181034.1005633-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
From: Yael Tzur via ltp <ltp@lists.linux.it>
Reply-To: Yael Tzur <yaelt@google.com>
Cc: linux-integrity@vger.kernel.org, Yael Tzur <yaelt@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test that encrypted keys can be instantiated using hex-ascii
encoded user-provided decrypted data.
(https://lore.kernel.org/lkml/20220215141953.1557009-1-yaelt@google.com/).

Signed-off-by: Yael Tzur <yaelt@google.com>
---

Notes:
    v -> v2: added key revocation and made styling changes.
    
    v2 -> v3: updated per latest kernel patch version.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl09.c | 55 +++++++++++++++++++++
 3 files changed, 57 insertions(+)
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
index 000000000..5d90a6a8d
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Google, Inc.
+ */
+
+/*\
+ * [Description]
+ * Test that encrypted keys can be instantiated using user-provided decrypted
+ * data that is hex-ascii encoded.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+#define ENCRYPTED_KEY_1_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
+#define ENCRYPTED_KEY_2_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
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
+				60, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey2 != -1)
+		tst_brk(TFAIL, "Instantiation of encrypted key using non hex-encoded decrypted data unexpectedly succeeded");
+
+	tst_res(TPASS, "Encrypted keys were instantiated with decrypted data as expected");
+
+	keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_DECRYPTED_DATA=y",
+		NULL
+	}
+};
-- 
2.35.1.473.g83b2b277ed-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
