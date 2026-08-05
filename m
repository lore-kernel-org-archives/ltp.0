Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E7DC55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:15:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 074813E90B9
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:15:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D1C13CF18A
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C2ABC1000A12
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B03F7F1F2;
 Wed,  5 Aug 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIVZ0Yvv5phbCrditT6MLXBOPMc4jkuHL+whUlVCqPE=;
 b=0MSpmaZJskq2l9Bf5i7ZD5Fq7jXbl7Va+Yd/RjV23bxFAeA024ds5TXlt5KXAsMrLCGi5F
 FEBUwaNIeRCvpYhUUb8JQBPpK1kqh67AY8AFhJmoL24yE70p3A1TJeuiHvHhrHfuNh2j1c
 xAPLKDQ8VT1S3cdZylbcqe/1/ZUPHww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIVZ0Yvv5phbCrditT6MLXBOPMc4jkuHL+whUlVCqPE=;
 b=rtlrZp4lYGyuQUOZxHFPca/8n3FEmpHpj9tn1g2Y40qio2zHOqHpyuvpy/PbPitNkQDQQA
 pbJTLjYMh/jBYVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0CE5779ED;
 Wed,  5 Aug 2026 15:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sC6ULXVTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:15:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:45 +0200
Message-ID: <20260805151451.648990-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1B03F7F1F2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/9] lib: Add support for max_kver to struct
 tst_test and tst_fs
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

max_kver adds a support to require a maximal kernel version the test can
run on. e.g. "7.2" (mainline release) or "6.1.180" (stable release).

NOTE: Mainline release is sufficient on any stable release (test with
.min_kver = "7.1" runs also on kernel 7.1.5). Stable releases are
compared as expected.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
* Mention flag in doc/developers/writing_tests.rst
* Fix doc (agent):
- * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
+ * on any stable release (test with ``max_kver = "7.1"`` runs also on kernel
* Fix checkpatch style (agent):
-       for (i=0, dots=0; max_kver[i]; i++)
+       for (i = 0, dots = 0; max_kver[i]; i++)

 doc/developers/writing_tests.rst |  3 +++
 include/tst_test.h               | 13 +++++++++-
 lib/tst_test.c                   | 43 ++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 4db57898fc..376ca1534d 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -402,6 +402,9 @@ LTP C And Shell Test API Comparison
     * - .min_kver
       - TST_MIN_KVER
 
+    * - .max_kver
+      - not implemented
+
     * - .min_mem_avail
       - not applicable
 
diff --git a/include/tst_test.h b/include/tst_test.h
index c69362485e..30c32b844e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -280,6 +280,9 @@ struct tst_ulimit_val {
  *
  * @min_kver: A minimum kernel version supporting the filesystem which has been
  *            created with mkfs.
+ *
+ * @max_kver: A maximum kernel version supporting the filesystem which has been
+ *            created with mkfs.
  */
 struct tst_fs {
 	const char *type;
@@ -292,6 +295,7 @@ struct tst_fs {
 	const void *mnt_data;
 
 	const char *min_kver;
+	const char *max_kver;
 };
 
 /**
@@ -301,7 +305,13 @@ struct tst_fs {
  *        and each time passed an increasing counter value.
  * @options: An NULL optstr terminated array of struct tst_option.
  *
- * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
+ * @min_kver: A minimal kernel version the test can run on. e.g. "4.4" (mainline
+ * release) or "6.1.180" (stable release).
+ *
+ * @max_kver: A maximal kernel version the test can run on. e.g. "7.2" (mainline
+ * release) or "6.1.180" (stable release). NOTE: Mainline release is sufficient
+ * on any stable release (test with ``max_kver = "7.1"`` runs also on kernel
+ * 7.1.5). Stable releases are compared as expected.
  *
  * @supported_archs: A NULL terminated array of architectures the test runs on
  *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
@@ -551,6 +561,7 @@ struct tst_fs {
 	struct tst_option *options;
 
 	const char *min_kver;
+	const char *max_kver;
 
 	const char *const *supported_archs;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c42dcf14e4..0d3714c709 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1083,6 +1083,40 @@ static bool check_min_kver(const char *min_kver, const int brk_nosupp)
 	return true;
 }
 
+/*
+ * Check for the maximal required kernel version.
+ *
+ * return: true if the kernel version is low enough, false otherwise.
+ */
+static bool check_max_kver(const char *max_kver, const int brk_nosupp)
+{
+	char *msg;
+	int dots, i, v1, v2, v3;
+
+	tst_parse_kver(max_kver, &v1, &v2, &v3);
+
+	for (i = 0, dots = 0; max_kver[i]; i++)
+		dots += (max_kver[i] == '.');
+
+	/*
+	 * For mainline kernel release without patch level (single dot e.g. "7.1")
+	 * ignore v3 (the sublevel): 7.1.x is always ok.
+	 * Do *not* ignore v3 on stable kernel release (2 dots, e.g. 7.1.5).
+	 */
+	if (tst_kvercmp(v1, v2, v3) > (dots == 1 ? 1023 : 0)) {
+		msg = "The test requires kernel %s or older";
+
+		if (brk_nosupp)
+			tst_brk(TCONF, msg, max_kver);
+		else
+			tst_res(TCONF, msg, max_kver);
+
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * Checks if the struct results values are equal.
  *
@@ -1459,6 +1493,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_min_kver(tst_test->min_kver, 1);
 
+	if (tst_test->max_kver)
+		check_max_kver(tst_test->max_kver, 1);
+
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
@@ -1582,6 +1619,9 @@ static void do_setup(int argc, char *argv[])
 			if (tst_test->filesystems && tst_test->filesystems->min_kver)
 				check_min_kver(tst_test->filesystems->min_kver, 1);
 
+			if (tst_test->filesystems && tst_test->filesystems->max_kver)
+				check_max_kver(tst_test->filesystems->max_kver, 1);
+
 			prepare_device(tst_test->filesystems);
 		}
 	}
@@ -1987,6 +2027,9 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	if (fs->min_kver && !check_min_kver(fs->min_kver, 0))
 		return;
 
+	if (fs->max_kver && !check_max_kver(fs->max_kver, 0))
+		return;
+
 	prepare_device(fs);
 
 	fork_testrun();
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
