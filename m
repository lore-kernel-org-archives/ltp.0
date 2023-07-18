Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D9BEB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 10:01:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9A2D3C98FB
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 12:01:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A88D3C98FB
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 12:00:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 20DD71A008B1
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 12:00:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 774081FD99;
 Tue, 18 Jul 2023 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689674455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aRUJwZRwqXLRJkkNR/iR9bXqhzzhNFwam5ICOeZdSzg=;
 b=v3r/VoatIgA0M4Rr1s3J0XM/Ref3l5dCqniysGKbWqOSZHWL7hL/u4vIR0rVw5NlkvhgCB
 Ih7LDfmoS8tiqbm5F5VkvL30XT3eqEOD/JwGLEJKSlzaoZTiFcXznjHRVV7pxye8HIb/71
 xjPFcVgKbRzlyI7qNDmfvjI1sOnvHQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689674455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aRUJwZRwqXLRJkkNR/iR9bXqhzzhNFwam5ICOeZdSzg=;
 b=PSDLJZQW5CmF2b8T7BEAPHIFOIOPGS49fi4dYXVk2pWJR9Ih90Tf423w2FNk++k4nnVsCu
 PuRCEVVCfeH2hJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2B31134B0;
 Tue, 18 Jul 2023 10:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9JKBN9ZitmTodAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jul 2023 10:00:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Jul 2023 12:00:50 +0200
Message-Id: <20230718100050.1162482-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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

Previously COMPAT_TST_16_H variable in Makefile was needed to be set
when all files in directory which use compat_16.mk/compat_tst_16.h were
rewritten to new API. Switch it to define variable for legacy tests
+ put warning into C sources (will be easier during cleanup to delete
the variable).

The only exception are these unconverted tests:
testcases/kernel/syscalls/setfsuid/setfsuid04.c
testcases/kernel/syscalls/setfsgid/setfsgid03.c
testcases/kernel/syscalls/setresgid/setresgid01.c
testcases/kernel/syscalls/setresgid/setresgid04.c
Because there are most of the tests in their directory converted,
variable USE_LEGACY_COMPAT_16_H is not set.

This cleanup also removes typo from 83ee53589: "compat_16_tst.h" (this
file does not exists, it should have been compat_tst_16.h).

Reported-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/getegid/Makefile        | 3 +++
 testcases/kernel/syscalls/getegid/getegid01.c     | 5 +++++
 testcases/kernel/syscalls/getegid/getegid02.c     | 5 +++++
 testcases/kernel/syscalls/getgroups/Makefile      | 3 +++
 testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++++
 testcases/kernel/syscalls/getgroups/getgroups03.c | 5 +++++
 testcases/kernel/syscalls/getresgid/Makefile      | 3 +++
 testcases/kernel/syscalls/getresgid/getresgid01.c | 5 +++++
 testcases/kernel/syscalls/getresgid/getresgid02.c | 5 +++++
 testcases/kernel/syscalls/getresgid/getresgid03.c | 5 +++++
 testcases/kernel/syscalls/getresuid/Makefile      | 3 +++
 testcases/kernel/syscalls/getresuid/getresuid01.c | 5 +++++
 testcases/kernel/syscalls/getresuid/getresuid02.c | 5 +++++
 testcases/kernel/syscalls/getresuid/getresuid03.c | 5 +++++
 testcases/kernel/syscalls/lchown/Makefile         | 3 +++
 testcases/kernel/syscalls/lchown/lchown01.c       | 5 +++++
 testcases/kernel/syscalls/lchown/lchown02.c       | 5 +++++
 testcases/kernel/syscalls/lchown/lchown03.c       | 5 +++++
 testcases/kernel/syscalls/setgroups/Makefile      | 3 +++
 testcases/kernel/syscalls/setgroups/setgroups01.c | 4 ++++
 testcases/kernel/syscalls/setgroups/setgroups02.c | 4 ++++
 testcases/kernel/syscalls/setgroups/setgroups03.c | 4 ++++
 testcases/kernel/syscalls/setgroups/setgroups04.c | 4 ++++
 testcases/kernel/syscalls/setuid/Makefile         | 3 ---
 testcases/kernel/syscalls/utils/compat_16.mk      | 2 +-
 25 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/getegid/Makefile b/testcases/kernel/syscalls/getegid/Makefile
index b2bb1e005..a319acf85 100644
--- a/testcases/kernel/syscalls/getegid/Makefile
+++ b/testcases/kernel/syscalls/getegid/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+# Remove after rewriting all tests to the new API.
+USE_LEGACY_COMPAT_16_H := 1
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
index 271fbb6b6..431c1b7f3 100644
--- a/testcases/kernel/syscalls/getegid/getegid01.c
+++ b/testcases/kernel/syscalls/getegid/getegid01.c
@@ -42,6 +42,11 @@
 #include <signal.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 static void setup();
diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
index 60f09501e..c52fcfe9d 100644
--- a/testcases/kernel/syscalls/getegid/getegid02.c
+++ b/testcases/kernel/syscalls/getegid/getegid02.c
@@ -28,6 +28,11 @@
 #include <errno.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/getgroups/Makefile b/testcases/kernel/syscalls/getgroups/Makefile
index b2bb1e005..a319acf85 100644
--- a/testcases/kernel/syscalls/getgroups/Makefile
+++ b/testcases/kernel/syscalls/getgroups/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+# Remove after rewriting all tests to the new API.
+USE_LEGACY_COMPAT_16_H := 1
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index dc3074b75..9ac5f888a 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -54,6 +54,11 @@
 #include <sys/types.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/getgroups/getgroups03.c b/testcases/kernel/syscalls/getgroups/getgroups03.c
index 5ba20ef82..fc94f0b8e 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups03.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups03.c
@@ -40,6 +40,11 @@
 #include <pwd.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define TESTUSER "root"
diff --git a/testcases/kernel/syscalls/getresgid/Makefile b/testcases/kernel/syscalls/getresgid/Makefile
index b2bb1e005..a319acf85 100644
--- a/testcases/kernel/syscalls/getresgid/Makefile
+++ b/testcases/kernel/syscalls/getresgid/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+# Remove after rewriting all tests to the new API.
+USE_LEGACY_COMPAT_16_H := 1
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getresgid/getresgid01.c b/testcases/kernel/syscalls/getresgid/getresgid01.c
index b5fb804ee..8000200e1 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid01.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid01.c
@@ -73,6 +73,11 @@
 #include <signal.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 char *TCID = "getresgid01";
diff --git a/testcases/kernel/syscalls/getresgid/getresgid02.c b/testcases/kernel/syscalls/getresgid/getresgid02.c
index 8bddf9824..ca4502aac 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid02.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid02.c
@@ -75,6 +75,11 @@
 #include <pwd.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define LTPUSER		"nobody"
diff --git a/testcases/kernel/syscalls/getresgid/getresgid03.c b/testcases/kernel/syscalls/getresgid/getresgid03.c
index 0785359e0..1d7bcabd2 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid03.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid03.c
@@ -77,6 +77,11 @@
 #include <pwd.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 char *TCID = "getresgid03";
diff --git a/testcases/kernel/syscalls/getresuid/Makefile b/testcases/kernel/syscalls/getresuid/Makefile
index b2bb1e005..a319acf85 100644
--- a/testcases/kernel/syscalls/getresuid/Makefile
+++ b/testcases/kernel/syscalls/getresuid/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+# Remove after rewriting all tests to the new API.
+USE_LEGACY_COMPAT_16_H := 1
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getresuid/getresuid01.c b/testcases/kernel/syscalls/getresuid/getresuid01.c
index 07fed9c13..a04918d6f 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid01.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid01.c
@@ -72,6 +72,11 @@
 #include <signal.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 char *TCID = "getresuid01";
diff --git a/testcases/kernel/syscalls/getresuid/getresuid02.c b/testcases/kernel/syscalls/getresuid/getresuid02.c
index 23f7944dd..77896a8a3 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid02.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid02.c
@@ -75,6 +75,11 @@
 #include <pwd.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define LTPUSER		"nobody"
diff --git a/testcases/kernel/syscalls/getresuid/getresuid03.c b/testcases/kernel/syscalls/getresuid/getresuid03.c
index bf117038b..34e40c45d 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid03.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid03.c
@@ -76,6 +76,11 @@
 #include <pwd.h>
 
 #include "test.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 char *TCID = "getresuid03";
diff --git a/testcases/kernel/syscalls/lchown/Makefile b/testcases/kernel/syscalls/lchown/Makefile
index 305fee281..7c76afea5 100644
--- a/testcases/kernel/syscalls/lchown/Makefile
+++ b/testcases/kernel/syscalls/lchown/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+# Remove after rewriting all tests to the new API.
+USE_LEGACY_COMPAT_16_H := 1
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 SRCS			:= $(sort $(wildcard $(abs_srcdir)/lchown*.c))
diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
index 4e6076e1f..aaa0ef403 100644
--- a/testcases/kernel/syscalls/lchown/lchown01.c
+++ b/testcases/kernel/syscalls/lchown/lchown01.c
@@ -41,6 +41,11 @@
 
 #include "test.h"
 #include "safe_macros.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 97966f6be..c0932fb7a 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -58,6 +58,11 @@
 
 #include "test.h"
 #include "safe_macros.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define TEST_USER       "nobody"
diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
index c26f54c21..ecb6ed64d 100644
--- a/testcases/kernel/syscalls/lchown/lchown03.c
+++ b/testcases/kernel/syscalls/lchown/lchown03.c
@@ -39,6 +39,11 @@
 
 #include "test.h"
 #include "safe_macros.h"
+
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
diff --git a/testcases/kernel/syscalls/setgroups/Makefile b/testcases/kernel/syscalls/setgroups/Makefile
index b2bb1e005..a319acf85 100644
--- a/testcases/kernel/syscalls/setgroups/Makefile
+++ b/testcases/kernel/syscalls/setgroups/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+# Remove after rewriting all tests to the new API.
+USE_LEGACY_COMPAT_16_H := 1
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
index fed7f8e5a..a571a57c8 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups01.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
@@ -118,6 +118,10 @@
 
 #include "test.h"
 
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 void setup();
diff --git a/testcases/kernel/syscalls/setgroups/setgroups02.c b/testcases/kernel/syscalls/setgroups/setgroups02.c
index de23a4a7f..462c8327c 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups02.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups02.c
@@ -73,6 +73,10 @@
 
 #include "test.h"
 
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define TESTUSER	"nobody"
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 490b06996..c800bcb51 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -74,6 +74,10 @@
 
 #include "test.h"
 
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 #define TESTUSER	"nobody"
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
index 971c86bd2..71dcc4e38 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
@@ -70,6 +70,10 @@
 
 #include "test.h"
 
+/*
+ * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
+ * rewriting all tests to the new API.
+ */
 #include "compat_16.h"
 
 TCID_DEFINE(setgroups04);
diff --git a/testcases/kernel/syscalls/setuid/Makefile b/testcases/kernel/syscalls/setuid/Makefile
index 1fdd7bd76..88d6385d9 100644
--- a/testcases/kernel/syscalls/setuid/Makefile
+++ b/testcases/kernel/syscalls/setuid/Makefile
@@ -4,8 +4,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-#for compat_16.mk uses the compat_16_tst.h
-COMPAT_TST_16_H		:= 1
-
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
index e81a00c40..71a8cc56f 100644
--- a/testcases/kernel/syscalls/utils/compat_16.mk
+++ b/testcases/kernel/syscalls/utils/compat_16.mk
@@ -60,7 +60,7 @@ MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
 # (no .h file, no TST_USE_NEWER64_SYSCALL def).
 DEF_16			:= TST_USE_COMPAT16_SYSCALL
 
-ifneq ($(COMPAT_TST_16_H),1)
+ifeq ($(USE_LEGACY_COMPAT_16_H),1)
 COMPAT_16_H		:= $(abs_srcdir)/../utils/compat_16.h
 else
 COMPAT_16_H     := $(abs_srcdir)/../utils/compat_tst_16.h
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
