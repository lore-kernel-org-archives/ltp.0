Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F0BCCF9FF
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 09:27:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508EB3CC8E6
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 10:27:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F39903CC8BE
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:27:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D59E200746
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:27:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D4721F461;
 Fri, 31 Oct 2025 09:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761902835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8D+MIJidXnQ6NFihiV6Hh81nlsjQhIMK0uvsrj0K2Os=;
 b=zHkHAdEaUPHKL4PnHi4fVDbU74BjXsG9Ph1JljzMho3Vkm1iNyh0g2+rcpfPRCBnbnZW6r
 rx9K/7/CltlKOFbe0+YVrA2gdHbXTaTx9JT6wB2EmrqLOceC4IFQ38dZ46R1PW/VFnT4Rd
 z7VigiIFKi/rSOyVJu1Mk9G/nVR/8pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761902835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8D+MIJidXnQ6NFihiV6Hh81nlsjQhIMK0uvsrj0K2Os=;
 b=vweQDp0usvwpYHwfYnmt7qweshukjhvKYreTjmVOe8Fl+2DmXoBZ9GxnNsUMQtjwsw5mkX
 2OtWBLFhvwDAjCAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zHkHAdEa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vweQDp0u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761902835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8D+MIJidXnQ6NFihiV6Hh81nlsjQhIMK0uvsrj0K2Os=;
 b=zHkHAdEaUPHKL4PnHi4fVDbU74BjXsG9Ph1JljzMho3Vkm1iNyh0g2+rcpfPRCBnbnZW6r
 rx9K/7/CltlKOFbe0+YVrA2gdHbXTaTx9JT6wB2EmrqLOceC4IFQ38dZ46R1PW/VFnT4Rd
 z7VigiIFKi/rSOyVJu1Mk9G/nVR/8pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761902835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8D+MIJidXnQ6NFihiV6Hh81nlsjQhIMK0uvsrj0K2Os=;
 b=vweQDp0usvwpYHwfYnmt7qweshukjhvKYreTjmVOe8Fl+2DmXoBZ9GxnNsUMQtjwsw5mkX
 2OtWBLFhvwDAjCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E454213B04;
 Fri, 31 Oct 2025 09:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HcSNvKABGk8WQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 31 Oct 2025 09:27:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 31 Oct 2025 10:27:10 +0100
MIME-Version: 1.0
Message-Id: <20251031-kirk_move_submodule-v1-2-3cad4270a0b5@suse.com>
References: <20251031-kirk_move_submodule-v1-0-3cad4270a0b5@suse.com>
In-Reply-To: <20251031-kirk_move_submodule-v1-0-3cad4270a0b5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761902834; l=1733;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=M4ZkYUBc+XpBrotJ7o82NKeuTLuJ7cic15p5g31VMRg=;
 b=pPWmg+kg9HadYVzznbcQQg3bij5qRPbk30P4bPPXo1awKCt5cCskiJE2d0IZyZwR8vQhzJfc/
 PlG1zrKR8V3CdHzeewG6imiOrsADhuvymKGcBjQxhKYaFqK8/5YbEGy
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 0D4721F461
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] kirk: move kirk source code inside
 tools/kirk/kirk-src
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .gitmodules         |  3 +++
 tools/kirk/Makefile | 22 ++++++++++++++++++++++
 tools/kirk/kirk-src |  1 +
 3 files changed, 26 insertions(+)

diff --git a/.gitmodules b/.gitmodules
index 8f081decc..a1ac4b1b8 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -7,3 +7,6 @@
 [submodule "tools/ltx/ltx-src"]
 	path = tools/ltx/ltx-src
 	url = https://github.com/linux-test-project/ltx.git
+[submodule "tools/kirk/kirk-src"]
+	path = tools/kirk/kirk-src
+	url = https://github.com/linux-test-project/kirk.git
diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
new file mode 100644
index 000000000..1a09c43ce
--- /dev/null
+++ b/tools/kirk/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2023 SUSE LLC <andrea.cervesato@suse.com>
+#
+# Install script for Linux Testing Project
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+BASE_DIR		:= $(abspath $(DESTDIR)/$(prefix))
+
+install:
+	mkdir -p $(BASE_DIR)/libkirk
+	mkdir -p $(BASE_DIR)/libkirk/channels
+
+	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
+	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
+	install -m 00775 $(top_srcdir)/tools/kirk/kirk-src/kirk $(BASE_DIR)/kirk
+
+	cd $(BASE_DIR) && ln -sf kirk runltp-ng
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
new file mode 160000
index 000000000..e0ef9f28b
--- /dev/null
+++ b/tools/kirk/kirk-src
@@ -0,0 +1 @@
+Subproject commit e0ef9f28bcf15d00cf8a03915df894bb38a5d8ea

-- 
2.51.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
