Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C038C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:22:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF1C33CFFB1
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:22:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6082A3CFBF6
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:48 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7591A20B260
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE2A2347C1;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=falfHRhZLyGesCXvxwkiTgg9dX2WyRM99oBb/Bob5Iw=;
 b=Eo9iYq7jD/QvyQ1A17K/jKu2YBXaBdUSEuCcDSbcgLpchouQ/U024kYQrJqwdDzMBjk1tR
 qjTarnmXPZn6uMQqT+jpyOuLnI2Q1AfzCfztm4j/ZZoSPjhKCuLi3+tfxlAEPQ9Vlbs2fh
 hE8yQakHT3nVrMR1oCwwVeWt1a4LI2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=falfHRhZLyGesCXvxwkiTgg9dX2WyRM99oBb/Bob5Iw=;
 b=TqXm62H/njsfafFQ/v5CF3xAH0KtwaNKlnS/XDEcjUdfvNsQ0yYSTfKdrD1ji90Mz8LhQq
 oAzv8QIkuZjEYLBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=falfHRhZLyGesCXvxwkiTgg9dX2WyRM99oBb/Bob5Iw=;
 b=QDHOA2mjPc2zjpOPWsr61aKPk8xdYzbLYIb8dQCfxtla0363ytU8d+zVfKHjFQtMqS5K6p
 Xo2+9c0g70/DiqcGH41aF9wU5s0gwnIsGIpUS/RFgkFovkcEiwkHkNGtQYYemD8R9Mb3en
 U/saJR8LUupVPvsg46xk3+9XUWQgR9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=falfHRhZLyGesCXvxwkiTgg9dX2WyRM99oBb/Bob5Iw=;
 b=GtuvE6LMvxdZS2VlhSOV+wPO+X9HBEmOEJb/lG3Sk1yzuLGDp8OY3XLHxk2PBnZi2vtKk4
 xSN4YcBh2pLsN9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D865E136D6;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDF2M94M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:52 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-8-79b603c8aea1@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/10] Refactor build system documentation
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

The build system documentation has been refactored using RST format and
fixing typos or syntax errors. The last section referring to INSTALL and
TODO has been removed, since those are files which we are not
maintaining anymore.
---
 doc_new/developers/build_system.rst | 209 ++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/doc_new/developers/build_system.rst b/doc_new/developers/build_system.rst
index cfcaf2d04..1a6ad4c56 100644
--- a/doc_new/developers/build_system.rst
+++ b/doc_new/developers/build_system.rst
@@ -2,3 +2,212 @@
 
 Build system
 ============
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

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
