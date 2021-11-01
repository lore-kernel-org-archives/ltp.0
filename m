Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280DC4167B
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:59:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A7B61247
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6A7B61247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94D283C70CC
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:54:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A34013C710E
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:52:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 48A72100079B
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:52:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF2FA212CA
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635778371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEuPfT94iJKRplpUCbi7+WiS8KWBdIRRO6nZvqBcoh0=;
 b=NTA8kJMIzYjiSUNMdw7NO3GBpkvLOu1ATHi5362R83Z5InPkORF43QL7LMkeBIugybLMVQ
 xlprZSt/BdZx7yXlNwF0m5m7g+DLtM+SZHSmaGI9DIKSRXf9KBAJNtp8i20Pgi4jTb/5eS
 JI7EFkMW4bqphwMnqkn8wPwSMfLBiaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635778371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEuPfT94iJKRplpUCbi7+WiS8KWBdIRRO6nZvqBcoh0=;
 b=NfPSRiMHwDSk3ESH6vrmYBMc+DwWRzYKUP5bhK0swKtIUey7vyKwY3E9ALvf7ZkyyMwuaf
 n2aZQpaTprVbaVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BE3713522
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ly6mJEP/f2HILQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Nov 2021 14:52:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Nov 2021 15:53:42 +0100
Message-Id: <20211101145342.7166-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101145342.7166-1-chrubis@suse.cz>
References: <20211101145342.7166-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] docparse: Split into metadata and docparse
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

That way the metadata are build and installed unconditionally as they
are going to be integral part of the test execution framework.

The metadata file is also renamed to ltp.json and installed into
$DESTDIR/metadata/ltp.json.

The docparse build is triggered from the metadata Makefile since it has
to be done once the ltp.json is fully generated.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Makefile                                      |  5 +---
 docparse/.gitignore                           |  2 --
 docparse/Makefile                             | 12 ++-------
 metadata/.gitignore                           |  2 ++
 metadata/Makefile                             | 26 +++++++++++++++++++
 {docparse => metadata}/data_storage.h         |  0
 docparse/docparse.c => metadata/metaparse.c   |  0
 {docparse => metadata}/parse.sh               |  0
 {docparse => metadata}/tests/Makefile         |  0
 {docparse => metadata}/tests/array_size01.c   |  0
 .../tests/array_size01.c.json                 |  0
 {docparse => metadata}/tests/array_size02.c   |  0
 .../tests/array_size02.c.json                 |  0
 {docparse => metadata}/tests/array_size03.c   |  0
 .../tests/array_size03.c.json                 |  0
 {docparse => metadata}/tests/array_size04.c   |  0
 .../tests/array_size04.c.json                 |  0
 {docparse => metadata}/tests/empty_struct.c   |  0
 .../tests/empty_struct.c.json                 |  0
 {docparse => metadata}/tests/expand_flags.c   |  0
 .../tests/expand_flags.c.json                 |  0
 {docparse => metadata}/tests/include.c        |  0
 {docparse => metadata}/tests/include.c.json   |  0
 {docparse => metadata}/tests/include.h        |  0
 {docparse => metadata}/tests/macro.c          |  0
 {docparse => metadata}/tests/macro.c.json     |  0
 .../tests/multiline_macro.c                   |  0
 .../tests/multiline_macro.c.json              |  0
 {docparse => metadata}/tests/tags.c           |  0
 {docparse => metadata}/tests/tags.c.json      |  0
 {docparse => metadata}/tests/test.sh          |  2 +-
 31 files changed, 32 insertions(+), 17 deletions(-)
 create mode 100644 metadata/.gitignore
 create mode 100644 metadata/Makefile
 rename {docparse => metadata}/data_storage.h (100%)
 rename docparse/docparse.c => metadata/metaparse.c (100%)
 rename {docparse => metadata}/parse.sh (100%)
 rename {docparse => metadata}/tests/Makefile (100%)
 rename {docparse => metadata}/tests/array_size01.c (100%)
 rename {docparse => metadata}/tests/array_size01.c.json (100%)
 rename {docparse => metadata}/tests/array_size02.c (100%)
 rename {docparse => metadata}/tests/array_size02.c.json (100%)
 rename {docparse => metadata}/tests/array_size03.c (100%)
 rename {docparse => metadata}/tests/array_size03.c.json (100%)
 rename {docparse => metadata}/tests/array_size04.c (100%)
 rename {docparse => metadata}/tests/array_size04.c.json (100%)
 rename {docparse => metadata}/tests/empty_struct.c (100%)
 rename {docparse => metadata}/tests/empty_struct.c.json (100%)
 rename {docparse => metadata}/tests/expand_flags.c (100%)
 rename {docparse => metadata}/tests/expand_flags.c.json (100%)
 rename {docparse => metadata}/tests/include.c (100%)
 rename {docparse => metadata}/tests/include.c.json (100%)
 rename {docparse => metadata}/tests/include.h (100%)
 rename {docparse => metadata}/tests/macro.c (100%)
 rename {docparse => metadata}/tests/macro.c.json (100%)
 rename {docparse => metadata}/tests/multiline_macro.c (100%)
 rename {docparse => metadata}/tests/multiline_macro.c.json (100%)
 rename {docparse => metadata}/tests/tags.c (100%)
 rename {docparse => metadata}/tests/tags.c.json (100%)
 rename {docparse => metadata}/tests/test.sh (88%)

diff --git a/Makefile b/Makefile
index 4e37362f9..63010d531 100644
--- a/Makefile
+++ b/Makefile
@@ -62,10 +62,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
 endif
 endef
 
-COMMON_TARGETS		+= testcases tools
-ifeq ($(WITH_METADATA),yes)
-COMMON_TARGETS		+= docparse
-endif
+COMMON_TARGETS		+= testcases tools metadata
 
 # Don't want to nuke the original files if we're installing in-build-tree.
 ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
diff --git a/docparse/.gitignore b/docparse/.gitignore
index 7a87b4234..d786a4762 100644
--- a/docparse/.gitignore
+++ b/docparse/.gitignore
@@ -1,7 +1,5 @@
 /*.txt
 /docbook-xsl.css
-/docparse
-/metadata.json
 /metadata.html
 /metadata.pdf
 /metadata.chunked/
diff --git a/docparse/Makefile b/docparse/Makefile
index e2defad38..ab30efc80 100644
--- a/docparse/Makefile
+++ b/docparse/Makefile
@@ -29,7 +29,6 @@ METADATA_GENERATOR_PARAMS += -v
 endif
 
 CLEAN_TARGETS		:= *.css *.js *.txt
-MAKE_TARGETS		:= metadata.json
 
 ifeq ($(WITH_METADATA_HTML),yes)
 MAKE_TARGETS		+= metadata.html
@@ -42,8 +41,6 @@ ifeq ($(WITH_METADATA_PDF),yes)
 MAKE_TARGETS		+= metadata.pdf
 endif
 
-HOST_MAKE_TARGETS	:= docparse
-
 INSTALL_DIR = metadata
 INSTALL_TARGETS = *.css *.js
 
@@ -51,13 +48,8 @@ ifndef METADATA_GENERATOR
 METADATA_GENERATOR := asciidoctor
 endif
 
-.PHONY: metadata.json
-
-metadata.json: docparse
-	$(abs_srcdir)/parse.sh > metadata.json
-
-txt: metadata.json
-	$(abs_srcdir)/testinfo.pl metadata.json
+txt: ../metadata/ltp.json
+	$(abs_srcdir)/testinfo.pl ../metadata/ltp.json
 
 ifeq ($(WITH_METADATA_HTML),yes)
 metadata.html: txt
diff --git a/metadata/.gitignore b/metadata/.gitignore
new file mode 100644
index 000000000..07d2fd6ff
--- /dev/null
+++ b/metadata/.gitignore
@@ -0,0 +1,2 @@
+metaparse
+ltp.json
diff --git a/metadata/Makefile b/metadata/Makefile
new file mode 100644
index 000000000..76a3aed94
--- /dev/null
+++ b/metadata/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/functions.mk
+
+MAKE_TARGETS		:= ltp.json docparse
+HOST_MAKE_TARGETS	:= metaparse
+INSTALL_DIR		= metadata
+
+.PHONY: ltp.json
+
+ltp.json: metaparse
+	$(abs_srcdir)/parse.sh > ltp.json
+
+docparse: ltp.json
+ifeq ($(WITH_METADATA),yes)
+	$(MAKE) -C ../docparse/
+endif
+
+test:
+	$(MAKE) -C tests/ test
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/docparse/data_storage.h b/metadata/data_storage.h
similarity index 100%
rename from docparse/data_storage.h
rename to metadata/data_storage.h
diff --git a/docparse/docparse.c b/metadata/metaparse.c
similarity index 100%
rename from docparse/docparse.c
rename to metadata/metaparse.c
diff --git a/docparse/parse.sh b/metadata/parse.sh
similarity index 100%
rename from docparse/parse.sh
rename to metadata/parse.sh
diff --git a/docparse/tests/Makefile b/metadata/tests/Makefile
similarity index 100%
rename from docparse/tests/Makefile
rename to metadata/tests/Makefile
diff --git a/docparse/tests/array_size01.c b/metadata/tests/array_size01.c
similarity index 100%
rename from docparse/tests/array_size01.c
rename to metadata/tests/array_size01.c
diff --git a/docparse/tests/array_size01.c.json b/metadata/tests/array_size01.c.json
similarity index 100%
rename from docparse/tests/array_size01.c.json
rename to metadata/tests/array_size01.c.json
diff --git a/docparse/tests/array_size02.c b/metadata/tests/array_size02.c
similarity index 100%
rename from docparse/tests/array_size02.c
rename to metadata/tests/array_size02.c
diff --git a/docparse/tests/array_size02.c.json b/metadata/tests/array_size02.c.json
similarity index 100%
rename from docparse/tests/array_size02.c.json
rename to metadata/tests/array_size02.c.json
diff --git a/docparse/tests/array_size03.c b/metadata/tests/array_size03.c
similarity index 100%
rename from docparse/tests/array_size03.c
rename to metadata/tests/array_size03.c
diff --git a/docparse/tests/array_size03.c.json b/metadata/tests/array_size03.c.json
similarity index 100%
rename from docparse/tests/array_size03.c.json
rename to metadata/tests/array_size03.c.json
diff --git a/docparse/tests/array_size04.c b/metadata/tests/array_size04.c
similarity index 100%
rename from docparse/tests/array_size04.c
rename to metadata/tests/array_size04.c
diff --git a/docparse/tests/array_size04.c.json b/metadata/tests/array_size04.c.json
similarity index 100%
rename from docparse/tests/array_size04.c.json
rename to metadata/tests/array_size04.c.json
diff --git a/docparse/tests/empty_struct.c b/metadata/tests/empty_struct.c
similarity index 100%
rename from docparse/tests/empty_struct.c
rename to metadata/tests/empty_struct.c
diff --git a/docparse/tests/empty_struct.c.json b/metadata/tests/empty_struct.c.json
similarity index 100%
rename from docparse/tests/empty_struct.c.json
rename to metadata/tests/empty_struct.c.json
diff --git a/docparse/tests/expand_flags.c b/metadata/tests/expand_flags.c
similarity index 100%
rename from docparse/tests/expand_flags.c
rename to metadata/tests/expand_flags.c
diff --git a/docparse/tests/expand_flags.c.json b/metadata/tests/expand_flags.c.json
similarity index 100%
rename from docparse/tests/expand_flags.c.json
rename to metadata/tests/expand_flags.c.json
diff --git a/docparse/tests/include.c b/metadata/tests/include.c
similarity index 100%
rename from docparse/tests/include.c
rename to metadata/tests/include.c
diff --git a/docparse/tests/include.c.json b/metadata/tests/include.c.json
similarity index 100%
rename from docparse/tests/include.c.json
rename to metadata/tests/include.c.json
diff --git a/docparse/tests/include.h b/metadata/tests/include.h
similarity index 100%
rename from docparse/tests/include.h
rename to metadata/tests/include.h
diff --git a/docparse/tests/macro.c b/metadata/tests/macro.c
similarity index 100%
rename from docparse/tests/macro.c
rename to metadata/tests/macro.c
diff --git a/docparse/tests/macro.c.json b/metadata/tests/macro.c.json
similarity index 100%
rename from docparse/tests/macro.c.json
rename to metadata/tests/macro.c.json
diff --git a/docparse/tests/multiline_macro.c b/metadata/tests/multiline_macro.c
similarity index 100%
rename from docparse/tests/multiline_macro.c
rename to metadata/tests/multiline_macro.c
diff --git a/docparse/tests/multiline_macro.c.json b/metadata/tests/multiline_macro.c.json
similarity index 100%
rename from docparse/tests/multiline_macro.c.json
rename to metadata/tests/multiline_macro.c.json
diff --git a/docparse/tests/tags.c b/metadata/tests/tags.c
similarity index 100%
rename from docparse/tests/tags.c
rename to metadata/tests/tags.c
diff --git a/docparse/tests/tags.c.json b/metadata/tests/tags.c.json
similarity index 100%
rename from docparse/tests/tags.c.json
rename to metadata/tests/tags.c.json
diff --git a/docparse/tests/test.sh b/metadata/tests/test.sh
similarity index 88%
rename from docparse/tests/test.sh
rename to metadata/tests/test.sh
index 767cc464c..c11f0e496 100755
--- a/docparse/tests/test.sh
+++ b/metadata/tests/test.sh
@@ -3,7 +3,7 @@
 fail=0
 
 for i in *.c; do
-	../docparse $i > tmp.json
+	../metaparse $i > tmp.json
 	if ! diff tmp.json $i.json &> /dev/null; then
 		echo "***"
 		echo "$i output differs!"
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
