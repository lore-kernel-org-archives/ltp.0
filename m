Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027CAC87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753778072; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=tvYCuPDOWQpRx+/sxT3ThTYfH3WAakVhUQYlN7bWUP8=;
 b=e/t36GQpHWoQ9kdcKadlOlW4++xOwRLezaSWhPclX8ZHTr7OsyRHeoOsMWJnN+UAlRMw6
 qEdBcLO6FtlMyT+OYaVWpN++Jh6dPX9lAI4aW3Ms7Vs/03r+YJ+PuTiuchjKy3Dq+bnEw5z
 wblpOIvCATkWFeEo+ud4tCoj/SapUsU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868B13C9F61
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 10:34:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E523C9ABA
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:34:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0BDB200219
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:34:10 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so54896705e9.3
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753778050; x=1754382850; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vCC8+qdlQP6j/kNfsaxVDBY0CIxcBKW1TGS7xBHimAQ=;
 b=Sebw715S3CaJHFaRFvuv2XUd/B9E7rSP3C5mPp+NCFd3vzD6f3iWRc1p02Kjp8yUxi
 cyZdWpAMrglsRnTCuc4i75EK95lFeHb70TvqXYiZxMLEn1D5IL+8WqD70KJOXFPbMgLS
 q01nuVAByQ4Glt565BKIrnxsHntfCY70/WTZu8cEn5C0kiQzMVKx118LK+N9ad/Cent+
 iCr2d7BsHkOLzglNMjOteWsaWI2Zi0S3gxEOumPZeUvYNJBU2YUMXGcjo9giUBb+P4ir
 JtIQ7JGKB2Aww2CZE1vriIMEtp89Y+zt9e07E/vGvVi+SnonHLPCQLLn1JDqfpUJg56P
 aD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753778050; x=1754382850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vCC8+qdlQP6j/kNfsaxVDBY0CIxcBKW1TGS7xBHimAQ=;
 b=gEKEz1uvZYO4JllXTYmJknjuE0RcyTl+9R5f/xi6mbfbYktVnVXxndlYjfBvWfJYm2
 3DWlxwU4waVMVe0+Nyx2AbAvXfkXaenWsEFcysP8rV/u0Yg1k6ylHoNROw0E++t9LWi3
 3BABlt59Aiqn+7t/MYqUZndmkClaRLUIRxANz1/O7nrp9aG0LbRoyOaGJYYEIBrwEWai
 Ipzu08NsfvfNHP3REG3BhnyJqC9hKKTcmr1OxxuOgFIAnYSZWpdtwIQyOih5Yv9PcXqv
 KxfMBimz12O4S2My+wZqxfD8U6uulsz5nyp0t1OOTRqeQyTt7DJaoi/yAzAox5pU0s/H
 eXSQ==
X-Gm-Message-State: AOJu0YyAAq0c4MytKv1evov5s5M1pLX2R7zK1m4ZpPRuceSfLucLwf33
 wEum29lTfPhNVxCyx5PF71IicJCqrheO9dTHl4EsfZhhwLVT1YR9HxUP6Iq5Ku/ktbQ=
X-Gm-Gg: ASbGnct+n51PHUukXO9zAjjQzfxVCE6ogyALIbvSWTafGcAs1UqYFsDBtEY4PWW6HSt
 A6npY4NCRdKVvWkNcXl/AC8S0eTJwrSFNjAOQMV4mI8FMeu2HKJRePSKQHUiqG17PqUq5usw7Gl
 7oKMu3+U5WRhkB+ndGLu3uiSvpSHxYFbl8+GhwaaVyuqL1/ujq2TQcfDrfQ95iUFtdvqTxKmwHr
 usqNuhmKu1VsYt0cA/NfhpLrU49VnR9fGS6OzpHx1FpmhNymShlVWIzuctNNZezU36Gro1qlSLE
 rv20uT1WxuQE1v7Cp53X6HgKgnf9F51nQpxUr6I4p+dLT7mxYtgxOEuzEIOe/S5yc9JRLca3kX/
 j41Nnax8AOpSi927012GD6dnvpzpPi3oAFw==
X-Google-Smtp-Source: AGHT+IE49BpDzX3gtwcl36HmiPOSsegt1EF7fckt5Di43UBtB84MQsyeO5jQjYv8yERr68ArKnW5BA==
X-Received: by 2002:a05:6000:2006:b0:3b7:83c0:a9e0 with SMTP id
 ffacd0b85a97d-3b783c0b0b3mr5505124f8f.25.1753778050197; 
 Tue, 29 Jul 2025 01:34:10 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.178.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-766cc11bfd6sm5567668b3a.74.2025.07.29.01.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 01:34:09 -0700 (PDT)
Message-ID: <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
Date: Tue, 29 Jul 2025 10:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad>
Content-Language: en-US
In-Reply-To: <5913636.DvuYhMxLoT@thinkpad>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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


On 7/29/25 10:32 AM, Avinesh Kumar wrote:
> We also have same failure for memfd_secret case in this test:
>
> ioctl_pidfd01.c:37: TINFO: memfd secret -> ...
> ioctl_pidfd01.c:28: TFAIL: ioctl(memfd secret, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
>
> If we are opting for skipping the tests when selinux is enforcing mode,
> this also needs to be skipped.

In this case we will probably need to disable the test for SELinux 
enforcing.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
