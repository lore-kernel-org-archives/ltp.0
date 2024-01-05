Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184E9C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:16:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59BB83CFE1B
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:16:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B78CF3CD427
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 04:45:34 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0113F600A6D
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 04:45:34 +0100 (CET)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-680c7cf2ab3so5565036d6.3
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 19:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704426333; x=1705031133;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O8c3ESdi0IpZK01xiWxgeJ4UdiYi9dbopai5vRQAmfM=;
 b=OHmVRphJvEDZue7ZrbO5DNiBmLLpOCvyAK1bhfFtUrkpFI8sd9U1lvxMWwhRGmFLLU
 FPNvoGeXYhnG5DMJAMc7UKt7RpI7Locv5KAttq8csjTmGfH1nBVb/SBV7wwggRx0YupR
 /H60Jt5f2ozcaPNg8Viwd5Du6hoBO8ykNE1iVgr2w1ECjVasVCPMlcdHGXDDkC91OgpS
 sS1BUjS/wT54ZFM9rmMg9ErvidTlf29TktKj7oKSE5RLsROpWoktxuv6ATEhBbNGWmKC
 Ad4cdw2r9t8lC/LORucy+wco5POa84k63X6xcgSbJv/ThGbfyfQ5e5/NxK41/OM56Jig
 YNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704426333; x=1705031133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8c3ESdi0IpZK01xiWxgeJ4UdiYi9dbopai5vRQAmfM=;
 b=dTXPhtbI/xXMbiFghyvO9qRiVfeIhOqx/wFqGs+nvo9qksPHforL6IIpQ5cPc25t7T
 K6tS4Fk6Gwzrjw4PB8qDe2dDC3mI0y8y8Sqcsl6Eo+6doP3S3fMLNer0osodpNg6SnQg
 w5yI1Ea9lT87N/VjXwBOfO5Du8FupENbyFgYf2gMYWknIMhnqUWKpeJwjla67FOJI8v1
 CSKGXThULfbE1ly003JXpCX7pJMEV3HIpAxjIzV0EcpuHmkWORq9wxsNO7EaE74vH7ZZ
 ep0MrQY+YkbuiSlbOs47fYdiupxHvSFDJQrZsBmAg406yTYMlZltllSKa4yw0zblDnfs
 8+Aw==
X-Gm-Message-State: AOJu0Yze7mVnson8OkYVEaH2c/4c4aKPdRs7lR0+LdjcQZEd2+w4tmRN
 jTa5fsqJMWXXhAPKwc0MjtyOY17gCUI42wYaXbOYLzrL+naXUQ==
X-Google-Smtp-Source: AGHT+IFbkA2aPU2aI39vcY4LyLCBENRrl6F3tJNOaay03B3PVHlOWcvhr88DceJ6bvJ0p4z3390ecg==
X-Received: by 2002:ad4:5742:0:b0:680:d233:9d7 with SMTP id
 q2-20020ad45742000000b00680d23309d7mr1637485qvx.125.1704426332729; 
 Thu, 04 Jan 2024 19:45:32 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
 by smtp.gmail.com with ESMTPSA id
 n12-20020ad444ac000000b0067f75dbf08fsm307623qvt.11.2024.01.04.19.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 19:45:32 -0800 (PST)
Message-ID: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Date: Thu, 4 Jan 2024 21:52:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZZVOhlGPg5KRyS-F@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jan 2024 10:15:32 +0100
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
Cc: Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 1/3/24 06:09, Cyril Hrubis wrote:
> Hi!
>> I am not sure I agree with this series.
>> Removing support for UCLINUX from LTP is almost a guarantee for
>> not noticing when more breakage is introduced.
>> 
>> How exactly is UCLINUX broken in LTP?
> 
> As far as we know noone is using it and nobody is maintaing it for a
> decade,

Nobody is maintaining "uclinux" because that was a distro, but you can build
nommu support in buildroot and such, and people do.

Rob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
