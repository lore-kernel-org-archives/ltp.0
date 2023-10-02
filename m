Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E19E748FE
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 17:34:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4B933CDDE3
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 19:34:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F6F3CDD94
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:34:27 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D22660054A
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:34:26 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-59f61a639b9so466437b3.1
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696268065; x=1696872865; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IXrrK42Ec3PVJqBKurWurGmtjYGztwJ748Plm9CSMas=;
 b=pHS4kCvO75YD1wrJev15YyzTn0Yi2QQsvYdmh2uhiP5EA5kbgc4z0hDuXoukppu8+a
 GGQpKG82xlp0VZaqRrwytHEKIOVASgFeug2sfJnyX2AcO+JNn/K2mSFqG2dTLrCvomci
 RKW6scyo7m8YTUx4WkClMcL8Ibj2k5XTT7L/09LbNtdAMxx9AVHYhBwCtod+KjbDWhMH
 j09N6Wn4roY9lu67EwCFivb/anxzSTIvmVgWeZCAIjq4s7UaycRs7XzOjNCiRRCHAR+C
 C+hKlo2duskpjChe7TJoB+6o9JkslPZVsb/o7nufk8WX9bLNOLrPteh1IYn8PiGoWq1X
 Ah5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696268065; x=1696872865;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXrrK42Ec3PVJqBKurWurGmtjYGztwJ748Plm9CSMas=;
 b=CXkpW6AwqMb3/nmXB7OSMurHUqGlJCm7qFsYNXtZhnqfMYz6OVyasOAyauED+vBtOl
 2UjlS+20bIBdOeI8MN9fd89yHNEw+K+9EYbqTSXgvu9uN2fzcIkBnV53eS/3mM0pfUol
 9nohSEBEpOsVze42Xto1eQAalIxvfRA6A0S+xgrcvr5w8jx4q6shw+jerl0POMvupXW7
 Hayii+dP1FBH4fziH6SnFPTx3fxJo1/Nr8dGC8wTc9HN76e6wLAcPnx+CiyuKwpPxZUC
 dWkXajp18E3t0ZwTweyVKJvqitaYa1+nIOD165/IW8I60hf8BPOWGZF2f4Sj0W0wRaah
 bEng==
X-Gm-Message-State: AOJu0Ywqneb5c13ExxpfY8p5yBr7Oyno95o7P8owfKEhFi81QrW9xZN0
 Os+W4nFeXFN3nMm7iLBquy+5kJDtg7ewuLVAb9jkBf9p2NPozSW3KDT7gYrmD45GjVOTSu74h8q
 f7JXQfDHl6a0lZLKRuH/krItfU5oBRblbghPaLFXeX6aLVJMe531MHQJx
X-Google-Smtp-Source: AGHT+IE6IC60Mw7RsJBxPU/uvXAI0e9TZ0tqkO+kPHIgj2nFIfCWJR4ZMbziWYPfzm5XIruPJXVb8Ctv+xc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:ec10:0:b0:59b:eace:d46f with SMTP id
 q16-20020a0dec10000000b0059beaced46fmr205033ywn.8.1696268065121; Mon, 02 Oct
 2023 10:34:25 -0700 (PDT)
Date: Mon,  2 Oct 2023 17:34:14 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002173416.1080347-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] pipe07: close /proc/self/fd after counting fds
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

v1->v2:
Split patch into bugfix and refactor
Fix bug in refactor that caused exp_num_pipes to not round down to
nearest even integer

Edward Liaw (2):
  pipe07: close /proc/self/fd after counting fds
  pipe07: refactor exp_num_pipes

 testcases/kernel/syscalls/pipe/pipe07.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--
2.42.0.582.g8ccd20d70d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
