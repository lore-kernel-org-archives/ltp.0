Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245A1EB64DB
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 07:58:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF5B3CB895
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 09:58:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCBCF3CB4BD
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 06:41:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE87E140051D
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 06:41:35 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0E89061D72;
 Mon,  5 Jun 2023 04:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06764C433EF;
 Mon,  5 Jun 2023 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685940093;
 bh=0A3OuK1ZjuhezJ/l5wHs/N9Yji6YIpoqf3xChLrwsjU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ugZ58vTDkRASZZIYOubWtcU2pO3WoUDzstD7j4oSlw7baGoXsiwXGwaTW+L/by7YB
 9MCNfOoREySk9QLGZvTRQDZ74thP2cMekLvmjsiMUS9fED/JFUwcqC8u7z4QHFj1i9
 0DG6B6VOnno5juNSe0t/P+7RHqI26eWTsk9P39vB72qU9OInK93YHHtDMUgtnCBtis
 MIY5AnmJrFFlLANt/+Di04A4AQRhK5U5chR6MXUvCfdcQXfrwr9tX4TYgXoV/aDAHo
 B8BTE5pC+8F/evzQXMhuPk6tAnJXsj3bABvM/CXL28aHFPiKuDtShrqWnXSzbyoi6x
 Jlpy94CTCQIhg==
From: Damien Le Moal <dlemoal@kernel.org>
To: ltp <ltp@lists.linux.it>,
	Linus Walleij <linus.walleij@linaro.org>
Date: Mon,  5 Jun 2023 13:41:30 +0900
Message-Id: <20230605044131.798383-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605044131.798383-1-dlemoal@kernel.org>
References: <20230605044131.798383-1-dlemoal@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 19 Jun 2023 09:58:05 +0200
Subject: [LTP] [PATCH 1/2] ioprio: use ioprio.h kernel header if it exists
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For the ioprio system call test cases, avoid blindly defining the
IOPRIO_XXX macro internally and instead use the kernel user API header
file if it exists. Given that the definitions in this header file have
changed over time, make sure to test for the existence of the macro
IOPRIO_PRIO_LEVEL macro and define it if it does not exist. Similarly,
use IOPRIO_NR_LEVELS to define IOPRIO_PRIO_NUM if that macro exists.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 configure.ac                              |  1 +
 testcases/kernel/syscalls/ioprio/ioprio.h | 29 +++++++++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 548288310..e4aa2cadf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,6 +56,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/if_ether.h \
     linux/if_packet.h \
     linux/io_uring.h \
+    linux/ioprio.h \
     linux/keyctl.h \
     linux/mempolicy.h \
     linux/module.h \
diff --git a/testcases/kernel/syscalls/ioprio/ioprio.h b/testcases/kernel/syscalls/ioprio/ioprio.h
index c74380475..6ca134a54 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio.h
+++ b/testcases/kernel/syscalls/ioprio/ioprio.h
@@ -6,6 +6,12 @@
 #ifndef LTP_IOPRIO_H
 #define LTP_IOPRIO_H
 
+#ifdef HAVE_LINUX_IOPRIO_H
+
+# include <linux/ioprio.h>
+
+#else
+
 enum {
 	IOPRIO_CLASS_NONE = 0,
 	IOPRIO_CLASS_RT,
@@ -19,15 +25,24 @@ enum {
 	IOPRIO_WHO_USER,
 };
 
-/* The I/O scheduler classes have 8 priorities 0..7 except for the IDLE class */
-#define IOPRIO_PRIO_NUM		8
+# define IOPRIO_CLASS_SHIFT	(13)
+# define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+
+# define IOPRIO_PRIO_CLASS(data)	((data) >> IOPRIO_CLASS_SHIFT)
+# define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
 
-#define IOPRIO_CLASS_SHIFT	(13)
-#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+#endif
+
+/* The RT and BE I/O priority classes have 8 priority levels 0..7 */
+#ifdef IOPRIO_NR_LEVELS
+# define IOPRIO_PRIO_NUM		IOPRIO_NR_LEVELS
+#else
+# define IOPRIO_PRIO_NUM		8
+#endif
 
-#define IOPRIO_PRIO_CLASS(data)	((data) >> IOPRIO_CLASS_SHIFT)
-#define IOPRIO_PRIO_LEVEL(data)	((data) & IOPRIO_PRIO_MASK)
-#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
+#ifndef IOPRIO_PRIO_LEVEL
+# define IOPRIO_PRIO_LEVEL(data)	((data) & IOPRIO_PRIO_MASK)
+#endif
 
 static const char * const to_class_str[] = {
 	[IOPRIO_CLASS_NONE] = "NONE",
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
