Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D03C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 06:21:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8C3B3CA0D5
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 08:21:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1483B3C87EF
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:21:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2E70600661
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:21:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1659B22400;
 Tue,  5 Jul 2022 06:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657002091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBwAaQanm+UTTD+lTgYAlROtuaQO9rk4UGlsNZxrKwg=;
 b=KR8xU0G/N70nuzanHmNtMuhx3tyLg7miBytqQLyHIiV2TAk7wURiZcBi0fQr+hXRMhYzvv
 odK5sMRlJ30krvEofvOTQhNjNDzhpcnm9Ox8F7aGaXMWvvyhpqecxVwfOBDyHisLvqcZyU
 XBAfyehJnzV6o0MNYdGSYOhpB7hsoVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657002091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBwAaQanm+UTTD+lTgYAlROtuaQO9rk4UGlsNZxrKwg=;
 b=FRtj6BSO51jNoWqfGb3JRQ5guJoP4KV5g7sfb2vWW7JmZqoi7WBFFEcXngGwXD9lUHYXpd
 H7PPJJXDniVNvmDA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 785D32C141;
 Tue,  5 Jul 2022 06:21:30 +0000 (UTC)
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-3-lkml@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 05 Jul 2022 06:57:02 +0100
In-reply-to: <20220627125321.1560677-3-lkml@jv-coder.de>
Message-ID: <87czekrseu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] openposix: Setup autoconf and fix
 installation layout
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> From: Joerg Vehlow <joerg.vehlow@aox.de>
>
> This allows installation of the tests to a different directory
> than directly under $prefix.
>
> Before the layout was:
> $prefix/bin/{run-*,t0,run-tests.h,Makefile}
> $prefix/conformance
> $prefix/functional
> $prefix/stress
>
> with prefix being /opt/openposix_testsuite on linux and
> /usr/local/openposix_testsuite on other systems
> OR the value of the env-var $prefix.
>
> With this change, the prefix defaults to /opt/openposix_testsuite
> and can be changed the usual way using configure (./configure ---prefix=foo)
> Additionally the path of the tests below $prefix can be changed, using
> configure --with-open-posix-testdir=<foo>. This allows clean installation as
> part of ltp:
>
> $prefix/bin/{run-all-posix-option-group-tests.sh,run-posix-option-group-test.sh}
> $prefix/$testdir/bin/{run-tests.sh,t0}
> $prefix/$testdir/conformance
> $prefix/$testdir/functional
> $prefix/$testdir/stress
>
> Only the two directly callable shell scripts are kept under $prefix/bin,
> the two other executables are moved to testdir, because they are only
> used by the implementation of the test execution scripts (run.sh)
> $prefix/bin/Makefile is not installed anymore, because it is not required.
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
> ---
>  testcases/open_posix_testsuite/.gitignore     |  5 ++
>  testcases/open_posix_testsuite/CFLAGS         |  1 -
>  .../Documentation/HOWTO_Release               |  4 +-
>  .../Documentation/HOWTO_RunTests              |  1 +
>  testcases/open_posix_testsuite/INSTALL        |  9 ----
>  testcases/open_posix_testsuite/LDFLAGS        |  0
>  testcases/open_posix_testsuite/LDLIBS         |  0
>  testcases/open_posix_testsuite/Makefile       | 51 +++++++++++++------
>  testcases/open_posix_testsuite/QUICK-START    |  6 +--
>  testcases/open_posix_testsuite/bin/Makefile   | 30 ++++++++---
>  .../bin/run-posix-option-group-test.sh        |  4 +-
>  testcases/open_posix_testsuite/configure.ac   | 18 +++++++
>  .../open_posix_testsuite/conformance/Makefile |  1 +
>  .../conformance/behavior/Makefile             |  2 +
>  .../conformance/definitions/Makefile          |  2 +
>  .../conformance/interfaces/Makefile           |  2 +
>  .../open_posix_testsuite/functional/Makefile  |  2 +
>  .../include/mk/config.mk.in                   | 17 +++++++
>  .../open_posix_testsuite/include/mk/env.mk    | 11 ++++
>  .../scripts/generate-makefiles.sh             | 39 +++-----------
>  .../scripts/print-prefix.sh                   | 10 ----
>  .../open_posix_testsuite/stress/Makefile      |  2 +
>  testcases/open_posix_testsuite/tools/Makefile |  9 ++--
>  23 files changed, 139 insertions(+), 87 deletions(-)
>  delete mode 100644 testcases/open_posix_testsuite/CFLAGS
>  delete mode 100644 testcases/open_posix_testsuite/INSTALL
>  delete mode 100644 testcases/open_posix_testsuite/LDFLAGS
>  delete mode 100644 testcases/open_posix_testsuite/LDLIBS
>  create mode 100644 testcases/open_posix_testsuite/configure.ac
>  create mode 100644 testcases/open_posix_testsuite/include/mk/config.mk.in
>  create mode 100644 testcases/open_posix_testsuite/include/mk/env.mk
>  delete mode 100755 testcases/open_posix_testsuite/scripts/print-prefix.sh
>
> diff --git a/testcases/open_posix_testsuite/.gitignore b/testcases/open_posix_testsuite/.gitignore
> index a134c02a4..c9164df3a 100644
> --- a/testcases/open_posix_testsuite/.gitignore
> +++ b/testcases/open_posix_testsuite/.gitignore
> @@ -15,3 +15,8 @@
>  run.sh
>  
>  logfile
> +
> +/configure
> +/config.log
> +/config.status
> +include/mk/config.mk
> diff --git a/testcases/open_posix_testsuite/CFLAGS b/testcases/open_posix_testsuite/CFLAGS
> deleted file mode 100644
> index 297d2929a..000000000
> --- a/testcases/open_posix_testsuite/CFLAGS
> +++ /dev/null
> @@ -1 +0,0 @@
> --std=c99 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -W -Wall
> diff --git a/testcases/open_posix_testsuite/Documentation/HOWTO_Release b/testcases/open_posix_testsuite/Documentation/HOWTO_Release
> index a6970c871..3332cae00 100644
> --- a/testcases/open_posix_testsuite/Documentation/HOWTO_Release
> +++ b/testcases/open_posix_testsuite/Documentation/HOWTO_Release
> @@ -20,8 +20,8 @@ released files.
>  4.  Download the *.tar.gz file from the SF interface and untar it in
>      a sandbox.
>  
> -5.  Run "make" to try to build and execute all files in the release, and
> -    ensure that they all build and execute correctly.
> +5.  Run "./configure && make" to try to build and execute all files
> +    in the release, and ensure that they all build and execute correctly.
>  
>  6.  Craft a release message and send to:  posixtest-announce.
>  
> diff --git a/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests b/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
> index 0231838e2..c443f9e3e 100644
> --- a/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
> +++ b/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
> @@ -45,6 +45,7 @@ To build and run the tests, you should be in the main posix test suite
>  directory.
>  
>  From there, execute:
> +    # ./configure
>      # make all
>  
>  This will build all of the conformance, functional, and stress tests.
> diff --git a/testcases/open_posix_testsuite/INSTALL b/testcases/open_posix_testsuite/INSTALL
> deleted file mode 100644
> index 9e3d3cd0a..000000000
> --- a/testcases/open_posix_testsuite/INSTALL
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -
> -This package does not install yet ... it is intended to be run
> -directly.
> -
> -See BUILD for information on how to configure your system to build
> -all tests.
> -
> -See Documentation/HOWTO_RunTests for information on how to run all tests.
> -
> diff --git a/testcases/open_posix_testsuite/LDFLAGS b/testcases/open_posix_testsuite/LDFLAGS
> deleted file mode 100644
> index e69de29bb..000000000
> diff --git a/testcases/open_posix_testsuite/LDLIBS b/testcases/open_posix_testsuite/LDLIBS
> deleted file mode 100644
> index e69de29bb..000000000
> diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
> index fea6db14b..affabf9f7 100644
> --- a/testcases/open_posix_testsuite/Makefile
> +++ b/testcases/open_posix_testsuite/Makefile
> @@ -5,6 +5,10 @@
>  # all of the Makefiles will be rebuilt by default.
>  CRITICAL_MAKEFILE=	conformance/interfaces/timer_settime/Makefile
>  
> +top_srcdir?=		.
> +
> +include include/mk/env.mk
> +
>  # The default logfile for the tests.
>  LOGFILE?=		logfile
>  # Subdirectories to traverse down.
> @@ -21,43 +25,58 @@ BUILD_MAKE=		env $(BUILD_MAKE_ENV) $(MAKE)
>  
>  TEST_MAKE=		env $(TEST_MAKE_ENV) $(MAKE) -k
>  
> -top_srcdir?=		.
> -
> -prefix?=		`$(top_srcdir)/scripts/print_prefix.sh`
> -
> -datadir?=		$(prefix)/share
> -
> -exec_prefix?=		$(prefix)
> -
>  all: conformance-all functional-all stress-all tools-all
>  
>  ifeq ($(shell uname -s), Linux)
>  include Makefile.linux
>  endif
>  
> -clean: $(CRITICAL_MAKEFILE)
> -	@rm -f $(LOGFILE)*
> +AUTOGENERATED_FILES = include/mk/config.mk
> +
> +.PHONY: ac-clean
> +ac-clean: clean
> +
> +.PHONY: clean
> +clean:
> +	$(RM) -f $(LOGFILE)*
> +	$(RM) -f config.log config.status
>  	@for dir in $(SUBDIRS) tools; do \
>  		$(MAKE) -C $$dir clean >/dev/null; \
>  	done
>  
> -distclean: distclean-makefiles
> +.PHONY: distclean
> +distclean: clean distclean-makefiles
> +	@rm -f $(AUTOGENERATED_FILES)

Shouldn't this also include the configure script itself? Running
distclean on the LTP root removes the top level configure script.

>  
>  # Clean out all of the generated Makefiles.
> +.PHONY: distclean-makefiles
>  distclean-makefiles:
>  	@for dir in $(SUBDIRS); do \
>  		$(MAKE) -C $$dir $@; \
>  	done
>  
> +$(AUTOGENERATED_FILES): $(top_builddir)/config.status
> +	$(SHELL) $^
> +
> +.PHONY: autotools
> +autotools: configure
> +
> +configure: configure.ac
> +	autoconf
> +
> +.PHONY: generate-makefiles
>  generate-makefiles: distclean-makefiles
>  	@env top_srcdir=$(top_srcdir) \
>  		$(top_srcdir)/scripts/generate-makefiles.sh
>  
> +.PHONY: install
>  install: bin-install conformance-install functional-install stress-install
>  
> +.PHONY: test
>  test: conformance-test functional-test stress-test
>  
>  # Test build and execution targets.
> +.PHONY: conformance-all conformance-install conformance-test
>  conformance-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(BUILD_MAKE) -C conformance -j1 all
> @@ -69,6 +88,7 @@ conformance-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(TEST_MAKE) -C conformance test
>  
> +.PHONY: functional-all functional-install functional-test
>  functional-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(BUILD_MAKE) -C functional -j1 all
> @@ -80,6 +100,7 @@ functional-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(TEST_MAKE) -C functional test
>  
> +.PHONY: stress-all stress-install stress-test
>  stress-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(BUILD_MAKE) -C stress -j1 all
> @@ -92,17 +113,15 @@ stress-test:
>  	@$(TEST_MAKE) -C stress test
>  
>  # Tools build and install targets.
> +.PHONY: bin-install
>  bin-install:
>  	@$(MAKE) -C bin install
>  
> +.PHONY: tools-all
>  tools-all:
>  	@$(MAKE) -C tools all
>  
> -$(CRITICAL_MAKEFILE): \
> -	$(top_srcdir)/scripts/generate-makefiles.sh	\
> -	$(top_srcdir)/CFLAGS			\
> -	$(top_srcdir)/LDFLAGS			\
> -	$(top_srcdir)/LDLIBS
> +$(CRITICAL_MAKEFILE): $(top_srcdir)/scripts/generate-makefiles.sh
>  	@$(MAKE) generate-makefiles
>  
>  .PHONY: check
> diff --git a/testcases/open_posix_testsuite/QUICK-START b/testcases/open_posix_testsuite/QUICK-START
> index 6f5d881b4..649d7a3d7 100644
> --- a/testcases/open_posix_testsuite/QUICK-START
> +++ b/testcases/open_posix_testsuite/QUICK-START
> @@ -10,8 +10,6 @@ No worries! Here's a quick doc to help you around POSIX** Test Suite.
>  Setting up your machine
>  ========================
>  
> -* There is nothing to install, the suite is intended to be run directly.
> -
>  * See the "BUILD" file for info on how to set up the Makefile and your machine,
>    depending on what specific area you are concentrating on.
>  (Signals, Semaphores, Threads, Timers or Message Queues).
> @@ -20,8 +18,8 @@ Setting up your machine
>  Running the tests
>  ===================
>  
> -* Easiest way to run all the tests is to do a "make all" in the top-level
> -  directory.
> +* Easiest way to run all the tests is to do a "./configure && make all"

Trailing whitespace at the end of this line

> +  in the top-level directory.
>  
>  * To run tests for a specific directory, do the following
>    - make generate-makefiles # only required for the first shot.
> diff --git a/testcases/open_posix_testsuite/bin/Makefile b/testcases/open_posix_testsuite/bin/Makefile
> index d9fd13800..262a6567c 100644
> --- a/testcases/open_posix_testsuite/bin/Makefile
> +++ b/testcases/open_posix_testsuite/bin/Makefile
> @@ -4,18 +4,32 @@
>  # Ngie Cooper, July 2010
>  #
>  
> -top_srcdir?=		..
> +top_srcdir ?= ..
>  
> -srcdir=			$(top_srcdir)/bin
> +include $(top_srcdir)/include/mk/config.mk
>  
> -prefix?=		`$(top_srcdir)/scripts/print-prefix.sh`
> -
> -bindir?=		$(prefix)/bin
> +INSTALL_BIN_TARGETS = run-all-posix-option-group-tests.sh run-posix-option-group-test.sh
> +INSTALL_TESTCASE_BIN_TARGETS = run-tests.sh t0
>  
> +.PHONY: clean
>  clean:
>  	@rm -f t0.val
>  
> -install: clean
> -	@set -e; for i in `ls *`; do \
> -	    install -m 0755 $$i $(DESTDIR)/$(bindir)/. ;\
> +.PHONY: install
> +install: clean $(DESTDIR)/$(bindir) $(DESTDIR)/$(testdir_bin)
> +	set -e; for file in $(INSTALL_BIN_TARGETS); do           \
> +		install -m 00755 $$file $(DESTDIR)/$(bindir)/$$file; \
> +	done
> +
> +	sed -i 's~TESTPATH=""~TESTPATH="$(testdir_rel)"~' $(DESTDIR)/$(bindir)/run-posix-option-group-test.sh
> +
> +	set -e; for file in $(INSTALL_TESTCASE_BIN_TARGETS); do	      \
> +		install -m 00755 $$file $(DESTDIR)/$(testdir_bin)/$$file; \
>  	done
> +
> +
> +$(DESTDIR)/$(bindir):
> +	mkdir -p $@
> +
> +$(DESTDIR)/$(testdir_bin):
> +	mkdir -p $@
> diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> index 1bbdddfd5..e90c252a3 100755
> --- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> +++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> @@ -8,7 +8,9 @@
>  #
>  # Use to build and run tests for a specific area
>  
> -BASEDIR="$(dirname "$0")/../conformance/interfaces"
> +TESTPATH=""
> +
> +BASEDIR="$(dirname "$0")/../${TESTPATH}/conformance/interfaces"
>  
>  usage()
>  {
> diff --git a/testcases/open_posix_testsuite/configure.ac b/testcases/open_posix_testsuite/configure.ac
> new file mode 100644
> index 000000000..ae0399d07
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/configure.ac
> @@ -0,0 +1,18 @@
> +AC_PREREQ(2.61)
> +AC_INIT([open_posix_testsuite], [LTP_VERSION], [ltp@lists.linux.it])
> +AC_CONFIG_FILES([ \
> +    include/mk/config.mk \
> +])
> +
> +AC_PROG_CC_C99

This causes a deprecation warning for me

> +
> +AC_PREFIX_DEFAULT(/opt/openposix_testsuite)
> +
> +AC_ARG_WITH([open-posix-testdir],
> +    [AS_HELP_STRING([--with-open-posix-testdir=DIR], [Relative path from $prefix to testdir])],
> +    [testdir=$withval],
> +    [testdir=]
> +)
> +AC_SUBST([testdir], [$testdir])
> +
> +AC_OUTPUT

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
