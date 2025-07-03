Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77CBC83F03
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 13:47:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046FE3C9918
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 15:47:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05D103C7679
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 15:47:28 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AD3331400445
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 15:47:27 +0200 (CEST)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23636167afeso53731235ad.3
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751550446; x=1752155246; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zNAwAKUUSnq/fgn37krSKF6pKcKmiBzRI7BF+xw0WaE=;
 b=HSPbMTddR3dd9z6KzvIO4s0eTMwdg69YwM+JZPje8oFSooMHLJGdOp2IJnoEHRBzjx
 7ew0EEUlcTsDfF2xZYJ7/q8M5X3IZuP58A/ePkSpmb4rDmpfM3oNbwJJD7HQ3u7qQfwv
 t3t6abjs5uMMhGD97KZ1QezC8lS45G/aSNU7nI3+nuaWs+yZ3moM8X0yfLmD9Q6gcZsx
 jgr0VhybTuBZGGtMX5eZyW2/Cjz9iT2J2dRYQn/3xbXQu+zvTwDd20Qe5NYFzuWIujb/
 R5jhsXq/5H/dTHzDMqxjxy9uk+DCFYXMrmoQDcK7ZGCHtntLo0lqIgsVF8bMdsaqz49d
 UjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751550446; x=1752155246;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zNAwAKUUSnq/fgn37krSKF6pKcKmiBzRI7BF+xw0WaE=;
 b=F1xTqqY+B3wpXsEMWYcpDQEJOEeDs0B464+l5NNmO0XVlh92dQ6AqsUvzQY3yiOnVS
 wmYvX1JBCeCP1NgP23ogVzhv47hGy7TVJEfYN6SI0QNl+WGdcXUeQgIZyKujund5KC7D
 ul+mdCKmh8C/CwQ6GtKOwzK6kszd4Okp1r/dbp7B7qb5JE+XKH8RUQifN3uPrUTYHBAh
 dQMmiiTiARuqV71mbiP2dpJ6A1gg1ibBWJWkzhuKOM88zJUJ85zrSz2pT2/G0/LL9eYg
 JlgTo8pJIEsFcGVCB7V02rIjOr9UiS0YqrI8MVdvCyeCHeN2bXLkwi6Rw9vAY9KtqbsS
 eCGQ==
X-Gm-Message-State: AOJu0YxQ5JXqvXf5yaQbUHtrUAF3V3FZklbZ2kPaO1HfgewjaVUU1nUO
 f08GfXLEKt8NWR062t0Jzpu8tv1YbKDBQ6z9OtS/N9o58/t3sT6ICKUecGSOWl2B7IyEMTUlJDI
 QwAo8vFk62whG2ZmgFaa8rFWoVefj/yc53ZNcMAuBHfJkR/2KjWIY9NyIug==
X-Gm-Gg: ASbGncudIFdtUAoPU0EeszeaBN5wWnGJsNgBl1zHs0MO3gjav8F7rvKSzUibDHzy7Cm
 VDhKzgm4rdUe581g76mLq61g/Ep/G4ICIVr402gr23ZSUJaka9rwBjCoY6bAUEyZ8SVh02GAz8o
 ty5mwu0ktgDEOY7F+2er4Na2rx0+uWAf6MKzIZzBj1GiTHnHU1CPD8nxTcDiN2AujCmDUx+8SHs
 r7p
X-Google-Smtp-Source: AGHT+IHUEXhlNkosB+s9dB8bgXeBCMiI6ZnZi91LzN17D+0f+rv731hdTBQXDcnHdjF6QrxZZv/F/SrS2k49x9IlVAI=
X-Received: by 2002:a17:90b:4a4f:b0:311:d670:a10d with SMTP id
 98e67ed59e1d1-31a90becdf9mr8541210a91.26.1751550445538; Thu, 03 Jul 2025
 06:47:25 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Jul 2025 19:17:13 +0530
X-Gm-Features: Ac12FXzo7Nc3aeY_LPk6VLx0lxdm_2o_RgOHnb7cSWld-ykvIKkT80YLPulKSrw
Message-ID: <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, 
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP syscalls mseal02 and shmctl03 fails on compat mode 64-bit
 kernel on 32-bit rootfs
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
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The LTP syscalls mseal02 and shmctl03 failed only with compat mode testing
with 64-bit kernel with 32-bit rootfs combination.

Would it be possible to detect compat mode test environment and handle the test
expectation in LTP test development ?

Test case:
 - ltp-syscalls/mseal02
 - ltp-syscalls/shmctl03

Test environments:
 - qemu-arm64-compat
 - qemu-x86_64-compat
 - x86-compat

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Test regression: LTP mseal02.c:45: TFAIL: mseal(0xf7a8e000,
4294963201, 0) expected EINVAL: ENOMEM (12)

Test regression: LTP shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax !=
2147483647 got 4294967295

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.16.0-rc4-next-20250701 #1 SMP
PREEMPT @1751364932 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
mseal02.c:45: TPASS: mseal(0xf7a8e000, 4096, 4294967295) : EINVAL (22)
mseal02.c:45: TPASS: mseal(0xf7a8e001, 4096, 0) : EINVAL (22)
mseal02.c:45: TFAIL: mseal(0xf7a8e000, 4294963201, 0) expected EINVAL:
ENOMEM (12)
mseal02.c:45: TPASS: mseal(0xf7a90000, 8192, 0) : ENOMEM (12)
mseal02.c:45: TPASS: mseal(0xf7a8f000, 8192, 0) : ENOMEM (12)
mseal02.c:45: TPASS: mseal(0xf7a8e000, 16384, 0) : ENOMEM (12)

tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.16.0-rc3-next-20250627 #1 SMP
PREEMPT @1751015729 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
shmctl03.c:31: TPASS: shmmin = 1
shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295
shmctl03.c:34: TPASS: /proc/sys/kernel/shmmni = 4096
shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295


## Source
* Kernel version: 6.16.0-rc4-next-20250701
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
* Git describe: 6.16.0-rc4-next-20250701
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250701/
* Architectures: arm64
* Toolchains: gcc-13
* Build name: gcc-13-lkftconfig-compat

## Build arm64
* Test log: https://qa-reports.linaro.org/api/testruns/28971382/log_file/
* Test details 1:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250701/testrun/28971327/suite/ltp-syscalls/test/mseal02/log
* Test details 2:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250627/testrun/28914507/suite/ltp-syscalls/test/shmctl03/log
* Test results compare 1:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250701/testrun/28971324/suite/ltp-syscalls/test/mseal02/history/
* Test results compare 2:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250627/testrun/28914507/suite/ltp-syscalls/test/shmctl03/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zGk12rggXwQHzqasQsWpTN3qyv/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zGk12rggXwQHzqasQsWpTN3qyv/config

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
