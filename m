Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5EDC3DA5D
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 20:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 909733D1B54
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 22:21:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227663D1A76
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 22:21:31 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5509C60132C
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 22:21:30 +0200 (CEST)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc5c0c65bcso2266415ad.2
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721420489; x=1722025289;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7TdICET9y2kBW1nT7B+XzjYYxpouKddOEs+h65MAYd8=;
 b=iqrHwCi/EakY875R5sBfIpOrd5ue6rhgqTr0Ls3Qxi9TBFoWtT4EfWLEDSY3+ayk3f
 tWzTlbOJbijNkKZ2RM5LN5t4vzznku2Aao4qkIJ3hb1JSys5kiuaBrBBPqER1LRmdmvJ
 ZptfffBSnWrbQFI7IDetkIgLeAtD0ZreVyk/Yo/0KXq+74ugTBWbykHrFbtpNhQAG080
 ywhbNiSe3pjcInbKPbx7Z6DKHH/TIY0locfWlo9K366jtOf0VNRw/qlx3y5WQlrntzHi
 +3cCaVXauIJQS690P+e/EJIwRiOFH7q+vE2DjstC/JQG32osGe6OXcV1IFpg6sSsVeMw
 HJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721420489; x=1722025289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7TdICET9y2kBW1nT7B+XzjYYxpouKddOEs+h65MAYd8=;
 b=N+f1xG1kJiqEFy5gSAFocigE6Hk6WFXveM3VbHaQxAE4XnyBjDdqRsCSBwq0sFGxM8
 FCVrHg1ZrGEuHtKLGjxN5znD3sJVWvy1Eo/W1NTB/Z8gwisB7pAiZtymMAnD95V+E4xW
 yk5nm1jqUej/4itl5WJp5cuk5XLygHKC5hyqu5cYNtsDUmHfgVCnDntERXB8j6sib8Zt
 kYHdWAToGZ10DQ+FqjuZhcUkGHC9L5Em+++220VLAHfqty4PazPRn0Mp7+5mtJmVSz+C
 jY7fz+oly2Gktisr5uFbhgljPWv2ULGHwJ3/vwch8T2EZIvTgjkAgcQeoG5qJcDkVhcI
 0ivQ==
X-Gm-Message-State: AOJu0YxEcuRAXpIWzROMZd+lVpekOhQiQMnpXErboPSrTJZboKFhGIdI
 UmkaiaJxR2GbqvFnHE7BgN6zfVfoz7j5GVbGOsIOv4doF29mt5DAVK6kDClRFeQ=
X-Google-Smtp-Source: AGHT+IFBmO+K7zL/agidVg2Z92TSxmmwPsuaZhiJ7FdU+invzsnYzP+ED6r48gQMg6agGpkBHJtLpw==
X-Received: by 2002:a05:6a21:6e4b:b0:1c3:b106:d293 with SMTP id
 adf61e73a8af0-1c42287e800mr783432637.3.1721420488617; 
 Fri, 19 Jul 2024 13:21:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff552c39sm1565712b3a.136.2024.07.19.13.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 13:21:27 -0700 (PDT)
Message-ID: <173c7d32-2fae-40e4-a1d8-490cee3bba15@kernel.dk>
Date: Fri, 19 Jul 2024 14:21:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240719174325.GA775414@pevik>
 <a59b75dd-8e82-4508-a34e-230827557dcb@kernel.dk>
 <20240719201352.GA782769@pevik>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240719201352.GA782769@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Slow down of LTP tests aiodio_sparse.c and
 dio_sparse.c in kernel 6.6
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
Cc: linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>, fstests@vger.kernel.org,
 linux-block@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 ltp@lists.linux.it, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/19/24 2:13 PM, Petr Vorel wrote:
> Hi Jens, all,
> 
>> On 7/19/24 11:43 AM, Petr Vorel wrote:
>>> Hi all,
> 
>>> LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
>>> down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
>>> tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
>>> 16 other processes reads the buffer and check only zero is there.
> 
>>> Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
>>> same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
>>> (Non default parameter creates much smaller file, thus the change is not that
>>> obvious).
> 
>>> Because the slowdown has been here for few kernel releases I suppose nobody
>>> complained and the test is somehow artificial (nobody uses this in a real world).
>>> But still it'd be good to double check the problem. I can bisect a particular
>>> commit.
> 
>>> Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
>>> performance" [4] block layer change somehow related?
> 
>> No, because that got disabled before release for unrelated reasons. Why
>> don't you just bisect it, since you have a simple test case?
> 
> Jens, thanks for info. Sure, I'll bisect next week and report.
> 
> The reason I reported before bisecting is because it wouldn't be the
> first time the test was "artificial" and therefore reported problem
> was not fixed. If it's a real problem I would expect it would be also
> caught by other people or even by fstests.

Didn't look at the test cases, so yeah may very well be bogus. But it
also may not... And a bisection may help shine some light on that too,
outside of just highlighting what commit made it slower.

-- 
Jens Axboe


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
