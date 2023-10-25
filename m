Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB4C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 08:37:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 021843CCBF2
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 10:37:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE7103CD377
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:37:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8E2C14052D2
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:37:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08D331FF31;
 Wed, 25 Oct 2023 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698223038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGSbvtbdXSe/ikEZHVkT1PiJbLGZ9aAg6zOQJwWBl1g=;
 b=td+tKgHezbuYf7vVlkIo++4hXki9hX/N3KsXWJTCs9TQAJEd0Qvfv41jFg4xUXjxmvpweN
 z5kibUWNXgKFQoWXTIPQNKRR7sJw+G5pN2IIXs7RsSuI51TAY59xotouINXlbAw26po0MH
 cDy0rPwHw3A9LT9Ow69ynCaA8s43/1w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 674DE13524;
 Wed, 25 Oct 2023 08:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EDKtEL3TOGVhAQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 25 Oct 2023 08:37:17 +0000
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 04:37:05 -0400
Message-Id: <20231025083706.13767-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231025083706.13767-1-wegao@suse.com>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231025083706.13767-1-wegao@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.84 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.74)[83.90%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: Add .ulimit
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixs: #530
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_test.h | 14 ++++++++++++++
 lib/tst_test.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 75c2109b9..dcdbc71d7 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -15,6 +15,7 @@
 #include <limits.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/resource.h>
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
@@ -148,6 +149,11 @@ extern unsigned int tst_variant;
 
 #define TST_UNLIMITED_RUNTIME (-1)
 
+struct tst_ulimit_val {
+	int resource;
+	rlim_t rlim_cur;
+};
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -306,6 +312,11 @@ struct tst_test {
 	 */
 	const struct tst_path_val *save_restore;
 
+	/*
+	 * {NULL, NULL} terminated array of (ulimit resource type and value)
+	 */
+	const struct tst_ulimit_val *ulimit;
+
 	/*
 	 * NULL terminated array of kernel config options required for the
 	 * test.
@@ -392,6 +403,9 @@ int tst_validate_children_(const char *file, const int lineno,
 #define tst_validate_children(child_count) \
 	tst_validate_children_(__FILE__, __LINE__, (child_count))
 
+#define tst_set_ulimit(conf) \
+	tst_set_ulimit_(__FILE__, __LINE__, (conf))
+
 #ifndef TST_NO_DEFAULT_MAIN
 
 static struct tst_test test;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2e58cad33..59eeda7e7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1129,6 +1129,25 @@ static void do_cgroup_requires(void)
 	tst_cg_init();
 }
 
+void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
+{
+	struct rlimit rlim;
+
+	SAFE_GETRLIMIT(conf->resource, &rlim);
+
+	if (conf->rlim_cur > rlim.rlim_max) {
+		rlim.rlim_max = conf->rlim_cur;
+		rlim.rlim_cur = conf->rlim_cur;
+	} else {
+		rlim.rlim_cur = conf->rlim_cur;
+	}
+
+	tst_res_(file, lineno, TINFO, "Set ulimit resource:%d rlim_cur:%lu rlim_max:%lu",
+		conf->resource, rlim.rlim_cur, rlim.rlim_max);
+
+	safe_setrlimit(file, lineno, conf->resource, &rlim);
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	if (!tst_test)
@@ -1227,6 +1246,15 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->ulimit) {
+		const struct tst_ulimit_val *pvl = tst_test->ulimit;
+
+		while (pvl->resource) {
+			tst_set_ulimit(pvl);
+			pvl++;
+		}
+	}
+
 	if (tst_test->mntpoint)
 		SAFE_MKDIR(tst_test->mntpoint, 0777);
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
