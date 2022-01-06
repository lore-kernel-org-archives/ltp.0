Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05369C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:25:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11EC93C7B55
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:25:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9B973C03F6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:06 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 528441A010EA
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641461104; i=@fujitsu.com;
 bh=TH/oFoa+13kWvDTCnGdCO7MJ8DBjVtLuTUFkvfmAlAk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=pri71bOQ6lwA68A1TKHasYZhXM6k1Zxawu0qqF+zKeDdXPM5HKXB6ZW813OUDMafj
 SQvdvC/RNKDHaB7FTZzR92QRz+Dtqw7si9oR1Lqkr6B35aBCJC8eUdSyWFFx5V0LIY
 SGwJLF8Kq0qd86hYnJmyD0surjujie6GPslz8D+8fbH/u9rr52+jSSLDMpPGautSYb
 77jHj5QGgBtJzZlt4mhFlzOivtgalJH1KWp10FCrvR7EQx0SajJEABlBm0URdNHu9O
 IOce6K3ZjOVfr7vuLTFDVmwWpIFOb8Aue05Ht+n1bDF60UGK8Ffq8FA8x7N59pSKA5
 gTjVYXMZm+lVA==
Received: from [100.115.64.141] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id AA/C8-06990-075B6D16;
 Thu, 06 Jan 2022 09:25:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsViZ8MxSTd/67V
 Eg3l/DSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oy9axUKNktV7PlyiL2BsVGsi5GLQ0jgLKPE
 +jebmSCcnUwSs2YfgnJ2M0r86W5h7GLk5GAT0JR41rmAGcQWEZCQ6Gh4yw5iMwuoSyyf9IsJx
 BYWiJVYPHMBWJxFQEVixbz5LCA2r4CHxMOG/2C9EgIKElMevgeyOTg4BVQldi73BAkLAZUfaN
 jLBFEuKHFy5hMWiPESEgdfvIBqVZS41PGNEcKukJg1q40JwlaTuHpuE/MERsFZSNpnIWlfwMi
 0itEuqSgzPaMkNzEzR9fQwEDX0NBU19xQ19DYWC+xSjdRL7VUNzk1r6QoESitl1herJdaXKxX
 XJmbnJOil5dasokRGMopxe6tOxgv9/3UO8QoycGkJMrbpXUtUYgvKT+lMiOxOCO+qDQntfgQo
 wwHh5IEr/0moJxgUWp6akVaZg4wrmDSEhw8SiK8vzYCpXmLCxJzizPTIVKnGBWlxHknbAFKCI
 AkMkrz4NpgsXyJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvq81AU3gy80rgpr8CWswEtPi
 c3GWQxSWJCCmpBibLT8bJRrkbqljn7F77J/HnEmGXVNMCxb98J1QnTVCu+X/0XIlHDt9Cown8
 OZHWW47JvcuZG98ka/r69EzL5s4ER2Nxhknv5YqPlrJLirw5be5oUvxRbOoyh86pVsHhaw58k
 M6/uFKmXPpAXu47Q7sczcRrOx542qQ9nn6GkZs3N6WmesfnuiVPAt4vb/2RbvA24VeeRtMCgQ
 q5WoWO3TqmG6YdaCs34WYMrGwy21Hv3R3THaV7PT9s60k72xvBr/LPTP++bP/1Z1LfUnYX5ct
 UnbVl2xe+p09G6+Gp5v719z9Pkw1sFHA84NdscnNqC+sEobaZknqCClUTSw5Erf20t9n0raxo
 TXgx1wl5JZbijERDLeai4kQAi6ZaHmADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-545.messagelabs.com!1641461103!5806!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5746 invoked from network); 6 Jan 2022 09:25:03 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Jan 2022 09:25:03 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 48540100446
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:03 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 38AEF100354
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:03 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 09:24:58 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Jan 2022 17:25:18 +0800
Message-ID: <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YdWsZpTjnBLszubC@pevik>
References: <YdWsZpTjnBLszubC@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] lib/tst_kconfig: Modify the return type of
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_kconfig.h |  5 +++--
 lib/tst_kconfig.c     | 21 ++++++++++++---------
 lib/tst_test.c        |  4 ++--
 3 files changed, 17 insertions(+), 13 deletions(-)

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
index d433b8cf6..dc7decff9 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -478,22 +478,26 @@ static void dump_vars(const struct tst_expr *expr)
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
 
-		if (!exprs[i])
-			tst_brk(TBROK, "Invalid kconfig expression!");
+		if (!exprs[i]) {
+			tst_res(TWARN, "Invalid kconfig expression!");
+			return 1;
+		}
 	}
 
-	if (validate_vars(exprs, expr_cnt))
-		tst_brk(TBROK, "Invalid kconfig variables!");
+	if (validate_vars(exprs, expr_cnt)) {
+		tst_res(TWARN, "Invalid kconfig variables!");
+		return 1;
+	}
 
 	var_cnt = get_var_cnt(exprs, expr_cnt);
 	struct tst_kconfig_var vars[var_cnt];
@@ -506,7 +510,7 @@ void tst_kconfig_check(const char *const kconfigs[])
 		int val = tst_bool_expr_eval(exprs[i], map);
 
 		if (val != 1) {
-			abort_test = 1;
+			ret = 1;
 			tst_res(TINFO, "Constraint '%s' not satisfied!", kconfigs[i]);
 			dump_vars(exprs[i]);
 		}
@@ -519,8 +523,7 @@ void tst_kconfig_check(const char *const kconfigs[])
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
