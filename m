Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425B6C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742989629; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=85ePzs6AuGQxHQIcyMOB+VykO1zWU3GsLwyg63e+kag=;
 b=XKFWtb+Urg0UF9zKwUeOkth93RRpR30ahxJ8fQyjmX6c8fyh7L0Q2/oSKdmdigGBX1yv2
 xaXJW9usVtMsOMagwMszX5FaL5BAHBzfHhMGJRjfS8jjFWk2R/FYwDWYLaNFE91Dpj4NIKx
 z+56sd3U3zbSUbr4fWpI6moOM0f7QSM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75FC43C9B07
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 12:47:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D75553C12AA
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 12:46:47 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF0F01A0064F
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 12:46:46 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so46984505e9.1
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742989606; x=1743594406; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yH/FxQGJe1TLdQHuZsSsa4kCEcGnluIHTo6P77OxJ2w=;
 b=V6RQEGXZHWIabuu8F9UJxkPpxP13E2jLNEMK8JZTM25jsCPbyXOR2PkwhbVTVjBZt1
 +J+c7B2fqX/fIr4q4kK/Jh8jwOK0nwJrd8SEH4pJ8Q4QSzElj9CgCwRbYDDDzKLzaoYj
 6vPAoUhjVaZkQM+d48e1KkqSHkcyetFTGTpXkvhxVf5vgDRzKBpD6E55vUGCB7kuFdCY
 d/3vIAtdLUpNdudQ630JeT2E3g6LYojBF8TXQRShYdAEN0HcYRpeoAOjtAg04jy2pnbn
 pMqBisy/LBKOXbuB1G+pYFBg5rFUrDCIhzKqfsesBg9l7AlvIIL/Pjw5hnMPbXQsWBcc
 RWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742989606; x=1743594406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yH/FxQGJe1TLdQHuZsSsa4kCEcGnluIHTo6P77OxJ2w=;
 b=t0jO0EmICcpyucmxjWN1qsOO01nbLEH8MZ/GpAATex4vs5FP6hu1JI67NYzw6E7cBy
 FrJpqLDNlFtVT0dMCBko2uw2JloDKeqQourI+WNhSf2CaAjnRR//8lYbhMi0S2Z/oedw
 /H3GFGlGYrej5rrVDx3+Z1S3lpXssZs7Ti9g7wD//BgSjCBkxL+1LNBzgRuJAlNMv65o
 6xo7bmH+3no9ItOuCjNdHgPXkGwOW7YE31CNr32ArzMG4fYlWChngeJ/ulGrKECBf5DT
 FmroQ66OJiFsPiwwM6MMot+fWrfoVlSbE5wPKhwsXzAefsnlMq+qyC3JrcbVB0WmhDBH
 5l0g==
X-Gm-Message-State: AOJu0Yyu2TwGL8VHGiSFBOf2KP14n9fEmUPbJXRSTMDe/jQ5iDC80Php
 nYPmo+nL6y4N8PqcI5HzAOb4sxDgUagxWdux/a7fVMA+bE7CtPC7AdIUpBecq+U=
X-Gm-Gg: ASbGncttWrdhSgtFfwNWF2nDxbkeoy8lGkO4rcYEIVdK5o1p1bT059e7NFOpTC/FAti
 gQp33Fv6FWzQvEd5gFw3VmCSdbE5O+rFRCPv6I8gAVjIz5u066TmLNh1f0JC6xzdFOqsW8CkCVO
 wKHPrtZBDczYG8/o7lfUEBiM3GaDbtozgw+gtlKK8BhdXWGXgW3xwfcMnZsf/SaDd0AUMmQOx9Z
 z9xNjCSwt58uVwkWA2/MdAHrieGiRar7VYye5wYpyv7FwjJBUFT5cSLUftadl952JZMNtT3pPDS
 DKGXiwvl04trROqbaG2ac9y4zYULPS0sql+xquYo2PHiykn7zQ/f5H2vQlDoXhmnKY2VeQzrpFq
 l+CtvnRcH+OYdMhPlzvfjVuFBSxUNNlmaZnF/LGaKoR08DpeRKKOpxwym5M4V81v+wl626s9K++
 wRcgKsSwc=
X-Google-Smtp-Source: AGHT+IHPOaZBH2in0qhNWmU4z2D38Z6tC5c5Mh749klmBbufhBqY+M789pQcnS23I6tsMWsIQdqKzQ==
X-Received: by 2002:a5d:6c61:0:b0:38f:3c8a:4c0a with SMTP id
 ffacd0b85a97d-3997f8f5d31mr15851125f8f.7.1742989606165; 
 Wed, 26 Mar 2025 04:46:46 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b4ce9sm16786919f8f.53.2025.03.26.04.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 04:46:45 -0700 (PDT)
Message-ID: <d6b36581-adef-4bdf-9309-4b13d87e85b1@suse.com>
Date: Wed, 26 Mar 2025 12:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250319-remove_symlink01-v1-1-1a532d6fc89f@suse.com>
 <Z-Pk6KESOk25Ge20@rei.lan>
Content-Language: en-US
In-Reply-To: <Z-Pk6KESOk25Ge20@rei.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove symlink01 test
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

Thanks, merged

On 3/26/25 12:28, Cyril Hrubis wrote:
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
