Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E553CC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 23:57:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24FB13CC9B9
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 01:57:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41D3B3C2B4D
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 01:57:12 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 978E01400076
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 01:57:11 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 d34-20020a630e22000000b005039e28b68cso5986540pgl.13
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 16:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1680220630;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7HUMd3u7NvZc9tVi0qb3RxGPxb0fBPZKaxMlebBDRps=;
 b=U2ZYYPpn41IdKIszYhnPHYahlgHFTzOW0zZYRkrWGXtUfq8xpxpT0tPijF/F/Fiivl
 HWq2HgK/WHJT9jgB8hc3f6p0zbV04QSLiW4ll1EDDSnQDCVrJN87wKHe8DMokWGKP+D+
 dvG1og0yKldQ/4DyNuwTuwoShx4+4GNUcEd0zEkuASqK9Ttiqv8KuD6PYTWkkIK5gln7
 FPqFL9VPboxCCKh+mKJMDp4M8R1kWW54N9oDZT6jJN3U+jdheEjxJJ7oK8cVfJDhzlLQ
 wb9PYAJpMzToYa1rtT7bB7jiac0m0bhDsQYvOGYaraLyOTbTPLf8L+ag/soW1wDAe2cC
 aH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680220630;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7HUMd3u7NvZc9tVi0qb3RxGPxb0fBPZKaxMlebBDRps=;
 b=zOkB5ZgiThkym9j4TRV+e8bsDWz4fOxrkidBiO0by+uW9OIkHdfiG0kbJjljEj7vKT
 5c502CEObXvL4yxgWunc8VlJBYfEZsv4YOLcIS79nb2uHu8/sYHhtniuSTgWVRrGgk0u
 1E2kG2U29bDBeAn9gcKiV+sVMP79NWbgMwLp+E53Kff7BrTgMBW8XZfxPyOUeG4HwhbF
 /jUa7VxVOE7SXNhmVxFvvywJ+4VKuPlNuQ7dvjG3oY+86LD/lZdAr9tHio205RBy6J2s
 jwuow31Bm3Nc7NLPqmz6T7wnyaJuIswa7QOF+NUBJX/5ZoZ3aEVSqJXrkRtYiPHbXL+3
 rhsg==
X-Gm-Message-State: AAQBX9cZJv/47vz/y93FO3ZPxeMCG4FuL2I5xIjbg5vkYseLllwKLJte
 6dUr1Z9s/x1cp0Jv7K4qYOjEUGYcTsD82ly45ChIyUHmKrLKQLp/lHbEFMqtuKV7Z+HlPl3fQ3F
 qMAu1jftydcz83yGddphIGXSglNuEZ8JJ426BSy2oPt/3xldEHbFoCwt+
X-Google-Smtp-Source: AKy350ZjUNT9tbRY6DhRWTWZ4Dvh4EJ0ogQMo/LGW1rA34dtABI6rgzpKJYk4DGVwd8Y/hRUg10qkljsJIw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:7c17:b0:1a1:c83c:ba4c with SMTP id
 x23-20020a1709027c1700b001a1c83cba4cmr9362761pll.13.1680220629625; Thu, 30
 Mar 2023 16:57:09 -0700 (PDT)
Date: Thu, 30 Mar 2023 23:57:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330235702.2292418-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] setpgid02: use 1 instead of getpgid(1)
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Android, init does not setpgid, so getpgid(1) returns 0 and the third
case of setting pgid to a different session's process group does not
behave as expected.  Replace it with the expected value.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/setpgid/setpgid02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 4b63afee8..bf7b3176b 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -44,7 +44,7 @@ static void setup(void)
 	 * Getting pgid of init/systemd process to use it as a
 	 * process group from a different session for EPERM test
 	 */
-	init_pgid = SAFE_GETPGID(1);
+	init_pgid = 1;
 }
 
 static void run(unsigned int n)
-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
