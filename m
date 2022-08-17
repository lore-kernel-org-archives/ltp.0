Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C527EC25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 13:39:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8FA3C9FDF
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 15:39:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A88423C9F48
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id E40C11A00496
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:43 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C645113E;
 Wed, 17 Aug 2022 06:38:44 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5D53F7D7;
 Wed, 17 Aug 2022 06:38:42 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 17 Aug 2022 14:39:43 +0100
Message-Id: <20220817133946.234985-2-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817133946.234985-1-tudor.cretu@arm.com>
References: <20220817133946.234985-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib: Fix initialization of recursive mutex
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

For any libc that doesn't define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP,
don't assume that the type of the mutex is the first member. Use a
runtime initializer instead.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 lib/tst_res.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8d86b48a4..2f66ec40c 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -82,17 +82,27 @@ void *TST_RET_PTR;
 	assert(strlen(buf) > 0);		\
 } while (0)
 
-#ifndef PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
-# ifdef __ANDROID__
-#  define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP \
-	PTHREAD_RECURSIVE_MUTEX_INITIALIZER
-# else
-/* MUSL: http://www.openwall.com/lists/musl/2017/02/20/5 */
-#  define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP  { {PTHREAD_MUTEX_RECURSIVE} }
-# endif
+#if !defined(PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP) && defined(__ANDROID__)
+#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP PTHREAD_RECURSIVE_MUTEX_INITIALIZER
 #endif
 
+#ifdef PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
 static pthread_mutex_t tmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+#else
+/* MUSL: http://www.openwall.com/lists/musl/2017/02/20/5 */
+static pthread_mutex_t tmutex;
+
+__attribute__((constructor))
+static void init_tmutex(void)
+{
+	pthread_mutexattr_t mutattr = {0};
+
+	pthread_mutexattr_init(&mutattr);
+	pthread_mutexattr_settype(&mutattr, PTHREAD_MUTEX_RECURSIVE);
+	pthread_mutex_init(&tmutex, &mutattr);
+	pthread_mutexattr_destroy(&mutattr);
+}
+#endif
 
 static void check_env(void);
 static void tst_condense(int tnum, int ttype, const char *tmesg);
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
