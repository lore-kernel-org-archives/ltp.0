Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF0ECA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 06:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755844482; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qtWisH18IVYaZ7apZWmdrEa717+e+hhUtXlqV8+x+Tw=;
 b=G3pp3nSrFdqTRDNt5/r6RxzaxapdM5JMgAgC4KKx2XE4qUSx0ObN9Y6FclvCboEmLGKzy
 VMOmHDwuZXKn27XSsow5FChb7jMFrjCYffnCu/4QJeu2AJrccZYgxRcvKtMb5sGp+hosmWK
 wp7/IO5oyAQp4Jxwh94uLAyPNVuZMsA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC9393CCCCC
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 08:34:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E6C3CCD68
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 08:33:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF6C9600043
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 08:33:43 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-afcb73621fcso237581566b.0
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 23:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755844423; x=1756449223; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GIUIzUWJ35RrgPWqKqrKUBSXbJIxsTdq12pLYUX4Mo=;
 b=bQ+GbYtFP1+waYm5qQxD5WLIqGpX3wVw0dwRl61cebq9KUD8xPEVklmW4l40TYIWwL
 bzgRNOfoh9hVdrChpBZJiMqWZ3ztWozXqm+dqvlWv0Fvhi40XYJWhnb8YbxakCkHSRVX
 TH2MhsN2/Bno8jw1o8Es6cQmg851q3zFdlzmOjSieeWET1YbT/+HaZAzR6989NsODfXZ
 UKJf2JGQHRtd1kYwxLAdfJ6MxypUKTkJoaZVlGwgPu7U85gHpLgB55inBMeGdRpwd6xF
 vSU7I/4tvDiEoWVMMa0jzF8zlVzEeORjPGuSD2uTO+ExgPWPSMDV4cB/Tth8u5PucvN0
 C5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755844423; x=1756449223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GIUIzUWJ35RrgPWqKqrKUBSXbJIxsTdq12pLYUX4Mo=;
 b=D9hEW5ZxMMt4wZOMP+o4VM8lqfbDlhiXf/hI6COZVI5KEjOqE/AkeP5SnPf2n8qzbQ
 Ox625dqWaJiOCqa/wdYaV2oJ5IfrFdU3KzlYK6D/5vyFnauRVLNpDfl4+p1/yRImugkR
 +KhZRYR+aR7noYJPibuQz4HZ4NRW9JYMPhHLs70Z3l0HN0IikzBwDD0lK7wMiAwEunCQ
 YIxr0XTpKtNkBmw3DjgNpH5yQpjatht+WA9naNaMMjbFxkab4nQM/FoBgQkLgzfazZFi
 Ym9xkQSRIn/hfja9Xwue61T9X1t0WVU8tc8fDt8PMnRnIDS7BjnBDXImPyC/siE35MDb
 sEfw==
X-Gm-Message-State: AOJu0YwZpytbzgEbi3lAhd2n6TdJ9HwSeTDTdl0+6XfgH09f9nTvYW+M
 62Q7bCvQ/HCZf+ni4B6mwTChp/f48ZixAk5VHdJ8RkPs5aB4rTlrtdri2dNC8l2Vul6HH/nd3T5
 FLpA=
X-Gm-Gg: ASbGncuehA58qu26xvqMqfM+mYyzyOmgImeB2F1sXFFfB1OxTuxaj0rVoRO6iJ5pnjT
 +qnC0NDPn9g5GVPK2t6zERWpqwQFnyfVMy16fKnk/z7LJRVtnQ54BDHLIyYvh53jUUHPTKMSNfm
 9in+Wix10U9/JYrdbqmEZR/ANzxYpCesqbl5qkietwyuFOQie9cneiH+mzsg3xTxj3MhgnV3yMD
 QGZdZL9grr6lvQcFyxqeCWDrG4epAHI/CHepHiHidjoAnPnjKhrLjaikVfcgyzTgGHGDTVk99PZ
 B1Uov8WQqE31xH0bzYiZwV4LVZtBwrdP8UhUJf+20wskz8jN1q5/Pu9xlp5g/Y2X6fmdYRlFcr3
 zPYHYEQUHwKUL9hTzuinbOuifh3qyQCn2VDlF9pnEOWGiv3kc5FiMJg==
X-Google-Smtp-Source: AGHT+IH8VDMrIaYLgzH7GEo000dFc+k00wPNlA+46B5o3FhEzPIjrjzWfkNE/L91aEpKkjqYf4q48g==
X-Received: by 2002:a17:907:3f97:b0:af9:21cb:23d4 with SMTP id
 a640c23a62f3a-afe295cace0mr145946266b.36.1755844422975; 
 Thu, 21 Aug 2025 23:33:42 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded4ca695sm535255666b.90.2025.08.21.23.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 23:33:42 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 06:33:07 +0000
Message-ID: <20250822063331.28886-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822063331.28886-1-wegao@suse.com>
References: <20250822040501.28640-1-wegao@suse.com>
 <20250822063331.28886-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] fspick01.c: Check mount point was really
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
 testcases/kernel/syscalls/fspick/fspick01.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d03cacd3d..dab2bd75e 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -6,6 +6,7 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
 
 #define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
@@ -25,6 +26,8 @@ static void run(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	int fspick_fd;
 
+	TST_EXP_VAL(tst_is_mounted_rw(MNTPOINT), 1);
+
 	TEST(fspick_fd = fspick(AT_FDCWD, MNTPOINT, tc->flags));
 	if (fspick_fd == -1) {
 		tst_res(TFAIL | TTERRNO, "fspick() failed");
@@ -49,8 +52,22 @@ static void run(unsigned int n)
 		goto out;
 	}
 
-	tst_res(TPASS, "%s: fspick() passed", tc->name);
+	TST_EXP_VAL(tst_is_mounted_ro(MNTPOINT), 1);
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
+	TST_EXP_VAL(tst_is_mounted_rw(MNTPOINT), 1);
+	tst_res(TPASS, "%s: fspick() passed", tc->name);
 out:
 	SAFE_CLOSE(fspick_fd);
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
