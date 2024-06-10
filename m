Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC37C27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718028447; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RhZZ0lH0oy3GzTPuvPMZUuTynuO/LEvCAyHn5n1Foiw=;
 b=HCeTp3reVJveA4+GYC/bAfVd/C+aMA5h0u2Tq7fYnjfghEIEoQut4R7Sl31lrUPV2VZkz
 txE9kVD+xr508XC5ovZ29oc6dpoAfc0SIyGOFPI5NpPPfbjqATEdrY3tHd4TbABOOpol7zZ
 phYg3rNRA7dXrwWkZaqDJywonjTMYtc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92F93D0B52
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 16:07:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 541D43C74EA
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 16:07:06 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E023601B22
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 16:07:05 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57c68c3f8adso2681492a12.1
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718028424; x=1718633224; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUUG2V7cs9H20ePvjR8EWsC/dn9SuVTQrHf91ddwDfU=;
 b=b1ulmeVuOGrCii/SkvExucVmWd4UxSyZTbGRwoVYfYZyoYPV+Y0dlnZB17LrfMs5Ar
 DMWxu3H8CCph4i9whApdbPRG+NJdxpUTm0LROPjGbfpG37Jb2d2AQVF87CTS+CE/Ljmr
 tDJynA3zakrJLpdiVs4qRIngU2+0pmp2g/I9Bkcq1Bse8HypuvdoOi5UmFKQE7LrNsq7
 LuiGl2ZboJYkEA5/BKjeI7gvdNbiLS5KWzyqXi9OALQJ6YcMvU7kWFgQZLGduPntp7L/
 XlqpS/KZXr7ca6ZF1gtDmdajXUO5vri6QS1HrLk1ZsWv0hxqVy9bMereeecZ1MfVM2NC
 YwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718028424; x=1718633224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUUG2V7cs9H20ePvjR8EWsC/dn9SuVTQrHf91ddwDfU=;
 b=mv6Xz8X39pXuBA9pwvL493QWbQa2m7/nFvPoUu1Vwx3Rzx21yVdK7GrSqkvLRWkl9X
 XAJFCpRW6BGnhK47MSVe3g9AGXQPHKK0OApXYRzoKOGIy5e5xzA1/12XU7gaIUIVTOi9
 DdPdi8louXt/xmIUlS5J6ZafBC+mMAiKwE8awJ/v1dadKZTqdTN16eEaPCoyG0IufY4j
 IuBQhLRt8MJBG9wzdBnWJ2viV9q5J1tvrxX4s0aPoJ8FcG48zW7zku8qabHNWifogL98
 w1SdQt4FCe8bkLkN5vu4aRFezmtFLOPpoZSkLGSGG4QyvNiC4nxQZiKDXYiJAdxULxXG
 9d0A==
X-Gm-Message-State: AOJu0YxqZ8FdNPwmj9JhbUf/XxWMCaX5ZKG3FKzHzydKxBJEShDA2roi
 1ADYzzIEv7cad6OXZS15ZdjsSqvNS0KTSGJaX3tA7/BVZjZ6UFG6W3ZPlrxycWk=
X-Google-Smtp-Source: AGHT+IFLz7XNtHuljfdqTzPgn882pW2Ceuwbzq3luU9F9JTzYhABIuEKHEW4UjRzd57cbF39h036Pg==
X-Received: by 2002:a50:a457:0:b0:57c:68c3:d4b3 with SMTP id
 4fb4d7f45d1cf-57c68c3d5d3mr5211750a12.28.1718028424659; 
 Mon, 10 Jun 2024 07:07:04 -0700 (PDT)
Received: from [10.232.133.65] ([88.128.88.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c55d8aca8sm5802796a12.97.2024.06.10.07.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 07:07:04 -0700 (PDT)
Message-ID: <84c8b7fb-cdb1-4238-bfe7-e2be5592a17d@suse.com>
Date: Mon, 10 Jun 2024 16:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
 <20240607-shutdown-v2-2-a09ce3290ee1@suse.com>
 <20240610134434.GA746646@pevik>
Content-Language: en-US
In-Reply-To: <20240610134434.GA746646@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add shutdown02 test
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

Hi Petr,

On 6/10/24 15:44, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +static int file_desc = -1;
>> +static int valid_sock = -1;
>> +static int invalid_sock = -1;
> FYI many LTP tests (or even lib/tst_cgroup.c) just expect that 0 is for stdin,
> thus they happily expect 0 is invalid). e.g.
>
> static int file_desc;
>
> Then in cleanup:
> if (valid_sock > 0)
> 	SAFE_CLOSE(valid_sock);
>
> Sure, your way is correct, but I'd be also OK with 0.
>
> (SAFE_SOCKET() and SAFE_CLOSE() also checks it should be >= 0 for valid file
> descriptor or just -1 for error).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

I will fix it now

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
