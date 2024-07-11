Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB9DC3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720705348; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1Wki4ZdvnX6S6FZ6IHpZHiZ9EjarW6uC3beTsNqqy1g=;
 b=o8um/aslBLl+I6c1c7G24tRIT84WvU/fBhESdQzkXiwzTvo4Oc6IWEnFwp8gZWVMw6HUk
 8m4eb9TnBKN1/vDT+6NiL2xfaRnYb2VdCpNY0fZypT+gTRXbkFYk2cYZMs6yFmjbXypG5L8
 GuvAz/+vAWU4/HtpqQEbsHtm8K9YeaE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F32553D0FA3
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 15:42:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B785E3CDED4
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 15:42:06 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 377A3140E80D
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 15:42:04 +0200 (CEST)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eea8ea8c06so11264541fa.2
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720705323; x=1721310123; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J6ZIhcyC8lLdLppKl8BgJhpd6rhH65EAakw9HUs5SoE=;
 b=TtD2PEYTBsauzjk1lgfwYdn8JgrjXZcT8BVB0I1ytiwcnwnBcWaL5m9+iER6xjugKL
 GbFvI/dcEnfN4Ptv5gPOnxXeZb3G/0ECNqUuk3vsClTk9FHDQgTRtSFNyqWyCcejscOZ
 JMTRRtz5U72dyIG1kea4Kpb68n7/tlMjwsiH5iofdrU5J9Sa9JZuqBxdp9iwI8jfuipY
 jhu4NqlYQif7JxhF0fGSnbO/KmoqLAFhZTGFSX7Hs57UUKKrGjHeKlMoe20oRGHHN1Zr
 7YBhgTzuvSaTUqN4nPnSt7ks3Q/Kl/xlwmnsyBLVk9kHX9Gc5Iw9DacL/9PswjHU/XqI
 d28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720705323; x=1721310123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J6ZIhcyC8lLdLppKl8BgJhpd6rhH65EAakw9HUs5SoE=;
 b=L08iY4Vx9o8n6u4NOqDMoKDZ7Bvp7R6vd7fu6SS1+NpDUYErTQYOxnCXwU2G3X0T12
 bsD7M0gm1fgMe7bUagJlbcyumkkV+Vc79ehICjD5YU9mASm5P38xrlhBaRfTQ1mk86s4
 4en0qNKDlAIrsomnRbqNZBVMkdHQmLdhQmuK50KcbeX2Dd+cw89K8t5YuyJZcIWTaHNM
 6T5baBrr1Utd9nYeKgKszsDIZ6hiWlchA4z4v82l2WjkfGXs7vbbjOqvYYdAr2K5tK1S
 jCFWc69rzYFjTu8ewCW9zgggURIOgeDT4M6FOJJ9Azbo1872w3OAFUmhAOpeUWbxCA+z
 KiMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1yekxy/0YCOSAv3whDz/IdMHXrHpDhD0TbH33AbAjmP2uY+DppjbU7Raq5P2dWwK6POnUPL2gd4Ijamovf0s3P+8=
X-Gm-Message-State: AOJu0Yyxj4DPi6r0J3i3bfEdYMhF86PpkZEiGXxgzc2fN4xOQrnKodAT
 TbgN641yYXenpM8aVXKc3ADNNuZPzh5Ynq3e2XT7T+z+XVEJkEz1X8RY/YVCq18=
X-Google-Smtp-Source: AGHT+IF/jyG3oek/q1oZa8wNEm2bfEXxffONHfH7qXSZ3hsk05FAFqRs4Em1y8/aiWvblQDpyxcNvw==
X-Received: by 2002:a2e:9990:0:b0:2ee:8d9a:8ce with SMTP id
 38308e7fff4ca-2eeb30e3601mr51669591fa.13.1720705323109; 
 Thu, 11 Jul 2024 06:42:03 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ab7faasm50624445ad.136.2024.07.11.06.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 06:42:02 -0700 (PDT)
Message-ID: <0df6d32d-8a65-4743-bf58-346a9a2eb693@suse.com>
Date: Thu, 11 Jul 2024 15:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com> <ZlhacuOD8hYVLYS6@yuki>
 <82ac2455-ab1c-4bdf-b4e3-5ae56dfb9871@suse.com> <ZlmESfb2JbYbSG1_@rei>
Content-Language: en-US
In-Reply-To: <ZlmESfb2JbYbSG1_@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add ioctl_ficlone03 test
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

On 5/31/24 10:03, Cyril Hrubis wrote:
> Hi!
>>> Can we move these invalid_fd tests into a separate test and use tst_fd
>>> to loop over all kinds of invalid input and output file descriptors?
>>>
>> I don't know if it's worth to loop over all possible cases. Each one of
>> them has a specific test case.
> This was actually requested by kernel developers, to feed the syscalls
> with all kind of unexpected file descriptors.
This is what fuzz testing is doing already, isn't it?
>> Also, invalid_fd test cases would look so simple that it makes more
>> sense to keep it here.
> Fair enough, we can keep these two here, but we need a tst_fd test as
> well.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
