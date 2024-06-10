Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAA8C27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718016775; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=KQLqCLIaO+IhCUk8qUjmgd/xVPYQem9u5RSVwq1vLiw=;
 b=Qzg38Gi90uaJIXDVWGlu0NhXHsv7nT9qR9cM3Vj3fApygwG7VRyy6FT+5bvVsCHordgm+
 eWe9UhqPirER2TSMcmDSNPJ78C9KBF9Dp2fKEV6zrs8BfU1E6BjX1433sgI+7DOV4wfYv7V
 Q55Z2zSVHRiMiATNS31r0aMT4Vjw/8U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 553A43D0B34
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 12:52:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D0933D01A9
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 12:52:31 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 73447601323
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 12:52:30 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6f0e153eddso180818266b.0
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718016750; x=1718621550; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6zS7ZHeSipxOwqy8Xp3HuZEOchDjywVJpz4VgCDyZ/g=;
 b=dT/9XyEhMQFnWIhquExjzhSX1IEvb2LFsMOSj+e1ZRAPlVhSleujazJJu4h+JpMEJS
 8eGUWy0oyh0GUrDZXZK45mEusoE/rHMjNCNB39DG/Wq5LyZNHm2QIhRI/uZmoLGHN19v
 7DrZ8mFxC+baAQc4U4DNoHiC9SZa1GkMQYBg6FdoBcH1toahVwSvvGKplYBWvmQr2C+u
 9OtL3lIQdZpyEkKeM0Gv/Eh8TnSPyLmAgAYuCLU9LaIzCYc1RJAZKlRxDyVgi8IYGpM/
 NG8xOrIgTWEljIsO4hwt6tAwNlvmkg/FxwVnBFIelWZUxlmgwdfidthgf33lHBOTWhAJ
 u+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718016750; x=1718621550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zS7ZHeSipxOwqy8Xp3HuZEOchDjywVJpz4VgCDyZ/g=;
 b=wkuS8GUDzen6gtpPMU2xBPJ6FJ8Cytuk/bfwYRR60Nqkbdv2BauM31o2EeT+QEohwM
 zSYCPF+Ppy0nrRP+1oJd6rMlEj3j8TpYFan2KF1CJJ0eqqulCAmyOENTQgV3iVaZpVv6
 ka8c+o2jWj35Zjm5DKAjFc4TFYdbv6AyJ02rMDwqy6Tnpn5X5sN2JxlbBYgB6ZVXscJZ
 MDhDrbEX/jayZ74DuyGbeoYtDzPgohoUaoEbrq0NyfTgnpIWUonXYkoo9DHmQUYHv604
 lz52DvUWz7qIRLcn13K7eoMTiM5gFyEMzX3ZRTvfaYs0zMkZ+txz121yMYocfI/mctYA
 yM2w==
X-Gm-Message-State: AOJu0YxNy4z61HUeiklEJjc0hgcRP0bLZfSjcV/jj3yTo75alpyAKyHb
 1z9Ftv3f7duX4jzxEq0EMOqz6zsDWoosv7ZQnrpEIxJArb3mLoB4DD/pqwVvD0Q=
X-Google-Smtp-Source: AGHT+IECje4unIJfIJrZZU4NzYGjpXMwH2rqp/2p+ywBuPVWeI9HTiIR8ftB10LQ0U+Da4aMOWaFLA==
X-Received: by 2002:a17:906:1d5a:b0:a6e:6555:4bc7 with SMTP id
 a640c23a62f3a-a6e65554cc7mr395363766b.36.1718016749771; 
 Mon, 10 Jun 2024 03:52:29 -0700 (PDT)
Received: from [10.232.133.65] ([88.128.88.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae23404fsm7230669a12.89.2024.06.10.03.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 03:52:29 -0700 (PDT)
Message-ID: <3031ceb7-0070-4e71-a1f2-13c78fd6ed64@suse.com>
Date: Mon, 10 Jun 2024 12:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240607115304.86028-1-pvorel@suse.cz>
 <6521fb41-3ac4-4487-8cf4-e1faff1e86b7@suse.com>
 <20240610093226.GA705643@pevik>
Content-Language: en-US
In-Reply-To: <20240610093226.GA705643@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

On 6/10/24 11:32, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi!
>> LGTM
>> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Thanks, merged as
> https://github.com/linux-test-project/kirk/commit/5e8c8064a0b2cee465f2a1dca1cfebef5ade36a2
>
> BTW I wonder if recent kirk commits (SSH fixes) are strong enough to release
> kirk and update LTP. WDYT? Or do you wait for ltx improvements before releasing
> new version?
>
> Kind regards,
> Petr

There were really minor updates in kirk. We can probably create a new 
version after more features will be added, but I have no idea when.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
