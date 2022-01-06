Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118EFC433EF
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:25:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04A013C8B34
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:25:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F57E3C03F6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:36 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 620A1600C76
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641461135; i=@fujitsu.com;
 bh=gTQygTbvnoV333JKpmmbva06jgKjdyA6DAD9fHb5v9U=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=bE0uxuIXsDuIRRqNv2UMI1OcixAeMBpcujKp1VIetFIMRzFTqZcnyMbIB8q/tWQ43
 DpBQy+KDtMP6evVGeI5YzJ/lsI9dmI1m6kGeTmi9yFXx8fPj9iQ/MQmcbRgUgmYEQd
 zLgnC+Jc5K6u5ijBALdZh7c+Sp/IZcmEu6g6nemvgX+AJd3EEGqU8vPyAv9N6C6a4n
 A/DqoZoVTS0omdrR2qNk1kdgxTS+R+BjlCX7WBpAu/UwkqLZijZZ5xF5R96mxjYqVi
 ZQppExugahNw2nMV5ut5noE1Oux6VtzxPZ0pudwZarq761oSYhJejSgvDBy0LO2LER
 4PoXmzG/UVuaA==
Received: from [100.115.32.243] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id FC/72-27579-F85B6D16;
 Thu, 06 Jan 2022 09:25:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8ORqNu/9Vq
 iwcEmLosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPuvgUsBQelK7bMkGxgnC7WxcjFISRwllFi
 5/sprBDOTiaJPW/ms0E4uxkl/r+/CpTh5GAT0JR41rmAGcQWEZCQ6Gh4yw5iMwuoSyyf9IsJx
 BYWCJC4/fsfG4jNIqAicbdzF5jNK+AhseH+XRYQW0JAQWLKw/dAczg4OAU8JZaf0gExhQSSJP
 7cUoeoFpQ4OfMJC8R0CYmDL14wQ3QqSlzq+MYIYVdIzJrVxgRhq0lcPbeJeQKj4Cwk7bOQtC9
 gZFrFaJVUlJmeUZKbmJmja2hgoGtoaKprbKlraqSXWKWbqJdaqlueWlyiC+SWF+ulFhfrFVfm
 Juek6OWllmxiBAZwSrG6yQ7G7pU/9Q4xSnIwKYnydmldSxTiS8pPqcxILM6ILyrNSS0+xCjDw
 aEkwWu/CSgnWJSanlqRlpkDjCaYtAQHj5II76+NQGne4oLE3OLMdIjUKUZFKXHeCVuAEgIgiY
 zSPLg2WARfYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMGwcyhSczrwRu+iugxUxAi8/JXQZ
 ZXJKIkJJqYAoI2PrratZu+09J39OrcxMS54hdlme8YBD8eaL+oawLdS7FVzQn7ZQo3bg32eO3
 jVXYLqYIttoVsufC9Ll2Xf9v7CaqaWJ3J2xhorxVyTyVK/uOzi5u9j4nGhSR/37N+SVf+Dqd9
 2f7aQpP2+vzuV1gdY9oetTBS/xTk9X+HIrPKXFZ8X9SzOXoIte5FtWHmUQ6nuZN5EprsNH7pO
 cZw7v65mL/d4/5ujRYfmz6w7+qQNCtpOX26pjmNZGX9CoLT0qUv7g459p+3v82Qe6lN2Qtk6Y
 oT8ztu3X6ZIYQxzWmKSv8/zu4VZTGNci/4UxY5sbKtfdPZ/gzdfvf6mpt7y9t2bJG/21+VvXP
 lbdUlFiKMxINtZiLihMBd+Buu1sDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-548.messagelabs.com!1641461134!3416!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23712 invoked from network); 6 Jan 2022 09:25:35 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-10.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Jan 2022 09:25:35 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C109F1001A4
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B439A100192
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:34 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 09:25:13 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Jan 2022 17:25:19 +0800
Message-ID: <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE environment
 variables
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

This environment variables is designed to add kernel config check functionality
switch. So we can disable kconfig check completely and it is useful especially
for the  embedded platforms that they don't have kernel config.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/user-guide.txt |  3 +++
 lib/tst_kconfig.c  | 31 +++++++++++++++++++++++++++++++
 lib/tst_test.c     |  1 +
 3 files changed, 35 insertions(+)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 494652618..8d4435a28 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -18,6 +18,9 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTP_SINGLE_FS_TYPE'  | Testing only - specifies filesystem instead all
                           supported (for tests with '.all_filesystems').
 | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
+| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
+                          'y' or '1': disable kconfig check,
+                          'n' or '0': enable kconfig check.
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
                           Variable is also used in shell tests, but ceiled to int.
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index dc7decff9..c37afd8c8 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -478,6 +478,27 @@ static void dump_vars(const struct tst_expr *expr)
 	}
 }
 
+static int tst_kconfig_disabled(void)
+{
+	static int check;
+
+	if (check)
+		return check - 1;
+
+	char *env = getenv("LTP_KCONFIG_DISABLE");
+
+	if (env) {
+		if (!strcmp(env, "n") || !strcmp(env, "0"))
+			check = 1;
+		if (!strcmp(env, "y") || !strcmp(env, "1"))
+			check = 2;
+		return check - 1;
+	}
+
+	check = 1;
+	return 0;
+}
+
 int tst_kconfig_check(const char *const kconfigs[])
 {
 	size_t expr_cnt = array_len(kconfigs);
@@ -485,6 +506,11 @@ int tst_kconfig_check(const char *const kconfigs[])
 	unsigned int i, var_cnt;
 	int ret = 0;
 
+	if (tst_kconfig_disabled()) {
+		tst_res(TINFO, "Kernel config check functionality has been disabled.");
+		return 0;
+	}
+
 	for (i = 0; i < expr_cnt; i++) {
 		exprs[i] = tst_bool_expr_parse(kconfigs[i]);
 
@@ -530,6 +556,11 @@ char tst_kconfig_get(const char *confname)
 {
 	struct tst_kconfig_var var;
 
+	if (tst_kconfig_disabled()) {
+		tst_res(TINFO, "Kernel config check functionality has been disabled.");
+		return 0;
+	}
+
 	var.id_len = strlen(confname);
 
 	if (var.id_len >= sizeof(var.id))
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d5cefadaa..3e6f2ee1f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -483,6 +483,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
+	fprintf(stderr, "LTP_KCONFIG_DISABLE  Switch for kernel config check functionality (y/1: disable, n/0: enable)\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
