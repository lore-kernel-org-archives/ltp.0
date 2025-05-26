Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92A9C54F30
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748226629; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NboMpl/4q0Ja4wYUQzf1033q5nCq/xDr4qO2u/S87Zo=;
 b=RUUYJOVUTyYXLeAw2ICNA/VGAha5qBEs+aKu9kk9RoUZAVhPlIHy7//ovBQ7ihFiFv9o2
 ja+x8EIeMz7T5ghcp8bsbt/TSszyMSXkhdF8lNlBDUlIqM25JKTNsTF+uWuMKk+NX6b7TJi
 rVoNFWTeGPdaDsKola1oHVE79LN6muQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5D453C293A
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 04:30:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BFA73C0F82
 for <ltp@lists.linux.it>; Mon, 26 May 2025 04:30:08 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0B49060083B
 for <ltp@lists.linux.it>; Mon, 26 May 2025 04:30:07 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4c4e6a0ccso1174153f8f.3
 for <ltp@lists.linux.it>; Sun, 25 May 2025 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748226606; x=1748831406; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AuDDRNklwfZEcBPzsa+MFqHJYgKadDI4Dqcfb3eaW0w=;
 b=a4Yw372dmQUEU0PUVqS0JS7qk4tk5jso2oWeJ8w1O9RH3m/ija4r5i0c8AEWhE2zwu
 DqimrELZAHE+daetAI+NFoRop5FQsp45Ylvg+fVfW+N62xf4qnR3l8rywkyz9PjL5Jdk
 DNHYnaBQtJVjBxXkT3xKKD9bQpRQkWlChU2DzBBacFzlIwikIB82+dEiTgyuFQWGc1FB
 r8pS3nunUHXR4H/1B6lw+1eMUekxdmjXyIJ9wxpdNNDHW1jUGGn0eWtXgC9RkmiVvaBY
 tiMp9dtnrJNFXyhZyspsi1VHsomtcDjSQ2Jz+IwjwtroW7r0toUH1PCLOpomsfiJAY+b
 puLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748226606; x=1748831406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuDDRNklwfZEcBPzsa+MFqHJYgKadDI4Dqcfb3eaW0w=;
 b=P23euegnVivyClehxY3PN2SGELd4j3nGs5rTtjx8pexTTldWyBLWtGjR/EBR28q5u7
 8dHTlcFEd3y6xOk2jJGVgvlOpGBQe0m9WzIJ9t/vXfEckez0sW9y7n7mCpBpgKkqwSu2
 fMCXTrMRHSMAlsXwfY6jFaXhXA2btYfeCKdOYmBWjvXQxNCItZPKss8makKLpmZCPrUz
 84j3fq0iQPQwlOOlLrKVvpjhO7ttoJISU9xgv6wY+1OEffpmu9zXMCWyshiP4OH2bX6U
 h9vLHbysUMi9Y0Cs8eHL2iqO36pLjoe0YaqfLoQsBXKBzLX7fjSOtkHZ558FjRCzs63z
 IRsw==
X-Gm-Message-State: AOJu0YxVJPD05blWe6IZWvMAzDaPQi9fRlpQ9ibOnxKPeRSWINFwItQn
 7NKfYOFdTbJ4MjFih6eECoxgB9l1oPtRigX3iZpCrnv8it8fivX4LBGnDRMdBsaTjw==
X-Gm-Gg: ASbGnctqoLkZz1aHCdAHgeuBKy5rwYdiWzpYXfQfbaX0RJ1R7nVe/0eiPyXjYeEPgJo
 KA+ALfIDKU2KnWQGXkEp+EdWhe+4/lPrUqmAHLikuL/9frHGPKmlmtl4FGToB41+8JuyBP/zyjH
 g6vfL63zvqRkEWcDEtzHqhcGrKZrXbujCG2P1Woj5e9vy4AKEJzm+mFSksoZH5NKZEh/Q9ul61e
 SQtZOx0GrYnGaHqzrgGlcDG4P9cq6XK9Xq8l5pi2EGryOCo2Tpt5iGHoH4K+HFEiMoFfru2k+tZ
 eUiIU/TFMYRYUzm2SFvluwDV6aiv9C4hv9lft4S9IW7Q2IR7UTA=
X-Google-Smtp-Source: AGHT+IFXET2hqitGViBLaBFsaXzol8P0y6RO7XoPxT1k0kJrN+1jxRlZEPtSNlS+3oqZje7B3S7o2Q==
X-Received: by 2002:a05:6000:40e1:b0:3a4:d0ed:257b with SMTP id
 ffacd0b85a97d-3a4d0ed285cmr3632886f8f.22.1748226606437; 
 Sun, 25 May 2025 19:30:06 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-233fbf0518bsm41806925ad.142.2025.05.25.19.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 19:30:06 -0700 (PDT)
Date: Mon, 26 May 2025 10:29:53 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aDR64TWa0Fo21t6B@MiWiFi-CR6608-srv>
References: <20250516151028.1254207-1-wegao@suse.com>
 <20250522205637.GA32918@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250522205637.GA32918@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig04.c: Check FSCONFIG_SET_PATH
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, May 22, 2025 at 10:56:37PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> I'm sorry not a real review, just point out obvious API errors.
Thanks for pointing that out :)

> 
> > +#include "lapi/fsmount.h"
> 
> > +#include "old/old_device.h"
> Why this?
tst_acquire_loop_device is needed in this case, and i saw following test
case using old_device.h, so i just copy it into current case.
testcases/lib/tst_device.c
> 
> > +
> > +
> > +	.all_filesystems = 1,
> > +	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat",
> > +		"ext2", "tmpfs", "xfs", "btrfs", NULL},
> So you skip nearly everything, right?
Yes, ONLY ext3 and ext4 support journal setup

> Why not use .mount_device = 1 ? That would mount the default filesystem.
This case need format default device with ext3 opts='-F -J device=/dev/loop1' firstly,
so the device can not be mounted before format.
> 
> Kind regards,
> Petr
> 
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
