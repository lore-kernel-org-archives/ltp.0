Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12DCCD1BB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 11:57:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02F753CF0E3
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 13:57:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C613CF0CD
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 13:57:11 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 608CE60083E
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 13:57:11 +0200 (CEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33bcf228ee4so5321354a91.1
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761134229; x=1761739029; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WzfUG+BqfKD/coIQsN8R1l6DNO8bGUEyk6UsV4mKerM=;
 b=wma+zv3arNUHqj9lJPC3AF6m3ckWnqt3+llALf1B1nBUOeNOnwXU3T+G4fIdU2gCLO
 9ci3SOEa/oab/K2ETq9gjR7HjFfRGHtnxLhuQDe0Z+9FMAq8DUP3qdvgsgBVpOWBcSbC
 wZ0LdqGT+LpnuQbhEOsI/Qg9/+qPNHnd13A0tA7qaWHVlGGqSECjIr8j1R6hPVgacb1J
 og9yTl9AnKUXz1qF+jgy5BtTFfVPdBG5j/gHuW7nCDiF6d30xLATkJYXnxOTZqfdEDb+
 esQItAI3uQAmWLAcrUlH+S6zzucWdIuXQRgrXyHuFs9wgz8fPUMxO1KjBybqRmkWC3r0
 oMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761134229; x=1761739029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WzfUG+BqfKD/coIQsN8R1l6DNO8bGUEyk6UsV4mKerM=;
 b=WpPhcb8kD+pK1F5PApwwQ1GSZXm3JzOkEFI8oDgKRkuNLG3gKI75KYDTM2ZX4kyTCl
 fAGQ5R0CIk4Wz7r7Av0rsnTkk/14L++80IvPqKQit3nVa8Yp357F7luTmtm3jiKSuSjm
 Iu0F5FmDWcHZ0fyOnzz7ksU3DchZqNI7Xa5RK5vvDq+pTdLEHw3NXg/iBDVHmUbLCncZ
 IfAwqYfL5xvaE6jYGZaAwHRqIVtBunH0/H19TU79OQ8rVbjoa/hsC+T5AS4kWZ4yRZ5B
 m9kbdgomScQ+RUHeLdr85JUlCdJkRDzEm+oBZZn5dyr2rv6Yx5XCyI7svH1yO/pISvbk
 ifXQ==
X-Gm-Message-State: AOJu0YwID2Nl2oUb9RCEfZzotyS+M+SId1THEF54zz0H3l4n/EJnFexq
 X4C2591LXJ4hw/+OCRuWk45q3cbMLByy7N7kYsBbKWrsZGJGIifwIeasDcSTncauuskHx8kWc11
 mMHK5
X-Gm-Gg: ASbGncsbJfyttJr4TdeQQ0PcB0ZYI2MaWfiAVJo5rZYmRpCNEEi6Igde3Qk21Sl4liR
 qlOkROYcuX2Xsgn8/cteABTTzjOndD/wVx8tJGPlaygP61ajPzgqWeKD1OCEZ7Z8kHJXayGIRCw
 /150GESuW6hzVO1HA99vTSrAhZv7cAvymze/Cdt5e9mQSkZ1CBuwNjbLa5S+F+rRsFS2Gwee/Tt
 ehSornaVZlJcMB3XuqwzRNpamrikBLo9XE3vVnIAKvy9EaK4WoZa+q4CxlrJ67onigFryHlnHpg
 Lp03fu4ZAOo/AK9kwATDWNnI1BUfYsW7vSl2Ra1fJKrLzTA2F/W2uCvwYgJYboqxBJc0kzzEN9T
 BqT9pHYfCJxH7L9742TijfuVcgw1rTNWxJlE8DSFLjkiskOBexbz7e2655yCXBjVLKaAu/3FBaG
 a4MyjCw0xZ5P3x98DFmfwzYU+CQa41gyJ90AgOTZVhlP6OVBwALLPqkJBEsw==
X-Google-Smtp-Source: AGHT+IEubD0OvI6uVVM+gnAPZHbQP3Rz7U+Y/YydXiR4UWw4SnGLju39L4qJ5sYEmZqdZYH8YZdr7g==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b1 with SMTP id
 98e67ed59e1d1-33bcf8f7802mr26421431a91.22.1761134229471; 
 Wed, 22 Oct 2025 04:57:09 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:21a:7bd8:378:3750])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33e22428b1esm2401348a91.22.2025.10.22.04.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:57:08 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Date: Wed, 22 Oct 2025 17:27:04 +0530
Message-ID: <20251022115704.46936-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid
 errors
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
 lkft-triage@lists.linaro.org, lkft-triage@linaro.org, viro@zeniv.linux.org.uk,
 benjamin.copeland@linaro.org, linux-fsdevel@vger.kernel.org,
 aalbersh@kernel.org, lkft@linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Latest kernels return ENOTTY instead of EINVAL when invoking
ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid).  Update the test to
accept both EINVAL and ENOTTY as valid errors to ensure compatibility
across different kernel versions.

Link: https://lore.kernel.org/all/CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 .../kernel/syscalls/ioctl/ioctl_pidfd05.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index d20c6f074..ec92240a1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
+ * Verify that ioctl() raises an EINVAL or ENOTTY error when PIDFD_GET_INFO is used. This
  * happens when:
  *
  * - info parameter is NULL
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
+#include <errno.h>
 #include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
@@ -43,7 +44,22 @@ static void run(void)
 		exit(0);
 
 	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
-	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+	/* Expect ioctl to fail; accept either EINVAL or ENOTTY */
+	TEST(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid));
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL || TEST_ERRNO == ENOTTY) {
+			tst_res(TPASS,
+				"ioctl(PIDFD_GET_INFO_SHORT) failed as expected with %s",
+				tst_strerrno(TEST_ERRNO));
+		} else {
+			tst_res(TFAIL,
+				"Unexpected errno: %s (expected EINVAL or ENOTTY)",
+				tst_strerrno(TEST_ERRNO));
+		}
+	} else {
+		tst_res(TFAIL, "ioctl(PIDFD_GET_INFO_SHORT) unexpectedly succeeded");
+	}
+
 
 	SAFE_CLOSE(pidfd);
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
