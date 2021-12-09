Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B5DC433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 07:43:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7DA3C7729
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 08:43:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B065C3C585E
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 08:43:40 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D975200DF3
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 08:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639035818; i=@fujitsu.com;
 bh=6/Ab0AIDjOphUpXxMdVwVTEdjNTt7ZSWCfdTMKhkf4E=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=a5Tc7TS9m4HHwVtbjNwEeL8jBT4tcUWEN+jc46YKb53x7a1gqwQLNeDaXfJCjk+yV
 +FScYwURPcFx+C/WLXcU5yig0aQp9VRzz63fLAKAmYHb7S6YOvYtZ/5MTGsfBom2O1
 mm6L8D86KTuWRJsKQTxO44z2iLItGxY5t+SITKc3vb9lyraR9I+xxoxExTRyPwCOCx
 YE6JTq+wL/ptyNCEPUdZ1kgDf4HXSH3Lk7cTdT+kQFXx95GcelwLsBX64/jEBFBxcP
 x01992UW368IHruQf6+q7xWYgWAsBKvK07HTp19rfyWCliqal6Y6JiP0GQf54MVKzO
 9bur+aUprtGeA==
Received: from [100.115.0.27] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 54/B3-30341-AA3B1B16;
 Thu, 09 Dec 2021 07:43:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8MxSXfl5o2
 JBlf/aFus+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBk//81jKbjOVfHszyKWBsY+zi5GLg4hgbOM
 Ej87bzNDODuZJN6/mscK4exmlPg/YR5TFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX
 2A1wgJBEoevHwerYRFQkdjTfQashlfAQ6J/4l5GEFtCQEFiysP3YDWcAp4STSvOgvUKAdUsWr
 eHEaJeUOLkzCcsEPMlJA6+eMEM0asocanjG9ScColZs9qYIGw1iavnNjFPYBSchaR9FpL2BYx
 Mqxitkooy0zNKchMzc3QNDQx0DQ1NdQ11jQyM9RKrdBP1Ukt1y1OLS3QN9RLLi/VSi4v1iitz
 k3NS9PJSSzYxAsM4pZjx9A7GTX0/9Q4xSnIwKYny3li8MVGILyk/pTIjsTgjvqg0J7X4EKMMB
 4eSBG//RqCcYFFqempFWmYOMKZg0hIcPEoivJKbgNK8xQWJucWZ6RCpU4yKUuK8LiAJAZBERm
 keXBssji8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuZ1AJnCk5lXAjf9FdBiJqDFzi3rQRa
 XJCKkpBqYku91KFdM4HN67cWestgnXmbVog3xNWUxKrcu3nFy51L9biUeudxeZMHm6r/PV7Bn
 LitaHf7lgLnub52ACdfi+d7s7w9kffd8gvmH957xyS/mflrqGm3x79CCJL8TaS23t1dF3m25a
 We2asIfs2+XXxaHX22UeCixvvv9jkXlx1paMrwE3p+xspxzTfdRiXbqru932zjXWnX+3G1/Xe
 WoSGtdhR/rZlEXxT/rvIsTK/Yy5vlXya3YuPZQ0sv1Yfsq5k34GT/FfZp05ym1/UvsuoK+Pg7
 wTjHSmlykdlfY2S3BSih21tmkNVc3FAXYLrz7XPjqHh7lAC2FCoOX7x+KsU7gMZS5cGnjngWi
 t4/tVGIpzkg01GIuKk4EAP0oB0ReAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1639035817!45762!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13766 invoked from network); 9 Dec 2021 07:43:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Dec 2021 07:43:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 4E4F810045F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 07:43:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 4133B100359
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 07:43:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 9 Dec 2021 07:43:22 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 9 Dec 2021 15:43:42 +0800
Message-ID: <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
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
 testcases/kernel/device-drivers/zram/zram_lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index fe9c915c3..ad5b6e216 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -49,6 +49,8 @@ zram_load()
 
 	tst_set_timeout $((dev_num*450))
 
+	rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
+
 	tst_res TINFO "create '$dev_num' zram device(s)"
 
 	modprobe zram num_devices=$dev_num || \
@@ -57,7 +59,8 @@ zram_load()
 	dev_num_created=$(ls /dev/zram* | wc -w)
 
 	if [ "$dev_num_created" -ne "$dev_num" ]; then
-		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
+		tst_brk FAIL "num of devices expected $dev_num, but created"\
+				"$dev_num_created"
 	fi
 
 	tst_res TPASS "all zram devices successfully created"
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
