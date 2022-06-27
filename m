Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A7C433EF
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 12:54:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C9A03C9428
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 14:54:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD5FC3C942D
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 14:53:35 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE4741000228
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 14:53:31 +0200 (CEST)
Received: from ubuntu.localdomain (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 230A0A346F;
 Mon, 27 Jun 2022 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1656334410; bh=N8Q5XQTuEZE6HbiXLcJCet7X/FvScTQ9IHKs2F/bDmM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=VA3mNuWPp7Om1BRiFUwuIta2GlBfAueBfCj/ABKqeIqd/AQnDyno3OcPsKTCTIjYr
 JTlATcZ1sEWDXMEXbs84v05vUqUBTbbC2lyE94VVGQeE+4PlHVBnDsxpw9I1siudht
 Z1mfhOrn2MskcgVcVHVBK4vHEsy+f9K7UOy6KZ/4=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Mon, 27 Jun 2022 14:53:20 +0200
Message-Id: <20220627125321.1560677-3-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627125321.1560677-1-lkml@jv-coder.de>
References: <20220627125321.1560677-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] openposix: Setup autoconf and fix installation
 layout
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

This allows installation of the tests to a different directory
than directly under $prefix.

Before the layout was:
$prefix/bin/{run-*,t0,run-tests.h,Makefile}
$prefix/conformance
$prefix/functional
$prefix/stress

with prefix being /opt/openposix_testsuite on linux and
/usr/local/openposix_testsuite on other systems
OR the value of the env-var $prefix.

With this change, the prefix defaults to /opt/openposix_testsuite
and can be changed the usual way using configure (./configure ---prefix=foo)
Additionally the path of the tests below $prefix can be changed, using
configure --with-open-posix-testdir=<foo>. This allows clean installation as
part of ltp:

$prefix/bin/{run-all-posix-option-group-tests.sh,run-posix-option-group-test.sh}
$prefix/$testdir/bin/{run-tests.sh,t0}
$prefix/$testdir/conformance
$prefix/$testdir/functional
$prefix/$testdir/stress

Only the two directly callable shell scripts are kept under $prefix/bin,
the two other executables are moved to testdir, because they are only
used by the implementation of the test execution scripts (run.sh)
$prefix/bin/Makefile is not installed anymore, because it is not required.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
---
 testcases/open_posix_testsuite/.gitignore     |  5 ++
 testcases/open_posix_testsuite/CFLAGS         |  1 -
 .../Documentation/HOWTO_Release               |  4 +-
 .../Documentation/HOWTO_RunTests              |  1 +
 testcases/open_posix_testsuite/INSTALL        |  9 ----
 testcases/open_posix_testsuite/LDFLAGS        |  0
 testcases/open_posix_testsuite/LDLIBS         |  0
 testcases/open_posix_testsuite/Makefile       | 51 +++++++++++++------
 testcases/open_posix_testsuite/QUICK-START    |  6 +--
 testcases/open_posix_testsuite/bin/Makefile   | 30 ++++++++---
 .../bin/run-posix-option-group-test.sh        |  4 +-
 testcases/open_posix_testsuite/configure.ac   | 18 +++++++
 .../open_posix_testsuite/conformance/Makefile |  1 +
 .../conformance/behavior/Makefile             |  2 +
 .../conformance/definitions/Makefile          |  2 +
 .../conformance/interfaces/Makefile           |  2 +
 .../open_posix_testsuite/functional/Makefile  |  2 +
 .../include/mk/config.mk.in                   | 17 +++++++
 .../open_posix_testsuite/include/mk/env.mk    | 11 ++++
 .../scripts/generate-makefiles.sh             | 39 +++-----------
 .../scripts/print-prefix.sh                   | 10 ----
 .../open_posix_testsuite/stress/Makefile      |  2 +
 testcases/open_posix_testsuite/tools/Makefile |  9 ++--
 23 files changed, 139 insertions(+), 87 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/CFLAGS
 delete mode 100644 testcases/open_posix_testsuite/INSTALL
 delete mode 100644 testcases/open_posix_testsuite/LDFLAGS
 delete mode 100644 testcases/open_posix_testsuite/LDLIBS
 create mode 100644 testcases/open_posix_testsuite/configure.ac
 create mode 100644 testcases/open_posix_testsuite/include/mk/config.mk.in
 create mode 100644 testcases/open_posix_testsuite/include/mk/env.mk
 delete mode 100755 testcases/open_posix_testsuite/scripts/print-prefix.sh

diff --git a/testcases/open_posix_testsuite/.gitignore b/testcases/open_posix_testsuite/.gitignore
index a134c02a4..c9164df3a 100644
--- a/testcases/open_posix_testsuite/.gitignore
+++ b/testcases/open_posix_testsuite/.gitignore
@@ -15,3 +15,8 @@
 run.sh
 
 logfile
+
+/configure
+/config.log
+/config.status
+include/mk/config.mk
diff --git a/testcases/open_posix_testsuite/CFLAGS b/testcases/open_posix_testsuite/CFLAGS
deleted file mode 100644
index 297d2929a..000000000
--- a/testcases/open_posix_testsuite/CFLAGS
+++ /dev/null
@@ -1 +0,0 @@
--std=c99 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -W -Wall
diff --git a/testcases/open_posix_testsuite/Documentation/HOWTO_Release b/testcases/open_posix_testsuite/Documentation/HOWTO_Release
index a6970c871..3332cae00 100644
--- a/testcases/open_posix_testsuite/Documentation/HOWTO_Release
+++ b/testcases/open_posix_testsuite/Documentation/HOWTO_Release
@@ -20,8 +20,8 @@ released files.
 4.  Download the *.tar.gz file from the SF interface and untar it in
     a sandbox.
 
-5.  Run "make" to try to build and execute all files in the release, and
-    ensure that they all build and execute correctly.
+5.  Run "./configure && make" to try to build and execute all files
+    in the release, and ensure that they all build and execute correctly.
 
 6.  Craft a release message and send to:  posixtest-announce.
 
diff --git a/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests b/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
index 0231838e2..c443f9e3e 100644
--- a/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
+++ b/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
@@ -45,6 +45,7 @@ To build and run the tests, you should be in the main posix test suite
 directory.
 
 From there, execute:
+    # ./configure
     # make all
 
 This will build all of the conformance, functional, and stress tests.
diff --git a/testcases/open_posix_testsuite/INSTALL b/testcases/open_posix_testsuite/INSTALL
deleted file mode 100644
index 9e3d3cd0a..000000000
--- a/testcases/open_posix_testsuite/INSTALL
+++ /dev/null
@@ -1,9 +0,0 @@
-
-This package does not install yet ... it is intended to be run
-directly.
-
-See BUILD for information on how to configure your system to build
-all tests.
-
-See Documentation/HOWTO_RunTests for information on how to run all tests.
-
diff --git a/testcases/open_posix_testsuite/LDFLAGS b/testcases/open_posix_testsuite/LDFLAGS
deleted file mode 100644
index e69de29bb..000000000
diff --git a/testcases/open_posix_testsuite/LDLIBS b/testcases/open_posix_testsuite/LDLIBS
deleted file mode 100644
index e69de29bb..000000000
diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index fea6db14b..affabf9f7 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -5,6 +5,10 @@
 # all of the Makefiles will be rebuilt by default.
 CRITICAL_MAKEFILE=	conformance/interfaces/timer_settime/Makefile
 
+top_srcdir?=		.
+
+include include/mk/env.mk
+
 # The default logfile for the tests.
 LOGFILE?=		logfile
 # Subdirectories to traverse down.
@@ -21,43 +25,58 @@ BUILD_MAKE=		env $(BUILD_MAKE_ENV) $(MAKE)
 
 TEST_MAKE=		env $(TEST_MAKE_ENV) $(MAKE) -k
 
-top_srcdir?=		.
-
-prefix?=		`$(top_srcdir)/scripts/print_prefix.sh`
-
-datadir?=		$(prefix)/share
-
-exec_prefix?=		$(prefix)
-
 all: conformance-all functional-all stress-all tools-all
 
 ifeq ($(shell uname -s), Linux)
 include Makefile.linux
 endif
 
-clean: $(CRITICAL_MAKEFILE)
-	@rm -f $(LOGFILE)*
+AUTOGENERATED_FILES = include/mk/config.mk
+
+.PHONY: ac-clean
+ac-clean: clean
+
+.PHONY: clean
+clean:
+	$(RM) -f $(LOGFILE)*
+	$(RM) -f config.log config.status
 	@for dir in $(SUBDIRS) tools; do \
 		$(MAKE) -C $$dir clean >/dev/null; \
 	done
 
-distclean: distclean-makefiles
+.PHONY: distclean
+distclean: clean distclean-makefiles
+	@rm -f $(AUTOGENERATED_FILES)
 
 # Clean out all of the generated Makefiles.
+.PHONY: distclean-makefiles
 distclean-makefiles:
 	@for dir in $(SUBDIRS); do \
 		$(MAKE) -C $$dir $@; \
 	done
 
+$(AUTOGENERATED_FILES): $(top_builddir)/config.status
+	$(SHELL) $^
+
+.PHONY: autotools
+autotools: configure
+
+configure: configure.ac
+	autoconf
+
+.PHONY: generate-makefiles
 generate-makefiles: distclean-makefiles
 	@env top_srcdir=$(top_srcdir) \
 		$(top_srcdir)/scripts/generate-makefiles.sh
 
+.PHONY: install
 install: bin-install conformance-install functional-install stress-install
 
+.PHONY: test
 test: conformance-test functional-test stress-test
 
 # Test build and execution targets.
+.PHONY: conformance-all conformance-install conformance-test
 conformance-all: $(CRITICAL_MAKEFILE)
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(BUILD_MAKE) -C conformance -j1 all
@@ -69,6 +88,7 @@ conformance-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(TEST_MAKE) -C conformance test
 
+.PHONY: functional-all functional-install functional-test
 functional-all: $(CRITICAL_MAKEFILE)
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(BUILD_MAKE) -C functional -j1 all
@@ -80,6 +100,7 @@ functional-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(TEST_MAKE) -C functional test
 
+.PHONY: stress-all stress-install stress-test
 stress-all: $(CRITICAL_MAKEFILE)
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(BUILD_MAKE) -C stress -j1 all
@@ -92,17 +113,15 @@ stress-test:
 	@$(TEST_MAKE) -C stress test
 
 # Tools build and install targets.
+.PHONY: bin-install
 bin-install:
 	@$(MAKE) -C bin install
 
+.PHONY: tools-all
 tools-all:
 	@$(MAKE) -C tools all
 
-$(CRITICAL_MAKEFILE): \
-	$(top_srcdir)/scripts/generate-makefiles.sh	\
-	$(top_srcdir)/CFLAGS			\
-	$(top_srcdir)/LDFLAGS			\
-	$(top_srcdir)/LDLIBS
+$(CRITICAL_MAKEFILE): $(top_srcdir)/scripts/generate-makefiles.sh
 	@$(MAKE) generate-makefiles
 
 .PHONY: check
diff --git a/testcases/open_posix_testsuite/QUICK-START b/testcases/open_posix_testsuite/QUICK-START
index 6f5d881b4..649d7a3d7 100644
--- a/testcases/open_posix_testsuite/QUICK-START
+++ b/testcases/open_posix_testsuite/QUICK-START
@@ -10,8 +10,6 @@ No worries! Here's a quick doc to help you around POSIX** Test Suite.
 Setting up your machine
 ========================
 
-* There is nothing to install, the suite is intended to be run directly.
-
 * See the "BUILD" file for info on how to set up the Makefile and your machine,
   depending on what specific area you are concentrating on.
 (Signals, Semaphores, Threads, Timers or Message Queues).
@@ -20,8 +18,8 @@ Setting up your machine
 Running the tests
 ===================
 
-* Easiest way to run all the tests is to do a "make all" in the top-level
-  directory.
+* Easiest way to run all the tests is to do a "./configure && make all" 
+  in the top-level directory.
 
 * To run tests for a specific directory, do the following
   - make generate-makefiles # only required for the first shot.
diff --git a/testcases/open_posix_testsuite/bin/Makefile b/testcases/open_posix_testsuite/bin/Makefile
index d9fd13800..262a6567c 100644
--- a/testcases/open_posix_testsuite/bin/Makefile
+++ b/testcases/open_posix_testsuite/bin/Makefile
@@ -4,18 +4,32 @@
 # Ngie Cooper, July 2010
 #
 
-top_srcdir?=		..
+top_srcdir ?= ..
 
-srcdir=			$(top_srcdir)/bin
+include $(top_srcdir)/include/mk/config.mk
 
-prefix?=		`$(top_srcdir)/scripts/print-prefix.sh`
-
-bindir?=		$(prefix)/bin
+INSTALL_BIN_TARGETS = run-all-posix-option-group-tests.sh run-posix-option-group-test.sh
+INSTALL_TESTCASE_BIN_TARGETS = run-tests.sh t0
 
+.PHONY: clean
 clean:
 	@rm -f t0.val
 
-install: clean
-	@set -e; for i in `ls *`; do \
-	    install -m 0755 $$i $(DESTDIR)/$(bindir)/. ;\
+.PHONY: install
+install: clean $(DESTDIR)/$(bindir) $(DESTDIR)/$(testdir_bin)
+	set -e; for file in $(INSTALL_BIN_TARGETS); do           \
+		install -m 00755 $$file $(DESTDIR)/$(bindir)/$$file; \
+	done
+
+	sed -i 's~TESTPATH=""~TESTPATH="$(testdir_rel)"~' $(DESTDIR)/$(bindir)/run-posix-option-group-test.sh
+
+	set -e; for file in $(INSTALL_TESTCASE_BIN_TARGETS); do	      \
+		install -m 00755 $$file $(DESTDIR)/$(testdir_bin)/$$file; \
 	done
+
+
+$(DESTDIR)/$(bindir):
+	mkdir -p $@
+
+$(DESTDIR)/$(testdir_bin):
+	mkdir -p $@
diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
index 1bbdddfd5..e90c252a3 100755
--- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
+++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
@@ -8,7 +8,9 @@
 #
 # Use to build and run tests for a specific area
 
-BASEDIR="$(dirname "$0")/../conformance/interfaces"
+TESTPATH=""
+
+BASEDIR="$(dirname "$0")/../${TESTPATH}/conformance/interfaces"
 
 usage()
 {
diff --git a/testcases/open_posix_testsuite/configure.ac b/testcases/open_posix_testsuite/configure.ac
new file mode 100644
index 000000000..ae0399d07
--- /dev/null
+++ b/testcases/open_posix_testsuite/configure.ac
@@ -0,0 +1,18 @@
+AC_PREREQ(2.61)
+AC_INIT([open_posix_testsuite], [LTP_VERSION], [ltp@lists.linux.it])
+AC_CONFIG_FILES([ \
+    include/mk/config.mk \
+])
+
+AC_PROG_CC_C99
+
+AC_PREFIX_DEFAULT(/opt/openposix_testsuite)
+
+AC_ARG_WITH([open-posix-testdir],
+    [AS_HELP_STRING([--with-open-posix-testdir=DIR], [Relative path from $prefix to testdir])],
+    [testdir=$withval],
+    [testdir=]
+)
+AC_SUBST([testdir], [$testdir])
+
+AC_OUTPUT
diff --git a/testcases/open_posix_testsuite/conformance/Makefile b/testcases/open_posix_testsuite/conformance/Makefile
index 11e8a840f..756d25252 100644
--- a/testcases/open_posix_testsuite/conformance/Makefile
+++ b/testcases/open_posix_testsuite/conformance/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Ngie Cooper, June 2010
 
+.PHONY: all clean distclean-makefiles install test
 all clean distclean-makefiles install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						   \
diff --git a/testcases/open_posix_testsuite/conformance/behavior/Makefile b/testcases/open_posix_testsuite/conformance/behavior/Makefile
index b09527fd3..f68140524 100644
--- a/testcases/open_posix_testsuite/conformance/behavior/Makefile
+++ b/testcases/open_posix_testsuite/conformance/behavior/Makefile
@@ -4,10 +4,12 @@
 # Ngie Cooper, June 2010
 #
 
+.PHONY: all clean install test
 all clean install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						  \
 	done
 
+.PHONY: distclean-makefiles
 distclean-makefiles:
 	@find */ -name 'Makefile*' | xargs rm -f
diff --git a/testcases/open_posix_testsuite/conformance/definitions/Makefile b/testcases/open_posix_testsuite/conformance/definitions/Makefile
index b09527fd3..f68140524 100644
--- a/testcases/open_posix_testsuite/conformance/definitions/Makefile
+++ b/testcases/open_posix_testsuite/conformance/definitions/Makefile
@@ -4,10 +4,12 @@
 # Ngie Cooper, June 2010
 #
 
+.PHONY: all clean install test
 all clean install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						  \
 	done
 
+.PHONY: distclean-makefiles
 distclean-makefiles:
 	@find */ -name 'Makefile*' | xargs rm -f
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/Makefile b/testcases/open_posix_testsuite/conformance/interfaces/Makefile
index 2eb2bd40b..3525da062 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/Makefile
+++ b/testcases/open_posix_testsuite/conformance/interfaces/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Ngie Cooper, June 2010
 
+.PHONY: all clean install test
 all clean install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						  \
 	done
 
+.PHONY: distclean-makefiles
 distclean-makefiles:
 	@find */ -name 'Makefile*' | xargs rm -f
diff --git a/testcases/open_posix_testsuite/functional/Makefile b/testcases/open_posix_testsuite/functional/Makefile
index 3b22c89af..4af1790fe 100644
--- a/testcases/open_posix_testsuite/functional/Makefile
+++ b/testcases/open_posix_testsuite/functional/Makefile
@@ -4,10 +4,12 @@
 # Ngie Cooper, June 2010
 #
 
+.PHONY: all clean install test
 all clean install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						   \
 	done
 
+.PHONY: distclean-makefiles
 distclean-makefiles:
 	@find */ -name 'Makefile*' | grep -v threads/Makefile | grep -v timers/Makefile | xargs rm -f
diff --git a/testcases/open_posix_testsuite/include/mk/config.mk.in b/testcases/open_posix_testsuite/include/mk/config.mk.in
new file mode 100644
index 000000000..c9a4b5c5a
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/mk/config.mk.in
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Joerg Vehlow <joerg.vehlow@aox.de>
+
+CC      =  @CC@
+CFLAGS  += @CFLAGS@
+LDLIBS  += @LIBS@
+LDFLAGS += @LDFLAGS@
+
+prefix      := @prefix@
+exec_prefix := @exec_prefix@
+bindir      := ${exec_prefix}/bin
+
+testdir_rel := @testdir@
+testdir     := ${prefix}/${testdir_rel}
+testdir_bin := ${testdir}/bin
+
+CFLAGS  += -std=c99 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -W -Wall
diff --git a/testcases/open_posix_testsuite/include/mk/env.mk b/testcases/open_posix_testsuite/include/mk/env.mk
new file mode 100644
index 000000000..0cd485f69
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/mk/env.mk
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Joerg Vehlow <joerg.vehlow@aox.de>
+
+abs_top_builddir		:= $(abspath $(top_srcdir))
+
+# autotools, *clean, don't require config.mk
+ifeq ($(filter autotools %clean,$(MAKECMDGOALS)),)
+include $(abs_top_builddir)/include/mk/config.mk
+else
+-include $(abs_top_builddir)/include/mk/config.mk
+endif
diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 3234aa454..0649c480f 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -111,9 +111,9 @@ top_srcdir?=		`echo "$prereq_dir" | awk '{ gsub(/[^\/]+/, "..", $0); print }'`
 subdir=			$prereq_cache_dir
 srcdir=			\$(top_srcdir)/\$(subdir)
 
-prefix?=		$PREFIX
-exec_prefix?=		\$(prefix)
-INSTALL_DIR=		\$(DESTDIR)/\$(exec_prefix)/\$(subdir)
+include \$(top_srcdir)/include/mk/env.mk
+
+INSTALL_DIR=		\$(DESTDIR)/\$(testdir)/\$(subdir)
 LOGFILE?=		logfile
 
 # Build variables
@@ -124,13 +124,6 @@ CFLAGS+=		-I\$(srcdir)
 
 EOF
 
-		if [ -f "$GLOBAL_BOILERPLATE" ]; then
-			cat >> "$makefile.1" <<EOF
-# Top-level make definitions
-`cat $GLOBAL_BOILERPLATE`
-EOF
-		fi
-
 		cat >> "$makefile.1" <<EOF
 # Submake make definitions.
 EOF
@@ -169,13 +162,16 @@ EOF
 	if [ ! -f "$makefile.3" ]; then
 
 		cat > "$makefile.3" <<EOF
+.PHONY: all
 all: \$(MAKE_TARGETS)
 	@if [ -d speculative ]; then \$(MAKE) -C speculative all; fi
 
+.PHONY: clean
 clean:
 	rm -f \$(MAKE_TARGETS) logfile* run.sh *.core
 	@if [ -d speculative ]; then \$(MAKE) -C speculative clean; fi
 
+.PHONY: install
 install: \$(INSTALL_DIR) run.sh
 	set -e; for file in \$(INSTALL_TARGETS) run.sh; do	\\
 		if [ -f "\$\$file" ] ; then			\\
@@ -185,6 +181,7 @@ install: \$(INSTALL_DIR) run.sh
 	done
 	@if [ -d speculative ]; then \$(MAKE) -C speculative install; fi
 
+.PHONY: test
 test: run.sh
 	\$(v)./run.sh
 
@@ -308,35 +305,13 @@ generate_makefiles() {
 export PATH="$PATH:`dirname "$0"`"
 
 AUTHORDATE=`grep "Ngie Cooper" "$0" | head -n 1 | sed 's,# *,,'`
-PREFIX=`print-prefix.sh`
-EXEC_PREFIX="${PREFIX}/bin"
 TOP_SRCDIR=${TOP_SRCDIR:=`dirname "$0"`/..}
 
-GLOBAL_BOILERPLATE="${TOP_SRCDIR}/.global_boilerplate"
-
-CONFIG_MK="../../include/mk/config-openposix.mk"
-
-rm -f "$GLOBAL_BOILERPLATE"
-
-for var in CFLAGS LDFLAGS LDLIBS; do
-	if [ -f "$TOP_SRCDIR/$var" ]; then
-		cat >> "$GLOBAL_BOILERPLATE" <<EOF
-$var+=		`cat "$TOP_SRCDIR/$var"`
-EOF
-	fi
-done
-
-if [ -f "$CONFIG_MK" ]; then
-	cat "$CONFIG_MK" >> "$GLOBAL_BOILERPLATE"
-fi
-
 # For the generic cases.
 generate_locate_test_makefile buildonly '.test' "$buildonly_compiler_args"
 generate_locate_test_makefile runnable '.run-test'
 generate_locate_test_makefile test-tools ''
 
-rm -f "$GLOBAL_BOILERPLATE"
-
 find . -name Makefile.1 -exec dirname {} \; | while read dir; do
 	if [ -f "$dir/Makefile.2" ]; then
 		cat $dir/Makefile.1 $dir/Makefile.2 $dir/Makefile.3 > $dir/Makefile
diff --git a/testcases/open_posix_testsuite/scripts/print-prefix.sh b/testcases/open_posix_testsuite/scripts/print-prefix.sh
deleted file mode 100755
index 795097f60..000000000
--- a/testcases/open_posix_testsuite/scripts/print-prefix.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-
-if uname -a | grep -iq linux
-then
-	DEFAULT_PREFIX=/opt
-else
-	DEFAULT_PREFIX=/usr/local
-fi
-
-echo ${prefix:=$DEFAULT_PREFIX/openposix_testsuite}
diff --git a/testcases/open_posix_testsuite/stress/Makefile b/testcases/open_posix_testsuite/stress/Makefile
index b09527fd3..f68140524 100644
--- a/testcases/open_posix_testsuite/stress/Makefile
+++ b/testcases/open_posix_testsuite/stress/Makefile
@@ -4,10 +4,12 @@
 # Ngie Cooper, June 2010
 #
 
+.PHONY: all clean install test
 all clean install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						  \
 	done
 
+.PHONY: distclean-makefiles
 distclean-makefiles:
 	@find */ -name 'Makefile*' | xargs rm -f
diff --git a/testcases/open_posix_testsuite/tools/Makefile b/testcases/open_posix_testsuite/tools/Makefile
index a6f0917a9..6d2f08a00 100644
--- a/testcases/open_posix_testsuite/tools/Makefile
+++ b/testcases/open_posix_testsuite/tools/Makefile
@@ -4,14 +4,15 @@
 # Ngie Cooper, June 2010
 #
 
--include ../../../include/mk/config-openposix.mk
+top_srcdir ?= ..
+srcdir     =  $(top_srcdir)/tools
 
-top_srcdir?=	..
-
-srcdir=		$(top_srcdir)/tools
+include ../include/mk/env.mk
 
+.PHONY: all
 all: ../bin/t0
 
+.PHONY: clean
 clean:
 	@rm -f ../bin/t0
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
