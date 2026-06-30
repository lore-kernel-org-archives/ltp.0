Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CDEC43327
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 22:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782859996; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WsWQ6mQ9rVWcFgrI6h6GJBN+9sFTqs3HBSPS7anN6cU=;
 b=eNxTsr8fsY1NS5jD0m2PTMkZOn4ddc4BDIGHLaP1lilmPVt4ygVb184gCI5Sn58p4t/O2
 ElroMzO4148OtxEg/3ygypNE7a6tcGsLC3v0/Qr3A5bJeibDbt4MvW9kvR0e5egaP/oSpMw
 MILRHVMsvqVgL77CItCjxUdJ8VZXeH8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8A503E52EF
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 00:53:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF6F43C745B
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 00:52:53 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50FB614001F5
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 00:52:52 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so36645e9.3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782859971; x=1783464771; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/wXoXwE30EJFzMxOOnkqkkDvN2SASnPu2FZ9422hYCg=;
 b=EjSw6icvDau8yZCrWU3z/KLy0kYwQZZeHibYP2dYK8AJ1i2v1h2GF/V03x/Wvnte2n
 zGzkQz8lupcqud80GrZus/BHJnWyO3RLtZI6gUNbA8me0QNgFjcyXrOI+LaspK0YosqI
 OQzMd9hZUeXC0z7T+soTuvipwaQGOsN7H/NCxOoT6uEgvUyNPUQRiAUmu9G9NjApbCmN
 kG9CXgBPtIux3/NwjN4wrW4zdzq4wCivOmXgKEqLAvl6nJEpW6wtIqRgdI5k+haLC1mD
 8vwVRtl0CEMeJLWysEMUMFp1Gt2PR3TSWoclMWLOnrAF/t2Wh0E9rWG1JibU6nSh7blv
 b9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782859971; x=1783464771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wXoXwE30EJFzMxOOnkqkkDvN2SASnPu2FZ9422hYCg=;
 b=eemsNDw3AJ10nQBc/PF6+G5ckrjRkr7ScxL4iYPlgMFiqxzBMmHt4KvZpwf5a2aj+Q
 D1+zmW1hnKMH1L9SbldKLtC6vfbRfWrrfh0TtUv49RFPznvVrc4vg6N8YsV1BSWUicDe
 GaiHx44P+7HvHfOxtyWA0G7U3uHearHcIfYn+FtVgwKNplSlBfvzZP8rFnwLlI7o2AdR
 +ZJobnOHHEQEJ8AITOZDcevWUuwUBrPZNEPAxZnHCnIFdDYROTLm0MBxZ4LgkHWivi+6
 7WXbe75Mq+9SfdC7TeBAU9uB1BjhJnMgzC9mV6vfNtTAQiNDQiePhIGx2ucg2li8zINX
 SXqg==
X-Gm-Message-State: AOJu0Yy4Z2wS6ic4pj3JiORlPMwwKwU3Sp84bb4ID7cFcHc9nEUA3w4j
 xZDH11iRBt9ijW3L6SnZjLuim9MAAWwuodiMohbQsMsGoNL+Wdj3MzAZh8d5exLt5q+j08RYh+H
 EamY=
X-Gm-Gg: AfdE7cmXKvRgPD4R1lbwL4UQJloavQ78MIrA0v//hhZol26ZFpeYy7Mdjt030hZV3GN
 gAQbu7vgMgSyFj8x1Y6SpZNNbrbDtnYfiSC2AmLzKHS8EuWrvcwNFoO3c0pGW9XN6hxew/Bbu70
 CjK7iuOR248VXXaOiX5HCs5sKNba7rouNWdFHpRJAkchNGisebBB2Q0kAr4iB51x/6Ux1QCi+h1
 DDOuA7nwFZGk0TO7mFR3x36unXe7Uu8hYuaI1pMKuqA7FTEDGQhFZpJFRwRdulzF0GPBglYvXAU
 oHMehKo7AEKnFv0Ezk0Tg5lcuwlnpGOEFwmOnBVUlhZ2PUPD7ESn5XvRukEIXbzFy7+YkbFLcFr
 HBoj/0TYjUNFOONescwz5EPzp2lyClJvSdMi12a2xuJihwJuqivQ5VBKl0PeK83LXhoux1lejqU
 V8yI63f7+X1seAw6rbedHEFOQWSWbVWA==
X-Received: by 2002:a05:600c:4695:b0:493:aa24:792b with SMTP id
 5b1f17b1804b1-493bda6fdc1mr36496605e9.22.1782859971570; 
 Tue, 30 Jun 2026 15:52:51 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm22224115e9.2.2026.06.30.15.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 15:52:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 22:52:49 +0000
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <akRIwUPkciwzymrG@autotest-wegao.qe.prg2.suse.org>
References: <20260630180855.159467-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260630180855.159467-1-avinesh.kumar@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_security.sh: quote variables in selinux
 helper functions
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

On Tue, Jun 30, 2026 at 08:08:54PM +0200, Avinesh Kumar via ltp wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> Quote variables in tst_disable_selinux() and tst_update_selinux_state()
> to follow shell quoting best practices.
> 
> Fixes: cc9206e612b2 ("tst_security.sh: Use enforce toggle to trigger SELinux measurement")
> 
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  testcases/lib/tst_security.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
> index 03b744fb3d42..a7dd9de63339 100644
> --- a/testcases/lib/tst_security.sh
> +++ b/testcases/lib/tst_security.sh
> @@ -119,7 +119,7 @@ tst_disable_selinux()
>  
>  	local f="$(tst_get_enforce)"
>  
> -	[ -f "$f" ] && echo 0 > $f
> +	[ -f "$f" ] && echo 0 > "$f"
>  }
>  
>  # Get SELinux directory path
> @@ -147,8 +147,8 @@ tst_update_selinux_state()
>  	[ -n "$dir" ] || return 1
>  
>  	# Toggle enforce to trigger SELinux state measurement
> -	orig_val=$(cat $dir/enforce)
> +	orig_val=$(cat "$dir/enforce")
>  	val=$((1 - orig_val))
> -	echo $val > $dir/enforce
> -	echo $orig_val > $dir/enforce
> +	echo "$val" > "$dir/enforce"
> +	echo "$orig_val" > "$dir/enforce"
Thanks.
Reviewed-by: Wei Gao <wegao@suse.com>

>  }
> -- 
> 2.54.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
