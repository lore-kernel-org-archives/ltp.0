Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B9EC4707C
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 20:12:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B8DE3CF095
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 21:11:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 219913CE3D7
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 21:11:45 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C9BE1001142
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 21:11:44 +0100 (CET)
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7baa8097064so319277339f.3
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1705090303; x=1705695103;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+m+8+sn/yrRpMNmoKuVGJnl0KXgHIO06YV19abnxPJI=;
 b=f/airsLGnBm/5m2KD2HEeIUFLoRu2J/fx6QG+u5bxHmB14aqSKeUl6I5fOPY9EMYSz
 JjqBfy19Tv0S9mt++0m5kSeApDRuz880FueoTfKd1uETpQGw9CMygttVSt16wtr5JJS3
 ONNfbi1BtcwrlxhExLai1TE1YLjCqB9QnZqD0LGDTsxKbJS+mZaqgBtl3fWGnYrymOXl
 SF91GAXOV9S+TEtQxc6zssmCmNAoojy6Hsvjj3AfrpGnM406gwj9KSug6rGMTQJOyZKF
 iXtG5rZpwwtdg3no4Vdw7kvtyn08Ah8SJ/ygoAKKK8lqkHaLTEpRSaTnh/QDQ0GwQn+y
 QMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705090303; x=1705695103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+m+8+sn/yrRpMNmoKuVGJnl0KXgHIO06YV19abnxPJI=;
 b=u31j42t/DhAeAck/iQJ81aV4zkMI0jUZ/rIqjE/Zh8HlNUQNmSmOVNHcmhrPC0yssm
 7AmVaGS/rD6NFua/wM8aWKNcSQALwD+G17QlfB33TXb058eRjoCNAH6+8ebyzSg4XD2w
 6H+HMSQmG5fliPr57RBGHkELQyJbv+d3lU5YlYyz0oPr1Vhx0MQYiYWvhAEijU5Nhpei
 zXxn17/k12bYkBt+c7yAM4JvhYooFuVtBEoMJLX0NbeUU44ua75YgNDFNA2WGgwn8Auj
 aPEQ1udZNCmpSWunpTQWjyDTkbVVSeFCirmOjnYlawflv20V+XxkoN6VLZBHJ85EGmxp
 QLIA==
X-Gm-Message-State: AOJu0YzLagpvUt1Z+FdtHZsQFlFtx/cw5nL1jKehyHsvvJmb0dDIXZxb
 vkwUhfEgWnIOkCrRU53Nd24wFJog4veV4Q==
X-Google-Smtp-Source: AGHT+IHqoFIA5SsY0S6pP9E/YEdP51Pl+qXJMok2jHmvOWgujRF0EPJI7JOUqJM1HPAneMcc2A0bVw==
X-Received: by 2002:a05:6602:89b:b0:7ba:b9fd:a234 with SMTP id
 f27-20020a056602089b00b007bab9fda234mr1993100ioz.37.1705090303206; 
 Fri, 12 Jan 2024 12:11:43 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
 by smtp.gmail.com with ESMTPSA id
 bt9-20020a056638430900b0046e25a7bb9esm1063767jab.176.2024.01.12.12.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 12:11:43 -0800 (PST)
Message-ID: <2ff803d9-748c-e168-3775-b05fb11868bb@landley.net>
Date: Fri, 12 Jan 2024 14:18:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Greg Ungerer <gerg@linux-m68k.org>
References: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <ZZ8JbCPd3rq4u7iG@x1-carbon>
 <7e348eb3-bd34-4c66-9ed6-b5108da80486@linux-m68k.org>
 <ZZ+zB29hRhpjiOrh@x1-carbon>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZZ+zB29hRhpjiOrh@x1-carbon>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] Call for nommu LTP maintainer [was:
 Re: [PATCH 00/36] Remove UCLINUX from LTP]
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
 Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 1/11/24 03:21, Niklas Cassel wrote:
>> > s/Linaro/Lineo/
>> 
>> Lineo was not founded by Jeff Dionne, see https://en.wikipedia.org/wiki/Lineo
>> for its genisys. Maybe you are thinking of RT-Control.
> 
> Yes, Jeff cofounded Rt-Control which later merged with Lineo.
> 
> My main point is that Linaro is a completely different company,
> which did not "die in the dot-com crash", like stated above.

Sorry, I typo uclibc/uclinux all the time too. (In extreme cases I swap
busybox/toybox, which is personally embarassing...)

Rob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
