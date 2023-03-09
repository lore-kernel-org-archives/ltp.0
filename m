Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8D2C64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 16:25:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E1273CD912
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 17:25:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475983CB05E
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 17:24:52 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A324F1400F8B
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 17:24:51 +0100 (CET)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFA7F3F196
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1678379089;
 bh=pKRjKerJOyNx6DHh8YxvBnUjgnIZj6JolHeFR2M1Awk=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=E06KfHzNHDBsNe8OMxWIFqmRBoC0EvtvVRGNiuH+JZvHHS1GxB5OIEPXrDcMygFdH
 B4zyVTZ1xl4G/fQTV+uuvrNjVMlvybDMOFsgRO/xMCnjJ+IqRMRnr5Bj5lfML7bH5z
 F3m7Y2lB+GLX6Og1Qcj/gIDayEvJZyGpV7xSAeFz6Mkafd3y0KmctOK1F5CL3Fxq+X
 Se8qNsdI1R2thOlRwmcZklUOwOotcKP8LnEbeSLRj/mvtW6HSQuV01KgDpRLjXwGkJ
 dNWowTdXr8kailTf0BFGspcWM7oQ4Vw08zMBT60aDhGRSKNEfnEcKdLVccV74w26td
 qyEspq+GHuehQ==
Received: by mail-wm1-f72.google.com with SMTP id
 n27-20020a05600c3b9b00b003e9ca0f4677so987291wms.8
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 08:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678379089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKRjKerJOyNx6DHh8YxvBnUjgnIZj6JolHeFR2M1Awk=;
 b=NN1ADV6rxvqLr3R4LqHezEedMrPSv7cjhYhLVUHL/JCQzwfwg8SRWOONm0jC5XaY03
 iI0njWapjszM18Nn/H71q1kvrimySc/6zhExN6NRkiEI5aV3Y92j0S5kFzhMAGAkzlp+
 6j0O3OuGhlNeVNy+tp7COTpd3ySNTYoiebQhqjkX/lhDs+sT8f+CWlzKom5YF6HcYmho
 nr0jfyAHXlUhC6auqyPH6ubTO59cRaIWzpyzuUCpYUiJsnXtxL2SYP16Od6iK7iTGVBB
 PSevS+FHu2Rzb8gH7UPnL2l9nxPb1PCvKqIiLblU0yr3JPjejx8BMqaDUfdF8DhSI0Qf
 D9HA==
X-Gm-Message-State: AO0yUKWBTJA0mAXAYL/lJFwwlUoa54Lyd5M6tPH8R+cn6rZpwrGnO0bn
 nc9HZ02H37kxpWBfezMksTTFb9xf/0L8Ocw28cXsPfrbzxq3iHOOHMFV5WNvcaPxNxbZnNvbC3U
 G6e5DVtbSHYcxdICoNUUOI6g2+4HJ
X-Received: by 2002:a05:600c:4f11:b0:3df:ef18:b0a1 with SMTP id
 l17-20020a05600c4f1100b003dfef18b0a1mr20123568wmq.12.1678379089721; 
 Thu, 09 Mar 2023 08:24:49 -0800 (PST)
X-Google-Smtp-Source: AK7set92drqZBau4y9Xpod3efFE18rBaZmFN9lNsQBvBmLuwG01HjQTsPJ9HoerAajA8Sps1FPP0gw==
X-Received: by 2002:a05:600c:4f11:b0:3df:ef18:b0a1 with SMTP id
 l17-20020a05600c4f1100b003dfef18b0a1mr20123555wmq.12.1678379089405; 
 Thu, 09 Mar 2023 08:24:49 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bce10000000b003e20fa01a86sm324414wmc.13.2023.03.09.08.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:24:49 -0800 (PST)
Date: Thu, 9 Mar 2023 16:24:47 +0000
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZAoIT1NunhWyuIUR@qwirkle>
References: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
 <Y++c8fBZxmUIR3Lb@pevik> <Y/N53BN2yr7WEIzr@qwirkle>
 <20230308165545.GA428998@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230308165545.GA428998@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs_fill: Fix test when running on a 256 CPU+
 machine
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 23/03/08 05:55PM, Petr Vorel wrote:
> Hi Andrei,
> 
> > > > The fs_fill test runs a fill test on all the supported filesystems. One
> > > > of them being vfat. This filesystem is configured dynamically or through
> > > > flags/arguments for its file allocation table type (12/16/32).
> 
> > > > The size of the test device (which is a loop-mounted fs) is 300MB. When not
> > > > instructed, mkfs will "automatically select between 12, 16 and 32 bit,
> > > > whatever fits better for the filesystem size"[1]. In the case of a 300Mb that
> > > > would end up as FAT16.
> > > Interesting. BTW we plan to change 300 MB to minimal filesystem which would fit
> > > to all existing tests (255 MB was for Btrfs, 300 MB was for XFS, but there might
> > > be minimal systems which can use vfat, ext4, ... with smaller resources, e.g.
> > > 16 MB for filesystem). Therefore I wonder what is minimal reasonable required
> > > size for vfat. i.e. what MB is required for FAT32? (I guess we don't want to
> > > check FAT12 or FAT16).
> 
> > The minimum/maximum values depend on the sector size. I'm not sure about
> > F12 but for the other ones I think it was 32MB for 512b sectors.
> 
> Thanks a lot for info. BTW I'm not convinced any more that using as smallest
> loop device size as possible is a good idea.

I agree. The moment we start getting into the limits of fs sizes, we
will end up in issues like this.

-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
