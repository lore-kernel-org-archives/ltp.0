Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC05C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739190497; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=WtJLyDUJHEos30AzWsdRD+wTtnybr55iioQMzxdzAk4=;
 b=rY/DbzCH5kEtrF75n+O/diS/cg+x64COL3J2DGFaAlPwPTLoB7mH3BGhTWXVNr9Xm26+u
 iExEAWHHbBfEzMauayd91RpPhlXsxyLg2yfHAUeMDRuHK62Lr3B8VAAx11p8tdatpywy9pe
 upteHQGGkqdIOChbFK9ASjM9Pe7a4O4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0236F3C98BD
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 13:28:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33B793C2C01
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 13:27:56 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D10C21BC0066
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 13:27:55 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5de6069ceb5so3093137a12.1
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 04:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739190475; x=1739795275; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wRqpeL/ePW24Cg2EGklVdXBemDO68KtyN+2laLGJhn8=;
 b=hCAy4JthkgcCNz76HX9wHRbUnm90Klg6UlP8msB8lXkSK3htwZyhEJgk+u46ca3Kzy
 ag7X/ib8g0NlW23qO4DY4lPyC0EGIoGjbedhpLY6P3ir8B8xIm9M7x5ubuV6cKvuaSZT
 wq1xQWdFUqKGlI/Eh+FwpPVmSRJXtiKHbvCh6jjjJG0gd8TV8+ICnPxSTLXURbB8eaFa
 Y84DgO6GphIR1Bch2xHcZChrq1d2vhRZpPMhxWqnu6mjL/2IOFq8dWgUXhj/ppy7fdrz
 fd3xJQi1UD32aP4n1IcmjoGF8t8+y/T0cR8Zg3nv0VOqrlF6Hru7j7VKBQH29wghyRWh
 hQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739190475; x=1739795275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wRqpeL/ePW24Cg2EGklVdXBemDO68KtyN+2laLGJhn8=;
 b=FWivf8ozu56hOPPN/wG0PrR6M/1b7uEvlCl8ohKo7Puc6NTStJuFFFZ7Os3eY5AxRQ
 eqmN6nxWdmyGfpfSgyAQyr7iVxP/4zMb/ctFhPNHQkVT6afR3tLzWaTcrjqGYE26dTNM
 3HKqjVgM/6PFIFhzk3mIXIS+kngFc6MXxReysOHE8cVGU9BK1m+Sp+mAlfCzZxw+mfjw
 n2OR5Vl8pKg6zbgF7qrWwRL6QxMyZxTwQU9wJ1PO/cFZSAHNKLz+gwZ9xlv6A2unOZOk
 WbgBdFrXu/kCBWn1+aV2JE5/Z6VrQ6Ml/zoOMO3JWVG0GldQO2uXtQAS+htK90qlEi3y
 82NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk9boKUluSYIu9fc+g7SphKAgc51T7oHF4M9qO7cqMnu35M1kZAACMuXIhT8nogfKoZZE=@lists.linux.it
X-Gm-Message-State: AOJu0YyWlftRF++xHMjKjfsWa568pC71hFXn1vHSmtT+nSjBWu/pNVF3
 bIx9P8bTvKBCZeMEn1+2jda9WK6D4xnZNkHjECxfWTC3Lg6rSwPavIBHdMfj0z4=
X-Gm-Gg: ASbGncv/bbR+xpxIkgLz9UJHPoKju9olBsC3qr01Y8uThVa57Y23PMgK8L4UbzEJkv+
 0pscCEM6QheAqWSXOGu/jnqRjhKV247F9GOjdoLsSCyE5A409Eod21ArPqzyAs7mV8tYFsTXJxS
 kEJysYjNOP0SuUYICSIzdelxmhnETzAJV/GUggimSKiC2fBJdD5TrJgPC9/WP+UP/jChv/uCoN1
 65wn8EGYBB8aq1xyMWqKFlpF/qnl4WBdYsS+S7D9+4CXMuX+lvkp0TLzJ/+NtkPwkb4BRYFXGDB
 dSrXpnWme5pWxw06M3CWDbncGr7ffhhIIj2N3c5ITGQLkW/rpqrraNQu+bzYo09rxvgwj1hq8yI
 CGe97l99A5csSzRVOlwhHxbQ4HL81np/EzLRxex7LzW/uc/AY9aY=
X-Google-Smtp-Source: AGHT+IEFHjeTYj/WSP2Qu0m7NtbW5GQoyG9G93aQd1ApANSeSXvL2ITxzR2mtUIv8WMfvuFIsKQznQ==
X-Received: by 2002:a17:906:ef0b:b0:ab7:5983:13b5 with SMTP id
 a640c23a62f3a-ab789c60c2dmr1451232966b.20.1739190475283; 
 Mon, 10 Feb 2025 04:27:55 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7c5dd464asm165483366b.185.2025.02.10.04.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 04:27:55 -0800 (PST)
Message-ID: <d753fe07-7eb5-4452-9d1b-cbe600012978@suse.com>
Date: Mon, 10 Feb 2025 13:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Xinjian <maxj.fnst@fujitsu.com>, ltp@lists.linux.it
References: <20250210091044.359274-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250210091044.359274-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] semctl08: Convert docs to docparse
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

Hi Ma,

please, take a look at the open discussion in the LTP ML "[LTP][Open 
discussion] docparse handling". Feel free to comment :-)

Best regards,
Andrea Cervesato

On 2/10/25 10:10, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/ipc/semctl/semctl08.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> index 1878bd49d..0c6ad1d8f 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> @@ -1,8 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
>    *
> - * Description:
>    * Cross verify the _high fields being set to 0 by the kernel.
>    */
>   #include "lapi/sembuf.h"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
