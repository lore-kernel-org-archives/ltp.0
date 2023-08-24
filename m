Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C79C3DA6F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 06:22:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545063CC4B8
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 08:22:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A734E3CC48D
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:22:28 +0200 (CEST)
Received: from smtp.priv.miraclelinux.com
 (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5ECC1140075B
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:22:26 +0200 (CEST)
Received: from localhost.localdomain (21A0035i-SL7B460.priv.miraclelinux.com
 [10.2.1.161])
 by smtp.priv.miraclelinux.com (Postfix) with ESMTP id E4670140052;
 Thu, 24 Aug 2023 15:22:19 +0900 (JST)
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 15:12:18 +0900
Message-Id: <d83140dc8ddd7aec2458061e283bd9fb4fbe73ca.1692857370.git.souta.kawahara@miraclelinux.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f8c3549f405479aa521dd654c105a2ba8d4d6f36.1692839061.git.souta.kawahara@miraclelinux.com>
References: <f8c3549f405479aa521dd654c105a2ba8d4d6f36.1692839061.git.souta.kawahara@miraclelinux.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] fix broken example code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is double definition of 'test'.
Fixed it.
Also Fixed example code for the same function described after that.

Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
---
 doc/c-test-api.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index e4e88edec..2ad841038 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -36,7 +36,7 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "setenv() failed");
 }
 
-static void test(void)
+static void run(void)
 {
 	char *ret;
 
@@ -64,7 +64,7 @@ next:
 }
 
 static struct tst_test test = {
-	.test_all = test,
+	.test_all = run,
 	.setup = setup,
 };
 -------------------------------------------------------------------------------
@@ -257,7 +257,7 @@ value and errno and reports the test result.
 
 [source,c]
 -------------------------------------------------------------------------------
-static void test(void)
+static void run(void)
 {
 	...
 	TST_EXP_PASS(stat(fname, &statbuf), "stat(%s, ...)", fname);
@@ -278,7 +278,7 @@ begin with a format string and then appropriate values to be formatted.
 
 [source,c]
 -------------------------------------------------------------------------------
-static void test(void)
+static void run(void)
 {
 	...
 	TST_EXP_FD(open(fname, O_RDONLY), "open(%s, O_RDONLY)", fname);
@@ -294,7 +294,7 @@ positive integer is returned.
 
 [source,c]
 -------------------------------------------------------------------------------
-static void test(void)
+static void run(void)
 {
 	...
 	TST_EXP_FAIL(stat(fname, &statbuf), ENOENT, "stat(%s, ...)", fname);
@@ -308,7 +308,7 @@ passed as the second argument.
 
 [source,c]
 -------------------------------------------------------------------------------
-static void test(void)
+static void run(void)
 {
 	...
 	TST_EXP_FAIL2(msgget(key, flags), EINVAL, "msgget(%i, %i)", key, flags);
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
