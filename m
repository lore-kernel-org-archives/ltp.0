Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A7C433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:02:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9235661051
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9235661051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52DF83C71E0
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:02:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D20B93C1414
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 869B66002FB
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE4BC1F782;
 Wed,  3 Nov 2021 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635940898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4TWdMck/MCLRtq1jWbOehzVY3JsCJT/rgyAl7z/huo=;
 b=Rgw9sXVp9qgyBeaio/3ImDyBlyWjeWnwT6cWzbJweHX6KiFDZi5P9EtI3CH5JbiHrYsrO6
 mJMTVs4loj+Ul4NMI0vZisbosXN1Py5jVfxYBZ0HntywiXJ9rHgtML28UMU2XBAEUqbkYo
 +wJcDUnZrhSbNOlwx6TSOPgGOgzf/5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635940898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4TWdMck/MCLRtq1jWbOehzVY3JsCJT/rgyAl7z/huo=;
 b=9K3TLQyBOm9V9fIYMk9xaBVelq9ewt/JgtrbD3rLPlZY9hZm/fCFJedugbef8IK9QZjBld
 iklatGTSlWaMY0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA4C513CE7;
 Wed,  3 Nov 2021 12:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yQlULCJ6gmFTRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 12:01:38 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Nov 2021 13:02:28 +0100
Message-Id: <20211103120233.20728-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103120233.20728-1-chrubis@suse.cz>
References: <20211103120233.20728-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/7] docparse: Add tests
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

This add a simple tests for the docparse parser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 docparse/tests/Makefile               |  4 ++++
 docparse/tests/empty_struct.c         |  2 ++
 docparse/tests/empty_struct.c.json    |  3 +++
 docparse/tests/expand_flags.c         |  3 +++
 docparse/tests/expand_flags.c.json    |  6 ++++++
 docparse/tests/include.c              |  5 +++++
 docparse/tests/include.c.json         |  4 ++++
 docparse/tests/include.h              |  1 +
 docparse/tests/macro.c                |  5 +++++
 docparse/tests/macro.c.json           |  4 ++++
 docparse/tests/macro_str.c            |  5 +++++
 docparse/tests/macro_str.c.json       |  4 ++++
 docparse/tests/multiline_macro.c      |  6 ++++++
 docparse/tests/multiline_macro.c.json |  4 ++++
 docparse/tests/tags.c                 |  7 +++++++
 docparse/tests/tags.c.json            | 13 +++++++++++++
 docparse/tests/test.sh                | 18 ++++++++++++++++++
 17 files changed, 94 insertions(+)
 create mode 100644 docparse/tests/Makefile
 create mode 100644 docparse/tests/empty_struct.c
 create mode 100644 docparse/tests/empty_struct.c.json
 create mode 100644 docparse/tests/expand_flags.c
 create mode 100644 docparse/tests/expand_flags.c.json
 create mode 100644 docparse/tests/include.c
 create mode 100644 docparse/tests/include.c.json
 create mode 100644 docparse/tests/include.h
 create mode 100644 docparse/tests/macro.c
 create mode 100644 docparse/tests/macro.c.json
 create mode 100644 docparse/tests/macro_str.c
 create mode 100644 docparse/tests/macro_str.c.json
 create mode 100644 docparse/tests/multiline_macro.c
 create mode 100644 docparse/tests/multiline_macro.c.json
 create mode 100644 docparse/tests/tags.c
 create mode 100644 docparse/tests/tags.c.json
 create mode 100755 docparse/tests/test.sh

diff --git a/docparse/tests/Makefile b/docparse/tests/Makefile
new file mode 100644
index 000000000..b5c8c4668
--- /dev/null
+++ b/docparse/tests/Makefile
@@ -0,0 +1,4 @@
+all:
+
+test:
+	@./test.sh
diff --git a/docparse/tests/empty_struct.c b/docparse/tests/empty_struct.c
new file mode 100644
index 000000000..e5d986413
--- /dev/null
+++ b/docparse/tests/empty_struct.c
@@ -0,0 +1,2 @@
+static struct tst_test test = {
+};
diff --git a/docparse/tests/empty_struct.c.json b/docparse/tests/empty_struct.c.json
new file mode 100644
index 000000000..9f49f5332
--- /dev/null
+++ b/docparse/tests/empty_struct.c.json
@@ -0,0 +1,3 @@
+  "empty_struct": {
+   "fname": "empty_struct.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/expand_flags.c b/docparse/tests/expand_flags.c
new file mode 100644
index 000000000..64f6da64e
--- /dev/null
+++ b/docparse/tests/expand_flags.c
@@ -0,0 +1,3 @@
+static struct tst_test test = {
+	.all_filesystems = 1,
+};
diff --git a/docparse/tests/expand_flags.c.json b/docparse/tests/expand_flags.c.json
new file mode 100644
index 000000000..cd79dd296
--- /dev/null
+++ b/docparse/tests/expand_flags.c.json
@@ -0,0 +1,6 @@
+  "expand_flags": {
+   "all_filesystems": "1",
+   "needs_device": "1",
+   "needs_tmpdir": "1",
+   "fname": "expand_flags.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/include.c b/docparse/tests/include.c
new file mode 100644
index 000000000..15377e339
--- /dev/null
+++ b/docparse/tests/include.c
@@ -0,0 +1,5 @@
+# include "include.h"
+
+static struct tst_test test = {
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/docparse/tests/include.c.json b/docparse/tests/include.c.json
new file mode 100644
index 000000000..b4ef1ccda
--- /dev/null
+++ b/docparse/tests/include.c.json
@@ -0,0 +1,4 @@
+  "include": {
+   "test_variants": "10",
+   "fname": "include.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/include.h b/docparse/tests/include.h
new file mode 100644
index 000000000..efa11d24f
--- /dev/null
+++ b/docparse/tests/include.h
@@ -0,0 +1 @@
+#define TEST_VARIANTS 10
diff --git a/docparse/tests/macro.c b/docparse/tests/macro.c
new file mode 100644
index 000000000..296da12f5
--- /dev/null
+++ b/docparse/tests/macro.c
@@ -0,0 +1,5 @@
+#define TEST_VARIANTS 10
+
+static struct tst_test test = {
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/docparse/tests/macro.c.json b/docparse/tests/macro.c.json
new file mode 100644
index 000000000..0dc73d8ec
--- /dev/null
+++ b/docparse/tests/macro.c.json
@@ -0,0 +1,4 @@
+  "macro": {
+   "test_variants": "10",
+   "fname": "macro.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/macro_str.c b/docparse/tests/macro_str.c
new file mode 100644
index 000000000..9e5f22489
--- /dev/null
+++ b/docparse/tests/macro_str.c
@@ -0,0 +1,5 @@
+#define SYSCALL		"syscall(\"foo\")"
+
+static struct tst_test test = {
+	.syscall = SYSCALL,
+};
diff --git a/docparse/tests/macro_str.c.json b/docparse/tests/macro_str.c.json
new file mode 100644
index 000000000..b16228316
--- /dev/null
+++ b/docparse/tests/macro_str.c.json
@@ -0,0 +1,4 @@
+  "macro_str": {
+   "syscall": "syscall(\"foo\")",
+   "fname": "macro_str.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/multiline_macro.c b/docparse/tests/multiline_macro.c
new file mode 100644
index 000000000..2de58112b
--- /dev/null
+++ b/docparse/tests/multiline_macro.c
@@ -0,0 +1,6 @@
+#define TEST_VARIANTS \
+	10
+
+static struct tst_test test = {
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/docparse/tests/multiline_macro.c.json b/docparse/tests/multiline_macro.c.json
new file mode 100644
index 000000000..bafd037da
--- /dev/null
+++ b/docparse/tests/multiline_macro.c.json
@@ -0,0 +1,4 @@
+  "multiline_macro": {
+   "test_variants": "10",
+   "fname": "multiline_macro.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/tags.c b/docparse/tests/tags.c
new file mode 100644
index 000000000..ade3974ff
--- /dev/null
+++ b/docparse/tests/tags.c
@@ -0,0 +1,7 @@
+static struct tst_test test = {
+	.tags = (const struct tst_tag[]) {
+		{"tag-name-1", "tag-value-1"},
+		{"tag-name-2", "tag-value-2"},
+		{}
+	}
+};
diff --git a/docparse/tests/tags.c.json b/docparse/tests/tags.c.json
new file mode 100644
index 000000000..14cc14f1c
--- /dev/null
+++ b/docparse/tests/tags.c.json
@@ -0,0 +1,13 @@
+  "tags": {
+   "tags": [
+     [
+      "tag-name-1",
+      "tag-value-1"
+     ],
+     [
+      "tag-name-2",
+      "tag-value-2"
+     ]
+    ],
+   "fname": "tags.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/test.sh b/docparse/tests/test.sh
new file mode 100755
index 000000000..767cc464c
--- /dev/null
+++ b/docparse/tests/test.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+fail=0
+
+for i in *.c; do
+	../docparse $i > tmp.json
+	if ! diff tmp.json $i.json &> /dev/null; then
+		echo "***"
+		echo "$i output differs!"
+		diff -u tmp.json $i.json
+		echo "***"
+		fail=1
+	fi
+done
+
+rm -f tmp.json
+
+exit $fail
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
