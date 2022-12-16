Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01D3C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 04:01:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C26C73CBCF9
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 05:01:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8ECF3C8C27
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:01 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D8BD1400979
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671163258; i=@fujitsu.com;
 bh=cfkltWc/K6uLdqyaacPivfuabuPMaIzQQbFZ/PJ62r4=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=kQYCe9lXDN/niOcvZFlTBpbMsc6CJRQyTlpBEpR0npZHF9tappEW69iPip23uczYD
 Z0YiRsJib+qoIajW71ehqjObxny1salMXZufik054BoFpDhRZzuBaNdHPNyIYKC6ie
 UQC8IHrLRRHXhoSWDCEnGzhm5XGqEUYgFEXnlw1K0ai/aVqWV9HIpog31+uaQWICJ9
 cO2558MFreRzfXSb5E2+kdoy/PQ0JERsr1AvLj2quT7iXhbu0YUuY/LXHHPjtelBTZ
 EsGuS/EbRQRb7tFknlW7wFeYZQx+Grawi3sBZsVebSjFd7AlDf16w8/VRiI6CHcyJf
 nr9VvPEFDxhKQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRWlGSWpSXmKPExsViZ8MxSbfq7ex
 kg/P/eS1WfN/B6MDose/3OtYAxijWzLyk/IoE1oy3LdOYChaKVrT+WcDawDhPqIuRk0NI4Cyj
 xPYZYV2MXED2ASaJjrOPmCCcPYwSi1asYAKpYhPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0C
 6xGWMBWovVFNwuIzSKgKjH32l6wel4BD4nPO8+C2RICChJTHr6HigtKnJz5hAVijoTEwRcvoG
 oUJS51fGOEsCskZs1qY4Kw1SSuntvEPIGRfxaS9llI2hcwMq1iNC1OLSpLLdI11ksqykzPKMl
 NzMzRS6zSTdRLLdUtTy0u0TXSSywv1kstLtYrrsxNzknRy0st2cQIDMWUYlXlHYxflv7RO8Qo
 ycGkJMqrv3x2shBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3srXQDnBotT01Iq0zBxgXMCkJTh4l
 ER4t1wASvMWFyTmFmemQ6ROMepybNrXdYBZiCUvPy9VSpx35SugIgGQoozSPLgRsBi9xCgrJc
 zLyMDAIMRTkFqUm1mCKv+KUZyDUUmY98JLoCk8mXklcJteAR3BBHSEzL2ZIEeUJCKkpBqY+r9
 GPn0qqaFfnvGv49NnrhhlHdlyhYVXOg9M7RX4Ep2x8MnZGestU2VNBWeE3DqnXxph4fpDKbbg
 el9GSv2TS4uqk/IP9R23LVl9wPxr4/37085KyMlO/yhr3rFjIrOfQIx7nrzD9Dfpy60ulZvbl
 JsURW14+4yhVEJR4h+jV99/7XT9F1ybRW3bSn9Pjraq/b5hYZNC/Z35PXVXvLmsVY/6Jm/ZqS
 kzcdUvo08LTuVvVdhXpd502Mf3zN+Nz54vid1w5XeM8D+HFfrc/fXSJzKDj/7kKdAKv/aOxTt
 IoezbPX5tybLDf1a+vtbDMnP6Eke1uISG4hNyUpOOrTn6KUo24G+E38mUghet3klKLMUZiYZa
 zEXFiQDJ21fmTAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-548.messagelabs.com!1671163258!80797!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 434 invoked from network); 16 Dec 2022 04:00:58 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-12.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Dec 2022 04:00:58 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E03331000D5
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:00:57 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id D2A791000D2
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:00:57 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 16 Dec 2022 04:00:56 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 16 Dec 2022 13:01:57 +0800
Message-ID: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/7] lib/tst_kvercmp: Remove old distnames
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

The oldest supported test distributions kernel version is 3.10[1], so these old version
check is useless.

[1]https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions
Acked-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/tst_kvercmp.c                                   | 12 ------------
 testcases/kernel/syscalls/inotify/inotify04.c       | 13 +++----------
 .../kernel/tracing/dynamic_debug/dynamic_debug01.sh |  3 +--
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index dc0daa746..a01b4332b 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -134,18 +134,6 @@ const char *tst_kvcmp_distname(const char *kver)
 	char *ret = distname;
 	char *p = distname;
 
-	if (strstr(kver, ".el5uek"))
-		return "OL5UEK";
-
-	if (strstr(kver, ".el5"))
-		return "RHEL5";
-
-	if (strstr(kver, ".el6uek"))
-		return "OL6UEK";
-
-	if (strstr(kver, ".el6"))
-		return "RHEL6";
-
 	if (strstr(kver, ".el7"))
 		return "RHEL7";
 
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index fb9f5c293..c4fce399c 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -50,11 +50,6 @@ char event_buf[EVENT_BUF_LEN];
 
 int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;
 
-static struct tst_kern_exv kvers[] = {
-	{ "RHEL5", "2.6.18-132" },
-	{ NULL, NULL },
-};
-
 static void cleanup(void)
 {
 	if (reap_wd_dir && myinotify_rm_watch(fd_notify, wd_dir) == -1)
@@ -110,11 +105,9 @@ void verify_inotify(void)
 	 * This isn't well documented in inotify(7), but it's intuitive if you
 	 * understand how Unix works.
 	 */
-	if (tst_kvercmp2(2, 6, 25, kvers) >= 0) {
-		event_set[test_cnt].mask = IN_ATTRIB;
-		strcpy(event_set[test_cnt].name, "");
-		test_cnt++;
-	}
+	event_set[test_cnt].mask = IN_ATTRIB;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
 
 	event_set[test_cnt].mask = IN_DELETE_SELF;
 	strcpy(event_set[test_cnt].name, TEST_FILE);
diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index 4b159517b..ca6c840b1 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -59,8 +59,7 @@ setup()
 		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
 	fi
 
-	# Both patches with changes were backported to RHEL6 kernel 2.6.32-547
-	if tst_kvcmp -ge '3.4 RHEL6:2.6.32-547' ; then
+	if tst_kvcmp -ge 3.4 ; then
 		NEW_INTERFACE=1
 		EMPTY_FLAG="=_"
 	fi
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
