Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2529CC61DA2
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 15:11:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7211C3CC740
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 16:11:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAC643CB38E
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 16:11:24 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 20A8D200ADA
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 16:11:24 +0100 (CET)
Received: by mail-vs1-xe30.google.com with SMTP id 3so20034192vsq.7
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sKj8jKaS9qzEpZ/g/OHaJQRuOTXzmq7peLRAuzMOX1c=;
 b=HDJ5qm0/Fk4IPj4N4/RAkv60QIA3V+CilbE0nwMA00YLr2k7NBBZ2jvVmLUCBqUJ5Y
 1Vn4j7M45VC76cKyChHEv5FPahv6UfN+A8UEEobOYmIcDvuu6vDAUrnyZUVImAEvm3bv
 q8h/YL1qrQg7ci6bwcHv5ivJ88WgYOZjuRp0OBW0JojSnuT00iN6MNgyyyypYNnaIA/0
 wukD9CzXPDyQ8E0SSq5Y/3Z2k4MTJDYwe2P4YntkE4AqeAZLctrv+tLur+c7EZe3E6ac
 YR0NqQjq/wnF3xq00pKaCVaR2PwRkN/j11VES34mcVn0E/wPx5UUBPDOKBJPC9yJCU3G
 q8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKj8jKaS9qzEpZ/g/OHaJQRuOTXzmq7peLRAuzMOX1c=;
 b=xaJSalLHv2H02faDOUqB3V24Vi6gvebd/uLZXxfEwdzSWYXl7eilgMqz/0GYFPH1lD
 2RLtQdRY4ip8DAiUiFWcgCKFvSbbYmhjhLj01wmqNVOgpZv7d2fEmemzDvcLbRcRoOsU
 5UAyC528VBePTLIC+P/XLgVI4XIAQUOs+QwrYayZU0qp/PQ2MJ/pajOsKcvyjoVankUg
 9E+Pp9bsZhkSbcrQGUxidchK75c8yLPZxSkqi0es4fTdr6VjgjIF7xMzyRnQgam0/puW
 qLtVPwvlvhW9exEvSlKn2Wzxf+dNRgbMGXGtePDHiQA0puz8+QFelQBojYu+7uVpXQaz
 Hu6A==
X-Gm-Message-State: AFqh2kpO9MV7c/7uxoOxaJNsufcxGf4CBiktQJtqxqJJ3NhYrrROgq0E
 h8Wuk8W8BlDvb2ENLYnH9Tj7t5g5oR26TV8wQtsfPQ==
X-Google-Smtp-Source: AMrXdXvbcCDG8QypkptU6Y9TFYAuhqUDoQNjsVfOwFzFHgNpOJPmg/3cmhm7ehU3nIxSXrKyvMXo1Wd5UNN/5wxEHtg=
X-Received: by 2002:a67:f2c2:0:b0:3d3:fdf4:9d30 with SMTP id
 a2-20020a67f2c2000000b003d3fdf49d30mr3817805vsn.34.1674659482687; Wed, 25 Jan
 2023 07:11:22 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jan 2023 20:41:11 +0530
Message-ID: <CA+G9fYsoGiJRYeuUpak+5aQ4Ev8s_u0YZKXMQuP7CwQsWo1G6g@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] next-20230124: LTP: shmctl01.c:120: TFAIL: after child
 shmdt() shm_nattcg=20 expected 0
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
Cc: Vasily Averin <vvs@virtuozzo.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shakeel Butt <shakeelb@google.com>, Luiz Capitulino <luizcap@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP syscalls shmctl01 test failed on Linux next-20230124 tag across all the
available architectures with following error logs,

tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
shmctl01.c:256: TINFO: shm_id=9 maps to kernel index=9
shmctl01.c:220: TINFO: Basic checks
shmctl01.c:175: TPASS: IPC_STAT: shm_segsz=2048
shmctl01.c:182: TPASS: IPC_STAT: shm_cpid=103946
shmctl01.c:189: TPASS: IPC_STAT: shm_ctime=1674621556 in range
<1674621556,1674621556>
shmctl01.c:175: TPASS: SHM_STAT: shm_segsz=2048
shmctl01.c:182: TPASS: SHM_STAT: shm_cpid=103946
shmctl01.c:189: TPASS: SHM_STAT: shm_ctime=1674621556 in range
<1674621556,1674621556>
shmctl01.c:220: TINFO: Children attach SHM
shmctl01.c:116: TPASS: before child shmat() shm_nattch=0
shmctl01.c:116: TPASS: after child shmat() shm_nattch=20
shmctl01.c:120: TFAIL: after child shmdt() shm_nattcg=20 expected 0
shmctl01.c:220: TINFO: Chidlren inherit SHM
shmctl01.c:116: TPASS: inherited after fork() shm_nattch=21
shmctl01.c:120: TFAIL: after child shmdt() shm_nattcg=21 expected 1
shmctl01.c:120: TFAIL: after parent shmdt() shm_nattcg=21 expected 0

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test logs:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230124/testrun/14344836/suite/ltp-syscalls/test/shmat01/details/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230125/testrun/14356742/suite/ltp-syscalls/test/shmat01/log

Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230125/testrun/14356742/suite/ltp-syscalls/test/shmat01/history/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: a54df7622717a40ddec95fd98086aff8ba7839a6
  git_describe: next-20230124
  kernel_version: 6.2.0-rc5
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl19cvIBraXOcZpBGCPzCajGAs/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/755587911
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl19cvIBraXOcZpBGCPzCajGAs/
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
