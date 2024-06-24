Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B82C2BBCA
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 01:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16FCB3D0F77
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 03:54:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0F4D3CFA21
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 03:53:50 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=52.59.177.22; helo=smtpbgeu1.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB7B41A00342
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 03:53:47 +0200 (CEST)
X-QQ-mid: bizesmtpsz2t1719194023tn0ldf3
X-QQ-Originating-IP: Cbh/35r62Eg0uBKO1h9kbqFrJPM+o/Lmg3oFl/150Ik=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Jun 2024 09:53:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8612894369545595741
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 24 Jun 2024 09:52:45 +0800
Message-Id: <20240624015245.54968-2-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240624015245.54968-1-lufei@uniontech.com>
References: <20240606065506.1686-1-lufei@uniontech.com>
 <20240624015245.54968-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] acct01: add EFAULT errno check.
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
Reply-To: pvorel@suse.cz
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add EFAULT errno check in acct01 testcase.

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/acct/acct01.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 1b53a32f2..ed1817bc5 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -33,6 +33,7 @@
 #define FILE_TMPFILE		"./tmpfile"
 #define FILE_ELOOP		"test_file_eloop1"
 #define FILE_EROFS		"ro_mntpoint/file"
+#define FILE_EFAULT		"/tmp/invalid/file/name"
 
 static struct passwd *ltpuser;
 
@@ -45,6 +46,7 @@ static char *file_eloop;
 static char *file_enametoolong;
 static char *file_erofs;
 static char *file_null;
+static char *file_efault;
 
 static void setup_euid(void)
 {
@@ -56,6 +58,16 @@ static void cleanup_euid(void)
 	SAFE_SETEUID(0);
 }
 
+static void setup_emem(void)
+{
+	file_efault = SAFE_MMAP(NULL, 1, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+}
+static void cleanup_emem(void)
+{
+	SAFE_MUNMAP(file_efault, 1);
+}
+
 static struct test_case {
 	char **filename;
 	char *desc;
@@ -72,6 +84,7 @@ static struct test_case {
 	{&file_eloop,   FILE_ELOOP,   ELOOP,        NULL, NULL},
 	{&file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
 	{&file_erofs,   FILE_EROFS,   EROFS,        NULL, NULL},
+	{&file_efault,	FILE_EFAULT,  EFAULT,  setup_emem, cleanup_emem},
 };
 
 static void setup(void)
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
