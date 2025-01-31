Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAD0C0218D
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738320532; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=pIhwPw3TYTq5l3U2tw5v6dHDH4160NlWrdkNxzE5x8s=;
 b=nsxbbQc3Uz2TYY2ueV6jn+qvcFstKbEsoTfnrjgvlBw2rri4Dt7BUwXrgkab6ROEsejd3
 g+oNIWcC2WTdHJFFHGjmoJPOkIdIgLhJTuAagAFl0Pe36HCEzK1Lif+pd3qCilp13XlWGqW
 ePHUoqZiMNr+pbhUq9TpANvpQ4lX8CQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ABB03C7ADF
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 11:48:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 512703C6F7C
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 11:48:31 +0100 (CET)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7991C62D1D0
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 11:48:30 +0100 (CET)
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-5dc7425ec5fso3247934a12.0
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 02:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738320510; x=1738925310; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfLZr14NvMB7CFtdw0ta/KVy7Sjhhk2y16Dd0ofeN2Y=;
 b=WRiStZteWsCYRQLJXOrEwr0o0iL6mx3x/wCM9YnnFYCILak8Xi8CfXZ9lUYHq8Nggx
 HvzIrjW+3axKDizIiedQpj3+jGvF3PFN0CuJStbUZjf2ILjDV+Ua7aL87zKl2HjI0oQ2
 n17vlfvRiYLCe1kb4YfKZXD03XROmHkNWpBRJY6G2ZnIpWwty1nC7hbZCbnEfgR+Ucqf
 m/Oe7lkSb+ZZAwOr5KxM0vHYMXiNIJwJCceSdrvadxX2/i6n+iQgAA04XH4GYurmBBGt
 wGFU0z2IczeJP//MuaqfexQ1CQJ7mh6GVzkpxx2CSNhG4fvZFWNYp59sOBz2QlWAFKko
 VfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738320510; x=1738925310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfLZr14NvMB7CFtdw0ta/KVy7Sjhhk2y16Dd0ofeN2Y=;
 b=D6vSY8OMyB1DLrNuGHhYBMyGlWCGA6ZZsZLGxMqLsmQw3YIi+zEgyl+Ht4AMvFiGoi
 ej8rf71gByU0+Vjo/zgOLdXt+u5hE1vNPumVxmXPHhtYLRtatf2s7fRCbcCsfRap8CN7
 WAKcRnDilAcb55pbilDFjkiuk1Kb91EA7GGinDmtYIXGY5w4DPblpjAYbhwZACk6JPTS
 +XiXYhkFphu7p26nRbHZoxCUL1F//w5a5WVeB+pMrev4dkiZdPXgt7YXnaZCQz7lPJIq
 yo1PcwfTWYXkxKyNYiw33FC2lbtBiP9tV5IN7o3TF57ZldKfZEWzQQqfJwjp/vbVx6kx
 6ZUQ==
X-Gm-Message-State: AOJu0YycMcZ09fpD2RIMpfcbfxrhJxByun8Q8R5dZstLD47+uRMoJtdZ
 viezJ38ta2ZPbUVNypDZFnYL+6bgYJOU28nzvJ8mx14Eq8q8zbFjDF0+dkYO4olaXYVIl1m09iW
 6R6OAFg==
X-Gm-Gg: ASbGncu14PE/F1ag62OzgwORXS8VtOBKU6OVwcP77uNkNoDsWaeL+eqlT+bHTXITiCP
 HT38n24Amz9lx0wh3PCFoHb+/3W0SztSeuL+rRExt7KInq9/EZXMsdjiepvVJt7hl+11XGAesX9
 V+AYDMtAEjQ4pPaeeP9vUkf6HRbbm9AZ4nMusZpOsjnpKh8Vfp7My6LS0gt1y1YugGsP7dfyADy
 OXy5i/y26quRfqg40d4dPC37CvUxeJi+zzdY/gZM+8ssLBGPxpNkRQB+ZLSjRGjoA9/S3zmuG0K
 +NB0bNPmXd73I4I9wuA7Hdro2uq3jBGryglhCYAW6P6Pu4IeQcCEOg2rVbFvs6D5dBWFfFxQrfw
 m3FPk699GWlskH4P0Lxds1Y+9ZBLQAr9k1FPOt+nAiRRqm4fWfmI=
X-Google-Smtp-Source: AGHT+IFfcLd0qvC42Gqe6gyb0ZVuYYR6rWQhP+LH+KvKx4gdBv6G6IiXTWcE97avkKesX+DHqLliZA==
X-Received: by 2002:a17:907:6d0b:b0:ab6:b8e2:ebf3 with SMTP id
 a640c23a62f3a-ab6cfda42c7mr1203082366b.36.1738320509785; 
 Fri, 31 Jan 2025 02:48:29 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723e9fe4sm2623082a12.26.2025.01.31.02.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 02:48:29 -0800 (PST)
Message-ID: <f635d8c0-41ba-47ec-9c85-85d36b756215@suse.com>
Date: Fri, 31 Jan 2025 11:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250131091535.GB1090737@pevik>
 <92cb274a-440a-42e5-95ab-5dd0e1513074@suse.com>
 <20250131103451.GA1097590@pevik>
Content-Language: en-US
In-Reply-To: <20250131103451.GA1097590@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Remove [Description] subtitle from docparse
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


On 1/31/25 11:34, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi Petr,
>> I'm currently working on parsing metadata in order to produce a tests list
>> in the LTP documentation.
> FYI I planned to work on it (announced in ML [1]), but since you started I stop
> working on it.
I'm sorry, I didn't read carefully. The results will come out soon tho, 
I will send the patch-set soon.
>
>> I just replace "[Description]" with "**Description**". Same for
>> "[Algorithm]".
>> I would keep the bold version tho, with the double star **.
> We talk about a different things. You about the conversion of the subtitles to
> the final documentation (previously was done in docparse/testinfo.pl, now you
> will do it in python).
>
> But I'm suggesting to entirely remove subtitle "Description". It looks to me
> useless and some people don't add it thus docs looks inconsistent.
The thing is that there's not only [Description], but there's also 
[Algorithm]. Maybe we can think about the tests description as a whole 
RST code that will be injected inside the documentation website once 
it's published. In this way, conversion would be much easier.
> Kind regards,
> Petr
>
>> Andrea
>> On 1/31/25 10:15, Petr Vorel wrote:
>>> Hi,
>>> Can we remove [Description] part from docparse documentation in tests?
>>> This is transformed into "Description" subtitle in resulted html/pdf.
>>> 1) It's not really needed (it's obvious that it's a description of the test)
>>> 2) Sometimes it's missing (inconsistency).
>>> I would keep other subtitles (e.g. [Algorithm]), just remove the first one.
>>> Kind regards,
>>> Petr
> [1] https://lore.kernel.org/ltp/20241227073921.GB290415@pevik/
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
