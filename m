Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5568C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 15:33:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF86A3CEC4C
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 17:33:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D907B3CCC4D
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 17:33:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id EA41B1402E10
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 17:33:29 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F1B1FB;
 Wed, 25 Oct 2023 08:34:08 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com
 [10.1.194.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0613F64C;
 Wed, 25 Oct 2023 08:33:26 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 16:33:17 +0100
Message-Id: <20231025153317.2897901-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/rename10: Test long file name too
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit 5b706c4ee104 ("Provide a PATH_MAX-long buffer when expecting
ENAMETOOLONG") modified rename10 in order to prevent out-of-bound
uaccess. However, in so doing, it changed the failure mode of the
rename() syscall: instead of the path being rejected by the
filesystem, due to the file name being too long, it is now rejected
directly by the syscall handler as the path itself is too long.

This patch adds a new long_name string that triggers the "file name
too long" failure mode, while preserving the "path too long" failure
mode for long_path. Unlike the original buffer (before commit
5b706c4ee104), no out-of-bound uaccess occurs when passing long_name
to rename(), as long_name is a null-terminated string that is short
enough to be interpreted as a valid path.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

CI run: https://github.com/kevin-brodsky-arm/ltp/actions/runs/6642693217

See also: https://lore.kernel.org/ltp/20231023135647.2157030-1-kevin.brodsky@arm.com/T/#m3d1649d695faa4426f141bb1beeb3b4762ca5876

 testcases/kernel/syscalls/rename/rename10.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index 3eab4be0f913..5b5f79073e6b 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -18,7 +18,13 @@
 #define MNT_POINT "mntpoint"
 #define TEMP_FILE "tmpfile"
 
+/* Path longer than PATH_MAX: fails the syscall right away (getname() fails) */
 static char long_path[PATH_MAX + 1] = {[0 ... PATH_MAX] = 'a'};
+/*
+ * Path fitting in PATH_MAX, but with an excessively long file name: rejected
+ * by the underlying filesystem
+ */
+static char long_name[PATH_MAX] = {[0 ... PATH_MAX - 2] = 'a', [PATH_MAX - 1] = '\0'};
 
 static void setup(void)
 {
@@ -30,6 +36,8 @@ static void run(void)
 {
 	TST_EXP_FAIL(rename(TEMP_FILE, long_path),
 				ENAMETOOLONG);
+	TST_EXP_FAIL(rename(TEMP_FILE, long_name),
+				ENAMETOOLONG);
 }
 
 static struct tst_test test = {
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
