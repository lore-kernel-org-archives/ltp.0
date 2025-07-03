Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9EFC83030
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 07:26:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43EB33C9133
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 09:26:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FDB13C2BFC
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 09:26:21 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5398F600688
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 09:26:20 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3141b84bf65so7454187a91.1
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751527579; x=1752132379; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GAMKSN1cf/DpMVRo6gFlykOi6cd+hJQyMWIE0kM7p2Y=;
 b=H66MK9gibPRyudq/eCmGkOaYhJZudPCIQXqXY+tBJZtUuWIBVBQOqzZcgSZHw/zhrT
 8Uwq4SM/77MK5TloC8d7MdGn8sYRscm3SgdYwPzQoFwWutVSkh6Twpuj6HvJ2YLA0lnn
 CWqN8A3NSdy+pryy3CIdDeG0LORVr3iaap7rh6M50ozXkx20MuS/yUI/CN5asfnmoziZ
 2xE41UumaGYoFI7BOqAX/+Pcf/7lZily1nDUoxn6a+fDTF7JjmV9Nz86/yNefC/x6Tzu
 U5IAJu5ZXHUDJJdFMT8hG9kQems/v7w/MJIlc/5HnyBBgCbqxQh3lfBXXJEr5l/72VIk
 BA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751527579; x=1752132379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GAMKSN1cf/DpMVRo6gFlykOi6cd+hJQyMWIE0kM7p2Y=;
 b=dQNmp2uvWa/JvtPgbgO9HCX/TdpNnFudMeOK9+xuuBE8M0PKCfE21yrtg9oO+nXnfm
 g/lfX2GMvMRioGIAs4/tYBbP4aMOSckVGkwZuZQyRu5k9WvNiJFrATw7pNIx5aVP6fva
 XZBEx8BJvul6NfUe1grFHzGa29wISRDg81L702xiX/A7uS0lUJuGbVn7+0Mz+BDgXUSl
 3IGoja3qh7iEvYue8554mDxMQbD1KA2ICx5M9p/gGy4MDRvgpaXX2J4/VTwviRYegLT3
 sUIDAzjTZ279hPYcdbP+NJz9PL3MOMVqYbqsNKQoDiKVVwsS03Mk+2HM6lwE8/ubpSHX
 6vxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+v2q9kdK6HFflNeEmg2F4lSnI/1/WM6/46in9tBn6ewVe0JefRTYOR/sMJHpqrdFTELs=@lists.linux.it
X-Gm-Message-State: AOJu0YwJ+8pK7kWCdIKozdfY1Jn+yckdyD5fd29T3cpC8Ro80jFFp+xX
 8dQpjoX33fIqJH2RMdQKWDO3VowBIiGgBrykD7/vNLf6lqKXYU5kaAGFSVjTf11mqmjv1zvwxAu
 RuOo+YOWdGNNwKOK0W4Vq1MBlN4zZOg6eJiP0PmSHOA==
X-Gm-Gg: ASbGncvM5Xv5pZoiy7Hngpd/287uyeLISXUAXwKIOIcw6XNSDEgsL12Kk/xs81xmqOq
 BlchDW7rT5qEn8EAYaLuNCbGe2dWVBPbkQTZgffQayMQ2K5dw2SFE6XIT5Ydj0LQk1VWPiki0Ol
 8iy/gs3xXik8vVBkDq2jdqubzpF5c1e+sUeZ+OIj3nCfK2zqImdYC+xPC/n2pPX7zudw5lJVXRY
 A12xXv8gW1Dyg==
X-Google-Smtp-Source: AGHT+IFBtroNhRgT2smI4MTW+nF7Q1k9nWSGPUagsoi7hbtQlf2pdM4tjmPERmB0KQXgaKAhNH2kWUgg6ohVrZtxleU=
X-Received: by 2002:a17:90a:d60c:b0:313:1a8c:c2c6 with SMTP id
 98e67ed59e1d1-31a90bc9850mr9100678a91.16.1751527578511; Thu, 03 Jul 2025
 00:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
In-Reply-To: <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Jul 2025 12:56:06 +0530
X-Gm-Features: Ac12FXzBgwMwFGfOkzvJ_EzX-plndvQT1fRe69w5kV27SFg1-zbk8bDaXp-Lnc4
Message-ID: <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250626: WARNING fs jbd2 transaction.c
 start_this_handle with ARM64_64K_PAGES
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
Cc: Theodore Ts'o <tytso@mit.edu>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4 <linux-ext4@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>
> Hi, Naresh!
>
> On 2025/6/26 20:31, Naresh Kamboju wrote:
> > Regressions noticed on arm64 devices while running LTP syscalls mmap16
> > test case on the Linux next-20250616..next-20250626 with the extra build
> > config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
> >
> > Not reproducible with 4K page size.
> >
> > Test environments:
> > - Dragonboard-410c
> > - Juno-r2
> > - rk3399-rock-pi-4b
> > - qemu-arm64
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> >
> > Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
> > transaction.c start_this_handle
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thank you for the report. The block size for this test is 1 KB, so I
> suspect this is the issue with insufficient journal credits that we
> are going to resolve.

I have applied your patch set [1] and tested and the reported
regressions did not fix.
Am I missing anything ?

[1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/

>
> Thanks,
> Yi.

- Naresh

> >
> > ## Test log
> > <6>[   89.498969] loop0: detected capacity change from 0 to 614400
> > <3>[   89.609561] operation not supported error, dev loop0, sector
> > 20352 op 0x9:(WRITE_ZEROES) flags 0x20000800 phys_seg 0 prio class 0
> > <6>[   89.707795] EXT4-fs (loop0): mounted filesystem
> > 6786a191-5e0d-472b-8bce-4714e1a4fb44 r/w with ordered data mode. Quota
> > mode: none.
> > <3>[   90.023985] JBD2: kworker/u8:2 wants too many credits
> > credits:416 rsv_credits:21 max:334
> > <4>[   90.024973] ------------[ cut here ]------------
> > <4>[ 90.025062] WARNING: fs/jbd2/transaction.c:334 at
> > start_this_handle+0x4c0/0x4e0, CPU#0: 2/42
> > <4>[   90.026661] Modules linked in: btrfs blake2b_generic xor
> > xor_neon raid6_pq zstd_compress sm3_ce sha3_ce fuse drm backlight
> > ip_tables x_tables
> > <4>[   90.027952] CPU: 0 UID: 0 PID: 42 Comm: kworker/u8:2 Not tainted
> > 6.16.0-rc3-next-20250626 #1 PREEMPT
> > <4>[   90.029043] Hardware name: linux,dummy-virt (DT)
> > <4>[   90.029524] Workqueue: writeback wb_workfn (flush-7:0)
> > <4>[   90.030050] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
> > -SSBS BTYPE=--)
> > <4>[ 90.030311] pc : start_this_handle (fs/jbd2/transaction.c:334
> > (discriminator 1))
> > <4>[ 90.030481] lr : start_this_handle (fs/jbd2/transaction.c:334
> > (discriminator 1))
> > <4>[   90.030656] sp : ffffc000805cb650
> > <4>[   90.030785] x29: ffffc000805cb690 x28: fff00000dd1f5000 x27:
> > ffffde2ec0272000
> > <4>[   90.031097] x26: 00000000000001a0 x25: 0000000000000015 x24:
> > 0000000000000002
> > <4>[   90.031360] x23: 0000000000000015 x22: 0000000000000c40 x21:
> > 0000000000000008
> > <4>[   90.031618] x20: fff00000c231da78 x19: fff00000c231da78 x18:
> > 0000000000000000
> > <4>[   90.031875] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > <4>[   90.032859] x14: 0000000000000000 x13: 00000000ffffffff x12:
> > 0000000000000000
> > <4>[   90.033225] x11: 0000000000000000 x10: ffffde2ebfba8bd0 x9 :
> > ffffde2ebd34e944
> > <4>[   90.033607] x8 : ffffc000805cb278 x7 : 0000000000000000 x6 :
> > 0000000000000001
> > <4>[   90.033971] x5 : ffffde2ebfb29000 x4 : ffffde2ebfb293d0 x3 :
> > 0000000000000000
> > <4>[   90.034294] x2 : 0000000000000000 x1 : fff00000c04dc080 x0 :
> > 000000000000004c
> > <4>[   90.034772] Call trace:
> > <4>[ 90.035068] start_this_handle (fs/jbd2/transaction.c:334
> > (discriminator 1)) (P)
> > <4>[ 90.035366] jbd2__journal_start (fs/jbd2/transaction.c:501)
> > <4>[ 90.035586] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
> > <4>[ 90.035807] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242
> > fs/ext4/inode.c:2846)
> > <4>[ 90.036004] ext4_writepages (fs/ext4/inode.c:2953)
> > <4>[ 90.036233] do_writepages (mm/page-writeback.c:2636)
> > <4>[ 90.036406] __writeback_single_inode (fs/fs-writeback.c:1680)
> > <4>[ 90.036616] writeback_sb_inodes (fs/fs-writeback.c:1978)
> > <4>[ 90.036891] wb_writeback (fs/fs-writeback.c:2156)
> > <4>[ 90.037122] wb_workfn (fs/fs-writeback.c:2303 (discriminator 1)
> > fs/fs-writeback.c:2343 (discriminator 1))
> > <4>[ 90.037318] process_one_work (kernel/workqueue.c:3244)
> > <4>[ 90.037517] worker_thread (kernel/workqueue.c:3316 (discriminator
> > 2) kernel/workqueue.c:3403 (discriminator 2))
> > <4>[ 90.037752] kthread (kernel/kthread.c:463)
> > <4>[ 90.037903] ret_from_fork (arch/arm64/kernel/entry.S:863)
> > <4>[   90.038217] ---[ end trace 0000000000000000 ]---
> > <2>[   90.039950] EXT4-fs (loop0): ext4_do_writepages: jbd2_start:
> > 9223372036854775807 pages, ino 14; err -28
> > <3>[   90.040291] JBD2: kworker/u8:2 wants too many credits
> > credits:416 rsv_credits:21 max:334
> > <4>[   90.040374] ------------[ cut here ]------------
> > <4>[ 90.040386] WARNING: fs/jbd2/transaction.c:334 at
> > start_this_handle+0x4c0/0x4e0, CPU#1: 2/42
> >
> >
> > ## Source
> > * Kernel version: 6.16.0-rc3-next-20250626
> > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > * Git sha: ecb259c4f70dd5c83907809f45bf4dc6869961d7
> > * Git describe: 6.16.0-rc3-next-20250626
> > * Project details:
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250626/
> > * Architectures: arm64
> > * Toolchains: gcc-13
> > * Kconfigs: gcc-13-lkftconfig-64k_page_size
> >
> > ## Build arm64
> > * Test log: https://qa-reports.linaro.org/api/testruns/28894530/log_file/
> > * Test LAVA log 1:
> > https://lkft.validation.linaro.org/scheduler/job/8331353#L6841
> > * Test LAVA log 2:
> > https://lkft.validation.linaro.org/scheduler/job/8331352#L8854
> > * Test details:
> > https://regressions.linaro.org/lkft/linux-next-master/next-20250626/log-parser-test/exception-warning-fsjbd2transaction-at-start_this_handle/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/config
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
