Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235DCC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:11:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31D4E3C93E4
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:11:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E44703C93B9
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:22 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F4E51A00F26
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641881420; i=@fujitsu.com;
 bh=K/ERPVUdtk58FBM32qQ3N0mDuzuG3jYhjn/a4K8ozA4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=xtqmxi0l+ZNO4rYUUbXmg3FH2KzSbT4pV5nzTFpgJw6ElunMkLJke8DG55jLRNYQV
 yWcd3KpZ9Hvk2oJZuCMCBw+wMlirsyvqg3JmfdPhCxOcveLBpDICC9mTMAZtaCJ5Vm
 ti5GaQZ2tC8+6UYh4dOEdsKdLCzMzk42AcT4awglFZIsicqEjHa8F0uM+jxieZ1dTz
 kE8x1AhRKntG63OwQdonauTspiRGVz80HLX+Z3FO9/wak3QyoYZiru3chCBMNSt42L
 C6OiRR6Lz7g14QZqG/0JJr4W2VXRfVbLo+G6DUPZOuyuHM2gwG4GYXGP3xOydSbZ45
 HWcttZoD6V0yA==
Received: from [100.115.1.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.ess.symcld.net id 85/96-14524-C4F1DD16;
 Tue, 11 Jan 2022 06:10:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8MxSddH/m6
 iQc9SVosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP279iCqRIVGxYENTD+EO5i5OIQEjjLKHF4
 4QkWCGcnk0RHxxdmCGcPo8Sj5ZtZuxg5OdgENCWedS5gBrFFBCQkOhresoPYzALqEssn/WICs
 YUF/CTe9LwFq2cRUJVYuGQhG4jNK+AhsXzldbAaCQEFiSkP34PN4RTwlOg9NRGsRkggUWL+ge
 dMEPWCEidnPmGBmC8hcfDFC2aIXkWJSx3fGCHsColZs9qgZqpJXD23iXkCo+AsJO2zkLQvYGR
 axWiZVJSZnlGSm5iZo2toYKBraGiqa6JraayXWKWbqJdaqlueWlyia6iXWF6sl1pcrFdcmZuc
 k6KXl1qyiREYwCnFLLE7GLf2/dQ7xCjJwaQkylsreTdRiC8pP6UyI7E4I76oNCe1+BCjDAeHk
 gTvDFmgnGBRanpqRVpmDjCaYNISHDxKIrxa0kBp3uKCxNzizHSI1ClGRSlx3s+CQAkBkERGaR
 5cGyyCLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5p0oBzSFJzOvBG76K6DFTECLkzlugyw
 uSURISTUwWb/IO/TVwajl7aSTgsuuFyo53Ow4e+nOsz+WzRbGLW5fz24KOG82J1TCerlyVtsa
 y38fZkjnJBZxTJmsfzpYNOTKzvfCflfcH86rvxJq0Pbi5UcvLaer5/ZOCr/1/FRte5yV78uZA
 rzMbDwM9wObVHsi3/Of/DNR/YB8xUY2ma+x+kzb26ZZHJF0fP2vJX+doCrb7sBJgn8MFrxY36
 /6cH4Z9/JHQex3H33+dmHdBo+m7dyPwzR2/twlMYM58vp0KfMH1xKzp1nVLNPS3j9Hb0Ww2aG
 3ZimHZi2OvsyRVWD/5+yWNe/DLL5LvfRwVPOY+Ezy5sTgmBnTcxqYV20xPjA5vKVzr0J5xb5H
 DzL3ciqxFGckGmoxFxUnAgAHfabwWwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-587.messagelabs.com!1641881419!42666!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31548 invoked from network); 11 Jan 2022 06:10:20 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-16.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 06:10:20 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 6F556100455
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 5E02010044F
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 06:10:02 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 14:10:32 +0800
Message-ID: <1641881435-2351-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/5] lib: Introduce KCONFIG_SKIP_CHECK environment
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/user-guide.txt |  1 +
 lib/tst_kconfig.c  | 20 ++++++++++++++++++++
 lib/tst_test.c     |  1 +
 3 files changed, 22 insertions(+)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 494652618..6b80bb699 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -10,6 +10,7 @@ For running LTP network tests see `testcases/network/README.md`.
 |==============================================================================
 | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
                           the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
+| 'KCONFIG_SKIP_CHECK'  | Skip kernel config check, the default is empty (don't skip).
 | 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
 | 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
                           'n' or '0': never colorize.
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 7d7aecfc1..d0c9b24c2 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -15,6 +15,16 @@
 #include "tst_kconfig.h"
 #include "tst_bool_expr.h"
 
+static int kconfig_skip_check(void)
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
 
+	if (kconfig_skip_check()) {
+		tst_res(TINFO, "Skipping kernel config check as requested");
+		return 0;
+	}
+
 	for (i = 0; i < expr_cnt; i++) {
 		exprs[i] = tst_bool_expr_parse(kconfigs[i]);
 
@@ -526,6 +541,11 @@ char tst_kconfig_get(const char *confname)
 {
 	struct tst_kconfig_var var;
 
+	if (kconfig_skip_check()) {
+		tst_res(TINFO, "Skipping kernel config check as requested");
+		return 0;
+	}
+
 	var.id_len = strlen(confname);
 
 	if (var.id_len >= sizeof(var.id))
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d5cefadaa..db19d0d68 100644
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
