Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34017C46467
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 00:27:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 671703CCB71
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 01:27:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10B673CB560
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 15:23:21 +0100 (CET)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EB5F200A01
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 15:23:20 +0100 (CET)
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
 id A0DBECA25; Wed, 11 Jan 2023 15:23:16 +0100 (CET)
From: Nikolaus Voss <nikolaus.voss@haag-streit.com>
To: Yael Tzur <yaelt@google.com>, Cyril Hrubis <chrubis@suse.cz>,
 Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>, nv@vosn.de
Message-Id: <20230111142316.A0DBECA25@mail.steuer-voss.de>
Date: Wed, 11 Jan 2023 15:23:16 +0100 (CET)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 12 Jan 2023 01:27:39 +0100
Subject: [LTP] [PATCH v2] syscalls/keyctl/keyctl09.c: fix test encrypted key
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit fixes the test for adding encrypted keys with unencrypted data.
Unencryted data must be provided hex-ascii encoding. Due to a kernel
bug, the unencypted data was not decoded to binary thus the length of
the key was only half the specified key size. This patch doubles the key
size.

Fixes: 342e7a0dd ("syscalls/keyctl09: test encrypted keys with provided decrypted data.")
Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
---
v2: add linux-git tag for kernel fix, only correct test input data

 testcases/kernel/syscalls/keyctl/keyctl09.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
index c88c481b9..cfd5f7e5f 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl09.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -13,8 +13,8 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
-#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
-#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
+#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa"
+#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123plaintext123@123!123@123!123@123"
 
 static void do_test(void)
 {
@@ -28,7 +28,8 @@ static void do_test(void)
 
 	TST_EXP_POSITIVE(add_key("encrypted", "ltptestkey1",
 			    ENCRYPTED_KEY_VALID_PAYLOAD,
-			    60, KEY_SPEC_PROCESS_KEYRING));
+			    strlen(ENCRYPTED_KEY_VALID_PAYLOAD),
+			    KEY_SPEC_PROCESS_KEYRING));
 
 	if (!TST_PASS)
 		return;
@@ -39,7 +40,8 @@ static void do_test(void)
 		return;
 
 	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey2",
-			    ENCRYPTED_KEY_INVALID_PAYLOAD, 60,
+			    ENCRYPTED_KEY_INVALID_PAYLOAD,
+			    strlen(ENCRYPTED_KEY_INVALID_PAYLOAD),
 			    KEY_SPEC_PROCESS_KEYRING), EINVAL);
 
 	keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
@@ -50,5 +52,9 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_DECRYPTED_DATA=y",
 		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{ "linux-git", "5adedd42245af"},
+		{}
 	}
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
