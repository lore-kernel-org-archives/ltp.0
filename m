Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00819C83030
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 10:54:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FEB83C9AA8
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 12:54:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFCDD3C9199
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 12:47:14 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12DAD1A0049E
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 12:47:14 +0200 (CEST)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23c76ed4a7fso11298945ad.1
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751539632; x=1752144432; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yT116BmQVYQp7TgXBQY166ymvqYjgN3gIl7mlb2d3wM=;
 b=YZD68nmxEuVVH9ct1m+KyEQQMtE4DcFF6/9dDeDJX8q6gYifhCjXRoXnpHqh49Lwh5
 GLZF31mjWrkXk+x0gB3vpPWHjQZbDhQWR+Iq0mCAT0ALFlj6En5tl0fuLd6mRHb4ipI0
 HChrQCgQPhgEeioyrl7UxRnYF/vNpocEoRO/NpB5Yz5i+6Qe3hGeKGZbzzWR3C6pslb5
 OKVrbZ5IEkKvPiztkvk5M383pcSaP3XRQy7ta7tyO5NlDZwBidquqLF3sSgTJiHWmHcR
 NmeOkNVr5f7vBQ4egf1cfu7gHFnGXimN2jXltBdY6lEg+nY7Dka8OTX0l03y0xmpZXEA
 CXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751539632; x=1752144432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yT116BmQVYQp7TgXBQY166ymvqYjgN3gIl7mlb2d3wM=;
 b=UYcrTzqVTJ3Hq1GTuvHGZfboMp12DOSg3dD68AGtvsGsOHqPAOqoInq1ZRhSF1oRZl
 p+4+pTqJ4OKVWqePYVYXtm1298WPmgPlZuiirXk9TYUlQHXsuCYK7LBwXuVQJfoVFQtI
 RaMJ4ufBn6E/0T0Eu5z1ioHY5H1AkG3GA5MNjpK7tH10h83QED/yAHMsX8fYZ8neeY7s
 J6/SXP3L6yVXSiQhUBylkRne/duQIbFfVzQ77G15Dp/6MZEqp4FYr0SrazroGQIzwpHc
 ko0f7VyJBXhQutyajROA0M3a00Nefd5ojpS3r26ZdEhau+0he2lBKa91lSbGVUwzAJ5N
 r0cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe6GFBNF5MKXCXa5wgq9b8qDcK5GMuZqBN84ikbReUg+BT2ye32ahQnIlTJRn+E8dwdhw=@lists.linux.it
X-Gm-Message-State: AOJu0Yy86rE+iAqIMV6KKSuBhlBicJC9oDYH8SNB1Htzzs6COiTc0Y6Y
 KUhKYSHApmL1nXCaGHKSFk1SPNcgfHIPer//B0wgvU3re6W49V+vy7as
X-Gm-Gg: ASbGncvoSjO5xpnMaJxHGC4npz2VDM/sPBjKBLlssB4niQmxz+21u8l/0YIN0e1irGt
 HMDUkp8ir21I+tjj+kWrCh7ue+3/jH8ntneYhObsFAWe+Wu/W9CrscfzEG+//9ZqRjL7FiIRtZ4
 q5WUDeeHMWCJDhaPzn+Bl7SsNaG06WnyHT/r2EgL7fJk6cjcFqyW/C7r6T4vcshnP8GUmIx1LMD
 zC1KEEvEAiyr/63WR1uM8liX0846yT9mNo+n0/906hbbgJvN/EleJHqiBO0mc4iKoSJiKe5PBZy
 ynIw2KxN6RGh6GrS7tFWreaXx9Xte+YjEM8tvIh0dpvDEDlxWjDstRKT7cOpLNoVLgJzxMXIYAs
 S/7Y=
X-Google-Smtp-Source: AGHT+IE+BSY2N3Ksp1Ngu882oItJhHDV437LBfkyE/yfOf+Y7Tt3xVRjNgqMrrvyEVdLEqjOCjXpZg==
X-Received: by 2002:a17:903:1aab:b0:234:f825:b2c3 with SMTP id
 d9443c01a7336-23c7a1f0e25mr31795975ad.17.1751539632373; 
 Thu, 03 Jul 2025 03:47:12 -0700 (PDT)
Received: from [30.221.128.104] ([47.246.101.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b9f2sm162265655ad.99.2025.07.03.03.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 03:47:12 -0700 (PDT)
Message-ID: <2ee5547a-fa11-49fb-98b7-898d20457d7e@gmail.com>
Date: Thu, 3 Jul 2025 18:47:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Zhang Yi <yi.zhang@huaweicloud.com>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 03 Jul 2025 12:53:54 +0200
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



On 2025/7/3 15:26, Naresh Kamboju wrote:
> On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>
>> Hi, Naresh!
>>
>> On 2025/6/26 20:31, Naresh Kamboju wrote:
>>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
>>> test case on the Linux next-20250616..next-20250626 with the extra build
>>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
>>>
>>> Not reproducible with 4K page size.
>>>
>>> Test environments:
>>> - Dragonboard-410c
>>> - Juno-r2
>>> - rk3399-rock-pi-4b
>>> - qemu-arm64
>>>
>>> Regression Analysis:
>>> - New regression? Yes
>>> - Reproducibility? Yes
>>>
>>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
>>> transaction.c start_this_handle
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Thank you for the report. The block size for this test is 1 KB, so I
>> suspect this is the issue with insufficient journal credits that we
>> are going to resolve.
> 
> I have applied your patch set [1] and tested and the reported
> regressions did not fix.
> Am I missing anything ?
> 
> [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
> 

I can also reproduce the similar warning with xfstests generic/730 under
64k page size + 4k block size.

Thanks,
Joseph



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
