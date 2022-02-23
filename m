Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD4EC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 20:08:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D79EB3C9741
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 21:08:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210883C9741
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 21:07:58 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FAF360066D
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 21:07:58 +0100 (CET)
Received: by mail-yb1-xb49.google.com with SMTP id
 z15-20020a25bb0f000000b00613388c7d99so28760987ybg.8
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=AgH7G9qMhJjeNsK8pjjl8l2MFRb6uv/e5h3RVBpFjcM=;
 b=lEvoTqPckwkesDmoXXT2GU4qtC9d2HvwvztmcK6sCsocVzbXr1YMGxD6/mvWS1AT8n
 vrAj3qUZyCWQtRz+GH6DCGKDjzKqWWCr514C7f1glIUX1IMwosvkkc3zLLIhRNV6QBFP
 bW5xTzchMMN272yNx+6+qqYkJZ1+9q2C9v9YZWE6dRmh0tHRUfq7Hjq0aFlS8eLOf/fG
 FptCf0nuWlZdwAHvPaZdPXkvCHkhyYOT6pqwP+OXD02DS48QYGRJKUIiHaOIbT4Jo3j+
 s8V8U6fykVUYTktsP6M9ZSPjodnr43ATUTNXP/97MHKdVcr0OsBIWtcfjT/aJt4yDVmU
 SWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=AgH7G9qMhJjeNsK8pjjl8l2MFRb6uv/e5h3RVBpFjcM=;
 b=JUFjNuw8eNts93zFXzJHDmyff1Jph162ZO1iG2y/UV31WMEbFYu5s1NayLpcucK7bZ
 /zoATHVXVtjqjO4PRAw5Z5iKY3EFOWElN5lTkwGeki4BaWyXnBXOGzd3ISs4Ht3sjJ6P
 w6cgHS/KkyFI9QWFG79P7mo2vyYnaMEmt97kHCt6kWH6rhTVCpA3V0/5ZrWoh6SdcMRV
 2+HkBi9XMR7cj8YKDR4FbSKjbGx1LJPR0WmiXqhCY4pOWDXsKOCDwEVyd6+f3fOWCaDG
 Uz9md7053jT9/Wq4BcV0ZyYe5CtBTeoaIxnfZI9rSeLX9Hm9e3Era4rI218dx11nP+Rx
 nUaA==
X-Gm-Message-State: AOAM530GIRaIZcQP93sUt5l5B3IIolqoPn19Oa7dpmSlDKIW8qah/vTa
 AOAMyJtxCFj6bFZpNfWnf+4F6k80XPfmJ5N2HuknD+JpEplSVrjbwqMkyZMCJXtxlQYX6I9WohB
 2qAi0+F8Yx7ZqPXRgblqX4yUQtQDzPU2rzgL0ZmP/RgbqxLI7G37LSA==
X-Google-Smtp-Source: ABdhPJzAzVL/jgyTyMBdgt10LBLSTNS2DA2lnFUL+O5dsWAxDcT8sK2SlRfFIRynAKemi0S1vNd4CagGZA==
X-Received: from yaelt.nyc.corp.google.com
 ([2620:0:1003:415:fdfb:5043:291f:63ca])
 (user=yaelt job=sendgmr) by 2002:a81:2450:0:b0:2d6:aee8:f0d5 with SMTP id
 k77-20020a812450000000b002d6aee8f0d5mr1248279ywk.81.1645646877043; Wed, 23
 Feb 2022 12:07:57 -0800 (PST)
Date: Wed, 23 Feb 2022 15:07:31 -0500
Message-Id: <20220223200731.1859670-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
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
    
    v3 -> v4: made styling changes.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl09.c | 53 +++++++++++++++++++++
 3 files changed, 55 insertions(+)
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
index 000000000..71fc2f2a9
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,53 @@
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
+#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
+#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
+
+static void do_test(void)
+{
+	char buffer[128];
+
+	TST_EXP_POSITIVE(add_key("user", "user:masterkey", "foo", 3,
+			    KEY_SPEC_PROCESS_KEYRING));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_POSITIVE(add_key("encrypted", "ltptestkey1",
+			    ENCRYPTED_KEY_VALID_PAYLOAD,
+			    60, KEY_SPEC_PROCESS_KEYRING));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_POSITIVE(keyctl(KEYCTL_READ, TST_RET, buffer, sizeof(buffer)));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey2",
+			    ENCRYPTED_KEY_INVALID_PAYLOAD, 60,
+			    KEY_SPEC_PROCESS_KEYRING), EINVAL);
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
