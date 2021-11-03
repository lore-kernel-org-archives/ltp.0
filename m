Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2809CC433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:02:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78E860F5A
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A78E860F5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 365F13C7209
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:02:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4282C3C1414
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C66C110011C6
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E6822191C;
 Wed,  3 Nov 2021 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635940900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIDrCbTw4S3pXFNtZrOsJNwM/s6mIyGlQy6OVmLsT3o=;
 b=dGOrFefM/67w8QBTRVR48WPa3IHYI4lxWFzDQmqRiJr0jgL1rHoyjLZzKwS0TkTqR+QxLi
 LEzOr/uK6xY2/iI7vOLfXB3BDBe5tMGxlnoer2kK4ROMa9MZZLNyozxgLpXatv6r+Ttblk
 P8UNm2CC9gKb9al2h1V9T1pvVxlwIAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635940900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIDrCbTw4S3pXFNtZrOsJNwM/s6mIyGlQy6OVmLsT3o=;
 b=xs8tPEBxUFIx4g6uMf/G0wwAzjX2Y70NPmDfY27kzabqJjIh3WRm50ooyL4YzaItCHsFBA
 FafMcYOpRCx/LqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45A6513CE7;
 Wed,  3 Nov 2021 12:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4jrnDyR6gmFdRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 12:01:40 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Nov 2021 13:02:31 +0100
Message-Id: <20211103120233.20728-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103120233.20728-1-chrubis@suse.cz>
References: <20211103120233.20728-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/7] docparse: Add type normalization
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For now just for .test_variants.

There are two reasons for this:

- This code makes sure that we get right value parsed and aborts the
  compilation if the parser got confused. This part is important since
  if the testrunners are going to use the metadata the data in there
  must be correct.

- And much less important it makes the resulting json nicer to read

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 docparse/data_storage.h               | 16 ++++++++
 docparse/docparse.c                   | 59 +++++++++++++++++++++++++++
 docparse/tests/include.c.json         |  2 +-
 docparse/tests/macro.c.json           |  2 +-
 docparse/tests/multiline_macro.c.json |  2 +-
 5 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index 117c1d127..91ea70a02 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -57,6 +57,22 @@ struct data_node {
 	};
 };
 
+static inline const char* data_type_name(enum data_type type)
+{
+	switch (type) {
+	case DATA_ARRAY:
+		return "array";
+	case DATA_HASH:
+		return "hash";
+	case DATA_STRING:
+		return "string";
+	case DATA_INT:
+		return "int";
+	default:
+		return "???";
+	}
+}
+
 static inline struct data_node *data_node_string(const char *string)
 {
 	size_t size = sizeof(struct data_node_string) + strlen(string) + 1;
diff --git a/docparse/docparse.c b/docparse/docparse.c
index bef56d004..733558c47 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -12,6 +12,7 @@
 #include <libgen.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <errno.h>
 
 #include "data_storage.h"
 
@@ -721,6 +722,61 @@ static struct data_node *parse_file(const char *fname)
 	return res;
 }
 
+static struct typemap {
+	const char *id;
+	enum data_type type;
+} tst_test_typemap[] = {
+	{.id = "test_variants", .type = DATA_INT},
+	{}
+};
+
+static void convert_str2int(struct data_node *res, const char *id, const char *str_val)
+{
+	long val;
+	char *endptr;
+
+	errno = 0;
+	val = strtol(str_val, &endptr, 10);
+
+	if (errno || *endptr) {
+		fprintf(stderr,	"Cannot convert %s value %s to int!", id, str_val);
+		exit(1);
+	}
+
+	if (verbose)
+		fprintf(stderr, "NORMALIZING %s TO INT %li", id, val);
+
+	data_node_hash_del(res, id);
+	data_node_hash_add(res, id, data_node_int(val));
+}
+
+static void check_normalize_types(struct data_node *res)
+{
+	unsigned int i;
+
+	for (i = 0; tst_test_typemap[i].id; i++) {
+		struct data_node *n;
+		struct typemap *typemap = &tst_test_typemap[i];
+
+		n = data_node_hash_get(res, typemap->id);
+		if (!n)
+			continue;
+
+		if (n->type == typemap->type)
+			continue;
+
+		if (n->type == DATA_STRING && typemap->type == DATA_INT) {
+			convert_str2int(res, typemap->id, n->string.val);
+			continue;
+		}
+
+		fprintf(stderr, "Cannot convert %s from %s to %s!",
+			typemap->id, data_type_name(n->type),
+			data_type_name(typemap->type));
+		exit(1);
+	}
+}
+
 static const char *filter_out[] = {
 	"bufs",
 	"cleanup",
@@ -822,6 +878,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* Normalize types */
+	check_normalize_types(res);
+
 	for (i = 0; implies[i].flag; i++) {
 		if (data_node_hash_get(res, implies[i].flag)) {
 			for (j = 0; implies[i].implies[j]; j++) {
diff --git a/docparse/tests/include.c.json b/docparse/tests/include.c.json
index b4ef1ccda..b7c636e82 100644
--- a/docparse/tests/include.c.json
+++ b/docparse/tests/include.c.json
@@ -1,4 +1,4 @@
   "include": {
-   "test_variants": "10",
+   "test_variants": 10,
    "fname": "include.c"
   }
\ No newline at end of file
diff --git a/docparse/tests/macro.c.json b/docparse/tests/macro.c.json
index 0dc73d8ec..c3f53ae43 100644
--- a/docparse/tests/macro.c.json
+++ b/docparse/tests/macro.c.json
@@ -1,4 +1,4 @@
   "macro": {
-   "test_variants": "10",
+   "test_variants": 10,
    "fname": "macro.c"
   }
\ No newline at end of file
diff --git a/docparse/tests/multiline_macro.c.json b/docparse/tests/multiline_macro.c.json
index bafd037da..634516242 100644
--- a/docparse/tests/multiline_macro.c.json
+++ b/docparse/tests/multiline_macro.c.json
@@ -1,4 +1,4 @@
   "multiline_macro": {
-   "test_variants": "10",
+   "test_variants": 10,
    "fname": "multiline_macro.c"
   }
\ No newline at end of file
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
