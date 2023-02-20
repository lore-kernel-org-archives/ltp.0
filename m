Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C96DC05027
	for <ltp@archiver.kernel.org>; Mon, 20 Feb 2023 13:47:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1C7B3CBCFB
	for <ltp@archiver.kernel.org>; Mon, 20 Feb 2023 14:47:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA2773CAFE8
 for <ltp@lists.linux.it>; Mon, 20 Feb 2023 14:47:14 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9161D778501
 for <ltp@lists.linux.it>; Mon, 20 Feb 2023 14:47:13 +0100 (CET)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73B603F212
 for <ltp@lists.linux.it>; Mon, 20 Feb 2023 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1676900831;
 bh=J2Q43Q+DgVEDJIlUueGRO464dpvXjCTw/Dm7p0A8VLo=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=L9d+FGf6+bD71fUBSnYA6nuulJjWVMwKML2oK6Lf/WTyQto9vgSSrS9MjRbVxeXcU
 PQxKLg13gk0eVvmYTi2ghupLTdj+k2YSKHwIkpW4dKTznqX1crlM1u6+efeUEo0HA9
 +hGFOrM+M3XwBhCs4ABugCMsuTpexuhxltK0ERF9Fuv9hHulOxJsVxP28akwlgl27K
 hY7cz9wYaI4rwuN9FL99T0PnX5cvhxrfrav0Nn1ejOzuZ94XEZNtRqWGfov09SlKeM
 j79uzHrPSM4zi/5yd+G3qt1adHqjO51p6G4/rwQId3sMCctGamhbfLgVb72P0dTY+/
 yuk4flkAKoh5A==
Received: by mail-wm1-f72.google.com with SMTP id
 x18-20020a1c7c12000000b003e1e7d3cf9fso646868wmc.3
 for <ltp@lists.linux.it>; Mon, 20 Feb 2023 05:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2Q43Q+DgVEDJIlUueGRO464dpvXjCTw/Dm7p0A8VLo=;
 b=1hgo9bgP5cwM/DE7oWDhgJ9ClW0zZsUB3/JowMmbPJy9wrcpVqK3orHq8gSUftcNtr
 incA6VdL/rUOgqz+eCzqgU6D5MvN5A8h4kaIGGyAlE5xkoDeamkLZDTCOLdZsD6VsFni
 n0NQS8F5xB7AwBZr662uZkr+V9jrZ2kmzIs7O2ToDcpVT1mCGRrikCNVNhs4jALGwUbY
 kAPb9kL1bNTFpU1qVygls3bNRsP9NM2dx6KduqrJJ4mL0qv4FkRIL2LX6gxL3K5wU9F0
 LSx/PMGDPUbftiQ1P+hnFmGylI8U12nJpTQAgXXnPSwbFCgy9m8nKIfXSPqb8JSLLi3q
 bHrg==
X-Gm-Message-State: AO0yUKUCQcm9bazI1NCqSs0qwhwwYIYg+xp+81XyvA0VECARzyGbJxwG
 8vmUioJmHzIzUKBuXWUVpFQKqtM6zHlLKDGbhQEFCkEdb5RKp5CCcLk+zhdpAnvOLCsf6stwq0w
 VfcT5GlU1SIg2jxIUzlkspWlLlmO2
X-Received: by 2002:a05:600c:a694:b0:3df:fa56:7a33 with SMTP id
 ip20-20020a05600ca69400b003dffa567a33mr1071065wmb.26.1676900831175; 
 Mon, 20 Feb 2023 05:47:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/2h/bM/vOBQhSyjRqCh2Ml8NeQdi8TQOeZOXGCZXIj1TCd2Xqj5Cbhjb9p/3WY8MyHrqs/EQ==
X-Received: by 2002:a05:600c:a694:b0:3df:fa56:7a33 with SMTP id
 ip20-20020a05600ca69400b003dffa567a33mr1071058wmb.26.1676900830854; 
 Mon, 20 Feb 2023 05:47:10 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a05600c4f4600b003df245cd853sm1996561wmq.44.2023.02.20.05.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Feb 2023 05:47:10 -0800 (PST)
Date: Mon, 20 Feb 2023 13:47:08 +0000
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y/N53BN2yr7WEIzr@qwirkle>
References: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
 <Y++c8fBZxmUIR3Lb@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y++c8fBZxmUIR3Lb@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

On 23/02/17 04:27PM, Petr Vorel wrote:
> Hi Andrei,
> 
> > The fs_fill test runs a fill test on all the supported filesystems. One
> > of them being vfat. This filesystem is configured dynamically or through
> > flags/arguments for its file allocation table type (12/16/32).
> 
> > The size of the test device (which is a loop-mounted fs) is 300MB. When not
> > instructed, mkfs will "automatically select between 12, 16 and 32 bit,
> > whatever fits better for the filesystem size"[1]. In the case of a 300Mb that
> > would end up as FAT16.
> Interesting. BTW we plan to change 300 MB to minimal filesystem which would fit
> to all existing tests (255 MB was for Btrfs, 300 MB was for XFS, but there might
> be minimal systems which can use vfat, ext4, ... with smaller resources, e.g.
> 16 MB for filesystem). Therefore I wonder what is minimal reasonable required
> size for vfat. i.e. what MB is required for FAT32? (I guess we don't want to
> check FAT12 or FAT16).

The minimum/maximum values depend on the sector size. I'm not sure about
F12 but for the other ones I think it was 32MB for 512b sectors.

> 
> > This is linked with another configuration that is the actual impact on
> > this issue: the maximum number of directories in the root of the
> > filesystem. FAT12 and FAT16 use a special system region: "Root Directory
> > Region". And by default (there is also an argument to configure this at
> > mkfs-time) this ends up being 256 when no custom arguments are provided.
> 
> > On the other hand, the test sets up the filesystem with a
> > "tst_ncpus_conf + 2" number of directories in the test filesystem's root
> > which can break the limit explained above on systems with a number of
> > CPUs that would amount above the limit.
> 
> > This change addresses this situation by using a subdirectory in the test
> > filesystem which is not subject to this limit.
> 
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > ---
> >  testcases/kernel/fs/fs_fill/fs_fill.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
> > index 2027b6df1..dd8ad2935 100644
> > --- a/testcases/kernel/fs/fs_fill/fs_fill.c
> > +++ b/testcases/kernel/fs/fs_fill/fs_fill.c
> > @@ -18,6 +18,7 @@
> >  #include "tst_test.h"
> 
> >  #define MNTPOINT "mntpoint"
> > +#define THREADS_SUBDIR "subdir"
> 
> >  static volatile int run;
> >  static unsigned int nthreads;
> > @@ -99,9 +100,13 @@ static void setup(void)
> >  	nthreads = tst_ncpus_conf() + 2;
> >  	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
> 
> > +	// Avoid creating the thread directories in the root of the filesystem
> > +	// to not hit the root entries limit on a  FAT16 filesystem.
> > +	SAFE_MKDIR(MNTPOINT "/" THREADS_SUBDIR, 0700);
> > +
> >  	for (i = 0; i < nthreads; i++) {
> >  		snprintf(workers[i].dir, sizeof(workers[i].dir),
> > -			 MNTPOINT "/thread%i", i + 1);
> > +			 MNTPOINT "/" THREADS_SUBDIR "/thread%i", i + 1);
> >  		SAFE_MKDIR(workers[i].dir, 0700);
> >  	}
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> If you don't mind, I suggest to merge slightly changed patch.

Happy with the changes below.

> 
> Kind regards,
> Petr
> 
> +++ testcases/kernel/fs/fs_fill/fs_fill.c
> @@ -18,6 +18,7 @@
>  #include "tst_test.h"
>  
>  #define MNTPOINT "mntpoint"
> +#define THREADS_DIR MNTPOINT "/subdir"
>  
>  static volatile int run;
>  static unsigned int nthreads;
> @@ -99,9 +100,15 @@ static void setup(void)
>  	nthreads = tst_ncpus_conf() + 2;
>  	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
>  
> +	/*
> +	 * Avoid creating the thread directories in the root of the filesystem
> +	 * to not hit the root entries limit on a FAT16 filesystem.
> +	 */
> +	SAFE_MKDIR(THREADS_DIR, 0700);
> +
>  	for (i = 0; i < nthreads; i++) {
>  		snprintf(workers[i].dir, sizeof(workers[i].dir),
> -			 MNTPOINT "/thread%i", i + 1);
> +			 THREADS_DIR "/thread%i", i + 1);
>  		SAFE_MKDIR(workers[i].dir, 0700);
>  	}
>  

-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
