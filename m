Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105ADC6FD1C
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 22:37:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA03F3CAD96
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:37:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11C23C8A8F
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:30 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 251241A0035E
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:30 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 l14-20020a170902f68e00b001a1a9a1d326so5957410plg.9
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679351848;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pLWN14FpA8BQ0CqUGjFJxG71LZ8F8BDFBXhZsNdHL0c=;
 b=J8mXlx0l1ytANcgDJY11bQAOSVTTvZ5fMM9pturNuVDgHWaVybwyJmF5i4IbevqLnl
 7Ac5TlBmxsBcGY4vBz6kbweIXgQcy1cwwOEuC0D4iI/X1F2aFWUivrubjp1omJkvjKY7
 8ZKkCaY+qhdtVsH6I28qHMNVWz/NaN9V+d+EseELEifc3ith4+waFQ7guTNInwxRo57e
 27cl5uzla7MvZS4LKdGucsKIIWoUQzkh61raHr1gkux7ZUvOBiSQeG3gralfcjBLXCSb
 3xJm2a+XupA3eQdkw+nZkf2uBWYoB5kGBk7PlQLaE1/zhc7egvCiK5AgmmkTJa7ZYzoB
 KFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679351848;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLWN14FpA8BQ0CqUGjFJxG71LZ8F8BDFBXhZsNdHL0c=;
 b=A+dMQQali+bNgGcqneoi1aaAzXHrlAuO/2b3/WLaeasx0LJzXdv531+deu+6wQVQTo
 WyVa9dvKbL80W2cMhA6YqY5x8uFdzX8xcitq2ZzV/SeoLtTO+DlQQP3jgRWs6KtLOkK1
 i15ARJoibSEusq5LYeGbSGbsGW5MFhKxxygke0UKpOSBPqH0wQt50VyTD8YUNry01tK/
 6tbIfuQkEa1w/T0DgKW+ghy4WEP87+nkJQx7AMam7I8CEjHyZVwqQ/j0Et6hKdFtU4TJ
 Tfi4SQ0ajB4MYMnGTxjBAtwADn8Fk6E/qubP50a4eJrrz1tcigZkornoNE7beevuCg9w
 vtcw==
X-Gm-Message-State: AO0yUKXN+XtdqZ6PWeF3HzWyNaFYsUgOc+RHOpW6UMj7cXzg/Ve/Z+Pb
 4jCCUPDkxohzMAksQO8Rk8rT6jkK+GfSi0x1xJTulYBDva64fpFf0sjnmdtm7w6WaDAwM8+hSUQ
 qL2v6vCma4Q4d/tcd+Skc7oREk6LIoTkSpBLw8YXmU3Fd925DftZxdoa8
X-Google-Smtp-Source: AK7set+TgmISR+49t0ydNnBc0ZBoLa8ytdfPHVXc2ECEhDpCtLUNyLdO11cyouZR7WyFZP/vcfn+ymC4EAQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:528a:0:b0:503:20b0:ac39 with SMTP id
 y10-20020a65528a000000b0050320b0ac39mr93181pgp.0.1679351848158; Mon, 20 Mar
 2023 15:37:28 -0700 (PDT)
Date: Mon, 20 Mar 2023 22:37:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320223723.2030960-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/3] tst_device.c: Handle Android path for backing
 device
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

e1b1ae66b240 ("tst_find_backing_dev: Get dev name from
/sys/dev/block/*/uevent") added a hardcoded path to check for the
backing device in /dev.  On Android, it needs to check /dev/block.

The set_dev_path function was renamed to set_dev_loop_path and its
return value was changed from 1 on success to 0 on success to be more
consistent with other functions.  A check was added to
tst_find_free_loopdev in the event that the loop device is not ready
yet, which appears to happen occasionally on Android.

Edward Liaw (3):
  tst_device.c: Use PATH_MAX more consistently
  set_dev_loop_path: Refactor set_dev_path and check return value
  tst_find_backing_dev: Also check /dev/block/ for backing device

 lib/tst_device.c | 59 ++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
