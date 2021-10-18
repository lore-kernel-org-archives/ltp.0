Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B46C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:48:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412A960F9D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 412A960F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0479A3C2EBC
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 17:48:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6035F3C3077
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB98A1400E58
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B90D21961
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634572039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEXx5w6fRkWKj9WgtromYQ0/XLrY8qDjmZHEhIXcsJk=;
 b=hPyzdFKUmb8uZgvfwa+W5Qe9uDrSH5uc/KJQ3qzJoQqlisRJ/ga+pDbwEpfdFsziN4srQk
 uMEGFmC/Y2gH7uCeDU3Fhbi6fjBWGMo5DfaKrWhQGgAqUJqH2bXlUi+l/5jDKvpjnAtKFy
 /yyba7RgqBTjey29ZlIxxDSF0XmG2mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634572039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEXx5w6fRkWKj9WgtromYQ0/XLrY8qDjmZHEhIXcsJk=;
 b=lPeh92dE7gPJR6u8Q47/AYM3fTPzDOkZtcuB4/AAIey0kgsT0IUA1Pqbm6xB11EfXhmmfN
 9v3pPYfHkiXFf1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 377A8140B7
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d7s5DAeXbWGAJwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Oct 2021 17:47:59 +0200
Message-Id: <20211018154800.11013-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018154800.11013-1-chrubis@suse.cz>
References: <20211018154800.11013-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/7] docparse/Makefile: Do not abort on missing
 generators
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

Since we want to use the metadata.json in the testrunner it must bte
build unconditionally.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Makefile           | 5 +----
 docparse/Makefile  | 4 ----
 m4/ltp-docparse.m4 | 3 ---
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 4e37362f9..447525e75 100644
--- a/Makefile
+++ b/Makefile
@@ -62,10 +62,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
 endif
 endef
 
-COMMON_TARGETS		+= testcases tools
-ifeq ($(WITH_METADATA),yes)
-COMMON_TARGETS		+= docparse
-endif
+COMMON_TARGETS		+= testcases tools docparse
 
 # Don't want to nuke the original files if we're installing in-build-tree.
 ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
diff --git a/docparse/Makefile b/docparse/Makefile
index e2defad38..5f2f40544 100644
--- a/docparse/Makefile
+++ b/docparse/Makefile
@@ -18,10 +18,6 @@ METADATA_GENERATOR_PARAMS := --xsltproc-opts "--stringparam toc.section.depth 1"
 METADATA_GENERATOR_PARAMS_HTML := -f xhtml
 METADATA_GENERATOR_PARAMS_PDF := -f pdf
 METADATA_GENERATOR_PARAMS_HTML_CHUNKED := -f chunked
-else ifeq ($(METADATA_GENERATOR),)
-$(error 'METADATA_GENERATOR' not not configured, run ./configure in the root directory)
-else
-$(error '$(METADATA_GENERATOR)' not supported, only asciidoctor and asciidoc are supported)
 endif
 
 ifdef VERBOSE
diff --git a/m4/ltp-docparse.m4 b/m4/ltp-docparse.m4
index 88d2e08e4..4cdcfc071 100644
--- a/m4/ltp-docparse.m4
+++ b/m4/ltp-docparse.m4
@@ -31,7 +31,6 @@ AC_DEFUN([LTP_CHECK_METADATA_GENERATOR_ASCIIDOC], [
 ])
 
 AC_DEFUN([LTP_DOCPARSE], [
-with_metadata=no
 with_metadata_html=no
 with_metadata_pdf=no
 
@@ -96,7 +95,6 @@ elif test "x$ax_perl_modules_failed" = x1; then
 elif test "x$with_metadata_html" = xno -a "x$with_metadata_pdf" = xno; then
 	AC_MSG_WARN([$reason, $hint])
 else
-	with_metadata=yes
 	AC_SUBST(METADATA_GENERATOR, $with_metadata_generator)
 	if test "x$with_metadata_html" = xno -a "x$enable_metadata_html" = xyes; then
 		AC_MSG_WARN([HTML $reason, $hint])
@@ -106,7 +104,6 @@ else
 	fi
 fi
 
-AC_SUBST(WITH_METADATA, $with_metadata)
 AC_SUBST(WITH_METADATA_HTML, $with_metadata_html)
 AC_SUBST(WITH_METADATA_PDF, $with_metadata_pdf)
 ])
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
