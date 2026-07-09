Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E91CC44501
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783587381; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=+VQACMQvxsLd7fzHzBncNqtR+Iy0YnapXSpa0vnpFLs=;
 b=Kr5rK0kHr1fBnH4XAJ/a01qauO0yneIF1UeYAxlrpONXv3z18rfH24unLDbrqDcT9IQPi
 81Pnk27A30OQOLNt9IbQSCb+W7AJlZJej5aVjcGxBMx4py914foUcDNxjw/IWuW309Rc0ML
 JvhpV3xVs0jFcqzLDnIKOqeENqnoIk8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C6F83E292D
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:56:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5F933E28D7
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 09:49:34 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF38D600650
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 09:49:33 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ccf2360620so12570755ad.3
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1783583372; x=1784188172; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWcTQjnqdZ1FBuITjeU/3FQtKem9tB+8PLI1K91110s=;
 b=as/QefClyeRaf/crzhr5fRZf8+vGNC+4nhl596stHK9O/Z2fn8s96lGAAn6h5mN6IH
 454Sq4roA+r3/P3/vmmIs2vUTenikQfSO9Otlx6BVfGiv+vTtlBQPd8/G4jH9PnjzvNS
 5Eo22RwAongJDnw6Ylwhmg0qIAEn4kuJxNNKLR3xA1JwMKEK0jZ1u/cjcy2J/S7/lpfy
 jpWkV+865cVNlfaMUN0ziwzRBG0LPKlKAe/Ut2zd3wQLPHdMnfWCXNyAXIyaTFXnjxYf
 RCpPUmB8TK0kvT4pzqmDG2vSiHfcDzallUJhl/fOG9MCia2Z9G5TsyxJrjpByT1DX1k8
 m2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783583372; x=1784188172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWcTQjnqdZ1FBuITjeU/3FQtKem9tB+8PLI1K91110s=;
 b=GLPrkVLpuz8f+35RfpXW+p+Y2AHj5HYXAyyTqrudNKy7EiNfoRtg3RSH04Uy2YF9Y2
 VbtlxrLwgvF7G0sFe55wWUuJG3uqBl528Wfc9vBZ9GK9akD8O/HNnyWoZbduKCVWJ0Ox
 qdD9bDOuP/8JsJWYR4HoZyghq6pwC0ciGln8JK9CUvPisvX/JdUlRCdIk+zjZOlHakY5
 2lORujN6Xuso93lJ97ApbQmTq1W1OjyWcjJ9iEDEPoRo+THXOhQ26qkvXAfwqX74qJK+
 J0l3n16989Mfh0N/D5B/jnJ/poje+8ztlZbX6FDwB9+Xe9oDsZfD/Sb6hKj8ER2+aFoJ
 xn0g==
X-Gm-Message-State: AOJu0YxqFACLtUuTmtYywAWFbijvbUj9pdIbzO3NUpW4x7zCUFKtMgBZ
 9BkXy/frAWLsg00CIVge2fzrx0zlRXPFOFtvGdpxq8ga8rxWfJMRvKN0lZ4PS/ZkvCtHgNLmOVe
 albVtrd2k9JX6K7dKfTrIN5p7G/SN2QgqPuEdhjpIxPe83kPVHdzd2fS4kJMhAzATT30R0ssRId
 J1JQYkH2DnXxnISePY2bdOZrvjTUjPMnOqB437pVc=
X-Gm-Gg: AfdE7cn5IzbUM0PfNi5sldTDRr0/n8xtPn53qyKvDMXvfQWb0LpTJY/ZFHOxShCKgKs
 4xpgkMHcjGU6OAL76PTXxHWEEPHr98cNiyZqAuKYMJx4Ay0ogAcYhNIpfBClBBWZx5x++NjWNFJ
 3nrcPiYqP9lFkH8DPRft9cTn5/uLY/EsTYYLcHHSkmWonmZfDpapoa+Brs+0qxGICEO2+NjNeI4
 oGm8vPm5IT1W/h3aqok9ceJjGXCNup4fCFTwx2oWuMU9rJflSe9E0FKclDi1Uum9ndYgObA+4Is
 NHsVDmlo+Q5ebQjjxKRXBowmg/8gaIXpe9d1/zy+Yrh76sEmol5nbgWbZMZ+61jkvVgaw+odA7+
 bWw1XQGI9RnO4cq98ny6tqUcF2Ir1d+4WIxV8mBiK9pAHPHCAwthe0Nn/nMS/7EyVackz5QqVJY
 b6XmNNKfTJLHcAbPm+2oTRkiSt+4Wp3pL5CHoNEhZTwRLz7Kyis+WTUg==
X-Received: by 2002:a17:903:380e:b0:2c9:c083:cd50 with SMTP id
 d9443c01a7336-2ccea36d9demr60652615ad.17.1783583372053; 
 Thu, 09 Jul 2026 00:49:32 -0700 (PDT)
Received: from LPMV6FJ9FM.cn.corp.seagroup.com ([143.92.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8d80sm39950715ad.25.2026.07.09.00.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 00:49:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 15:49:23 +0800
Message-ID: <20260709074923.73372-1-mingyu.he@shopee.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Jul 2026 10:56:00 +0200
Subject: [LTP] [PATCH] pty09: Cap RLIMIT_NOFILE-based slave PTY opens
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
From: Runli via ltp <ltp@lists.linux.it>
Reply-To: Runli <mingyu.he@shopee.com>
Cc: littleswimmingwhale@gmail.com, Runli <mingyu.he@shopee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

pty09 derives the number of slave PTY opens from RLIMIT_NOFILE. When the
limit is very large, for example 1048576, the test tries to open nearly
one million slave PTYs on the same master. That makes the workload depend
on the caller's file descriptor limit instead of the PTY behavior being
tested, and can turn a working PTY open path into a timeout-driven TBROK.

The test only needs to verify that a slave pseudo-terminal can be opened
multiple times in parallel. Cap the number of slave opens at 4096 so the
test remains representative and deterministic even when RLIMIT_NOFILE is
set unusually high.

Fixes: 20aa13dbd8a68 ("Add pty09 test")
Signed-off-by: Runli <mingyu.he@shopee.com>
---
 testcases/kernel/pty/pty09.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/pty/pty09.c b/testcases/kernel/pty/pty09.c
index f3ade2381..7eff1ad54 100644
--- a/testcases/kernel/pty/pty09.c
+++ b/testcases/kernel/pty/pty09.c
@@ -14,6 +14,8 @@
 
 static int masterfd = -1;
 
+#define MAX_SLAVE_OPENS 4096
+
 static unsigned int count_avail_pid(void)
 {
 	DIR *dir;
@@ -31,6 +33,8 @@ static unsigned int count_avail_pid(void)
 	SAFE_CLOSEDIR(dir);
 
 	max_pid_num = limit.rlim_cur - count;
+	if (max_pid_num > MAX_SLAVE_OPENS)
+		max_pid_num = MAX_SLAVE_OPENS;
 
 	tst_res(TINFO, "Available number of pids: %u", max_pid_num);
 
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
