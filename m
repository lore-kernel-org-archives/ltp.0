Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B1C3DA5D
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721041859; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=vWgVkG8iXCh7pnjpjIfbfUvtzIHnAhMT9M0io8tkSHo=;
 b=D5zP7RetV8eC6UB7JFFu/EmMk12v09S5spFqjVxoEOd32ZWr3S9WjWnspoRkzwYeRm742
 ZeAmi/6wwcDfGaLKg+wnJNCUxUDwoNjfc5uW87yGhFFX88WH7Yx4zI6SZ4el+X71O3qFqUa
 y/wniLQ+9Pp1+N2IKEtMOo5JulHgUhg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE0763D1A2D
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 13:10:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C543C2BC7
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 13:10:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0A533201729
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 13:10:37 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77c349bb81so433119066b.3
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721041836; x=1721646636; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XHA5r3T6a0QHgOxorxxMz9Y24SYnX8ya3oJSly/m8Zs=;
 b=SQ7MlY6bzjI9N5EPO74z2Xr4LoRYYBjpSynPE6pxBvHMwORjx6fW7wr88+9VNCVUhi
 4AGL50V1kKU4RKP8ILwAw75tG9jC7Acbqh0gIP0RdQ7DGIKID98kKe6WZuqP12/zcIh5
 I9fq1a2SCCQ0T0QtcsZ/zxf1W9ML/eRqEFD9Dvwg4w1jBGpgsLKa5u64LsEF3FM6EBDY
 a2HiNXaERHHoy4Tu3+eWSQMrYrWT9/sHVxBh0CmDqk99jxYbwkgt8Yjcgsk9MPQoOoCA
 y10gofleE33m4Wv7nVQ4qKtHKczn3D4T3rqjvRIaxCYzDjafW59AE5YatTiud+4aI7MH
 hMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721041836; x=1721646636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XHA5r3T6a0QHgOxorxxMz9Y24SYnX8ya3oJSly/m8Zs=;
 b=ejBIV67nElW3fhBM+R2lqdf76Vna6sLnCMTPbTwLqjIKaqDyeyDWgBHyIkwGPdAdK/
 H7FBOsYacLU4wg9Ah+/3scL7P1tAEreF1Pj/f1JtEC0Hga2wEHO5eHVnmnP4lxJNX3Co
 n5SZdicGJrntlKm8BxZz/rzQFBxJurDSasCpa049WvqgcvySFQvCcxiJXp3XM6ekfpm3
 ifivrU8gbTOSthUcjR4ZEjoZ2eLnvtVINzpKcbWAl3hO8D1PsaTlyuK9Rak/0sEiuXjb
 NYbOLC8kzyitpltOO7V3hmPSdL+1XRXgqAAn+Y35CukW83hoL5NNx7O3u9Wsqn3uRPCX
 KqCg==
X-Gm-Message-State: AOJu0YyIhl6/eEJJWedFpQZ7Waa0RcT13+vleGE6c6nxSrqWj50GPCTN
 tAjajhUTouda59wqAFv/iW0ec4soT5SkUmFTPRKGvoc0QzH7Pv1owheC2ZSPFHRPgi0nCKdDTPU
 +4lY=
X-Google-Smtp-Source: AGHT+IEVNhol9n8wM4xp46kQ4vyWDmDBzFtUKJvTqoHtLZIupSm0WhMCJI3ST24qvU7h2flzID9lvQ==
X-Received: by 2002:a17:906:f6c9:b0:a77:b054:ba7d with SMTP id
 a640c23a62f3a-a780b705414mr1181169466b.46.1721041439044; 
 Mon, 15 Jul 2024 04:03:59 -0700 (PDT)
Received: from [192.168.178.49] ([178.20.93.127])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b268a293csm3237502a12.67.2024.07.15.04.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 04:03:58 -0700 (PDT)
Message-ID: <e3f88888-2a5e-4515-9805-bc605e081f52@suse.com>
Date: Mon, 15 Jul 2024 13:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
 <Zov59BQ_7j-1080J@yuki>
Content-Language: en-US
In-Reply-To: <Zov59BQ_7j-1080J@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] cachestat testing suite
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/8/24 16:38, Cyril Hrubis wrote:
> Hi!
> This series is missing all kind of "interesting" tests namely:
>
> - tst_fd iterator test that passes all kinds of unexpected fds to the
>    cachestat syscall
>
> - invalid parameters tests, invalid fd, invalid pointers
>    - what does happen if we supply len = 0
>    - what does happen if we pass off or len out of the file?
And another thing....the kselftests only check for EBADF and now I 
understand why: basically cachestat() seems to always pass but when file 
descriptor is invalid....
>
> All these corner cases are probably more interesting that the basic
> functional test.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
