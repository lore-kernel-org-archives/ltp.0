Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DED0C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704702836; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bhnwjf7317XI/nNRbaAzxUfOz3Qy+Tx7p0vpkr7ATpc=;
 b=Y+rk78z+s/z7kPRPRh8a34lFOw67mdYC08dAJ6RaspuRpcdXJPz8bEnwvKVRinJLavI7M
 jKK6QXc2L86o002YyYc1rpUWt7xr6sV6xUM14/hEg63mvdBZKMkglC0sxW1JtVP/AvSRo8B
 e51kXaMtPpvG/JEe7Zbg5v3sjn9ldsk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EAFF3CDC0B
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:33:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E48E33C8B55
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 09:33:34 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1FC7600828
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 09:33:33 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so14790815e9.0
 for <ltp@lists.linux.it>; Mon, 08 Jan 2024 00:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1704702813; x=1705307613; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
 b=FA3YkRPxmNxYqL4TRzGnlVZLLd084UkSCUKp62vt85nqu7QS1yJXDOjwhxsyJpwTr3
 jf5gLchSWnyewf8TIuSdLB0Sf6j/gDAnecBdLbDdkXuYBIfCKet46CCiHQrhGkwjSbhq
 YanhnDlfcUY+m0D2biKfvj8bZqGPTKzb7WNkVprLUAg2nauKiYNGI/GdraiW1xw4daSt
 gwZn8iafkOwRqR51pIt4TRv2qyRV2RAy6T+nj/kUOtpB4QgTOE/0EKVoCWDqEnwsyK0O
 T0jjc8JyPpISeHmDlVTUG9+QXWMWKMEPXkXKkZieT4rfOvDbj1cVE1wtwqUq0yPRoK/h
 Gy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704702813; x=1705307613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
 b=AwO6AzN4snPNCFF5Wd+fA2M6UXtycOEKCJ/eSgzesSEdNO6VbkafWu5RiWLkIJgbfV
 NYD7469Sg+iuj5dCVEu7w++G5E+S3zVjfTVHkgks/dlEFvlapxDeyUV1/RSfdyOU3Fyn
 oH+hsG9nNufyRpQ8rz3nN5VfXtHV9rWvBRQmHbkx/1ZDCV8kQnrwivOlpRsSJaOLPof6
 KOZQb1GnFjjGGZ54apYRkTOU6qbWNkeodJqMi8SA8cYsssK0fK2HO5x53rCCs6tnEKwn
 JOsgaCyFMXy5GHLzcIvFSQDLlNnRaQDn0rgYJZVbWCSI+32uEItVB++kxLvixWAFMte0
 mCmw==
X-Gm-Message-State: AOJu0Yyxpt5AgiNXh3u1z0UGpOmERo9Y+jUd4Y9x7ThbPUTK+hg9DOxH
 6EzAUHIG3KXiMW4aunm4ZcrS+eEcV90LYg==
X-Google-Smtp-Source: AGHT+IFdr9+p9p3yVvUI5Yb2+RUaaTtc6lK6/0ftFespHQFyJZzml/U22xZUgZCqObC/GxElyekYhg==
X-Received: by 2002:a05:600c:3411:b0:40d:4dce:4a2e with SMTP id
 y17-20020a05600c341100b0040d4dce4a2emr2008525wmp.26.1704702813400; 
 Mon, 08 Jan 2024 00:33:33 -0800 (PST)
Received: from [172.20.10.3] ([37.161.21.69]) by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b0040d3db8186fsm10246189wmq.5.2024.01.08.00.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:33:32 -0800 (PST)
Message-ID: <848d1908-b758-44c2-a7bd-f3e83da18bce@suse.com>
Date: Mon, 8 Jan 2024 09:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rob Landley <rob@landley.net>, Cyril Hrubis <chrubis@suse.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Content-Language: en-US
In-Reply-To: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
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
Cc: Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

My 2 cents. I'm working on refactoring growfiles test which uses UCLINUX 
flag.
During its development I had occasion to check UCLINUX support and 
(indeed) it seems pretty
broken for LTP, because nobody is maintaining it for a while and such 
tests use old API that will
be replaced in any case sooner or later. I agree with other people about 
removing it, unless there's
a valid reason to keep it.
Just in case we want to keep it, someone should take care about UCLINUX 
support, testing LTP releases for it as well, but it doesn't seem like 
something we can do inside the LTP devs team due to the lack of resources.

Regards,
Andrea

On 1/5/24 04:52, Rob Landley wrote:
> On 1/3/24 06:09, Cyril Hrubis wrote:
>> Hi!
>>> I am not sure I agree with this series.
>>> Removing support for UCLINUX from LTP is almost a guarantee for
>>> not noticing when more breakage is introduced.
>>>
>>> How exactly is UCLINUX broken in LTP?
>> As far as we know noone is using it and nobody is maintaing it for a
>> decade,
> Nobody is maintaining "uclinux" because that was a distro, but you can build
> nommu support in buildroot and such, and people do.
>
> Rob



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
