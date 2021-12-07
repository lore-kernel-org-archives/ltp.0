Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41B0C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 12:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D773C55DF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:54:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9BF63C0BCC
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:54:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 49EAC1400E72
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:54:35 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 813CC21954;
 Tue,  7 Dec 2021 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638881675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pY3ZsLqAUuDkCXdI0bX+ix9JM8J4bUcjsKECbG7+4T8=;
 b=e/dIiEiKh+iFgcJcaepA1nWHGfkHQZ0fc6cXsH0NZDaGOclAayugQ7XsJhurzljsm/lHPI
 ySqzoZSGojaW8wrAVP7khUNUgDPJfLPIH7RrHDRNWm17kELLu3s5nT5CM+1eXGJI96PWrh
 zk78bD9XwVIEPljn96tMSYcS3pruMro=
Received: from g78.suse.de (unknown [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id 3F5B8A3B84;
 Tue,  7 Dec 2021 12:54:35 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  7 Dec 2021 12:54:20 +0000
Message-Id: <20211207125420.32538-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130114527.5942-1-chrubis@suse.cz>
References: <20211130114527.5942-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] check: Deprecated API symbols
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

The old API represents a big source of complication. It invalidates a
lot of assumptions we can make when writing checks specifically for
the new API.

Cyril proposed ignoring these symbols altogether in a previous
patch. This is a counter proposal to print a warning, but then abandon
checking the symbol any further.

The reasoning is that ignoring them altogether might hide errors. Also
the existence of the old API may be a surprise to new developers. This
change will alert them that a test needs updating and that it is not
to be used as a reference.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 tools/sparse/sparse-ltp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index 3a38229f1..513033518 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -81,6 +81,32 @@ static void do_entrypoint_checks(struct entrypoint *ep)
 		do_basicblock_checks(bb);
 	} END_FOR_EACH_PTR(bb);
 }
+/* The old API can not comply with the rules. So when we see one of
+ * these symbols we know that it will result in further
+ * warnings. Probably these will suggest inappropriate things. Usually
+ * these symbols should be removed and the new API used
+ * instead. Otherwise they can be ignored until all tests have been
+ * converted to the new API.
+ */
+static bool check_symbol_deprecated(const struct symbol *const sym)
+{
+	static struct ident *TCID_id, *TST_TOTAL_id;
+	const struct ident *id = sym->ident;
+
+	if (!TCID_id) {
+		TCID_id = built_in_ident("TCID");
+		TST_TOTAL_id = built_in_ident("TST_TOTAL");
+	}
+
+	if (id != TCID_id && id != TST_TOTAL_id)
+		return false;
+
+	warning(sym->pos,
+		"Ignoring deprecated API symbol: '%s'. Should this code be converted to the new API?",
+		show_ident(id));
+
+	return true;
+}
 
 /* Check for LTP-003 and LTP-004
  *
@@ -212,6 +238,9 @@ static void check_test_struct(const struct symbol *const sym)
 /* AST level checks */
 static void do_symbol_checks(struct symbol *sym)
 {
+	if (check_symbol_deprecated(sym))
+		return;
+
 	check_symbol_visibility(sym);
 	check_test_struct(sym);
 }
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
