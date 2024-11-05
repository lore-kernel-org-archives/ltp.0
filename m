Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1336D12683
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730804783; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NZRq+uBbXDqOkLr/3Jf+CzC1IdbgwoZImuTBcaiNwjI=;
 b=bInF63dTzV8iU6D2DN+pznmUdnD0g2n6K6k1Rfq5+crB4cTnQJPOb4gJwbGGOEGdUkQ3+
 m0wbNBGakr02Wo2i5vZvwPC7jBExCN0RZYzo07OESRQXX5CgERSlQk6XpLyh4twI3jptR1U
 j19Kl1to3g4Op9HazHlT/OvgbAmdok4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 212663D2050
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:06:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998003D1091
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:06:01 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09E5F629473
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:06:01 +0100 (CET)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539e5c15fd3so5133541e87.3
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 03:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730804760; x=1731409560; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kRNwD6941zNIExMPlUUstjLShGgmSX9XSQrWdIS64ZU=;
 b=cOuHKKljWIogpxG0/snCXGeO4V/UVUsH0PkoRtFkuwuJ6G92zWhxu5JUAAIgiqfulF
 +sqhZlkFE6wH7uUqEhtBL/9kLJJEFkvmxEA1IhdSd7haY7K4+fJwi9af2VMwchE86kjK
 dLwOEX1fbgEVLTTKsBfIWGK1pk2VXjHspqy5/dOsABrI5jaz5ZOn88e1Ok55C82ahRBz
 8L+USEFbqs6TDi8aiRPo+G4u7jbcJ3mbKnfNlpTMF6c/K4UF4bE3ThmgnTy6TxcN6os2
 QVKJcSvjsQ0nhy3kJOAOr0FGpbquEbU2+8IlynXiD1W+BTcXsiz2oV9Nw0pDQpem25EX
 P6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730804760; x=1731409560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRNwD6941zNIExMPlUUstjLShGgmSX9XSQrWdIS64ZU=;
 b=vfp+OQJ4RI4jSKL/P2gN7ciqIPn0i4Gnw6mbdSlntZQcsHjCGOBorTVk0i7XPBYgVH
 1fJXt1dedqppKWA2zIdWEnm7G9WX/v/9rotafKhTh5CAgLh22G1i7vPKHgGSEpdq/7JI
 2Kovf2/S41oNIIKTc1rzgIO8tJgXviStCRdn7QpeBgStLgNyUN6AqO+krjW4uqbCGxjn
 mtdN30Ux/EKAvMoc+ALTTQudiies20vjRfGufpDPGAgqjxLLBUhHx8p478bu4ZY2TuNX
 4rtCIaokVf1m0QsVKShMaUnAx+PQyswgG5PyL3RUQiEd1paiE+Us1OfExBYvO295gLG4
 dO3Q==
X-Gm-Message-State: AOJu0Yz7MRQ4vbMi+mj8mbVeYHoDyi+UAsjiWvdTEISWldMnYjv2JwyL
 THUgsdtM0cvBlNIiWEmyodPA6zd+XeGkpx9Zrlsf1GAjjoDPDDsXkovfGlqXPw==
X-Google-Smtp-Source: AGHT+IEQ7FPM8Yd+HuWlxFwMXH0ujBcKQ+B/s5N7R030so6QUHXhPgeP3dRcwirnoSX+qSGuwKajFg==
X-Received: by 2002:a05:6512:ac5:b0:539:fda6:fa0a with SMTP id
 2adb3069b0e04-53b348c382bmr17476772e87.9.1730804760185; 
 Tue, 05 Nov 2024 03:06:00 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc1asm75965475ad.57.2024.11.05.03.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:05:59 -0800 (PST)
Date: Tue, 5 Nov 2024 06:05:56 -0500
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <Zyn8FA6Ad0Z7WQY0@wegao>
References: <20241031085904.57020-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031085904.57020-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] llistxattr02: Convert docs to docparse
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

On Thu, Oct 31, 2024 at 04:59:04PM +0800, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  .../kernel/syscalls/llistxattr/llistxattr02.c | 34 ++++++++-----------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
> index 6974f013b..c91d05f35 100644
> --- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
> +++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
> @@ -1,25 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) 2016 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*/
> -
> -/*
> -* Test Name: llistxattr02
> -*
> -* Description:
> -* 1) llistxattr(2) fails if the size of the list buffer is too small
> -* to hold the result.
> -* 2) llistxattr(2) fails if path is an empty string.
> -* 3) llistxattr(2) fails when attempted to read from a invalid address.
> -* 4) llistxattr(2) fails if path is longer than allowed.
> -*
> -* Expected Result:
> -* 1) llistxattr(2) should return -1 and set errno to ERANGE.
> -* 2) llistxattr(2) should return -1 and set errno to ENOENT.
> -* 3) llistxattr(2) should return -1 and set errno to EFAULT.
> -* 4) llistxattr(2) should return -1 and set errno to ENAMETOOLONG.
> -*/
> + * Copyright (c) 2016 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify llistxattr(2) returns -1 and set proper errno:
> + *
> + * - ERANGE if the size of the list buffer is too small to hold the result
> + * - ENOENT if path is an empty string
> + * - EFAULT when attempted to read from a invalid address
> + * - ENAMETOOLONG if path is longer than allowed
> + */
>  
Reviewed-by: Wei Gao <wegao@suse.com>
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
