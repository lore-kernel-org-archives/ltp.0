Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6F6CD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 12:15:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352DC3CE3C5
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 14:15:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02B63C0FCA
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:15:27 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADEC66068F7
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:15:24 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35AC75D92F;
 Thu,  4 Apr 2024 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712232923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d/o97zsFxLBznRxMxy1zIwQRehSxQgPQFCdsIbQtwhI=;
 b=0+XEo/W4yBxIGRG54/B5hMX8bAvFttILs3J4P4V8JX00c/yVrzKZT2Mf2iVJOqc6XVs7vI
 7/c/EDPgPe88MC3XnNScN9Y1y99nIANBAVVGRJgnYHLQucor71z3gG6T8OFT8w7uy2/yqh
 bxAUy3hQmX6EaYA2xkA59EZL22mT594=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712232923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d/o97zsFxLBznRxMxy1zIwQRehSxQgPQFCdsIbQtwhI=;
 b=m9lsANVcsU+dlJZE1myf3SMfRLa1LHA8DqSgnB1ZhVA0eb24+/Cpx6TCfiog3CVIjUVSX2
 nF39n8RhgkLUjGCg==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C0FC313298;
 Thu,  4 Apr 2024 12:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id iVp9LNqZDmYlXAAAn2gu4w
 (envelope-from <andrea.cervesato@suse.de>); Thu, 04 Apr 2024 12:15:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  4 Apr 2024 14:15:21 +0200
Message-Id: <20240404121521.22483-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,
 imap2.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] New LTP documentation
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The new LTP documentation is meant to use Sphinx as the main
documentation framework, with ReconStructedText as the main language.
All the conversion has been done step-by-step, each chapter at time,
updating english syntax and fixing typos. There are minor improvements,
but overall the structure is the same.
The API chapters is ongoing and it will be completed soon in the future.

The old documentation has been moved into doc/old folder, but it will
removed once new documentation will be completed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Moved documentation into doc/ folder
Moved old documentation into doc/old folder

 .readthedocs.yml                              |   18 +
 README.md                                     |  252 ----
 README.rst                                    |   29 +
 doc/.gitignore                                |    4 +
 doc/Makefile                                  |   15 +-
 doc/_static/custom.css                        |    4 +
 doc/conf.py                                   |  201 ++++
 doc/developers/api_c_tests.rst                |    7 +
 doc/developers/api_kvm_tests.rst              |    7 +
 doc/developers/api_network_tests.rst          |    7 +
 doc/developers/api_shell_tests.rst            |    4 +
 doc/developers/build_system.rst               |  213 ++++
 doc/developers/debugging.rst                  |   21 +
 doc/developers/ltp_library.rst                |   42 +
 doc/developers/setup_mailinglist.rst          |   50 +
 doc/developers/test_case_tutorial.rst         | 1038 +++++++++++++++++
 doc/developers/writing_tests.rst              |  537 +++++++++
 doc/index.rst                                 |  103 ++
 doc/maintainers/ltp_release_procedure.rst     |  173 +++
 doc/maintainers/patch_review.rst              |  171 +++
 doc/{ => old}/Build-System.asciidoc           |    0
 doc/{ => old}/C-Test-API.asciidoc             |    0
 doc/{ => old}/C-Test-Case-Tutorial.asciidoc   |    0
 doc/{ => old}/C-Test-Network-API.asciidoc     |    0
 doc/{ => old}/Contact-Info.asciidoc           |    0
 doc/{ => old}/KVM-Test-API.asciidoc           |    0
 ...TP-Library-API-Writing-Guidelines.asciidoc |    0
 doc/{ => old}/LTP-Release-Procedure.asciidoc  |    0
 ...Maintainer-Patch-Review-Checklist.asciidoc |    0
 doc/old/Makefile                              |   11 +
 doc/{ => old}/Shell-Test-API.asciidoc         |    0
 ...-kernel,-libc,-toolchain-versions.asciidoc |    0
 .../Test-Writing-Guidelines.asciidoc          |    0
 doc/{ => old}/User-Guidelines.asciidoc        |    0
 doc/{ => old}/man1/Makefile                   |    0
 doc/{ => old}/man1/doio.1                     |    0
 doc/{ => old}/man1/iogen.1                    |    0
 doc/{ => old}/man1/ltp-bump.1                 |    0
 doc/{ => old}/man1/ltp-pan.1                  |    0
 doc/{ => old}/man3/Makefile                   |    0
 doc/{ => old}/man3/parse_opts.3               |    0
 doc/{ => old}/man3/parse_ranges.3             |    0
 doc/{ => old}/man3/random_range.3             |    0
 doc/{ => old}/man3/random_range_seed.3        |    0
 doc/{ => old}/man3/tst_res.3                  |    0
 doc/{ => old}/man3/tst_sig.3                  |    0
 doc/{ => old}/man3/tst_tmpdir.3               |    0
 doc/{ => old}/man3/usctest.3                  |    0
 doc/{ => old}/namespaces-helper-tools.txt     |    0
 doc/{ => old}/nommu-notes.txt                 |    0
 doc/{ => old}/rules.tsv                       |    0
 doc/requirements.txt                          |    3 +
 doc/spelling_wordlist                         |  120 ++
 doc/users/quick_start.rst                     |  126 ++
 doc/users/setup_tests.rst                     |  104 ++
 doc/users/stats.rst                           |    9 +
 doc/users/supported_systems.rst               |  110 ++
 57 files changed, 3118 insertions(+), 261 deletions(-)
 create mode 100644 .readthedocs.yml
 delete mode 100644 README.md
 create mode 100644 README.rst
 create mode 100644 doc/.gitignore
 create mode 100644 doc/_static/custom.css
 create mode 100644 doc/conf.py
 create mode 100644 doc/developers/api_c_tests.rst
 create mode 100644 doc/developers/api_kvm_tests.rst
 create mode 100644 doc/developers/api_network_tests.rst
 create mode 100644 doc/developers/api_shell_tests.rst
 create mode 100644 doc/developers/build_system.rst
 create mode 100644 doc/developers/debugging.rst
 create mode 100644 doc/developers/ltp_library.rst
 create mode 100644 doc/developers/setup_mailinglist.rst
 create mode 100644 doc/developers/test_case_tutorial.rst
 create mode 100644 doc/developers/writing_tests.rst
 create mode 100644 doc/index.rst
 create mode 100644 doc/maintainers/ltp_release_procedure.rst
 create mode 100644 doc/maintainers/patch_review.rst
 rename doc/{ => old}/Build-System.asciidoc (100%)
 rename doc/{ => old}/C-Test-API.asciidoc (100%)
 rename doc/{ => old}/C-Test-Case-Tutorial.asciidoc (100%)
 rename doc/{ => old}/C-Test-Network-API.asciidoc (100%)
 rename doc/{ => old}/Contact-Info.asciidoc (100%)
 rename doc/{ => old}/KVM-Test-API.asciidoc (100%)
 rename doc/{ => old}/LTP-Library-API-Writing-Guidelines.asciidoc (100%)
 rename doc/{ => old}/LTP-Release-Procedure.asciidoc (100%)
 rename doc/{ => old}/Maintainer-Patch-Review-Checklist.asciidoc (100%)
 create mode 100644 doc/old/Makefile
 rename doc/{ => old}/Shell-Test-API.asciidoc (100%)
 rename doc/{ => old}/Supported-kernel,-libc,-toolchain-versions.asciidoc (100%)
 rename doc/{ => old}/Test-Writing-Guidelines.asciidoc (100%)
 rename doc/{ => old}/User-Guidelines.asciidoc (100%)
 rename doc/{ => old}/man1/Makefile (100%)
 rename doc/{ => old}/man1/doio.1 (100%)
 rename doc/{ => old}/man1/iogen.1 (100%)
 rename doc/{ => old}/man1/ltp-bump.1 (100%)
 rename doc/{ => old}/man1/ltp-pan.1 (100%)
 rename doc/{ => old}/man3/Makefile (100%)
 rename doc/{ => old}/man3/parse_opts.3 (100%)
 rename doc/{ => old}/man3/parse_ranges.3 (100%)
 rename doc/{ => old}/man3/random_range.3 (100%)
 rename doc/{ => old}/man3/random_range_seed.3 (100%)
 rename doc/{ => old}/man3/tst_res.3 (100%)
 rename doc/{ => old}/man3/tst_sig.3 (100%)
 rename doc/{ => old}/man3/tst_tmpdir.3 (100%)
 rename doc/{ => old}/man3/usctest.3 (100%)
 rename doc/{ => old}/namespaces-helper-tools.txt (100%)
 rename doc/{ => old}/nommu-notes.txt (100%)
 rename doc/{ => old}/rules.tsv (100%)
 create mode 100644 doc/requirements.txt
 create mode 100644 doc/spelling_wordlist
 create mode 100644 doc/users/quick_start.rst
 create mode 100644 doc/users/setup_tests.rst
 create mode 100644 doc/users/stats.rst
 create mode 100644 doc/users/supported_systems.rst

diff --git a/.readthedocs.yml b/.readthedocs.yml
new file mode 100644
index 000000000..28e8c88a5
--- /dev/null
+++ b/.readthedocs.yml
@@ -0,0 +1,18 @@
+version: 2
+
+build:
+  os: "ubuntu-22.04"
+  tools:
+    python: "3.6"
+  apt_packages:
+    - enchant-2
+    - hunspell-en-us
+
+# Build from the doc/ directory with Sphinx
+sphinx:
+  configuration: doc/conf.py
+
+# Explicitly set the version of Python and its requirements
+python:
+  install:
+    - requirements: doc/requirements.txt
diff --git a/README.md b/README.md
deleted file mode 100644
index ef656eecd..000000000
--- a/README.md
+++ /dev/null
@@ -1,252 +0,0 @@
-Linux Test Project
-==================
-
-Linux Test Project is a joint project started by SGI, OSDL and Bull developed
-and maintained by IBM, Cisco, Fujitsu, SUSE, Red Hat, Oracle and others. The
-project goal is to deliver tests to the open source community that validate the
-reliability, robustness, and stability of Linux.
-
-The LTP testsuite contains a collection of tools for testing the Linux kernel
-and related features. Our goal is to improve the Linux kernel and system
-libraries by bringing test automation to the testing effort. Interested open
-source contributors are encouraged to join.
-
-Project pages are located at: http://linux-test-project.github.io/
-
-The latest image is always available at:
-https://github.com/linux-test-project/ltp/releases
-
-The discussion about the project happens at LTP mailing list:
-http://lists.linux.it/listinfo/ltp
-
-LTP mailing list is archived at:
-https://lore.kernel.org/ltp/
-
-IRC #ltp at: [irc.libera.chat](https://libera.chat/)
-
-The git repository is located at GitHub at:
-https://github.com/linux-test-project/ltp
-
-The patchwork instance is at:
-https://patchwork.ozlabs.org/project/ltp/list/
-
-Warning!
-========
-
-**Be careful with these tests!**
-
-Don't run them on production systems. Growfiles, doio, and iogen in particular
-stress the I/O capabilities of systems and while they should not cause problems
-on properly functioning systems, they are intended to find (or cause) problems.
-
-Quick guide to running the tests
-================================
-
-If you have git, autoconf, automake, m4, pkgconf / pkg-config, libc headers,
-linux kernel headers and other common development packages installed (see
-INSTALL and ci/*.sh), the chances are the following will work:
-
-```
-$ git clone https://github.com/linux-test-project/ltp.git
-$ cd ltp
-$ make autotools
-$ ./configure
-```
-
-Now you can continue either with compiling and running a single test or with
-compiling and installing the whole testsuite.
-
-For optional library dependencies look into scripts for major distros in
-`ci/` directory. You can also build whole LTP with `./build.sh` script.
-
-Shortcut to running a single test
----------------------------------
-If you need to execute a single test you actually do not need to compile
-the whole LTP, if you want to run a syscall testcase following should work.
-
-```
-$ cd testcases/kernel/syscalls/foo
-$ make
-$ PATH=$PATH:$PWD ./foo01
-```
-
-Shell testcases are a bit more complicated since these need a path to a shell
-library as well as to compiled binary helpers, but generally following should
-work.
-
-```
-$ cd testcases/lib
-$ make
-$ cd ../commands/foo
-$ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
-```
-
-Open Posix Testsuite has it's own build system which needs Makefiles to be
-generated first, then compilation should work in subdirectories as well.
-
-```
-$ cd testcases/open_posix_testsuite/
-$ make generate-makefiles
-$ cd conformance/interfaces/foo
-$ make
-$ ./foo_1-1.run-test
-```
-
-Compiling and installing all testcases
---------------------------------------
-
-```
-$ make
-$ make install
-```
-
-This will install LTP to `/opt/ltp`.
-* If you have a problem see `INSTALL` and `./configure --help`.
-* Failing that, ask for help on the mailing list or Github.
-
-Some tests will be disabled if the configure script can not find their build
-dependencies.
-
-* If a test returns `TCONF` due to a missing component, check the `./configure`
-  output.
-* If a tests fails due to a missing user or group, see the Quick Start section
-  of `INSTALL`.
-
-Running tests
--------------
-
-To run all the test suites
-
-```
-$ cd /opt/ltp
-$ ./runltp
-```
-
-Note that many test cases have to be executed as root.
-
-To run a particular test suite
-
-```
-$ ./runltp -f syscalls
-```
-
-To run all tests with `madvise` in the name
-
-```
-$ ./runltp -f syscalls -s madvise
-```
-Also see
-
-```
-$ ./runltp --help
-```
-
-Test suites (e.g. syscalls) are defined in the runtest directory. Each file
-contains a list of test cases in a simple format, see doc/ltp-run-files.txt.
-
-Each test case has its own executable or script, these can be executed
-directly
-
-```
-$ testcases/bin/abort01
-```
-
-Some have arguments
-
-```
-$ testcases/bin/mesgq_nstest -m none
-```
-
-The vast majority of test cases accept the -h (help) switch
-
-```
-$ testcases/bin/ioctl01 -h
-```
-
-Many require certain environment variables to be set
-
-```
-$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
-```
-
-Most commonly, the path variable needs to be set and also `LTPROOT`, but there
-are a number of other variables, `runltp` usually sets these for you.
-
-Note that all shell scripts need the `PATH` to be set. However this is not
-limited to shell scripts, many C based tests need environment variables as
-well.
-
-For more info see `doc/User-Guidelines.asciidoc` or online at
-https://github.com/linux-test-project/ltp/wiki/User-Guidelines.
-
-Network tests
--------------
-Network tests require certain setup, described in `testcases/network/README.md`
-(online at https://github.com/linux-test-project/ltp/tree/master/testcases/network).
-
-Containers
-----------
-
-*Presently running the LTP inside a container is not a shortcut. It
-will make things much harder for you.*
-
-There is a Containerfile which can be used with Docker or
-Podman. Currently it can build Alpine and OpenSUSE images.
-
-The container can be built with a command like:
-
-```
-$ podman build -t tumbleweed/ltp \
-       --build-arg PREFIX=registry.opensuse.org/opensuse/ \
-       --build-arg DISTRO_NAME=tumbleweed \
-       --build-arg DISTRO_RELEASE=20230925 .
-```
-
-Or just `podman build .` which will create an Alpine container.
-
-It contains Kirk in /opt/kirk. So the following will run some tests.
-
-```
-$ podman run -it --rm tumbleweed/ltp:latest
-$ cd /opt/kirk && ./kirk -f ltp -r syscalls
-```
-
-SUSE also publishes a
-[smaller LTP container](https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*)
-that is not based on the Containerfile.
-
-Debugging with gdb and strace
-=============================
-
-The new test library runs the actual test, i.e. the `test()` function in a
-forked process. To get stack trace of a crashing test in gdb it's needed to
-[`set follow-fork-mode child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html).
-To trace the test with strace, use strace with `-f` option to enable tracing of forked processes also.
-
-Developers corner
-=================
-
-Before you start you should read following documents:
-
-* `doc/Test-Writing-Guidelines.asciidoc`
-* `doc/Build-System.asciidoc`
-* `doc/LTP-Library-API-Writing-Guidelines.asciidoc`
-
-There is also a step-by-step tutorial:
-
-* `doc/C-Test-Case-Tutorial.asciidoc`
-
-If something is not covered there don't hesitate to ask on the LTP mailing
-list. Also note that these documents are available online at:
-
-* https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
-* https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines
-* https://github.com/linux-test-project/ltp/wiki/Build-System
-* https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
-
-Although we accept GitHub pull requests, the preferred way is sending patches to our mailing list.
-
-It's a good idea to test patches on GitHub Actions before posting to mailing
-list. Our GitHub Actions setup covers various architectures and distributions in
-order to make sure LTP compiles cleanly on most common configurations.
-For testing you need to just push your changes to your own LTP fork on GitHub.
diff --git a/README.rst b/README.rst
new file mode 100644
index 000000000..3e176bd0b
--- /dev/null
+++ b/README.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Linux Test Project
+==================
+
+Linux Test Project is a joint project started by SGI, OSDL and Bull developed
+and maintained by SUSE, Red Hat, Fujitsu, IBM, Cisco, Oracle and others. The
+project goal is to deliver tests to the open source community that validate
+reliability, robustness, and stability of the Linux Kernel.
+
+The testing suites contain a collection of tools for testing the Linux kernel
+and related features. Our goal is to improve the Linux kernel and system
+libraries by bringing test automation.
+
+.. warning::
+
+   LTP tests shouldn't run in production systems. In particular,
+   growfiles, doio, and iogen, stress the I/O capabilities of the systems and
+   they are intended to find (or cause) problems.
+
+Some references:
+
+* `Documentation <http://linux-test-project.rtfd.io/>`_
+* `Source code <https://github.com/linux-test-project/ltp>`_
+* `Releases <https://github.com/linux-test-project/ltp/releases>`_
+* `Mailing List <http://lists.linux.it/listinfo/ltp>`_
+* `Working patches (patchwork) <https://patchwork.ozlabs.org/project/ltp/list/>`_
+* `Working patches (lore.kernel.org) <https://lore.kernel.org/ltp>`_
+* `#ltp @ libera chat <https://libera.chat/>`_
diff --git a/doc/.gitignore b/doc/.gitignore
new file mode 100644
index 000000000..173179852
--- /dev/null
+++ b/doc/.gitignore
@@ -0,0 +1,4 @@
+html/
+build/
+_static/syscalls.rst
+syscalls.tbl
diff --git a/doc/Makefile b/doc/Makefile
index f7e4dd021..e536e95db 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,11 +1,8 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2009, Cisco Systems Inc.
-# Ngie Cooper, July 2009
+all:
+	sphinx-build -b html . html
 
-top_srcdir			?= ..
+spelling:
+	sphinx-build -b spelling -d build/doctree . build/spelling
 
-include $(top_srcdir)/include/mk/env_pre.mk
-
-RECURSIVE_TARGETS	:= install
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+clean:
+	rm -rf html/
diff --git a/doc/_static/custom.css b/doc/_static/custom.css
new file mode 100644
index 000000000..cb4d3821d
--- /dev/null
+++ b/doc/_static/custom.css
@@ -0,0 +1,4 @@
+/* set multiline tables cells */
+.wy-table-responsive table td {
+    white-space: normal;
+}
diff --git a/doc/conf.py b/doc/conf.py
new file mode 100644
index 000000000..fb3e83cf2
--- /dev/null
+++ b/doc/conf.py
@@ -0,0 +1,201 @@
+# Configuration file for the Sphinx documentation builder.
+#
+# For the full list of built-in configuration values, see the documentation:
+# https://www.sphinx-doc.org/en/master/usage/configuration.html
+
+import os
+import re
+import sphinx
+import socket
+import urllib.request
+
+# -- Project information -----------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information
+
+project = 'Linux Test Project'
+copyright = '2024, Linux Test Project'
+author = 'Linux Test Project'
+release = '1.0'
+
+# -- General configuration ---------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
+
+extensions = [
+    'linuxdoc.rstKernelDoc',
+    'sphinxcontrib.spelling'
+]
+
+exclude_patterns = ["html*", '_static*']
+
+spelling_lang = "en_US"
+spelling_warning = True
+spelling_exclude_patterns=['users/stats.rst']
+spelling_word_list_filename = "spelling_wordlist"
+
+# -- Options for HTML output -------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
+
+html_theme = 'sphinx_rtd_theme'
+html_static_path = ['_static']
+
+
+def generate_syscalls_stats(_):
+    """
+    Generate statistics for syscalls. We fetch the syscalls list from the kernel
+    sources, then we compare it with testcases/kernel/syscalls folder and
+    generate a file that is included in the statistics documentation section.
+    """
+    output = '_static/syscalls.rst'
+
+    # sometimes checking testcases/kernel/syscalls file names are not enough,
+    # because in some cases (i.e. io_ring) syscalls are tested, but they are
+    # part of a more complex scenario. In the following list, we define syscalls
+    # which we know they are 100% tested already.
+    white_list = [
+        'rt_sigpending',
+        'sethostname',
+        'lsetxattr',
+        'inotify_add_watch',
+        'inotify_rm_watch',
+        'newfstatat',
+        'pselect6',
+        'fanotify_init',
+        'fanotify_mark',
+        'prlimit64',
+        'getdents64',
+        'pkey_mprotect',
+        'pkey_alloc',
+        'pkey_free',
+        'io_uring_setup',
+        'io_uring_enter',
+        'io_uring_register',
+        'epoll_pwait2',
+        'quotactl_fd',
+    ]
+
+    # populate with non-syscalls which are present in the kernel sources
+    # syscalls file
+    black_list = [
+        'reserved177',
+        'reserved193',
+        'rseq'
+    ]
+
+    # fetch syscalls file
+    error = False
+    try:
+        socket.setdefaulttimeout(3)
+        urllib.request.urlretrieve(
+            "https://raw.githubusercontent.com/torvalds/linux/master/arch/mips/kernel/syscalls/syscall_n64.tbl",
+            "syscalls.tbl")
+    except Exception as err:
+        error = True
+        logger = sphinx.util.logging.getLogger(__name__)
+        msg = "Can't download syscall_n64.tbl from kernel sources"
+        logger.warning(msg)
+
+        with open(output, 'w+') as stats:
+            stats.write(f".. warning::\n\n    {msg}")
+
+    if error:
+        return
+
+    text = [
+        'Syscalls\n',
+        '--------\n\n',
+    ]
+
+    # collect all available kernel syscalls
+    regexp = re.compile(r'\d+\s+n64\s+(?P<syscall>\w+)\s+\w+')
+    ker_syscalls = []
+    with open("syscalls.tbl", 'r') as data:
+        for line in data:
+            match = regexp.search(line)
+            if match:
+                ker_syscalls.append(match.group('syscall'))
+
+    # collect all LTP tested syscalls
+    ltp_syscalls = []
+    for root, _, files in os.walk('../testcases/kernel/syscalls'):
+        for myfile in files:
+            if myfile.endswith('.c'):
+                ltp_syscalls.append(myfile)
+
+    # compare kernel syscalls with LTP tested syscalls
+    syscalls = {}
+    for kersc in ker_syscalls:
+        if kersc in black_list:
+            continue
+
+        if kersc not in syscalls:
+            if kersc in white_list:
+                syscalls[kersc] = True
+                continue
+
+            syscalls[kersc] = False
+
+        for ltpsc in ltp_syscalls:
+            if ltpsc.startswith(kersc):
+                syscalls[kersc] = True
+
+    # generate the statistics file
+    tested_syscalls = [key for key, val in syscalls.items() if val]
+    text.append('syscalls which are tested under **testcases/kernel/syscalls**:\n\n')
+    text.append(f'* kernel syscalls: {len(ker_syscalls)}\n')
+    text.append(f'* tested syscalls: {len(tested_syscalls)}\n\n')
+
+    # create tested/untested syscalls table
+    index_tested = 0
+    table_tested = [
+        'Tested syscalls\n',
+        '~~~~~~~~~~~~~~~\n\n',
+        '.. list-table::\n',
+        '    :header-rows: 0\n\n',
+    ]
+
+    index_untest = 0
+    table_untest = [
+        'Untested syscalls\n',
+        '~~~~~~~~~~~~~~~~~\n\n',
+        '.. list-table::\n',
+        '    :header-rows: 0\n\n',
+    ]
+
+    for sysname, tested in syscalls.items():
+        if tested:
+            if (index_tested % 3) == 0:
+                table_tested.append(f'    * - {sysname}\n')
+            else:
+                table_tested.append(f'      - {sysname}\n')
+
+            index_tested += 1
+        else:
+            if (index_untest % 3) == 0:
+                table_untest.append(f'    * - {sysname}\n')
+            else:
+                table_untest.append(f'      - {sysname}\n')
+
+            index_untest += 1
+
+    left = index_tested % 3
+    if left > 0:
+        for index in range(0, left + 1):
+            table_tested.append(f'      -\n')
+
+    left = index_untest % 3
+    if left > 0:
+        for index in range(0, left + 1):
+            table_untest.append(f'      -\n')
+
+    text.extend(table_tested)
+    text.append('\n')
+    text.extend(table_untest)
+
+    # write the file
+    with open(output, 'w+') as stats:
+        stats.writelines(text)
+
+
+def setup(app):
+    app.add_css_file('custom.css')
+    app.connect('builder-inited', generate_syscalls_stats)
diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
new file mode 100644
index 000000000..adee17f16
--- /dev/null
+++ b/doc/developers/api_c_tests.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. Include headers in this file with:
+.. .. kernel-doc:: ../../include/tst_test.h
+
+Developing using C API
+======================
diff --git a/doc/developers/api_kvm_tests.rst b/doc/developers/api_kvm_tests.rst
new file mode 100644
index 000000000..5ec3fc3a4
--- /dev/null
+++ b/doc/developers/api_kvm_tests.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. Include headers in this file with:
+.. .. kernel-doc:: ../../include/tst_test.h
+
+Developing using KVM API
+========================
diff --git a/doc/developers/api_network_tests.rst b/doc/developers/api_network_tests.rst
new file mode 100644
index 000000000..3e487d7f2
--- /dev/null
+++ b/doc/developers/api_network_tests.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. Include headers in this file with:
+.. .. kernel-doc:: ../../include/tst_test.h
+
+Developing using network API
+============================
diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
new file mode 100644
index 000000000..2fb2a5068
--- /dev/null
+++ b/doc/developers/api_shell_tests.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Developing using shell API
+==========================
diff --git a/doc/developers/build_system.rst b/doc/developers/build_system.rst
new file mode 100644
index 000000000..1a6ad4c56
--- /dev/null
+++ b/doc/developers/build_system.rst
@@ -0,0 +1,213 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Build system
+============
+
+The following document briefly describes the steps and methodologies used for
+the new and improved Makefile system.
+
+The Problem
+-----------
+
+The problem with the old Makefile system is that it was very difficult to
+maintain and it lacked any sense of formal structure, thus developing for LTP
+and including new targets was more difficult than it should have been
+(maintenance). Furthermore, proper option-based cross-compilation was
+impossible due to the fact that the Makefiles didn't support a prefixing
+system, and the appropriate implicit / static rules hadn't been configured to
+compile into multiple object directories for out-of-tree build support (ease of
+use / functionality). Finally, there wasn't a means to setup dependencies
+between components, such that if a component required ``libltp.a`` in order to
+compile, it would go off and compile ``libltp.a`` first (ease of use).
+
+These items needed to be fixed to reduce maintenance nightmares for the
+development community contributing to LTP, and the project maintainers.
+
+Design
+------
+
+The system was designed such that including a single GNU Makefile compatible
+set in each new directory component is all that's essentially required to
+build the system.
+
+Say you had a directory like the following (with ``.c`` files in them which
+directly tie into applications, e.g. baz.c -> baz):
+
+.. code-block::
+
+    .../foo/
+        |--> Makefile
+        |
+        --> bar/
+            |
+            --> Makefile
+            |
+            --> baz.c
+
+.. code-block:: make
+  :caption: .../foo/Makefile
+
+    #
+    # Copyright disclaimer goes here -- please use GPLv2.
+    #
+
+    top_srcdir		?= ..
+
+    include $(top_srcdir)/include/mk/env_pre.mk
+    include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+.. code-block:: make
+  :caption: .../foo/bar/Makefile
+
+    #
+    # Copyright disclaimer goes here -- please use GPLv2.
+    #
+
+    top_srcdir		?= ../..
+
+    include $(top_srcdir)/include/mk/env_pre.mk
+    include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+Kernel Modules
+--------------
+
+Some of the tests need to build kernel modules, happily LTP has
+infrastructure for this.
+
+.. code-block:: make
+
+    ifneq ($(KERNELRELEASE),)
+
+    obj-m := module01.o
+
+    else
+
+    top_srcdir	?= ../../../..
+    include $(top_srcdir)/include/mk/testcases.mk
+
+    REQ_VERSION_MAJOR	:= 2
+    REQ_VERSION_PATCH	:= 6
+    MAKE_TARGETS		:= test01 test02 module01.ko
+
+    include $(top_srcdir)/include/mk/module.mk
+    include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+    endif
+
+This is a Makefile example that allows you to build kernel modules inside LTP.
+The prerequisites for the build are detected by the ``configure`` script.
+
+The ``REQ_VERSION_MAJOR`` and ``REQ_VERSION_PATCH`` describe minimal kernel
+version for which the build system tries to build the module.
+
+The build system is also forward compatible with changes in Linux kernel
+internal API so that, if module fails to build, the failure is ignored both on
+build and installation. If the userspace counterpart of the test fails to load
+the module because the file does not exists, the test is skipped.
+
+Note the ``ifneq($(KERNELRELEASE),)``. The reason it exists, it is that the
+Makefile is executed twice: once by LTP build system and once by kernel
+kbuild, see ``Documentation/kbuild/modules.rst`` in the Linux kernel tree for
+details on external module build.
+
+Make Rules and Make Variables
+-----------------------------
+
+When using make rules, avoid writing ad hoc rules like:
+
+.. code-block:: make
+
+    [prog]: [dependencies]
+        cc -I../../include $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) \
+	    -o [prog] [dependencies]
+
+This makes cross-compilation and determinism difficult, if not impossible.
+Besides, implicit rules are your friends and as long as you use ``MAKEOPTS=;``
+in the top-level caller (or do ``$(subst r,$(MAKEOPTS)``) to remove ``-r``),
+the compile will complete successfully, assuming all other prerequisites have
+been fulfilled (libraries, headers, etc).
+
+.. list-table::
+    :header-rows: 1
+
+    * - Variable
+      - Explaination
+
+    * - $(AR)
+      - The library archiver
+
+    * - $(CC)
+      - The system C compiler
+
+    * - $(CCP)
+      - The system C preprocessor
+
+    * - $(CFLAGS)
+      - C compiler flags
+
+    * - $(CPPFLAGS)
+      - Preprocessor flags, e.g. ``-I`` arguments
+
+    * - $(DEBUG_CFLAGS)
+      - Debug flags to pass to ``$(CC)``, ``-g``, etc
+
+    * - $(KVM_LD)
+      - Special linker for wrapping KVM payload binaries into linkable object
+        files. Defaults to ``$(LD)``. Change this variable if the KVM Makefile
+        fails to build files named ``*-payload.o``
+
+    * - $(LD)
+      - The system linker (typically ``$(CC)``, but not necessarily)
+
+    * - $(LDFLAGS)
+      - What to pass in to the linker, including ``-L`` arguments and other ld
+        arguments, apart from ``-l`` library includes (see ``$(LDLIBS)``).
+        This should be done in the ``$(CC)`` args passing style when
+        ``LD := $(CC)``, e.g. ``-Wl,-foo``, as opposed to ``-foo``
+
+    * - $(LDLIBS)
+      - Libraries to pass to the linker (e.g. ``-lltp``, etc)
+
+    * - $(LTPLDLIBS)
+      - LTP internal libraries i.e. these in libs/ directory
+
+    * - $(OPT_CFLAGS)
+      - Optimization flags to pass into the C compiler, ``-O2``, etc. If you
+        specify ``-O2`` or higher, you should also specify
+        ``-fno-strict-aliasing``, because of gcc fstrict-aliasing optimization
+        bugs in the tree optimizer. Search for **fstrict-aliasing optimization
+        bug** with your favorite search engine.
+
+        Examples of more recent bugs: tree-optimization/17510
+        and tree-optimization/39100.
+
+        Various bugs have occurred in the past due to buggy logic in the
+        tree-optimization portion of the gcc compiler, from 3.3.x to 4.4.
+
+    * - $(RANLIB)
+      - What to run after archiving a library
+
+    * - $(WCFLAGS)
+      - Warning flags to pass to ``$(CC)``, e.g. ``-Werror``, ``-Wall``, etc.
+
+Make System Variables
+---------------------
+
+A series of variables are used within the make system that direct what actions
+need to be taken. Rather than listing the variables here, please refer to the
+comments contained in ``.../include/mk/env_pre.mk``.
+
+Guidelines and Recommendations
+------------------------------
+
+Of course, GNU Make manual is the key to understand the Make system, but
+following manuals are probably the most important:
+
+* `Implicit Rules <http://www.gnu.org/software/make/manual/make.html#Implicit-Rules>`_
+* `Variables and Expansion <http://www.gnu.org/software/make/manual/make.html#Using-Variables>`_
+* `Origin Use <http://www.gnu.org/software/make/manual/make.html#Origin-Function>`_
+* `VPath Use <http://www.gnu.org/software/make/manual/make.html#Directory-Search>`_
+
+.. warning::
+
+    Rebuild from scratch before committing anything in the build system.
diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
new file mode 100644
index 000000000..7a4e6b2ad
--- /dev/null
+++ b/doc/developers/debugging.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Debugging
+=========
+
+This section explains some tricks which can be used to debug test binaries.
+
+Debug messages
+--------------
+
+The LTP framework currently supports ``TDEBUG`` flag test debug messages. These
+messages can be enabled using the ``-D`` test's argument.
+
+Tracing and debugging syscalls
+------------------------------
+
+The new test library runs the actual test (i.e. the ``test()`` function) in a
+forked process. To get stack trace of a crashing test in gdb it's needed to
+`set follow-fork-mode child <https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html>`_.
+To trace the test, please use ``strace -f`` to enable tracing also for the
+forked processes.
diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
new file mode 100644
index 000000000..85b69c11c
--- /dev/null
+++ b/doc/developers/ltp_library.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+LTP Library guidelines
+======================
+
+General Rules
+-------------
+
+When we extend library API, we need to apply the same general rules that we use
+when writing tests, plus:
+
+#. LTP library tests must go inside ``lib/newlib_tests`` directory
+#. LTP documentation has to be updated according to API changes
+
+Shell API
+---------
+
+API source code is in ``tst_test.sh``, ``tst_security.sh`` and ``tst_net.sh``
+(all in ``testcases/lib`` directory).
+
+Changes in the shell API should not introduce uncommon dependencies
+(use basic commands installed everywhere by default).
+
+Shell libraries
+~~~~~~~~~~~~~~~
+
+Aside from shell API libraries in ``testcases/lib``, it's worth putting
+common code for a group of tests into a shell library. The filename
+should end with ``_lib.sh`` and the library should load ``tst_test.sh`` or
+``tst_net.sh``.
+
+Shell libraries should have conditional expansion for ``TST_SETUP`` or
+``TST_CLEANUP``, to avoid surprises when test specific setup/cleanup function is
+redefined by shell library.
+
+.. code-block:: bash
+
+    # ipsec_lib.sh
+    # SPDX-License-Identifier: GPL-2.0-or-later
+    TST_SETUP="${TST_SETUP:-ipsec_lib_setup}"
+    ...
+    . tst_test.sh
diff --git a/doc/developers/setup_mailinglist.rst b/doc/developers/setup_mailinglist.rst
new file mode 100644
index 000000000..1eee0ae9f
--- /dev/null
+++ b/doc/developers/setup_mailinglist.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Setting up the Mailing list
+===========================
+
+Before using ``git send-email``, you need to set up your email client to send
+emails from the command line. This typically involves configuring an SMTP server
+and authentication details.
+
+Open a terminal and configure Git with your email settings using the following
+commands:
+
+.. code-block:: bash
+
+    git config --global sendemail.from "Your Name <your_email@example.com>"
+    git config --global sendemail.smtpserver "smtp.example.com"
+    git config --global sendemail.smtpuser "your_email@example.com"
+    git config --global sendemail.smtpserverport 587
+    git config --global sendemail.smtpencryption tls
+
+Replace ``smtp.example.com`` with the SMTP server address provided by your email
+provider. Replace ``your_email@example.com`` with your email address. Adjust the
+SMTP port and encryption settings according to your email provider's
+requirements.
+
+To test the configuration you can use ``--dry-run`` parameter.
+
+.. code-block:: bash
+
+    git send-email --dry-run --to "ltp@lists.linux.it" --subject "Test Email" --body "This is a test email." HEAD^
+
+Depending on your SMTP server's configuration, you may need to authenticate
+before sending emails. If required, configure authentication settings using:
+
+.. code-block:: bash
+
+    git config --global sendemail.smtpuser "your_email@example.com"
+    git config --global sendemail.smtppass "your_password"
+
+Replace ``your_email@example.com`` with your email address and ``your_password``
+with your email account password.
+
+For any corner case, please take a look at the
+`email + git <https://git-send-email.io/>`_ documentation.
+
+.. note::
+
+    This method still works in most of the cases, but nowadays we often
+    require to setup a two factor authentication. If this is the case, please
+    consider setting up Git accordingly.
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
new file mode 100644
index 000000000..ae7d59959
--- /dev/null
+++ b/doc/developers/test_case_tutorial.rst
@@ -0,0 +1,1038 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Test case tutorial
+==================
+
+This is a step-by-step tutorial on writing a simple C LTP test, where topics
+of the LTP and Linux kernel testing will be introduced gradually using a
+concrete example. Most sections will include exercises, some trivial and
+others not so much. If you find an exercise is leading you off at too much of
+a tangent, just leave it for later and move on.
+
+LTP tests can be written in C or Shell script. This tutorial is **only for tests
+written in C** using the new LTP test API. Note that while we go into some
+detail on using Git, this is not intended as a canonical or complete guide
+for Git.
+
+Assumptions & Feedback
+----------------------
+
+We assume the reader is familiar with C, Git and common Unix/Linux/GNU tools
+and has some general knowledge of Operating Systems. Experienced Linux
+developers may find it too verbose while people new to system level Linux
+development may find it overwhelming.
+
+Comments and feedback are welcome, please direct them to the Mailing list.
+
+Getting Started
+---------------
+
+First of all, make sure you have a copy of LTP in the current folder
+and we recommended cloning the Linux kernel repository for reference, this
+guide will refer to files and directories.
+
+.. code-block:: bash
+
+    git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+
+There are a number of other repositories which are useful for reference as
+well, including the GNU C library ``glibc`` and the alternative C library
+``musl``. Some system calls are partially or even entirely implemented in user
+land as part of the standard C library. So in these cases, the C library is an
+important reference. ``glibc`` is the most common C library for Linux, however
+``musl`` is generally easier to understand.
+
+How system calls are implemented varies from one architecture to another and
+across kernel and C library versions. To find out whether a system call is
+actually accessing the kernel (whether it is actually a system call) on any
+given machine you can use the ``strace`` utility. This intercepts system calls
+made by an executable and prints them. We will use this later in the tutorial.
+
+Choose a System Call to test
+----------------------------
+
+We will use the ``statx()`` system call, to provide a concrete example of a
+test. At the time of writing there is no test for this call which was
+introduced in Linux kernel version 4.11.
+
+Linux system call specific tests are primarily contained in
+``testcases/kernel/syscalls``, but you should also ``git grep`` the entire LTP
+repository to check for any existing usages of a system call.
+
+One way to find a system call which is not currently tested by the LTP is to
+look at ``include/linux/syscalls.h`` in the kernel tree.
+
+Something the LTP excels to ensure bug-fixes are back ported to
+maintenance releases, so targeting a specific regression is another
+option.
+
+Find an untested System call
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Try to find an untested system call which has a manual page (i.e. ``man
+syscall`` produces a result). It is a good idea to Git-clone the latest kernel
+man-pages repository.
+
+.. code-block:: bash
+
+    git clone git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
+
+At the time of writing, the difference between the latest man-pages release and
+the ``HEAD`` of the repository (usually the latest commit) is well over 100
+commits. This represents about 9 weeks of changes. If you are using a stable
+Linux distribution, your man-pages package may well be years old. So as with
+the kernel, it is best to have the Git repository as a reference.
+
+You could also find a system call with untested parameters or use whatever it
+is you are planning to use the LTP for.
+
+Create the test skeleton
+------------------------
+
+I shall call my test ``statx01.c``, by the time you read this that file name
+will probably be taken, so increment the number in the file name as
+appropriate or replace ``statx`` with the system call in the chosen exercise.
+
+.. code-block:: bash
+
+    mkdir testcases/kernel/syscalls/statx
+    cd testcases/kernel/syscalls/statx
+    echo statx >> .gitignore
+
+Next open ``statx01.c`` and add the following boilerplate. Make sure to change
+the copyright notice to your name/company, correct the test name and minimum
+kernel version if necessary. I will explain what the code does below.
+
+.. code-block:: c
+
+    // SPDX-License-Identifier: GPL-2.0-or-later
+    /*
+    * Copyright (c) 2017 Instruction Ignorer <"can't"@be.bothered.com>
+    */
+
+    /*\
+    * [Description]
+    *
+    * All tests should start with a description of _what_ we are testing.
+    * Non-trivial explanations of _how_ the code works should also go here.
+    * Include relevant links, Git commit hashes and CVE numbers.
+    * Inline comments should be avoided.
+    */
+
+    #include "tst_test.h"
+
+    static void run(void)
+    {
+        tst_res(TPASS, "Doing hardly anything is easy");
+    }
+
+    static struct tst_test test = {
+        .test_all = run,
+        .min_kver = "4.11",
+    };
+
+Starting with the ``#include`` statement we copy in the main LTP test library
+headers. This includes the most common test API functions and the test harness
+initialisation code. It is important to note that this is a completely
+ordinary, independent C program, however ``main()`` is missing because it is
+implemented in ``tst_test.h``.
+
+We specify what code we want to run as part of the test using the ``tst_test
+test`` structure. Various callbacks can be set by the test writer, including
+``test.test_all``, which we have set to ``run()``. The test harness will execute
+this callback in a separate process (using ``fork()``), forcibly terminating it
+if it does not return after ``test.timeout`` seconds.
+
+We have also set ``test.min_kver`` to the kernel version where ``statx`` was
+introduced. The test library will determine the kernel version at runtime. If
+the version is less than 4.11 then the test harness will return ``TCONF``,
+indicating that this test is not suitable for the current system
+configuration.
+
+Occasionally features are back ported to older kernel versions, so ``statx`` may
+exist on kernels with a lower version. However we don't need to worry about
+that unless there is evidence of it happening.
+
+As mentioned in the code itself, you should specify what you are testing and
+the expected outcome, even if it is relatively simple. If your program flow is
+necessarily complex and difficult to understand (which is often the case when
+trying to manipulate the kernel into doing something bad), then a detailed
+explanation of how the code works is welcome.
+
+What you should not do, is use inline comments or include the same level of
+explanation which is written here. As a general rule, if something is easy to
+document, then the code should also be easy to read. So don't document the easy
+stuff (except for the basic test specification).
+
+Before continuing we should compile this and check that the basics work. In
+order to compile the test we need a ``Makefile`` in the same subdirectory. If
+one already exists, then nothing needs to be done, otherwise add one with the
+following contents.
+
+.. code-block:: make
+
+    # SPDX-License-Identifier: GPL-2.0-or-later
+    # Copyright (c) 2019 Linux Test Project
+
+    top_srcdir		?= ../../../..
+
+    include $(top_srcdir)/include/mk/testcases.mk
+
+    include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+This will automatically add ``statx01.c`` as a build target producing a
+``statx01`` executable. Unless you have heavily deviated from the tutorial, and
+probably need to change ``top_srcdir``, nothing else needs to be done.
+
+Normally, if you were starting a Makefile from scratch, then you would need to
+add ``statx01`` as a build target. Specifying that you would like to run some
+program (e.g. ``gcc`` or ``clang``) to transform ``statx01.c`` into ``statx01``.
+Here we don't need to do that, but sometimes it is still necessary. For example,
+if we needed to link to the POSIX threading library, then we could add the
+following line after ``testcases.mk``.
+
+.. code-block:: make
+
+    statx01: CFLAGS += -pthread
+
+Assuming you are in the test's subdirectory ``testcases/kernel/syscalls/statx``,
+please do:
+
+.. code-block:: bash
+
+    make
+    ./statx01
+
+This should build the test and then run it. However, even though the test is
+in the ``syscalls`` directory it won't be automatically ran as part of the
+_syscalls_ test group (remember ``./runltp -f syscalls`` from the
+``README.md``?). For this we need to add it to the ``runtest`` file. So open
+``runtest/syscalls`` and add the lines starting with a ``+``.
+
+.. code-block::
+
+    statvfs01 statvfs01
+    statvfs02 statvfs02
+
+    +statx01 statx01
+    +
+    stime01 stime01
+    stime02 stime02
+
+The ``runtest`` files are in a two column format. The first column is the test
+name, which is mainly used by test runners for reporting and filtering. It is
+just a single string of text with no spaces. The second column, which can
+contain spaces, is passed to the shell in order to execute the test. Often it
+is just the executable name, but some tests also take arguments (the LTP has a
+library for argument parsing, by the way).
+
+If you haven't done so already, we should add all these new files to Git. It
+is vitally important that you do not make changes to the master branch. If you
+do then pulling changes from upstream becomes a major issue. So first of all
+create a new branch.
+
+.. code-block:: bash
+
+    git checkout -b statx01 master
+
+Now we want to add the files we have created or modified, but before doing a
+commit make sure you have configured Git correctly. You need to at least set
+your Name and e-mail address in ``~/.gitconfig``, but there are some other
+settings which come in handy too. My relatively simple configuration is similar
+to the below:
+
+.. code-block:: ini
+
+    [user]
+        name = Sarah Jane
+        email = sjane@e-mail.address
+    [core]
+        editor = emacs
+    [sendemail]
+        smtpServer = smtp.server.address
+
+Obviously you need to at least change your name and e-mail. The SMTP server is
+useful for ``git send-email``, which we will discuss later. The editor value is
+used for things like writing commits (without the ``-m`` option).
+
+.. code-block:: bash
+
+    git add -v :/testcases/kernel/syscalls/statx :/runtest/syscalls
+    git commit -m "statx01: Add new test for statx syscall"
+
+This should add all the new files in the ``statx`` directory and the ``runtest``
+file. It is good practice to commit early and often. Later on we will do a
+Git-rebase, which allows us to clean up the commit history. So don't worry
+about how presentable your commit log is for now. Also don't hesitate to
+create a new branch when doing the exercises or experimenting. This will allow
+you to diverge from the tutorial and then easily come back again.
+
+I can't emphasize enough that Git makes things easy through branching and that
+things quickly get complicated if you don't do it. However if you do get into
+a mess, Git-reflog and Git-reset, will usually get you out of it. If you also
+mess that up then it may be possible to cherry pick 'dangling' commits out of
+the database into a branch.
+
+Report TCONF instead of TPASS
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Maybe the test should report ``TCONF: Not implemented`` instead or perhaps
+``TBROK``. Try changing it do so.
+
+Check Git ignores the executable
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Is your ``.gitignore`` correct?
+
+Run make check
+~~~~~~~~~~~~~~~~~~
+
+Check coding style with ``make check``.
+
+Install the LTP and run the test with runtest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Run ``statx01`` on its own, also using ``-I0`` amd ``-I10``.
+
+Call the system call
+--------------------
+
+At the time of writing ``statx`` has no ``glibc`` wrapper. It is also fairly common
+for a distribution's C library version to be older than its kernel or it may use a
+cut down C library in comparison to the GNU one. So we must call ``statx()``
+using the general ``syscall()`` interface.
+
+The LTP contains a library for dealing with the ``syscall`` interface, which is
+located in ``include/lapi``. System call numbers are listed against the relevant
+call in the ``*.in`` files (e.g. ``x86_64.in``) which are used to generate
+``syscalls.h``, which is the header you should include. On rare occasions you
+may find the system call number is missing from the ``*.in`` files and will need
+to add it (see ``include/lapi/syscalls/strip_syscall.awk``).
+
+System call numbers vary between architectures, hence there are multiple
+``*.in`` files for each architecture. You can find the various values for the
+``statx`` system call across a number of ``unistd.h`` files in the Linux kernel.
+
+Note that we don't use the system-call-identifier value available in
+``/usr/include/linux/uinstd.h`` because the kernel might be much newer than the
+user land development packages.
+
+For ``statx`` we had to add ``statx 332`` to ``include/lapi/syscalls/x86_64.in``,
+``statx 383`` to ``include/lapi/syscalls/powerpc.in``, etc.  Now lets look at
+the code, which I will explain in more detail further down.
+
+.. code-block:: c
+
+    /*
+    * Test statx
+    *
+    * Check if statx exists and what error code it returns when we give it dodgy
+    * data.
+    */
+
+    #include <stdint.h>
+    #include "tst_test.h"
+    #include "lapi/syscalls.h"
+
+    struct statx_timestamp {
+        int64_t	       tv_sec;
+        uint32_t       tv_nsec;
+        int32_t	       __reserved;
+    };
+
+    struct statx {
+        uint32_t	stx_mask;
+        uint32_t	stx_blksize;
+        uint64_t	stx_attributes;
+        uint32_t	stx_nlink;
+        uint32_t	stx_uid;
+        uint32_t	stx_gid;
+        uint16_t	stx_mode;
+        uint16_t	__spare0[1];
+        uint64_t	stx_ino;
+        uint64_t	stx_size;
+        uint64_t	stx_blocks;
+        uint64_t	stx_attributes_mask;
+        struct statx_timestamp	stx_atime;
+        struct statx_timestamp	stx_btime;
+        struct statx_timestamp	stx_ctime;
+        struct statx_timestamp	stx_mtime;
+        uint32_t	stx_rdev_major;
+        uint32_t	stx_rdev_minor;
+        uint32_t	stx_dev_major;
+        uint32_t	stx_dev_minor;
+        uint64_t	__spare2[14];
+    };
+
+    static int sys_statx(int dirfd, const char *pathname, int flags,
+                unsigned int mask, struct statx *statxbuf)
+    {
+        return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+    }
+
+    ...
+
+So the top part of the code is now boiler plate for calling ``statx``. It is
+common for the kernel to be newer than the user land libraries and headers. So
+for new system calls like ``statx``, we copy, with a few modifications, the
+relevant definitions into the LTP. This is somewhat like 'vendoring', although
+we are usually just copying headers required for interacting with the Kernel's
+ABI (Application Binary Interface), rather than internalising actual
+functionality.
+
+So from the top we include the ``stdint.h`` library which gives us the standard
+``(u)int*_t`` type definitions. We use these in place of the Kernel type
+definitions such as ``__u64`` in ``linux/types.h``. We then have a couple of
+structure definitions which form part of the ``statx`` API. These were copied
+from ``include/uapi/linux/stat.h`` in the Kernel tree.
+
+After that, there is a wrapper function, which saves us from writing
+``tst_syscall(__NR_statx, ...``, every time we want to make a call to
+``statx``. This also provides a stub for when ``statx`` is eventually integrated
+into the LTP library and also implemented by the C library. At that point we
+can switch to using the C library implementation if available or fallback to
+our own.
+
+The advantage of using the C library implementation is that it will often be
+better supported across multiple architectures. It will also mean we are using
+the system call in the same way most real programs would. Sometimes there are
+advantages to bypassing the C library, but in general it should not be our
+first choice.
+
+The final test should do a check during configuration (i.e. when we run
+``./configure`` before building) which checks if the ``statx`` system call and
+associated structures exists. This requires writing an ``m4`` file for use with
+``configure.ac`` which is processed during ``make autotools`` and produces the
+configure script.
+
+For the time being though we shall just ignore this. All you need to know for
+now is that this is a problem which eventually needs to be dealt with and that
+there is a system in place to handle it.
+
+.. code-block:: c
+
+    ...
+
+    static void run(void)
+    {
+        struct statx statxbuf = { 0 };
+
+        TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
+
+        if (TST_RET == 0)
+            tst_res(TFAIL, "statx thinks it can stat NULL");
+        else if (TST_ERR == EFAULT)
+            tst_res(TPASS, "statx set errno to EFAULT as expected");
+        else
+            tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
+    }
+
+    static struct tst_test test = {
+        .test_all = run,
+        .min_kver = "4.11",
+    };
+
+The ``TEST`` macro sets ``TST_RET`` to the return value of ``tst_statx()`` and
+``TST_ERR`` to the value of ``errno`` immediately after the functions
+return. This is mainly just for convenience, although it potentially could
+have other uses.
+
+We check whether the return value indicates success and if it doesn't also
+check the value of ``errno``. The last call to ``tst_res`` includes ``TERRNO``,
+which will print the current error number and associated description in
+addition to the message we have provided. Note that it uses the current value
+of ``errno`` not ``TST_ERR``.
+
+What we should have done in the example above is use ``TTERRNO`` which takes the
+value of ``TST_ERR``.
+
+If we try to run the test on a kernel where ``statx`` does not exist, then
+``tst_syscall`` will cause it to fail gracefully with ``TCONF``. Where ``TCONF``
+indicates the test is not applicable to our configuration.
+
+The function ``tst_syscall`` calls ``tst_brk(TCONF,...)`` on failure. ``tst_brk``
+causes the test to exit immediately, which prevents any further test code from
+being run.
+
+What are the differences between ``tst_brk`` and ``tst_res``?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+See ``include/tst_test.h``. Also what do they have in common?
+
+What happens if you call ``tst_res(TINFO, ...)`` after ``sys_statx``?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Does the test still function correctly?
+
+Extend the test to handle other basic error conditions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For example, see if you can trigger ``ENOENT`` instead. You shouldn't
+have to create any files, which is discussed in the next section.
+
+Setup, Cleanup and files
+------------------------
+
+Some tests require resources to be allocated, or system settings to be
+changed, before the test begins. This ``setup`` only has to be done once at the
+beginning and at the end of the test needs to be removed or reverted. The
+``cleanup`` also has to be done regardless of whether the test breaks.
+
+Fortunately, like most test libraries, we have setup and cleanup (teardown)
+callbacks. ``setup`` is called once before ``run`` and ``cleanup`` is called once
+afterwards. Note that ``run`` itself can be called multiple times by the test
+harness, but that ``setup`` and ``cleanup`` are only called once.
+
+If either your code, a ``SAFE_*`` macro or a library function such as
+``tst_syscall`` call ``tst_brk``, then ``run`` will exit immediately and the
+``cleanup`` function is then called. Once ``cleanup`` is completed, the test
+executable will then exit altogether abandoning any remaining iterations of
+``run``.
+
+For ``statx`` we would like to create some files or file like objects which we
+have control over. Deciding where to create the files is easy, we just create
+it in the current working directory and let the LTP test harness handle where
+that should be by setting ``.needs_tmpdir = 1``.
+
+.. code-block:: c
+
+    /*
+    * Test statx
+    *
+    * Check if statx exists and what error code it returns when we give it dodgy
+    * data. Then stat a file and check it returns success.
+    */
+
+    #include <stdint.h>
+    #include "tst_test.h"
+    #include "lapi/syscalls.h"
+    #include "lapi/fcntl.h"
+
+    #define FNAME "file_to_stat"
+    #define STATX_BASIC_STATS 0x000007ffU
+
+    /*************** statx structure and wrapper goes here ! ***************/
+    ...
+
+We have added an extra include ``lapi/fcntl.h`` which wraps the system header by
+the same name (``#include <fcntl.h>``). This header ensures we have definitions
+for recently added macros such as ``AT_FDCWD`` by providing fall backs if the
+system header does not have them. The ``lapi`` directory contains a number of
+headers like this.
+
+At some point we may wish to add ``lapi/stat.h`` to provide a fall back for
+macros such as ``STATX_BASIC_STATS``. However for the time being we have just
+defined it in the test.
+
+
+.. code-block:: c
+
+    ...
+
+    static void setup(void)
+    {
+        SAFE_TOUCH(FNAME, 0777, NULL);
+    }
+
+    static void run(void)
+    {
+        struct statx statxbuf = { 0 };
+
+        TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
+        if (TST_RET == 0)
+            tst_res(TFAIL, "statx thinks it can stat NULL");
+        else if (TST_ERR == EFAULT)
+            tst_res(TPASS, "statx set errno to EFAULT as expected");
+        else
+            tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
+
+        TEST(sys_statx(AT_FDCWD, FNAME, 0, STATX_BASIC_STATS, &statxbuf));
+        if (TST_RET == 0)
+            tst_res(TPASS, "It returned zero so it must have worked!");
+        else
+            tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
+    }
+
+    static struct tst_test test = {
+        .setup = setup,
+        .test_all = run,
+        .min_kver = "4.11",
+        .needs_tmpdir = 1
+    };
+
+The ``setup`` callback uses one of the LTP's ``SAFE`` functions to create an empty
+file ``file_to_stat``. Because we have set ``.needs_tmpdir``, we can just create
+this file in the present working directory. We don't need to create a
+``cleanup`` callback yet because the LTP test harness will recursively delete
+the temporary directory and its contents.
+
+The ``run`` function can be called multiple times by the test harness, however
+``setup`` and ``cleanup`` callbacks will only be ran once.
+
+.. warning::
+
+    By this point you may have begun to explore the LTP library headers or older
+    tests. In which case you will have come across functions from the old API such
+    as ``tst_brkm``. The old API is being phased out, so you should not use these
+    functions.
+
+So far we haven't had to do any clean up. So our example doesn't answer the
+question "what happens if part of the clean up fails?". To answer this we are
+going to modify the test to ask the (highly contrived) question "What happens
+if I create and open a file, then create a hard-link to it, then call open
+again on the hard-link, then ``stat`` the file".
+
+
+.. code-block:: c
+
+    #define LNAME "file_to_stat_link"
+
+    ...
+
+    static void setup(void)
+    {
+        fd = SAFE_OPEN(FNAME, O_CREAT, 0777);
+        SAFE_LINK(FNAME, LNAME);
+        lfd = SAFE_OPEN(LNAME, 0);
+    }
+
+    static void cleanup(void)
+    {
+        if (lfd != 0)
+            SAFE_CLOSE(lfd);
+
+        if (fd != 0)
+            SAFE_CLOSE(fd);
+    }
+
+    static void run(void)
+    {
+            ...
+
+        TEST(sys_statx(AT_FDCWD, LNAME, 0, STATX_BASIC_STATS, &statxbuf));
+        if (TST_RET == 0)
+            tst_res(TPASS, "It returned zero so it must have worked!");
+        else
+            tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
+    }
+
+    static struct tst_test test = {
+        .setup = setup,
+        .cleanup = cleanup,
+        .test_all = run,
+        .tcnt = 2,
+        .min_kver = "4.11",
+        .needs_tmpdir = 1
+    };
+
+Because we are now opening a file, we need a ``cleanup`` function to close the
+file descriptors. We have to manually close the files to ensure the temporary
+directory is deleted by the test harness (see the
+https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines[test
+writing guidelines] for details).
+
+As a matter of good practice, the file descriptors are closed in reverse
+order. In some circumstances the order in which clean up is performed is
+significant. In that case resources created towards the end of 'setup' are
+dependent on ones near the beginning. So during 'cleanup' we remove the
+dependants before their dependencies.
+
+If, for some reason, the file descriptor ``lfd`` became invalid during the test,
+but ``fd`` was still open, we do not want ``SAFE_CLOSE(lfd)`` to cause the
+``cleanup`` function to exit prematurely. If it did, then ``fd`` would remain open
+which would cause problems on some file systems.
+
+Nor do we want to call ``cleanup`` recursively. So during 'cleanup' ``tst_brk``,
+and consequently the ``SAFE`` functions, do not cause the test to exit with
+``TBROK``. Instead they just print an error message with ``TWARN``.
+
+It is not entirely necessary to check if the file descriptors have a none zero
+value before attempting to close them. However it avoids a bunch of spurious
+warning messages if we fail to open ``file_to_stat``. Test case failures can be
+difficult to interpret at the best of times, so avoid filling the log with
+noise.
+
+Check ``statx`` returns the correct number of hard links
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The field ``statx.stx_nlink`` should be equal to 2, right?
+
+Git-branch
+~~~~~~~~~~
+
+We are about to make some organisational changes to the test, so now would be
+a good time to branch. Then we can switch between the old and new versions, to
+check the behavior has not been changed by accident.
+
+Split the test
+--------------
+
+In our current test, we have essentially rolled two different test cases into
+one. Firstly we check if an error is returned when bad arguments are provided
+and secondly we check what happens when we stat an actual file. Quite often it
+makes sense to call ``tst_res`` multiple times in a single test case because we
+are checking different properties of the same result, but here we are clearly
+testing two different scenarios.
+
+So we should split the test in two. One obvious way to do this is to create
+``statx02.c``, but that seems like overkill in order to separate two simple test
+cases. So, for now at least, we are going to do it a different way.
+
+.. code-block:: c
+
+    ...
+
+    static void run_stat_null(void)
+    {
+        struct statx statxbuf = { 0 };
+
+        TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
+        if (TST_RET == 0)
+            tst_res(TFAIL, "statx thinks it can stat NULL");
+        else if (TST_ERR == EFAULT)
+            tst_res(TPASS, "statx set errno to EFAULT as expected");
+        else
+            tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
+    }
+
+    static void run_stat_symlink(void)
+    {
+        struct statx statxbuf = { 0 };
+
+        TEST(sys_statx(AT_FDCWD, LNAME, 0, STATX_BASIC_STATS, &statxbuf));
+        if (TST_RET == 0)
+            tst_res(TPASS, "It returned zero so it must have worked!");
+        else
+            tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
+    }
+
+    static void run(unsigned int i)
+    {
+        switch(i) {
+        case 0: run_stat_null();
+        case 1: run_stat_symlink();
+        }
+    }
+
+    static struct tst_test test = {
+        .setup = setup,
+        .cleanup = cleanup,
+        .test = run,
+        .tcnt = 2,
+        .min_kver = "4.11",
+        .needs_tmpdir = 1
+    };
+
+So we have used an alternative form of the ``test`` or ``run`` callback which
+accepts an index. Some tests use this index with an array of parameters and
+expected return values. Others do something similar to the above. The index
+can be used how you want so long as each iteration calls ``tst_res`` in a
+meaningful way.
+
+If an iteration fails to return a result (i.e. call ``tst_res`` with a value
+other than ``TINFO``) then the test harness will report ``TBROK`` and print the
+iteration which failed. This prevents a scenario in your test from silently
+failing due to some faulty logic.
+
+What is wrong with the switch statement?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Were you paying attention? Also see the output of ``make check``.
+
+Test a feature unique to statx
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+So far we have not tested anything which is unique to ``statx``. So, for
+example, you could check stx_btime is correct (possibly only to within a
+margin of error) and that it differs from ``stx_mtime`` after writing to the
+file.
+
+Alternatively you could check that ``stx_dev_major`` and ``stx_dev_minor`` are set
+correctly. Note that the LTP has helper functions for creating devices and
+file systems.
+
+This could be quite a challenging exercise. You may wish to tackle an
+altogether different test scenario instead. If you get stuck just move onto
+the next section and come back later.
+
+Submitting the test for review
+------------------------------
+
+Ignoring the fact we should probably create ``lapi/stat.h`` along with a bunch
+of fallback logic in the build system. We can now get our test ready for
+submission.
+
+The first thing you need to do before considering submitting your test is run
+``make check-statx01`` or ``make check`` in the test's directory. Again, we use
+the kernel style guidelines where possible. Next you should create a new
+branch, this will allow you to reshape your commit history without fear.
+
+After that we have the pleasure of doing an interactive ``rebase`` to clean up
+our commit history. In its current form the test only really needs a single
+commit, but if you have been using Git correctly then you should have
+many. The main reason we want to compress it to a single commit, is to make
+the LTP's Git-log readable. It also allows us to write a coherent description
+of the work as a whole in retrospective. Although, when adding a new test, the
+test description in the code will probably make the commit message redundant.
+
+Anyway, as an example, we shall look at my personal commit history from this
+tutorial and ``rebase`` it. You should try following along with your own
+repository. First lets look at the commit history since we branched from
+master.
+
+.. code-block:: bash
+
+    git log --oneline master..HEAD
+    152d39fe7 (HEAD -> tutorial-rebase2, tutorial-rebase) tutorial: Start Submitting patch section
+    70f7ce7ce statx01: Stop checkpatch from complaining
+    bb0332bd7 tutorial: Fix review problems
+    6a87a084a statx01: Fix review problems
+    d784b1e85 test-writing-guidelines: Remove old API argument
+    c26e1be7a fixup! tutorial
+    1e24a5fb5 (me/tutorial-rebase) fixup! tutorial
+    568a3f7be fixup! tutorial
+    09dd2c829 statx: stage 6
+    bfeef7902 statx: stage 5b
+    76e03d714 statx: stage 5a
+    98f5bc7ac statx: stage 4
+    6f8c16438 statx: stage 3 (Add statx01)
+    5d93b84d8 Add statx and other syscall numbers
+    5ca627b78 tutorial: Add a step-by-step C test tutorial
+
+So we have told git to show all the commits which don't exist in ``master``, but
+are in ``HEAD``, where ``HEAD`` is the top of the current branch. The current
+branch is ``tutorial-rebase2`` which I just created. I have already done one
+``rebase`` and submitted a patch for review, so my original branch was just called
+``tutorial``.
+
+As usual my commit history is starting to look like a bit of mess! There is
+even a commit in there which should not be in the this branch (Remove old API
+argument), however it can be ignored for now and 'cherry picked' into a new branch
+later.
+
+For my patch I actually need at least two commits, one which contains the
+tutorial text and one which contains the test and associated files. So first
+of all I want to 'squash' (amalgamate) all the commits appended with
+``tutorial:`` into the bottom commit.
+
+.. code-block:: bash
+
+    $ git rebase -i 5ca627b78\^
+    ...
+
+This begins an interactive ``rebase`` where commit ``5ca6427b78`` is the earliest
+commit we want to edit. The ``^`` symbol after the commit hash, specifies the
+commit before this one. The interactive ``rebase`` command takes the last commit
+we want to keep unaltered as it's argument (in other words it takes a
+non-inclusive range).
+
+Upon entering a similar command you will be presented with a text file
+similar to the following. The file should be displayed in your text editor of
+choice, if it doesn't, then you may change the editor variable in
+``.gitconfig``.
+
+.. code-block:: bash
+
+    pick 5ca627b78 tutorial: Add a step-by-step C test tutorial
+    pick 5d93b84d8 Add statx and other syscall numbers
+    pick 6f8c16438 statx: stage 3 (Add statx01)
+    pick 98f5bc7ac statx: stage 4
+    pick 76e03d714 statx: stage 5a
+    pick bfeef7902 statx: stage 5b
+    pick 09dd2c829 statx: stage 6
+    pick 568a3f7be fixup! tutorial
+    pick 1e24a5fb5 fixup! tutorial
+    pick c26e1be7a fixup! tutorial
+    pick d784b1e85 test-writing-guidelines: Remove old API argument
+    pick 6a87a084a statx01: Fix review problems
+    pick bb0332bd7 tutorial: Fix review problems
+    pick 70f7ce7ce statx01: Stop checkpatch from complaining
+    pick 152d39fe7 tutorial: Start Submitting patch section
+
+The last commit from Git-log is shown at the top. The left hand column
+contains the commands we want to run on each commit. ``pick`` just means we
+re-apply the commit as-is. We can reorder the lines to apply the commits in a
+different order, but we need to be careful when reordering commits to the same
+file. If your ``rebase`` results in a merge conflict, then you have probably
+reordered some commits which contained changes to the same piece of code.
+
+Perhaps a better name for the interactive ``rebase`` command would be 'replay'. As
+we pick a point in the commit history, undo all those commits before that
+point, then reapply them one at a time. During the replay we can reorder the
+commits, drop, merge, split and edit them, creating a new history.
+
+The commands I am going to use are ``reword`` and ``fixup``. The ``reword`` command
+allows you to edit a single commit's message. The 'fixup' command 'squashes' a
+commit into the commit above/preceding it, merging the two commits into
+one. The commit which has ``fixup`` applied has its commit message deleted. If
+you think a commit might have something useful in its message then you can use
+``squash`` instead.
+
+.. code-block:: bash
+
+    reword 5ca627b78 tutorial: Add a step-by-step C test tutorial
+    fixup 568a3f7be fixup! tutorial
+    fixup 1e24a5fb5 fixup! tutorial
+    fixup c26e1be7a fixup! tutorial
+    fixup bb0332bd7 tutorial: Fix review problems
+    fixup 152d39fe7 tutorial: Start Submitting patch section
+    fixup 276edecab tutorial: Save changes before rebase
+    pick 5d93b84d8 Add statx and other syscall numbers
+    pick 6f8c16438 statx: stage 3 (Add statx01)
+    pick 98f5bc7ac statx: stage 4
+    pick 76e03d714 statx: stage 5a
+    pick bfeef7902 statx: stage 5b
+    pick 09dd2c829 statx: stage 6
+    pick d784b1e85 test-writing-guidelines: Remove old API argument
+    pick 6a87a084a statx01: Fix review problems
+
+So all the commits marked with ``fixup`` will be re-played by Git immediately
+after 5ca62 at the top. A new commit will then be created with the amalgamated
+changes of all the commits and 5ca62's log message. It turns out that I didn't
+need to reword anything, but there is no harm in checking. It is easy to
+forget the ``Signed-off-by:`` line.
+
+I could now do the same for the commits to the ``statx`` test, making the commit
+message prefixes consistent. However I am not actually going to submit the
+test (yet).
+
+I won't attempt to show you this, but if you need to do the opposite and split
+apart a commit. It is also possible using Git-rebase by marking a line with
+``edit``. This will pause Git just after replaying the marked commit. You can
+then use a 'soft' Git-reset to bring the selected commit's changes back into
+the 'index' where you are then able to un-stage some parts before
+re-committing.
+
+You can also use ``edit`` and ``git commit --amend`` together to change a commit
+deep in your history, but without resetting the 'index'. The 'index' contains
+changes which you have staged with ``git add``, but not yet committed.
+
+So now that the commit history has been cleaned up, we need to submit a patch
+to the mailing list or make a pull request on GitHub. The mailing list is the
+preferred place to make submissions and is more difficult for most people, so
+I will only cover that method.
+
+Just before we create the patch, we need to check that our changes will still
+apply to the master branch without problems. To do this we can use another
+type of ``rebase`` and then try rebuilding and running the test.
+
+.. code-block:: bash
+
+    git checkout master
+    git pull origin
+    git checkout tutorial-rebase2
+    git rebase master
+
+Above, I update the master branch and then replay our changes onto it using
+``git rebase master``. You may find that after the rebase there is a merge
+conflict. This will result in something which looks like the following (taken
+from a Makefile conflict which was caused by reordering commits in a ``rebase``).
+
+.. code-block:: diff
+
+    <<<<<<< HEAD
+    cve-2016-7117:	LDFLAGS += -lpthread
+    =======
+    cve-2014-0196:	LDFLAGS += -lpthread -lutil -lrt
+    cve-2016-7117:	LDFLAGS += -lpthread -lrt
+    >>>>>>> 4dbfb8e79... Add -lrt
+
+The first line tells us this is the beginning of a conflict. The third line
+separates the two conflicting pieces of content and the last line is the end
+of the conflict. Usually, all you need to do is remove the lines you don't
+want, stage the changes and continue the ``rebase`` with ``git rebase
+--continue``.
+
+In order to create a patch e-mail we use
+`git format-patch <https://git-scm.com/docs/git-format-patch>`_,
+we can then send that e-mail using
+`git send-email <https://git-scm.com/docs/git-send-email>`_.
+It is also possible to import the patch (``mbox``) file into a number of e-mail
+programs.
+
+.. code-block:: bash
+
+    $ git format-patch -1 -v 2 -o output --to ltp@lists.linux.it fd3cc8596
+    output/v2-0001-tutorial-Add-a-step-by-step-C-test-tutorial.patch
+
+The first argument ``-1`` specifies we want one commit from fd3cc8596
+onwards. If we wanted this commit and the one after it we could specify ``-2``
+instead.
+
+This is my second patch submission so I have used ``-v 2``, which indicates this
+is the second version of a patch set. The ``-o`` option specifies the output
+directory (literally called ``output``). The ``--to`` option adds the ``To:`` e-mail
+header, which I have set to the LTP mailing list.
+
+We can then send this patch with the following command sans ``--dry-run``.
+
+.. code-block:: bash
+
+    git send-email --dry-run output/v2-0001-tutorial-Add-a-step-by-step-C-test-tutorial.patch
+
+Git will ask some questions (which you can ignore) and then tell you what it
+would do if this weren't a dry-run. In order for this to work you have to have
+a valid SMTP server set in ``.gitconfig`` and also be signed up to the LTP
+mailing list under the same e-mail address you have configured in Git. You can
+sign up at https://lists.linux.it/listinfo/ltp.
+
+Doing code review
+-----------------
+
+While waiting for your test to be reviewed, you are invited and encouraged to
+review other contributors' code. This may seem bizarre when you are completely
+new to the project, but there are two important ways in which you can
+contribute here:
+
+A.   Point out logical errors in the code.
+B.   Improve your own understanding
+
+It doesn't matter whether you know the canonical way of writing an LTP test in
+C. An error of logic, when properly explained, is usually indisputable. These
+are the most important errors to find as they always result in false test
+results. Once someone points out such an error it is usually obvious to
+everyone that it is a bug and needs to be fixed.
+
+Obviously testing the patch is one way of finding errors. You can apply
+patches using ``git am``. Then it is just a case of compiling and running the
+tests.
+
+Finally, reading and attempting to comment on other peoples patches, gives
+you a better understanding of the reviewers perspective. This is better for
+the project and for you.
+
+Style and organisational issues are best left to after you have found logical
+errors.
+
+Final notes
+-----------
+
+Hopefully you can now grasp the structure of an LTP test and have some idea of
+what is available in the LTP test library. There are a vast number of library
+functions available (mainly located in include and lib), some of which are
+documented in the test writing guidelines and many of which are not.
+
+We have only scratched the surface of the immense technical complexity of
+systems programming across multiple Kernel and C lib versions as well as
+different hardware architectures. The important thing to take away from this
+is that you have to be conscientious of what will happen on systems different
+from yours. The LTP has a huge and varied user base, so situations you may
+think are unlikely can and do happen to somebody.
+
+Of course you don't want to spend time allowing for situations which may never
+arise either, so you have to do your research and think about each situation
+critically. The more systems you can test on before submitting your changes,
+the better, although we understand not everyone has access to a lab.
+
+One important topic which has not been covered by this tutorial, is
+multi-process or multi-threaded testing. The LTP library functions work inside
+child processes and threads, but their semantics change slightly. There are
+also various helper functions for synchronising and forking processes.
+
+.. note::
+
+    When it comes time to submit a test, the preferred way to do it is on the
+    mailing list although you can also use GitHub. The LTP follows similar rules
+    to the kernel for formatting and submitting patches. Generally speaking the
+    review cycle is easier for small patches, so try to make small changes or
+    additions where possible.
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
new file mode 100644
index 000000000..7b4b70bd0
--- /dev/null
+++ b/doc/developers/writing_tests.rst
@@ -0,0 +1,537 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Writing tests
+=============
+
+This document describes LTP guidelines and it's intended for anybody who wants
+to write or to modify a LTP testcase. It's not a definitive guide and it's not,
+by any means, a substitute for common sense.
+
+Guide to clean and understandable code
+--------------------------------------
+
+Testcases require that the source code is easy to follow. When a test starts to
+fail, the failure has to be analyzed and clean test codebase makes this task
+much easier and quicker.
+
+Keep things simple
+~~~~~~~~~~~~~~~~~~
+
+It's worth to keep testcases simple or, better, as simple as possible.
+
+The kernel and libc are tricky beasts and the complexity imposed by their
+interfaces is quite high. Concentrate on the interface you want to test and
+follow the UNIX philosophy.
+
+It's a good idea to make the test as self-contained as possible too, ideally
+tests should not depend on tools or libraries that are not widely available.
+
+Do not reinvent the wheel!
+
+* Use LTP standard interface
+* Do not add custom PASS/FAIL reporting functions
+* Do not write Makefiles from scratch, use LTP build system instead
+* Etc.
+
+Keep functions and variable names short
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Choosing a good name for an API functions or even variables is a difficult
+task do not underestimate it.
+
+There are a couple of customary names for different things that help people to
+understand code, for example:
+
+* For loop variables are usually named with a single letter ``i``, ``j``, ...
+* File descriptors ``fd`` or ``fd_foo``.
+* Number of bytes stored in file are usually named as ``size`` or ``len``
+* Etc.
+
+Do not overcomment
+~~~~~~~~~~~~~~~~~~
+
+Comments can sometimes save your day, but they can easily do more harm than
+good. There has been several cases where comments and actual implementation
+drifted slowly apart which yielded into API misuses and hard to find bugs.
+Remember there is only one thing worse than no documentation: wrong
+documentation.
+
+Ideally, everybody should write code that is obvious, which unfortunately isn't
+always possible. If there is a code that requires to be commented, keep it
+short and to the point. These comments should explain *why* and not *how*
+things are done.
+
+Never ever comment the obvious.
+
+In case of LTP testcases, it's customary to add an asciidoc formatted comment
+paragraph with highlevel test description at the beginning of the file right
+under the GPL SPDX header. This helps other people to understand the overall
+goal of the test before they dive into the technical details. It's also
+exported into generated documentation hence it should mostly explain what is
+tested.
+
+DRY (Code duplication)
+~~~~~~~~~~~~~~~~~~~~~~
+
+Copy & paste is a good servant but very poor master. If you are about to copy a
+large part of the code from one testcase to another, think what would happen if
+you find bug in the code that has been copied all around the tree. What about
+moving it to a library instead?
+
+The same goes for short but complicated parts, whenever you are about to copy &
+paste a syscall wrapper that packs arguments accordingly to machine
+architecture or similarly complicated code, put it into a header instead.
+
+C coding style
+--------------
+
+LTP adopted `Linux kernel coding style <https://www.kernel.org/doc/html/latest/process/coding-style.html>`_.
+Run ``make check`` in the test's directory and/or use ``make check-$TCID``, it
+uses (among other checks) our vendored version of
+`checkpatch.pl <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl>`_
+script from kernel git tree.
+
+.. note::
+      If ``make check`` does not report any problems, the code still may be wrong
+      as all tools used for checking only look for common mistakes.
+
+The following linting code can be found when we run ``make check``:
+
+.. list-table::
+    :header-rows: 1
+
+    * - Linting code
+      - Message
+      - Explanation
+
+    * - LTP-001
+      - Library source files have ``tst_`` prefix
+      - API source code is inside headers in ``include/{empty}*.h``,
+        ``include/lapi/{empty}*.h`` (backward compatibility for old kernel and
+        libc) and C sources in ``lib/{empty}*.c``. Files must have ``tst_``
+        prefix.
+
+    * - LTP-002
+      - ``TST_RET`` and ``TST_ERR`` are never modified by test library functions
+      - The test author is guaranteed that the test API will not modify these
+        variables. This prevents silent errors where the return value and
+        errno are overwritten before the test has chance to check them.
+
+        The macros which are clearly intended to update these variables. That
+        is ``TEST`` and those in ``tst_test_macros.h``. Are of course allowed to
+        update these variables.
+
+    * - LTP-003
+      - Externally visible library symbols have the ``tst_`` prefix
+      - Functions, types and variables in the public test API should have the
+        ``tst_`` prefix. With some exceptions for symbols already prefixed with
+        ``safe_`` or ``ltp_``.
+
+        Static (private) symbols should not have the prefix.
+
+    * - LTP-004
+      - Test executable symbols are marked ``static``
+      - Test executables should not export symbols unnecessarily. This means
+        that all top-level variables and functions should be marked with the
+        ``static`` keyword. The only visible symbols should be those included
+        from shared object files.
+
+    * - LTP-005
+      - Array must terminate with a sentinel value (i.e. ``NULL`` or ``{}``)
+      - When defining arrays in the ``struct tst_test`` structure, we need to
+        end the array items with a sentinel ``NULL`` value.
+
+Shell coding style
+------------------
+
+When writing testcases in shell, write in *portable shell* only, it's a good
+idea to try to run the test using alternative shell (alternative to bash, for
+example dash) too.
+
+*Portable shell* means Shell Command Language as defined by POSIX with an
+exception of few widely used extensions, namely **local** keyword used inside of
+functions and ``-o`` and ``-a`` test parameters (that are marked as obsolete in
+POSIX).
+
+You can either try to run the testcases in Debian which has ``/bin/sh`` pointing
+to ``dash`` by default, or to install ``dash`` on your favorite distribution,
+then use it to run tests. If your distribution lacks ``dash`` package, you can
+always compile it from `sources <http://gondor.apana.org.au/~herbert/dash/files/>`_.
+
+Run ``make check`` in the test's directory and/or use ``make check-$TCID.sh``.
+It uses (among other checks) our vendored version of
+`checkbashism.pl <https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl>`_
+from Debian that is used to check for non-portable shell code.
+
+.. note::
+
+      If ``make check`` does not report any problems the code still may be wrong,
+      as ``checkbashisms.pl`` is used for checking only common mistakes.
+
+Here there are some common sense style rules for shell
+
+* Keep lines under 80 chars
+* Use tabs for indentation
+* Keep things simple, avoid unnecessary subshells
+* Don't do confusing things (i.e. don't name your functions like common shell
+  commands, etc.)
+* Quote variables
+* Be consistent
+
+3 Backwards compatibility
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+LTP test should be as backward compatible as possible. Think of an enterprise
+distributions with long term support (more than five years since the initial
+release) or of an embedded platform that needs to use several years old
+toolchain supplied by the manufacturer.
+
+Therefore LTP test for more current features should be able to cope with older
+systems. It should at least compile fine and if it's not appropriate for the
+configuration it should return ``TCONF``.
+
+There are several types of checks we use:
+
+* The *configure script* is usually used to detect availability of a function
+  declarations in system headers. It's used to disable tests at compile time or
+  to enable fallback definitions.
+
+* Checking the ``errno`` value is another type of runtime check. Most of the
+  syscalls returns either ``EINVAL`` or ``ENOSYS`` when syscall was not
+  implemented or was disabled upon kernel compilation.
+
+* LTP has kernel version detection that can be used to disable tests at runtime.
+  Unfortunately, the kernel version does not always corresponds to a well
+  defined feature set, as distributions tend to backport hundreds of patches
+  while the kernel version stays the same. Use with caution.
+
+* Lately, we added a kernel ``.config`` parser. A test can define a boolean
+  expression of kernel config variables that has to be satisfied in order to run
+  a test. At the moment, this is mostly used for kernel namespaces.
+
+* Sometimes it makes sense to define a few macros instead of creating a
+  configure test. One example is Linux specific POSIX clock ids in
+  ``include/lapi/posix_clocks.h``
+
+Dealing with messed up legacy code
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+LTP still contains a lot of old and messy code and we are cleaning it up as
+fast as we can but, despite the decade of efforts, there is still a lot of it.
+If you start modifying old or a messy testcase and your changes are more
+complicated than simple typo fixes, you should convert the test into a new
+library first.
+
+It's also much easier to review the changes if you split them into a smaller
+logical groups. The same goes for moving files: if you need to rename or to move
+files, do it in a separate patch.
+
+License
+~~~~~~~
+
+Code contributed to LTP should be licensed under GPLv2+ (GNU GPL version 2 or
+any later version).
+
+Use ``SPDX-License-Identifier: GPL-2.0-or-later``
+
+LTP Structure
+-------------
+
+The structure of LTP is quite simple. Each test is a binary written either in
+portable shell or C. The test gets a configuration via environment variables
+and/or command line parameters, it prints additional information into the
+stdout and reports overall success/failure via the exit value.
+
+Tests are generally placed under the ``testcases/`` directory. Everything that
+is a syscall or (slightly confusingly) libc syscall wrapper, goes under
+``testcases/kernel/syscalls/``.
+
+There is also ``testcases/open_posix_testsuite/`` which is a well maintained
+fork of the Open POSIX testsuite project, that has been dead since 2005.
+
+We also have a number of directories with tests for more specific features, such
+as containers, etc.
+
+Runtest Files
+~~~~~~~~~~~~~
+
+The list of tests to be executed is stored in runtest files under the
+``runtest/`` directory. The default set of runtest files to be executed is
+stored in ``scenario_groups/default``. When you add a test, you should add
+corresponding entries into some runtest file(s) as well.
+
+Each line of runtest file contains one test. The first item is the test name.
+All other items, separated by space will be executed as a command.
+
+.. code-block:: bash
+
+      shell_test01 echo "SUCCESS" | shell_pipe01.sh
+      splice02 splice02 -s 20
+
+Blank lines and lines starting with a ``#`` (comments) are ignored.
+
+Syscalls tests, placed under ``testcases/kernel/syscalls/``, use
+``runtest/syscalls`` file. For kernel related tests for memory management we
+have ``runtest/mm``, etc.
+
+.. note::
+
+      runtest files should have one entry per a test. Creating a
+      wrapper that runs all your tests and adding it as a single test
+      into runtest file is strongly discouraged.
+
+Datafiles
+---------
+
+If your test needs data files, these should be put into a subdirectory
+named ``datafiles`` and installed into the ``testcases/data/$TCID`` directory.
+This will require to add ``INSTALL_DIR := testcases/data/TCID`` into
+``datafiles/Makefile``.
+
+You can obtain path to datafiles via ``$TST_DATAROOT`` provided by ``test.sh``
+or via C function ``tst_dataroot()`` provided by libltp:
+
+.. code-block:: c
+
+      const char *dataroot = tst_dataroot();
+
+Datafiles can also be accessed as ``$LTPROOT/testcases/data/$TCID/...``,
+but ``$TST_DATAROOT`` and ``tst_dataroot()`` are preferred, as these can be used
+when running testcases directly in git tree as well as from install location.
+
+Subexecutables
+~~~~~~~~~~~~~~
+
+If your test needs to execute a binary, place it in the same directory of the
+testcase and name the binary with ``$TESTNAME_`` prefix, where ``$TESTNAME`` is
+the name of the test binary. Once the test is executed by the framework, the
+path to the directory with all LTP binaries is added to the ``$PATH`` and you
+can execute it via its name.
+
+.. note::
+
+      If you need to execute a test from the LTP tree, you can add ``PATH`` to
+      the current directory with ``PATH="$PATH:$PWD" ./foo01``.
+
+Test Contribution Checklist
+---------------------------
+
+#. Test compiles and it runs fine (check with ``-i 10`` and ``-i 0`` too)
+#. ``make check`` should not emit any warnings for the test you are working on
+   (hint: run it in the test's directory and/or use ``make check-$TCID``)
+#. The runtest entries are in place
+#. New test binaries are added into the corresponding ``.gitignore`` files
+#. Patches apply over the latest git
+
+About .gitignore files
+~~~~~~~~~~~~~~~~~~~~~~
+
+There are numerous ``.gitignore`` files in the LTP tree. Usually, there is a
+``.gitignore`` file for a group of tests. The reason of this setup is simple:
+it's easier to maintain a ``.gitignore`` file per tests' directory, rather
+than having a single file in the project root directory. In this way, we don't
+have to update all the gitignore files when moving directories, and they get
+deleted automatically when a directory with tests is removed.
+
+Testing pre-release kernel features
+-----------------------------------
+
+Tests for features not yet in the mainline kernel release are accepted. However,
+they must be added only to the **staging** runtest file. Once a feature is part
+of the stable kernel ABI, the associated test must be moved out of staging.
+
+Testing builds with GitHub Actions
+----------------------------------
+
+Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
+to ensure LTP builds in various distributions, including old, current and
+bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
+architectures using cross-compilation. For a full list of tested distros, please
+check ``.github/workflows/ci.yml``.
+
+.. note::
+
+      Passing the GitHub Actions CI means that LTP compiles in a variety of
+      different distributions on their **newest releases**.
+      The CI also checks for code linting, running ``make check`` in the whole
+      LTP project.
+
+LTP C And Shell Test API Comparison
+-----------------------------------
+
+.. list-table::
+    :header-rows: 1
+
+    * - C API ``struct tst_test`` members
+      - Shell API ``$TST_*`` variables
+
+    * - .all_filesystems
+      - TST_ALL_FILESYSTEMS
+
+    * - .bufs
+      - \-
+
+    * - .caps
+      - \-
+
+    * - .child_needs_reinit
+      - not applicable
+
+    * - .cleanup
+      - TST_CLEANUP
+
+    * - .dev_extra_opts
+      - TST_DEV_EXTRA_OPTS
+
+    * - .dev_fs_opts
+      - TST_DEV_FS_OPTS
+
+    * - .dev_fs_type
+      - TST_FS_TYPE
+
+    * - .dev_min_size
+      - not applicable
+
+    * - .format_device
+      - TST_FORMAT_DEVICE
+
+    * - .max_runtime
+      - \-
+
+    * - .min_cpus
+      - not applicable
+
+    * - .min_kver
+      - TST_MIN_KVER
+
+    * - .min_mem_avail
+      - not applicable
+
+    * - .mnt_flags
+      - TST_MNT_PARAMS
+
+    * - .min_swap_avail
+      - not applicable
+
+    * - .mntpoint | .mnt_data
+      - TST_MNTPOINT
+
+    * - .mount_device
+      - TST_MOUNT_DEVICE
+
+    * - .needs_cgroup_ctrls
+      - \-
+
+    * - .needs_checkpoints
+      - TST_NEEDS_CHECKPOINTS
+
+    * - .needs_cmds
+      - TST_NEEDS_CMDS
+
+    * - .needs_devfs
+      - \-
+
+    * - .needs_device
+      - TST_NEEDS_DEVICE
+
+    * - .needs_drivers
+      - TST_NEEDS_DRIVERS
+
+    * - .needs_kconfigs
+      - TST_NEEDS_KCONFIGS
+
+    * - .needs_overlay
+      - \-
+
+    * - .needs_rofs
+      - \-
+
+    * - .needs_root
+      - TST_NEEDS_ROOT
+
+    * - .needs_tmpdir
+      - TST_NEEDS_TMPDIR
+
+    * - .options
+      - TST_PARSE_ARGS | TST_OPTS
+
+    * - .resource_files
+      - \-
+
+    * - .restore_wallclock
+      - not applicable
+
+    * - .sample
+      - \-
+
+    * - .save_restore
+      - \-
+
+    * - .scall
+      - not applicable
+
+    * - .setup
+      - TST_SETUP
+
+    * - .skip_filesystems
+      - TST_SKIP_FILESYSTEMS
+
+    * - .skip_in_compat
+      - \-
+
+    * - .skip_in_lockdown
+      - TST_SKIP_IN_LOCKDOWN
+
+    * - .skip_in_secureboot
+      - TST_SKIP_IN_SECUREBOOT
+
+    * - .supported_archs
+      - not applicable
+
+    * - .tags
+      - \-
+
+    * - .taint_check
+      - \-
+
+    * - .tcnt
+      - TST_CNT
+
+    * - .tconf_msg
+      - not applicable
+
+    * - .test | .test_all
+      - TST_TESTFUNC
+
+    * - .test_variants
+      - \-
+
+    * - .timeout
+      - TST_TIMEOUT
+
+    * - .tst_hugepage
+      - not applicable
+
+    * - .ulimit
+      - not applicable
+
+    * - not applicable
+      - TST_NEEDS_KCONFIGS_IFS
+
+    * - not applicable
+      - TST_NEEDS_MODULE
+
+    * - not applicable
+      - TST_POS_ARGS
+
+    * - not applicable
+      - TST_USAGE
+
+.. list-table::
+    :header-rows: 1
+
+    * - C API other structs
+      - Shell API ``$TST_*`` variables
+
+    * - struct tst_device
+      - TST_DEVICE
diff --git a/doc/index.rst b/doc/index.rst
new file mode 100644
index 000000000..80820ab51
--- /dev/null
+++ b/doc/index.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. include:: ../README.rst
+
+.. toctree::
+   :maxdepth: 3
+   :hidden:
+   :caption: For users
+
+   users/quick_start
+   users/setup_tests
+   users/supported_systems
+   users/stats
+
+.. toctree::
+   :maxdepth: 3
+   :hidden:
+   :caption: For developers
+
+   developers/setup_mailinglist
+   developers/writing_tests
+   developers/test_case_tutorial
+   developers/api_c_tests
+   developers/api_shell_tests
+   developers/api_network_tests
+   developers/api_kvm_tests
+   developers/ltp_library
+   developers/build_system
+   developers/debugging
+
+.. toctree::
+   :maxdepth: 3
+   :hidden:
+   :caption: For maintainers
+
+   maintainers/patch_review
+   maintainers/ltp_release_procedure
+
+For users
+---------
+
+.. descriptions here are active
+
+:doc:`users/quick_start`
+   How to build and use LTP framework in few steps
+
+:doc:`users/setup_tests`
+   How to setup tests execution
+
+:doc:`users/supported_systems`
+   A list of supported technologies by the LTP framework
+
+:doc:`users/stats`
+   Some LTP statistics
+
+For developers
+--------------
+
+.. descriptions here are active
+
+:doc:`developers/setup_mailinglist`
+   How to configure git and to start sending patches via ``git send-email``
+
+:doc:`developers/writing_tests`
+   Starting guide on writing tests
+
+:doc:`developers/test_case_tutorial`
+   A tutorial showing how to write a test from scratch using C API
+
+:doc:`developers/api_c_tests`
+   Walk through the C API features
+
+:doc:`developers/api_shell_tests`
+   Walk through the Shell API features
+
+:doc:`developers/api_network_tests`
+   Walk through the network API features
+
+:doc:`developers/api_kvm_tests`
+   Walk through the KVM API features
+
+:doc:`developers/ltp_library`
+   Developing new features in the LTP library
+
+:doc:`developers/build_system`
+   Short introduction to the LTP build system
+
+:doc:`developers/debugging`
+   How to debug LTP tests
+
+For maintainers
+---------------
+
+:doc:`maintainers/patch_review`
+   Steps to follow when reviewing patches
+
+:doc:`maintainers/ltp_release_procedure`
+   Steps to follow for a new LTP release
+
+
+Getting help
+------------
+To report a problem or suggest any feature, please write at ltp@lists.linux.it
diff --git a/doc/maintainers/ltp_release_procedure.rst b/doc/maintainers/ltp_release_procedure.rst
new file mode 100644
index 000000000..f0bc01cee
--- /dev/null
+++ b/doc/maintainers/ltp_release_procedure.rst
@@ -0,0 +1,173 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Release process
+===============
+
+Preparations
+------------
+
+The release procedure generally takes a few weeks. In the first week or two,
+patches that should go into the release are reviewed and possibly merged. These
+patches are either fixes or patches pointed out by the community.
+
+Patch review, when finished, is followed by a git freeze, which is a period
+where only fixes are pushed to the git. During that period community is
+expected to run a LTP pre-release tests, reports problems, and/or send fixes to
+the mailing list. In this period we are especially making sure that there are
+no regressions in the test results on a wide range of distributions and
+architectures.
+
+Once the stabilization period has ended the time has finally come to proceed
+with the release.
+
+Prepare the release notes
+-------------------------
+
+Part of the preparation is also to write the release notes, which are then
+added to the GitHub release and also sent as announcement to various mailing
+lists (see below).
+
+Have a look at `this release letter <https://lore.kernel.org/ltp/ZGNiQ1sMGvPU_ETp@yuki/>`_
+to get the idea how it should look.
+
+Tag the git and push changes to github
+--------------------------------------
+
+.. code-block:: bash
+
+    cd ltp
+    echo YYYYMMDD > VERSION
+    git commit -S -s -m 'LTP YYYYMMDD' VERSION
+    git tag -s -a YYYYMMDD -m 'LTP YYYYMMDD'
+    git push origin master:master
+    git push origin YYYYMMDD
+
+The string ``YYYYMMDD`` should be substituted to the current date.
+
+You can use `tools/tag-release.sh <https://github.com/linux-test-project/ltp/blob/master/tools/tag-release.sh>`_
+script to have the above automated process.
+It allows you to verify the tag before pushing it and does other checks.
+
+.. code-block:: bash
+
+    $ ./tools/tag-release.sh
+    ===== git push =====
+    new tag: 'YYYYMMDD', previous tag: '20230127'
+    tag YYYYMMDD
+    Tagger: Person-who-released LTP <foo@example.com>
+    Date:   ...
+
+    LTP YYYYMMDD
+    -----BEGIN PGP SIGNATURE-----
+    ...
+    -----END PGP SIGNATURE-----
+
+    commit 3ebc2dfa85c2445bb68d8c0d66e33c4da1e1b3a7
+    gpg:                using RSA key ...
+    ...
+    Primary key fingerprint: ...
+    Author: Person-who-released LTP <foo@example.com>
+    Date:   ...
+
+        LTP YYYYMMDD
+
+        Signed-off-by: Person-who-released LTP <foo@example.com>
+
+    diff --git a/VERSION b/VERSION
+    index af4c41fec..ae488c0e7 100644
+    --- a/VERSION
+    +++ b/VERSION
+    @@ -1 +1 @@
+    -20230127
+    +YYYYMMDD
+
+    Please check tag and signature. Proceed? [N/y]: y
+    Pushing changes to upstream git. Proceed? [N/y]: y
+    ...
+    To github.com:linux-test-project/ltp.git
+     * [new tag]             YYYYMMDD -> YYYYMMDD
+
+Prepare tarballs and metadata documentation
+-------------------------------------------
+
+The following procedure will show how to create the release archives and the
+metadata documentation:
+
+.. code-block:: bash
+
+    # clone already clonned git repository to new folder
+    cd ..
+    git clone ltp ltp-full-YYYYMMDD
+    cd ltp-full-YYYYMMDD
+
+    # update all submodules
+    git submodule update --init
+
+    # Generate configure script
+    make autotools
+
+    # Generate tarballs
+    cd ..
+    tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
+    tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
+
+    # Generate checksums
+    md5 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.md5
+    sha1 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha1
+    sha256sum ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha256
+
+    # Generate metadata documentation
+    ./configure --with-metadata-generator=asciidoctor
+    make -C metadata
+    cp -v docparse/metadata.html ../metadata.YYYYMMDD.html
+
+You can use `tools/create-tarballs-metadata.sh <https://github.com/linux-test-project/ltp/blob/master/tools/create-tarballs-metadata.sh>`_
+script to have the above procedure automated. All generated files are placed
+in the ``ltp-release-YYYYMMDD`` directory.
+
+.. code-block:: bash
+
+    $ ./tools/create-tarballs-metadata.sh
+    ===== git clone =====
+    Cloning into 'ltp-full-YYYYMMDD'...
+    done.
+    ===== Update submodules =====
+    Submodule 'tools/kirk' (https://github.com/linux-test-project/kirk.git) registered for path 'tools/kirk'
+    ...
+    ===== Generate configure script =====
+    sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$:]):;p;q}' VERSION > m4/ltp-version.m4
+    aclocal -I m4
+    ...
+    ===== Generate tarballs =====
+    ===== Generate checksums =====
+    ===== Generate metadata documentation =====
+    checking for a BSD-compatible install... /usr/bin/install -c
+    ...
+    'docparse/metadata.html' -> '/home/foo/ltp-release-YYYYMMDD/metadata.YYYYMMDD.html'
+    Generated files are in '/home/foo/ltp-release-YYYYMMDD', upload them to github
+
+Upload the generated files to GitHub
+------------------------------------
+
+Click on `Releases <https://github.com/linux-test-project/ltp/releases>`_, then
+switch to `Tags <https://github.com/linux-test-project/ltp/tags>`_. Click on
+'Add release notes'.  There should be 'Attach binaries ...' link at the
+bottom of the page.
+
+Don't forget to upload checksums for the tarballs and metadata documentation
+as well.
+
+Send release announcement
+-------------------------
+
+The announcement is sent to:
+
+* ltp at lists.linux.it
+* linux-kernel at vger.kernel.org
+* libc-alpha at sourceware.org
+
+CCed to:
+
+* lwn at lwn.net
+* akpm at linux-foundation.org
+* torvalds at linux-foundation.org
diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
new file mode 100644
index 000000000..81d198532
--- /dev/null
+++ b/doc/maintainers/patch_review.rst
@@ -0,0 +1,171 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Patch review
+============
+
+Anyone can and should review patches. It's the only way to get good at patch
+review and for the project to scale. For this reason, we have a short guide on
+what to do during the review process.
+
+Goals of patch review
+---------------------
+
+#. Prevent false positive test results
+#. Prevent false negative test results
+#. Keep the code as simple as possible, but no simpler
+
+How to find clear errors
+------------------------
+
+A clear error is one where there is unlikely to be any argument if you
+provide evidence of it. Evidence being an error trace or logical proof
+that an error will occur in a common situation.
+
+The following are examples and may not be appropriate for all tests.
+
+* Merge the patch locally. It should apply cleanly to master.
+* Compile the patch with default and non-default configurations.
+
+  * Use sanitizers e.g. undefined behaviour, address.
+  * Compile on non-x86
+  * Compile on x86 with ``-m32``
+  * Compile testing patches with GitHub Actions in LTP repo fork can cover
+    various distros/architectures
+
+* Use ``make check``
+* Run effected tests in a VM
+
+  * Use single vCPU
+  * Use many vCPUs and enable NUMA
+  * Restrict RAM to < 1GB.
+
+* Run effected tests on an embedded device
+* Run effected tests on non-x86 machine in general
+* Run reproducers on a kernel where the bug is present
+* Run tests with ``-i0`` and ``-i2``
+* Compare usage of system calls with man page descriptions
+* Compare usage of system calls with kernel code
+* Double check commit message
+* Search the LTP library for existing helper functions
+* Check doc formatting, i.e. ``make doc && chromium docparse/metadata.html``
+
+How to find subtle errors
+-------------------------
+
+A subtle error is one where you can expect some argument because you
+do not have clear evidence of an error. It is best to state these as
+questions and not make assertions if possible.
+
+Although if it is a matter of style or "taste" then senior maintainers
+can assert what is correct to avoid bike shedding.
+
+* Ask what happens if there is an error, could it be debugged just
+  with the test output?
+* Are we testing undefined behavior?
+
+  * Could future kernel behaviour change without "breaking userland"?
+  * Does the kernel behave differently depending on hardware?
+  * Does it behave differently depending on kernel configuration?
+  * Does it behave differently depending on the compiler?
+  * Would it behave differently if the order of checks on syscall parameters
+    changed in the kernel?
+
+* Will it scale to tiny and huge systems?
+
+  * What happens if there are 100+ CPUs?
+  * What happens if each CPU core is very slow?
+  * What happens if there are 2TB of RAM?
+
+* Are we repeating a pattern that can be turned into a library function?
+* Is a single test trying to do too much?
+* Could multiple similar tests be merged?
+* Race conditions
+
+  * What happens if a process gets preempted?
+  * Could checkpoints or fuzzsync by used instead?
+  * Note, usually you can insert a sleep to prove a race condition
+    exists however finding them is hard
+
+* Is there a simpler way to achieve the same kernel coverage?
+
+How to get patches merged
+-------------------------
+
+Once you think a patch is good enough you should add your ``Reviewed-by``
+and/or ``Tested-by`` tags. This means you will get some credit for getting
+the patch merged. Also some blame if there are problems.
+
+If you ran the test you can add the ``Tested-by`` tag. If you read the
+code or used static analysis tools on it, you can add the Reviewed-by
+tag.
+
+In addition you can expect others to review your patches and add their
+tags. This will speed up the process of getting your patches merged.
+
+Maintainers Checklist
+---------------------
+
+Patchset should be tested locally and ideally also in maintainer's fork in
+GitHub Actions on GitHub.
+
+.. note::
+
+    GitHub Actions do only build testing, passing the CI means only that
+    the test compiles fine on variety of different distributions and releases.
+
+The test should be executed at least once locally and should PASS as well.
+
+Commit messages should have
+
+* Author's ``Signed-off-by`` tag
+* Committer's ``Reviewed-by`` or ``Signed-off-by`` tag
+* Check also mailing lists for other reviewers / testers tags, notes and failure
+  reports
+* ``Fixes: hash`` if it fixes particular LTP commit
+* ``Fixes: #N`` if it fixes github issue number N, so it's automatically closed
+* LTP documentation should be kept up to date.
+
+After patch is accepted or rejected, set correct state and archive in the
+`LTP patchwork instance <https://patchwork.ozlabs.org/project/ltp/list/>`_.
+
+New tests
+---------
+
+New test should
+
+* Have a record in runtest file
+* Test should work fine with more than one iteration (e.g. run with ``-i 100``)
+* Run with ``-i 0`` to check that setup and cleanup are coded properly
+  (no test is being run)
+* Have a brief description
+* License: the default license for new tests is GPL v2 or later, use
+  ``GPL-2.0-or-later``; the licence for test (e.g. GPL-2.0) should not change
+  unless test is completely rewritten
+* Old copyrights should be kept unless test is completely rewritten
+
+C tests
+~~~~~~~
+
+* Use the new C API, implementing ``struct tst_test``
+* Test binaries are added into corresponding ``.gitignore`` files
+* Check coding style with ``make check``
+* Docparse documentation
+* If a test is a regression test it should include ``.tags`` in the
+  ``struct tst_test`` definition
+* When rewriting old tests, `uClinux <https://en.wikipedia.org/wiki/%CE%9CClinux>`_
+  support should be removed (project has been discontinued).
+  E.g. remove ``#ifdef UCLINUX``, replace ``FORK_OR_VFORK()`` with simple
+  ``fork()`` or ``SAFE_FORK()``.
+
+Shell tests
+~~~~~~~~~~~
+
+* Use new shell API
+* Check coding style with ``make check``
+* If a test is a regression test it should include related kernel or glibc
+  commits as a comment
+
+LTP library
+~~~~~~~~~~~
+
+For patchset touching the LTP library, follow the LTP library guidelines.
diff --git a/doc/Build-System.asciidoc b/doc/old/Build-System.asciidoc
similarity index 100%
rename from doc/Build-System.asciidoc
rename to doc/old/Build-System.asciidoc
diff --git a/doc/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
similarity index 100%
rename from doc/C-Test-API.asciidoc
rename to doc/old/C-Test-API.asciidoc
diff --git a/doc/C-Test-Case-Tutorial.asciidoc b/doc/old/C-Test-Case-Tutorial.asciidoc
similarity index 100%
rename from doc/C-Test-Case-Tutorial.asciidoc
rename to doc/old/C-Test-Case-Tutorial.asciidoc
diff --git a/doc/C-Test-Network-API.asciidoc b/doc/old/C-Test-Network-API.asciidoc
similarity index 100%
rename from doc/C-Test-Network-API.asciidoc
rename to doc/old/C-Test-Network-API.asciidoc
diff --git a/doc/Contact-Info.asciidoc b/doc/old/Contact-Info.asciidoc
similarity index 100%
rename from doc/Contact-Info.asciidoc
rename to doc/old/Contact-Info.asciidoc
diff --git a/doc/KVM-Test-API.asciidoc b/doc/old/KVM-Test-API.asciidoc
similarity index 100%
rename from doc/KVM-Test-API.asciidoc
rename to doc/old/KVM-Test-API.asciidoc
diff --git a/doc/LTP-Library-API-Writing-Guidelines.asciidoc b/doc/old/LTP-Library-API-Writing-Guidelines.asciidoc
similarity index 100%
rename from doc/LTP-Library-API-Writing-Guidelines.asciidoc
rename to doc/old/LTP-Library-API-Writing-Guidelines.asciidoc
diff --git a/doc/LTP-Release-Procedure.asciidoc b/doc/old/LTP-Release-Procedure.asciidoc
similarity index 100%
rename from doc/LTP-Release-Procedure.asciidoc
rename to doc/old/LTP-Release-Procedure.asciidoc
diff --git a/doc/Maintainer-Patch-Review-Checklist.asciidoc b/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
similarity index 100%
rename from doc/Maintainer-Patch-Review-Checklist.asciidoc
rename to doc/old/Maintainer-Patch-Review-Checklist.asciidoc
diff --git a/doc/old/Makefile b/doc/old/Makefile
new file mode 100644
index 000000000..f7e4dd021
--- /dev/null
+++ b/doc/old/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir			?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+RECURSIVE_TARGETS	:= install
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/doc/Shell-Test-API.asciidoc b/doc/old/Shell-Test-API.asciidoc
similarity index 100%
rename from doc/Shell-Test-API.asciidoc
rename to doc/old/Shell-Test-API.asciidoc
diff --git a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc b/doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc
similarity index 100%
rename from doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
rename to doc/old/Supported-kernel,-libc,-toolchain-versions.asciidoc
diff --git a/doc/Test-Writing-Guidelines.asciidoc b/doc/old/Test-Writing-Guidelines.asciidoc
similarity index 100%
rename from doc/Test-Writing-Guidelines.asciidoc
rename to doc/old/Test-Writing-Guidelines.asciidoc
diff --git a/doc/User-Guidelines.asciidoc b/doc/old/User-Guidelines.asciidoc
similarity index 100%
rename from doc/User-Guidelines.asciidoc
rename to doc/old/User-Guidelines.asciidoc
diff --git a/doc/man1/Makefile b/doc/old/man1/Makefile
similarity index 100%
rename from doc/man1/Makefile
rename to doc/old/man1/Makefile
diff --git a/doc/man1/doio.1 b/doc/old/man1/doio.1
similarity index 100%
rename from doc/man1/doio.1
rename to doc/old/man1/doio.1
diff --git a/doc/man1/iogen.1 b/doc/old/man1/iogen.1
similarity index 100%
rename from doc/man1/iogen.1
rename to doc/old/man1/iogen.1
diff --git a/doc/man1/ltp-bump.1 b/doc/old/man1/ltp-bump.1
similarity index 100%
rename from doc/man1/ltp-bump.1
rename to doc/old/man1/ltp-bump.1
diff --git a/doc/man1/ltp-pan.1 b/doc/old/man1/ltp-pan.1
similarity index 100%
rename from doc/man1/ltp-pan.1
rename to doc/old/man1/ltp-pan.1
diff --git a/doc/man3/Makefile b/doc/old/man3/Makefile
similarity index 100%
rename from doc/man3/Makefile
rename to doc/old/man3/Makefile
diff --git a/doc/man3/parse_opts.3 b/doc/old/man3/parse_opts.3
similarity index 100%
rename from doc/man3/parse_opts.3
rename to doc/old/man3/parse_opts.3
diff --git a/doc/man3/parse_ranges.3 b/doc/old/man3/parse_ranges.3
similarity index 100%
rename from doc/man3/parse_ranges.3
rename to doc/old/man3/parse_ranges.3
diff --git a/doc/man3/random_range.3 b/doc/old/man3/random_range.3
similarity index 100%
rename from doc/man3/random_range.3
rename to doc/old/man3/random_range.3
diff --git a/doc/man3/random_range_seed.3 b/doc/old/man3/random_range_seed.3
similarity index 100%
rename from doc/man3/random_range_seed.3
rename to doc/old/man3/random_range_seed.3
diff --git a/doc/man3/tst_res.3 b/doc/old/man3/tst_res.3
similarity index 100%
rename from doc/man3/tst_res.3
rename to doc/old/man3/tst_res.3
diff --git a/doc/man3/tst_sig.3 b/doc/old/man3/tst_sig.3
similarity index 100%
rename from doc/man3/tst_sig.3
rename to doc/old/man3/tst_sig.3
diff --git a/doc/man3/tst_tmpdir.3 b/doc/old/man3/tst_tmpdir.3
similarity index 100%
rename from doc/man3/tst_tmpdir.3
rename to doc/old/man3/tst_tmpdir.3
diff --git a/doc/man3/usctest.3 b/doc/old/man3/usctest.3
similarity index 100%
rename from doc/man3/usctest.3
rename to doc/old/man3/usctest.3
diff --git a/doc/namespaces-helper-tools.txt b/doc/old/namespaces-helper-tools.txt
similarity index 100%
rename from doc/namespaces-helper-tools.txt
rename to doc/old/namespaces-helper-tools.txt
diff --git a/doc/nommu-notes.txt b/doc/old/nommu-notes.txt
similarity index 100%
rename from doc/nommu-notes.txt
rename to doc/old/nommu-notes.txt
diff --git a/doc/rules.tsv b/doc/old/rules.tsv
similarity index 100%
rename from doc/rules.tsv
rename to doc/old/rules.tsv
diff --git a/doc/requirements.txt b/doc/requirements.txt
new file mode 100644
index 000000000..742fb8b4b
--- /dev/null
+++ b/doc/requirements.txt
@@ -0,0 +1,3 @@
+sphinx-rtd-theme==2.0.0
+linuxdoc==20231020
+sphinxcontrib-spelling==7.7.0
diff --git a/doc/spelling_wordlist b/doc/spelling_wordlist
new file mode 100644
index 000000000..0c016e615
--- /dev/null
+++ b/doc/spelling_wordlist
@@ -0,0 +1,120 @@
+aarch
+akpm
+amd
+archiver
+archs
+args
+asciidoc
+autoconf
+automake
+backport
+baz
+btime
+bufs
+CCed
+cgroup
+cgroups
+checksum
+checksums
+cmds
+codebase
+compat
+config
+cpus
+ctrls
+datafiles
+dev
+devfs
+dio
+distro
+distros
+docparse
+doio
+executables
+fd
+filesystem
+filesystems
+fixup
+fs
+fstrict
+fuzzsync
+gcc
+gdb
+github
+gitignore
+glibc
+growfiles
+hugepage
+iogen
+kbuild
+kconfigs
+kver
+ld
+le
+libc
+libltp
+libs
+linkable
+linux
+lockdown
+ltp
+lwn
+Maipo
+Makefile
+Makefiles
+mem
+mnt
+mntpoint
+msg
+namespace
+namespaces
+onwards
+openSUSE
+patchset
+pkgconf
+posix
+ppc
+pre
+pre
+preprocessor
+rebase
+reflog
+reinit
+repo
+rofs
+runtest
+scall
+secureboot
+sourceware
+statx
+stdout
+structs
+stx
+subdirectory
+subshell
+subshells
+syscall
+syscalls
+tcnt
+tconf
+teardown
+testcase
+testcases
+testsuite
+testsuites
+tmp
+tmpdir
+toolchain
+toolchains
+torvalds
+tst
+uClibc
+ulimit
+un
+userland
+userspace
+vCPU
+vCPUs
+vendoring
+vger
+wallclock
diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
new file mode 100644
index 000000000..40d8dd9c6
--- /dev/null
+++ b/doc/users/quick_start.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Installation and tests execution
+================================
+
+Basics requirements to build LTP are the following:
+
+* git
+* autoconf
+* automake
+* make
+* gcc
+* m4
+* pkgconf / pkg-config
+* libc headers
+* linux headers
+
+.. code-block:: console
+
+   $ git clone https://github.com/linux-test-project/ltp.git
+   $ cd ltp
+   $ make autotools
+   $ ./configure
+
+.. note::
+
+   For optional library dependencies, take a look at the scripts inside ``ci/``
+   directory.
+
+Running single tests
+--------------------
+
+LTP provides the possibility to build and run single tests:
+
+.. code-block:: console
+
+   $ cd testcases/kernel/syscalls/foo
+   $ make
+   $ PATH=$PATH:$PWD ./foo01
+
+Shell testcases are a bit more complicated, since they need to setup ``PATH``
+as well as to compiled binary helpers:
+
+.. code-block:: console
+
+   $ cd testcases/lib
+   $ make
+   $ cd ../commands/foo
+   $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
+
+Open Posix Testsuite has it's own build system which needs Makefiles to be
+generated first:
+
+.. code-block:: console
+
+   $ cd testcases/open_posix_testsuite/
+   $ make generate-makefiles
+   $ cd conformance/interfaces/foo
+   $ make
+   $ ./foo_1-1.run-test
+
+Compiling and installing all testcases
+--------------------------------------
+
+To compile all tests is really simple:
+
+.. code-block:: console
+
+   $ make
+
+   $ # install LTP inside /opt/ltp by default
+   $ make install
+
+.. note::
+
+   Some tests will be disabled if ``configure`` script won't find the build
+   dependencies.
+
+Running tests
+-------------
+
+To run all the test suites
+
+.. code-block:: console
+
+   $ cd /opt/ltp
+
+   $ # run syscalls testing suite
+   $ ./kirk -f ltp -r syscalls
+
+.. note::
+
+   Many test cases have to be executed as root.
+
+Test suites (e.g. syscalls) are defined in the ``runtest`` directory. Each file
+contains a list of test cases in a simple format.
+
+Each test case has its own executable or script that can directly executed:
+
+.. code-block:: console
+
+   $ testcases/bin/abort01
+
+   $ # some tests have arguments
+   $ testcases/bin/mesgq_nstest -m none
+
+   $ # vast majority of tests have a help
+   $ testcases/bin/ioctl01 -h
+
+   $ # Many require certain environment variables to be set
+   $ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
+
+Most commonly, the ``PATH`` variable needs to be set and also ``LTPROOT``, but
+there are a number of other variables which usually ``kirk`` sets for you.
+
+.. note::
+
+   All shell scripts need the ``PATH`` to be set. However, this is not limited
+   to shell scripts and some C based tests need environment variables as well.
+   They usually raise a configuration error when this is needed.
+
+Network tests
+-------------
+
+Network tests usually require a certain setup that is described in
+``testcases/network/README.md``.
diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
new file mode 100644
index 000000000..910cc2315
--- /dev/null
+++ b/doc/users/setup_tests.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Tests setup
+===========
+
+The internal LTP library provides a set of features that permits to customize
+tests behaviour by setting environment variables and using specific tests
+arguments.
+
+Library environment variables
+-----------------------------
+
+Following environment variables are expected to be set by LTP users. Therefore,
+with some exceptions, they have ``LTP_`` prefix. Environment variables with
+``TST_`` prefix are used inside LTP shell API and should **not** be set by
+users.
+
+.. list-table::
+   :header-rows: 1
+
+   * - Variable
+     - Note
+
+   * - KCONFIG_PATH
+     - The path to the kernel config file, (if not set, it tries the usual paths
+       ``/boot/config-RELEASE`` or ``/proc/config.gz``)
+
+   * - KCONFIG_SKIP_CHECK
+     - Skip kernel config check if variable set (not set by default)
+
+   * - LTPROOT
+     - Prefix for installed LTP.  **Should be always set**, since some tests
+       need it to use data files (``LTP_DATAROOT``). LTP is by default installed
+       into ``/opt/ltp``
+
+   * - LTP_COLORIZE_OUTPUT
+     - By default LTP colorizes it's output unless it's redirected to a pipe or
+       file. Force colorized output behaviour: ``y`` or ``1``: always colorize,
+       ``n`` or ``0``: never colorize.
+
+   * - LTP_DEV
+     - Path to the block device to be used. C Language: ``.needs_device = 1``.
+       Shell language: ``TST_NEEDS_DEVICE=1``.
+
+   * - LTP_SINGLE_FS_TYPE
+     - Testing only - specifies filesystem instead all supported
+       (for tests with ``.all_filesystems``).
+
+   * - LTP_DEV_FS_TYPE
+     - Filesystem used for testing (default: ``ext2``).
+
+   * - LTP_TIMEOUT_MUL
+     - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
+       machines to avoid unexpected timeout).
+
+   * - LTP_RUNTIME_MUL
+     - Multiplies maximal test iteration runtime. Tests that run for more than a
+       second or two are capped on runtime. You can scale the default runtime
+       both up and down with this multiplier. This is not yet implemented in the
+       shell API.
+
+   * - LTP_VIRT_OVERRIDE
+     - Overrides virtual machine detection in the test library. Setting it to
+       empty string, tella the library that system is not a virtual machine.
+       Other possible values are ``kvm``, ``xen``, ``zvm`` and ``microsoft``
+       that describe different types supervisors.
+
+   * - PATH
+     - It's required to addjust path: ``PATH="$PATH:$LTPROOT/testcases/bin"``
+
+   * - TMPDIR
+     - Base directory for template directory (C language: ``.needs_tmpdir = 1``
+       and shell: ``TST_NEEDS_TMPDIR=1``). Must be an absolute path (default:
+       '/tmp').
+
+   * - LTP_NO_CLEANUP
+     - Disable running test cleanup (defined in ``TST_CLEANUP``).
+       Shell API only.
+
+   * - LTP_ENABLE_DEBUG
+     - Enable debug info (value ``1`` or ``y``).
+
+Test execution time and timeout
+-------------------------------
+
+The limit on how long a test can run does compose of two parts: ``max_runtime``
+and ``timeout``. The limit does apply to a single test variant. That means, for
+example, that tests which run for all available filesystems will apply this
+limit for a single filesystem only.
+
+The ``max_runtime`` is a cap on how long the ``run()`` function can take and for
+most testcases this part is set to zero. For tests that do run for more than a
+second or two the ``max_runtime`` has to be defined and the ``run()`` function
+has to check actively how much runtime is left.
+
+Test runtime can be scaled up and down with ``LTP_RUNTIME_MUL`` environment
+variable or set on a commandline by the ``-I`` parameter. Hoewever,
+setting the runtime too low will cause long running tests to exit prematurely,
+possibly before having a chance to actually test anything.
+
+The timeout is a limit for test setup and cleanup and it's also a safety
+margin for the runtime accounting. It's currently set to 30 seconds but it may
+change later. If your target machine is too slow, it can be scaled up with the
+``LTP_TIMEOUT_MUL`` environment variable.
diff --git a/doc/users/stats.rst b/doc/users/stats.rst
new file mode 100644
index 000000000..7073442aa
--- /dev/null
+++ b/doc/users/stats.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Statistics
+==========
+
+In this section we collect some statistics related to the current state of
+LTP tests.
+
+.. include:: ../_static/syscalls.rst
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
new file mode 100644
index 000000000..6220a96e0
--- /dev/null
+++ b/doc/users/supported_systems.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Supported systems
+=================
+
+Kernel version
+--------------
+
+Minimal supported kernel version is **3.10**.
+
+Oldest tested distributions
+---------------------------
+
+.. list-table::
+    :header-rows: 1
+
+    * - Distro
+      - Kernel
+      - glibc
+      - gcc
+      - clang
+
+    * - openSUSE Leap 42.2
+      - 4.4
+      - 2.22
+      - 4.8.5
+      - \-
+
+    * - Ubuntu 18.04 LTS bionic
+      - 4.15
+      - 2.27
+      - 7.3.0
+      - \-
+
+    * - Debian 11 (bullseye)
+      - 5.10
+      - 2.31
+      - 10.2.1
+      - 11.0.1
+
+    * - RHEL-7.9 Maipo
+      - 3.10
+      - 4.8.5
+      - 2.17
+      - \-
+
+Older distributions are not officially supported, which means that it
+may or may not work. It all depends on your luck. It should be possible
+to compile latest LTP even on slightly older distributions than we
+support with a few manual tweaks, e.g. disabling manually tests for
+newly added syscalls, etc. **Trivial fixes/workarounds may be accepted,
+but users are encouraged to move to a newer distro.**
+
+If latest LTP cannot be compiled even with some amount of workarounds,
+you may result to older LTP releases, however these are **not** supported
+in any way. Also if you are trying to run LTP on more than 10 years old
+distribution you may as well reconsider you life choices.
+
+Tested architectures
+--------------------
+
+.. list-table::
+    :header-rows: 1
+
+    * - Architecture
+      - Build
+
+    * - x86_64
+      - native
+
+    * - x86 emulation
+      - native
+
+    * - aarch64
+      - cross compilation
+
+    * - ppc64le
+      - cross compilation
+
+    * - s390x
+      - cross compilation
+
+Supported C libraries
+---------------------
+
+.. list-table::
+    :header-rows: 1
+
+    * - C library
+      - Note
+
+    * - `glibc <https://www.gnu.org/software/libc/>`_
+      - Targeted libc, tested both compilation and actual test results.
+
+    * - `uClibc-ng <https://uclibc-ng.org/>`_
+      - Although not being tested, it should work as it attempt to maintain a glibc compatible interface.
+
+    * - `uClibc <https://www.uclibc.org/>`_
+      - Older uClibc might have problems.
+
+    * - `musl <https://musl.libc.org/>`_
+      - Not yet fully supported. Check ``ci/alpine.sh`` script.
+
+    * - Android
+      - Please use `AOSP fork <https://android.googlesource.com/platform/external/ltp>`_
+
+C version
+---------
+
+LTP is compiled with ``-std=gnu99``.
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
