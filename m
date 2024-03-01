Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6D2C5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709274465; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=raGUMCE14pvhVG2ATJ5Ds4oXPhnO7akgf8zSt7y2z14=;
 b=pKO62s3NXqtEJYdpB+3yYOXuubHTP3QBMJLZb8xJXBap91vdG5NKEvBKZT6qY6yhR3ih1
 uUd3LWuF3BikDVOTED0cZ5Cy105q/3JB2C+AkEml2UGbhswWCibat8pnUiFXsbix75nwGpR
 YZoWHOroo6fOxASMVv6wdy5mSp5e1Zg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D5963CECF4
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 07:27:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE05E3CECF2
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 07:27:24 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03640100CD1D
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 07:27:23 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412c227c80bso7624785e9.1
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 22:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709274443; x=1709879243; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sbGMS+pTExGwVRCc3Ghj+3vF04CotY8wVBMN1cYm8QQ=;
 b=f/ggDBBVsZNmuRa4e2Wxo2R9qXSpWHHmbO9UyrOeDNk01HRHvCW9D/6s5uWd3BIV+A
 MEmZRy5lLx59RCdAhIRKmPA5id90adLM576JfP6S3o7bwIqK/L3CZcRYrIJovszcQT6s
 5CJYEJQdpB9kvs4v0ticqbrCmjEVQewOelvmyoyLaiBk2mhPmTwLeg7efWK+iLu+/GFU
 244Xiuh1oydSrgKGxsNBD6SashDQnhtlcPxoGb9Q4sGSYPDVa2SWf4tLyE00WPXqtCX3
 yqu4AaSjKBx1fybTEj8Jlo6r1GAHlVuiRB8ImPCAMZtSSRQl/ApLMJp+6MStM1Rdw4aI
 E5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709274443; x=1709879243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbGMS+pTExGwVRCc3Ghj+3vF04CotY8wVBMN1cYm8QQ=;
 b=WhRlsq41DtZvtVNN1UR+Q9U3hq8EotMX+ibLxQbM94ppXskCYxYGM0qME5Z4Ae40e+
 WiNLTlvbuX1hlpCTK2qLM1LwtkDMRuH7NMXK4o2zgSXhqanBwJhuItIKgp0Dp0g5xqSC
 9IQo2N4DFEffSjzCL/pC8YY1+Z44G5LvOTvN42JqhJOH5qmt6Z/BkOODKF6C256remvJ
 uVljtyK7QfCb6JLa2lZdp0opHKu5IAGRAQPFSPWKe8SGB0FFdlCwSbCxQbfGJAonATpK
 qiNZMC2dTsfs3JvQIjtZjYaHSzHPZrrtqWsRDSFZB/Q7Rptl7GyPNjA69Osj26MZY/Sw
 l4hw==
X-Gm-Message-State: AOJu0YxNS1c2+4VPR1iNmqr2GfcdkZps3nv5BxUTVXbetTB66r+9pJzr
 Xli7q48BJlze7QYQaK96bwnhOrLf7rklo6YB/YXTk5+dkbf5cD0Hfczud0VRUUPrsDFg5vXUY2w
 =
X-Google-Smtp-Source: AGHT+IEic6SV1WANMwsAZ8OdhfM9aDbzgBmhu+aT3EmM1ZPWtudnEwVTSl67l8xrDo9TnyQqrH4xYA==
X-Received: by 2002:a05:600c:4e92:b0:412:c827:7a09 with SMTP id
 f18-20020a05600c4e9200b00412c8277a09mr409908wmq.11.1709274442683; 
 Thu, 29 Feb 2024 22:27:22 -0800 (PST)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 ay29-20020a05600c1e1d00b00412bb8101bbsm4333623wmb.43.2024.02.29.22.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 22:27:22 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  1 Mar 2024 01:27:16 -0500
Message-Id: <20240301062716.3023-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I encounter a dead loop on following code in our test on ppc64 machine:
while ((c = fgetc(fp)) != EOF)

I think "/proc/swaps" is not normal file and can not get EOF in some situation,
so i use fgets a line and caculate swap dev number.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 libs/libltpswap/libswap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index c8cbb8ea1..6924066b7 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -13,6 +13,7 @@
 
 #define TST_NO_DEFAULT_MAIN
 #define DEFAULT_MAX_SWAPFILE 32
+#define MAX_LINE_LEN 256
 
 #include "tst_test.h"
 #include "libswap.h"
@@ -274,16 +275,17 @@ int tst_max_swapfiles(void)
 int tst_count_swaps(void)
 {
 	FILE *fp;
-	int used = -1;
-	char c;
+	int used = 0;
 
 	fp = SAFE_FOPEN("/proc/swaps", "r");
 	if (fp == NULL)
 		return -1;
 
-	while ((c = fgetc(fp)) != EOF) {
-		if (c == '\n')
+	char line[MAX_LINE_LEN];
+	while (fgets(line, MAX_LINE_LEN, fp) != NULL) {
+		if (strstr(line, "/dev/") != NULL) {
 			used++;
+		}
 	}
 
 	SAFE_FCLOSE(fp);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
