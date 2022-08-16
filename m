Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F4AC19F2C
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 05:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C5CE3C9814
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 07:15:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677223C96AC
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:15:46 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 596846001AF
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:15:44 +0200 (CEST)
Received: by mail-pj1-x1032.google.com with SMTP id gj1so8818178pjb.0
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=oyN800X9x0VLzdXNvF5+HSfm5brMyn4q4QD5jE3XSmY=;
 b=dPaTSyQHYFCP8FbM6HaPfT9zDFFWAs1N5EiiMzzdqfqxr6IABCj2lAW7iZ1Iq6vhxU
 uit+SAwNyM1yHKAFmo882CnpFGwWp6voIonAOQNy+JOgMlYXgiZZjwJfxqsEpQnVOdxr
 ELYGGgtCAKb28CuND8SxwTTN+5E58fJoG6mLJrI8jZ5/jeQX1e6WJ8LLQWw4bxgEmJC5
 bReq+j89DshwPkVlZLQszi52ispE6B6kCDplMNtJHt0onYbbHSV8mfzV/idCxsiXX6zc
 B45MTE4xZpKkx8fIqUZFUto5yfW4Suju7exvIALXZfQMUYPldkOos9vHzQOgRR8zaJ7X
 hOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=oyN800X9x0VLzdXNvF5+HSfm5brMyn4q4QD5jE3XSmY=;
 b=1Rd9OTI0LCGKzxmlixrJBzbFG0+SHpsYnU1Vuk7y4jgA5OkpFRPfVrzE5Lv22g8EMx
 QDv1y7OrADUeRaj19jAxC3G5NdX6tZ9hGfFYctvhRq/5mHXaw9YSe1k1XclmlioKfwLW
 MIOaSXrBqTFbsDfuU5wm3DAKexPrJ6qyH+xAWjO+TunWHzb9xUU30SLlCcV7tz92kQwo
 ABQgtwr/xM03cW/e6/kTFWVwRwu9wXNv0TjowTb5CSG3sa8POIPojjz+lOdUg0bNIS9X
 zKvhaHgrM6/+UOWP/hXKnBFcw6f3aArxWnW+cXt1w6gZ76+haBK9Dk/+dNNVztX28Xdz
 i/cg==
X-Gm-Message-State: ACgBeo1VJMa+Di49x6tTc09ymfJrva3sQykt1eom2GUVXMQT9MDzi/sO
 +5FzCGmbz5LB0Sw6aKZPAA8bAcPk1vUFrA==
X-Google-Smtp-Source: AA6agR6R0ULUQdABkHTcP3gAgZngKX/uR35PoLAeDMkyLVyhZvaXNyjen2eCM1qNiAF8hw0QX387lA==
X-Received: by 2002:a17:903:22c1:b0:16f:3d1:f5c with SMTP id
 y1-20020a17090322c100b0016f03d10f5cmr20353840plg.155.1660626941689; 
 Mon, 15 Aug 2022 22:15:41 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::bb7a])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170903245200b001641b2d61d4sm7965252pls.30.2022.08.15.22.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 22:15:41 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 15 Aug 2022 22:15:38 -0700
Message-Id: <20220816051539.2948547-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add configure check for sys/pidfd.h
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
Cc: Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use it to include newly added sys/pidfd.h in glibc 2.36+

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac         | 1 +
 include/lapi/pidfd.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index 81cba98c2..a0123f166 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,6 +71,7 @@ AC_CHECK_HEADERS_ONCE([ \
     sys/epoll.h \
     sys/fanotify.h \
     sys/inotify.h \
+    sys/pidfd.h \
     sys/prctl.h \
     sys/shm.h \
     sys/timerfd.h \
diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
index 244d3acaf..d29a2b274 100644
--- a/include/lapi/pidfd.h
+++ b/include/lapi/pidfd.h
@@ -15,6 +15,10 @@
 #define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+#ifdef HAVE_SYS_PIDFD_H
+#include <sys/pidfd.h>
+#endif
+
 static inline void pidfd_send_signal_supported(void)
 {
 	/* allow the tests to fail early */
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
