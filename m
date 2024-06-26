Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB3BC27C4F
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 10:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57BA63D1159
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 12:55:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9F523CBDBB
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 12:54:44 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AEDE71402E24
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 12:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719399282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O4qkCOGD0TUlTRgQJeqywpEoGDKlc957rTTXdJRQwdc=;
 b=JIF/tDVxoarIn5mYJz79m/MC9qzBxDv4v61Cf7DK+QXRcqLbB51aBCgzAiw/GAiWV0qXx1
 Y0kaYNoNHV5YysSSODXu15IvBxovo7HRR5pBxLz+wygMQ1gBmntDzd4SZGFdYPu23tgwOU
 HE4whNpSOMSLp6PtyyL6cY6vmSTduTs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-4zSt3QDpMgmMircdjr7aHQ-1; Wed,
 26 Jun 2024 06:54:39 -0400
X-MC-Unique: 4zSt3QDpMgmMircdjr7aHQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F6E19560BC
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 10:54:38 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 479691956050
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 10:54:36 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 26 Jun 2024 18:54:30 +0800
Message-ID: <20240626105431.746411-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/2] lib: add TST_RES_ serious macros
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

This patch introduces new macros to encapsulate existing tst_res and
tst_brk functions in the LTP library. These macros simplify the usage
of tst_ functions by providing a more user-friendly interface for
generating standardized test output.

  TST_RES_TINFO()    -> tst_res(TINFO, ...)
  TST_RES_TWARN()    -> tst_res(TINFO, "WARNING: ", ...)
  TST_RES_TPASS()    -> tst_res(TPASS, ...)
  TST_RES_TDEBUG()   -> tst_res(TDEBUG, ...)
  TST_RES_TFAIL()    -> tst_res(TFAIL,  ...)

  TST_BRK_TCONF()    -> tst_brk(TCONF, ...)
  TST_BRK_TBROK()    -> tst_brk(TBROK,  ...)

  TST_RES_TPASS_ER() -> tst_res(TPASS | errno, ...)
  TST_RES_TFAIL_ER() -> tst_res(TFAIL | errno, ...)
  TST_BRK_TBROK_ER() -> tst_brk(TBROK | errno, ... )

The macros handle various scenarios including simple messages and messages
with error flags, ensuring consistent logging of file and line information.

Additionally, a new test case in tst_res_macros.c demonstrates the usage
of these macros.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    At the begining I wanted to implement one macro to implement functionality
    like handling both messages and printing errno with the message. Still,
    after trying some complex macro definition usages I found that this made
    things too complex and confusing, so why not define more macros for special
    use, and then this patch was signed.
    
    Maybe something like TST_RES_TFAIL_ER is not a good name, but please help to
    give another, or any advise will be appreciated.

 include/tst_test_macros.h         | 34 +++++++++++++++++++++
 lib/newlib_tests/tst_res_macros.c | 50 +++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 lib/newlib_tests/tst_res_macros.c

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 22b39fb14..e36df9c0d 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -368,4 +368,38 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
 		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
+/* Test result print macros */
+#define TST_RES_TINFO(MESSAGE, ...) \
+	tst_res(TINFO, MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TCONF(MESSAGE, ...) \
+	tst_res(TCONF, MESSAGE, ##__VA_ARGS__)
+
+#define TST_BRK_TCONF(MESSAGE, ...) \
+	tst_brk(TCONF, MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TWARN(MESSAGE, ...) \
+	tst_res(TINFO, "WARNING: "MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TPASS(MESSAGE, ...) \
+	tst_res(TPASS, MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TPASS_ER(flag, MESSAGE, ...) \
+	tst_res(TPASS | flag, MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TDEBUG(MESSAGE, ...) \
+	tst_res(TDEBUG, MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TFAIL(MESSAGE, ...) \
+	tst_res(TFAIL, MESSAGE, ##__VA_ARGS__)
+
+#define TST_RES_TFAIL_ER(flag, MESSAGE, ...) \
+	tst_res(TFAIL | flag, MESSAGE, ##__VA_ARGS__)
+
+#define TST_BRK_TBROK(MESSAGE, ...) \
+	tst_brk(TBROK, MESSAGE, ##__VA_ARGS__)
+
+#define TST_BRK_TBROK_ER(flag, MESSAGE, ...) \
+	tst_brk(TBROK | flag, MESSAGE, ##__VA_ARGS__)
+
 #endif	/* TST_TEST_MACROS_H__ */
diff --git a/lib/newlib_tests/tst_res_macros.c b/lib/newlib_tests/tst_res_macros.c
new file mode 100644
index 000000000..74b656da0
--- /dev/null
+++ b/lib/newlib_tests/tst_res_macros.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Li Wang <liwang@redhat.com>
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int i = 10, j = 20;
+	char *str = "test";
+
+	TST_RES_TINFO("message");
+	TST_RES_TINFO("message, i = %d", i);
+	TST_RES_TDEBUG("message, i = %d", i);
+
+	TST_RES_TPASS("message");
+	TST_RES_TPASS("message, i = %d, j = %d, str = %s", i, j, str);
+	TST_RES_TPASS_ER(TTERRNO, "message, i = %d, j = %d", i, j);
+
+	TST_RES_TWARN("message");
+	TST_RES_TWARN("message, i = %d", i);
+
+	TST_RES_TFAIL("message");
+	TST_RES_TFAIL("message, i = %d, j = %d", i, j);
+
+	TST_RES_TFAIL_ER(TERRNO, "message");
+	TST_RES_TFAIL_ER(TERRNO, "message, i = %d, j = %d", i, j);
+	TST_RES_TFAIL_ER(TERRNO, "message, i = %d, str = %s", i, str);
+
+	TST_RES_TFAIL_ER(TTERRNO, "message");
+	TST_RES_TFAIL_ER(TTERRNO, "message, i = %d", i);
+	TST_RES_TFAIL_ER(TTERRNO, "message, i = %d, str = %s", i, str);
+
+	TST_BRK_TBROK("message");
+	TST_BRK_TBROK("message, i = %d, j = %d", i, j);
+
+	TST_BRK_TBROK_ER(TERRNO, "message");
+	TST_BRK_TBROK_ER(TERRNO, "message, i = %d, str = %s", i, str);
+
+	TST_BRK_TBROK_ER(TTERRNO, "message");
+	TST_BRK_TBROK_ER(TTERRNO, "message, i = %d", i);
+	TST_BRK_TBROK_ER(TTERRNO, "message, i = %d, str = %s", i, str);
+
+	TST_BRK_TCONF("message, i = %d, j = %d, str = %s", i, j, str);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
