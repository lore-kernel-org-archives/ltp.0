Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0C4CE7A96
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:13:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E04F13CF2C9
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:13:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 334163CE246
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:13:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C533601EC9
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:13:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 717C421853;
 Mon, 25 Sep 2023 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695654804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRb5rjK8UgxYFohUAcyv5qqTRd7KafEWfdjlzwRlrtc=;
 b=YpecerjpKcTjEzqM8Rh6yXa9Tk4vOoSYMyRg0jcqkUrD/apYl4gmH00B14+onsTwa4s7go
 olprTh9XLWMsAdrl9Oc6CfEJmsnoDONhCOmO4ZhpgZ+PAjswOV35y8jRdARwpYIE1nvgzw
 GMa0Bq5J9KtSZsU5yI3gHzZ3Lj16UKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695654804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRb5rjK8UgxYFohUAcyv5qqTRd7KafEWfdjlzwRlrtc=;
 b=M9GGA9t5ITSjZtHQJhDrIL/7JDkWA06RWD6nXZCvEWCgfhmyw6ALYGZgzWbN/C/y/023Kd
 XPs/OxgH4MFv3ZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2074113580;
 Mon, 25 Sep 2023 15:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uNtsBJSjEWXHTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 15:13:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 17:13:17 +0200
Message-Id: <20230925151319.87688-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925151319.87688-1-pvorel@suse.cz>
References: <20230925151319.87688-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib/tst_test.c: docparse/testinfo.pl: Add support
 for musl git fixes
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

Similar to other git repos (linux-git, linux-stable-git, glibc-git) we
need also to have support for musl fixes in tags (musl-git).

Link: https://github.com/linux-test-project/ltp/issues/1081
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 3 ++-
 lib/tst_test.c       | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 67e435d79..78433c40a 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -13,12 +13,13 @@ use File::Basename qw(dirname);
 use constant OUTDIR => dirname(abs_path($0));
 
 # tags which expect git tree, also need constant for URL
-our @TAGS_GIT = ("linux-git", "linux-stable-git", "glibc-git");
+our @TAGS_GIT = ("linux-git", "linux-stable-git", "glibc-git", "musl-git");
 
 # tags should map these in lib/tst_test.c
 use constant LINUX_GIT_URL => "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=";
 use constant LINUX_STABLE_GIT_URL => "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=";
 use constant GLIBC_GIT_URL => "https://sourceware.org/git/?p=glibc.git;a=commit;h=";
+use constant MUSL_GIT_URL => "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=";
 use constant CVE_DB_URL => "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-";
 
 sub load_json
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e2c195645..179f697b7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -45,6 +45,7 @@ const char *TCID __attribute__((weak));
 #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
 #define LINUX_STABLE_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
 #define GLIBC_GIT_URL "https://sourceware.org/git/?p=glibc.git;a=commit;h="
+#define MUSL_GIT_URL "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id="
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
 
 #define DEFAULT_TIMEOUT 30
@@ -592,6 +593,8 @@ static void print_test_tags(void)
 			fprintf(stderr, LINUX_STABLE_GIT_URL "%s\n", tags[i].value);
 		else if (!strcmp(tags[i].name, "glibc-git"))
 			fprintf(stderr, GLIBC_GIT_URL "%s\n", tags[i].value);
+		else if (!strcmp(tags[i].name, "musl-git"))
+			fprintf(stderr, MUSL_GIT_URL "%s\n", tags[i].value);
 		else
 			fprintf(stderr, "%s: %s\n", tags[i].name, tags[i].value);
 	}
@@ -855,6 +858,7 @@ static void print_failure_hints(void)
 	print_failure_hint("linux-stable-git", "missing stable kernel fixes",
 					   LINUX_STABLE_GIT_URL);
 	print_failure_hint("glibc-git", "missing glibc fixes", GLIBC_GIT_URL);
+	print_failure_hint("musl-git", "missing musl fixes", MUSL_GIT_URL);
 	print_failure_hint("CVE", "vulnerable to CVE(s)", CVE_DB_URL);
 	print_failure_hint("known-fail", "hit by known kernel failures", NULL);
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
