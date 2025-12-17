Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5296ED64083
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 07:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765955632; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qJoQcEhmi8SuCzkNdRVdZRI+zpu7dFGs1sI1vt4v3sw=;
 b=JAQAmb+xKf7mP4PjI4zkbHXBOkQlvBoX6kjq6Ozl/8VgH9/D3kvhxk5ulQEEgDklAzuq8
 QhWKP5sMumzJ0BeJh+PCIw+GmIZRApAxu7pofRgdtlR0sHNHUKoC6xr+4KAdSHv5tzp8j+n
 QScLkJMM7scrGnXiXqWPaAbLSR6LrUs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6C043D03A5
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 08:13:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FB453D0395
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 08:13:29 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D93A200243
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 08:13:25 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so10220379a12.0
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 23:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765955605; x=1766560405; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qonRBzuoeFe81qOTY2CDuyQbz4XnbK+1jkMGOTIb3xM=;
 b=PojGuIhBRm+9j1dlqNgPrAVnQX2aDIyAnn4v1WtmM4BDPe6POvvQU+jAcXbsWx6/Pc
 8YM/7o40AkElLr7gfgahakegp0akQb7Qe8zlCijUFaj6b+ins4JpkxtuNeEPIE5UfcVd
 KW71jPJFQFL8EbPQQn0XHKIfMJtQl3SJkEVpn6Oo5kKyFBSf5mgGzH/bUlVpt29a9Lzx
 /zF4VOgidtVWOEXjBEoa6o7nsht1sD37BZOND4lzygBKvb6REn8xzWvmnoqN7YBML6hE
 dzZhpXhPu5CiEuRRq/f3h7n+IswAz5ZFTifTSYOMjwcSztacs8mY7lwGdKIwhZoYAdYP
 /KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765955605; x=1766560405;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qonRBzuoeFe81qOTY2CDuyQbz4XnbK+1jkMGOTIb3xM=;
 b=hndv//tdGvxwgymZuAEin6o/qvGY2WRyQZ4RvwY+4rWtx7HGY+czSDwWjx3a/ScGx4
 bI/dhf5R3zNo2VJq5z5iLyQeh48DeVHmJPbqYDzavTglGdfdSk8cFUSXlQYNRZeFyZM7
 4O3E6golr05jaYYLzG6KZNpwg4rnVuqobMmidZW/7k/5K3MFKBgkQRLlAhEj4mUGxLrD
 xLq0WTHmCAFBGAxhHe3KYJ7lPM37Z2XLkdtWAjeqZnIDiytATVPkQDI/XjqVdBfa10IO
 BtkWImQEyPMhgH14VkC+tOE8oF/T2gVvVT9MEZvXYh4ejHnSK37HL5JzPMyio8X+Eqrm
 pccw==
X-Gm-Message-State: AOJu0Yw5XbIsbCdMowKtWTNY7XoyvWBap8fGXENtYXv10qFlkWqvO8Iz
 Rxlm66gP4Z5h1bqaBPE3VW17+LbhmPhZ9U7qI2EqQ2KaYf2wLgIluMqxF2xfyN7Hirf1aeYcxIs
 yAT+j6No=
X-Gm-Gg: AY/fxX4Lp15+XqyDiJvyxOtPH6h5d2Oa6pEt/+YQNSceZKP6PS2b6njD/z5DmMZ9TlK
 nbCi0/7nC8XMUdJ6qG6RCxlRnb2mSMJSufjccFYjBzBYNyWs1m96MrQjoM6N+eW8tBMqi4iOLi6
 tCrC6CK3NifolE+hnBZxDQR7WV8EzIf3RgKaGhYf8dt+hYBK1AiV6KaZfSvgqO1l3jqW6d8NP8T
 tN/lJoXuLJioXj1jPg2wh7xGNWOAE4IHmLAOjv4ImlKeXQkoDxjD+iR0S4McA189G14lhiZH5OU
 4dJacU/L97fAGX1x3ISYscvSm2K10XbcCm49GAgqwTUZkhArNW+Abv8UyozU1rYyWno0ir6RX8X
 4rx5beWzt6choOziGd7Qe1j9IfJLhtyix4ojgvQkXBPwa8E/UcAHOOz4cDaMQ84IYh3Dn3abkpP
 ufhGZ0nfytzwUIx8IQm/4=
X-Google-Smtp-Source: AGHT+IGHqyiIJSMzhtOrCm5bQ86+slvufnsuZ8RvOfTh+ymxlB3QfHX7S6V40H5U9XKKHpTsldgBUg==
X-Received: by 2002:a05:6402:1e8e:b0:640:e75a:f95d with SMTP id
 4fb4d7f45d1cf-6499b16e7b8mr17118879a12.15.1765955604699; 
 Tue, 16 Dec 2025 23:13:24 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b3f4f5a6csm1566799a12.13.2025.12.16.23.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 23:13:24 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 17 Dec 2025 08:13:23 +0100
Message-Id: <DF0B0KNU874U.AETPU4ILX5BI@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Martin Doucha" <mdoucha@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251216173053.29112-1-mdoucha@suse.cz>
 <20251216173053.29112-2-mdoucha@suse.cz> <20251217070831.GA34230@pevik>
In-Reply-To: <20251217070831.GA34230@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cpuset_memory: Fix race in multinode subtests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> I wonder if this very old test is in a long run worth to rewrite into C, as depending on
> sleep is not a good idea and C API would hopefully help to avoid it. (Yeah, we
> discuss sleep as a part of ground rules [1].)

I tried, and I gave up :-) too many testcases and a really messy code. I
really wish we could rewrite it, but this is one of those tests which is
not worth the effort.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
