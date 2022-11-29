Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C4C4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 04:38:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 350433C6D0A
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 05:38:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 646373C6D0A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:38:38 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 520311400278
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:38:38 +0100 (CET)
Received: by mail-pj1-x1036.google.com with SMTP id
 hd14-20020a17090b458e00b0021909875bccso311300pjb.1
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 20:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=48Xm3VfV4sx0+bUZmYTNZIpSa0XzNl3vvIQW42o7jJQ=;
 b=T5LUfnFRWiWAdf7zeRpoyRCNSY164AYnoRT7heMBmwvQh/rkonGTMP2fDaxZ3cb3zq
 WgnsezEnwq9KAb5FRfzcc5muJkJxXkVwjBgn2+VHTj+wotmFhoJq5rNh+hOLZk0LZ3g/
 Ozt9Ev52HQoPAwOc9bKAd0REmzrYFGjcYLOh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48Xm3VfV4sx0+bUZmYTNZIpSa0XzNl3vvIQW42o7jJQ=;
 b=FIcAxVZseaeFMG4ma+w+X7dS6LUHGUrZVTWFB/Fc2NUxrBvHwBoTejrOG+DClgnFct
 aSxidfgk9QEPqdzSjjMueX7i3WxBmFBVmExtGrTcGeklLDmMz9O8U38m9NT0sU8bFwb5
 W/4CGFDH1bGvLnP9MvrGJj4fmBGzWqAWUy7fupXbpyS1/D6cRATjgg2GHhuhgN1sFFLq
 FgvBRqKuKFaMr4nGXyvVWw5j2HQQJAGW0M835gwB7IfVX19sxF9AaToQP/aowtyELdck
 iLbTjWA8eG1MtTCQ2nn85SWUpOodeWSFm7p9YONs6fg+THRb3rjnz0OE3sEYjgfxGBN8
 u2Jw==
X-Gm-Message-State: ANoB5pnAj8jEAt4Y0RlSGfqXb/3sc5Af96i+ncLpMOj5FsUfPcr2Sm84
 0be1gjzTOJz8fJnqvexdOFgfSg==
X-Google-Smtp-Source: AA0mqf5c3WV2DuftkVuXZ0Ps8inmw7FchDxrXziCDRwmtaUhnUDq6si8XtaqqqnfHmFIrk0qg4O0fg==
X-Received: by 2002:a17:90a:fb86:b0:219:26b5:d41e with SMTP id
 cp6-20020a17090afb8600b0021926b5d41emr12318785pjb.20.1669696716694; 
 Mon, 28 Nov 2022 20:38:36 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
 by smtp.gmail.com with ESMTPSA id
 o42-20020a17090a0a2d00b00219133d0f4esm321809pjo.9.2022.11.28.20.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 20:38:36 -0800 (PST)
Date: Tue, 29 Nov 2022 13:38:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y4WMxqyVlAt0Sp3g@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
 <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
 <Y3zlrBQ8fgJyNm7G@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3zlrBQ8fgJyNm7G@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Nitin Gupta <ngupta@vflare.org>, linux-kselftest@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On (22/11/22 16:07), Petr Vorel wrote:
> > On 11. 11. 22 1:48, Sergey Senozhatsky wrote:
> > > On (22/11/10 15:29), Martin Doucha wrote:

[..]

> > > Can you try using /dev/urandom for dd, not /dev/zero?
> > > Do you still see zeroes in sysfs output or some random values?
> 
> > After 50 test runs on a kernel where the issue is confirmed, I could not
> > reproduce the failure while filling the device from /dev/urandom instead of
> > /dev/zero. The test reported compression ratio around 1.8-2.5 which means
> > the memory usage reported by mm_stat was 10-13MB.
> 
> Martin, thanks a lot for reruning tests. I wonder problems on /dev/zero is a
> kernel bug or just problem which should be workarounded.

Hmm. Does CONFIG_KASAN show anything interesting?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
