Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A44C4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 15:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D31343CC521
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 16:08:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBBB03CC527
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 16:07:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 3365B60042A
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 16:07:47 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A38A12FC;
 Wed, 30 Nov 2022 07:07:53 -0800 (PST)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 724503F73D;
 Wed, 30 Nov 2022 07:07:45 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 30 Nov 2022 15:07:37 +0000
Message-Id: <20221130150738.745960-3-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130150738.745960-1-tudor.cretu@arm.com>
References: <20221130150738.745960-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] safe_open,
 safe_openat: Fix undefined behaviour in vararg handling
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

Accessing elements in an empty va_list is undefined behaviour.
The open system call expects the mode argument only when O_CREAT or
O_TMPFILE is specified in flags, otherwise the mode argument is ignored.

Modify the safe_open and safe_openat wrappers to read the variadic
argument only when it's expected to be provided.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 include/lapi/fcntl.h   |  3 +++
 lib/safe_macros.c      | 21 ++++++++++++---------
 lib/tst_safe_file_at.c | 13 ++++++++-----
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 8a0a893f9..f17220737 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -141,6 +141,9 @@
 # define MAX_HANDLE_SZ	128
 #endif
 
+#define TST_OPEN_NEEDS_MODE(oflag) \
+	(((oflag) & O_CREAT) != 0 || ((oflag) & O_TMPFILE) == O_TMPFILE)
+
 #ifndef HAVE_STRUCT_FILE_HANDLE
 struct file_handle {
 	unsigned int handle_bytes;
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d8816631f..d34b71fda 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -13,7 +13,6 @@
 #include <sys/xattr.h>
 #include <sys/sysinfo.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <libgen.h>
 #include <limits.h>
 #include <pwd.h>
@@ -21,6 +20,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <malloc.h>
+#include "lapi/fcntl.h"
 #include "test.h"
 #include "safe_macros.h"
 
@@ -236,18 +236,21 @@ int safe_munmap(const char *file, const int lineno, void (*cleanup_fn) (void),
 int safe_open(const char *file, const int lineno, void (*cleanup_fn) (void),
               const char *pathname, int oflags, ...)
 {
-	va_list ap;
 	int rval;
-	mode_t mode;
+	mode_t mode = 0;
 
-	va_start(ap, oflags);
+	if (TST_OPEN_NEEDS_MODE(oflags)) {
+		va_list ap;
 
-	/* Android's NDK's mode_t is smaller than an int, which results in
-	 * SIGILL here when passing the mode_t type.
-	 */
-	mode = va_arg(ap, int);
+		va_start(ap, oflags);
+
+		/* Android's NDK's mode_t is smaller than an int, which results in
+		 * SIGILL here when passing the mode_t type.
+		 */
+		mode = va_arg(ap, int);
 
-	va_end(ap);
+		va_end(ap);
+	}
 
 	rval = open(pathname, oflags, mode);
 
diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
index f530dc349..257f70291 100644
--- a/lib/tst_safe_file_at.c
+++ b/lib/tst_safe_file_at.c
@@ -35,13 +35,16 @@ const char *tst_decode_fd(const int fd)
 int safe_openat(const char *const file, const int lineno,
 		const int dirfd, const char *const path, const int oflags, ...)
 {
-	va_list ap;
 	int fd;
-	mode_t mode;
+	mode_t mode = 0;
 
-	va_start(ap, oflags);
-	mode = va_arg(ap, int);
-	va_end(ap);
+	if (TST_OPEN_NEEDS_MODE(oflags)) {
+		va_list ap;
+
+		va_start(ap, oflags);
+		mode = va_arg(ap, int);
+		va_end(ap);
+	}
 
 	fd = openat(dirfd, path, oflags, mode);
 	if (fd > -1)
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
