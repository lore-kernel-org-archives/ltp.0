Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D1FC83F17
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 06:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753684892; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=u5eArxh8H4mJkNR+ReDtLxXJzGE4/QLCuzOB9MjdkNM=;
 b=pjuIJdFWRHQkfTmaGZxeRyYUZQ6+JUbkJI7gMZ7YyO4+xnxnP8+s9MwAEM7a9d47qhzV6
 Bxg8TR+GivVynq1ZH6g8BjaQ8yhno3CebEknRsZAy/K5h8drSihaMzEPyDoNJOQfivf1pKG
 UvzDHrGpuK1Piq/7/t1uqrg9SH6xlt4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAFEF3C79B6
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 08:41:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC3643C088D
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 08:41:10 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58B2460080C
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 08:41:08 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso3284575f8f.1
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 23:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753684868; x=1754289668; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fzJVP6N1yUEYp3kr9Es7aiqcasdaZenH7J2GnHSU9pM=;
 b=Ip+hAyVIInaV9gztGjgJ0UPIuovwqaUPcqdjOtN0ha+LdRZh7Rz8rghW5bsPSJANeE
 o5xvISlnzvI6ykO5FymhQz5pQcgvuGly9Nj5lw5ZD4LkzM276kmmOZu+piX0IwP8zBiB
 4V0wekvwvi2j7ins5nke3UizF2+CkwIlR0zdBccM9SYZMicmeHZ+2kKkWpFynJSJFruX
 9ACxD+3MXcWvMHCysJ49B1beedJGv4AS3so9nK1K5dsmYXH0/pnP1jBAawDeOd433R8Z
 5vybZ5zZe7CiyY/wH42oC59pIDlF3U/shqbEHppovCcPrEFGJxUG+212B1ynKkxW/CcH
 GBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753684868; x=1754289668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fzJVP6N1yUEYp3kr9Es7aiqcasdaZenH7J2GnHSU9pM=;
 b=gXHt9G1mRGop3CDcyjDtqY8+UsvzqcIgCTCJp7uMhPGXDHci8mpDJJ0jO047V4pHa6
 Z9g0N+0JY7gyk6DiH2ay7VoKipjZRGdGIxUkcG5tIOANlPCs0OmVahFWvQLY1IThb70R
 lvrpxKWXh0KddjdoSWlfATBhQFuIkAKCKD40zwrDIYevC4fwhm8PkT6+RMB729Z8awT5
 SJAX/PxTh5hCqcdJvBA5s8oubmRHZo5F9MogSaPIYz67RbPV+MP9GFNGPwj2nUa4l059
 WHEOZHQwiNXmCUB7n2QialcSPND+/lb3Rvd+azwwobUzwbKiJfCHQNksXpdCI9bes9aL
 QIMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrf7vLBBNniNge1IBOdTaT840zKmXE/VRP84OVgETBugRbpvfUq4fV/VGUBszJcaGG6zU=@lists.linux.it
X-Gm-Message-State: AOJu0YwNfNR2BdvHsfJa01SMUm95g5QH9NMlUR4oDsKaQ3XzHy/u6O6b
 CHYxyMshwU7b5XlLCZpcf+/JEFj6tCDGtCdE8XahhAGE7FicMPp2otQ4ZRZ7tgpI5gE=
X-Gm-Gg: ASbGncuzPDQkWmNHOve/TwXuVfdUgeA/GHRzShyd8wSniuLg0u8Oc0tFUgKRX0VxdMY
 3em19EtHDiW+K6tTYAVGEUcAb5Pdc2mYCDsY7kGaYzi/TQN8zQmBMdPBFI5WYCRWLs0EU0eylaZ
 JFOE19Or+ZqcX8ieL8xU2YatGvcJuHfxNdB38+2rtjhWL0OwKWZVVIlAxlfsV4lqQSnSczj8SC9
 D0vjkY7WMvdCUzlA3/WCDvdDnVB51RofB1tYpaarqlDcnjI0Kuo7WT91zRCQzU4AYtIhlLd5Thn
 l3riMJ5Y9FstmcaHIlT5Y9PwSDSQKCpiFLmtZks9jwbUa0LqyBX+AR00o1m1lRb9w6DvoRRO49g
 E1906dpPpIBjR7iZPp6rn29FsXALKn3XaTg==
X-Google-Smtp-Source: AGHT+IHxeqywaRtqSsBlw3RamGYl/89C+BBGiuUOR6Y7YW1+D+7rHP3Nswhhf0yY7kT9jDRVyg4CXg==
X-Received: by 2002:a05:6000:144b:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3b776780c7amr7070841f8f.49.1753684867249; 
 Sun, 27 Jul 2025 23:41:07 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.193.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fe648707asm34962275ad.135.2025.07.27.23.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jul 2025 23:41:06 -0700 (PDT)
Message-ID: <b105dbc3-3243-4016-8c10-714fd298fa43@suse.com>
Date: Mon, 28 Jul 2025 08:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiao Yang <iceyangxiao@gmail.com>, ltp@lists.linux.it
References: <20250727050450.104599-1-iceyangxiao@gmail.com>
Content-Language: en-US
In-Reply-To: <20250727050450.104599-1-iceyangxiao@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Update the usage of kirk options
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

Merged thanks!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 7/27/25 7:04 AM, Xiao Yang wrote:
> The kirk options have been changed since kirk version 2.0.
>
> Signed-off-by: Xiao Yang <iceyangxiao@gmail.com>
> ---
>   doc/users/quick_start.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
> index 8a25b9129..e73175e33 100644
> --- a/doc/users/quick_start.rst
> +++ b/doc/users/quick_start.rst
> @@ -87,7 +87,7 @@ To run all the test suites
>      $ cd /opt/ltp
>   
>      $ # run syscalls testing suite
> -   $ ./kirk -f ltp -r syscalls
> +   $ ./kirk -U ltp -f syscalls
>   
>   .. note::
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
