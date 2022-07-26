Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728D3CCA489
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:53:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 561BF3CA0A3
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:53:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C55A3C04EF
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:52:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3F3A600701
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:52:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8D76C375CB;
 Tue, 26 Jul 2022 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1658836373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RuF7aGkBcQrRfahPYqO/o6qlOZMEFnYDHJzSbO2qxk=;
 b=j/4DY8977Z475lhyBoYQ68ru7+kdcvJg0e3qhIJVf2cxqj6BdYBpxM+Dzq/FIej/Tgt+iw
 NQXhY+S3qIB5M9dVNhYGRbbbux1Yt+yACFMFYdWwgu7H+FE7DnyisXR5LEOuTTkSMI4X3Z
 AeeKCWecrSuobpfIp8rP6V2Lt5tdpac=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id 5144F2C15D;
 Tue, 26 Jul 2022 11:52:53 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 26 Jul 2022 12:52:34 +0100
Message-Id: <20220726115234.25310-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Yt+RA5chfBh54kvI@pevik>
References: <Yt+RA5chfBh54kvI@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tools: Check headers with checkpatch.pl
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

checkpatch.pl doesn't load included headers so they must be passed to
it specifically. This change automatically includes headers from the
current directory. Manual intervention is still required if a test
author changes a header located elsewhere. However you can now write
'make check-header.h', once in the correct directory.

Note that our Sparse based tool (amongst others) loads headers and
checks at least some of the content.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/env_post.mk             | 1 +
 include/mk/generic_leaf_target.inc | 2 +-
 include/mk/rules.mk                | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index dc4df41d3..a00f31b08 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -92,6 +92,7 @@ endif
 
 CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcard $(abs_srcdir)/*.c)))))
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
+CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
 CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
 SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 33e9c9ea0..565a282bb 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -110,6 +110,6 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
 install: $(INSTALL_FILES)
 
 $(CHECK_TARGETS): | $(CHECK_DEPS)
-check: $(CHECK_TARGETS) $(SHELL_CHECK_TARGETS)
+check: $(CHECK_HEADER_TARGETS) $(CHECK_TARGETS) $(SHELL_CHECK_TARGETS)
 
 # vim: syntax=make
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index 32d8d05a7..517863c04 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -57,6 +57,15 @@ else
 	@-$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
 endif
 
+.PHONY: $(CHECK_HEADER_TARGETS)
+$(CHECK_HEADER_TARGETS): check-%.h: %.h
+ifdef VERBOSE
+	-$(CHECK_NOFLAGS) $<
+else
+	@echo CHECK $(target_rel_dir)$<
+	@-$(CHECK_NOFLAGS) $<
+endif
+
 .PHONY: $(SHELL_CHECK_TARGETS)
 $(SHELL_CHECK_TARGETS): check-%.sh: %.sh
 ifdef VERBOSE
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
