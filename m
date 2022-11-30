Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED46C4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:37:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2B003CC533
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:37:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AE973CC50C
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:37:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 4C7E01A00985
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:37:05 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D1AF1042;
 Wed, 30 Nov 2022 05:37:10 -0800 (PST)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72BE3F73D;
 Wed, 30 Nov 2022 05:37:02 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 30 Nov 2022 13:36:17 +0000
Message-Id: <20221130133619.632073-2-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130133619.632073-1-tudor.cretu@arm.com>
References: <20221130133619.632073-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] syscalls/f{get,
 set}xattr: Don't pass a pointer to mode argument in open
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

Passing NULL to open as the mode parameter is undefined behaviour
as a mode_t is a numerical type, not compatible with a pointer type.
If neither O_CREAT nor O_TMPFILE is specified in flags, then the mode
argument is ignored, so just remove it in these cases.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/fgetxattr/fgetxattr01.c | 2 +-
 testcases/kernel/syscalls/fgetxattr/fgetxattr02.c | 2 +-
 testcases/kernel/syscalls/fgetxattr/fgetxattr03.c | 2 +-
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c | 2 +-
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
index 35c46a1c3..52e6e44ab 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
@@ -111,7 +111,7 @@ static void setup(void)
 	size_t i = 0;
 
 	SAFE_TOUCH(FNAME, 0644, NULL);
-	fd = SAFE_OPEN(FNAME, O_RDONLY, NULL);
+	fd = SAFE_OPEN(FNAME, O_RDONLY);
 
 	for (i = 0; i < ARRAY_SIZE(tc); i++) {
 		tc[i].value = SAFE_MALLOC(tc[i].size);
diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
index 82fb676be..c3cff0aab 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
@@ -244,7 +244,7 @@ static void setup(void)
 			SAFE_BIND(tc[i].fd, (const struct sockaddr *) &sun,
 					sizeof(struct sockaddr_un));
 		} else {
-			tc[i].fd = SAFE_OPEN(tc[i].fname, tc[i].fflags, NULL);
+			tc[i].fd = SAFE_OPEN(tc[i].fname, tc[i].fflags);
 		}
 
 		if (tc[i].exp_ret >= 0) {
diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr03.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr03.c
index d293ffca9..0581b9670 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr03.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr03.c
@@ -48,7 +48,7 @@ static void verify_fgetxattr(void)
 static void setup(void)
 {
 	SAFE_TOUCH(FILENAME, 0644, NULL);
-	fd = SAFE_OPEN(FILENAME, O_RDONLY, NULL);
+	fd = SAFE_OPEN(FILENAME, O_RDONLY);
 
 	SAFE_FSETXATTR(fd, XATTR_TEST_KEY, XATTR_TEST_VALUE,
 			XATTR_TEST_VALUE_SIZE, XATTR_CREATE);
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
index ffec8104f..d799e477f 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
@@ -205,7 +205,7 @@ static void setup(void)
 	long_value[XATTR_SIZE_MAX + 1] = '\0';
 
 	SAFE_TOUCH(FNAME, 0644, NULL);
-	fd = SAFE_OPEN(FNAME, O_RDONLY, NULL);
+	fd = SAFE_OPEN(FNAME, O_RDONLY);
 
 	for (i = 0; i < ARRAY_SIZE(tc); i++) {
 		if (!tc[i].key)
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 3aea4b59e..0336c964a 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -211,7 +211,7 @@ static void setup(void)
 	for (i = 0; i < ARRAY_SIZE(tc); i++) {
 
 		if (!tc[i].issocket) {
-			tc[i].fd = SAFE_OPEN(tc[i].fname, tc[i].fflags, NULL);
+			tc[i].fd = SAFE_OPEN(tc[i].fname, tc[i].fflags);
 			continue;
 		}
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
