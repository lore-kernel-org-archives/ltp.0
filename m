Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20784CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755835579; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=k27Lj96FnVOdSqyqtyPslQXVFdolNB5DAmqzU8p7G2o=;
 b=E0u6rmSHYn2UuVNkRmcRFnOnxiA+uceA6OIrG3HqwbSEogETrXtn1793Pl+xCnoRqlQjX
 FB25DLZFPDHG57ycuZVTK+kuBwjYsGXfNC8phi61ofWT+5FOUQDhYT+qzBS+LpvaPyrCI+t
 +JVtQEZfbpsWu5aIZ/9V+AVN6o7ETl4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1A603CCC74
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 06:06:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D1543CCBCC
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 06:05:12 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 77E622000D2
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 06:05:12 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so238287466b.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 21:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755835511; x=1756440311; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsmvjpybWkTqEQWvuWkWayohcsSLUjuou6QuyouUE/Q=;
 b=faX4adkVgnIhASN8adgh+Hu130jakAit4U6Pr+sCsLsm5rX2G5CwAnT86b3cqQDQvU
 hAEerwp7ss1uLz0JaRpTd9bn5aBSWQ5or13Gey2aNORkxJ/6GwELYRxV6v/z8vuuuIMe
 nJkCrPLo0wDwUYHRMZsJg+JujSTz+O9At4HUEywvSRDLCt83+0jqMPif0lFw+F1a3WL/
 Fs3Uwd9qknX85J63Ew54SOxfskEYhRSxrBmEdXRrzgY++D+eyHuVtgUgVxrHXnRQs3rg
 VDRNzB/HYmqpt9NkE7Z4rzUYu0dYczQ2ojUPn7Hoiw2ctPvoSI/2nIPDb/eQfmb03zAu
 K/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755835511; x=1756440311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsmvjpybWkTqEQWvuWkWayohcsSLUjuou6QuyouUE/Q=;
 b=tSEdmqGR73sciQ/4q4delzhe8CymH/dfgN6vx7Gg1Jox9EAzWIiUjmqJ0weNxx1V9m
 nyUYBlA0kojDq2rNZvuA7ItCxHGYC73cmwcxnsKQd4DQv7ArjH/9OPUmDWv/sN4EXsre
 yDLxUdJxSnvS3AceloFZq5BstJQM4FPQBrv79fN08MXtk6mH3T/uBMFJK3Nf5840QpcX
 LW+Dw1IHBEVH97w9TJaPxmUAcvWDnY6PtZR8f6Rx5k1aoFn9ZTstPD4RK5IBOQ4PeEGV
 rtEQAVAusidUjKXH0xP3Xrpz0aocEhi4H+trMbByW1abU+X7mQWP2LlJmn4hbP3ejfC/
 Hchg==
X-Gm-Message-State: AOJu0YxGLNwNvsPEAEeUbmWsE7wyB2YnnKuXCHHeJfp2ywC/CAzYWxth
 IY/StIWqFu/5iKFSmjQkvDTB8/xP/zHB07dEt3Lx8M1WyPnXDqFyVEBxFQsFiQdwenS/SFFQ+mg
 CkoI=
X-Gm-Gg: ASbGnctOV1q48UikX1EET3FWmCnoJnRzIoaj/GqqENVcayuTSJHtOR0BbtNwMPkVUEf
 dG5JeKM7VVR4/J0A5RJ00CtDfaUIRFYR7GJQyUflKLM9eTzIvPWuv3l+Vw3KWFViLzPfCf8dgjj
 HlVW5FBGIC6qfYMSZUqal5+KuPCXHn6gOkyYQvc/yhsuZvrqmNTp1/gjQOu9Dt4y2bGG0VJEa/v
 SJM8l5BKtWqrrVz/Q8kqo8AhO5TmdTjA2vqeJKHw6R3ZtAMLrB/N/KCjWCfI26WMk7AdWJ+IvoI
 M/AKWeHAP0RpS5MPo4S4Hd75BPmxSOXLm+9r8Dh/dd6zbAN3gSkk/BD7v5WRkADg2XYlmh3Ksej
 lMIhD2GBxb401czhZrAfPTEx96jjPx4KUWzOcBxlv5dk=
X-Google-Smtp-Source: AGHT+IHRM6C177PYpZ0n4xNqnMBJ7b3xkw82ft8ZZZdko7Ef4irY9XoBZ80Er6+PYo5K+H0cDycpuw==
X-Received: by 2002:a17:907:2d07:b0:af9:4075:4ea5 with SMTP id
 a640c23a62f3a-afe28f5ba80mr139400766b.25.1755835511558; 
 Thu, 21 Aug 2025 21:05:11 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded2bacd2sm522745766b.24.2025.08.21.21.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 21:05:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 04:03:59 +0000
Message-ID: <20250822040501.28640-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822040501.28640-1-wegao@suse.com>
References: <20250822034215.28533-1-wegao@suse.com>
 <20250822040501.28640-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] fspick01.c: Check mount point was really
 remounted read only
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

Fixes: #1171
The fspick01 test does not test if FSCONFIG_CMD_RECONFIGURE really
reconfigures the mount point, e.g. if the mount point was really
remounted read only.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/fspick/fspick01.c | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d03cacd3d..8cb2d3669 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -6,6 +6,7 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
 
 #define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
@@ -24,6 +25,12 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	int fspick_fd;
+	char abspath[PATH_MAX];
+	char *tmpdir = tst_tmpdir_path();
+
+	snprintf(abspath, sizeof(abspath), "%s/%s", tmpdir, MNTPOINT);
+
+	TST_EXP_VAL(tst_is_mounted_rw(abspath), 1);
 
 	TEST(fspick_fd = fspick(AT_FDCWD, MNTPOINT, tc->flags));
 	if (fspick_fd == -1) {
@@ -49,8 +56,22 @@ static void run(unsigned int n)
 		goto out;
 	}
 
-	tst_res(TPASS, "%s: fspick() passed", tc->name);
+	TST_EXP_VAL(tst_is_mounted_ro(abspath), 1);
+
+	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
+		goto out;
+	}
 
+	TEST(fsconfig(fspick_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
+		goto out;
+	}
+
+	TST_EXP_VAL(tst_is_mounted_rw(abspath), 1);
+	tst_res(TPASS, "%s: fspick() passed", tc->name);
 out:
 	SAFE_CLOSE(fspick_fd);
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
