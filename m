Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A17C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:41:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A3853C8191
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:41:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C34EF3C0761
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:41:07 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BAA51400C47
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639136466; i=@fujitsu.com;
 bh=7cMRrZv7Q/hoxvWUkj2MDjNaH6bwKkChv0RAloOHWzk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=JcIdSZ7pOUVX8cAPed/mmhVefhDZMHvqs6g07nd0kSXaXN9x98NnR82mH2QGT8LiB
 hMYymPm2tDzboMO+p9JrYgikjhJft3it7jbs0rJVLU4hP2/s9Fwt+YrDgGjHvxl0R9
 1D5wZplXTKy4IoFjvHXIU6Nh7+LF9yC2+YAMMf0EGJyDchSzw/ZmiEMbIOJMkWQcMK
 8+vVVJi+eNyzbib922MfJf8xnZOsEprLtHpz1fNZfu7N6gKeqzmKRz4o+Vz8KFM5md
 LpgA7eQQi30WUc6RltKFKfwrRvgkF7X5DArLoHYtvI418FC9lpHIbtGUlxBCxC3uiv
 uMutUREXSZbrg==
Received: from [100.115.1.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 42/CE-10124-2DC33B16;
 Fri, 10 Dec 2021 11:41:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8MxSfeizeZ
 EgxXr9S1WfN/B6MDose/3OtYAxijWzLyk/IoE1ozL39uYCpbwVcyYeIylgfEzdxcjF4eQwFlG
 iYa+Y0wQzk4miYnbjjBCOHsYJT7+XsLexcjJwSagKfGscwEziC0iICHR0fAWLM4soC6xfNIvJ
 hBbWCBU4lnPG7AaFgFViW9/DrGB2LwCHhJvd+5gBbElBBQkpjx8D1bDKeAp8bt5N1iNkECSxP
 Ndqxgh6gUlTs58wgIxX0Li4IsXzBC9ihKXOr4xQtgVErNmtTFB2GoSV89tYp7AKDgLSfssJO0
 LGJlWMVolFWWmZ5TkJmbm6BoaGOgaGprqmgBZhnqJVbqJeqmluuWpxSW6QG55sV5qcbFecWVu
 ck6KXl5qySZGYBinFLOk7mDs6/upd4hRkoNJSZRX7PemRCG+pPyUyozE4oz4otKc1OJDjDIcH
 EoSvIzWmxOFBItS01Mr0jJzgDEFk5bg4FES4d0IkuYtLkjMLc5Mh0idYlSUEud9A5IQAElklO
 bBtcHi+BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5pYFIQ4snMK4Gb/gpoMRPQYueW9SC
 LSxIRUlINTFaqzwtV6gLXH/2Q+lHS04yX56ejbhKb8Np1FZ7GovHvzpnttYpeM/9USNvliA35
 2YdCDVKfys6f8Unv34dzYjtOi/xKYrz26EKLn+KyQ7OmbXzb1bruneaTl90f1l8z/13czmtmG
 bPletGLrAvT/h/ckaT43uteZ/gN20M98TEnprBazm4NzuZ8r3v29Jb7v0Vm/l2VU7OqJiHTzv
 RwuQDXzAWtXcvXfp60//TEZPEjPxq+Kku/33F+jdKm+GOxX6ZteivtPNm93l2tSjb935/c56y
 /vTSvHWHJ1Hd0NTr+xI3hRs4zvau7YlT0ykPNi6ZPejG/O2DF3jNaH2ak63mzdmyf2mIiY1Wg
 0iuveEOJpTgj0VCLuag4EQBPc68vXgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-585.messagelabs.com!1639136465!67236!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14072 invoked from network); 10 Dec 2021 11:41:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-2.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Dec 2021 11:41:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3E843100441
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:41:05 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 30069100353
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:41:05 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 10 Dec 2021 11:40:29 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 10 Dec 2021 19:40:47 +0800
Message-ID: <1639136448-2148-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YbJ3SKsLu7iNoqZc@pevik>
 <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] zram/zram_lib.sh: Skip test if zram module can
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
 testcases/kernel/device-drivers/zram/zram_lib.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index fe9c915c3..4fed1f17c 100755
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
@@ -47,6 +52,11 @@ zram_load()
 		tst_brk TBROK "dev_num must be > 0"
 	fi
 
+	lsmod | grep -q '^zram'
+	if [ $? -eq 0 ]; then
+		 rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
+	fi
+
 	tst_set_timeout $((dev_num*450))
 
 	tst_res TINFO "create '$dev_num' zram device(s)"
@@ -54,10 +64,12 @@ zram_load()
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
