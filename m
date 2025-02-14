Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B767C02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739530145; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Z7NozFC2aDILzvN24Pu/R5Q81ayYXtyFIRUfeeu/3lc=;
 b=jrEkxZu2rLhiS44kGIxiRHES2tG3xK9cfM44saHMhiTU+y0yueTqvZkSbL8T7nMIRDAHR
 3RTy/9M0faZpMRJzQYFMdnVtAdujL3VNlx1dOuEdNgorih4SdpMHHp518u7FeqjFBaYlmnZ
 CNXSrMeaCgWlWliXFbsTSvhB/SoHgzk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF1D43C9AF3
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:49:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D307A3C9254
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:48:43 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E08CA63D42B
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:48:41 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2e5so394297f8f.2
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739530121; x=1740134921; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D13qABaRm1Y2G73xjNcEYih0OOto/UYxqn3xfWCF+Ec=;
 b=e54k4idIpq9geCrRhg4uBTICxkNf//sL3ixUCXD3CxxczSpu58RVM71n5SWnOTxCqC
 aDPKGdMfyLhOlTCqXhyt9zUuK4/aOKDTeTzviOZqkMCCEk2covPmSxtZVfI4sLiw5cCE
 jXcQWRy+Ptg3KXhCeITRQ2JwhdLqJsHRW4TmPm/3W6hh9Ts2/Hvq6rJsqT7WLzkp1mfL
 RnG+uTRculA67Dv+ACwAR/FB++ngHi9f459vEqsNccB7DgntcHlNBMcZajWgLK+OWjxV
 DF+Z/M817c2CjQnWYIiXymdpnwRenltjW8HN41uEBETgfJQxa42mbqQRqzkAZlpxIuhj
 h+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739530121; x=1740134921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D13qABaRm1Y2G73xjNcEYih0OOto/UYxqn3xfWCF+Ec=;
 b=AYsAT/jXdUpwk3kqGGMwHxCQLAZHaNDXGgY6FxOwMRXjd6Xtadh+hq6IH7ve3TX/Co
 8hqnGIqZ2bvIjHh/SkK6HZNEtOjtscdIIyOD9/uYYMFZBzovpDd+Xe8VA1sZfCOo29/B
 JuL0CCUIE7ZziXIQpDxHCelgIJjc6tFLuEs+mR54Js3elQTkj0tVFjLM7x4H3X8WN6we
 A7ZvDes5kfrkE45+5T4VPF5Jrl1N8jm4/dIrjYAjCH6mQR7/fXGiYBE93XGBvM3I8HAn
 ZT/jXF7xI0UD6xQ1EnUAyUsPvMg10sp+vWmKsZ98l51Gy6K5Op7V2kZNBGosFhhzt4XO
 0FmA==
X-Gm-Message-State: AOJu0YyPpI+MwDQjNOTl4fivQdXE/Mk70sCgUfL1dMWduT/7MVyXJwaZ
 b33FXwOIVFalhsz71+OJ+tGTtOeFbJX+7wsR6yPv7UtL0RV57vfa8oSfWXfqj9Y=
X-Gm-Gg: ASbGncs++LhrRxUwzLu02VfqT9f/bTShiivEF/sIjjkA+o94x8b3NCK79YZHi162JAI
 1wpjR9Sk5XbNPQQG/TMPna7Vslv5qJN7WVpn4nWQpaqb/genaJ7HnoBCbY6wVQWFn9a3z0VI1R+
 m/SfcSbSEms3JRJeWRQVzH42ejit+xBfmbI+RD7E+ttn08CffeJpESaMUURM1yELj2pc/qRv9sZ
 33OngVfPvngayGaxtqKOd29ecKwT1Hk2tLsB4EAXJZmtxr9lLPoOzMkQnu10IGqwHZdQ6+dHm07
 XtNCae4+Xy/bM49wjVpM3pfA
X-Google-Smtp-Source: AGHT+IHBpdQUJGPr0pb2b1KoMojPP5Xx+drpc98e07bLTZxYewSPJGv4DE1Z7tMhEV6aiWX9kmD9Xg==
X-Received: by 2002:a5d:5885:0:b0:38d:da79:c27 with SMTP id
 ffacd0b85a97d-38f244d5085mr7790595f8f.2.1739530121208; 
 Fri, 14 Feb 2025 02:48:41 -0800 (PST)
Received: from [10.232.133.38] ([88.128.90.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5fb6sm4208955f8f.44.2025.02.14.02.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 02:48:40 -0800 (PST)
Message-ID: <184d8746-0b63-441a-a7c3-f13870dc78ab@suse.com>
Date: Fri, 14 Feb 2025 11:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250213133730.27999-1-andrea.cervesato@suse.de>
 <20250213133730.27999-3-andrea.cervesato@suse.de> <Z68X-GLzmpViuimC@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z68X-GLzmpViuimC@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] options: add new --run-pattern
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

Hi!

On 2/14/25 11:16, Cyril Hrubis wrote:
> Hi!
>> Add the --run-pattern|-S option to filter tests based on a specific
>> string pattern. This option accepts a list of strings, allowing users
>> to specify multiple patterns. A common usage example is as follows:
>>
>>      kirk --run-pattern sendfile madvice
>>
>> Each string is compared against the labels defined in the runtest file,
>> and only tests containing the specified patterns will be executed.
> So this is a substring match, right? I wonder if we should use a regular
> expression instead, so that we can do more complex matches.
>
I thought about that, but I wanted to start with something easier and 
check for feedback. We are already doing it for skip-tests option.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
