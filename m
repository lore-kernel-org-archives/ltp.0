Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AE3E748FE
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 17:35:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 237AE3CDE2E
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 19:35:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8256E3CE06F
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:34:36 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D11FE1400995
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:34:35 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-56f75e70190so15797763a12.3
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696268074; x=1696872874; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yfK78M3B0vAfdMsOOtW0Ch+JZ6tCMLCBSlmuQX81bhw=;
 b=dU09ZyE9AvqzSFOsTo/oC9KIDutR2aggRv9H/lL7Fq5LGB57teYbr+gSw5O0XJs2xH
 OmqpcjYCfyuuD7AVPI8KfzOQGtEX3JAJHcHki89R7XvjzuIiwRucM9xxAIcOR1Pl32Ak
 1k8YzaaZ2V71kU5xLak2BJDFSAE2OXAtAS+g8Cux5zXB3zKV6LVJ1FSGKIqBOm6YjpDV
 y0yjE/RsgOlfre18Z8P4SFk+ndQ2h49iCn29gWeBgXM6V44DRvr4xL9wSnyBKDYBCnX5
 z25sCR6GTIFGBwWqA54F/NdK14xX5ilnbY8mr2dw7xTLHtwbekgD+n1W7LQIrbFTBqu2
 Y0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696268074; x=1696872874;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfK78M3B0vAfdMsOOtW0Ch+JZ6tCMLCBSlmuQX81bhw=;
 b=sR+b0rDFkeB6ZA1rGYVunAyIyrF81ql8cHlZtDstJuqmhKYlz+9LnDlK+hXW/nNEHp
 xOdUJfAtBlqHYwF56LUTtFSlbe1lszVEvxhOFOJeomszAem/+DdRh5elkG4E5PGQKAka
 khV6OOEPdQSTBP2ldGt7ZMqSCVx0Z619a5jnrNLAezL+Le7yDMZOgMDyg+zO/fBKH61K
 SZYeBxT9oFvI8i8rupkjfjMLwEouphALgrmwBHWFcnKOXGbVkMyAUQrmDZojbZx3ZEMt
 YoNxOA/9f+PjWQEocAY0tE1Oj6RL7WzYOqJYkpa9zZwrgHp2iO0sG1s0hLqImGPq9Tbl
 ij/g==
X-Gm-Message-State: AOJu0YwFGdfny5cwJ0c1IvjWvfEW2wvargGk5Vgvixbykgy4PFuULzO4
 HK4lb//gzSj9G7iFUNECw/jNqnPz7xFHX2D6SfzF6s+xuINrt79olU1rxwZBbpc42W9mSvdAnFd
 jkWFIUQjnYESbaG1qhFZAyUXNI/iT/baJkvTa0Y2CUdHtd4eNTLqDWwFI
X-Google-Smtp-Source: AGHT+IEvugCUtXyRPQQvLWg0RECRD8dOXKC4AbpyjXcM0NJW1jg7QnyARHgUoikWeMLyI+wXu5atJzwSI9k=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:7e5c:0:b0:57c:856a:5010 with SMTP id
 o28-20020a637e5c000000b0057c856a5010mr188022pgn.10.1696268074121; Mon, 02 Oct
 2023 10:34:34 -0700 (PDT)
Date: Mon,  2 Oct 2023 17:34:16 +0000
In-Reply-To: <20231002173416.1080347-1-edliaw@google.com>
Mime-Version: 1.0
References: <20231002173416.1080347-1-edliaw@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002173416.1080347-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] pipe07: refactor exp_num_pipes
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

Move doubling the exp_num_pipes into the value.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/pipe/pipe07.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index d9b23044d..8098007c2 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -58,8 +58,8 @@ static void setup(void)
 	tst_res(TINFO, "getdtablesize() = %d", max_fds);
 	pipe_fds = SAFE_MALLOC(max_fds * sizeof(int));
 
-	exp_num_pipes = (max_fds - record_open_fds()) / 2;
-	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes * 2);
+	exp_num_pipes = (max_fds - record_open_fds()) / 2 * 2;
+	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes);
 }
 
 static void run(void)
@@ -75,7 +75,7 @@ static void run(void)
 	} while (!TST_RET);
 
 	TST_EXP_EQ_LI(errno, EMFILE);
-	TST_EXP_EQ_LI(exp_num_pipes * 2, num_pipe_fds);
+	TST_EXP_EQ_LI(exp_num_pipes, num_pipe_fds);
 
 	for (int i = 0; i < num_pipe_fds; i++)
 		SAFE_CLOSE(pipe_fds[i]);
-- 
2.42.0.582.g8ccd20d70d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
