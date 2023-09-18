Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75173CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:56:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AA423CE511
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:56:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B2363C9611
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:56:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09278200C02
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:56:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B1EC21B45;
 Mon, 18 Sep 2023 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695038169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ui0OdqJFsmr0ee3BMnmlglpWZq5eGMRHJDCCt75xohU=;
 b=YgY73krFV4gC9W9T150EAyGgO+A5rPOZso3qgEWUl/6BJzTGWdg/lCojU9RYwCB1WupeBh
 NmgJ/RV3LF7NOzGr4ueTZkayQbXficBzN2qykqpvQhWAVPxMGqFo8t0wX1lhLBESCTEcne
 SePA7FBTHdS8aBhsO+fO33WCnfln2xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695038169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ui0OdqJFsmr0ee3BMnmlglpWZq5eGMRHJDCCt75xohU=;
 b=Qx+v1VivNEFj3YzLNix1Y+zu6Sru5MgLQ1XgU7+9EM3dfom7lcD0rybf5Q8iNkVqE9zKMi
 jeMk8gi4LNA6LEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FD3113480;
 Mon, 18 Sep 2023 11:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uGn7Gdk6CGXpZQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 18 Sep 2023 11:56:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 13:56:08 +0200
Message-Id: <20230918115608.5630-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918115608.5630-1-andrea.cervesato@suse.de>
References: <20230918115608.5630-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] Add Linux Test eXecutor inside tools
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
 2 files changed, 34 insertions(+)
 create mode 100644 tools/ltx/Makefile

diff --git a/.gitmodules b/.gitmodules
index 088023039..c9a6eea31 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -7,3 +7,6 @@
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
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
