Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BFFC43334
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 12:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75EC93C93C9
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 14:54:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D63C63C9420
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 14:53:34 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 622B4600356
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 14:53:32 +0200 (CEST)
Received: from ubuntu.localdomain (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 7193C9FF8E;
 Mon, 27 Jun 2022 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1656334411; bh=KnRKeUxtXolONwjQK5CoewwA6FGbVFjF5EhoV10tLwc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=KolkbhvV92jXlPTwcQ6qwvf5+O7l8GWl/VLVNgrMDkuPGPV8LBprGbsVLDEDkUk60
 W3B938Z5SZaPzNB1lPivx/TYPcJ/lXMC/uRX5OqXHTXIBPyRER0xQWzwVPkoR7rbj+
 DNBL09sye+VVF4lFEd2v77JSslHEF+8NA7grnyF0=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Mon, 27 Jun 2022 14:53:21 +0200
Message-Id: <20220627125321.1560677-4-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627125321.1560677-1-lkml@jv-coder.de>
References: <20220627125321.1560677-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] configure: Integrate open posix testsuite
 configure
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
---
 configure.ac           | 11 +++++++++++
 include/mk/automake.mk |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 69b145b5f..5ac23421c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -334,8 +334,19 @@ AC_ARG_WITH([open-posix-testsuite],
   [with_open_posix_testsuite=$withval],
   [with_open_posix_testsuite=no]
 )
+
+# Allow setting the directoy, where the open posix testsuite is installed to.
+# If nothing is defined, we have to pass our default value to submake
+AC_ARG_WITH([open-posix-testdir],
+  [AS_HELP_STRING([--with-open-posix-testdir=<dir>],
+    [compile and install the open posix testsuite])],
+  [],
+  [ac_configure_args="$ac_configure_args --with-open-posix-testdir=testcases/open_posix_testsuite"]
+)
+
 if test "x$with_open_posix_testsuite" = xyes; then
     AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["yes"])
+    AC_CONFIG_SUBDIRS([testcases/open_posix_testsuite])
 else
     AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["no"])
 fi
diff --git a/include/mk/automake.mk b/include/mk/automake.mk
index 219d015d0..ee3b7f1b8 100644
--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -27,7 +27,8 @@ AUTOHEADER	?= autoheader
 AUTOMAKE	?= automake
 
 AUTOCONFED_SUBDIRS	= \
-			testcases/realtime
+			testcases/realtime \
+			testcases/open_posix_testsuite
 
 # We want to run this every single time to ensure that all of the prereq files
 # are there.
@@ -35,6 +36,10 @@ AUTOCONFED_SUBDIRS	= \
 testcases/realtime/configure:
 	$(MAKE) -C $(@D) autotools
 
+.PHONY: testcases/open_posix_testsuite/configure
+testcases/open_posix_testsuite/configure:
+	$(MAKE) -C $(@D) autotools
+
 .PHONY: autotools
 autotools: aclocal autoconf autoheader automake $(addsuffix /configure,$(AUTOCONFED_SUBDIRS))
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
