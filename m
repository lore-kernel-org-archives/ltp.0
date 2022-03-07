Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87234C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 16:03:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEE903C1BC9
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 17:03:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAD163C0E5F
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 17:02:55 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 29992600823
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 17:02:55 +0100 (CET)
Received: by mail-yb1-xb2d.google.com with SMTP id b35so31846041ybi.13
 for <ltp@lists.linux.it>; Mon, 07 Mar 2022 08:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=oUiS8St9u6jfbDcvn7O2xYzrVRnsblDuTr18hd0OKbY=;
 b=yknKkgg36doSZGb9bSrwwPi/ng2twjs+DjuXJ4ZenpwNzMJFZMROdi7E2liiIp8hkC
 hq/qjT6U0AvPIiqaIt7whbyh+wcdM0THyTzYXufY6GJxLvGfV00FKniLs+SqodA6XZpA
 f7bKXe9DI+xE45O8Gfy2alVuKydBPoffnPLCgCnVhc3CWDq6sGTbN/fc+93eWr42yJVC
 2aqQQ33rGSVAIbwH2LkMXG+QNoeEZNiAF0xNRCugNtWLXqubaXYFxG/kyTT3G959o/tH
 d+s1k0ob4NbaGm0Oo6R+WRup6oSu1xmNmnWDFkrV1huVhJ7cyMvXPZIJhYU6B8AzMRp6
 7FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=oUiS8St9u6jfbDcvn7O2xYzrVRnsblDuTr18hd0OKbY=;
 b=y75wQt6uhG8M9bZWjRsVkZsEcpue4F6z/tPsZ6W2ZmubJHT3cl6R5g8RNz4pvx4SNS
 94NLAx8+OLe8RRYAs2rUfLXvY1tPfrMr4X2gNQvvZBXCl/2SDP0HsGbROBbDHwsI0xkm
 tdXsCPlA/SArPqu7Q0GgGg5IoLK66mSWHlhfpjrNxtgMsTI2jP4yIfGoOoXD+as+DRl+
 1E4V4LWp2OD3cn2jHnq+bzRiaKDsC3IqWfus+quickc+Qb1wtLbXPM+obH6uYpRgXHMj
 fyVTl6AfljVjMOStQ0o8hrsBfcBYCWPDJ7WiY127K/Xa0pZJMEXZyOH4rSaRRKepkqG9
 gDpw==
X-Gm-Message-State: AOAM530r+W8apDZar/T4IP0yVs5PI4WPBuE2RT/4k9k3wdyeAgB2Q9oH
 Py+4mU3g1nDwWSnPb+eGtjZSEQqskzEBrWyZKU1oXMQMh9O8LWNd
X-Google-Smtp-Source: ABdhPJyqM5A9UkFfdBHih/0XUOqLmHjU2A+XzqehBH1mnkInSaZgB3rPF8qGTvQxZ/UiC/DWz9MJ7QkmOYnkHHZ/gQ0=
X-Received: by 2002:a25:be05:0:b0:629:1f49:b782 with SMTP id
 h5-20020a25be05000000b006291f49b782mr6723180ybk.88.1646668972845; Mon, 07 Mar
 2022 08:02:52 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 7 Mar 2022 21:32:41 +0530
Message-ID: <CA+G9fYtGP6Mj3P4fbzTVQdtMrdN-6un+HBSXQCnkGFhpOSBLQw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 regressions@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [next] LTP mm thp04 timeouted after 15 minutes
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
Cc: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP mm thp04 timeouted after 15 minutes on Linux next-20220307 on all the
available devices.

Following two tests regressed.
    - LTP mm: thp04 (timed out after 15 minutes)
    - LTP cve : cve-2017-1000405 (timed out after 5 minutes)

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 519dd6c19986696f59847ff8bf930436ccffd9a1
  git_describe: next-20220307
  kernel-config: https://builds.tuxbuild.com/2639Ukfjo4gbqTYIT0qtQgX1a5J/config


tst_test.c:1433: TINFO: Timeout per run is 0h 15m 00s
thp03.c:76: TPASS: system didn't crash, pass.
Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
tst_test.c:1433: TINFO: Timeout per run is 0h 15m 00s
[  989.498742] kworker/dying (36) used greatest stack depth: 11352 bytes left
Test timeouted, sending SIGKILL!
tst_test.c:1479: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1480: TBROK: Test killed! (timeout?)
Summary:
passed   0
failed   0
broken   1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log [1].
LKFT test results comparision [2] & [3].

--
Linaro LKFT
https://lkft.linaro.org
[1] https://lkft.validation.linaro.org/scheduler/job/4664637#L22900
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220307/testrun/8280389/suite/ltp-mm-tests/test/thp04/history/
[3] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220307/testrun/8285821/suite/ltp-cve-tests/test/cve-2017-1000405/history/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
