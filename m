Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6478C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 14:48:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D5E33CCA0C
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 15:48:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C38423CCA1B
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 15:48:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id A512360067C
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 15:48:05 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58D3A1FB;
 Wed, 23 Nov 2022 06:48:10 -0800 (PST)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 234433F73B;
 Wed, 23 Nov 2022 06:48:03 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 23 Nov 2022 14:47:44 +0000
Message-Id: <20221123144746.590890-2-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123144746.590890-1-tudor.cretu@arm.com>
References: <20221123144746.590890-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] safe_open: Fix undefined behaviour in vararg
 handling
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
Therefore, remove the variadicness from safe_open as it always calls
open with the mode argument included.

Adapt the SAFE_OPEN macro to handle the change by passing a default
argument of 0 to mode if it's omitted.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 include/old/safe_macros.h |  6 ++++--
 include/safe_macros_fn.h  |  3 ++-
 include/tst_safe_macros.h |  6 ++++--
 lib/safe_macros.c         | 13 +------------
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index fb1d7a110..d16540d63 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -59,9 +59,11 @@
 #define SAFE_MUNMAP(cleanup_fn, addr, length)	\
 	safe_munmap(__FILE__, __LINE__, (cleanup_fn), (addr), (length))
 
+#define __SAFE_OPEN(cleanup_fn, pathname, oflags, mode, ...)	\
+	safe_open(__FILE__, __LINE__, (cleanup_fn), (pathname), (oflags), (mode))
+
 #define SAFE_OPEN(cleanup_fn, pathname, oflags, ...)	\
-	safe_open(__FILE__, __LINE__, (cleanup_fn), (pathname), (oflags), \
-	    ##__VA_ARGS__)
+	__SAFE_OPEN((cleanup_fn), (pathname), (oflags), ##__VA_ARGS__, 0)
 
 #define SAFE_PIPE(cleanup_fn, fildes)	\
 	safe_pipe(__FILE__, __LINE__, cleanup_fn, (fildes))
diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 114d8fd43..d143079c3 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -74,7 +74,8 @@ int safe_munmap(const char *file, const int lineno,
                 void (*cleanup_fn)(void), void *addr, size_t length);
 
 int safe_open(const char *file, const int lineno,
-              void (*cleanup_fn)(void), const char *pathname, int oflags, ...);
+              void (*cleanup_fn)(void), const char *pathname, int oflags,
+              mode_t mode);
 
 int safe_pipe(const char *file, const int lineno,
               void (*cleanup_fn)(void), int fildes[2]);
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 81c4b0844..d53555c88 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -86,9 +86,11 @@ void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size);
 #define SAFE_MUNMAP(addr, length) \
 	safe_munmap(__FILE__, __LINE__, NULL, (addr), (length))
 
+#define __SAFE_OPEN(pathname, oflags, mode, ...) \
+	safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), (mode))
+
 #define SAFE_OPEN(pathname, oflags, ...) \
-	safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
-	    ##__VA_ARGS__)
+	__SAFE_OPEN((pathname), (oflags), ##__VA_ARGS__, 0)
 
 #define SAFE_PIPE(fildes) \
 	safe_pipe(__FILE__, __LINE__, NULL, (fildes))
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d8816631f..a92b58347 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -234,20 +234,9 @@ int safe_munmap(const char *file, const int lineno, void (*cleanup_fn) (void),
 }
 
 int safe_open(const char *file, const int lineno, void (*cleanup_fn) (void),
-              const char *pathname, int oflags, ...)
+              const char *pathname, int oflags, mode_t mode)
 {
-	va_list ap;
 	int rval;
-	mode_t mode;
-
-	va_start(ap, oflags);
-
-	/* Android's NDK's mode_t is smaller than an int, which results in
-	 * SIGILL here when passing the mode_t type.
-	 */
-	mode = va_arg(ap, int);
-
-	va_end(ap);
 
 	rval = open(pathname, oflags, mode);
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
