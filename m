Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4915BC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 10:39:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 040753CBE6A
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 11:39:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 630843CB6DC
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 11:39:29 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2595014001FB
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 11:39:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1670841567; i=@fujitsu.com;
 bh=AkSgxf27TqJKUi7ACmS2IsqgYkcf7Ttx/ulEFpPxDvo=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=bwN82JGhrWxvgtK4WbH4gR/D8yD6RK2dxubiUH5srUC2DshPRd809i5awLvcX183l
 5myxUPe49vXlq1ob5Kt7OQ1wm2WWy86HGCA5bn07dv2pE+Y9t40xdEw+xVOljIMFOm
 sor57jgRUii5zOlRuWPKzr5oBJq1dwkIWbrWjp6QLKan1Py5W47dIhtizHl+BNlDh9
 mLqxkcBdku1l/1kF4lzno2bWe0c1L7WDJ3J0MndQcOuGRyklKRYlYslWPjU7ToK1WC
 VWp7WImQMnQCLIr3J8JntSwTGYaU9XFQqkfINsEarLsmqCv1n7F+Y4BE19PntaSRsk
 5ihqUYlgN9wGA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8ORqHuPZXq
 ywd4P2hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bcfbuYCy4LV6w6toSlgfGOQBcjF4eQwFlG
 iQmPTrFBOAeYJDpfbGOBcPYwSjz4vgwow8nBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXE
 4gtLGArMb/pMyuIzSKgKnFt1nEWEJtXwEOi78xfsBoJAQWJKQ/fM0PEBSVOznzCAjFHQuLgix
 fMEDWKEpc6vjFC2BUSs2a1QfWqSVw9t4l5AiP/LCTts5C0L2BkWsVoVpxaVJZapGtoqZdUlJm
 eUZKbmJmjl1ilm6iXWqpbnlpcomukl1herJdaXKxXXJmbnJOil5dasokRGI4pxYrrdjBOX/ZH
 7xCjJAeTkihv+p9pyUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeAO+AOUEi1LTUyvSMnOAsQGTl
 uDgURLhPcY0PVmIt7ggMbc4Mx0idYpRUUqcV4gZKCEAksgozYNrg8XjJUZZKWFeRgYGBiGegt
 Si3MwSVPlXjOIcjErCvNtBxvNk5pXATX8FtJgJaHHUy6kgi0sSEVJSDUx2U78/33v/6bMZFwz
 nvq7zftR4pr/PY1+RsdeX5JuPvdzM7zLG7a/7P8Ppdn2U4swNG3Smiy3byj3jc2e92vQT1rPb
 NE2P+TzKKsidebZq9dwPdgJThDkmVNW1bH2TdPJVS9/buTtu/biZM9eP9ypjHW9A3lZu/9yy9
 gmVQevMm6oTOPpCMnalHolzdJFry2Y99P+c6V3D6wITe2V7nnXY/f9ZNNNz7x9//YlP+db8Vt
 y54VP4iZW3k1q43b5OT2Zk9Eu+0j9Bg7nhlfIahr3dyjs1nmhr1khdPHXZVqZ2d3vNoUu6t1i
 n/zYwt3vslng46KXucqE/y4/cVHM9fmGrF59Qjs8M0SnifLolBw8osRRnJBpqMRcVJwIA3mty
 gUIDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-571.messagelabs.com!1670841566!290753!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1427 invoked from network); 12 Dec 2022 10:39:26 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-5.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Dec 2022 10:39:26 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6979C100192
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 10:39:26 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 5D362100191
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 10:39:26 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 12 Dec 2022 10:39:24 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 12 Dec 2022 19:40:26 +0800
Message-ID: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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

Our travis-ci has dropped or never used them, they are useless.
So delete.

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
