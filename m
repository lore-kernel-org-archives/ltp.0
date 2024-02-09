Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A446FC48297
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707487115; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=fUcFunOhad7QV/6+N7iQvQMZqlls8nhz4lSYoGYQSSs=;
 b=JKWrnJPXS56pvfBzJIi71LA/1BSSy0dwALB96qJTQmCFkIsqoQ5Ynyh9daQYrjewXClne
 tyvc6vftPWum7UGb1n+iRTs09iL4OE729nLtKivSyqX4lkm2BfihniDxwvw8ZucpisBpp/s
 tMdIbohfW6RxPyM/fturqU8JK8JfTDU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12EBB3CF4E4
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 14:58:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADA563CDE93
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 14:58:13 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7651B600831
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 14:58:12 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33b66883de9so378124f8f.0
 for <ltp@lists.linux.it>; Fri, 09 Feb 2024 05:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707487092; x=1708091892; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lbjcZqJbELeiBQjBagybLOyxVVHKpGu0XpcoPG0GFcw=;
 b=WorUo9AUJcOzsKILRyRAgI1hH5vuWSyGW3d6nvXQBEheZlQoRYcEcyNFq66ZT3XFbL
 qfpbpP6kae5XnwW/50wL8iJXRuUKUA6Y2S41kLp/3u2InzMr/luPjYQwT6nooVnKj7SO
 rQg88qYnwC7ni1kxez6Xvey3tDc0BFuF6PojLchyagafpEhvKc0SsIpeRRWI/4mtqXhf
 m12ic11dEklIFHjs4zPGoTQscCpeAB3m8D6Cyi15aftDBtGCMt+CPrHHEHVV5JWiFAyY
 24+jK1LgP1SzwRsuQs4TUsal6drlobyUZBin+4ynJqTdGU9bJjwvu3Uvfzo5GQQJjtZ2
 lP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707487092; x=1708091892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbjcZqJbELeiBQjBagybLOyxVVHKpGu0XpcoPG0GFcw=;
 b=CcNL7GxfHsXmZ2Fa8KvpZTpXtG+YAp7gXWqiGg8l4glo+2fUKt88YywDSNYcYjbtYc
 RoQKYbW7y7Rf6TEVOhty9GfpfEl5bCFCMQEiJxZueifzf9P4vZ23vgn8pvjupPzZBAnx
 EMwXnYhBE+lvaGhNglUXGwgYy91gqWES5jY7OcOtMVaq7yGhCOx6rHhDe8/gUWMr6kX0
 J9UkgkHzcGxTnuYOYTLCDnH6Bo1f6tQm0/rh1kt3N4f+ICyv6W7kDe1YNaTqubID+iz0
 U3h4dpYF3riLss3PNpOrK1J+eaOwKWvLpbLM+fwlrXAIQPdn8633SWqqgdiN84gvEgB6
 ZFGQ==
X-Gm-Message-State: AOJu0Yz/fxloep6hKorpsjJ2BjyDQQ6Sze5rsElnqkTEPM6yWl5SQFYH
 bjOF1V02vrYqgn9QIKpMGjL+rvGHg/Xp6487T9HEzVKtnYWrzDxYdoJSF/K3ZJQ=
X-Google-Smtp-Source: AGHT+IGy/2vWYpzZkWECioXz28q1PEayoCzU2r1aXeTpTCjlkxLWb6hOdy9Zijdo7T/tBXfQEjkVxw==
X-Received: by 2002:adf:e687:0:b0:33b:20f5:b90c with SMTP id
 r7-20020adfe687000000b0033b20f5b90cmr1175970wrm.13.1707487091885; 
 Fri, 09 Feb 2024 05:58:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWSaOYz+BBL8Wp8m6LWrJzX50SMYCIG4Ne+FipZ1MlZnb/HW+yE7ICb719vvC5m4cjmPrsmtIqPrsv4cb6xw915g15Ujeeua9suLkVqk0T3QCDKBH7FY8A78A==
Received: from [10.232.133.56] ([88.128.88.29])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a5d55c4000000b0033aedaea1b2sm1889295wrw.30.2024.02.09.05.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 05:58:11 -0800 (PST)
Message-ID: <4dbe786e-0701-4e83-be4d-79176454ac44@suse.com>
Date: Fri, 9 Feb 2024 14:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20231116152108.10155-1-andrea.cervesato@suse.de>
 <20240209135445.GA280250@pevik>
Content-Language: en-US
In-Reply-To: <20240209135445.GA280250@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactor timer_getoverrun test using new LTP
 API
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

Hi Petr,

Yes, indeed it's not needed.
Can you please correct it before merge?

Thanks,
Andrea

On 2/9/24 14:54, Petr Vorel wrote:
> Hi Andrea,
>
>> +++ b/testcases/kernel/syscalls/timer_getoverrun/Makefile
>> @@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
>>   include $(top_srcdir)/include/mk/testcases.mk
>> +LDLIBS			:= -lrt $(LDLIBS)
> Shouldn't we merge without -lrt, when we test only raw syscalls?
> If yes, it can be merged before merging.
>
> Otherwise LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
