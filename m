Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF4CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 08:25:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC2873CE4D9
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:25:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1CD33CA907
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:25:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD6571B6226A
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:25:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04F641F37F;
 Mon, 18 Sep 2023 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695025509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6WWlxhkQog/UAmlRjB1l/w2V8qbcf97ziiT3NtN+3I=;
 b=fRMZPI2bAvWGLD4yHbIC+z/jFBpfh6DCu+yQKHzqnkvYTPAOELBKoKgavv7ZereQ4foAKJ
 Kw+MA5O8vjEssxQFXgg+pdE0cReAz1HsNuOD50U3AOFwhbWM38EcnVweL9w72cQ0Y8FTsh
 L3xoxvLMRY+NS9m10jn/j7rTMcoSZic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695025509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6WWlxhkQog/UAmlRjB1l/w2V8qbcf97ziiT3NtN+3I=;
 b=gQSEiHzWI3kwJR/FD5FrQxhm1Q63P5JaomFY+SWhLJzIXk+v83JPiAFL05q3pjpKfQ49z1
 5U5T+uxixpjboTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C69A01358A;
 Mon, 18 Sep 2023 08:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2MchL2QJCGWZdAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 18 Sep 2023 08:25:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 10:25:06 +0200
Message-Id: <20230918082506.17464-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918082506.17464-1-andrea.cervesato@suse.de>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add Linux Test eXecutor inside tools
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

The ltx program runs on the system under test (SUT). It's primary
purpose is to run test executables in parallel and serialise the
results.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .gitmodules        |  3 +++
 tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
 tools/ltx/ltx-src  |  1 +
 3 files changed, 35 insertions(+)
 create mode 100644 tools/ltx/Makefile
 create mode 160000 tools/ltx/ltx-src

diff --git a/.gitmodules b/.gitmodules
index c389186c9..2a8b7a399 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -10,3 +10,6 @@
 [submodule "tools/kirk"]
 	path = tools/kirk
 	url = https://github.com/linux-test-project/kirk.git
+[submodule "tools/ltx/ltx-src"]
+	path = tools/ltx/ltx-src
+	url = https://github.com/linux-test-project/ltx.git
diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
new file mode 100644
index 000000000..4810ec8df
--- /dev/null
+++ b/tools/ltx/Makefile
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2023 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) 2023 Andrea Cervesato <andrea.cervesato@suse.com>
+#
+# Install script for Linux Test eXecutor
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+ifneq ($(wildcard $(abs_srcdir)/ltx-src/*),)
+
+BINARY=ltx
+
+MAKE_TARGETS := $(BINARY)
+
+CFLAGS+=-I$(abs_srcdir)/ltx-src/ -I$(abs_srcdir)/ltx-src/msgpack/
+
+$(BINARY): $(wildcard $(abs_srcdir)/ltx-src/*.c $(abs_srcdir)/ltx-src/msgpack/*.c)
+ifdef VERBOSE
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
+else
+	@echo CC $@
+	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
+endif
+
+INSTALL_DIR := $(prefix)
+
+endif
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/tools/ltx/ltx-src b/tools/ltx/ltx-src
new file mode 160000
index 000000000..d6d150947
--- /dev/null
+++ b/tools/ltx/ltx-src
@@ -0,0 +1 @@
+Subproject commit d6d1509479537f4fdfa9b5adcb67eb6312714999
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
