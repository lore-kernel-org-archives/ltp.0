Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D40C87FC9
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753878710; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=JrlKaBVH3Ii7jWGTr9og42nphgxE1WHYiopnAw7QEbQ=;
 b=dI6YRH72DxGFjD3E57XbOQoLtB1IKlB34uJJtHQLyz7fkka2RbmOfnqI547Z8GYDp5BDO
 +mEEzDP5RHnRNrMa57i5RjogttvQy0EhpekdsRQwDiAjfmJ/5reByrKM3hThgmx3kFuAJNH
 q4iIrK78wsmBchB6q4VyfqNbh5H3P74=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 804F13CB046
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:31:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 008723C0565
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:31:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4D7DD1A0043C
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:31:29 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so71939065e9.1
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753878689; x=1754483489; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EaNdZ6Mw875DI1nc+Mu8P469ViQMRdVLB4rWe6B1s3k=;
 b=TTgAoPlTZ4mDzptjgo0+v/lWlon3v6ON/akEzlBYWgIvLBCAIrDg2koxby/dGLEVDw
 0cYDebXsVmXCJZ4A9chO8DBaI9NLGKUS5xo6KAUG1DkrnwA9TBTsbQvjg0VYgKsTOMOC
 WkqqmiD70KR1Tyxc1FUQ5/yEDwUibv99+5trJuJ6YfNCD/cWRb0E3fT780CHC86irDlJ
 UlpecFJ2bLBwH97dN2fUlfrI6FZMDtNnmJ+mGMR1qo4xqPWDEh47UOH4klY6CZGjRmtz
 R8z0MoWKhi590N5YdVPtuNI76+dOrLk88ZtGLNJAjBOdJ6qIWKjlmj2uatV4tGBv7KG2
 J3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753878689; x=1754483489;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EaNdZ6Mw875DI1nc+Mu8P469ViQMRdVLB4rWe6B1s3k=;
 b=Knwsvynd3WufN1cC5Sw1OEmQb7CLvEMDlhZrMO5hSJfqjCyCb6PJnhJOBeunBLocKo
 eEGAORnZx1x4qrwTck+lJRxtuit/5Mrpt9rLjEFuhEeKHU/g+CT7axx/kI2OtzVsxiaO
 PqicOl4wCFHepzByIFsOmoVajOaGlIoBWc7CLEAzPXQBFirF+j38vh8MJi2o20Uq5QKA
 EF6miFu7UnlhmHftYOWaSCaBpiayswHDuksQ2iTuOykjUX+W2GftK1T3rVf2vLVGylHM
 vSo05w4N8mOciF2xIMazwUQVI2Z30iitk5tpivx7zXbLCZFL+iksqFn3ZV3qteT+Dec7
 4UMw==
X-Gm-Message-State: AOJu0YwEHyWIcR86dF819Jp9QjJYU1V5gqOaVgkyU7nS5PQGLrhOpVtG
 HGKNzp7h5TFX90RqlsWMaohxfiOxlRz06Ebb6HO97ylFk87tR+pin7LrO+Bj4j3XQyk=
X-Gm-Gg: ASbGnctRn3g7Q92W9hUNIGwvfHfjtmjfbw+ZdkVdW5Wf6jxTF5PvFUcrEStNRnzBtpx
 a56tWzwzla3qe3wG3g2fxvKe1/6XAzxtG0x9xELTMAfWz6UDgXAnHp0rLFSGN5bW7W6K1pegMdP
 f46GRT5Y23xynNSaMiOXU0B9+Ic9uKcTrVVND4RTNLmJjYzlXuzAoSQqRIOQnKEPjv2sJ/NSKX+
 XwYltIIxU7t0x4sQMec1CmMn3pDXwOCosyj4EB8wQYgDQkD1HKxolOJC2CIZ5SjQd5tlbTfn5qM
 kBmugepy4xZ5be81zIfMXgDZkkXA0S1Y9N+AKnvddOwk0zven+DQFZ//AgE3ki1isxg6xWmha/D
 BQsqwK2tRWe+Own8ve7G4zuv18V8kKTtEHw==
X-Google-Smtp-Source: AGHT+IGH753oma/w9n0PTDsZ/yhJ1kjY4c7ewlfq27DQ1iz2jUB6YnBngyN2XPvgA//yPovpc7xd2w==
X-Received: by 2002:a05:6000:4027:b0:3b7:8c83:db18 with SMTP id
 ffacd0b85a97d-3b794fc2107mr2233923f8f.6.1753878688697; 
 Wed, 30 Jul 2025 05:31:28 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6b0361sm9297455a12.48.2025.07.30.05.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 05:31:28 -0700 (PDT)
Message-ID: <c3fff452-c6fe-43db-a32b-1269f79696a4@suse.com>
Date: Wed, 30 Jul 2025 14:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250729-ioctl_pidfd_supported-v2-1-f9ef90134138@suse.com>
 <aInnRVfk3uR0cUIU@rei.lan> <013b634e-8d39-48c2-9e5b-e54f6f65da7e@suse.com>
Content-Language: en-US
In-Reply-To: <013b634e-8d39-48c2-9e5b-e54f6f65da7e@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Correctly check if PIDFD_INFO_EXIT is available
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


On 7/30/25 2:04 PM, Andrea Cervesato wrote:
> On 7/30/25 11:35 AM, Cyril Hrubis wrote:
>> Hi!
>> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>>
> It seems we need to add also a couple of errno checks more. 
> ioctl(PIDFD_INFO_EXIT ...) starts to fail with EINVAL from a certain 
> version of the kernel, after introducing `pidfd_ioctl` function in 
> fs/pidfs.c, while before only ENOTTY was raised.
>
> After the introduction of "cdda1f26e74b - pidfd: add ioctl to retrieve 
> pid info" in v6.13, the logic inside the kernel changed and we get 
> ESRCH error due to the introduction of `struct pidfd_info`, but the 
> lack of PIDFD_INFO_EXIT support: at that specific commit, only 
> PIDFD_INFO_PID is supported.
>
> This is due to the implementation of `pidfd_ioctl()`, that is not 
> validating commands before asking for a pid task.
>
> I guess there's either a enhancement to do in the kernel 
> implementation, or a lack of checks from our side. Since we are 
> talking about 3 versions of the kernel ago, we should probably verify 
> that kernel doesn't support PIDFD_INFO_EXIT by looking at the 
> following ioctl() errno:
>
> - ENOTTY
> - EINVAL
> - ESRCH
>
> - Andrea
>
The `pidfd_ioctl()` commands check has been introduced in v6.13 with 
"8ce352818820 pidfs: check for valid ioctl commands", so the patch v4 
that I sent needs to check for ENOIOCTLCMD as well..

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
