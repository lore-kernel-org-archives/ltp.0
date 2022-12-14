Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B22C001B2
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 10:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D71C93CBD67
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 11:44:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AC4A3C1B40
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:44:01 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A74BF60068B
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671014639; i=@fujitsu.com;
 bh=cfkltWc/K6uLdqyaacPivfuabuPMaIzQQbFZ/PJ62r4=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=R9c2MHC756gDIfHcA1kmGmZTa0ZF9up4dOfhDUIOPNqnEKCNc4nl6ZImqLqTurRS9
 MciDS6p5nmYdDt3rRv6+SBZ5ZImEPI9cpfxMnoENoW6EnxcrlntG6/MMw/GZP4g4Gh
 9BTxnbSKg/G1WEoejQGlC8c+8bEzYrgc96byS3Cbjihf4AQ1Puj+A/EOerLeqCHNDn
 2Rvvv7jZYwmG6904CftBR7yUyyszcMjSxaoTfhYEeyXXilhKI5uQu72fFy9R+jLbpS
 SW7F2gVb2xbH6IVwm8FmBK09h19hlURAauJ4fS9A16ZbnBK/ugR2Ld4v8e0ZeCh7Ic
 Z57d2g4h56b1g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRWlGSWpSXmKPExsViZ8ORqPt+xcx
 kg40vBSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oy3LdOYChaKVrT+WcDawDhPqIuRi0NI4Cyj
 xJfD15ghnANMEncP9LF1MXICOXsYJb516oPYbAKaEs86FzCD2CICEhIdDW/ZQWxmAXWJ5ZN+M
 YHYwgK2EvdetoHZLAKqEqdOnQGbwyvgIdH18j1YvYSAgsSUh++ZIeKCEidnPmGBmCMhcfDFC2
 aIGkWJSx3fGCHsColZsyBmSgioSVw9t4l5AiP/LCTts5C0L2BkWsVoXpxaVJZapGtoppdUlJm
 eUZKbmJmjl1ilm6iXWqqbl19UkqFrqJdYXqyXWlysV1yZm5yTopeXWrKJERiOKcWpzDsYLy/7
 o3eIUZKDSUmU16huRrIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd4/S2cmCwkWpaanVqRl5gBjA
 yYtwcGjJMJ7ZTpQmre4IDG3ODMdInWKUZdj076uA8xCLHn5ealS4rwLlgMVCYAUZZTmwY2Axe
 klRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK890Eu4cnMK4Hb9AroCCagI6JeTgU5oiQRISX
 VwJTfZfld8NdhX0vPtw/Lgx0PFfK5z9l7+9AunbcHnE852qq1rPv2YdETqXS3X44lXXP/+M4I
 Pyr37NLxCsXDHbu7GSSDlhvYXTrznE3y9G4+We/FK5x9vuf2examvFja+f3/7WlLPsSrus2b1
 Xdz0f71t788t+2LKdCI2fDsptQDg5gVvou0TffNWeD09d32/ZWHQ2ufPI4uWCixcs7ay5FCD0
 uzf/H6HjUQnuu018mo/kfoVy63Z5cZWRc8SeSc/izpnv18MfPlAqd/8MvfctxbbOtusObl9Ff
 1HdqFvoaX1H8Yd4QZ9E7+/utN4qn4069qy/Z+KW/V4tXWMFujdmgDt3O4ccEDXuff8cdeVXMp
 sRRnJBpqMRcVJwIA1xxsl04DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-745.messagelabs.com!1671014638!94132!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4054 invoked from network); 14 Dec 2022 10:43:59 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-14.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Dec 2022 10:43:59 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id A834E1001AA
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:43:58 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 9C245100182
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:43:58 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 14 Dec 2022 10:43:57 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Dec 2022 19:44:58 +0800
Message-ID: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] lib/tst_kvercmp: Remove old distnames
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
