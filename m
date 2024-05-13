Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3283DC25B75
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 20:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715633286; h=mime-version :
 message-id : to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=zWb23Qvb0A2IcXWp0Hp5qDL4qYFPX1wv68rDDnw3J48=;
 b=MidirozLRKpeGLuyuq/pxPQ1LHuxPZYGDgg3fSMWiPsty5i1ur+IUFUgEHowwFjxLWrAa
 jVRFDg8mrWpUBoMgrm0hK7tmCEP6GSEAvIS6LBQ4PQ8jdQoQiij3im+8/PCLDZwGf2udQkz
 Y/DXvz6WnmJpAlCnszTcS0SyUbQkl1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01B2E3CF200
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 22:48:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20BB53C893F
 for <ltp@lists.linux.it>; Mon, 13 May 2024 22:47:44 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=web.de
 (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=wine.dev@web.de;
 receiver=lists.linux.it)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D816B600BE3
 for <ltp@lists.linux.it>; Mon, 13 May 2024 22:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1715633259; x=1716238059; i=wine.dev@web.de;
 bh=YMD28K5CT7C/+Zxl2jjMsDufS5aPNBYlcInpCzRnlYk=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ksP938a0NetpltaAiK9fBg9cQ767YawcS9XhnsofI5HoXYjAgRdgnCtaiSOWPGEf
 +P71j76JBibYlefZZLzlbhiKagKtPm1RjAMxMlbCayr/d4w6bVMa1QfdJFyXCiBY0
 5EsacngH17Wv0qGd4+OgC2NIQrr6a+MN4rP+9W0fSagBq5yE5RxZknlJv94blpQqN
 QU3xsWT7TQaVHJ6K6HrfIf/HxkhmbUShoSAZbxhHTfs9TKSdopz3otzi9ddMYVo/Z
 dPPXKX73pPuOEk8I0n6bZnck+XaKLPCyYWZ77NLQhuXvMAJ+l1sIJvCj5RWyKCHB+
 kHMOMr3hfsbl8pt6Mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [84.188.37.204] ([84.188.37.204]) by web-mail.web.de
 (3c-app-webde-bap30.server.lan [172.19.172.30]) (via HTTP); Mon, 13 May
 2024 22:47:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-74891c6d-f969-45be-ab73-89e340d7f6d3-1715633259373@3c-app-webde-bap30>
To: LTP <ltp@lists.linux.it>
Date: Mon, 13 May 2024 22:47:39 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:5mW0r0SuIQZYr8sTXsAM+0mupybWIiGow4Wylz1DL3PxFauuQG52SKxGh2tnhtx1QiIpe
 SnfpmWD4PkPRPCFPma5iKDtgjaGeoJaRQjbJmo73t5tsoc81YM6HvvAl37pgPYaB7koLNzaU2/nv
 6eMvCaX5sxncIHQ85i/GbzeGTr3nMPR117XbHj0ZtW/TsyuH+WOOLS/yh5DOQYzJ5cK56bvJ8tzg
 PmaZ5yGd/Hsap2ZKSSs0sbnGx6/3sfH35H11Khv+OHspUsnxFgItLNLH9Abw0/+vn9z2Yxm+ObVw
 EA=
UI-OutboundReport: notjunk:1;M01:P0:un8mtfzJFp8=;VW1cqjjUyopitKEoTvCS/OyR/2H
 YVxffH4HIGD3Q5CIBLyhKpu4vjyekwNU0nmjfLV/aXj+6HrX8WncfhwLRjhd5yNCKSkxzWwcL
 yvmlYqbT0HQOFAew1lVBdiEuTDQRcwGY1iE5UKmZvJA2Kn4woYqYwBHq5STHAk7zBMO10yq/K
 f9DGbH0bW1eEq0pmc3gWiJk18Y2KMvmfFCf50sccBDt61QBaoo1VG3lp+8OdP/inYPptnBtiL
 LTuQt2Ig936OgT45j/IAx1Ow+7AxQAjgsfu5p4Gvwlpx7dL2opDaZYjRhAYouhC+c6Mh1nTZm
 YbP5SpiOZeRZ7cAUwiGxI2gLeXtxUfKZKVDv0ySRVOJ034BqCosHwF/OcTprRZUPORKb3qDoS
 kTJtYYx0SRFtfvByFHnzDeg8ba24X+L/fyJ9JM2Ux5P4+Yhqn0EVHOA4hVve1UPLpwS1SjEWo
 cPn0lCaby6z07t7/LeeQY6DkZZuBijiEVcJTN4LcNvxbqnx2ifuXlPGuo/7tMpLTgeKlDCika
 eTf0UBCIyL4lDco9jR5lKbMXiCG+gGP40bJIi7zjEl0LUoDRVFbwmD9XC2+2dlpH4Xt/N7Dwq
 +V1PyOaWTMQNskogFVfHfkN67tUIf1gBZVEQySlnjpoGeXwqtpE0XHIUaAVXfBxXWQtdo89G5
 69Nui9yL6pSVsbfZyJjySzuBcpbSnrSokIeS5w/kgL4QmdxNbMRPuwQeXOVxWmM=
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open_posix_testsuite: Replace old -W commandline
 argument
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
From: Detlef Riekenberg via ltp <ltp@lists.linux.it>
Reply-To: Detlef Riekenberg <wine.dev@web.de>
Cc: Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The Open Posix testsuite calls the compiler with the old
gcc commandline argument "-W", but that breaks other compiler

This patch renames the old "-W" to "-Wextra" (as suggested by LTP mailing list members)

Reference:
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

gcc 3.4 renamed "-W" to "-Wextra" in 2004:
https://gcc.gnu.org/gcc-3.4/changes.html

--
Regards ... Detlef

Signed-off-by: Detlef Riekenberg <wine.dev@web.de>
---
 testcases/open_posix_testsuite/include/mk/config.mk.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/include/mk/config.mk.in b/testcases/open_posix_testsuite/include/mk/config.mk.in
index c9a4b5c5a..20422e0f1 100644
--- a/testcases/open_posix_testsuite/include/mk/config.mk.in
+++ b/testcases/open_posix_testsuite/include/mk/config.mk.in
@@ -14,4 +14,4 @@ testdir_rel := @testdir@
 testdir     := ${prefix}/${testdir_rel}
 testdir_bin := ${testdir}/bin

-CFLAGS  += -std=c99 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -W -Wall
+CFLAGS  += -std=c99 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -Wall -Wextra
--
2.40.1



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
