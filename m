Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54DCC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:40:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62F513C8FC1
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 10:40:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3706F3C2FA4
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 03:18:20 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 47614201DD0
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 03:18:20 +0100 (CET)
Received: by mail-yb1-xb4a.google.com with SMTP id
 y125-20020a25dc83000000b005c2326bf744so1852223ybe.21
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 18:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=pR+fjBVeHG+Dz5BWpaT9e03Wce0EIRy1MQ2NNyLJbHA=;
 b=fbBiF4or7qS7Z6ZEnhelyPWq7ciS54XuEki/bsr1s3zu7JSoMHwX2dJMNwdRwKPcy+
 D+cgumSnvyI6bJ3dOo12zLL+oNZP6OkPTLBRP4ruzO0mO93t2KhocL3ha4GX13CrKAOL
 hHbELr2ac/wWSCywQYE6xkiEyb6ECrL6k6oS0OQ8BxtR9f0pryKfSo3O0F3rRggafAiP
 2sSUsj7kO5+UJRokE4w8ydsWNn23hax4FCVMEcdc/tTr7iLsrq93DRX+FpMWnZOUD3tb
 OoX8kVnQ+w8b1H7I5Y/MAlHu53y/6Nu3MHUZHtavnBxtpCVjsOXHjlDQAk/i/ARDBUJk
 nUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=pR+fjBVeHG+Dz5BWpaT9e03Wce0EIRy1MQ2NNyLJbHA=;
 b=zdedmL5Unmm1NrWpc+IT2QPnTFsK8IkJFn2z2tnczYJcV0sXHYTp6s7k4p/nO35EON
 IX5fAZGQSrl5zPDLid2wC/ynldR8l0LEtVbX9LneZO0fCR2tIAZYbpcFf9gU6zDExqW3
 PpUMrxzb/s2yYaqcVg8qU1q0jsHSHGAqFpSEcq1DiGsV1G0nSCliziDf4RQyDWsI9YNs
 kHwY8ZfEcQMhGMBXU90SK0C+OR9hDjlZYz0uRXv3xqnTjmuKiLvWEeMBgCoqhe1Y2Fm8
 vBwmOzsne2KRMzRbaIBs3F3GXpJGgEDMgM8UXCzmT/c0Rb86SWLPkCJ73rpyqOg+K+Jc
 OGKA==
X-Gm-Message-State: AOAM533XluZKOo6u36DKYvyLZkO6n+2QyFpPAYMR7Q3L3x6wh9+0SwAG
 7CaOFDEiJxgF/7G/TIu5TRO13AfCwxVjHSROMiFDJy9FN3fgHMlF0t0cJ1KSS9JqjIaPRDdEYpU
 0J4li/UAxNXfUFcxfERBph6TxMx4H5H7ju+g5SFbCbYc0ZAT0t33giA==
X-Google-Smtp-Source: ABdhPJyI65wYsFsZsazdtJWtk2ZwdrYbfZjCAODHe/2Qn4zJDVaFqUkU/WCE8Sq/+Dorh6R073GRNX5QZw==
X-Received: from yaelt.nyc.corp.google.com
 ([2620:0:1003:415:7c73:1d86:25c1:77e5])
 (user=yaelt job=sendgmr) by 2002:a25:9849:: with SMTP id
 k9mr1414250ybo.728.1639707498968; 
 Thu, 16 Dec 2021 18:18:18 -0800 (PST)
Date: Thu, 16 Dec 2021 21:17:26 -0500
Message-Id: <20211217021726.2487455-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 17 Dec 2021 10:40:25 +0100
Subject: [LTP] [PATCH] syscalls/keyctl09: test encrypted keys.
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
 testcases/kernel/syscalls/keyctl/keyctl09.c | 50 +++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl09.c

diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
new file mode 100644
index 000000000..4589ef367
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Google, Inc.
+ */
+
+/*
+ * Description: This tests that encrypted keys can be instantiated using
+ * user-provided decrypted data (plaintext), and separately, using
+ * kernel-generated key material.
+ */
+
+#include <errno.h>
+#include <stdint.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static void do_test(void)
+{
+	key_serial_t masterkey;
+	key_serial_t encryptedkey1;
+	key_serial_t encryptedkey2;
+	char buffer[128];
+
+	masterkey = add_key("user", "user:masterkey", "foo", 3, KEY_SPEC_PROCESS_KEYRING);
+	if (masterkey == -1)
+		tst_brk(TBROK | TERRNO, "Failed to add user key");
+
+	encryptedkey1 = add_key("encrypted", "ltptestkey1", "new enc32 user:masterkey 32 plaintext12345678901234567890123", 60, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey1 == -1)
+		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using payload decrypted data");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey1");
+
+	encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32 user:masterkey 32", 27, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey2 == -1)
+		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using kernel-generated key material");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey2");
+
+	tst_res(TPASS, "Encrypted keys were successfully instantiated and read");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.34.1.173.g76aa8bc2d0-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
