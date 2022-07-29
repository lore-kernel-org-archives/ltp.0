Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA44C00144
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 15:33:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18D883C8C90
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 17:33:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D2B53C816F
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 17:32:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8E051A009BE
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 17:32:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85761210B2;
 Fri, 29 Jul 2022 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659108770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f/GorR3OsP29gPpoWqTrpg4QS0a83WAmsltKyWhY7Y8=;
 b=xBiJh16XcYyaZSY+OWGg3ulQw/2cSs+cN7FBs4gs3O9qK2m7BSs/n8xs1KKvJvbAvYCgLY
 6s8ZQQL6pdF7SyFMcErTBrIseSh9a+mQP+TCRIcadGRT8cPyfMBwlZ1+HoFQhITWRQ1QDe
 u1Oj0OpS2O/lK2nFOtw0sKV4N9HX++Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659108770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f/GorR3OsP29gPpoWqTrpg4QS0a83WAmsltKyWhY7Y8=;
 b=o8AuHOdIyWqWdsokghTqqKuDF8/kIUC8Q0zKnDaZwwPtvUptlVrqa1PhpqNjIfZfBXOyVe
 gqL6L19m8NR6u5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A86A13A8E;
 Fri, 29 Jul 2022 15:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2xmUEKL942IKfQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 15:32:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 29 Jul 2022 17:32:46 +0200
Message-Id: <20220729153246.1213-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] metaparse: Replace macro also in arrays
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
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This helps to replace macros like:

    #define TEST_APP "userns06_capcheck"

    static const char *const resource_files[] = {
	TEST_APP,
	NULL,
    };

$ ./metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ ../testcases/kernel/containers/userns/userns06.c
Before:
   "resource_files": [
     "TEST_APP"
    ],
    ...

After:
   "resource_files": [
     "userns06_capcheck"
    ],
    ...

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

This is a reaction on patch
https://patchwork.ozlabs.org/project/ltp/patch/20220722083529.209-1-chenhx.fnst@fujitsu.com/
First: I was wrong, inlining arrays does any change in the docparse output.
BTW I'd be still for inlining for better readability.

I'm not sure if this is not good idea, maybe some of the constants should be
kept unparsed, e.g.:

Orig:
   "caps": [
     "TST_CAP",
     "(",
     "TST_CAP_DROP",
     "CAP_SYS_RESOURCE",

Becomes:
   "caps": [
     "TST_CAP",
     "(",
     "TST_CAP_DROP",
     "24",

CAP_SYS_RESOURCE is replaced because it's a string, but IMHO it'd be better to keep it.
TST_CAP{_DROP,} aren't replaced because they aren't a plain strings.
Maybe replace only non-numerc values?

Kind regards,
Petr

 metadata/metaparse.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 2384c73c8..0cc288b2d 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019-2021 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 2020-2022 Petr Vorel <pvorel@suse.cz>
  */
 
 #define _GNU_SOURCE
@@ -286,9 +286,28 @@ static void close_include(FILE *inc)
 	fclose(inc);
 }
 
+static void try_apply_macro(char **res)
+{
+	ENTRY macro = {
+		.key = *res,
+	};
+
+	ENTRY *ret;
+
+	ret = hsearch(macro, FIND);
+
+	if (!ret)
+		return;
+
+	if (verbose)
+		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
+
+	*res = ret->data;
+}
+
 static int parse_array(FILE *f, struct data_node *node)
 {
-	const char *token;
+	char *token;
 
 	for (;;) {
 		if (!(token = next_token(f, NULL)))
@@ -315,6 +334,7 @@ static int parse_array(FILE *f, struct data_node *node)
 		if (!strcmp(token, "NULL"))
 			continue;
 
+		try_apply_macro(&token);
 		struct data_node *str = data_node_string(token);
 
 		data_node_array_add(node, str);
@@ -323,25 +343,6 @@ static int parse_array(FILE *f, struct data_node *node)
 	return 0;
 }
 
-static void try_apply_macro(char **res)
-{
-	ENTRY macro = {
-		.key = *res,
-	};
-
-	ENTRY *ret;
-
-	ret = hsearch(macro, FIND);
-
-	if (!ret)
-		return;
-
-	if (verbose)
-		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
-
-	*res = ret->data;
-}
-
 static int parse_get_array_len(FILE *f)
 {
 	const char *token;
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
