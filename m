Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28755C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:58:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3F7A3E4B54
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:58:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 021B03E56A0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48DAB600812
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA3CF3E08;
 Wed, 29 Jul 2026 09:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eqi++0U2VZPEQd0e1Lt1+c87DOekJCfjJMVBKbblY5I=;
 b=cEXfofuZr3Xd79gxVlevm0CkjYdjfglri6CBaFETquj+jgp9iv79BqELfCgYWv7ASJn4zK
 UorqvlCDQuu2/AxZnPslrCJFcR7LPvtz4pU7P2xl5Uql3BLIDdgzxisleeWwkHNwsbqevt
 dEtLWVrqG7KyRGpkjzWv+hnMCKikDGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eqi++0U2VZPEQd0e1Lt1+c87DOekJCfjJMVBKbblY5I=;
 b=jp7eYTkuwnSypOkxk9m3gMP2j/k5pDebPAqYkILP/HEY4EGlbmo1uviFWJeM1cI2OsVnUz
 9WZyg5dw9QgvErBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eqi++0U2VZPEQd0e1Lt1+c87DOekJCfjJMVBKbblY5I=;
 b=RkLiuqQ9EoXfG8g1eiiN1pPu0pWn7D4zZu2svqXNoU1KEnqwdre0IQH2XlknSXAqBBfjIX
 Q0wg+rlJBBXHvrxBSXbu2grkdA6a4UxUdXMU1FJhV+mpmJqOfiUMuimXKdqhFme0k5aDCd
 Wwx93L1M7CXss2++a1aAr0LjF8RxJDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eqi++0U2VZPEQd0e1Lt1+c87DOekJCfjJMVBKbblY5I=;
 b=BRlea8TTrFZ7t6iaODXPhFY0CWODNBaoDJD3r0XnzeqpVpa81QSR1//R9FLjRBMlUjoH7X
 BGI647BvGIMFsBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8106B779B3;
 Wed, 29 Jul 2026 09:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DvUHKHOaWrTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:57:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:57:27 +0200
Message-ID: <20260729095730.29185-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729095730.29185-1-pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] lib: Add support for max_kver to struct
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as v1.

 include/tst_test.h |  9 ++++++++-
 lib/tst_test.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index c69362485e..0910660827 100644
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
@@ -301,7 +305,9 @@ struct tst_fs {
  *        and each time passed an increasing counter value.
  * @options: An NULL optstr terminated array of struct tst_option.
  *
- * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
+ * @min_kver: A minimal kernel version the test can run on. e.g. "4.4".
+ *
+ * @max_kver: A maximal kernel version the test can run on. e.g. "7.2".
  *
  * @supported_archs: A NULL terminated array of architectures the test runs on
  *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
@@ -551,6 +557,7 @@ struct tst_fs {
 	struct tst_option *options;
 
 	const char *min_kver;
+	const char *max_kver;
 
 	const char *const *supported_archs;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 778a1fed40..fa38b3a7a3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1087,6 +1087,36 @@ static bool check_min_kver(const char *min_kver, const int brk_nosupp)
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
+	int v1, v2, v3;
+
+	if (tst_parse_kver(max_kver, &v1, &v2, &v3)) {
+		tst_res(TWARN,
+			"Invalid kernel version %s, expected %%d.%%d.%%d",
+			max_kver);
+	}
+
+	if (tst_kvercmp(v1, v2, v3) > 0) {
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
@@ -1463,6 +1493,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_min_kver(tst_test->min_kver, 1);
 
+	if (tst_test->max_kver)
+		check_max_kver(tst_test->max_kver, 1);
+
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
@@ -1586,6 +1619,9 @@ static void do_setup(int argc, char *argv[])
 			if (tst_test->filesystems && tst_test->filesystems->min_kver)
 				check_min_kver(tst_test->filesystems->min_kver, 1);
 
+			if (tst_test->filesystems && tst_test->filesystems->max_kver)
+				check_max_kver(tst_test->filesystems->max_kver, 1);
+
 			prepare_device(tst_test->filesystems);
 		}
 	}
@@ -1991,6 +2027,9 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
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
