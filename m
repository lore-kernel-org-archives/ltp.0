Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428CAECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 16:08:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58593CAC98
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 18:08:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3306C3CAC95
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 18:07:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B0DC60070B
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 18:07:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA88B21C5A
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663344447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SL2qPaz+gXJRdQYzh+bl5vyYvu6GpHHtFST3XfJD2lU=;
 b=FyuN4MWPBfwpj1/OI97tT7eBxUL42Os2THeSOhdvAmUsbFVUMApGauRX9ejQjminnpMzV/
 BrQIPwwf9lqH/L+0GZsaA+q21LMpd7scXg6u3D0pxwtqNpHbTzq0DFH/ARy2Vc4ehFL27o
 LHVepB0kU15uwvfQoS1GSci8iPxn2to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663344447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SL2qPaz+gXJRdQYzh+bl5vyYvu6GpHHtFST3XfJD2lU=;
 b=Ua9zmnfXHen1GdVsIo+6Oi60f4Lcwpqh6JwAnOemtR/34Img8cdpa0ipB3kCfVSsElnmqW
 zZWpJSt9oXrzJCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4C6913ADC
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mBM9Kz+fJGNGfQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:07:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 16 Sep 2022 18:07:25 +0200
Message-Id: <20220916160726.12797-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916160726.12797-1-mdoucha@suse.cz>
References: <20220916160726.12797-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] request_key03: Split test into 3 testcases
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../syscalls/request_key/request_key03.c      | 70 ++++++++++---------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index 2780532f3..cb256f41e 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -37,6 +37,30 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
+static struct test_case {
+	const char *type;
+	const char *payload;
+	int effort;
+} testcase_list[] = {
+	/*
+	 * Briefly test the "encrypted" and/or "trusted" key types when
+	 * availaible, mainly to reproduce CVE-2017-15299.
+	 */
+	{"encrypted", "update user:foo 32", 2},
+	{"trusted", "update", 2},
+
+	/*
+	 * Test the "user" key type for longer, mainly in order to reproduce
+	 * CVE-2017-15951.  However, without the fix for CVE-2017-15299 as well,
+	 * WARNs may show up in the kernel log.
+	 *
+	 * Note: the precise iteration count is arbitrary; it's just intended to
+	 * be enough to give a decent chance of reproducing the bug, without
+	 * wasting too much time.
+	 */
+	{"user", "payload", 20},
+};
+
 static char *opt_bug;
 
 static void run_child_add(const char *type, const char *payload, int effort)
@@ -95,29 +119,29 @@ static void run_child_request(const char *type, int effort)
 	}
 }
 
-static void test_with_key_type(const char *type, const char *payload,
-			       int effort)
+static void do_test(unsigned int n)
 {
 	int status;
 	pid_t add_key_pid;
 	pid_t request_key_pid;
 	bool info_only;
+	struct test_case *tc = testcase_list + n;
 
 	TEST(keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL));
 	if (TST_RET < 0)
 		tst_brk(TBROK | TTERRNO, "failed to join new session keyring");
 
-	TEST(add_key(type, "desc", payload, strlen(payload),
+	TEST(add_key(tc->type, "desc", tc->payload, strlen(tc->payload),
 		     KEY_SPEC_SESSION_KEYRING));
 	if (TST_RET < 0 && TST_ERR != EINVAL) {
 		if (TST_ERR == ENODEV) {
 			tst_res(TCONF, "kernel doesn't support key type '%s'",
-				type);
+				tc->type);
 			return;
 		}
 		tst_brk(TBROK | TTERRNO,
 			"unexpected error checking whether key type '%s' is supported",
-			type);
+			tc->type);
 	}
 
 	/*
@@ -126,13 +150,13 @@ static void test_with_key_type(const char *type, const char *payload,
 	 */
 	add_key_pid = SAFE_FORK();
 	if (add_key_pid == 0) {
-		run_child_add(type, payload, effort);
+		run_child_add(tc->type, tc->payload, tc->effort);
 		exit(0);
 	}
 
 	request_key_pid = SAFE_FORK();
 	if (request_key_pid == 0) {
-		run_child_request(type, effort);
+		run_child_request(tc->type, tc->effort);
 		exit(0);
 	}
 
@@ -149,11 +173,11 @@ static void test_with_key_type(const char *type, const char *payload,
 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
 		tst_res(info_only ? TINFO : TPASS,
 			"didn't crash while updating key of type '%s'",
-			type);
+			tc->type);
 	} else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(info_only ? TINFO : TFAIL,
 			"kernel oops while updating key of type '%s'",
-			type);
+			tc->type);
 	} else {
 		tst_brk(TBROK, "add_key child %s", tst_strstatus(status));
 	}
@@ -163,39 +187,19 @@ static void test_with_key_type(const char *type, const char *payload,
 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
 		tst_res(info_only ? TINFO : TPASS,
 			"didn't crash while requesting key of type '%s'",
-			type);
+			tc->type);
 	} else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(info_only ? TINFO : TFAIL,
 			"kernel oops while requesting key of type '%s'",
-			type);
+			tc->type);
 	} else {
 		tst_brk(TBROK, "request_key child %s", tst_strstatus(status));
 	}
 }
 
-static void do_test(void)
-{
-	/*
-	 * Briefly test the "encrypted" and/or "trusted" key types when
-	 * availaible, mainly to reproduce CVE-2017-15299.
-	 */
-	test_with_key_type("encrypted", "update user:foo 32", 2);
-	test_with_key_type("trusted", "update", 2);
-
-	/*
-	 * Test the "user" key type for longer, mainly in order to reproduce
-	 * CVE-2017-15951.  However, without the fix for CVE-2017-15299 as well,
-	 * WARNs may show up in the kernel log.
-	 *
-	 * Note: the precise iteration count is arbitrary; it's just intended to
-	 * be enough to give a decent chance of reproducing the bug, without
-	 * wasting too much time.
-	 */
-	test_with_key_type("user", "payload", 20);
-}
-
 static struct tst_test test = {
-	.test_all = do_test,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(testcase_list),
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
 		{"b:", &opt_bug,  "Bug to test for (cve-2017-15299 or cve-2017-15951; default is both)"},
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
