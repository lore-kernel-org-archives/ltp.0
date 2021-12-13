Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21054C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 05:45:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8B813C88C5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 06:45:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E802E3C87C8
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 06:44:40 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C40E100061D
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 06:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639374278; i=@fujitsu.com;
 bh=9xQr6p2zrBP7zLanA6gT06FdkzkUB9XsHZh5eAp4dEU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=iSWlQqk+zDlp9llAfJlcB4UQzEmMds3PJpqhi0EgibrKGrlK7QazpNuTSk9UmRPmb
 fWFVKqHOuqELZJ553Ql0tj4Z/P8qqYZHn5c/9OlTdW1IpFzRedcHMmzqNdx+74bUHv
 LP9z1DCM3hbMczeexBDCQW3ZzBq5lqBQKEv0Hc7GfJpwUK8wWVMA7xG4oTYHvHVbEd
 lXGUuUYYp3I4LmzL81XCxj9cSiH/wt55byj12Jr20y3HhlWJyEzxAk7fa/xLO45Nmr
 Z0PI+2D9IfFPAttbkrXODd0RwhkwvOLRP0jxqISPb+En+E9SOy3vx1pVJ62bQc18iW
 ZNFZsjVEiL3iA==
Received: from [100.115.1.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 57/61-30341-5CDD6B16;
 Mon, 13 Dec 2021 05:44:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8MxSffo3W2
 JBj8alSxWfN/B6MDose/3OtYAxijWzLyk/IoE1owXEyeyFsziq1g+4zB7A+MH7i5GLg4hgbOM
 EqvPtrFAODuZJD4uvMIO4exhlLjx7y1TFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX
 2A1wgKhEh2rd7KC2CwCqhJX768Cqufg4BXwlPiwxAwkLCGgIDHl4XuwMZwCXhJn1z0GaxUSSJ
 Lo+7OUBcTmFRCUODnzCQvEeAmJgy9eMEP0Kkpc6vjGCGFXSMya1cYEYatJXD23iXkCo+AsJO2
 zkLQvYGRaxWiVVJSZnlGSm5iZo2toYKBraGiqCySNjPUSq3QT9VJLdctTi0t0DfUSy4v1UouL
 9Yorc5NzUvTyUks2MQKDOKWYoXoH4//en3qHGCU5mJREeb8xbk0U4kvKT6nMSCzOiC8qzUktP
 sQow8GhJMHbcmtbopBgUWp6akVaZg4womDSEhw8SiK8jMCoEuItLkjMLc5Mh0idYlSUEuc9eg
 coIQCSyCjNg2uDRfElRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK800Cm8GTmlcBNfwW0mAl
 kceVmkMUliQgpqQamOb5HFyYUuB+ZfLDE549v8313k51P/68TXM3bVuwRo7PsTJ8Uy4dnWzcV
 RSx5EhLbHdSUw5DMeP32uxfncttOnf3yZZlMdVOm4wxfrsSJN2+eupfiwCY5/+p8Xl7FvYrLn
 OzWfV2voXrb+vqvY5fKUxmNnt/rMplvru09++1r6fmLi+QusvU1djz5avW7XdpNX1Ig4mLgFZ
 nmlbnvj3yW8jcp6/RimtkbIGZ1Wvu8zKTrb60UU83Kd7PtKr5T8Jtf+OC9RffjZjOvPy8/Y3n
 is9ubLp106VqcMDXiS+3UDNmjgW8PiCQ3md/XLL+XqLxq88qz5+YERinV7G3a3Nt48SinkZHN
 r22Sp47xPXlZrcRSnJFoqMVcVJwIAGdael1dAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-585.messagelabs.com!1639374277!173691!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32614 invoked from network); 13 Dec 2021 05:44:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-14.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 05:44:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 212B51000FC
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 05:44:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1411E1000EE
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 05:44:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 05:44:23 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 13:44:20 +0800
Message-ID: <1639374260-22887-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639374260-22887-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YbNH1J8E3nzH15Cu@yuki>
 <1639374260-22887-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
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

If zram-generator package is installed and works, then we can not
remove zram module because zram swap is being used. We can also use zramstart
command or similar shell script(use zramctl,mkswap,swapon) to do this.

Since zram01.sh and zram02.sh needs to rmmod and modprobe, they can't work well
if zram module can't be removed. So skip it.

Fixes: #888
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index fe9c915c3..26f19ec02 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -5,6 +5,7 @@
 
 dev_makeswap=-1
 dev_mounted=-1
+dev_zram_load=-1
 
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
@@ -17,6 +18,10 @@ zram_cleanup()
 {
 	local i
 
+	if [ $dev_zram_load -le 0 ]; then
+		return
+	fi
+
 	for i in $(seq 0 $dev_makeswap); do
 		swapoff /dev/zram$i
 	done
@@ -47,6 +52,10 @@ zram_load()
 		tst_brk TBROK "dev_num must be > 0"
 	fi
 
+	if grep -q '^zram' /proc/modules; then
+		 rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
+	fi
+
 	tst_set_timeout $((dev_num*450))
 
 	tst_res TINFO "create '$dev_num' zram device(s)"
@@ -54,10 +63,12 @@ zram_load()
 	modprobe zram num_devices=$dev_num || \
 		tst_brk TBROK "failed to insert zram module"
 
+	dev_zram_load=1
 	dev_num_created=$(ls /dev/zram* | wc -w)
 
 	if [ "$dev_num_created" -ne "$dev_num" ]; then
-		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
+		tst_brk TFAIL "expected num of devices $dev_num, but created"\
+				"$dev_num_created"
 	fi
 
 	tst_res TPASS "all zram devices successfully created"
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
