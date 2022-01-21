Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A88C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:06:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 615A93C970D
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:06:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE2C43C9424
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:06:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 05D161A01155
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:06:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24A8021910;
 Fri, 21 Jan 2022 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642759569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=anKLH66f9v8afg/wbAdpP8qQspfMEUnoRLsdoI8Jw/s=;
 b=W5qLe2+JuR3IZ2ZBx0m4Dta7463eaLnhZ07XgK2qfyz4uGaB91Ow5B04q2hnXxjCl7edh4
 kmks68wM3F8+zBxxYyKDpVPnd9cNkt8MbOzw18R0iC4zlsZQW07K7CQHmgnYKRGKwnaDcu
 oHzs7+xjtslfCJJ9yJtydIu9Z+pULts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642759569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=anKLH66f9v8afg/wbAdpP8qQspfMEUnoRLsdoI8Jw/s=;
 b=AlFoMn78uiBwUEbNJNI/I3ROL2W0Awa2RSX5dYRA2B1bYH9U8uztzsdwDWMh2uXo0GARIq
 AMBxnuJdVPL/RKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA81A13B9C;
 Fri, 21 Jan 2022 10:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hWYzL5CF6mEMZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 10:06:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jan 2022 11:06:04 +0100
Message-Id: <20220121100604.1072-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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

tmpfs does not support it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/aiodio_append.c | 10 ++++++++--
 testcases/kernel/io/ltp-aiodio/dio_append.c    |  4 ++++
 testcases/kernel/io/ltp-aiodio/dio_read.c      |  4 ++++
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    | 10 ++++++++--
 testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 10 ++++++++--
 5 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index cb04b04a57..46cc74ee4e 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -131,8 +131,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));
+	}
 }
 
 static void run(void)
@@ -177,6 +179,10 @@ static struct tst_test test = {
 		{"b:", &str_numaio, "Number of async IO blocks (default 16)"},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 };
 #else
 TST_TEST_TCONF("test requires libaio and its development packages");
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 59fd710e70..c099793f6c 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -93,4 +93,8 @@ static struct tst_test test = {
 		{"c:", &str_appends, "Number of appends (default 1000)"},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index 2c2ec4bce0..67a28147fd 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -177,4 +177,8 @@ static struct tst_test test = {
 		{"s:", &str_filesize, "File size (default 128M)"},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 4ee2fbab18..39fc895d65 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -83,8 +83,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));
+	}
 }
 
 static void run(void)
@@ -129,4 +131,8 @@ static struct tst_test test = {
 		{"o:", &str_offset, "File offset (default 0)"},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 4bf11c9588..1fbf83de06 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -107,8 +107,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));
+	}
 }
 
 static void run(void)
@@ -163,4 +165,8 @@ static struct tst_test test = {
 		{"c:", &str_numwrites, "Number of append & truncate (default 100)"},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
