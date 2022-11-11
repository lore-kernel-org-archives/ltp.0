Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44763C433FE
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 08:38:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B5B33CD51D
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:38:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 286753CAAE3
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 01:48:39 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D576F10007EF
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 01:48:38 +0100 (CET)
Received: by mail-pf1-x42e.google.com with SMTP id z26so3578221pff.1
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 16:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/gUNRy1qZIXrqUZUL7883/f/GJegibYfXZQZVngW38U=;
 b=VWZwrH2WTLZH7q/x1ZgpdvYSrGqwsN5f7i9ypcQ7UreI7sa/e03yNK6qv9VxqDlXP8
 i04ZhlEljAEqFDY6vjaYs/QXE3J3167rQ2D69YQqoO8AcyVoep415lPw40kShPC8NBdV
 9bzPkkL603xzDjwINJOebgWujA4I8bQIIWYOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gUNRy1qZIXrqUZUL7883/f/GJegibYfXZQZVngW38U=;
 b=da0tqb6qUhsQCuUOW+J8zrllZM2R0A44kP9OY2dSIjJlH1W9I8K+1oyeePw0NEYAPN
 0vYFHrUh5S/9JKA72Vfl8HlrLYx8vAEZINUBAWHrHZfRl/dg28Y4BrtAQx9D11ldd/5E
 Hih3k6Z0RI2UguEv74V3meI+tXg3tfam30uCMz3z9Yr9vV+GYZHHMZ5MXBSQ7ba2mCbF
 DM3PSLQNz9wSifumfjSJNcNmVh9YJxlVTgVCDiuAODCMgR/O8lQ/yaXB888yS+zChLEM
 UPCcGp4T/gPabStu/OtrgY/gYTD4KJ0FeqPwh649YMt89Xzo98oV4qzUx5tb19hkNLsp
 v2oQ==
X-Gm-Message-State: ACrzQf03RT4SZiUIKxo3P8zgbBI17oCkQYgpvso23Tq0UjqvRzcpl+pE
 G6byK0Zrz2LzXqS6bmxrSQBZOA==
X-Google-Smtp-Source: AMsMyM7sIWgS/0TfYwBT7X/dzMu66eUOL/4N1tpn2UCyic5dZmo1cMUhDUlzUKuzT+rqzDYvi7knxQ==
X-Received: by 2002:a63:fc14:0:b0:43c:2e57:97df with SMTP id
 j20-20020a63fc14000000b0043c2e5797dfmr3852168pgi.189.1668127717205; 
 Thu, 10 Nov 2022 16:48:37 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a632006000000b004388ba7e5a9sm221005pgg.49.2022.11.10.16.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 16:48:36 -0800 (PST)
Date: Fri, 11 Nov 2022 09:48:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y22b3wWs2QfMjJHi@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Nov 2022 09:38:05 +0100
Subject: Re: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Cc: Jens Axboe <axboe@kernel.dk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 linux-kselftest@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On (22/11/10 15:29), Martin Doucha wrote:
> New version of LTP test zram01 found a sysfile issue with zram devices
> mounted using VFAT filesystem. When when all available space is filled, e.g.
> by `dd if=/dev/zero of=/mnt/zram0/file`, the corresponding sysfile
> /sys/block/zram0/mm_stat will report that the compressed data size on the
> device is 0 and total memory usage is also 0. LTP test zram01 uses these
> values to calculate compression ratio, which results in division by zero.
> 
> The issue is specific to PPC64LE architecture and the VFAT filesystem. No
> other tested filesystem has this issue and I could not reproduce it on other
> archs (s390 not tested). The issue appears randomly about every 3 test runs
> on SLE-15SP2 and 15SP3 (kernel 5.3). It appears less frequently on SLE-12SP5
> (kernel 4.12). Other SLE version were not tested with the new test version
> yet. The previous version of the test did not check the VFAT filesystem on
> zram devices.

Whoooaa...

> I've tried to debug the issue and collected some interesting data (all
> values come from zram device with 25M size limit and zstd compression
> algorithm):
> - mm_stat values are correct after mkfs.vfat:
> 65536      220    65536 26214400    65536        0        0        0
> 
> - mm_stat values stay correct after mount:
> 65536      220    65536 26214400    65536        0        0        0
> 
> - the bug is triggered by filling the filesystem to capacity (using dd):
> 4194304        0        0 26214400   327680       64        0        0

Can you try using /dev/urandom for dd, not /dev/zero?
Do you still see zeroes in sysfs output or some random values?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
