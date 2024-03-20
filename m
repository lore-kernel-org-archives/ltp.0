Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBF5C6FD1F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E743CFFAF
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:22:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B5A33CFBFB
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:48 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2307603440
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 248DF5BF31;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfm0c0QAulBEbMKUX9g98rYni7ZO2qpRqx0tZrJzQ34=;
 b=0Rx3uZlCLTDHSvQRXCLprl/fdjzBO5/zaxhF9tfdyPSxliWVUWrZ2jQTW416CIK9o/bCW9
 StDCW/x2nVclp2XpHKANe/jwyjWsaZfpvFAeN98exWJkloiyK+Vuu40gFs6VgpZRwnlzj7
 i86l+u+RcapJ6f6HGWHX+zr8h3bOBuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfm0c0QAulBEbMKUX9g98rYni7ZO2qpRqx0tZrJzQ34=;
 b=0iIiMoVQD/AyrQJH6pnjWXZp2JcXqWnO7bMjiLqG6ixEL+Rob/zn8HN2lnDo4mKyIsT8EX
 tXAotbCqYtcecMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfm0c0QAulBEbMKUX9g98rYni7ZO2qpRqx0tZrJzQ34=;
 b=0Rx3uZlCLTDHSvQRXCLprl/fdjzBO5/zaxhF9tfdyPSxliWVUWrZ2jQTW416CIK9o/bCW9
 StDCW/x2nVclp2XpHKANe/jwyjWsaZfpvFAeN98exWJkloiyK+Vuu40gFs6VgpZRwnlzj7
 i86l+u+RcapJ6f6HGWHX+zr8h3bOBuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfm0c0QAulBEbMKUX9g98rYni7ZO2qpRqx0tZrJzQ34=;
 b=0iIiMoVQD/AyrQJH6pnjWXZp2JcXqWnO7bMjiLqG6ixEL+Rob/zn8HN2lnDo4mKyIsT8EX
 tXAotbCqYtcecMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 096361396E;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0FQCAd4M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:45 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-1-79b603c8aea1@suse.com>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,linux.it:email,suse.com:email,gnu.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/10] Add the new basics documentation
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

This is the first patch introducing the new LTP documentation. The
new documentation is now using Sphinx as the main framework,
providing a solid substitute to Github wiki pages.

This patch is meant to be the starting point, where we start rewriting
the old asciidoc documentation format.

A .readthedocs.yaml configuration has been added to provide an initial
documentation publish via readthedocs service.
---
 .readthedocs.yml                              |  15 +++
 doc_new/.gitignore                            |   1 +
 doc_new/Makefile                              |   5 +
 doc_new/_static/custom.css                    |   4 +
 doc_new/conf.py                               |  27 ++++++
 doc_new/developers/api_c_tests.rst            |   4 +
 doc_new/developers/api_kvm_tests.rst          |   4 +
 doc_new/developers/api_network_tests.rst      |   4 +
 doc_new/developers/api_shell_tests.rst        |   4 +
 doc_new/developers/build_system.rst           |   4 +
 doc_new/developers/debugging.rst              |  10 ++
 doc_new/developers/ltp_library.rst            |   4 +
 doc_new/developers/setup_mailinglist.rst      |   4 +
 doc_new/developers/test_case_tutorial.rst     |   4 +
 doc_new/developers/writing_tests.rst          |  20 ++++
 doc_new/index.rst                             | 124 +++++++++++++++++++++++++
 doc_new/maintainers/ltp_release_procedure.rst |   4 +
 doc_new/maintainers/patch_review.rst          |   4 +
 doc_new/requirements.txt                      |   1 +
 doc_new/users/quick_start.rst                 | 126 ++++++++++++++++++++++++++
 doc_new/users/setup_tests.rst                 | 104 +++++++++++++++++++++
 doc_new/users/supported_systems.rst           | 110 ++++++++++++++++++++++
 22 files changed, 587 insertions(+)

diff --git a/.readthedocs.yml b/.readthedocs.yml
new file mode 100644
index 000000000..636e29c97
--- /dev/null
+++ b/.readthedocs.yml
@@ -0,0 +1,15 @@
+version: 2
+
+build:
+  os: "ubuntu-22.04"
+  tools:
+    python: "3.6"
+
+# Build from the docs/ directory with Sphinx
+sphinx:
+  configuration: doc_new/conf.py
+
+# Explicitly set the version of Python and its requirements
+python:
+  install:
+    - requirements: doc_new/requirements.txt
diff --git a/doc_new/.gitignore b/doc_new/.gitignore
new file mode 100644
index 000000000..5ccff1a6b
--- /dev/null
+++ b/doc_new/.gitignore
@@ -0,0 +1 @@
+html/
diff --git a/doc_new/Makefile b/doc_new/Makefile
new file mode 100644
index 000000000..aea89f641
--- /dev/null
+++ b/doc_new/Makefile
@@ -0,0 +1,5 @@
+all:
+	sphinx-build -b html . html
+
+clean:
+	rm -rf html/
diff --git a/doc_new/_static/custom.css b/doc_new/_static/custom.css
new file mode 100644
index 000000000..cb4d3821d
--- /dev/null
+++ b/doc_new/_static/custom.css
@@ -0,0 +1,4 @@
+/* set multiline tables cells */
+.wy-table-responsive table td {
+    white-space: normal;
+}
diff --git a/doc_new/conf.py b/doc_new/conf.py
new file mode 100644
index 000000000..b333ebf2a
--- /dev/null
+++ b/doc_new/conf.py
@@ -0,0 +1,27 @@
+# Configuration file for the Sphinx documentation builder.
+#
+# For the full list of built-in configuration values, see the documentation:
+# https://www.sphinx-doc.org/en/master/usage/configuration.html
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
+extensions = []
+
+
+# -- Options for HTML output -------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
+
+html_theme = 'sphinx_rtd_theme'
+html_static_path = ['_static']
+
+def setup(app):
+    app.add_css_file('custom.css')
diff --git a/doc_new/developers/api_c_tests.rst b/doc_new/developers/api_c_tests.rst
new file mode 100644
index 000000000..c03f9caf1
--- /dev/null
+++ b/doc_new/developers/api_c_tests.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Developing using C API
+======================
diff --git a/doc_new/developers/api_kvm_tests.rst b/doc_new/developers/api_kvm_tests.rst
new file mode 100644
index 000000000..1ef7ec452
--- /dev/null
+++ b/doc_new/developers/api_kvm_tests.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Developing using KVM API
+========================
diff --git a/doc_new/developers/api_network_tests.rst b/doc_new/developers/api_network_tests.rst
new file mode 100644
index 000000000..4fe45f5f6
--- /dev/null
+++ b/doc_new/developers/api_network_tests.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Developing using network API
+============================
diff --git a/doc_new/developers/api_shell_tests.rst b/doc_new/developers/api_shell_tests.rst
new file mode 100644
index 000000000..2fb2a5068
--- /dev/null
+++ b/doc_new/developers/api_shell_tests.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Developing using shell API
+==========================
diff --git a/doc_new/developers/build_system.rst b/doc_new/developers/build_system.rst
new file mode 100644
index 000000000..cfcaf2d04
--- /dev/null
+++ b/doc_new/developers/build_system.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Build system
+============
diff --git a/doc_new/developers/debugging.rst b/doc_new/developers/debugging.rst
new file mode 100644
index 000000000..18a4a67e9
--- /dev/null
+++ b/doc_new/developers/debugging.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Debugging
+=========
+
+The new test library runs the actual test, i.e. the `test()` function in a
+forked process. To get stack trace of a crashing test in gdb it's needed to
+`set follow-fork-mode child <https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html>`_.
+To trace the test, please use `strace -f` to enable tracing also for the
+forked processes.
diff --git a/doc_new/developers/ltp_library.rst b/doc_new/developers/ltp_library.rst
new file mode 100644
index 000000000..b780b6870
--- /dev/null
+++ b/doc_new/developers/ltp_library.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+LTP Library development
+=======================
diff --git a/doc_new/developers/setup_mailinglist.rst b/doc_new/developers/setup_mailinglist.rst
new file mode 100644
index 000000000..b7320b9a2
--- /dev/null
+++ b/doc_new/developers/setup_mailinglist.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Setting up the Mailing list
+===========================
diff --git a/doc_new/developers/test_case_tutorial.rst b/doc_new/developers/test_case_tutorial.rst
new file mode 100644
index 000000000..43563c234
--- /dev/null
+++ b/doc_new/developers/test_case_tutorial.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Test case tutorial
+==================
diff --git a/doc_new/developers/writing_tests.rst b/doc_new/developers/writing_tests.rst
new file mode 100644
index 000000000..ba0188aee
--- /dev/null
+++ b/doc_new/developers/writing_tests.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Writing tests
+=============
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
diff --git a/doc_new/index.rst b/doc_new/index.rst
new file mode 100644
index 000000000..a8778b3d8
--- /dev/null
+++ b/doc_new/index.rst
@@ -0,0 +1,124 @@
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
+* `Source code <https://github.com/linux-test-project/ltp>`_
+* `Releases <https://github.com/linux-test-project/ltp/releases>`_
+* `Mailing List <http://lists.linux.it/listinfo/ltp>`_
+* `Working patches (patchwork) <https://patchwork.ozlabs.org/project/ltp/list/>`_
+* `Working patches (lore.kernel.org) <https://lore.kernel.org/ltp>`_
+* `#ltp @ libera chat <https://libera.chat/>`_
+
+.. toctree::
+   :maxdepth: 3
+   :hidden:
+   :caption: For users
+
+   users/quick_start
+   users/setup_tests
+   users/supported_systems
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
diff --git a/doc_new/maintainers/ltp_release_procedure.rst b/doc_new/maintainers/ltp_release_procedure.rst
new file mode 100644
index 000000000..808ff2211
--- /dev/null
+++ b/doc_new/maintainers/ltp_release_procedure.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Release process
+===============
diff --git a/doc_new/maintainers/patch_review.rst b/doc_new/maintainers/patch_review.rst
new file mode 100644
index 000000000..1fb76b8bc
--- /dev/null
+++ b/doc_new/maintainers/patch_review.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Patch reviewing
+===============
diff --git a/doc_new/requirements.txt b/doc_new/requirements.txt
new file mode 100644
index 000000000..59709ec72
--- /dev/null
+++ b/doc_new/requirements.txt
@@ -0,0 +1 @@
+sphinx-rtd-theme==2.0.0
diff --git a/doc_new/users/quick_start.rst b/doc_new/users/quick_start.rst
new file mode 100644
index 000000000..40d8dd9c6
--- /dev/null
+++ b/doc_new/users/quick_start.rst
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
diff --git a/doc_new/users/setup_tests.rst b/doc_new/users/setup_tests.rst
new file mode 100644
index 000000000..910cc2315
--- /dev/null
+++ b/doc_new/users/setup_tests.rst
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
diff --git a/doc_new/users/supported_systems.rst b/doc_new/users/supported_systems.rst
new file mode 100644
index 000000000..6220a96e0
--- /dev/null
+++ b/doc_new/users/supported_systems.rst
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
