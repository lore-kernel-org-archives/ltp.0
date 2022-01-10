Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C0C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:25:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BC353C9360
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 07:25:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2813C6AAF
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:18 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A61F8600A35
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641795916; i=@fujitsu.com;
 bh=bodRrEzzud5z/JeZEdyMJOM2Zk3A8rBgFoShFUWnA2Y=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=eM3d7NEgjLRE1cOGEaIp/1mNDm8Iwddf8J1rYJKsiy/ZUz3FAhBDJVLxdm6obpeNR
 L/U/Uvd00U3NkeLOIBqjVEwJ5OUEwcj0CsR9CgSK1gA5KTNGnJwYLVHD7bikyIjGZ/
 8eSamM8osW96Axknfk5nbXlEXluN5xqy7/b61J0iQHyC/zUw8C7Vd2i732UPHsZlHJ
 ydFrC4qVS94rdhNOmYpgJqQPWVQ19jjM8XIwxYLybJeDhhpuYTgNjiBTUr+wrhck5z
 /FG0zu9EYTurn83r05xNo3LiMZsZek2FIqgR2jdQ1ddM630WZd8xftDOVVIpXNXFdW
 UVPraaEM02cIA==
Received: from [100.115.5.195] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id E5/BF-10124-C41DBD16;
 Mon, 10 Jan 2022 06:25:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8ORqOtz8Xa
 iwc23QhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aa/zPYC06IV5yftIi9gXGLcBcjF4eQwFlG
 idOvFrJDODuZJBqPNrBBOHsYJf4+PgyU4eRgE9CUeNa5gBnEFhGQkOhoeAsWZxZQl1g+6RdTF
 yMHh7CAn8S2abogYRYBVYnPa5azgdi8Ah4S6+9dZwKxJQQUJKY8fA82hlPAU+L2vOksILaQQK
 LE2x+9zBD1ghInZz5hgRgvIXHwxQtmiF5FiUsd3xgh7AqJWbPaoGaqSVw9t4l5AqPgLCTts5C
 0L2BkWsVolVSUmZ5RkpuYmaNraGCga2hoqmuqa2RkrpdYpZuol1qqW55aXKJrqJdYXqyXWlys
 V1yZm5yTopeXWrKJERjEKcWsj3cwrun7qXeIUZKDSUmUd9/524lCfEn5KZUZicUZ8UWlOanFh
 xhlODiUJHj1DgDlBItS01Mr0jJzgBEFk5bg4FES4Y04B5TmLS5IzC3OTIdInWJUlBLnPQ4yUw
 AkkVGaB9cGi+JLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5D4NM4cnMK4Gb/gpoMRPQ4mQ
 OsMUliQgpqQam+MnbYv7d1Zypv1DZfHq6iYnefEdJEd5ZT7pc2zfMf3SuQFGwds7WV1vD7Q59
 CNdv/fbp6+WguuenrjbNr2G2FLA/kLnkw8M3Lz71HD81dQHXr1f1R7Luq8QwXnwSnFNR9VZ7m
 /x8t5K0v6cr3qhUH/rnJcW+x22f7uwta8/PrEsNOS6zmf3nn4y+17se90t9P8s8jXVRe7mPdG
 OJqmH6HQbjPynHlii8vCkZW3InLi5u4uy5R49Y8jXUpD7dpZX8Kqfy4z+9/q65q75xzXCUiLD
 keiVhvdW+ad6czX8Ylnx9dYll/uwSprW5DtfzozvSw9YFPH8vru7SH7fhTt+7p7ueWfqLXBGO
 MbtV49ctp8RSnJFoqMVcVJwIAJDD6rldAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-585.messagelabs.com!1641795916!228777!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28286 invoked from network); 10 Jan 2022 06:25:16 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-4.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Jan 2022 06:25:16 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C0EFB100188
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B48F8100199
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 06:09:39 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 10 Jan 2022 09:49:07 +0800
Message-ID: <1641779349-8424-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] lib: Introduce KCONFIG_SKIP_CHECK environment
 variable
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

This environment variable is designed to add kernel config check functionality
switch. So we can skip kconfig check completely and it is useful especially
for the embedded platforms that they don't have kernel config.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/user-guide.txt |  1 +
 lib/tst_kconfig.c  | 20 ++++++++++++++++++++
 lib/tst_test.c     |  1 +
 3 files changed, 22 insertions(+)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 494652618..864467f60 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -10,6 +10,7 @@ For running LTP network tests see `testcases/network/README.md`.
 |==============================================================================
 | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
                           the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
+| 'KCONFIG_SKIP_CHECK'  | Skip kernel config check, the default is empty(don't skip).
 | 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
 | 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
                           'n' or '0': never colorize.
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 7d7aecfc1..e4264101d 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -15,6 +15,16 @@
 #include "tst_kconfig.h"
 #include "tst_bool_expr.h"
 
+static int kconfig_check_skipped(void)
+{
+	char *skipped = getenv("KCONFIG_SKIP_CHECK");
+
+	if (skipped)
+		return 1;
+
+	return 0;
+}
+
 static const char *kconfig_path(char *path_buf, size_t path_buf_len)
 {
 	const char *path = getenv("KCONFIG_PATH");
@@ -485,6 +495,11 @@ int tst_kconfig_check(const char *const kconfigs[])
 	unsigned int i, var_cnt;
 	int ret = 0;
 
+	if (kconfig_check_skipped()) {
+		tst_res(TINFO, "Skipping kernel config check as requested");
+		return 0;
+	}
+
 	for (i = 0; i < expr_cnt; i++) {
 		exprs[i] = tst_bool_expr_parse(kconfigs[i]);
 
@@ -526,6 +541,11 @@ char tst_kconfig_get(const char *confname)
 {
 	struct tst_kconfig_var var;
 
+	if (kconfig_check_skipped()) {
+		tst_res(TINFO, "Skipping kernel config check as requested");
+		return 0;
+	}
+
 	var.id_len = strlen(confname);
 
 	if (var.id_len >= sizeof(var.id))
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d5cefadaa..8ac3cdc5c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -479,6 +479,7 @@ static void print_help(void)
 	fprintf(stderr, "Environment Variables\n");
 	fprintf(stderr, "---------------------\n");
 	fprintf(stderr, "KCONFIG_PATH         Specify kernel config file\n");
+	fprintf(stderr, "KCONFIG_SKIP_CHECK   Skip kernel config check (the default is empty means don't skip)\n");
 	fprintf(stderr, "LTPROOT              Prefix for installed LTP (default: /opt/ltp)\n");
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
