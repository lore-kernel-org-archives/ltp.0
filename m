Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE9DC7EE23
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 09:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354733CD2C9
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 11:02:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFD93CBD83
 for <ltp@lists.linux.it>; Wed, 24 May 2023 11:02:33 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A37B200939
 for <ltp@lists.linux.it>; Wed, 24 May 2023 11:02:33 +0200 (CEST)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-439367c12ceso469292137.0
 for <ltp@lists.linux.it>; Wed, 24 May 2023 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684918952; x=1687510952;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ua6FkUKy2yQqOMjKldJnUgyegjdZw3FbhuPjicIwteg=;
 b=fKFDl8ZGGN7XNtarh49Y8oGnN/EsvWER4MjTjYlfHqkuS/8KB7f0rUvIts68PTIU6Z
 I4z2Lo+xQrwcYCKpMdns6bE9/+rEFqzuiQhyLWKTGbW6+wwVeQPx7+/6OYZNe4UpkXuM
 dtg2fMvdW/QXlMtQhHaQfvfzuAZhed0YhczXn+UOb9H30TWONqiYQb80g6n9fumbvBf8
 a0iaH34Zwawv3LhEoiojd8mEjW+BTJf02unRksZSXrD0HHKu5T7Tzp8lmrfqACx+zhhj
 DoByis3GvrH5tVeMjYqH4YgtWatyGIYbMiqLnssySAxDugcXA9C34EOXGwooZud4/kWI
 MEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684918952; x=1687510952;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ua6FkUKy2yQqOMjKldJnUgyegjdZw3FbhuPjicIwteg=;
 b=FpmUIEAPvohnZQm49BjNZunzP67s1PzQfNiGRyDaCQWjN09LxJxI3NBGrtQzSkcXQM
 7fSTtTGCBRJSAFuZ3JwKqhq4rWMGIqt/8anJW0o7xbw7J3X2Wpm7ES8qf5itOv5vqgAJ
 U64aa2nYTRZpCaLW1p4YX3mhAMGH6SB/c54tqLSDqtT7/XoPePeWkxsNZka6VJ7o7f2C
 PytQX9j+5yRqKHjyegHD8dYuQ3FBn+/qgR4/it/XZTrr/83V3mIMqvkMWmK+SOnDclsM
 7u4MKv0YJ9Lr4gZkpJTV3ZeqrbbkECCAddoV18pTg6ryDvvv2/W8XgNtS2XcD7P0qf3r
 5n8Q==
X-Gm-Message-State: AC+VfDzasdB9xYTp/mbaxO1wjDF+Ib512lAP8XWhNJHIGiE3feY5wm2R
 NqqTQTqrMHNrwW1tOMoneaFCji7YlR9G5PjdQlrOVg==
X-Google-Smtp-Source: ACHHUZ5+N5FBtl4UeP/lGj5cD/G4H09HIygf4+rwHs0U98XLci7zKstCxKdKZWSbYm/VEQwbUn1WTfmxdJCrhOmqXKc=
X-Received: by 2002:a67:f483:0:b0:439:3c9f:d040 with SMTP id
 o3-20020a67f483000000b004393c9fd040mr4503215vsn.34.1684918951760; Wed, 24 May
 2023 02:02:31 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 May 2023 14:32:20 +0530
Message-ID: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, LTP List <ltp@lists.linux.it>,
 lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
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
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While running LTP controllers following kernel crash noticed on qemu-x86_64
compat mode with stable-rc 6.3.4-rc2.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

 Linux version 6.3.4-rc2 (tuxmake@tuxmake) (x86_64-linux-gnu-gcc
(Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1
SMP PREEMPT_DYNAMIC @1684862676
..
./runltp -f controllers
...
cpuset_inherit 11 TPASS: cpus: Inherited information is right!
cpuset_inherit 13 TPASS: mems: Inherited information is right!
<4>[ 1130.117922] int3: 0000 [#1] PREEMPT SMP PTI
<4>[ 1130.118132] CPU: 0 PID: 32748 Comm: cpuset_inherit_ Not tainted
6.3.4-rc2 #1
<4>[ 1130.118216] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[ 1130.118320] RIP: 0010:__alloc_pages+0xeb/0x340
<4>[ 1130.118605] Code: 48 c1 e0 04 48 8d 84 01 00 13 00 00 48 89 45
a8 8b 05 d9 31 cf 01 85 c0 0f 85 05 02 00 00 89 d8 c1 e8 03 83 e0 03
89 45 c0 66 <90> 41 89 df 41 be 01 00 00 00 f6 c7 04 75 66 44 89 e6 89
df e8 ec
<4>[ 1130.118653] RSP: 0018:ffffa3d085d07b08 EFLAGS: 00000246
<4>[ 1130.118694] RAX: 0000000000000000 RBX: 0000000000400dc0 RCX:
ffffa2b9ffffa000
<4>[ 1130.118706] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000400dc0
<4>[ 1130.118717] RBP: ffffa3d085d07b60 R08: 00007fffffffe000 R09:
00007fffffffefff
<4>[ 1130.118728] R10: ffffa2b981faaa0c R11: 0000000000000000 R12:
0000000000000000
<4>[ 1130.118739] R13: 0000000000000000 R14: 0000000000000000 R15:
00007fffffffefec
<4>[ 1130.118783] FS:  0000000000000000(0003)
GS:ffffa2b9fbc00000(0063) knlGS:00000000f7f05880
<4>[ 1130.118798] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
<4>[ 1130.118810] CR2: 00000000f7c10bec CR3: 00000001085ba000 CR4:
00000000000006f0
<4>[ 1130.118899] Call Trace:
<4>[ 1130.118974]  <TASK>
<4>[ 1130.119069]  alloc_pages+0x94/0x140
<4>[ 1130.119128]  get_zeroed_page+0x1d/0x50
<4>[ 1130.119142]  __pud_alloc+0x33/0xe0
<4>[ 1130.119156]  __handle_mm_fault+0x50c/0x1310
<4>[ 1130.119175]  handle_mm_fault+0xf8/0x320
<4>[ 1130.119187]  ? check_vma_flags+0x53/0x130
<4>[ 1130.119199]  __get_user_pages+0x1ed/0x600
<4>[ 1130.119214]  get_user_pages_remote+0x137/0x3c0
<4>[ 1130.119229]  get_arg_page+0x65/0x150
<4>[ 1130.119245]  copy_string_kernel+0xd7/0x1e0
<4>[ 1130.119258]  do_execveat_common.isra.0+0x11e/0x240
<4>[ 1130.119272]  __ia32_compat_sys_execve+0x3f/0x50
<4>[ 1130.119285]  __do_fast_syscall_32+0x6b/0xf0
<4>[ 1130.119300]  do_fast_syscall_32+0x38/0x80
<4>[ 1130.119312]  do_SYSENTER_32+0x23/0x30
<4>[ 1130.119324]  entry_SYSENTER_compat_after_hwframe+0x7f/0x91
<4>[ 1130.119374] RIP: 0023:0xf7f0a579
<4>[ 1130.119570] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10
08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5
0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00
00 00 00
<4>[ 1130.119578] RSP: 002b:00000000ffcc16e8 EFLAGS: 00000206
ORIG_RAX: 000000000000000b
<4>[ 1130.119594] RAX: ffffffffffffffda RBX: 00000000086cc480 RCX:
00000000086d8810
<4>[ 1130.119600] RDX: 00000000086dc490 RSI: 00000000086cc480 RDI:
0000000000000020
<4>[ 1130.119605] RBP: 00000000086d6270 R08: 0000000000000000 R09:
0000000000000000
<4>[ 1130.119610] R10: 0000000000000000 R11: 0000000000000206 R12:
0000000000000000
<4>[ 1130.119614] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
<4>[ 1130.119652]  </TASK>
<4>[ 1130.119698] Modules linked in:
<4>[ 1130.148538] ---[ end trace 0000000000000000 ]---
<4>[ 1130.148708] RIP: 0010:__alloc_pages+0xeb/0x340
<4>[ 1130.148907] Code: 48 c1 e0 04 48 8d 84 01 00 13 00 00 48 89 45
a8 8b 05 d9 31 cf 01 85 c0 0f 85 05 02 00 00 89 d8 c1 e8 03 83 e0 03
89 45 c0 66 <90> 41 89 df 41 be 01 00 00 00 f6 c7 04 75 66 44 89 e6 89
df e8 ec
<4>[ 1130.148923] RSP: 0018:ffffa3d085d07b08 EFLAGS: 00000246
<4>[ 1130.148947] RAX: 0000000000000000 RBX: 0000000000400dc0 RCX:
ffffa2b9ffffa000
<4>[ 1130.148952] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000400dc0
<4>[ 1130.148958] RBP: ffffa3d085d07b60 R08: 00007fffffffe000 R09:
00007fffffffefff
<4>[ 1130.148963] R10: ffffa2b981faaa0c R11: 0000000000000000 R12:
0000000000000000
<4>[ 1130.148968] R13: 0000000000000000 R14: 0000000000000000 R15:
00007fffffffefec
<4>[ 1130.148974] FS:  0000000000000000(0003)
GS:ffffa2b9fbc00000(0063) knlGS:00000000f7f05880
<4>[ 1130.148981] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
<4>[ 1130.148987] CR2: 00000000f7c10bec CR3: 00000001085ba000 CR4:
00000000000006f0
<0>[ 1130.149129] Kernel panic - not syncing: Fatal exception in interrupt
<0>[ 1130.152835] Kernel Offset: 0x8400000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17170153/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17170153/suite/log-parser-test/test/check-kernel-panic/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17170153/suite/log-parser-test/test/check-kernel-panic/details/

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
