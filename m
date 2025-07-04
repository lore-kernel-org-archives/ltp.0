Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CCC83F03
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751619521; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=S1f+BL6alcEoj78H1u5sX9QGfNLFuUBA5g1pgYmvGNk=;
 b=Be1BD+UCcz+BPDPKgeIXzqit55sRiR2Tss3AP6AmwBl92tJGrgfEfy9k7efbuwHbsHAwU
 6QDlJAtmhTRU5ZMMJEmQ3HYdxszwYpEiAL+lmUYQKic9OyDHYSvItxIDkcRVV8AYPdc45Vz
 HeMdS9DiiB0WuJAQmLOTKS68LgimPpI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A96A3C9CE4
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 10:58:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E25553C9C7D
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 10:58:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9C6E600D30
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 10:58:19 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso5031325e9.2
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751619499; x=1752224299; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcJUJJeQrxTabrj3RgQ5Ul2dGB4h2YY52zo05VkDBZ0=;
 b=V9XesMS/T1neJEM39260iMITDr/Pxhfun8kHDhXoueCDhnZLBkKQIVFYdpgfzGWHaB
 kXmr/ar+VZGOFvkvtE121v1eakugoMN7LkLTboe32bA1UwlNegP8vCGWuUa0jAjI6zza
 qmCV89MIKsQzMMgPQbdLHiBZeCc8sia3Z0e+pi6YJuEP9Jg/FSn8jWEpc82YNSX4QKME
 hi9S6GyMtzUsvXSMk8D3LGzdHUyPKfWD9MhibqzVvCJHvJvCCZJqjTGdlXSqpYGFzy5f
 tXZrFKHWZMKjCuZL8LaqgDNclgL8mgx49nHQmkOAkqmbxX5nZNUTekf1yAhIGRXT8RS3
 FgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751619499; x=1752224299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcJUJJeQrxTabrj3RgQ5Ul2dGB4h2YY52zo05VkDBZ0=;
 b=JSyRKAWfRryXpPWhsZNYc+eqbyAFPHllpdfDDdZmjs6gMBLoBifmC40+kni7fMe7Rz
 aW5wlJQcxrT9oXl8ZEqbuIosMLl10Stg292Ymw08WMQsXzkr+rbepxf94Upynk7ZXv1f
 sPwZWfS4QXue139S7tl2fffHFz86XxxpKpgi8tqhWS9B585BKAU44AKlkBppH/6dcqvi
 HTKk5oL62SCDtUfwtPiEQI67/S+Ugq0DyoPiDPuKd/x8KPD50gIq4zTa3KwzB71xqDX5
 TL8xNSm4m4X9DG2a8tKPi+aBN8hcn8s7bJGKKOhXgFKdHWMtO+mOkLa7Ww4Fib0SlXHO
 T6FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW06LXn3bod9eXel0tPrZb1yxq6uAku+1HGI36gdgwvZRTP2bi0sq0baypCIfkQxs6Upkk=@lists.linux.it
X-Gm-Message-State: AOJu0Yz7Z4kAzTefJScI6+SykL4VaaGIH5giKbJCBE2nH87Iph9ZJAlc
 zr95DhTRKJGdT+hNOs1GQefvAzlX9CqoRFm8lzFLnCFuigrxa/4T3G0Pf3wiPz3Vm/Y=
X-Gm-Gg: ASbGncvMdoNcwQ7ZcA2fO12SkRoSDfLg2R8p0VfR7Vo2EgCoFCwj+EGA7iCWtAHTSel
 PiyhDafKWQ6cB0HfMEnVu5iL0QsQM9+rhEdOmVK90coBrioJuV2aF1aiODDc9E+hSEQ0RDxbbrC
 y7ZnDvY8cNywQHNOMzVxGnSkKd5sKgY/tqjIPcKT468M3Ryi4bPu5jwp+9Di4yLx23AWbBz4LVf
 OoFZKitIYotTLkFlVMxcIrXWrLXWMszSvDIrIRNZJz2pGHd/6/IzVi8BMRpzF30+tyRi7U3mEWv
 s4QJ6zDe80gKLYFhdcslB19Aefv5cjeijg8QjV7dJdDzXKVqEKe15MJWs/soP+uqjbuwjijRt99
 p7rcWvXjcapj03mEYfJlIz97mDJrN9vwxf8cIwKHZvnYc8u6yY9nVmp5BT4lBvkwsaxY3IQ/FmN
 XrD6yU6Vx0yubNiI/YqwUYAVsK3w==
X-Google-Smtp-Source: AGHT+IG94jJ0rbN56pwpQKch9BwILpqt8RmGJEaxlJmd2tHA/BsqSukQbtpXPp4rm8lkIPF1mrUqdQ==
X-Received: by 2002:a05:6000:714:b0:3a4:f663:acb9 with SMTP id
 ffacd0b85a97d-3b4964bdb54mr1389444f8f.9.1751619498844; 
 Fri, 04 Jul 2025 01:58:18 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce43d5586sm1640220b3a.172.2025.07.04.01.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:58:18 -0700 (PDT)
Message-ID: <cdaf39a3-4835-4d88-9688-2a4a3db71bb0@suse.com>
Date: Fri, 4 Jul 2025 10:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
References: <20250704084330.17896-1-akumar@suse.de>
Content-Language: en-US
In-Reply-To: <20250704084330.17896-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] crash02: remove verbose option from runtest file
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged thanks!

On 7/4/25 10:43 AM, Avinesh Kumar wrote:
> we have removed support for verbose option -v in the rewrite of crash02
>
> Fixes: 16cd67ef1 (misc: rewrite crash02 test)
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>   runtest/crashme | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/runtest/crashme b/runtest/crashme
> index 7a630916b..af45d29bc 100644
> --- a/runtest/crashme
> +++ b/runtest/crashme
> @@ -7,6 +7,6 @@ f00f f00f
>   crash01 crash01
>   # Generate random code and execute it. Read f00f comment,
>   # this test lockup SunOS,WindowsNT,etc. in seconds..
> -crash02 crash02 -v 2
> +crash02 crash02
>   # Fork as many children as possible.  On systems with lots of memory
>   # and kernels prior to 2.4.19, this can hang the system by using up all pids

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
