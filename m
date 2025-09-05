Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B0ACA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 06:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757053468; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=HYCixcFtXdz8nDaDJSgQ0muiN6SYGcwJ92f2c6u5RkA=;
 b=ocHVFdXcUhFRShAc6fahDcrvvGvH8mNXbc8/crI1KGPoLsFI5/MRDqL5Pg39tLtyJXEM0
 VpxQbGfWJ2cG0dnaW0vPAZkOprPi/DW7RGnd0H45IsBoM3aFv5i25q9JC+Gyeg4qYO1ABcU
 tLS7hRn1QEzBquQlB1zwF04rIj/eqeU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B28E3CD4D8
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 08:24:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 098433CC3B6
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 08:24:07 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F9FD200985
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 08:24:07 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so360290666b.0
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757053447; x=1757658247; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJROZMV4k+mo1SmHXe9eALQkHsiNFPIxBaJRzyqGEiE=;
 b=M6udQIXNpnlLNR4A9/DKUb5jzI5NsPs9B4/IxfMeJRQRoJtbrDGCaLVKcjABJP0ESr
 jZ7qP83krPy2zT8i3FmXa8EKinoIUGJUB3d4FDwVN/8+KPiwGeTVuFp9IyuqzMQRwQAI
 ZMdD9ykbB+BKgmIqkoK9r85i1saxKUpnB/DxdF9lJh3SgIJS77lbmk0O2AL13i6ARdq6
 GvLvGlxpWSgJY46mN2Hbvoh+z+jSmPyc1V6ltm4hwnXt0PLT8Spvkk3gctA1SoHX31RS
 v7nmmVbeIieIyDyYqZ6gTVSJHjxiURKdLCnwYihp8buLXlMHZKvyI8Oto0dPRBHJWs3p
 Z78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757053447; x=1757658247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJROZMV4k+mo1SmHXe9eALQkHsiNFPIxBaJRzyqGEiE=;
 b=gb0pKn1JRbRG7iTF4ZJQiLMHJweq2rRORqY5cZnT+/1LlSoLMV9rxXFmzKK7rYaJSX
 R5BLlNYnJZ9UbEift0y7Oix2tynt6DWDiK1QLIa9aiz6CphwrhpRWnAj5ri+GL7QhIjU
 fMUEblX6iOh4j2TX7TBiWBl/MFgU8psl0louu6UV4iUToDOi/hnn7QEOmfg9CeY7x8XL
 hTG6EiSAK5TYSNU114ZWTjEhBmiyuQ69nbPPJ+jtgjRJHgGdYwTgKJ3r2lPyptr19+dK
 UL5K/yUzp/E41MP0xq/t09AgP/+SpZFN80spiCxaiKNSNBY/LjU3D+ue0SQS2bmxRjJc
 BOmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3IDpYavFdVCpZyXesGt4ugcGR/OuPJfsmwbeWMwOltC4X8c3SgarZ0FQTysKoyd3WS/Q=@lists.linux.it
X-Gm-Message-State: AOJu0YyyTT3JTEEbLjB3VaEowBqIs8YPiOPUnecaYoEMg2cxrf7bH6I/
 mY0ZHd3akFFMYM8vD/Xo2u99rqgencqRvxVWejq9Pmhn9o1MRKu+9WY7USRw7TJI1Wg=
X-Gm-Gg: ASbGncvP40u6SFC0NkxhpTZ/tbBrn1Vq350xHagNVFnUg81k6a38pUUUsBIeDvUpJwY
 7RlgRYcAgjmbcue8ZhnD8bw5NzFEpKIOSFj+culkciu+IIFyDd7esAUtor8fsxmodp7wfG58q6J
 +3OV2XaSgcP2Pe+U3eUm/8I9URYAri+atzcyCJtLZej1i/bBcQjbEP3Cdk4ZNRra9T66bMkivI0
 iHWTmTWZyQbUs7XVXyjTGuAWpzcwOtTlHDdjcmqOviIaxIvKBcTP8l7wyDBVH1I7TH/rEPQqpWw
 UsKO1TujbskknNBTjtbxOXA4hqekZh4A0tCRwrQPgY2ApVdeGpnw49lAFcjr6rcPzGouZIIhtme
 zzZ5ig3iM9AYMATfDEduUJ88VY9iPjBzQqQMQT7KfOA7lBiyAvsYH1OgKPjDPu89sKfjWtZof5p
 bjJuY/8nU+/p4m40Y6
X-Google-Smtp-Source: AGHT+IFPp306O6IPfY7Hc3C1bIY/4RMGv5Zgt9KVvG+N8D7T7RfPTHJhMC0GHV2F2DljyFcx7EE/xw==
X-Received: by 2002:a17:907:2da1:b0:b04:3cd2:2662 with SMTP id
 a640c23a62f3a-b043cd26a93mr1545990066b.14.1757053446849; 
 Thu, 04 Sep 2025 23:24:06 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04190700a4sm1327874166b.63.2025.09.04.23.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 23:24:06 -0700 (PDT)
Message-ID: <dd2ff5d6-cbb5-43bd-8416-dd586c890728@suse.com>
Date: Fri, 5 Sep 2025 08:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <aLVzVyaVhr4IHkyd@yuki.lan>
Content-Language: en-US
In-Reply-To: <aLVzVyaVhr4IHkyd@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 9/1/25 12:20 PM, Cyril Hrubis wrote:
> Hi!
> It's about the time we start to prepare for the September release. As
> usuall I will go over the patches in the patchwork in the next week or
> two. If there is something that you think should be part of the release,
> please point it out so that I can have a look ASAP.
>
This is a patch that would be nice to merge inside the new release, 
since it's breaking reviews: 
https://patchwork.ozlabs.org/project/ltp/patch/20250904090739.50326-1-pvorel@suse.cz/

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
