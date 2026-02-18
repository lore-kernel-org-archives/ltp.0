Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49C8E9A03B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771399979; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5d4Q1iaN6xjf4hZzMQpHwjJI/5C3TUXZwOjkQEKLiUw=;
 b=O/ckLAoyQeHPvg7h5Zb3PeMP5/qdhbqbmAM/++7ZaKNNv+OjVPOn6yCZqcgojjzpOjGK3
 +7nWMhLdBTe4LAT6tvkWhFGUkpK4j7ChNW4QOFpM7BnXuyVQp9iwmSxH4JLVKnLK86ZFyZy
 cn/zZw+NNff31vflEgBBNG0W0KuAZOs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F36813CF68C
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 08:32:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EAF13CB3F4
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 08:32:35 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E8CA200385
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 08:32:35 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4837584120eso33056855e9.1
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 23:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771399955; x=1772004755; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7eGztQlAkQSrVCxI+vLFy261YQhcKqaYEKCESKeFXw=;
 b=fOOHjaNNFU7RmINsGQM2HOTLaFDqIGSzX/EhyUgJl03FZXDgxFkQnzqom45ZIqmZgV
 qn+TVEyir7yJu8tdUO482UmENOH0XtPaQNX07ObXR+BA3FoGlOquaDqN6eVoNcBF7R/T
 52k0MOeeqUIM/drQqxBtmWAwXeYdWd1Fnxpw1du1w02YWp9k6H851uoEuOOT5zdqhsOY
 MVDzJgu4O6ZIhgjg6+Wdm++HzvfgJcVZa80K9/PwOythaowgk4YErDm+I1uAoLu4he5T
 nNRvKTdT2mFS1Z7jk1aahHzXmO3kgdo8Hym4EMAcc6Yki3qCMmYWaTQaJyvO6DCftyzu
 LG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771399955; x=1772004755;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w7eGztQlAkQSrVCxI+vLFy261YQhcKqaYEKCESKeFXw=;
 b=QA/3LUVPaY7IgqSiXACTpR54F4HeRLJ9okDfPh/fknqMme/NKlcXmzLqy5ZWomIhiZ
 4SdaVcQmHOdPmsTpJy4GzwMNSZfXaON7sF5pMjoaBarPECEKv3YiP4NDBMPc6OTXWk01
 wx51eSxaFKdW3r9BfJpdGSq8mHS8GoqEtbgCl+jaU7TWlE8y5A4iPwS+KLwG8z9fEfTZ
 mQqLNmUyS/yImGtMTER5ey3HWZIumn9sfSudNHeaxHbXLhAp1xif/neetWgG7xrk+wzC
 M2vBSby8rPSIpXNJB+x48PvTyk2rHKXpUzmDD1VXPKfsEvPpZcescX6RQ2GWZRgpN7cx
 dywA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVemXvUHFDNWZMAJLpD88rtuyNwSeOJdecKlgtTEP6NaQr5dvAtv4SHoy/AkDGbHYh1CC8=@lists.linux.it
X-Gm-Message-State: AOJu0YynC50cWY8opme3PNCrfP+iIQKBmsgM2DqOZOCy+8pAD2l6NzKN
 bzsVmylk8TEN1jjJgbt89OmcYGgBaY/Uj5jR9Lf1sbp8Twzwd1P3Kzc/XqjirPTAsIo8AyiTejv
 6/oLlNJA=
X-Gm-Gg: AZuq6aKOpiVSl25KBLrBQAjiLSghylLtoWPX3psecJkGWK/WD5Hamz38gKAJV2W3hYf
 1bIeDtDMkI/7QNAkqAbce9zJuKe0Cq8Nix4LLtlW1D5CafeiB9gGhsspSE+UMmterMhDpmMEe8P
 R5SKGREATKCu2UFIcUWZmXcP/8l9O4eF+N67FBc7JT8/KNsk2Yh2GRnUUWY5If2oBukc0L9Avcy
 8usxWQd8R9JvqlIi8l0Izqbo80jOqxFjh8VACF8293RjhyvuLHGwx7zejYPKwvVY7nUd8jzwAiR
 kQwdoPaxzSf/04AWGcmoKenNis7fPAn7iYp54daebh2p4BEuH6XEi4rxF9GKwwB59a3UKnwpUlI
 jMpjwsjezBdgTcSGafPLqds7V500Ix6vKa+lBxOBhKwlaK4CeyMeyZgRrQAS+E5MpEktzq9FBPa
 +wmKee8E8YTgQAnTARoj4U7hbdJ/WjGv3zgZztynE8b/5ShP7Nj0JjTesw6aQKD46J546RuubCC
 bUxt5N24piRKrn7pnA=
X-Received: by 2002:a05:600c:154a:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-48379bfc005mr238264395e9.35.1771399954625; 
 Tue, 17 Feb 2026 23:32:34 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d835f6bsm549952505e9.14.2026.02.17.23.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 23:32:34 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 08:32:33 +0100
Message-Id: <DGHWVKIT3R2X.35ZHPUJ7CCISU@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260213145200.23935-1-mdoucha@suse.cz>
 <DGHA452V46ZQ.1WJ56YNH91QUB@suse.com>
 <b78e314f-c439-409d-9659-96f7f81462ea@suse.cz>
In-Reply-To: <b78e314f-c439-409d-9659-96f7f81462ea@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] readahead02: Always allow at least 100ms for
 cache to fill
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Tue Feb 17, 2026 at 4:39 PM CET, Martin Doucha wrote:
> On 2/17/26 14:42, Andrea Cervesato wrote:
> > Hi!
> > 
> >>   	if (do_readahead) {
> >>   		do {
> >> +			cached_prev = get_file_cached_bytes(fname, fsize);
> >> +			tst_res(TDEBUG, "Per-file cached: %lu kB",
> >> +				cached_prev / 1024);
> > 
> > This should be %zu. The rest LGTM
> > 
> > Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Good catch. Should I send a v2 with fix for the format string and the 
> MIN_SLEEP_LIMIT rename, or can you fix both during merge?

Maybe it's better to have a v2, so other people will take a look at it.
Thanks,

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
