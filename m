Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF885C433EF
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 13:07:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24BDF3CA840
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 14:07:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D85523CA802
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:06:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD77B1A00A22
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:06:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E9C11218FE;
 Mon, 14 Mar 2022 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1647263217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PKQGsNK95GMNRuisO2wmAR8VwRm2unYxAMczGRZ0IS0=;
 b=YTblxEF/NtvcweomUvm8fldTlPPSgjTxeNHm9135NfOsPLXPkZ/69RMmYkJ2XrFoPRs8SC
 y779QmgO8T7M6eLO5p5EAyXHVwO1wGC1a6jw7K2Wg+xdUa5uoopzr0D5bihewURWKAVRW2
 0kpJd5Pk5Ef4pD9YWMk9k20d/J6of/w=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id A5363A3B88;
 Mon, 14 Mar 2022 13:06:57 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 14 Mar 2022 13:06:29 +0000
Message-Id: <20220314130630.9378-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tools/sparse-ltp: Check all struct arrays in
 tst_test for ending {}
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

Check for null termination on tst_test.save_restore and all the other
struct arrays in tst_test. They are all null terminated.

Also prevents a segfault when scalar NULL is used as the final entry
and print a helpful error message instead.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tools/sparse/sparse-ltp.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index 608025800..d649ee7b7 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -178,27 +178,31 @@ static bool is_terminated_with_null_struct(const struct symbol *const sym)
 	if (item_init->type == EXPR_POS)
 		item_init = item_init->init_expr;
 
+	if (item_init->type != EXPR_INITIALIZER)
+		return false;
+
 	return ptr_list_empty((struct ptr_list *)item_init->expr_list);
 }
 
-/* Check for (one instance of) LTP-005
+/* LTP-005: Check array sentinel value
  *
- * The tags array is only accessed when the test fails. So we perform
- * a static check to ensure it ends with {}
+ * This is most important for the tags array. It is only accessed when
+ * the test fails. So we perform a static check to ensure it ends with
+ * {}.
  */
-static void check_tag_initializer(const struct symbol *const sym)
+static void check_struct_array_initializer(const struct symbol *const sym)
 {
 	if (is_terminated_with_null_struct(sym))
 		return;
 
 	warning(sym->pos,
-		"LTP-005: test.tags array doesn't appear to be null-terminated; did you forget to add '{}' as the final entry?");
+		"LTP-005: Struct array doesn't appear to be null-terminated; did you forget to add '{}' as the final entry?");
 }
 
 /* Find struct tst_test test = { ... } and perform tests on its initializer */
 static void check_test_struct(const struct symbol *const sym)
 {
-	static struct ident *tst_test, *tst_test_test, *tst_tag;
+	static struct ident *tst_test, *tst_test_test;
 	struct ident *ctype_name = NULL;
 	struct expression *init = sym->initializer;
 	struct expression *entry;
@@ -214,7 +218,6 @@ static void check_test_struct(const struct symbol *const sym)
 	if (!tst_test_test) {
 		tst_test = built_in_ident("tst_test");
 		tst_test_test = built_in_ident("test");
-		tst_tag = built_in_ident("tst_tag");
 	}
 
 	if (sym->ident != tst_test_test)
@@ -227,11 +230,19 @@ static void check_test_struct(const struct symbol *const sym)
 		if (entry->init_expr->type != EXPR_SYMBOL)
 			continue;
 
+		switch (entry->ctype->ctype.base_type->type) {
+		case SYM_PTR:
+		case SYM_ARRAY:
+			break;
+		default:
+			return;
+		}
+
 		const struct symbol *entry_init = entry->init_expr->symbol;
 		const struct symbol *entry_ctype = unwrap_base_type(entry_init);
 
-		if (entry_ctype->ident == tst_tag)
-			check_tag_initializer(entry_init);
+		if (entry_ctype->type == SYM_STRUCT)
+			check_struct_array_initializer(entry_init);
 	} END_FOR_EACH_PTR(entry);
 
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
