Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB3C433EF
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 05:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2143C974A
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 06:51:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 361533C9728
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 06:51:10 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7431E6008A3
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 06:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1643349068; i=@fujitsu.com;
 bh=a08omTuZqkKwEfcLyoLtsY50UOpHMHbaXVWBenLW4ys=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=uSnqk/tDVbXKg/i+TyL2ut509L1QQH6m6MXikdaQU6BKjSUA2T/sJz5wWL6BthW4L
 zNUclkKCFCrIydbV153l09DWysJLdP0z8Rg7bRwXD/eZ1OUluFaBTl9z5aflgYDAuQ
 jMacL994ABPhZ6F7ZM9VkX92ruLIw+bEx/9FLA5AnUKa9vZzMNcNX/OboV5KtfZUUD
 Ol24K6+KfYFnWlUOZZKqm5v62ig2LGonlmEJeI3tsWqMNYiXgERlMDNA0MkNJMRk8z
 Q8F8jypPFVfgTxutTfU+zb99EDD9i44eQdca4M/YAJTiCk7dMKF+xGdD8PHXeLZeQI
 cJY0ZNQw2fG2g==
Received: from [100.115.38.101] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-2.aws.ess.symcld.net id E4/D7-14616-B4483F16;
 Fri, 28 Jan 2022 05:51:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8ORqOvd8jn
 RYGWbusWK7zsYHRg99v1exxrAGMWamZeUX5HAmvF5/yamgq9CFU9+nmBpYFwu0MXIxSEkcJZR
 4u2lG4wQzk4midtzFrBBOHsYJSa8WAfkcHKwCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC0RI3P93DqyGRUBVYvLh3ywgNq+Ah8TDc1/B6iUEFCSmPHzPDBEXlDg58wkLxBwJiYMvXj
 BD1ChKXOr4xghhV0jMmtXGBGGrSVw9t4l5AiP/LCTts5C0L2BkWsVolVSUmZ5RkpuYmaNraGC
 ga2hoqmtspGtoopdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yTopeXWrKJERiWKcUKfDsY
 m1f91DvEKMnBpCTKm9v0OVGILyk/pTIjsTgjvqg0J7X4EKMMB4eSBO+EeqCcYFFqempFWmYOM
 EZg0hIcPEoivDUgrbzFBYm5xZnpEKlTjLocO4/OW8QsxJKXn5cqJc6r2AxUJABSlFGaBzcCFq
 +XGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzOoFM4cnMK4Hb9AroCCagI7Yd+QRyREkiQkq
 qgcmz4p7WscW1D6d855x9s/t70us/UjE/e1NedG5u1/a7wvD1m/Umu8nuAVz8TAmSjhvmM/wX
 zZwwv/ZGRrPjlSkr5ly8dvuv/HzfzhniGfO9l6xMen3W1kdgpjVr8Z9Jd3apyL7sO932Wv69s
 P5KEUuFlRUz2uI/r5lpZiKyWSxU+3OkV0i0b6fq44iNyZ4elU69J5YmnJwYHn750u0dcuzZac
 dO5VTPKhXx5ClPSrmW/XGVvssjsQ0Pt9e0yQmt2mo/ZfGGW5EmR/x2azC8udojfeRilNWcSt8
 bFReunS4Pcjn30ex61uVVK5w9e637rhx4dNm31788ueCY+UPuuE0nCo9vVKs8sHCmKc+VxstK
 LMUZiYZazEXFiQBDAjNHUgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-548.messagelabs.com!1643349067!52242!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26079 invoked from network); 28 Jan 2022 05:51:07 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-2.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 28 Jan 2022 05:51:07 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 4667410019D
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 05:51:07 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 39A4D10004D
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 05:51:07 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 28 Jan 2022 05:50:44 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 28 Jan 2022 13:51:11 +0800
Message-ID: <1643349071-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sysctl/sysctl03: Test whether return EINVAL when
 passing negative value
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

It is a regression for kernel commit
1622ed7d07432 ("sysctl: returns -EINVAL when a negative value is passed to proc_doulongvec_minmax").

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/commands                      |  1 +
 testcases/commands/sysctl/sysctl03.sh | 52 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100755 testcases/commands/sysctl/sysctl03.sh

diff --git a/runtest/commands b/runtest/commands
index 8cfad0449..c515c7231 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -41,4 +41,5 @@ gdb01_sh gdb01.sh
 unshare01_sh unshare01.sh
 sysctl01_sh sysctl01.sh
 sysctl02_sh sysctl02.sh
+sysctl03_sh sysctl03.sh
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
diff --git a/testcases/commands/sysctl/sysctl03.sh b/testcases/commands/sysctl/sysctl03.sh
new file mode 100755
index 000000000..ae7bd11c6
--- /dev/null
+++ b/testcases/commands/sysctl/sysctl03.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+# Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+#
+# When we pass a negative value to the proc_doulongvec_minmax() function,
+# the function should return EINVAL and the corresponding interface value
+# does not change.
+#
+# It is also a regression test for
+# commit 1622ed7d0743 ("sysctl: returns -EINVAL when a negative value is passed
+# to proc_doulongvec_minmax").
+#
+# Use fs.epoll.max_user_watches interface to test this.
+
+TST_TESTFUNC=do_test
+TST_SETUP=setup
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="sysctl"
+TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y, CONFIG_INOTIFY_USER=y"
+sys_name="fs.epoll.max_user_watches"
+sys_file="/proc/sys/fs/epoll/max_user_watches"
+
+. tst_test.sh
+
+setup()
+{
+	orig_value=$(cat "$sys_file")
+}
+
+do_test()
+{
+	tst_res TINFO "trying to set $sys_name=-1"
+
+	sysctl -w -q $sys_name=-1 2>&1 | grep -q "Invalid argument"
+
+	if [ $? -eq 0 ]; then
+		tst_res TPASS "sysctl returns EINVAL when passing a negative value"
+	else
+		tst_res TFAIL "sysctl doesn't return EINVAL when passing a negative value"
+	fi
+
+	new_value=$(cat "$sys_file")
+	if [ $orig_value -eq $new_value ]; then
+		tst_res TPASS "the interface value doesn't change when passing a negative value"
+	else
+		tst_res TFAIL "the interface value changes when passing a negative value"
+		sysctl -w -q $sys_name=$orig_value
+	fi
+}
+
+tst_run
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
