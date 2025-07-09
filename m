Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A82C83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 13:49:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF2583CACF0
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 15:49:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6C303CA066
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:49:08 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6CD49609253
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:49:07 +0200 (CEST)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so7541265a12.0
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752068945; x=1752673745; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ateKzkbCHc5sIaL8yEpNYKQqvJ9cJ8N1E9YOvRIl00=;
 b=LxvJP8rtGuS91t3GuI0empIY6dO9dPNYVZX28muZkpjf4Lx5mIyZg2Jho8uBj9nnJV
 Kt5IOmM3DjveKs1TuM7COUBcWIlvdyKkz3kkUMDJJR0nhT6EbCM7gvavXetmeSU2xY9g
 tnDFfvgxHUhM2IJqU4BVf1TTBkvjxRzoPJRCn9m/tjkSRL0aPDhW86z/zOWnmL+sQ7Z0
 SQs49aaEgQdW++Byt6a4oY49TktsOwLt69w39H8KTlaBTPEhq8hujlM0rst0G/ye+aef
 GgQSoOfYwUHOhQtLTokKtw0JvpMZHdsY7jj5F/DV4dvSyXNulZ7zsixv4w5anyny4MDM
 lMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752068945; x=1752673745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ateKzkbCHc5sIaL8yEpNYKQqvJ9cJ8N1E9YOvRIl00=;
 b=KygCVhxfe4mtFwbE4HHO0C4nMfKgrprq63ZcJMg3NlY6ASG97vX4wpE334n7m7/QD/
 GLFX6B3YDHS8GS0mPmubOgWkPdCtwZwz2HlmSijLQj6q9fPaEWw+7LjnGgPBbYz1Xwur
 1wSvms5uY2QuABQ0fF+oSf0GW6wkwZZmROBCdN1vDRZmPS/LUhF9U8FM/081W2SZCN4g
 6RXmcD5bsS/h7WlmjDhxMuZhbknY2lr8l9WHz6qXIzPW6sNFau1Dl7Yg3hWz9LZo7JRB
 ZtNEvC3ddA5Tm9zqrXqDZJN9r6ODFmeKWjKMKPXt5XHh+peyu8Mw6QZUIjSUDxu4a7bU
 Hl7g==
X-Gm-Message-State: AOJu0Yz0wAb9x2+P7jEJYgxo7BbcIqGtwzx7kNOIpwavjcKgb5euLfxe
 STs2aJ3c7j4C6SqCJx3Ftgz+Rjg5YwEPv+HlnE4R3ja8OPT5XZSGzFXMFl0S/fH9CQCb1Uf9wSC
 s2hZY9heN3NCbA4xp9kqIm16TWCbA/5HVicpWyHRhrMSADzw0lVKXmUQ=
X-Gm-Gg: ASbGnct5s74eXjPI6x2/0uQ0xtwI49GrVvNK0gRAS71rtNxuDxOi61Ji9Fu7qENGOAP
 iL6DfJo+VMEV44jf4VMaea7+zH2dH0NszpBd3ZQJmKZIpnnAz/PrQ0WTwVxVKCBt8HmhMEttWau
 9P4RXnJCkkaDVhG/axRXLggBrN8gY6jCrkItvJ1seBF+F9cXpbydnfh/UGF+DJrsopEG1cy5HAK
 shJ
X-Google-Smtp-Source: AGHT+IEQhV/nQ/B4d0iM22W5NrME2JaC25s+7CHkU0EidyyHVczc0JiUB1Lee+thAVIgRRGr45oEj47FGwEV1HtC4tQ=
X-Received: by 2002:a17:90b:1c83:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-31c2fda93a0mr4025868a91.20.1752068945122; Wed, 09 Jul 2025
 06:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 19:18:53 +0530
X-Gm-Features: Ac12FXzgk6k00MV94kKXG4l_JDYuhQNs3d5XgUxk-gImCMO8BtDoIe_cQgiLU2U
Message-ID: <CA+G9fYs=3LHdf1ge1MiCoCOUpW=VjPdVWrNJX8+wi7u6N18j3Q@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
 linux-block <linux-block@vger.kernel.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: syscalls: TWARN ioctl(/dev/loop0, LOOP_SET_STATUS,
 test_dev.img) failed EOPNOTSUPP (95)
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
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 rbm@suse.com, Arnd Bergmann <arnd@arndb.de>, Anuj Gupta <anuj20.g@samsung.com>,
 willy@infradead.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Ben Copeland <benjamin.copeland@linaro.org>, Christoph Hellwig <hch@lst.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 8 Jul 2025 at 18:28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regressions were observed while testing LTP syscalls cachestat01 and
> other related tests on the next-20250702 Linux kernel across several devices.
>
> The issue appears to be related to the inability to configure /dev/loop0
> via the LOOP_SET_STATUS ioctl, which returned EOPNOTSUPP
> (Operation not supported). This results in a TBROK condition,
> causing the test to fail.

Anders, bisected this down to this commit id,
   # first bad commit:
       [9eb22f7fedfc9eb1b7f431a5359abd4d15b0b0cd]
       fs: add ioctl to query metadata and protection info capabilities

> Test environments:
> - arm64
> - qemu-x86_64
> - qemu-riscv
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
>
> Regressions started from next-20250702 ( next-20250708)
> Good: next-20250701
> Bad: next-20250702
>
> Test regression: Linux next-20250702 TWARN ioctl(/dev/loop0,
> LOOP_SET_STATUS, test_dev.img) failed EOPNOTSUPP (95) TBROK Failed to
> acquire device
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test log
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_cacQ9AfS0 as tmpdir (tmpfs filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_device.c:190: TWARN: ioctl(/dev/loop0, LOOP_SET_STATUS,
> test_dev.img) failed: EOPNOTSUPP (95)
> tst_device.c:362: TBROK: Failed to acquire device

Lore link,
* https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/

>
> ## Source
> * Kernel version: 6.16.0-rc4-next-20250702
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: 50c8770a42faf8b1c7abe93e7c114337f580a97d
> * Git describe: next-20250702
> * Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250704/testrun/29017637
> * Architectures: arm64, x86_64, riscv64.
> * Toolchains: gcc-13 and clang-20
> * Kconfigs: defconfig+ltp
>
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/28986655/log_file/
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250702/ltp-syscalls/cachestat01/
> * Test history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250704/testrun/29017637/suite/ltp-syscalls/test/cachestat01/history/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJjY2EmRMul6P0UgjdOm4Ssiqh/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJjY2EmRMul6P0UgjdOm4Ssiqh/config
>
> ## List of tests
>   - cachestat01
>   - cachestat04
>   - chdir01
>   - chmod09
>   - close_range01
>   - copy_file_range01
>   - copy_file_range02
>   - creat09
>   - fallocate04
>   - fallocate05
>   - fallocate06
>   - fanotify01
>   - fanotify05
>   - fanotify06
>   - fanotify10
>   - fanotify13
>   - fanotify14
>   - fanotify15
>   - fanotify16
>   - fanotify17
>   - fanotify18
>   - fanotify19
>   - fanotify20
>   - fanotify21
>   - fanotify22
>   - fanotify23
>   - fchmodat2_01
>   - fdatasync03
>   - fgetxattr01
>   - fremovexattr01
>   - fremovexattr02
>   - fsetxattr01
>   - fsmount01
>   - fsmount02
>   - fsopen01
>   - fsopen02
>   - fspick01
>   - fspick02
>   - fsskipig01
>   - fsskipig02
>   - fsskipig03
>   - fstatfs01
>   - fstatfs01_64
>   - fsync01
>   - fsync04
>   - getdents01
>   - getdents02
>   - getxattr02
>   - getxattr03
>   - inotify03
>   - ioctl04
>   - ioctl05
>   - ioctl06
>   - ioctl_ficlone02
>   - ioctl_fiemap01
>   - ioctl_loop01
>   - lchown03
>   - linkat02
>   - listmount01
>   - listmount02
>   - lremovexattr01
>   - lstat03
>   - lstat03_64
>   - mkdir09
>   - mknodat02
>   - mmap16
>   - mount01
>   - mount02
>   - mount03
>   - mount04
>   - mount05
>   - mount06
>   - mount07
>   - mount_setattr01
>   - move_mount01
>   - move_mount02
>   - msync04
>   - open_tree01
>   - open_tree02
>   - prctl06
>   - preadv03
>   - preadv03_64
>   - preadv203
>   - preadv203_64
>   - pwritev03
>   - pwritev03_64
>   - quotactl01
>   - quotactl04
>   - quotactl06
>   - quotactl08
>   - quotactl09
>   - readahead02
>   - readdir01
>   - rename01
>   - rename03
>   - rename04
>   - rename05
>   - rename06
>   - rename07
>   - rename08
>   - rename10
>   - rename11
>   - rename12
>   - rename13
>   - rename15
>   - renameat01
>   - setxattr01
>   - stat04
>   - stat04_64
>   - statfs01
>   - statfs01_64
>   - statmount01
>   - statmount02
>   - statmount04
>   - statmount05
>   - statmount06
>   - statmount07
>   - statvfs01
>   - statx06
>   - statx08
>   - statx10
>   - statx11
>   - statx12
>   - sync01
>   - syncfs01
>   - umount01
>   - umount02
>   - umount03
>   - umount2_01
>   - umount2_02
>   - unlink09
>   - utime01
>   - utime02
>   - utime03
>   - utime04
>   - utime05
>   - utimensat01
>   - writev03
>

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
