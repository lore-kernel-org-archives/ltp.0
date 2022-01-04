Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527FC433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 06:57:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F39E3C8F89
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 07:57:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60AFF3C21F9
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 07:57:19 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0D7E1000970
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 07:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641279437; i=@fujitsu.com;
 bh=3Fg8mY39HkZi5vsItE5wYTUIYeL3ji8hwBiLbfCiQMk=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=QHlEG+ViwePNoaX/+lCXbzQuK28gqDg2SWTAOXW5n/LfAIUE6FbQLBnLOEc1A2W+W
 kfxPq3GKICCU6mUCAOHyyl3s9imWcwYOjYYmPSKD8308YHede60RruuDs8nLW8VGwZ
 rYahO41OnRApMYAC+WpcXz2qgwn2m0ZJ56/LdtpqC2DM5SpGAALx6vtVIcfuUTN0vI
 tHP/SIfNviFF8sGcPn4GO3S8N8kK6Mu54ZS8JhuJEYOcP8ft9dGdrrMlFhf7F5bHRs
 pdDB967Qb4Ihes9dwFXtp3OPBewvOQllPdYbTWddzrHiMlusaNAn4N+YM6LJHYSWOm
 ThUWfCSxLPKCQ==
Received: from [100.115.32.243] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id EA/DD-27579-DCFE3D16;
 Tue, 04 Jan 2022 06:57:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRWlGSWpSXmKPExsViZ8MxSffs+8u
 JBo1bRC1WfN/B6MDose/3OtYAxijWzLyk/IoE1oz9+9eyFawUq2jb0MzewPhEqIuRi0NI4Cyj
 xPP+BnYIZyeTxLtV85ggnN2MEk/WbWPuYuTkYBPQlHjWuQDMFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFoiVmDZrFQuIzSKgInHh2QGwel4BD4mNi/rBaiQEFCSmPHwPFReUODnzCQvEHAmJgy9eME
 PUKEpc6vjGCGFXSMya1QbVqyZx9dwm5gmM/LOQtM9C0r6AkWkVo3VSUWZ6RkluYmaOrqGBga6
 hoamusamuoYmlXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFecWVuck6KXl5qySZGYGCmFCtP3cF4
 etVPvUOMkhxMSqK8GScvJwrxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4K14DZQTLEpNT61Iy8wBR
 glMWoKDR0mE9+c7oDRvcUFibnFmOkTqFKOilDhvHUhCACSRUZoH1waLzEuMslLCvIwMDAxCPA
 WpRbmZJajyrxjFORiVhHn7QabwZOaVwE1/BbSYCWjxOTmwxSWJCCmpBqYa8cfBfb83thlr7n1
 pXz+3etaS1IpZ+lE/wnonrZOY7er9YSbD4xtWGWfyZRWlZ887tNal8/7T3fbTy5bZ6KyPKYvd
 aXb461nNFK+SXzprk8rORrze8C5hQkKg7gx3e436D5oiVceMxBdP/jvP3DDtR9DlyJvq3OmP9
 3VxXT0xS+L0KR9eg2Lpd2a/nBzSDCQltrI9NM37Mrn3xYdfxx+93BB8YqlUk/KJm+USQrfVKv
 cvO3fgzGmJ8wkaLpw99xhjrLIK41y+clrHKvs55hcXdLdeettxQnzqo7kze9N0Pkd+amS6Ofd
 XTsMrvvWp833V/F9NvHikXiy+4sVU99npHZmTrZR+2STabi9+9kOJpTgj0VCLuag4EQAqeJma
 RwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-548.messagelabs.com!1641279437!336020!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15491 invoked from network); 4 Jan 2022 06:57:17 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Jan 2022 06:57:17 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 016AD10034F
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 06:57:17 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E86A11000FE
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 06:57:16 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 06:56:54 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Jan 2022 14:57:17 +0800
Message-ID: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] lib/tst_kconfig: Modify the return type of
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
 include/tst_kconfig.h |  2 +-
 lib/tst_kconfig.c     | 21 ++++++++++++---------
 lib/tst_test.c        |  4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 1bb21fea8..050687c69 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -53,6 +53,6 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
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
index 23fc0ebf4..f0bf97743 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1016,8 +1016,8 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
 
-	if (tst_test->needs_kconfigs)
-		tst_kconfig_check(tst_test->needs_kconfigs);
+	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
+		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
 	assert_test_fn();
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
