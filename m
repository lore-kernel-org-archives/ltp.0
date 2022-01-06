Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E3CC433EF
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB9603C909D
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:26:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EFB53C03F6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:38 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB085200BDA
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641461135; i=@fujitsu.com;
 bh=xXS6wnhzMNkJ5S6TNTJOlhvCNUOnWPB2QdM8ekNKy+o=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=qcrXFUct3YIZaosenEdKmj79yYqMEGBi9gWx7roOCMf8o5ndCT8Y296E9QjhcdQpD
 OL6ScPKWbYO/RFULH9/ht5lf6MNIaKI6it3unEeUkIka/Cu7fdMrONCZ2YOV1zPpf9
 mLNoiRl/YCDhP+4XWRLnoilOd3sDft8hie7f6zOXMXUQ2b35XIoK86YIAEXuurOqOL
 VCHAwtAV6aKlzUFz9IhUV1PLY3XZ2oUi7506FSfTqZ8issATBtpSH9/RlIKoOL5BM3
 08d0qtd17Mbube+md69d5WUos1xaLp1os+ep6o/fPR8ND5YnqX3R4H+u/O5hZt7FPS
 2cz7bLPaWsYfg==
Received: from [100.115.6.48] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 03/69-10124-F85B6D16;
 Thu, 06 Jan 2022 09:25:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8ORqNu/9Vq
 iwf8DEhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8apnZeYCz7xVDyZu42pgbGBu4uRi0NI4Cyj
 xJRDj9ghnJ1MEtuaZjBCOLsZJT41TmLuYuTkYBPQlHjWuQDMFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFnCUeLTqEVgNi4CKxNRtzSwgNq+Ah0TLjRdg9RICChJTHr4HquHg4BTwlFh+SgfEFBJIkv
 hzSx2iWlDi5MwnLBDTJSQOvnjBDNGpKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmMgrOQtM9C0r6
 AkWkVo1VSUWZ6RkluYmaOrqGBga6hoamuqa6RqaleYpVuol5qqW55anGJrqFeYnmxXmpxsV5x
 ZW5yTopeXmrJJkZgCKcUs/7fwdjd91PvEKMkB5OSKG+X1rVEIb6k/JTKjMTijPii0pzU4kOMM
 hwcShK89puAcoJFqempFWmZOcB4gklLcPAoifD+2giU5i0uSMwtzkyHSJ1i1OVoebRkEbMQS1
 5+XqqUOO+ELUBFAiBFGaV5cCNgsX2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvHMgUnsy
 8ErhNr4COYAI64pzcZZAjShIRUlINTIk/nYNdC9a8rXJS79PccF2ia93qA48XOopKh264dT3V
 eandx6mPSycrTVq6TevsW8U1i3jyv+urTW5fdP2O9+Lfe+YLZDIfcrphyzxpZwZb3C7WyVvfx
 LTPL3y9w/nNwf0d0pbsvU0xWmt8Hy7JOvxt2V65mIqKvKotV3OYbyXVKKZZr1nzzd94i4bJGr
 crKTNaahyyn7RytjLn77XKX1Z1feGz1Un6Bds3s3Oq8m84/6HA4ln9Y+8ZgtH7K32lzeuyzuS
 9z9i5qmB6V80pXwGR8n7GNa/Puggfkd57a960rWdUGd486/W8qyuquSLx29tXUx7Pm3s+7PP+
 DIX7HofNmt3eZNyTyzCdKXNbYrsSS3FGoqEWc1FxIgAGnf99aAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1641461135!1482!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22863 invoked from network); 6 Jan 2022 09:25:35 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Jan 2022 09:25:35 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id E5B981001AA
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BF2E71001A2
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:34 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 09:25:25 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Jan 2022 17:25:21 +0800
Message-ID: <1641461121-2212-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/commands/sysctl/sysctl02.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/testcases/commands/sysctl/sysctl02.sh b/testcases/commands/sysctl/sysctl02.sh
index 3964a9829..1c444268a 100755
--- a/testcases/commands/sysctl/sysctl02.sh
+++ b/testcases/commands/sysctl/sysctl02.sh
@@ -20,15 +20,14 @@ TST_CLEANUP=cleanup
 TST_CNT=4
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl"
+TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y"
 sys_name="fs.file-max"
 sys_file="/proc/sys/fs/file-max"
-syms_file="/proc/kallsyms"
 
 . tst_test.sh
 
 setup()
 {
-	[ ! -f "$sys_file" ] && tst_brk TCONF "$sys_file not enabled"
 	orig_value=$(cat "$sys_file")
 }
 
@@ -61,17 +60,15 @@ sysctl_test_overflow()
 
 sysctl_test_zero()
 {
-	[ ! -f "$syms_file" ] && tst_brk TCONF "$syms_file not enabled"
+	tst_check_kconfigs "CONFIG_KALLSYMS=y" "CONFIG_KALLSYMS_ALL=y" "CONFIG_KASAN=y" \
+		|| tst_brk TCONF "kconfig doesn't meet test's requirement!"
+
 	ROD sysctl -w -q $sys_name=0
 
-	if grep -q kasan_report $syms_file; then
-		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
-			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
-		else
-			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
-		fi
+	if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
+		tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
 	else
-		tst_res TCONF "kernel doesn't support KASAN"
+		tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
 	fi
 }
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
