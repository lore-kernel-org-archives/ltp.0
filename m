Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB961C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786432456; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+tRVArp8349aVMMeBWoafQJ06JeTShcd49+m2mPvWHw=;
 b=e7mQU8x0x2zuJsOBUUy+BNN5Bq+jTE/kmtSG5UAkddy3BlD9wp9nDuFAgSicb9wJD1d2m
 7CcveAFyhHo3rDq0xSb4WlVm0gZW1PZDz8qdyfn9ARTCSY/c4+V1d0XJNnc9yrrzM/BUcJe
 XgSEjQmPEz6n4+09TaUi7NqNHgOQrOI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FAFD3D064E
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:14:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E00193CC1EA
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:13:53 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A1E0910006A3
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:13:52 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so2742429f8f.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786432432; x=1787037232; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+3KJLijtg9/vl0N1FwDC+2dWdg3abqj7bm+nrgqQbd4=;
 b=FALjCNUnkC0k9deGnQ7encbyidq6spy8TaFyldowhh50a3np4eJ9j60gPBkrAfMw4i
 2fUxxYYvLvBfIPmc6eXGHwZZlwWM5JUZvrHvJ/iXcg3sxesswMsGkurLqdH719/T6NPA
 gAWnTEx625GvbkFm86gnbwDp0LO5uZFqHCw5nF78/GM5MkAYtpVfejLJ7MJi+zbQ8mWz
 jl4598ZkfetEe0tRfI77GaS4f3kxXFIzZ1mY6GFlgnFTo2bUSbUgdXMjNLJdmEDxRuEJ
 3B7Ii4KDhaG5QPBTOgZr8uZNmdp7BlFZYEsH+zixLDtVN0Sbw6/IRXkWSfVCDHspIKpT
 Pwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786432432; x=1787037232;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+3KJLijtg9/vl0N1FwDC+2dWdg3abqj7bm+nrgqQbd4=;
 b=nSIt+dlptHI1loyxtHVll/fWBBEu2Kv7ojkyrgBD+akvlp64Zo/wLenYsll9Z/njYv
 j7AIEMsdUbkKnfD0tbaFHAK9k9OmJ+i33HcmBUx+PWN7LKNw8sxLMIpJzvQUtW4q9uam
 Qt33SfuEBxiy/ZNJqxtE5qwWj955ZMt+HGP1ztANHmSgFVU0Nc3ctNljAhxZwZKUaPw6
 ZmYzqQlZVl6jW83z6ZzZoJEOQ2BnYWV7v6e1hRCIAoUl34cUH8HUUCxnsibrEeQlbZch
 SBa4bAuxbLtV3JModczqoph3I9OcHbczCmMHePR3GUMX67Y/dMpU0oCmlxnt5Rzn/Imc
 NaWg==
X-Gm-Message-State: AOJu0YwSWXpnDNmTEu4KSm9pc9itkRemMSSV0ltnjz84395eeMwNME7T
 1wujbug0RAdNOA2yF3ZAeV3RFJI1Tt+qXq46zVIKRhF24eJJZvp+Lx1FjPC7UQiEWswpK5Vpe/A
 lYMXZDJU=
X-Gm-Gg: AR+sD10vB7VutVdxZJV7wHcxcZLXDCit0b1xhW4nXFYXHKB6XBRXf+Gc6bOGh8ECbjw
 RPIbDRnqO824qX7API8gfKnh3euQM+XjyucJSL2OQT+2isheFLJjE0x75d3IFDiqTjShI1EIr7f
 B6ILibntRWdILZH3xVvNLll1LrsrGEL72xKTw6X7XVHPkt0+gq3mJuYRKO7SWxaA3cSVAvlPO5C
 3+TBXinKGKuwdFqqvfpLCx0Z/8MhFaY6p4+hn7klmS6B5DYA6PS7kmtKSlUuSJ0A0pA62VRQ0vZ
 /VAdr44jZBu9ie32tZzaj4+YCD+cFgPSwHz2lXuMvQpjDA5BDA2LUjtlCpSUgAt+ArByTRRuAEe
 GN1pYh3Xvfd8NQhUSECAC+Fz0Mp328+asvCoL8lNMkr3/pZvw7/b03jtWS9Lj0uhAgI/pnq+D1O
 +1jZgRXwlMUF8Nhy5xaJtj/JfJWKvxyoV0hRfyGJxN6FmyPlk/aJX9BCG54BFMeX9MyoxKiA==
X-Received: by 2002:a05:6000:401f:b0:47f:f3f9:ae37 with SMTP id
 ffacd0b85a97d-4814ad7fd23mr2035340f8f.7.1786432431895; 
 Tue, 11 Aug 2026 00:13:51 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a709624sm2294148f8f.22.2026.08.11.00.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 00:13:51 -0700 (PDT)
Message-ID: <6a7acbaf.9099b29d.135d6f.b466@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260810160048.1040517-8-pvorel@suse.cz>
Date: Tue, 11 Aug 2026 07:13:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/7] lib: Add 2 basic tests for .min_kver &&
 .max_kver
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
> + */
> +
> +/*
> + * Basic test to test that .min_kver and .max_kver can be used together.
> + * Test should TCONF or TPASS.
> + */
> +
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TPASS, "Test has sufficient kernel version");
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "4.4",
> +	.max_kver = "7.2",
> +	.test_all = do_test,
> +};

this test is a bit weird, it's system dependent and it will TPASS or
TCONF according to the kernel version. Is there a way to test this
in a different way? I know it's hacky, but maybe we can use
__attribute__((constructor)) and fetch uname() info before running
the maximum kernel version check.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
