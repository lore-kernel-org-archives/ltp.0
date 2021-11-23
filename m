Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F8FC4332F
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 12:44:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCB863C8E78
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 13:44:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A5673C8DC5
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 13:43:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E30810009AB
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 13:43:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CC35A2191A;
 Tue, 23 Nov 2021 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1637671436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jlo8nxCi1O+BImzOi0WxkMrAHq4EZ2aEXRQ6f3bRW+Y=;
 b=UNO1t8lulLeJOUyYCx8YpkLkMeCMYRJsVq37S7XX1Zotse188EG+tToAv3wfwmREJjL6sw
 CH8wPWFSv26Q5bClHubKipHBjNLNFHpCuPIShX6WtE8Wnh43weepyJD4RwQWWO6VG+03Yp
 YDFg6es5jybhhjJPnzNyrI4KoxLVg58=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id 9E2E1A3B88;
 Tue, 23 Nov 2021 12:43:56 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 23 Nov 2021 12:43:46 +0000
Message-Id: <20211123124348.31073-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123124348.31073-1-rpalethorpe@suse.com>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tools/sparse: Add static check
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

This was adapted from Sparse's inbuilt check_duplicates (-Wdecl). The
original check appears to print a warning whenever a symbol is
non-static, but has no prototype. It appears to work because library
symbols are usually declared first in a header file and then again
with their definition in a source file.

The LTP version also checks for the various library prefixes, but
should otherwise be the same.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 tools/sparse/sparse-ltp.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index 45874e8eb..73725d191 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -82,6 +82,57 @@ static void do_entrypoint_checks(struct entrypoint *ep)
 	} END_FOR_EACH_PTR(bb);
 }
 
+/* Check for LTP-003 and LTP-004
+ *
+ * Try to find cases where the static keyword was forgotten.
+ */
+static void check_symbol_visibility(struct symbol *sym)
+{
+	struct symbol *next = sym;
+	unsigned long mod = sym->ctype.modifiers;
+	const char *name = show_ident(sym->ident);
+	int has_lib_prefix = !strncmp("tst_", name, 4) ||
+		!strncmp("TST_", name, 4) ||
+		!strncmp("ltp_", name, 4) ||
+		!strncmp("safe_", name, 5);
+
+	if (!(mod & MOD_TOPLEVEL))
+		return;
+
+	if (has_lib_prefix && (mod & MOD_STATIC)) {
+		warning(sym->pos,
+			"LTP-003: Symbol '%s' has the LTP public library prefix, but is static (private).",
+			name);
+		return;
+	}
+
+	if ((mod & MOD_STATIC))
+		return;
+
+	if (tu_kind == LTP_LIB && !has_lib_prefix) {
+		warning(sym->pos,
+			"LTP-003: Symbol '%s' is a public library function, but is missing the 'tst_' prefix",
+			name);
+		return;
+	}
+
+	if (next->same_symbol)
+		return;
+
+	if (sym->ident == &main_ident)
+		return;
+
+	warning(sym->pos,
+		"Symbol '%s' has no prototype or library ('tst_') prefix. Should it be static?",
+		name);
+}
+
+/* AST level checks */
+static void do_symbol_checks(struct symbol *sym)
+{
+	check_symbol_visibility(sym);
+}
+
 /* Compile the AST into a graph of basicblocks */
 static void process_symbols(struct symbol_list *list)
 {
@@ -90,6 +141,8 @@ static void process_symbols(struct symbol_list *list)
 	FOR_EACH_PTR(list, sym) {
 		struct entrypoint *ep;
 
+		do_symbol_checks(sym);
+
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
 		if (!ep || !ep->entry)
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
