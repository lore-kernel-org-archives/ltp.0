Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D81C8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 07:22:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADB873CA339
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:22:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567323C0980
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 03:43:36 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A59D31000416
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 03:43:35 +0200 (CEST)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2363616a1a6so22594355ad.3
 for <ltp@lists.linux.it>; Sun, 06 Jul 2025 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751852614; x=1752457414; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ0QVfcPqBxlG+BwXU72MLxNR3PM6YaC0rXqHjP+Erg=;
 b=K7FE2D5tShNjEHOu9wVfRO/Mfm2mzfLcDOtnPxVs2PUAQWFvv7e4G/Udb0+mogrAGV
 XEGI6xo+hFSiWd9zi251NcB/eCYelkj4UFdAK/YsAKFubDZY8eEptcPfDsoHhKppEua9
 DVV7CgM0u7hLcSOLO7yMrj1NdsYVZlNEBHdY2DoAx++wGjLdPHdQ58ku2gonsvmm/HkS
 FUbu5AFyM9BxjPKxKcFpiqlUQCupDfZ18bM1irI7uDnftnkIigciieVkvEzoTtS7uSRq
 1D+h0Ebbj0Fgj1GReoM1TCz6aTsdNojqjrY5wAqsQXUtm4X5va2FElTFshdXOnto2xEp
 S01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751852614; x=1752457414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mQ0QVfcPqBxlG+BwXU72MLxNR3PM6YaC0rXqHjP+Erg=;
 b=eC3oi4FrPGJUPlJ12rWQbFKAmTn/tU7BU9gIvmXh2auBOfypTcdJInOSrmIf5wEjDm
 tdkDQaltANzmBV8OXDTUxAleBytXGoEklxdIrEpZFq5WTdutXAschWEyJ/E0H18qrFhH
 pPxIx533zW8loK93VcSaeDB5Wfcx3uNbiEApx99mKgQsZl0R8D4iFWnZIRby1t9kEypE
 LJigDBhl7A5Bgt5ZNjyoY7xWl5vEIEWaO+Xdnn5q9BBmGhiX7COq1t39p5FIP/E9iEd5
 /i5mzqdjDXDbeIpSZ8Xs7wkDZ7MZLlaQQXHtkp/icX9IUxeWmIB3Vi1nuQDlifJUt3gZ
 QN1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlenucqST4dPeMTwG5qp5OExT3WTTT0aeIBd3sOd4Jkl62o6FrRuvp28HhyDdB1vuTAvs=@lists.linux.it
X-Gm-Message-State: AOJu0Yx+cuZSajD2XVDbOIHzwAk+dF5b8BXBYkV8EjRrLj8ITi6bzJNP
 588f1vPR4UoB2f+MkFV8ZRHk6czbwt03bo0aCm+9fX4fuP9iFQ4JrrZg
X-Gm-Gg: ASbGncshCYnXyUuKHozH+wJnq1mIRK1T8bgpdoKOaKhMuvyqikSz9Ly4cVc6uxB+kBm
 ur3Q+zGl+g4mnSNHRv7AiSTmjGKwB60bZ0N0SzSYx+gZAT6s1NgkooxrWyW3rIU481gHWQAfPAv
 N2dH3kYzHnpjkykLcYUIzsnenK9BJo/s11vTharl6uS20vo/em6b0maaFzKVnmzPj/vn3cjtaQ9
 rbpYKftFKVd2M6JCyQWszmex7DT1QRbi2HwXVSep04wPSFXejPIi4FFOhtwvcV2hD0qIrO1UtTt
 1XuLZjaTzOqaOmhB87/30iLhtDAeYjNAFk9tip+Z6tI16b+Qlpm/bUZs0y/Adkl930m1AzOI+lH
 U+ro=
X-Google-Smtp-Source: AGHT+IHNt7WBHbqYkIjNosgrP7JpZnQJUROnNvYMUGxq5civC/rNorosebcQakFdz4ycPFVURZ8NHQ==
X-Received: by 2002:a17:903:244d:b0:235:2375:7eaa with SMTP id
 d9443c01a7336-23c8747eb6cmr172434375ad.22.1751852613869; 
 Sun, 06 Jul 2025 18:43:33 -0700 (PDT)
Received: from [30.221.128.189] ([47.246.101.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8457bea4sm77287425ad.146.2025.07.06.18.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jul 2025 18:43:33 -0700 (PDT)
Message-ID: <5db1e0c2-a192-4883-9535-dd269efdff74@gmail.com>
Date: Mon, 7 Jul 2025 09:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Yi <yi.zhang@huaweicloud.com>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
 <2ee5547a-fa11-49fb-98b7-898d20457d7e@gmail.com>
 <094a1420-9060-4dcf-9398-8873193f5f7b@huaweicloud.com>
From: Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <094a1420-9060-4dcf-9398-8873193f5f7b@huaweicloud.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 08 Jul 2025 09:22:13 +0200
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



On 2025/7/5 15:10, Zhang Yi wrote:
> On 2025/7/3 18:47, Joseph Qi wrote:
>>
>>
>> On 2025/7/3 15:26, Naresh Kamboju wrote:
>>> On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>>>
>>>> Hi, Naresh!
>>>>
>>>> On 2025/6/26 20:31, Naresh Kamboju wrote:
>>>>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
>>>>> test case on the Linux next-20250616..next-20250626 with the extra build
>>>>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
>>>>>
>>>>> Not reproducible with 4K page size.
>>>>>
>>>>> Test environments:
>>>>> - Dragonboard-410c
>>>>> - Juno-r2
>>>>> - rk3399-rock-pi-4b
>>>>> - qemu-arm64
>>>>>
>>>>> Regression Analysis:
>>>>> - New regression? Yes
>>>>> - Reproducibility? Yes
>>>>>
>>>>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
>>>>> transaction.c start_this_handle
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>
>>>> Thank you for the report. The block size for this test is 1 KB, so I
>>>> suspect this is the issue with insufficient journal credits that we
>>>> are going to resolve.
>>>
>>> I have applied your patch set [1] and tested and the reported
>>> regressions did not fix.
>>> Am I missing anything ?
>>>
>>> [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
>>>
>>
>> I can also reproduce the similar warning with xfstests generic/730 under
>> 64k page size + 4k block size.
>>
> 
> Hi, Joseph!
> 
> I cannot reproduce this issue on my machine. Theoretically, the 'rsv_credits'
> should be 113 under 64k page size + 4k block size, I don't think it would
> exceed the max user trans buffers. Could you please give more details?
> What is the configuration of your xfstests? and what does the specific error
> log look like?
> 
I'm testing on arm 64K ECS with xfstests local.config as follows:

export TEST_DEV=/dev/nvme1n1p1
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/nvme1n1p2
export SCRATCH_MNT=/mnt/scratch

Each disk part is 250G and formated with 4k block size.

The dmesg shows the following warning:

[  137.174661] JBD2: kworker/u32:0 wants too many credits credits:32 rsv_credits:1577 max:2695
...
[  137.175544] Call trace:
[  137.175545]  start_this_handle+0x3bc/0x3d8 (P)
[  137.175548]  jbd2__journal_start+0x10c/0x248
[  137.175550]  __ext4_journal_start_sb+0xe4/0x1b0
[  137.175553]  ext4_do_writepages+0x430/0x768
[  137.175556]  ext4_writepages+0x8c/0x118
[  137.175558]  do_writepages+0xac/0x180
[  137.175561]  __writeback_single_inode+0x48/0x328
[  137.175563]  writeback_sb_inodes+0x244/0x4a0
[  137.175564]  wb_writeback+0xec/0x3a0
[  137.175566]  wb_do_writeback+0xc0/0x250
[  137.175568]  wb_workfn+0x70/0x1b0
[  137.175570]  process_one_work+0x180/0x400
[  137.175573]  worker_thread+0x254/0x2c8
[  137.175575]  kthread+0x124/0x130
[  137.175577]  ret_from_fork+0x10/0x20
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
