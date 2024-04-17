Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A3C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713339780; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=GnqCnPSaOC0ldF0qEC0+ntqgdxLP/MQGiSNaqE8yeIk=;
 b=NUkWqIm75/AZbum8fDHYrXnfClV5oLrHBdc/snb9bE2essyNZhrPp+JKhi/JBCWu+iZ7Z
 FLclSwd3eHjua4MTfWh+AzCQTcg/XVNbhbyJlLaaLd2F7swYzbiWf9tJz/JIOTsBX/BBFQA
 wk/72kJXz/aV3bcK/v4GhGpYg8A++Ao=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2560F3CFB1E
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 09:43:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C1093CFAF4
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 09:42:38 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1D2C01009BFA
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 09:42:38 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id
 38308e7fff4ca-2db17e876abso4681201fa.1
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713339757; x=1713944557; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDlaRT0+PmKVOX4J3oDJGoJ7OeZAt0x5Qlw5YSpGQgU=;
 b=Zf+fvSqFAlj1N8s/a5MRVxA/Liwbq3JG9xV7iO7+dbruiuI/uFoom0Uk3kXUaACHpA
 AZ1vBHllgNquK6COe6whwfa9hhFJyoy1HVxPMsJZjJPP5hpiv9QpkAvj3Suet1V9HfXB
 GykhOMUzdEoXr8d2RxoMce3fMNuf1SfpSzJ+yQHUYskBwWWDtOHzpuze1mLQ0ExPjdp3
 YUspryz7TTZoJqqkNTq6jv9Zw7k8nL1UsONCtRgXX82gFLVcBZ4KdJNrRaJLc++o2vzT
 XEt+seHc6NtWlJi0bYWQKiIjcHm0AZKMMh6tzBg65rNltb0i41DDo+XM2n1xzAr3OvE3
 L6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713339757; x=1713944557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tDlaRT0+PmKVOX4J3oDJGoJ7OeZAt0x5Qlw5YSpGQgU=;
 b=NFW1tPOeYhVtMbOQCYRj3FJVg5ZEl7va9u772mREEawGMDRQPpbGqWB+1HRLaK+eSo
 8XTsK9OMEjvgflQoYg/rqaV25xNeVissaaUVhRF3z/K+Ra/Q48Vcfx8Y46c8h3IlZj1g
 D/ErckeNBR5zC5Q0ztyRKr9R9IrdaSvT3qvsLrAqV7ZF+r+93TNGQoXZa5FfKfGzAhsB
 x2Vfmm6KccSEjHm2Rxlmz6JU9vHcvTVaktCR0NVyeRuuV3XE8rPFonu22lS7UVZrEeP5
 0hX9KfZbw4zJtHNkSn9d3Ytl9/+CI5n2sAsS/hNK5PGZwLZz9jyQ/hhlIsBaPSV+eUAt
 Fl7w==
X-Gm-Message-State: AOJu0Yzy6xhzWCCivepjESDk/hQXE31l+yvOcY6XF29X+kIvLkmHBPvz
 ZSPQdu5ALpJpjEF7XrNpfsyrXaUawCE393J7tA8QsSXmTgXXg71LQydAE/Bg7u3BgFN0hazlSlR
 0vyaY3JSK
X-Google-Smtp-Source: AGHT+IGP1wpcoqG4B1mlPFi3I8J+4TGE4iDGiM6+iaXVkcT1KZTezEi9e6p80XTr+vVb5F8vd2BAZw==
X-Received: by 2002:a2e:be04:0:b0:2d8:da4c:5909 with SMTP id
 z4-20020a2ebe04000000b002d8da4c5909mr10377632ljq.51.1713339756663; 
 Wed, 17 Apr 2024 00:42:36 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.72])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a05600c3b1a00b00415dfa709dasm1678392wms.15.2024.04.17.00.42.36
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 00:42:36 -0700 (PDT)
Message-ID: <e2966eda-b250-4033-a7ff-0ec8dce9d333@suse.com>
Date: Wed, 17 Apr 2024 09:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <CAE3MqZyt47uc=h1P2tryBJsXeoEEzNnHSX5A02hM=RR0goxJKg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE3MqZyt47uc=h1P2tryBJsXeoEEzNnHSX5A02hM=RR0goxJKg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Identify current test coverage and clarify contribution
 opportunities
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

Hi Luigi,

On 4/17/24 08:32, Luigi Pellecchia wrote:
> Hi all,
> I'm Luigi Pellecchia, a Principal SW Quality Engineer at Red Hat.
> I developed an Open Source Software Quality Management Tool, named "BASIL
> The FuSa Spice" that can help the LTP keep track of the test case coverage
> against man pages and to clarify contribution opportunities to new members.
> I prepared an initial demo I shared on LinkedIn at
> https://www.linkedin.com/posts/luigi-pellecchia_how-basil-can-help-linux-test-project-to-activity-7186248090129956864-d-vC?utm_source=share&utm_medium=member_desktop
Thanks for sharing. I watched the demo and it can be useful in certain 
circumstances, but in others it could be tricky. I will explain myself 
at the end of the email.
> This tool is under the hood of ELISA (Linux Foundation) github at
> https://github.com/elisa-tech/BASIL
>
> Any feedback will be greatly appreciated
>
> Please let me know if you have any questions, or if you'd like to see a
> live demo of the tool.
>
> Regards
>
> --
> Luigi
>
One of the things we noticed is that man pages are not updated too often 
and some kernel features are not covered by the manuals. This would be 
an issue when it comes to calculate tests coverage and some of us think 
that this approach could be hard to follow.

Also, LTP has a lack of men power nowadays (especially when it comes to 
reviews) which means coverage report is good to track LTP status, but we 
would take ages to implement remaining kernel tests. There's an internal 
discussion in LTP about bringing more people inside the project and we 
are trying to move forward to achieve this goal (see new documentation). 
That would help the whole project.

We have a monthly LTP meeting. The next will probably be the 8th of may 
(I need to send the email yet). It's public, so feel free to join if you 
want.

Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
