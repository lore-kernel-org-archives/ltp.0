Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D1BC3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704702904; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bhnwjf7317XI/nNRbaAzxUfOz3Qy+Tx7p0vpkr7ATpc=;
 b=H3oOBD9mcwaINWI0I6R5m3UZEyzJ0WF6vbVOLNp7RjzxtAy+KoP0j8zv2/eRjR+KVV7F2
 Xy9lHJRR6NRB0mkgTT9YPyLacRN9PHZAPYJd4B9WhYVbKlNktNzQlVhGKDOnJpBk9G2dWkf
 Mj7v16Js8GrEcfIgxOjVMBOc5RWbOV4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C76233CE53D
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:35:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73833CD371
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 09:34:42 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E9D501400FAB
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 09:34:41 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so18242615e9.2
 for <ltp@lists.linux.it>; Mon, 08 Jan 2024 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1704702881; x=1705307681; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
 b=e68cdOhKsDCT/iPKxw2BQt7pa0LqVS+B+/BzVCF8SgDSjWjnG4RwGvdhXgcVsZdHUR
 4b247GR1XNuKiCgnPJJzO0TVXnU5v+vsCuCf7rDflsWDAlnsIaFCR5iZ+vTAPmYZujNi
 K0Llxya6V+jD/jnZ2KqGNkoSY2LFg3Hw5P4oRK3PEL7udfc8SmRshaY2rSyNH0d1QR+0
 fKVSp8JgjIYYPRvrYLM0t/5tSukpgg0ZVJPa777+tWRs50L+n3u5CBHsiDkb/ixkeQsT
 PG7+SabTAUKRaJRrEQAA1EwzP4QLK33qNuxOtNm8f3w/lU8mGRZFY9M2lLQTfrMqm03g
 qXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704702881; x=1705307681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
 b=HQqSw31LK/aJBQcjMNqMqhyrAudJSJpmtSIZ2cp0db9QPVthlL4OJYWTwt4zGpZWag
 B+xcDnpGyoJHqJAJ/+vnedFoNK55SqTPF7A0hUIWsikVdlbXehllERs70fboN0C14IFs
 n2PP3w9mZMK/V4sILScZzAd44SYK3oHDL5wKbwhZhIkcOGnjcnxZl7r1T0fuKuHpnF9C
 ihreRxEZ7oQ7R/J2n7eYKN948DwlB41e7E3zxT0pGgmYdMnDPExudapLmuONYZOiut35
 SIZlPfzODqS/GyvxgMwgMvfxtlkbap5sNrJOdeYZrUv/tC+V22YW+YPxlQfFiqZ2hcLb
 5yRQ==
X-Gm-Message-State: AOJu0YzgEizCE5db0gTxKWWj9zHR7BE4pWc/cegFbyEgc18zxrvF8FsU
 UX0nAAJyWWorB5ofTCAXsOIQTft31nItNA==
X-Google-Smtp-Source: AGHT+IG/mp6y+0cYUrDCavig/3hnnulb4tFtsRjSF6zEM6NAi6nWZTX4f7mAdVBvGKSLQG0+ZSf0JA==
X-Received: by 2002:a05:600c:3ac6:b0:40e:4785:276f with SMTP id
 d6-20020a05600c3ac600b0040e4785276fmr507460wms.100.1704702881399; 
 Mon, 08 Jan 2024 00:34:41 -0800 (PST)
Received: from [172.20.10.3] ([37.161.21.69]) by smtp.gmail.com with ESMTPSA id
 fc7-20020a05600c524700b0040d7b340e07sm10122595wmb.45.2024.01.08.00.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:34:40 -0800 (PST)
Message-ID: <6fd9dcfa-b412-4573-a2c7-e4ded89bb225@suse.com>
Date: Mon, 8 Jan 2024 09:34:35 +0100
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
