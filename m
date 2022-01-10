Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B56C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:25:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AAAB3C92DF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 07:25:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB8283C6AAF
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:18 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 94E5D2002D8
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641795916; i=@fujitsu.com;
 bh=H7h9hyVQ5xHHBPijxfY5wnBIqYlAfwrRHD5jrSsM5SY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=KRORsuOB8z3eR9/08LSp4Zd4HpedhDRhDOXc4/YXlwhWyptZcVh09q1jjmKC8r/n0
 5WlZ8tlB4pJgtGw+CMriJt+z1vdjfnuKNa7GtAOvmE1Vitw7rI9MDEm/2vJj1HbJZo
 2gU84BqQZQFI0ESt8ua0naJQtSF4wW9zhXlP5OOc7VjfxBb0UqTGdECCJZKeNbWtgN
 NgsWBLyK+aF65BXEsuK9zJZT4Szo1NS5CYVBtOnwXubLTcgxKHLTlSoQ2Rcpw2ygRe
 v6uzKeRLDgGElNW+74T52PZIXIe6SvwPo8ImNjT2DZ3K9hZeI17URgU+2GNRtwCkyH
 mLggDi7NaBwOQ==
Received: from [100.115.5.195] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id 0A/C7-13695-C41DBD16;
 Mon, 10 Jan 2022 06:25:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8ORqOtz8Xa
 iwfWNwhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8akKTPYCqaKV0x+W9zAuF64i5GLQ0jgLKPE
 wtULmSCcnUwSyy9chnL2MEpM6DrF1sXIycEmoCnxrHMBM4gtIiAh0dHwlh3EZhZQl1g+6RcTi
 C0sECuxpWU3I4jNIqAqseVSF1gNr4CHxKHZE8BsCQEFiSkP34PN4RRQkfjRvwSsV0hAWeLQq5
 1Q9YISJ2c+YYGYLyFx8MULZoheRYlLHd8YIewKiVmz2pggbDWJq+c2MU9gFJyFpH0WkvYFjEy
 rGK2SijLTM0pyEzNzdA0NDHQNDU11TXWNjI31Eqt0E/VSS3XLU4tLdA31EsuL9VKLi/WKK3OT
 c1L08lJLNjECgzilmPXlDsbpfT/1DjFKcjApifLuO387UYgvKT+lMiOxOCO+qDQntfgQowwHh
 5IEr94BoJxgUWp6akVaZg4womDSEhw8SiK8EeeA0rzFBYm5xZnpEKlTjIpS4rzHQWYKgCQySv
 Pg2mBRfIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO9hkCk8mXklcNNfAS1mAlqczAG2uCQ
 RISXVwMS6Z6PmxeCd2msXGRmmvpZ+nJEkMfXI02+X/reV7X7/0Cvg1e6+t+tt1+YHues9+1hw
 991Dnktx3G7p886mOW4r3XJiZ6VaTGKY10uOt3OMdk84a7C++HnP3xXxBc/in2g8EVT/rxR6Y
 foZ99+lEqt/MBvNOup0Ueh7isD1rBdFdZXneHIC5p/Yu/L4j0tSFS2PkvIOGn5bvCi1vuyKSd
 1z79Opsyxec7B213D9K3hQNGXG6qsyhhOUglrVN/lXJxj0z948KUS18r6a0bcrWid7vE68Xfl
 DQIfjeU9cvfijoGPt19sSGlVOOZx+J7vCZtlq1z2neCT3/V+3hG3bmb3CxyfKsYlPeeD9MHL2
 oc7/SizFGYmGWsxFxYkAyErRWV0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-585.messagelabs.com!1641795916!211381!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6773 invoked from network); 10 Jan 2022 06:25:16 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-16.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Jan 2022 06:25:16 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id CA5531001A7
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B611E10019A
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 06:09:36 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 10 Jan 2022 09:49:06 +0800
Message-ID: <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YdbQmTJK73804UYT@yuki>
References: <YdbQmTJK73804UYT@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lib/tst_kconfig: Modify the return type of
 tst_kconfig_check function
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

So this function can be used to detect whether the function succeeded in shell
api by its return value.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_kconfig.h | 5 +++--
 lib/tst_kconfig.c     | 9 ++++-----
 lib/tst_test.c        | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 1bb21fea8..cc0908ea8 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -44,7 +44,8 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
 
 /**
  * Checks if required kernel configuration options are set in the kernel
- * config and exits the test with TCONF if at least one is missing.
+ * config. Return 0 if every config is satisfied and return 1 if at least
+ * one is missing.
  *
  * The config options can be passed in two different formats, either
  * "CONFIG_FOO" in which case the option has to be set in order to continue the
@@ -53,6 +54,6 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
  *
  * @param kconfigs NULL-terminated array of config strings needed for the testrun.
  */
-void tst_kconfig_check(const char *const kconfigs[]);
+int tst_kconfig_check(const char *const kconfigs[]);
 
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index d433b8cf6..7d7aecfc1 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -478,12 +478,12 @@ static void dump_vars(const struct tst_expr *expr)
 	}
 }
 
-void tst_kconfig_check(const char *const kconfigs[])
+int tst_kconfig_check(const char *const kconfigs[])
 {
 	size_t expr_cnt = array_len(kconfigs);
 	struct tst_expr *exprs[expr_cnt];
 	unsigned int i, var_cnt;
-	int abort_test = 0;
+	int ret = 0;
 
 	for (i = 0; i < expr_cnt; i++) {
 		exprs[i] = tst_bool_expr_parse(kconfigs[i]);
@@ -506,7 +506,7 @@ void tst_kconfig_check(const char *const kconfigs[])
 		int val = tst_bool_expr_eval(exprs[i], map);
 
 		if (val != 1) {
-			abort_test = 1;
+			ret = 1;
 			tst_res(TINFO, "Constraint '%s' not satisfied!", kconfigs[i]);
 			dump_vars(exprs[i]);
 		}
@@ -519,8 +519,7 @@ void tst_kconfig_check(const char *const kconfigs[])
 			free(vars[i].val);
 	}
 
-	if (abort_test)
-		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
+	return ret;
 }
 
 char tst_kconfig_get(const char *confname)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9fea7263a..d5cefadaa 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1025,8 +1025,8 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (tst_test->needs_kconfigs)
-		tst_kconfig_check(tst_test->needs_kconfigs);
+	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
+		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
