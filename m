Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFA6C63703
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 15:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E26EF3CC14A
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 16:58:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EF1C3C2A67
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 16:58:17 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EEC21A00807
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 16:58:17 +0100 (CET)
Received: by mail-qk1-x72b.google.com with SMTP id z1so10264303qkl.9
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qs0nZ1rFh/s7MTR6+29xGDMlHk1tahA90qx6nUbU6w0=;
 b=W3sB3oJvRoNx0VC2yM2FQ6Ev/+nc13R58IJFJndvG5zrSCt4KXWHdZ6zV2f5P04vwC
 coYp7i/4L0D6qBB2/mM6gC8B5Hap5ikN4lYCxc3NuIUa5HEE4oGDq26/N2dHmz2j+6xW
 xTvds0opU2zCXTeoD7kWOdDY+WZHi3NFuBZ84RxKKSv84sq/tsjhKfs3IHaizDPOd9Ps
 ZV90N1vR/8LTGEYyr62UIaXclWH/qK1088y+O21hgS7g6HBOCXlupU4IX/C1w/UMEYSB
 Na7a2jWUpQbOwmVLiE8yXlpyo/WKygc+zlp4rghG9CldbdiwoayMt8s+1pKTrPW6y9vh
 Oq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qs0nZ1rFh/s7MTR6+29xGDMlHk1tahA90qx6nUbU6w0=;
 b=rpxB5xaBQT0Prh2f8mY8//oCXOkeyoa/2C3daid4EBmE7n9TFGbNqF/XdWyw6dIzfW
 IpQuYUx9PiCFDXCGfKubWsBt3Oc2OatChBP+8Ismd0m8hBNRUdsJfVHwQmezTDN7Y0Mo
 2ors13O4OU5GuyxmX1CI5GEJ2k5bHd6Yg0gVjvO2NCCs6cS/8p2GqDCuZ/92VYY/yJnu
 EA2Yd0Tn6Ywdx7WlwkJlBGWEa/kY6RciCE/GY7PktYPzYDSPqusDGm5c5bKtobQc7VA4
 Vxu5+HPCvVEfroQEToRp9GI/E7N9x/WTSnKm0J1BqvIjOVTqY03mls5Kkw1zcWfsbXFN
 rDOg==
X-Gm-Message-State: ANoB5plhzoJk1PRzQ60ZxdYGcAtEpDAdD3DdXC8dtGAgddUmX2VuoP9Z
 gquMCxjVpeXKB+IFQeYQdY3Wv2IwStdEP1rcthAV2A==
X-Google-Smtp-Source: AA0mqf6MVYwoYOhFT0gxk5rqGIihkNKVqwUwRwH46llz3gEgyDjhmfIbn9BLQr53oVvP6jd52Fdnrhp6onLZcC0LK/g=
X-Received: by 2002:a05:620a:cf5:b0:6fe:c37b:880e with SMTP id
 c21-20020a05620a0cf500b006fec37b880emr9851138qkj.221.1670428695952; Wed, 07
 Dec 2022 07:58:15 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 7 Dec 2022 21:28:04 +0530
Message-ID: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
 regressions@lists.linux.dev, lkft-triage@lists.linaro.org, 
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] next: LTP: syscalls: epoll_clt() if fd is an invalid fd
 expected EBADF: EINVAL (22)
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
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP syscalls epoll_ctl02 is failing on Linux next master.
The reported problem is always reproducible and starts from next-20221205.

GOOD tag: next-20221202
BAD tag: next-20221205

tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
epoll_ctl02.c:87: TPASS: epoll_clt(...) if epfd is an invalid fd : EBADF (9)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd does not support epoll : EPERM (1)
epoll_ctl02.c:87: TFAIL: epoll_clt(...) if fd is an invalid fd
expected EBADF: EINVAL (22)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if op is not supported : EINVAL (22)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is the same as epfd : EINVAL (22)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if events is NULL : EFAULT (14)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
EPOLL_CTL_DEL : ENOENT (2)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
EPOLL_CTL_MOD : ENOENT (2)
epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is already registered
with EPOLL_CTL_ADD : EEXIST (17)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Test results:
https://lkft.validation.linaro.org/scheduler/job/5931196#L1367
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221207/testrun/13492039/suite/ltp-syscalls/test/epoll_ctl02/log
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221205/testrun/13412113/suite/ltp-syscalls/test/epoll_ctl02/details/

Test results comparison:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221207/testrun/13492039/suite/ltp-syscalls/test/epoll_ctl02/history/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: ee9bda616d36d2dc864aa294c2656fad88c9efa0
  git_describe: next-20221205
  kernel_version: 6.1.0-rc7
  kernel-config: https://builds.tuxbuild.com/2ITqQKvBJSwcIYKcYvEdPjjrw64/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/713047540
  artifact-location: https://builds.tuxbuild.com/2ITqQKvBJSwcIYKcYvEdPjjrw64
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
