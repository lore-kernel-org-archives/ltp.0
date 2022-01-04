Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B8C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 06:57:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FA8E3C90B7
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 07:57:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CF6E3C1D3C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 07:57:19 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B22C060072B
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 07:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641279438; i=@fujitsu.com;
 bh=xXS6wnhzMNkJ5S6TNTJOlhvCNUOnWPB2QdM8ekNKy+o=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=O/4Md/+foBUmGIbsTlQJ0hjNPFrrI4a1nV91cMya1zeH694MHgo9ChlTY95KDKhPe
 I4vYxHPkNU6xCfP54mLUTAOg5UTJuOF8MeJEaEmKm+H/bvexNQfMYaWpkKFplbv7Bx
 nWJF8zSTfe9w+cmRb/sMculShuMorVYVWdJsaaTXekcfyIRTmRtaP6yDCQfxlFvin2
 tbQAEfO2lsMvm6ohHghZfO2+AKEvbMnah7IEwlL+f3Dp+3yeZ2v5HtZaXSu7PFj+bc
 xhh25l6QuTDpME1McyQjQq20NQmEBdfTm3eX6dH4t1Bqz0LEzod9ryAZRcDWy+Lpdk
 F3V/ax5VMcQew==
Received: from [100.115.70.228] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id 67/8D-06990-DCFE3D16;
 Tue, 04 Jan 2022 06:57:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8MxSffs+8u
 JBie/yFms+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBmndl5iLvjEU/Fk7jamBsYG7i5GLg4hgbOM
 Esf39DJBODuZJD5M284C4exmlNj7+hlQhpODTUBT4lnnAmYQW0RAQqKj4S07iM0soC6xfNIvs
 BphAUeJ9Rcfs4LYLAIqEi+fLAeL8wp4SFz49xKsXkJAQWLKw/dAczg4OAU8Jc5tFQMJCwGV9G
 yZzgZRLihxcuYTFojxEhIHX7xghmhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/
 AyLSK0S6pKDM9oyQ3MTNH19DAQNfQ0FTX3FDX0NJAL7FKN1EvtVQ3OTWvpCgRKK2XWF6sl1pc
 rFdcmZuck6KXl1qyiREYzCnF7vt2ML7o+6l3iFGSg0lJlDfj5OVEIb6k/JTKjMTijPii0pzU4
 kOMMhwcShK8Fa+BcoJFqempFWmZOcDIgklLcPAoifD+fAeU5i0uSMwtzkyHSJ1i1OVoebRkEb
 MQS15+XqqUOG8dSJEASFFGaR7cCFiUX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzNsPMoU
 nM68EbtMroCOYgI44Jwd2REkiQkqqgclvC+MKz0uLInaaiwcHvuUMMjhj/uncikK2b38DT7fe
 YeUJmVGhuSru7fbAV6s+ZCvI1GV1CObI/bpVUaEgqF6/6mqoYZO6bd/9tX6mt87+vaxxIPDrz
 HNfnpyblLXo+eY5SeqaVdOKFv5zbhB8endX7Jakvj+Od4x/SBYmJvkEOb30DHrLJvtK6tRbvZ
 3sL++eWPzoZm2j2AKO1aaX56qfCD+zpmW1VcbOn9N+eb9/d0J1ekzlxMN7TAW2pkddCPH1FI2
 cyzwvMUjm9q1Z182LkyofmEzXu6QdJegeO//Kwp5Cu/Ot3HdcdsbH6nHz3i+f4PHM9JXH48m+
 fGXrGz225wus9K7dc075jbXWS0UlluKMREMt5qLiRABbSGkybQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-532.messagelabs.com!1641279437!56490!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19932 invoked from network); 4 Jan 2022 06:57:17 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-16.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Jan 2022 06:57:17 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 0BD7A100445
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 06:57:17 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id F2574100344
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 06:57:16 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 06:57:14 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Jan 2022 14:57:19 +0800
Message-ID: <1641279439-2421-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] sysctl/sysctl02.sh: Use kconfig shell api
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
