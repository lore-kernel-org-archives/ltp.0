Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917BFC7EE32
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:31:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB15A3CCBAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:31:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C6CF3C0EBA
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:31:30 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2823A600BC9
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:31:29 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-313b6625cf1so825078a91.0
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750941087; x=1751545887; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EIOkAUyi7+ujarkTFH99WxEnz3RnUsZ9Cfbw2lKPPMg=;
 b=W2Z93wgdRVibiOycytjtBLAmmkaz5m4rhBoroT13bJ+3FfVQMMKsyOO9PcVvFC0zIG
 JgfjaGtf7ETFSTOxc+ji3iIu5e7uo5T5Msy+e4YiKqaNSawoDwo6/Xpy7xrxnUvLLqaJ
 qbQGKNzTRqiD0HGF88lzhfvSDxvZp/eQvy364VUWgTMhnk+7opP/20aXjREF64S3V0SY
 8I9fPQJAFPLTIK6V9gldKGfUW+y3NuuNZDBwZSkVplP+oipHoTNtm1+59VDEB/GGkUVj
 NtqUuNBPmpOWICEXIeHGpg+IQCxx+nZ/A5f3iqDSuzepG1EP26vZKlF5ibrzoZUkZ8NU
 qq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750941087; x=1751545887;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EIOkAUyi7+ujarkTFH99WxEnz3RnUsZ9Cfbw2lKPPMg=;
 b=PLjwgsgPBZXhRrbzpA38hk8l4Ysxh+1+oEMmHtKu52FfcAQem+hnjIhk/RlG6kAZUc
 CHo3A9PP1l4WiA0ndGLtuWuqRanKUyphu6Udwqo9h6pbtnv/GIVWZ4HHsg9r4hr8imCt
 aowdje4TaSxE+/fmFC90MiTvxQ7dv/VgtIK4eMSxTqaBaq882/pJpTJBqMpRlu5ph/1D
 B55M9/7YgshBLmujnn8S2XZ7Zr7T25lSTRHZ/eZE2oqkZPEYYv1hzu1w0/AmVvAL+XW2
 LCB7W1OJQrobRlV1AnGdFEHJnOYy3RgRZ+xENzJOdeQY2/PY2WtZ/kV2VlDXgpyrXwB9
 u0vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgYB36t+M6BCId/kbFXXjy/4xsrnAB0pPFNf/hUa73OcXfrCOynyj5+KDJV8f7lpLWdwU=@lists.linux.it
X-Gm-Message-State: AOJu0YyJzQAmRgGU+oK5lDi+K5H01hjrmMW9/xNJFges+lRZeifciAMy
 bgJ5c4GEPB23+7R/tu3JCsimB1XTc++qy5PMjoXR8GbZ4w4x3u0eMP94M0hW+2WPRce6Z0elmf0
 oB2YbbaqC4bfVQcrql/LgS1dhl9IMbZ7bgZcu0iNtPHGj3K4QyjlGo+IYgw==
X-Gm-Gg: ASbGncvXfUvwvumdSSU17CNHWFR9oCzq60DbhbAxzUpplBNJLvO72cy1FgQMk0/azdc
 aez031ODeH12WDJ28reGSpwibUqYORMjAutyt0enzOFa0YAQbUb0ttoGl3HGhu9aRUQdjt/jcqO
 sYYBFDJMtMY8s0mxGqJ3Ikz2IlHpgBH/9HOShcqCvsCtEm+pi2e7dPD8CAvwNAxKjg5yChXWU4u
 4CZsKLt2f+K7ZQ=
X-Google-Smtp-Source: AGHT+IGA5Lld9l17rfBeRi3J6RtVhUs8VMLhujLLvSb8uLda4du0G2dKBSQALBMM1VCCHZPZuj94xiQrzmJCa/zGAg8=
X-Received: by 2002:a17:90a:ec8f:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-316d69c8e39mr4270600a91.5.1750941087313; Thu, 26 Jun 2025
 05:31:27 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Jun 2025 18:01:16 +0530
X-Gm-Features: Ac12FXzu4alDLey0mZeuA43OiDuuxMWqb_ya1XrTviNkqYaW1clUM_UZCxNwuVM
Message-ID: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
To: linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
 Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] next-20250626: WARNING fs jbd2 transaction.c
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
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Regressions noticed on arm64 devices while running LTP syscalls mmap16
test case on the Linux next-20250616..next-20250626 with the extra build
config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.

Not reproducible with 4K page size.

Test environments:
- Dragonboard-410c
- Juno-r2
- rk3399-rock-pi-4b
- qemu-arm64

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
transaction.c start_this_handle

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
<6>[   89.498969] loop0: detected capacity change from 0 to 614400
<3>[   89.609561] operation not supported error, dev loop0, sector
20352 op 0x9:(WRITE_ZEROES) flags 0x20000800 phys_seg 0 prio class 0
<6>[   89.707795] EXT4-fs (loop0): mounted filesystem
6786a191-5e0d-472b-8bce-4714e1a4fb44 r/w with ordered data mode. Quota
mode: none.
<3>[   90.023985] JBD2: kworker/u8:2 wants too many credits
credits:416 rsv_credits:21 max:334
<4>[   90.024973] ------------[ cut here ]------------
<4>[ 90.025062] WARNING: fs/jbd2/transaction.c:334 at
start_this_handle+0x4c0/0x4e0, CPU#0: 2/42
<4>[   90.026661] Modules linked in: btrfs blake2b_generic xor
xor_neon raid6_pq zstd_compress sm3_ce sha3_ce fuse drm backlight
ip_tables x_tables
<4>[   90.027952] CPU: 0 UID: 0 PID: 42 Comm: kworker/u8:2 Not tainted
6.16.0-rc3-next-20250626 #1 PREEMPT
<4>[   90.029043] Hardware name: linux,dummy-virt (DT)
<4>[   90.029524] Workqueue: writeback wb_workfn (flush-7:0)
<4>[   90.030050] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 90.030311] pc : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
<4>[ 90.030481] lr : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
<4>[   90.030656] sp : ffffc000805cb650
<4>[   90.030785] x29: ffffc000805cb690 x28: fff00000dd1f5000 x27:
ffffde2ec0272000
<4>[   90.031097] x26: 00000000000001a0 x25: 0000000000000015 x24:
0000000000000002
<4>[   90.031360] x23: 0000000000000015 x22: 0000000000000c40 x21:
0000000000000008
<4>[   90.031618] x20: fff00000c231da78 x19: fff00000c231da78 x18:
0000000000000000
<4>[   90.031875] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[   90.032859] x14: 0000000000000000 x13: 00000000ffffffff x12:
0000000000000000
<4>[   90.033225] x11: 0000000000000000 x10: ffffde2ebfba8bd0 x9 :
ffffde2ebd34e944
<4>[   90.033607] x8 : ffffc000805cb278 x7 : 0000000000000000 x6 :
0000000000000001
<4>[   90.033971] x5 : ffffde2ebfb29000 x4 : ffffde2ebfb293d0 x3 :
0000000000000000
<4>[   90.034294] x2 : 0000000000000000 x1 : fff00000c04dc080 x0 :
000000000000004c
<4>[   90.034772] Call trace:
<4>[ 90.035068] start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1)) (P)
<4>[ 90.035366] jbd2__journal_start (fs/jbd2/transaction.c:501)
<4>[ 90.035586] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
<4>[ 90.035807] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242
fs/ext4/inode.c:2846)
<4>[ 90.036004] ext4_writepages (fs/ext4/inode.c:2953)
<4>[ 90.036233] do_writepages (mm/page-writeback.c:2636)
<4>[ 90.036406] __writeback_single_inode (fs/fs-writeback.c:1680)
<4>[ 90.036616] writeback_sb_inodes (fs/fs-writeback.c:1978)
<4>[ 90.036891] wb_writeback (fs/fs-writeback.c:2156)
<4>[ 90.037122] wb_workfn (fs/fs-writeback.c:2303 (discriminator 1)
fs/fs-writeback.c:2343 (discriminator 1))
<4>[ 90.037318] process_one_work (kernel/workqueue.c:3244)
<4>[ 90.037517] worker_thread (kernel/workqueue.c:3316 (discriminator
2) kernel/workqueue.c:3403 (discriminator 2))
<4>[ 90.037752] kthread (kernel/kthread.c:463)
<4>[ 90.037903] ret_from_fork (arch/arm64/kernel/entry.S:863)
<4>[   90.038217] ---[ end trace 0000000000000000 ]---
<2>[   90.039950] EXT4-fs (loop0): ext4_do_writepages: jbd2_start:
9223372036854775807 pages, ino 14; err -28
<3>[   90.040291] JBD2: kworker/u8:2 wants too many credits
credits:416 rsv_credits:21 max:334
<4>[   90.040374] ------------[ cut here ]------------
<4>[ 90.040386] WARNING: fs/jbd2/transaction.c:334 at
start_this_handle+0x4c0/0x4e0, CPU#1: 2/42


## Source
* Kernel version: 6.16.0-rc3-next-20250626
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: ecb259c4f70dd5c83907809f45bf4dc6869961d7
* Git describe: 6.16.0-rc3-next-20250626
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250626/
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: gcc-13-lkftconfig-64k_page_size

## Build arm64
* Test log: https://qa-reports.linaro.org/api/testruns/28894530/log_file/
* Test LAVA log 1:
https://lkft.validation.linaro.org/scheduler/job/8331353#L6841
* Test LAVA log 2:
https://lkft.validation.linaro.org/scheduler/job/8331352#L8854
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250626/log-parser-test/exception-warning-fsjbd2transaction-at-start_this_handle/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/config

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
