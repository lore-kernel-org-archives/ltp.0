Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18DBD12689
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730805566; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=e3gEy1NiLkCWtNfMmLfS6Rkyv42f2aHgryG2UHjzEP4=;
 b=OaQzcDd6E5rB7TMLDgtQN6wbAPywIYIDmNz0+ApIkonDYg85+YeAQOHBIVwq0MjPFKAXh
 ilO52B6GwHnx1tL1D9f3gKYcXQ023z/a3JRZhG/vFdZdQmujQITtEJ38we8bFyt5ZLmBzhe
 ORsQB8Q1DR1F+DST9aOmQeYQkS38IuI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F2D23D2093
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:19:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F0653D1AD2
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:19:05 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BD744245576
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:19:03 +0100 (CET)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso505526666b.1
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 03:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730805543; x=1731410343; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sG6WRM0/57h3B3wLhto7jLHnHdpKIbVbYLJZtKyNYEg=;
 b=BSjQOUSTWrms0uHPwrNkKN8G3CYvV7Xhb7ehTVjYRVEgIrEhTjFvN56y3lSo9DufJI
 8sY/yVttlF7WFhZaMpWkwmIE9Oa3MxvdFu+rFtSkYV9mR8thHfcRURVJ359gl2PIzATX
 s71LrpBgb8XhBwzFITOOj74acXynWk1hpRmBIX29Nyq6LbbKHPYNmrGI2T4Xk1No29ye
 LjeTgGb0NvnyvEp3czp72E62uhZ8Y4J3qyWsrMNMQl+yWhNBnUeP+vibY699Iw8IKhu+
 qYsLlV6B46/+eGiGDCUJRj/K6/TTHzcDx1uvtzrKbaRYnK0XNcrMDfczHcE4fljnFII/
 3JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805543; x=1731410343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sG6WRM0/57h3B3wLhto7jLHnHdpKIbVbYLJZtKyNYEg=;
 b=kBQ6q9UbMtzk45CFxvOLQgX/RVCqIfKUWav/36SKn5HT244raNTqZIpjCms1afrl48
 mQLBf87EqHHYz39T7cpEf/W18trcNDEf+UbULBQa3/TrsOIjZDqKwksKFdIt0+hd6Tfu
 DEhiQsFeC89JP/acfczTrHoae2n40Is/Pm9s+1+AVAvwTHICEIskqF0V/kn+WZdqPsly
 YLHDn8dVYDNyuLPwrvOif/5Guw9Tl3PqLXkYKnxw+f8eMqgJvNqSOh+KBC4ZQsRPpHc4
 YhygUl+JlYKSU+1qejPZ00zvgQQiUe1pOtJkW0xVx6CBzvvoBtFtz7D0sCNOZReF+NeU
 PNYQ==
X-Gm-Message-State: AOJu0Yw4bfOWkt6q0hT3JykP46Xae+aPBHAVYar0XDne6/fJVwUtIebG
 KE7lTEQ03IJpBKyGgJOsvQy4YRmRzGSoxQTYFqsipsCGcY38KD/y/aer+HfguA==
X-Google-Smtp-Source: AGHT+IFqU2Uiq2zlHcT+jPbysTJRX3MtaCRM/LEMr0CI3dqotVUwzLZ2+C2jDSinNxU7SrLempxNzA==
X-Received: by 2002:a17:906:c145:b0:a99:7bc0:bca9 with SMTP id
 a640c23a62f3a-a9e6553af4fmr1584318966b.3.1730805542978; 
 Tue, 05 Nov 2024 03:19:02 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17d7328sm120660966b.129.2024.11.05.03.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:02 -0800 (PST)
Date: Tue, 5 Nov 2024 06:18:57 -0500
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <Zyn/IUYuWpAoswZP@wegao>
References: <20241031085934.57039-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031085934.57039-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] llistxattr03: Convert docs to docparse
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 31, 2024 at 04:59:34PM +0800, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  .../kernel/syscalls/llistxattr/llistxattr03.c | 23 +++++++++----------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
> index 940851f40..3280e91aa 100644
> --- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
> +++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
> @@ -1,17 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) 2016 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*/
> -
> -/*
> -* Test Name: llistxattr03
> -*
> -* Description:
> -* llistxattr is identical to listxattr. an empty buffer of size zero
> -* can return the current size of the list of extended attribute names,
> -* which can be used to estimate a suitable buffer.
> -*/
> + * Copyright (c) 2016 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * llistxattr is identical to listxattr. An empty buffer of size zero
> + * can return the current size of the list of extended attribute names,
> + * which can be used to estimate a suitable buffer.
> + */
Reviewed-by: Wei Gao <wegao@suse.com>
>  
>  #include "config.h"
>  #include <errno.h>
> -- 
> 2.42.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
