Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B014FC001DB
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 05:19:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 732863CD21B
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 07:19:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2506A3C6B5E
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 07:19:25 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47E75600663
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 07:19:25 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc6535027aso9480445ad.2
 for <ltp@lists.linux.it>; Sun, 06 Aug 2023 22:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691385563; x=1691990363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TFnplcIQrufgoEeVnD1iXcx2sLuZX9r5b+/X2IXHNf8=;
 b=Q7DxxIhgMo46QGY0MrbuPuKxRUCe4gavGP6YsLFndAQqK9FPDABdLLnQqnYB8H9ebW
 EkXHpkiFK7lecutNCxsohpe1hIPHd1HAxLXofeko7lWPAYlEUbYG/HWYA7VO6Ppji+L8
 KPFb4h8H+3yOU6595s5gH4QBLiOWkMRAnxZU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691385563; x=1691990363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFnplcIQrufgoEeVnD1iXcx2sLuZX9r5b+/X2IXHNf8=;
 b=PC/tuW9zMpFrDEPcyn7fG9kYFp1O3AEanzk6HAvIbDvc6AXRZ7zvL4LcJYUEp8n04J
 AV6/BdiEFYN1EQeC+q8avawr1dQua7NKilHa64TrL+aCONlepT8gJQsZfFHaiJGp7hCC
 yXjQEfO+GtnfCb+a3xy/vBzC/STGACo1xBvVsoLBheXA3INOoIkuTo2NJuubF9ND7WEY
 I+qpOqGL0q3OMzxFm+HF3Jq/dlnwUKNTlYkrtLuVdUWXtYtoHKHV7X1/Q/obe6kaGDtn
 RiU1dXlD1cmGRK/oT5IPmO++bBzu03j6UglaEprW4AyOQEIavRqA+OUrCgCofSPvuv/9
 oB0A==
X-Gm-Message-State: AOJu0YzKbevdB+avLUWgcaCdVXGfiSEM0FUKJ9Fip2TGjhFbq6z/Zc3e
 Xfw6wjiYgbg06NIpM+7+oh1F9Q==
X-Google-Smtp-Source: AGHT+IH9VWVSqgbvsZOfDQkkDfR3GmRAM6nKTnGLYAkOPsQI5W+o8XCsCIaf1qov50YwMQAeJ8h7JQ==
X-Received: by 2002:a17:902:d512:b0:1bb:59da:77f8 with SMTP id
 b18-20020a170902d51200b001bb59da77f8mr11480833plg.48.1691385563411; 
 Sun, 06 Aug 2023 22:19:23 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902ed8c00b001bba7aab826sm5793688plj.163.2023.08.06.22.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Aug 2023 22:19:22 -0700 (PDT)
Date: Mon, 7 Aug 2023 14:19:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ian Wienand <iwienand@redhat.com>
Message-ID: <20230807051917.GC907732@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <ZMycl7xKyJoQNpcu@fedora19.localdomain>
 <ZNB2kORYiKdl3vSq@fedora19.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZNB2kORYiKdl3vSq@fedora19.localdomain>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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
Cc: Jens Axboe <axboe@kernel.dk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 linux-kselftest@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On (23/08/07 14:44), Ian Wienand wrote:
[..]
> 
> At this point, because this test fills from /dev/zero, the zsmalloc
> pool doesn't actually have anything in it.  The filesystem metadata is
> in-use from the writes, and is not written out as compressed data.
> The zram page de-duplication has kicked in, and instead of handles to
> zsmalloc areas for data we just have "this is a page of zeros"
> recorded.  So this is correctly reflecting that fact that we don't
> actually have anything compressed stored at this time.
> 
> >  >> If we do a "sync" then redisply the mm_stat after, we get
> >  >>   26214400     2842    65536 26214400   196608      399        0        0
> 
> Now we've finished writing all our zeros and have synced, we would
> have finished updating vfat allocations, etc.  So this gets compressed
> and written, and we're back to have some small FS metadata compressed
> in our 1 page of zsmalloc allocations.
> 
> I think what is probably "special" about this reproducer system is
> that it is slow enough to allow the zero allocation to persist between
> the end of the test writes and examining the stats.
> 
> I'd be happy for any thoughts on the likelyhood of this!

Thanks for looking into this.

Yes, the fact that /dev/urandom shows non-zero values in mm_stat means
that we don't have any fishy going on in zram but instead very likely
have ZRAM_SAME pages, which don't reach zsmalloc pool and don't use any
physical pages.

And this is what 145 is in mm_stat that was posted earlier. We have 145
pages that are filled with the same bytes pattern:

> >  >> however, /sys/block/zram1/mm_stat shows
> >  >>   9502720        0        0 26214400   196608      145        0        0

> If we think this is right; then the point of the end of this test [1]
> is ensure a high reported compression ratio on the device, presumably
> to ensure the compression is working.  Filling it with urandom would
> be unreliable in this regard.  I think what we want to do is something
> highly compressable like alternate lengths of 0x00 and 0xFF.

So var-lengths 0x00/0xff should work, just make sure that you don't have
a pattern of sizeof(unsigned long) length.

I think fio had an option to generate bin data with a certain level
of compress-ability. If that option works then maybe you can just use
fio with some static buffer_compress_percentage configuration.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
