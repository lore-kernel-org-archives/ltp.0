Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E0C27C65
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718022850; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=9hTtoqTeDfZznHty+DvsfOoLs8Qu4jg6nDIxLxPwaqo=;
 b=JQirQBFeu2CFS73ljt6i4bzNQDl/gN8gWbMaiqSjNcJl1/O/ubDpVMhjeUA2YwHTmCxOX
 XcnBDNeeKXfvmM3yeAeZKlDNjiysYTCE321AdFFgtEaBYVZWLqvOxD3bWoM2rD5m381CYh3
 TccfRGRazGumXr8Cu7AGRJdH889ndms=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37B243D0B46
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 14:34:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAAF03C9430
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 14:33:49 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF3001A00FA9
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 14:33:48 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a677d3d79so9863677a12.1
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718022828; x=1718627628; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2uQibaq2GBc90BtW9x28EiayAcEKQfi49hxm4hrZe2o=;
 b=cKHxwUzVWRlwtf+mSRdaKNyJ7LVShE2r3wRFnzfTnwNzU3FZB2XlOb053wylUWA87M
 ioNwIAgvYNRdsxTVIp+8SnGw0elifLFebZAmPgKIomvvKN5Xthyggk4jmsOCjbiYNsuY
 D9wqoJHFa2whEwqlfqZ8jPFWbaI9uumehn/6z4O35eER1EnvMAwe9SQTD+6tDPHKjeIb
 d708s6PAQjrJVT2/0illcUXlkMeyX9y99fhHm3qprCt5ImEYNZrOxRXWu1iFvhLtk9fe
 m091zhFfZ3teAOX9Vha9ohH2vYTyYzmEzetnpbWPnbKt5wSBLS4KcRCe/KOGzhKvMkUJ
 ZoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718022828; x=1718627628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uQibaq2GBc90BtW9x28EiayAcEKQfi49hxm4hrZe2o=;
 b=hJdwBNpGVk0Evn5v+79iQK24tYG+O1R6jMnr+Y2j+Jiucqrbc8j1hGXb3Quhvz5Gt4
 9yhwNobylzXSupv0fT/pFHjffQGRm9of+8jyySCwsEuKrFEiojtcNHHOAFn+fzDyPToe
 CPPKBQpAKnbDXtorXsE1WxvX2OPtlH+C8hTYUHf/njfdYZw8btF4xLSpgunqS9Xtxvpx
 dTE88q8SNJFWREI3XyCrSvH0b32tIEixCnp1o+a86X+VETfHxX5gEHJ6+4vVWH09m/KQ
 XGnOYrrbyNfpyQ047qkiuzYjyoJf445JS2/7caGUeih2jv/OCpKd1IM1dOK/AyPQTa/i
 JK8g==
X-Gm-Message-State: AOJu0YyyHdUuOD4SBFNAet62kZDNr2FiPIujkM6bruBXEmP55QChEZ8x
 aOJS3j2hXYyqcniCBJ8my5CVQQH9Rn4W3nVkmIs/g8cDXINHJkWzPwSHxiSC7YA=
X-Google-Smtp-Source: AGHT+IHJ2/0xJFZfrOeXffAlirrF78ZNdgMzMx6zOkvNOsxyZenR40TUcTg/VP892Y+hb1TuunHTmw==
X-Received: by 2002:aa7:d6c8:0:b0:57c:537a:49c5 with SMTP id
 4fb4d7f45d1cf-57c537a4a7cmr6510882a12.18.1718022828015; 
 Mon, 10 Jun 2024 05:33:48 -0700 (PDT)
Received: from [10.232.133.65] ([88.128.88.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c8bb27687sm800427a12.15.2024.06.10.05.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 05:33:47 -0700 (PDT)
Message-ID: <a5ef2eef-9061-4591-9613-b2b64cee39dd@suse.com>
Date: Mon, 10 Jun 2024 14:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240607115304.86028-1-pvorel@suse.cz>
 <6521fb41-3ac4-4487-8cf4-e1faff1e86b7@suse.com>
 <20240610093226.GA705643@pevik>
 <3031ceb7-0070-4e71-a1f2-13c78fd6ed64@suse.com>
 <20240610105759.GA710648@pevik>
Content-Language: en-US
In-Reply-To: <20240610105759.GA710648@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [KIRK PATCH 1/1] README: Document passing environment
 variables
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

On 6/10/24 12:57, Petr Vorel wrote:
>> On 6/10/24 11:32, Petr Vorel wrote:
>>> Hi Andrea,
>>>> Hi!
>>>> LGTM
>>>> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>> Thanks, merged as
>>> https://github.com/linux-test-project/kirk/commit/5e8c8064a0b2cee465f2a1dca1cfebef5ade36a2
>>> BTW I wonder if recent kirk commits (SSH fixes) are strong enough to release
>>> kirk and update LTP. WDYT? Or do you wait for ltx improvements before releasing
>>> new version?
>>> Kind regards,
>>> Petr
>> There were really minor updates in kirk. We can probably create a new
>> version after more features will be added, but I have no idea when.
> OK, thanks for info. From the description they looks as a real bug fixes which
> would users appreciated.
>
> Kind regards,
> Petr
>
>> Andrea

Yeah, now that I'm taking a closer look I think you are right. Let's 
make a new kirk version then.

Thank,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
