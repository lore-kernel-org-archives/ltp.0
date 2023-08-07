Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95665EB64DD
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 04:44:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12CA33CD1F7
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 06:44:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12D733CB482
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 06:44:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 418A6600726
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 06:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691383450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+2EbnFZV7yJtZskjh+cWG4NxmXWzvfmJSRPX0ne/hU=;
 b=Gok80n6k1JA4onMrnAOha7hVQmzE3KGkcH1CF9kCML69KMTZHbOMvtogNX9wN952GTSls2
 oGCWho1F2/eKtmUMuyBK9SiRTdAXXZBCgCmzaN8vCFrAXCyawxfqtTKJf53Xyc9brZ1nu2
 wmoBdb6/15s6F4QzEn45WXClSyS7CMg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-qPKX1K-jNMWw1tYDtYEN2Q-1; Mon, 07 Aug 2023 00:44:08 -0400
X-MC-Unique: qPKX1K-jNMWw1tYDtYEN2Q-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-686b9ab0174so2583361b3a.2
 for <ltp@lists.linux.it>; Sun, 06 Aug 2023 21:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691383447; x=1691988247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+2EbnFZV7yJtZskjh+cWG4NxmXWzvfmJSRPX0ne/hU=;
 b=Qf/HuvINGomRD8AF4TST908kd3KFx6H+nkjLF7wosDxwipNh5OORSt73CEfEWmzOTt
 XE60ZM3bNPA0E85OIrsz70abcD6JFpA2ZK5vAIu+BFBUfBwSwKCAGo42OFAIwVgHsU95
 0Gg0XEbVzEZHzdMQfoX9U2e2PhyctZIYJkgL5LFRmkP9b7eWrhimTdTvdm4ThTF5seHR
 SI2HPwn98Hw0hkrY7IkBdM2LPO0ykVz07TbcVddT1jjHDAY0834lmDJsklLB/La0u/gg
 N7GvTFWqLRZpI3T4lF5DyFMVFfTQ4xEvbRUW9nBPqEvA1vyrJOcj9f6Zhu/KOSU8FIZJ
 Pe1g==
X-Gm-Message-State: AOJu0YxKB9D+GgHAmTQL3fk4lb2GnF+JzNjiYQs02gc8MewUQdVYs+wm
 KMb+fAZn5arnHAWe/RH4i4t8CQcnx7BwzsNhh5KmGveRV4sSGxAt/5JS4s10jX6nZroYkmZv9Np
 CBNmAWJGJqac=
X-Received: by 2002:a05:6a20:1006:b0:125:f3d8:e65b with SMTP id
 gs6-20020a056a20100600b00125f3d8e65bmr7292044pzc.18.1691383447641; 
 Sun, 06 Aug 2023 21:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDShi2vAdRaNGp+RB4NdbaHvukAeLo4WlRfe0u382qDdlhARlZSEovvdd8LQZl2heUKcBudQ==
X-Received: by 2002:a05:6a20:1006:b0:125:f3d8:e65b with SMTP id
 gs6-20020a056a20100600b00125f3d8e65bmr7292025pzc.18.1691383447235; 
 Sun, 06 Aug 2023 21:44:07 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 iz7-20020a170902ef8700b001b895a17429sm5697860plb.280.2023.08.06.21.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Aug 2023 21:44:06 -0700 (PDT)
Date: Mon, 7 Aug 2023 14:44:00 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Minchan Kim <minchan@kernel.org>
Message-ID: <ZNB2kORYiKdl3vSq@fedora19.localdomain>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <ZMycl7xKyJoQNpcu@fedora19.localdomain>
MIME-Version: 1.0
In-Reply-To: <ZMycl7xKyJoQNpcu@fedora19.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

After thinking it through, I think I might have a explanation...

On Fri, Aug 04, 2023 at 04:37:11PM +1000, Ian Wienand wrote:
> To recap; this test [1] creates a zram device, makes a filesystem on
> it, and fills it with sequential 1k writes from /dev/zero via dd.  The
> problem is that it sees the mem_used_total for the zram device as zero
> in the sysfs stats after the writes; this causes a divide by zero
> error in the script calculation.
> 
> An annoted extract:
> 
>  zram01 3 TINFO: /sys/block/zram1/disksize = '26214400'
>  zram01 3 TPASS: test succeeded
>  zram01 4 TINFO: set memory limit to zram device(s)
>  zram01 4 TINFO: /sys/block/zram1/mem_limit = '25M'
>  zram01 4 TPASS: test succeeded
>  zram01 5 TINFO: make vfat filesystem on /dev/zram1
> 
>  >> at this point a cat of /sys/block/zram1/mm_stat shows
>  >>   65536      527    65536 26214400    65536        0        0        0
> 
>  zram01 5 TPASS: zram_makefs succeeded

So I think the thing to note is that mem_used_total is the current
number of pages (reported * PAGE_SIZE) used by the zsmalloc allocator
to store compressed data.

So we have made the file system, which is now quiescent and just has
basic vfat data; this is compressed and stored and there's one page
allocated for this (arm64, 64k pages).

>  zram01 6 TINFO: mount /dev/zram1
>  zram01 6 TPASS: mount of zram device(s) succeeded
>  zram01 7 TINFO: filling zram1 (it can take long time)
>  zram01 7 TPASS: zram1 was filled with '25568' KB
>
>  >> however, /sys/block/zram1/mm_stat shows
>  >>   9502720        0        0 26214400   196608      145        0        0
>  >> the script reads this zero value and tries to calculate the
>  >> compression ratio
> 
>  ./zram01.sh: line 145: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

At this point, because this test fills from /dev/zero, the zsmalloc
pool doesn't actually have anything in it.  The filesystem metadata is
in-use from the writes, and is not written out as compressed data.
The zram page de-duplication has kicked in, and instead of handles to
zsmalloc areas for data we just have "this is a page of zeros"
recorded.  So this is correctly reflecting that fact that we don't
actually have anything compressed stored at this time.

>  >> If we do a "sync" then redisply the mm_stat after, we get
>  >>   26214400     2842    65536 26214400   196608      399        0        0

Now we've finished writing all our zeros and have synced, we would
have finished updating vfat allocations, etc.  So this gets compressed
and written, and we're back to have some small FS metadata compressed
in our 1 page of zsmalloc allocations.

I think what is probably "special" about this reproducer system is
that it is slow enough to allow the zero allocation to persist between
the end of the test writes and examining the stats.

I'd be happy for any thoughts on the likelyhood of this!

If we think this is right; then the point of the end of this test [1]
is ensure a high reported compression ratio on the device, presumably
to ensure the compression is working.  Filling it with urandom would
be unreliable in this regard.  I think what we want to do is something
highly compressable like alternate lengths of 0x00 and 0xFF.  This
will avoid the same-page detection and ensure we actually have
compressed data, and we can continue to assert on the high compression
ratio reliably.  I'm happy to propose this if we generally agree.

Thanks,

-i

> [1] https://github.com/linux-test-project/ltp/blob/8c201e55f684965df2ae5a13ff439b28278dec0d/testcases/kernel/device-drivers/zram/zram01.sh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
