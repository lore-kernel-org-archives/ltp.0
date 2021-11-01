Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD412C433EF
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:59:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD51F61242
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD51F61242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556103C7181
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:53:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A07B3C7046
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:52:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 643706005C4
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:52:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAE702196F
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635778368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20KiXxDpZoaY7uYZQJ75DN2M/ZCNmy2lMZqx1Oddwf0=;
 b=LRHkbhf0MMLCJvUIntM+kzWuhFVIDWgjmpHoggnZnoKOJetLGQF+xlPfcSd9XkLZp8fpPB
 +3mrmP8mKXkaJ54VPT9K+V45etgwyi9z7/2v1UYCNYp9XUvM/XAh3j9cx7MyLQCfkSokeh
 6XfIpQw/6HqWqcPU71Ic4K3pd8PKx6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635778368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20KiXxDpZoaY7uYZQJ75DN2M/ZCNmy2lMZqx1Oddwf0=;
 b=WLMNlldo4bxJbOMDva9D7Gvt8g/5MG7av0FVxSz4CTPPWkAN+qbRzAfRMVy/OkSuGgzt2B
 BC/T+OLx3inxYoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D734113522
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RtBkM0D/f2G2LQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Nov 2021 14:52:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Nov 2021 15:53:37 +0100
Message-Id: <20211101145342.7166-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101145342.7166-1-chrubis@suse.cz>
References: <20211101145342.7166-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] docparse: Add tests
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

This add a simple tests for the docparse parser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
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
 docparse/tests/multiline_macro.c      |  6 ++++++
 docparse/tests/multiline_macro.c.json |  4 ++++
 docparse/tests/tags.c                 |  7 +++++++
 docparse/tests/tags.c.json            | 13 +++++++++++++
 docparse/tests/test.sh                | 18 ++++++++++++++++++
 15 files changed, 85 insertions(+)
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
