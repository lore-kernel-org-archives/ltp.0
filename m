Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5971ED12680
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730804709; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zclXBV0Jv8J9u1C3AmVDwyHDXG5OtakhvCaaNndVNEM=;
 b=kryJRVylq5sF9L/5K0FFYn7Ps2MTck+vvx+JEKfpMa/waw+ntMWf0d8KH0gwpnvmIBA3V
 tqgmwsNwuDbllnHrka5mEY9tdypvQ8ogbxl5P8NQQvjaKxoMCcRlcjyUqFVLhYn4AAfBgSP
 yMEvy2HiKMCY7mWS77z4aBWSbvM5PHs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 596CB3D206B
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:05:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F62A3D1091
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:04:48 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8FC6601EB9
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:04:46 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso934440566b.2
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730804686; x=1731409486; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8eAGZGAbId7aPNDp7gP4lcktKTDyj3+Uhn37r3QG1E=;
 b=a3LN2C2sOxPmsSkvXck6Wj3eUJt0wP7nKIwon/l59cv8LtKyOZ7JYaA9mfqF/LdpeT
 MrgdFNj5igzBXFFHEKKfuFWpqJYW29xVyEkzFtB5ZldBu0+h9/0R2H2QMoPv83WV2tSz
 s+je6cWmhP3/GTkUK50MBNGOxxsjZTfLEkJL7cI3TKrXyhfpbyfCk1qrVu+0YY3Sp8uz
 AkhyCwoUv1kwUQwRtmbKAtrDpOW84hOyULHPhqCH1u2i0297BMUeOZ1CvL8BJhoRycNs
 Db4TyjC362nEoGD3qoyPEX10RozR0AZ1wXIDBGLAPE47n0gFVRUSBcvTTuX7E0tOYBkW
 wTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730804686; x=1731409486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8eAGZGAbId7aPNDp7gP4lcktKTDyj3+Uhn37r3QG1E=;
 b=WV5xIShHSbzJvu2eL7BDh33bNl0ADW8x6qZUb9ZczGH3VGyt3SpKWsNQhfO9YxNHeB
 4T5kSJXzzHDQZjrzCK2k/Dh8RTupgByhbL7ddjWksSRD0jFZG41g0DowGgQttm8qZi69
 0/vZuOkuaMy6IPqtQNMkV9XUkXoJ8mKih2zx0Sk9MWaf3KxOb+3n3OztrVZCA3gtCpvG
 Jr/IlmCsy1biLos9MyzBml050dcsO+ifAOoHQ1iTc9BeQ7hQdg5s2m1ZoUQnUEixqUT5
 4mnkccR6yuGREuNP+q/DffkFwrrD2wKOiK5cr+9uE/asAlpsc5MGxEoEOokY9bD9tVh3
 cwPw==
X-Gm-Message-State: AOJu0Yz+YKYIndDvMBT53kM30lkjKfbswAMUOebCHJ0FYxS6lNQt5Afo
 oqyzfEjRWMjwlE/KKuFzZNK82+77YeATiwp8ISmaFV+Resea/6h9tFooFJFcWfI5tSCC0Mgah/c
 =
X-Google-Smtp-Source: AGHT+IGYfK1Z9XG9FCgr7hlY10dq+qeAWM5RdebezBGTRtKflwXtFirKmRJAJ50oLfPF1OfNM+fR+g==
X-Received: by 2002:a17:907:7d8b:b0:a9a:5b4:b19e with SMTP id
 a640c23a62f3a-a9de5ee15damr3784714366b.32.1730804686004; 
 Tue, 05 Nov 2024 03:04:46 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17f49a9sm116574866b.133.2024.11.05.03.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:04:45 -0800 (PST)
Date: Tue, 5 Nov 2024 06:04:40 -0500
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <Zyn7yLeMy5D3Lrj7@wegao>
References: <20241031085809.56982-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031085809.56982-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] llistxattr01: Convert docs to docparse
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

On Thu, Oct 31, 2024 at 04:58:09PM +0800, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  .../kernel/syscalls/llistxattr/llistxattr01.c | 23 ++++++++-----------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
> index f59413265..5002fe96f 100644
> --- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
> +++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
> @@ -1,18 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) 2016 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*/
> -
> -/*
> -* Test Name: llistxattr01
> -*
> -* Description:
> -* The testcase checks the basic functionality of the llistxattr(2).
> -* llistxattr(2) retrieves the list of extended attribute names
> -* associated with the link itself in the filesystem.
> -*
> -*/
> + * Copyright (c) 2016 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic test for llistxattr(2), retrieves the list of extended attribute names
> + * associated with the link itself in the filesystem.
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
