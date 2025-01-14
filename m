Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327E5E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736843224; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=a8l98EG0N//kavz26MbwTMa0ChPikNSDg+czlqMAghk=;
 b=MFzXGif6h94sYv2XazDG5zo51IE6dq25LCyfp1sOM8pmIfKTu8wBHleZNGY4ZURqa9iV7
 JUrWVoz+zVeetqaADCpy972MOpQ+uQve/jMnEZR9MNIjfvnckEKvSGkVw0jXEzenkmNllVU
 lOu8bUZ2vz8bm35X9hluzBBTtGSonCo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF3943C7A0F
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 09:27:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92BEF3C021D
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 09:26:42 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BCF2F1016C5E
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 09:26:41 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso35724495e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 00:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736843201; x=1737448001; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+YO79mMTKspiVhIbYz9bbI298LGv77ovtCCO4yOLdU=;
 b=K+Y8Ra4lgCarXqvP8AXgkg4jjFbYrk8CVUSvETn07kZmR8+pAKbhQMhXN1/XOxLFO/
 N+u74KURe7XqpcXZBOElOp9pJZU5kX/ZJUBTKc84DYC+LeUfliQI+LiQ3FxeyDSvnqkV
 OhqXBF16B6WxAE42u7jQz9S/rRTIRoY/zYWZ7muW6VAjXP96R4jE9KPyodwtltKAWHH2
 tCTiMpidxSwVeMi+ie2PrqT6i9u7BGXmQOAl0NX3bbfEm4/sgTb235x6fEgbyRiT3ZyU
 5yi31eojiTlZy1IYdi9X0SFZLHIv6oCV/PNNR7ih/XLWELeLgjy0dN8AhvBo1WTlunYI
 Jnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736843201; x=1737448001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2+YO79mMTKspiVhIbYz9bbI298LGv77ovtCCO4yOLdU=;
 b=ooXJuj8FI1p1VVLumXwsxR1RVMq4klBi8+fxShuwB0QMELUNHAWHSNuocuY1ZLyss7
 rPjar9LKx7iQvZgCnMZyWlT7RYZKr3bAwcqgbDJ5Jqo4hbJiRQx0v5IizMTdAfITJkMg
 OYZ6mrQTtWiQUkxZpqcHy6BZ0AsNulreLHekZveaStZRxA5ROBXKvB+O+TMMbwgHBZxp
 sQgChMnBw3zWJtxcG2n+bki0kDiTsfHZtStI5hyZyn1/vi4hKMJko53EecK9VsB31WHE
 xiCgxR1c6TQLvMe0cRUw8zF2xc/v9Cw3292p1ycsLVd0/iAQOlFd6YHiJForpaTNosL5
 Kswg==
X-Gm-Message-State: AOJu0YwEr946nacVbxgrHthnX6RQgK8co4BLhBWTLtH5biPYNwHoLHaE
 8MNnlAT8g3ZilLmHPyl9nEFVtxU6foGl+U8mlthl+xZVCgmT1IaokRRGaJtH/TQpWxtYWWGg5+j
 2A1uOJg==
X-Gm-Gg: ASbGnct4xh658MDAvTuBvSKjjSCDt+zrvU4ugtr8cipu56tYHS6AdivIbDFla4xSj+T
 laX2yAWT1cteBeP1pcLxD+x7gwRDHG/yhQm6ciJJF62MqIwn48o60HCrVE6/XQNcoLgnna4D4Qv
 e7yfHjwlPBhpDZCGLk477JY9QfeJqcSM8GkERhNz+FcutZrfqCdNLnm+cVZLmuZWVdzY5lDYzVa
 A5xO3GnVldnCmptq0UZBiN2bua0QNtXu2Z1ok3IIO521X7j+YWZqRNuTFLBPTyZYsI9ONnHhA5+
 tyAgKCk58pqv1vj99S+NzCwyt8JiK7rmPx9IyzTh3dj76gYbwceaFP/eIqMD0DSKM9n/Krop3xT
 nSyyKM19QQSabLWtlilM=
X-Google-Smtp-Source: AGHT+IFl0I2VUBMnHUw6BSDC+3KyTmTlliSK1sApY1DFME4Lcc3luNVR1/XQaJ2LuWbpJQ2vxtTrMA==
X-Received: by 2002:a05:600c:3ca0:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-436e266e818mr202890055e9.2.1736843200758; 
 Tue, 14 Jan 2025 00:26:40 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da63eesm201255945e9.3.2025.01.14.00.26.39
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 00:26:40 -0800 (PST)
Message-ID: <d8fd570f-fbad-483c-a74f-92c40ced02c8@suse.com>
Date: Tue, 14 Jan 2025 09:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20250113-add_b4-config-v1-1-d0c14d9dfac6@suse.com>
Content-Language: en-US
In-Reply-To: <20250113-add_b4-config-v1-1-d0c14d9dfac6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add .b4-config file
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

Hi Ricardo,

I was using the same configuration but locally. Nice idea to add it in 
the public repo.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 1/13/25 23:02, Ricardo B. Marliere via ltp wrote:
> This file configures the `b4` tool which some contributors might use.
>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>   .b4-config | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000000000000000000000000000000000..2efdf2273240dcf57bd5cab174ff6c7a1952dd5b
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,6 @@
> +# Configuration for the `b4` tool
> +# See https://b4.docs.kernel.org/en/latest/config.html
> +[b4]
> +    send-series-to = Linux Test Project <ltp@lists.linux.it>
> +    pw-url = https://patchwork.ozlabs.org/
> +    pw-project = ltp
>
> ---
> base-commit: 7aea2cea9ad5d9e1586112a57948c7f85dc12970
> change-id: 20250113-add_b4-config-4fb22fbded22
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
