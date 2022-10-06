Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD185C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6C2C3CAE77
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 14:25:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFB0D3C0726
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 10:17:15 +0200 (CEST)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BF132001B4
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 10:17:14 +0200 (CEST)
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
 id 92303897; Thu,  6 Oct 2022 10:17:09 +0200 (CEST)
From: Nikolaus Voss <nv@vosn.de>
To: Yael Tzur <yaelt@google.com>, Cyril Hrubis <chrubis@suse.cz>,
 Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>
Date: Thu, 6 Oct 2022 08:15:55 +0200
Message-Id: <20221006081709.92303897@mail.steuer-voss.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 10 Oct 2022 14:25:33 +0200
Subject: [LTP] [PATCH] syscalls/keyctl/keyctl09.c: fix test encrypted key
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
size and adds a test with a wrong key size to trigger a corresponding
error.

This patch must be used with the kernel fix
https://lore.kernel.org/lkml/20220919072317.E41421357@mail.steuer-voss.de

test output:
~ # ./keyctl09
tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
keyctl09.c:28: TPASS: add_key("user", "user:masterkey", "foo", 3, KEY_SPEC_PROCESS_KEYRING) returned 837616982
keyctl09.c:34: TPASS: add_key("encrypted", "ltptestkey1", ENCRYPTED_KEY_PREAMBLE HEXASCII_UNENCRYPTED_DATA, strlen(ENCRYPTED_KEY_PREAMBLE HEXASCII_UNENCRYPTED_DATA), KEY_SPEC_PROCESS_KEYRING) returned 449585633
keyctl09.c:44: TPASS: keyctl(KEYCTL_READ, TST_RET, buffer, sizeof(buffer)) returned 186
[ 3031.280283] trusted_key: encrypted key: decrypted data provided must contain only hexadecimal characters
keyctl09.c:50: TPASS: add_key("encrypted", "ltptestkey2", ENCRYPTED_KEY_PREAMBLE ASCII_UNENCRYPTED_DATA, strlen(ENCRYPTED_KEY_PREAMBLE ASCII_UNENCRYPTED_DATA), KEY_SPEC_PROCESS_KEYRING) : EINVAL (22)
[ 3031.284871] trusted_key: encrypted key: decrypted data provided does not match decrypted data length provided
keyctl09.c:58: TPASS: add_key("encrypted", "ltptestkey3", ENCRYPTED_KEY_PREAMBLE SHORT_HEXASC_UNENCRYPTED_DATA, strlen(ENCRYPTED_KEY_PREAMBLE SHORT_HEXASC_UNENCRYPTED_DATA), KEY_SPEC_PROCESS_KEYRING) : EINVAL (22)

Fixes: 342e7a0dd ("syscalls/keyctl09: test encrypted keys with provided decrypted data.")
Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
---
 testcases/kernel/syscalls/keyctl/keyctl09.c | 30 +++++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
index c88c481b9..c5165a280 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl09.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -13,8 +13,13 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
-#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
-#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
+#define ENCRYPTED_KEY_PREAMBLE		"new enc32 user:masterkey 32 "
+#define SHORT_HEXASC_UNENCRYPTED_DATA	"abcdefABCDEF1234567890aaaaaaaaaa"
+#define HEXASCII_UNENCRYPTED_DATA	SHORT_HEXASC_UNENCRYPTED_DATA \
+					SHORT_HEXASC_UNENCRYPTED_DATA
+#define SHORT_ASCII_UNENCRYPTED_DATA	"plaintext123@123!123@123!123@123"
+#define ASCII_UNENCRYPTED_DATA		SHORT_ASCII_UNENCRYPTED_DATA \
+					SHORT_ASCII_UNENCRYPTED_DATA
 
 static void do_test(void)
 {
@@ -27,8 +32,11 @@ static void do_test(void)
 		return;
 
 	TST_EXP_POSITIVE(add_key("encrypted", "ltptestkey1",
-			    ENCRYPTED_KEY_VALID_PAYLOAD,
-			    60, KEY_SPEC_PROCESS_KEYRING));
+			    ENCRYPTED_KEY_PREAMBLE
+			    HEXASCII_UNENCRYPTED_DATA,
+			    strlen(ENCRYPTED_KEY_PREAMBLE
+				   HEXASCII_UNENCRYPTED_DATA),
+			    KEY_SPEC_PROCESS_KEYRING));
 
 	if (!TST_PASS)
 		return;
@@ -38,8 +46,20 @@ static void do_test(void)
 	if (!TST_PASS)
 		return;
 
+	/* key not hex-ascii encoded */
 	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey2",
-			    ENCRYPTED_KEY_INVALID_PAYLOAD, 60,
+			    ENCRYPTED_KEY_PREAMBLE
+			    ASCII_UNENCRYPTED_DATA,
+			    strlen(ENCRYPTED_KEY_PREAMBLE
+				   ASCII_UNENCRYPTED_DATA),
+			    KEY_SPEC_PROCESS_KEYRING), EINVAL);
+
+	/* key size mismatch */
+	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey3",
+			    ENCRYPTED_KEY_PREAMBLE
+			    SHORT_HEXASC_UNENCRYPTED_DATA,
+			    strlen(ENCRYPTED_KEY_PREAMBLE
+				   SHORT_HEXASC_UNENCRYPTED_DATA),
 			    KEY_SPEC_PROCESS_KEYRING), EINVAL);
 
 	keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
