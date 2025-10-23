Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927CCCD1BC
	for <ltp@archiver.kernel.org>; Thu, 23 Oct 2025 16:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853893CF26B
	for <ltp@archiver.kernel.org>; Thu, 23 Oct 2025 18:44:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FCC83CDFBE
 for <ltp@lists.linux.it>; Thu, 23 Oct 2025 18:44:08 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA0461400430
 for <ltp@lists.linux.it>; Thu, 23 Oct 2025 18:44:07 +0200 (CEST)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b6ce806af3eso948614a12.0
 for <ltp@lists.linux.it>; Thu, 23 Oct 2025 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761237846; x=1761842646; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WBSNSnNcjQaKaCnCJuZwnw3e0fnN82ayIMOAkE29L9Y=;
 b=pg71td++BUUm8qVm+qbFIdjNMSK5IU2Y1C9SXHotM10YBEiXzoUhzLqX5/wTkpLU6S
 1z95hhEKmKl4OMUl1wRdv2i9iRqxYZ6i9tFVGEIJxohzHmeyI+76Ag2k2oFGyUuPbLHM
 itgKod7yJvJ4+3dOM24x0GBj9C69ElINPmxokeAZj5+wIscmZcMgKYGooaEnVa7G2hdy
 M4HgqJA3BKrHWk2qhui2dPwmW3eYv0KiRf9/sC3SudBF6UQBe1RGoub3KtDjqvBoQiT4
 J7R/YFiPfdJbTnAXYhVwtcDkgXBYnICTWBdI4dQrURvYmNnJJURNKzzecCfw5eUJJ5GF
 SaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761237846; x=1761842646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WBSNSnNcjQaKaCnCJuZwnw3e0fnN82ayIMOAkE29L9Y=;
 b=qYgDlbukN/hlRtd9YdPIbThoiokW8SsRH75XBnz/crIPLhKjYWvUswf4BLTfU/wTMd
 TrLNGx6PKY2yBXQyxb3XG0wOzh94nH9to4RxsCWOvLS8o7l8iCeRh+YsARBOelyrq21x
 bHnlVcaqJunyuy/QdQscAxDgzkRXzNXiMXIMCyHXenbXZxUeXyFk1MR7y5r3pml7+8Dq
 XvFzA8qF2LemDobY927V/OyyFuNS7cWmGXq1+6BxZ6XyD7oQaqb3gREgxitPmvjjoshv
 Gw3onXWutVlWqLjLNq9E79cLbsVX7DgwMAxF+gcXGmyLrbM2yANdi6svslgYTHcbCy5A
 yQfA==
X-Gm-Message-State: AOJu0Yx4tl319luLYF2AKZF9ISXLq7LLBsqj6duIhwO/mRWyzhU/jelT
 6cWAuyECGyiXHI2dPqtD47vsMH1WmAPeub4GST9IR/t/Icc4vWWaQIkGb9BuGoA25GlUNT/6TY2
 eaKQB
X-Gm-Gg: ASbGncsy+z+iQV+MOF1hVxVSyMq7xtlLPVyJEyPLVFX/oRzjQoyg9CWuN50VV5T5NMV
 9wPPjVsXUGNDisT9sjVxP5IZgPzkiSEOwItVSv2zZxs/UxfPdWMaU6SUpNY7f3tGLIMvF2VlDNK
 wJJ16Qldg3jtCKrHlkr0b2NYGu3+kQd0wMxc7y6/yAp7ZvoNM5647qITOrEV6xjcvrm7EqjPW6J
 K4tSmKDMKRxaAqLU8uEi+JEVz8doEwY5pK+owugQ8Ks3eOfX4k2a8er2qtrrOCp4QvZQKlm3gd3
 XWxAxUyYXpkBogk5rsuePpALmsMExAzVKw7RCvF59hc9wMGGNrScb/FdmbVjIwoe57bCL9CGOy0
 0MyAaOsz9RIcRn3xSrGX6FMcld44Leq+7IdXhXXEebxvoummTO52MhO6Aj/S7nzJgDUQExwOaD1
 Ya0+5yVUSvkvgohI7xHecGb5YUqZD6CEoOG0oX5QuCNMSsTmd0TQ==
X-Google-Smtp-Source: AGHT+IE4pFFH1ySU5m3ad6i6VUzfPRs66wcF55zEy8vDarPljKErMuGfeUnYnh7PBCKkJQkt4U7EUg==
X-Received: by 2002:a17:902:cec2:b0:282:eea8:764d with SMTP id
 d9443c01a7336-2946552521emr61649525ad.35.1761237845759; 
 Thu, 23 Oct 2025 09:44:05 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:d184:69e6:58bf:965c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de0c894sm28713685ad.47.2025.10.23.09.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:44:04 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Date: Thu, 23 Oct 2025 22:14:01 +0530
Message-ID: <20251023164401.302967-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as
 valid errors
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
Cc: arnd@kernel.org, brauner@kernel.org, jack@suse.cz,
 regressions@lists.linux.dev, arnd@arndb.de, linux-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, viro@zeniv.linux.org.uk,
 benjamin.copeland@linaro.org, linux-fsdevel@vger.kernel.org,
 aalbersh@kernel.org, lkft@linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
test to accept both EINVAL and ENOTTY as valid errors to ensure
compatibility across different kernel versions.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index d20c6f074..744f7def4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,8 +4,8 @@
  */
 
 /*\
- * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
- * happens when:
+ * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
+ * PIDFD_GET_INFO is used. This happens when:
  *
  * - info parameter is NULL
  * - info parameter is providing the wrong size
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
+#include <errno.h>
 #include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
@@ -43,7 +44,12 @@ static void run(void)
 		exit(0);
 
 	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
-	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+
+	/* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
+	int exp_errnos[] = {EINVAL, ENOTTY};
+
+	TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
+			exp_errnos, ARRAY_SIZE(exp_errnos));
 
 	SAFE_CLOSE(pidfd);
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
