Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C73FC433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 09:48:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B0343C980F
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 11:48:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 500713C051B
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 11:48:29 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 53300600F53
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 11:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1657273707; i=@fujitsu.com;
 bh=wJqF8wxYHa65gwPMAUmCWgfNP3zK+fYPl2Ao8M1duZk=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=azoTCH7zEsNJE/oZNDWUMRBg4dvqMEh5ENqdlfKZAaM6wxGBBJ94RISZ1NMm8CY8i
 CE1oiQIcZTjvRtbFxDEJ4fqik+DJX3Sefi6mZ9QZQkf9/TNDie2z1hgpDrlmHSJEB3
 NnselqjOrPm+GF9ROD5v8k8Z0PImTiuJfTZFnWBF84OKIWUKFZ0vUtoM0plncd6A5d
 b0s/iffi43WOY+rrssc0ZnwEOyu6GbrCHVQ/IcXrehvegfD5NCKAbRQniLPB/j1maL
 IOm97Znim/CmYnR85ABLHnXJMjalTAoAjMzZ53B4efufc+XSx3650m16G0dpENthSs
 T5Vdwzn4mhZGA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8ORqJv193i
 SwbyHehYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8anTZfZC6YIVzSs38XSwLhGoIuRi0NI4Cyj
 RPucSYxdjJxAzgEmiQUnsiASuxklpv6dxgKSYBPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0i
 wnEFhZQlfj14DXQIA4OFgEVifPn/EHCvAIeEq/ON4O1SggoSEx5+J4ZIi4ocXLmExaIMRISB1
 +8gKpRlLjU8Y0Rwq6QeH34ElRcTeLquU3MExj5ZyFpn4WkfQEj0ypGm6SizPSMktzEzBxdQwM
 DXUNDU11Lc11DY0u9xCrdRL3UUt28/KKSDF1DvcTyYr3U4mK94src5JwUvbzUkk2MwLBMKU7s
 3sG4et8vvUOMkhxMSqK89q+OJwnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4F33GygnWJSanlqRl
 pkDjBGYtAQHj5IIL/cfoDRvcUFibnFmOkTqFKMux9TZ//YzC7Hk5eelSonzsoIUCYAUZZTmwY
 2AxeslRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK880Gm8GTmlcBtegV0BBPQEcvyj4AcUZK
 IkJJqYFq2sX768k0Tlxi8P6XFfVx3kyln0oMLPvXs4hv+aEw78ePktMQF4j9m8OQf/X8wqOt6
 pa7PlG3LeV/u3bJhL+ce1QdZtz8dXMT0KPyewuGu57v4rwRFmfHNDPE+9kTcXKxDU36JsVeD0
 SWnda9eT72ZMX1Z0EHmF3qaH5V4i9mObM+aulOqudPqZxencfyUpZozHfICmOotC580BFy521
 DB5sEunbhqN89ek1R/v4XxjC1vpignveeenlvWPusyc3U7X+LVZpv34h7rjiQeL1RTTlnFbm9
 QLPThbeuE2Sc176wMfC/4raDE/IXGltcuih7TmnjLtLbGdMw4zXxph6qzd+n5bRIi86V9JDu+
 XlJiKc5INNRiLipOBAAM1f+uUgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-728.messagelabs.com!1657273706!21306!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31756 invoked from network); 8 Jul 2022 09:48:26 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-22.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 8 Jul 2022 09:48:26 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 2936F100192
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 10:48:26 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 1DA53100043
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 10:48:26 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 8 Jul 2022 10:48:24 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 8 Jul 2022 18:49:08 +0800
Message-ID: <1657277348-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_cgroup: Fix typo
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

We only have needs_cgroup_ctrls instead of needs_cgroup_controllers in
tst_test structure. So fix it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
I found it when I plan to write a cgroup regression test to ltp.
 doc/c-test-api.txt   | 6 +++---
 include/tst_cgroup.h | 2 +-
 lib/tst_test.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index c138b7027..9ecf28630 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2144,13 +2144,13 @@ struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
-	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	...
 };
 -------------------------------------------------------------------------------
 
 Above, we first ensure the memory controller is available on the
-test's CGroup with '.needs_cgroup_controllers'. This populates a structure,
+test's CGroup with '.needs_cgroup_ctrls'. This populates a structure,
 'tst_cg', which represents the test's CGroup.
 
 We then write the current processes PID into 'cgroup.procs', which
@@ -2217,7 +2217,7 @@ static void cleanup(void)
 struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.needs_cgroup_controllers = (const char *const []){
+	.needs_cgroup_ctrls = (const char *const []){
 		"cpuset",
 		"memory",
 		NULL
diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d32d62399..08d1339a2 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -115,7 +115,7 @@ void tst_cg_print_config(void);
 
 /* Ensure the specified controller is available in the test's default
  * CGroup, mounting/enabling it if necessary. Usually this is not
- * necesary use tst_test.needs_cgroup_controllers instead.
+ * necessary use tst_test.needs_cgroup_ctrls instead.
  */
 void tst_cg_require(const char *const ctrl_name,
 			const struct tst_cg_opts *const options)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 4a196fc46..4b4dd125d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1259,7 +1259,7 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->needs_cgroup_ctrls)
 		do_cgroup_requires();
 	else if (tst_test->needs_cgroup_ver)
-		tst_brk(TBROK, "needs_cgroup_ver only works with needs_cgroup_controllers");
+		tst_brk(TBROK, "tst_test->needs_cgroup_ctrls must be set");
 }
 
 static void do_test_setup(void)
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
