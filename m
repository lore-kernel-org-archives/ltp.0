Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFC3E748FE
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 17:34:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE01C3CE06C
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 19:34:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5E023CDEC1
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:34:33 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54581600A42
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:34:33 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-56c2d67da6aso14793590a12.2
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696268072; x=1696872872; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zuPmbm9QxeLn0RTntL5g5QP6LHXkR4gDzTHhkxw3CFw=;
 b=xvtyiPkkXbAjHB930r8OsRkDZzTTonRomDWeT/ZT+pF6UHAkohSncNAxvUSfqSkcVh
 BMuyQuN/zhQMdu5UAvpDp+jKELD1bGrnl5oxN6NjKUjzhwEzvIaUjmCeFBv5v7cnH+iF
 e/67cNWM7YfDTuhU7bP5UH3lKI+kbe31e8BoQ5zv07jTyyZs0fTWNyrbksvMuRo/AIZn
 ZdETgYTRQ0C8+iG1Eq7AF37voieB97nwsci91aNuGfZseDUlFcFBFO/YLMZUbTd4k15f
 5r77r+mhP/v61fg3Z+7jspyIDwj/rXRvIAh6MeqEy0ZR0H9ykCirq1c+Jz/DRFH7VEdF
 vXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696268072; x=1696872872;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zuPmbm9QxeLn0RTntL5g5QP6LHXkR4gDzTHhkxw3CFw=;
 b=m7LTfB680cz+iAYQOjIYoLr2NtgrkpUnGW71v7PU2EuhpSAFCbyAmPo3cbAuMWvBQt
 dtFZ2ISm+KLX5Ijo3qoJWrj9Dlq3Z28qIUyGFxYG9bGLxVZDPHNbr9ZiArOE2ClgFTcq
 zXquv5HxsTkszvRIDiPt3c/sYkFulV23A4dNq5qNRGMgrW5XqmU7NFnBjOGgpYluwTDD
 BkFFYfhC46zTyZsLeikARRY7D0SUiav9Rz3vo8OgjNqfbJk8T7Wh1zgNNV5u/rfLRDl8
 gptQNI4/PilzAJokZ4nopvi+hbspEncaHBoleRbGtOAyjPOjZQ4Li5OtfpU7kg8qpMcd
 Cgnw==
X-Gm-Message-State: AOJu0YzAh3jmRI0eLIhEmPl1A7tnFDFsj242WZpiByTvovvGVKpNq8jX
 uOQHPg+6UxSMKl2roRQaoFUvlo/qvV05CouqoitVVBqYG3FOMEpIyVolhKKCviv24xTu4rRvpOX
 BWT4Ng3Pq2XacrbzudApG3rLLjJ+eBMNPqZUQlOpAp63peBeAayOYBjPp
X-Google-Smtp-Source: AGHT+IE/DMN12U1BQRa4QqRpxNmKb7HPU8czwK4OW5uYPxVeglkccbVdufiHdp0njGAz9BodrZZ8BZL83I0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:6dc8:0:b0:564:e80e:81c0 with SMTP id
 i191-20020a636dc8000000b00564e80e81c0mr185437pgc.2.1696268071412; Mon, 02 Oct
 2023 10:34:31 -0700 (PDT)
Date: Mon,  2 Oct 2023 17:34:15 +0000
In-Reply-To: <20231002173416.1080347-1-edliaw@google.com>
Mime-Version: 1.0
References: <20231002173416.1080347-1-edliaw@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002173416.1080347-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] pipe07: close /proc/self/fd after counting fds
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

Leaving the directory fd open will count against the max number of fds
opened, so the final expected count will be off when (max_fds -
record_open_fds()) is even.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/pipe/pipe07.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index 196485684..d9b23044d 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -45,6 +45,8 @@ static int record_open_fds(void)
 		opened_fds[num_opened_fds++] = fd;
 	}
 
+	SAFE_CLOSEDIR(dir);
+
 	return num_opened_fds;
 }
 
-- 
2.42.0.582.g8ccd20d70d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
