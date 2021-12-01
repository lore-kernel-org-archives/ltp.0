Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA7EC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 16:24:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B07E93C8FE2
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 17:24:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 432793C8AA2
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 17:24:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C17E3601CA2
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 17:24:26 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3055C2170C;
 Wed,  1 Dec 2021 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638375866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Km7qgpPO4jbm1oYQ1ROa+w5GeSl62VyDrx9EXSI8Q1U=;
 b=tSIXdKjyrNaBH1NsDD5NAC1qlAlMToX2UghIdQ0WwI1HFp5v6tmuvz7NN+sfNK5E0hOlkY
 sn2GRTvn6niUntutbiRsyE4nU7pj119Vl4w6GbIc1iWB95BukqpRNPuL7DUzZa5FFTy4XY
 FfC+b/1YQx6tYhL3i1bGwT5iDFpUEGA=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id 00F22A3B83;
 Wed,  1 Dec 2021 16:24:25 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed,  1 Dec 2021 16:24:01 +0000
Message-Id: <20211201162401.12725-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211201162401.12725-1-rpalethorpe@suse.com>
References: <20211201162401.12725-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] check: Add LTP-005 null termination check on
 test.tags
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

This only adds a check for test.tags. There are other null terminated
arrays which would benefit from this check. However these appear to be
accessed on every invocation of a test. So missing the null sentinel
value will reliably result in a segfault.

This check should be relatively easy to generalise. However this would
still complicate this initial commit. Other types and variables
produce different ASTs even if the concrete syntax looks
similar.

This does not explicitly check for zero at the end of an array. For
one thing the zero is implicit when one writes '{}'. We just get an
empty expression list. When one writes '{NULL, 0}', we get an implicit
cast to 'char *'. We assume an implicit cast must be zero as the
compiler should not allow some random value to be cast to a pointer
implicitly.

Perhaps surprisingly the following will be checked for null
termination correctly:

static struct tst_tag tags[] = { ..., {} };

static struct tst_test test = {
       .tags = tags,
       ...
}

There is some logic in the code which is particularly baffling

	if (item_init->type == EXPR_POS)
		item_init = item_init->init_expr;

This helps with the above case as for some reason we only see EXPR_POS
when test.tags are initialized inline.

		if (entry->init_expr->type != EXPR_SYMBOL)
			continue;

This prevents a segfault when we encounter test.timeout which is
represented with an immediate value (EXPR_VALUE). The more corner
cases we need to handle the more lines like this appear.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 tools/sparse/sparse-ltp.c | 92 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index b1677d336..078d3eb43 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -126,10 +126,102 @@ static void check_symbol_visibility(const struct symbol *const sym)
 		name);
 }
 
+/* See base_type() in dissect.c */
+static struct symbol *unwrap_base_type(const struct symbol *sym)
+{
+	switch (sym->ctype.base_type->type) {
+	case SYM_ARRAY:
+	case SYM_NODE:
+	case SYM_PTR:
+		return unwrap_base_type(sym->ctype.base_type);
+	default:
+		return sym->ctype.base_type;
+	}
+}
+
+/* Checks if some struct array initializer is terminated with a zeroed
+ * (NULL) item e.g. {} or {NULL, NULL, ...}
+ */
+static int is_terminated_with_null_struct(const struct symbol *const sym)
+{
+	struct expression *arr_init = sym->initializer;
+	struct expression *item_init =
+		last_ptr_list((struct ptr_list *)arr_init->expr_list);
+	struct expression *entry;
+
+	if (item_init->type == EXPR_POS)
+		item_init = item_init->init_expr;
+
+	FOR_EACH_PTR(item_init->expr_list, entry) {
+		if (entry->init_expr->type == EXPR_IMPLIED_CAST)
+			continue;
+
+		return 0;
+	} END_FOR_EACH_PTR(entry);
+
+	return 1;
+}
+
+/* Check for (one instance of) LTP-005
+ *
+ * The tags array is only accessed when the test fails. So we perform
+ * a static check to ensure it ends with {} or {NULL, NULL}.
+ */
+static void check_tag_initializer(const struct symbol *const sym)
+{
+	if (is_terminated_with_null_struct(sym))
+		return;
+
+	warning(sym->pos,
+		"test.tags array doesn't appear to be null-terminated; did you forget to add '{}' as the final entry?");
+}
+
+/* Find struct tst_test test = { ... } and perform tests on its initializer */
+static void check_test_struct(const struct symbol *const sym)
+{
+	static struct ident *tst_test, *tst_test_test, *tst_tag;
+	struct ident *ctype_name = NULL;
+	struct expression *init = sym->initializer;
+	struct expression *entry;
+
+	if (!sym->ctype.base_type)
+		return;
+
+	ctype_name = sym->ctype.base_type->ident;
+
+	if (!init)
+		return;
+
+	if (!tst_test_test) {
+		tst_test = built_in_ident("tst_test");
+		tst_test_test = built_in_ident("test");
+		tst_tag = built_in_ident("tst_tag");
+	}
+
+	if (sym->ident != tst_test_test)
+		return;
+
+	if (ctype_name != tst_test)
+		return;
+
+	FOR_EACH_PTR(init->expr_list, entry) {
+		if (entry->init_expr->type != EXPR_SYMBOL)
+			continue;
+
+		const struct symbol *entry_init = entry->init_expr->symbol;
+		const struct symbol *entry_ctype = unwrap_base_type(entry_init);
+
+		if (entry_ctype->ident == tst_tag)
+			check_tag_initializer(entry_init);
+	} END_FOR_EACH_PTR(entry);
+
+}
+
 /* AST level checks */
 static void do_symbol_checks(struct symbol *sym)
 {
 	check_symbol_visibility(sym);
+	check_test_struct(sym);
 }
 
 /* Compile the AST into a graph of basicblocks */
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
