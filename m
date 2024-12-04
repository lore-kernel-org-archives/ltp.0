Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4584E7716D
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 09:39:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EA523DEE00
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 10:39:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CF813DED75
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 10:38:53 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52EB96609DA
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 10:38:52 +0100 (CET)
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4af1ace57c7so372022137.0
 for <ltp@lists.linux.it>; Wed, 04 Dec 2024 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733305131; x=1733909931; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cWUJzDJGc7Svmrjo2Yx287BIq8DOoijbqXVcFkV/Th8=;
 b=KPIwZU+dGrQXzGNz5JJBgMNoJ9P6VEdE1L2xwqP6Zwl9xVSPtB8E3KOoIyi8avDNrP
 fLAS26Lcixg7Caky6avJ7AnBOKZO2fkaL+avB6ujKFP0UV+ocqsMTX5ZuRUu0w8zmkBh
 HPUUnggNEE0v7A+btJ0W5M5eb35XSId/OR+As4rfqmTtjyeqpezUtv49y0qSNDFsp2M0
 14zJfOppoeElJRJ9LnA7P1/2p1z9rnN/KuJr2sRIPpBmdcJyuAI4EHsI16wfgTY5cxmA
 /XFvvxTmQvXZjwLW8U0g1XzjxEum21zVtFMU2OU7zULvmdXuB99pZhzfbHssNF1fpADv
 sBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733305131; x=1733909931;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cWUJzDJGc7Svmrjo2Yx287BIq8DOoijbqXVcFkV/Th8=;
 b=SJ9we7JDwGTiMne94jpbP7b9W7PtxXk33Dag5DKVEOaGwVaqif4iO4e0bGIOkLdOeo
 b3ZWV7zl3TLRsL7fQuVmhPpYRM7rbr4mjYFWPdVU/CrTYd3kEwaDBzEfcS8qelZNz4YW
 /9aeoOR5LcxHlYPUHBcajYlcpAVSJaR7FRWUbhs+fcnxXtJEuIw5AfnV5Bd51LwIGxdg
 svyO7v/yQuBHoSsHN6SiIV9CSqEyOz01YUUc1lRTX/sq3VzM++eWsyXgBbtBmgCahbFd
 Iy/0/Qk4/vj1z/4aHjGSIWporbgyCt9ER7b/mXKw4NZv4AtqzN9POad+mJEEQBW359uW
 X8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGVC0Ct+eBONZTM9M6sEIb2YgFBadX/9WAiWkncDhSRQV6S21QC/mWCjs1RL/A5vMRR20=@lists.linux.it
X-Gm-Message-State: AOJu0Yy87JnB0ILSerGOrL4NZDHa/hwo4EYGDZtfbnJkSJxa+9PTAx7l
 G562miO/bc31b9LtCnh9Tk7EJajBJPT94OkoOoAWAx82qLsvehd+3rkoT+OS40HOgfzz8UYxBQj
 ++e2WXImNKLlEPvmOXnGCERRqx0OF3YYFBtVfXw==
X-Gm-Gg: ASbGncsCIlh0TG6cH1Q3h+Oie6CwK7CkDoWI5c5Dx4kwzqtaSdQSjJqvjMvE9BQexQm
 oZVg/roPp5HIxBDCmOY0JrzhdXV1CsXmE
X-Google-Smtp-Source: AGHT+IHa2s2KZFVXgBuDE21MW01ekjk63BnpZQJJFVpTdT6Md53yNFIsgwBWlwO6BnTMW3wblvbpS4cjY/IyxSO907Y=
X-Received: by 2002:a05:6102:945:b0:4af:1614:858f with SMTP id
 ada2fe7eead31-4af98869826mr5567377137.12.1733305131087; Wed, 04 Dec 2024
 01:38:51 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 15:08:40 +0530
Message-ID: <CA+G9fYv4tUvUj1+rv5AU98QT9P8-RYVTkLAc-fCbLvy3wLtpJw@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] next-20241203: LTP syscalls: name_to_handle_at01 and
 open_by_handle_at01 failed
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
Cc: Benjamin Copeland <benjamin.copeland@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following LTP syscalls name_to_handle_at01 and open_by_handle_at01
/ 02 tests
failed on the Linux next-20241203 tag.

First seen on Linux next-20241204 tag
GOOD: Linux next-20241128 tag
BAD: Linux next-20241203 tag

List of device :
  - juno-r2 - arm64
  - juno-r2-compat
  - qemu-arm64
  - qemu-arm64-compat
  - qemu-armv7
  - qemu-riscv64
  - qemu-x86_64
  - qemu-x86_64-compat
  - x15 - arm
  - x86_64
  - x86-compat

ltp-syscalls:
    * open_by_handle_at01
    * open_by_handle_at02
    * name_to_handle_at01

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test failed log:
=================
tst_buffers.c:57: TINFO: Test is using guarded buffers
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (0)
name_to_handle_at01.c:98: TBROK: fstat(1,0x7fffda449ce0) failed: EBADF (9)

Summary:
passed   1
failed   0
broken   1

tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opehXJa6X
as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
PREEMPT_DYNAMIC @1733269464 x86_64
tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
tst_buffers.c:57: TINFO: Test is using guarded buffers
open_by_handle_at01.c:101: TPASS: open_by_handle_at() passed (0)
open_by_handle_at01.c:97: TBROK: fstat(1,0x7fff409f94e0) failed: EBADF (9)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0
tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opeN4blFw
as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
PREEMPT_DYNAMIC @1733269464 x86_64
tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
tst_buffers.c:57: TINFO: Test is using guarded buffers
open_by_handle_at02.c:98: TPASS: invalid-dfd: open_by_handle_at()
failed as expected: EBADF (9)
open_by_handle_at02.c:86: TFAIL: stale-dfd: open_by_handle_at() passed
unexpectedly
open_by_handle_at02.c:85: TBROK: close(1) failed: EBADF (9)

Summary:
passed   1
failed   1

Links:
---
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/tests/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188858/suite/ltp-syscalls/test/open_by_handle_at02/history/

Steps to reproduce:
------------
- tuxmake \
        --runtime podman \
        --target-arch arm64 \
        --toolchain gcc-13 \
        --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config

metadata:
----
  git describe: 6.13.0-rc1-next-20241203
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
  toolchain: gcc-13
  config: gcc-13-defconfig-lkftconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
