Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580A9C04A6A
	for <ltp@archiver.kernel.org>; Fri,  4 Aug 2023 06:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC0C3CD49C
	for <ltp@archiver.kernel.org>; Fri,  4 Aug 2023 08:37:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E19E3CB9A0
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 08:37:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 94F971000D58
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 08:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691131041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRbNEV/g+3SWffCtpqnTW+44zOe74EJ4R0UlzfLRMdg=;
 b=estP8MlUPohsgM+Tcvp+oWi2TjlWOITz9LYdoD0I/2H0yP2U+NQqMH+kxmsjbzzNzfTHRT
 fYX4gdfpdZLxVwfamK4Fl7btgSky07NoeEodf8Rr+Yd3D7+C5tzONus996aOjD3yIVnLK2
 Ua1Ay1CUFAHkT8QLxay1AdSxrDZd66M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-AP7J6ikYNTe3vHlFYS9eMA-1; Fri, 04 Aug 2023 02:37:19 -0400
X-MC-Unique: AP7J6ikYNTe3vHlFYS9eMA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63cf3020a29so19525596d6.0
 for <ltp@lists.linux.it>; Thu, 03 Aug 2023 23:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691131039; x=1691735839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRbNEV/g+3SWffCtpqnTW+44zOe74EJ4R0UlzfLRMdg=;
 b=ecOQ3RFTsSv+ZI2N6FcEa+UfiseZCqbeVwcFFcx/HuADz3ybWG4Ax+7PPGL3XiRhI6
 0KcIa8Ywb+/FARMWU3sm5gQ+6ibsIBCrfFED8rDW4nQIIt5d7LIUiD5kwO5Ls0lmb/lN
 r5Igw9v/hfUe0nxS3B8kK6Y/FVK6KVc9SH446pqwpA92SL9aHB9LG3+aXyDcFPjWCWxH
 UqVPURui+nLny8nyz6j5N4aG7LhDj478Um9zeGFOjuS1NSX59aAsxPFHB24wPxRQ9Qn2
 yNz0vrf0cu8fHwLGm84VyN/Y8eAZcNAHDAEZOkVV/5yVC1j8RwBguho2AB3aPzvog/+i
 Md2A==
X-Gm-Message-State: AOJu0YzEPVRn5Gih6Ryc8xlgd40TWoseTA8DpGrlQjAhov7VcCcD9bno
 hUxQjJp3o39Hvuf5TrYdBTXMXF2AiBahWcD/8EuYsh8PzTMmUT7t6WQl9Mi72d7Tv446ncR22+i
 dF0smErUzSp0=
X-Received: by 2002:a05:622a:44f:b0:404:a649:879c with SMTP id
 o15-20020a05622a044f00b00404a649879cmr1022818qtx.49.1691131038969; 
 Thu, 03 Aug 2023 23:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQAEaqfcC9XZlm+xYVaRBqSvtLqOU49iCHOkXeJwSJ4Vq7u3O4eD+BrXMQHkYycIHuMGVRvA==
X-Received: by 2002:a05:622a:44f:b0:404:a649:879c with SMTP id
 o15-20020a05622a044f00b00404a649879cmr1022804qtx.49.1691131038689; 
 Thu, 03 Aug 2023 23:37:18 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 7-20020a17090a034700b002681bda127esm920379pjf.35.2023.08.03.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 23:37:18 -0700 (PDT)
Date: Fri, 4 Aug 2023 16:37:11 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Minchan Kim <minchan@kernel.org>
Message-ID: <ZMycl7xKyJoQNpcu@fedora19.localdomain>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
MIME-Version: 1.0
In-Reply-To: <Y2l3vJb1y2Jynf50@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
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
Cc: Jens Axboe <axboe@kernel.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 07, 2022 at 01:25:16PM -0800, Minchan Kim wrote:
> > following bug is trying to workaround an error on ppc64le, where
> > zram01.sh LTP test (there is also kernel selftest
> > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > updates) has often mem_used_total 0 although zram is already filled.

> Is it happening on only ppc64le?

I have managed to replicate this on an arm64 system.  I frankly don't
know what is so special about it -- it's a qemu guest and I'm not sure
what exactly it's running ontop of.

> Is it a new regression? What kernel version did you use?

I've replicated this on 4.18.0; obviously something more recent would
be useful but I'm hesitant to destroy too much state in case it is
something ...

> Actually, mem_used_total indicates how many *physical memory* were
> currently used to keep original data size.
> 
> However, if the test data is repeated pattern of unsigned long
> (https://github.com/torvalds/linux/blob/master/drivers/block/zram/zram_drv.c#L210)
> zram doesn't allocate the physical memory but just mark the unsigned long's value
> in meta area for decompression later.

To recap; this test [1] creates a zram device, makes a filesystem on
it, and fills it with sequential 1k writes from /dev/zero via dd.  The
problem is that it sees the mem_used_total for the zram device as zero
in the sysfs stats after the writes; this causes a divide by zero
error in the script calculation.

An annoted extract:

 zram01 3 TINFO: /sys/block/zram1/disksize = '26214400'
 zram01 3 TPASS: test succeeded
 zram01 4 TINFO: set memory limit to zram device(s)
 zram01 4 TINFO: /sys/block/zram1/mem_limit = '25M'
 zram01 4 TPASS: test succeeded
 zram01 5 TINFO: make vfat filesystem on /dev/zram1

 >> at this point a cat of /sys/block/zram1/mm_stat shows
 >>   65536      527    65536 26214400    65536        0        0        0

 zram01 5 TPASS: zram_makefs succeeded
 zram01 6 TINFO: mount /dev/zram1
 zram01 6 TPASS: mount of zram device(s) succeeded
 zram01 7 TINFO: filling zram1 (it can take long time)
 zram01 7 TPASS: zram1 was filled with '25568' KB

 >> at this point "ls -lh" shows the file
 >> total 25M
 >> -rwxr-xr-x. 1 root root 25M Aug  4 01:06 file

 >> however, /sys/block/zram1/mm_stat shows
 >>   9502720        0        0 26214400   196608      145        0        0
 >> the script reads this zero value and tries to calculate the
 >> compression ratio

 ./zram01.sh: line 145: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

 >> If we do a "sync" then redisply the mm_stat after, we get
 >>   26214400     2842    65536 26214400   196608      399        0        0

I have managed to instrument this, and in the following

 static ssize_t mm_stat_show(struct device *dev,
                struct device_attribute *attr, char *buf)
 {
  ...
        if (init_done(zram)) {
		mem_used = zs_get_total_pages(zram->mem_pool);
                pr_info("mm_stat_show: init done %p %lld\n", zram->mem_pool, mem_used);
                zs_pool_stats(zram->mem_pool, &pool_stats);

zs_get_total_pages(zram->mem_pool) is definitely zero, which is why
the mm_stat is returning zero.  i.e. zsmalloc really doesn't seem to
have any pages recorded for that mem_pool ...

This doesn't seem to make sense; how can a device that has a file
system on it not even have one page assigned to it in zram->mem_pool?

I *think* this has something to do with the de-deuplication as noted.
If I stub out page_same_filled() to return false always, we see instead

 zram01 7 TPASS: zram1 was filled with '25568' KB
 >>  < immediately after >
 >> 10223616    48516   131072 26214400   196608        0        0        0
 >>  < after sync >
 >> 26214400   126933   327680 26214400   327680        0        0        0

So I think this test still needs a sync to be sure that it's seeing
the right values?  It's probably expected that this takes some time to
write everything out?

But is it possible that mem_used_total being zero is a bug -- possibly
triggered by the de-dup path and the test writing the same thing in
every block?  Something like the first de-duped page also being thrown
out?

-i

[1] https://github.com/linux-test-project/ltp/blob/8c201e55f684965df2ae5a13ff439b28278dec0d/testcases/kernel/device-drivers/zram/zram01.sh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
