Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA068C001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:19:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE4CB3CECE8
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:19:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742B13CECA6
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 7FB921400077
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:24 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5F4C1042;
 Mon, 23 Oct 2023 06:58:03 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com
 [10.1.194.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E36F3F64C;
 Mon, 23 Oct 2023 06:57:22 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 14:56:47 +0100
Message-Id: <20231023135647.2157030-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231023135647.2157030-1-kevin.brodsky@arm.com>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Oct 2023 16:18:31 +0200
Subject: [LTP] [PATCH 3/3] Provide a PATH_MAX-long buffer when expecting
 ENAMETOOLONG
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

A number of tests check that syscalls manipulating paths return
-ENAMETOOLONG when the specified path is longer than allowed. There
are actually two ways this error can be triggered:

1. If the given string is longer than PATH_MAX, i.e. 4096 as far as
   the kernel is concerned, then the getname() helper will fail and
   the kernel will return -ENAMETOOLONG right away.

2. If the string fits in PATH_MAX, but the filesystem rejects the
   path name, for instance because one of its components is longer
   than the support file name length (e.g. 255 for ext4).

At the moment, we always fail because of 2. since we set PATH_MAX to
1024 in LTP, and in fact we sometimes use NAME_MAX as buffer length
instead (which is shorter). Thus what actually happens is that the
kernel overreads the provided buffer and finds some zero before
hitting the "real" PATH_MAX limit (4096).

We should clearly avoid such overreads. Having the syscalls fail
right away by hitting 1. is the safer option. To do so, we obtain
the value of PATH_MAX directly from the appropriate kernel header,
and ensure it is used where relevant. This affects at least the
following tests:

- rename10
- symlink03

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/old/usctest.h                       | 12 ++----------
 testcases/kernel/syscalls/rename/rename10.c |  2 +-
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/old/usctest.h b/include/old/usctest.h
index 9b9446d70a1e..2d46c4045111 100644
--- a/include/old/usctest.h
+++ b/include/old/usctest.h
@@ -34,16 +34,8 @@
 #ifndef __USCTEST_H__
 #define __USCTEST_H__
 
-/*
- * Ensure that PATH_MAX is defined
- */
-#ifndef PATH_MAX
-#ifdef MAXPATHLEN
-#define PATH_MAX  MAXPATHLEN
-#else
-#define PATH_MAX  1024
-#endif
-#endif
+/* For PATH_MAX */
+#include <linux/limits.h>
 
 /***********************************************************************
  * The following globals are defined in parse_opts.c but must be
diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index 444f65366576..3eab4be0f913 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -18,7 +18,7 @@
 #define MNT_POINT "mntpoint"
 #define TEMP_FILE "tmpfile"
 
-static char long_path[NAME_MAX + 1] = {[0 ... NAME_MAX] = 'a'};
+static char long_path[PATH_MAX + 1] = {[0 ... PATH_MAX] = 'a'};
 
 static void setup(void)
 {
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
