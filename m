Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B8CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781176608; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=mq0rWAFNQY9vVp9mb35ZbVAptzh2QAoJSrYtg+s1oN0=;
 b=f8INb9IOLwj3w8EQcI5btuwi533vgk+4x/rs3ejvbg68d6mc9Rk0vmsJcAwNnryt5bfW5
 XuPnY9Xd+ncDaZ07Y13po+vNXnpOCx6bAI28vr1RTCn6MrROMV8oQrkujlfPDGrbTiqO3DX
 KT6T9SurCnV6YAcYYFrZOaw0zZz4Uzw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EB5F3E5E85
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:16:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC60E3CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 13:16:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C462F6003D0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 13:16:25 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b9318997so57683875e9.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781176585; x=1781781385; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXtENguT9/1Bb+pW3abxwEv+mAI5TUGbO/qttQu9z9Y=;
 b=QIYuj9y8K4NgLJqu3Z5ZwzVMFrhzPk62oXWAy60oGwO9Rhl4x/jCH7K8WSv/SVRcyF
 cmnsAbephZFfUKGnakr24Kq7u3UGf+X1wgquDWbv18wQzMDcbryS55k6ry9WhRj8orkB
 b4nIGzBXgvbIts1Jn2lq1VJJ/ClvUj/hUHnN8V4lB/dvPoZDBmBxSkZNvXODPjQvWWzf
 CmnPe8GKj/otGulnl/fiHWT7SRJVFE4/G9M0pgxmWHCjx1XNyU40j7/5lYs3R49jqWKo
 RQn1U1oZ+7J37Du+pzIwjrObwBDDM2+exxvrYSYOBzEFL3YQW1gXxrEGjc+/lbtiduTg
 R6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176585; x=1781781385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXtENguT9/1Bb+pW3abxwEv+mAI5TUGbO/qttQu9z9Y=;
 b=Xrc9fz+Lgi+1zcrQ/RT84376k5iULcH8E5oJExErUVE7rFmB4LG7Cf8AQw8mVAlEet
 5s6PZujIg8Q06dpZVyKHdS9VRo8cS9gvgBfaVFIBdm/twu5WrDD2jZKJUhGU0b9WaBDU
 tbwnKsbuSR6vZ08XD3wMMxF75jWyJJaoZFeCnV9ZUKAohnzRWHGDKv9gFUICiAHIvmO7
 9ArA7uu7wM8hK/pKV6db4zlNkSV8IRTzw5zdcJR9jK9COyrpNhba4jqBl0hhR83kUNVM
 GLh2dJxcFO21LteSoQsKmzi8JugFx2pUQpOIsgbStt+p8YMLD/EX4egRRKpLfh7hajYf
 xrpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8p2OpLUK/ujerxFGiJ26F7SwpHKWDtF4h3hQNT2M+bwZ5I6WVPZrscM3tGb2FYGSKgoWA=@lists.linux.it
X-Gm-Message-State: AOJu0YxchARru257T0LivKityjNeNdAZ902NacD0nq/Hp2TcCXD8WZG4
 rOcqAUd+YuL3ih9R9G53UFDXrcn653jwMwsVVEVwMDiSKX7ynn6UsOKvZJDuuTsb0tL4v5/472W
 kHxWPeYg=
X-Gm-Gg: Acq92OFcxffuKd+f6gLC4I4/hF4c1Sve9+zjmGYAHcePfCF/0lXOZVgaI/UvmaO//Ut
 FNh93DdKUS3dksOoTYJPynPORlNstb6x0lgE8ytSi/nMRabdMN/4PXwsXvm7jv0r9flXlBgy3wC
 AlLNHQQZvObkXhr8qfyu6tBy0B5eN3DItly8eC/LDSN8KRSYODTqn77Hfq2pynXetGiA8jJjaBx
 IjU5G8bI1O0YhBd6+vvddv3zesjcrGI95wrLrioWvRqU27k8N6XK0pyherZIVmoaJ7MJBqrsiDf
 4DlWm527K+MN2g9KKhyO2nVJHsP4zTphbtd0GB1lvE6cnzDHYIesUNbR+h4zBrx1crHbfE+0rY1
 dspgeIYArzyjcg1fdMB1RoFTr1blWhmhzn1I07ceSRFdkQpDQi+U5f9nneFj2CAcVDopx2sDDHc
 PTd2GnLF781Gk3gnjV3rnHLTSRkZ990WDXXhJJ1sEeAWHqo0zWQCo=
X-Received: by 2002:a05:600c:4f95:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490e55b8672mr29621545e9.5.1781176585060; 
 Thu, 11 Jun 2026 04:16:25 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5153feesm43902415e9.0.2026.06.11.04.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:16:24 -0700 (PDT)
Message-ID: <5437cc67-8490-4a5c-9b5f-1ef31c9e72ca@suse.com>
Date: Thu, 11 Jun 2026 13:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
Content-Language: en-US
In-Reply-To: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] xfrm: Skip on EOPNOTSUPP in compat mode
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,


On 6/11/26 11:37 AM, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> A 32-bit binary running on a 64-bit kernel uses the XFRM netlink compat
> layer, which is only available when CONFIG_XFRM_USER_COMPAT is enabled
> (and its module loaded). Without it the kernel returns EOPNOTSUPP for
> any XFRM netlink message, which is a configuration limitation rather
> than a test failure.
> 
> Report TCONF instead of TBROK in that case for xfrm01, xfrm02 and
> xfrm03.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/network/sockets/xfrm01.c | 3 +++
>   testcases/network/sockets/xfrm02.c | 3 +++
>   testcases/network/sockets/xfrm03.c | 3 +++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
> index 5490d6b8a9f7fde79478ae0484e6ea8156d07cf3..22244032a521a42331b0c1411ae33f75622e64ce 100644
> --- a/testcases/network/sockets/xfrm01.c
> +++ b/testcases/network/sockets/xfrm01.c
> @@ -126,6 +126,9 @@ static void setup(void)
>   		if (TST_ERR == EPROTONOSUPPORT)
>   			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
>   
> +		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
nit:
should the message be more explicit for
CONFIG_XFRM_USER_COMPAT=m


Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>
Tested-by: Avinesh Kumar <avinesh.kumar@suse.com>


Thanks,
Avinesh

> +
>   		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
>   	}
>   }
> diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
> index 43edb77d43c8c99e9883fc9922031d559ef31c40..376f6ebe551dd81fbc6a982503eacd68da636f93 100644
> --- a/testcases/network/sockets/xfrm02.c
> +++ b/testcases/network/sockets/xfrm02.c
> @@ -126,6 +126,9 @@ static void setup(void)
>   		if (TST_ERR == EPROTONOSUPPORT)
>   			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
>   
> +		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
> +
>   		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
>   	}
>   
> diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
> index 02ab95c6b7a87f8f206b30a39bb6feb097117998..fa5df9c285d540d5cad0e890a73d43ad9aeba1c2 100644
> --- a/testcases/network/sockets/xfrm03.c
> +++ b/testcases/network/sockets/xfrm03.c
> @@ -202,6 +202,9 @@ static void setup(void)
>   		if (TST_ERR == EPROTONOSUPPORT)
>   			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
>   
> +		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
> +
>   		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
>   	}
>   
> 
> ---
> base-commit: c685f1b774fab694c42dfb7522bc42d999904373
> change-id: 20260611-fix_xfrm_compat_mode-0503f1f9bb8d
> 
> Best regards,


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
