Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE2C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:10:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2793C93FC
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:10:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C69FF3C937D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:22 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 318031A00F2E
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641881420; i=@fujitsu.com;
 bh=Ub7nFpsv2oLMD1XAhCRNXvejK91EX6kIQviyQR/nCsE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=PWAxHs0ScytmnHj28dSJvh1asBFuEZTJVdFvXfvAln8ANTFZ5v64XxOW+Zsx04MDD
 m3THYjpV//hntodHsfTc9KGP8Nky0aEXOgUYMQgOY/kYtqQsXWLU2okuOzcIA/1jsf
 LvQqWi8UBzHqeGh9nCJA1yn1t2vn0ylK4aO4mZrL4/q1gLcpBL+nrAx/NOsY1F7KXJ
 rvpa7ZUbflRhESnM9gbLWxS9WXnN6P0pq7OjI3CnWK9t95skDmHlge7XFFWKJzFppW
 3Leh1IvdfPSE9pk8AI95qmoTbyX+oEwtp1GGBjxeIH3ZvgFU/7vVcD10Pi6lqGa4I8
 43/sK9EnshSLA==
Received: from [100.115.1.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.ess.symcld.net id B6/96-14524-C4F1DD16;
 Tue, 11 Jan 2022 06:10:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8MxSddH/m6
 iwaqj7BYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b5edOZCl6JVxw+8pexgfGPcBcjF4eQwFlG
 ie2NZ5kgnJ1MEsve/GTvYuQEcvYwSmy9xAJiswloSjzrXMAMYosISEh0NLwFq2EWUJdYPukXU
 DMHh7BArMTpFkWQMIuAqsSUGZsZQWxeAQ+Jps/7wWwJAQWJKQ/fg43hFFCRuLh5BwtIq5CAsk
 TrQXWIckGJkzOfsEBMl5A4+OIFM0SrosSljm9QYyokZs1qY4Kw1SSuntvEPIFRcBaS9llI2hc
 wMq1itEwqykzPKMlNzMzRNTQw0DU0NNU11DW11Eus0k3USy3VLU8tLtE11EssL9ZLLS7WK67M
 Tc5J0ctLLdnECAzflGJG6x2MHX0/9Q4xSnIwKYny1kreTRTiS8pPqcxILM6ILyrNSS0+xCjDw
 aEkwTtDFignWJSanlqRlpkDjCWYtAQHj5IIr5Y0UJq3uCAxtzgzHSJ1ilFRSpz3syBQQgAkkV
 GaB9cGi99LjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5J8oBTeHJzCuBm/4KaDET0OJkjts
 gi0sSEVJSDUwr7I5+Vv7IUndOx9nZ/WGqKMfapXrfHsW46fNfiO5u9LmvO1s8faPW4bzbalo3
 uLeK/NGzuOBy8JK5foq+yseupxXhNsy7Z5x+mSycuIlb76b7ivRrT+0O9ZoWZtueVH1WeHbh7
 h0Mx20MA6+u3K4R8HljHot26M7tRZ2HuGIX69oZ7tIy177nHLsi1vCZStRP1fLAwBmeJnKb9h
 5m9byzmLUpptDPgONV0cuAioay7Jrl2iqr9zRrLzoYxisX3JfAJRtm+WY/b1GNtKJy4bQnz5N
 Wfu8zrtx56I7o4qR3q2qmKhnMnLOu9vWX0LMVG+POKz579O7xoh2NX08sCdm1uGhFdPdNmSWS
 ITJXlZVYijMSDbWYi4oTAfD++vtaAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-591.messagelabs.com!1641881419!62060!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18785 invoked from network); 11 Jan 2022 06:10:20 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 06:10:20 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 6DDF3100453
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 5A3B110044D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 06:09:57 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 14:10:31 +0800
Message-ID: <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Ydw4BXF2ramqahuh@yuki>
References: <Ydw4BXF2ramqahuh@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/5] lib/tst_kconfig: Modify the return type of
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
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
