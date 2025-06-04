Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A8C5B552
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749020542; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=69zl7bMoieevbMqjZBwtyRJQAowFqJ6qkIbuZTHIyfk=;
 b=fXzmUzs34XOBaDoJy57xMR/Lw9GBI8uED1BIfkSpaQNI8Av1SewPv8yowuiIIqPEPD2KU
 tX8RmP4Pdi65PZl94oOVWwoqePxQgEg/hXyas95CyS3WJek0gaMDZe8IJbv3qteNnVIqTNr
 5elXnkoxp90uCSVFN5ZLiifg19DEenQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0BA33CA0FD
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 09:02:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0FD3C3334
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:02:00 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62552601B03
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:02:00 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a522224582so56812f8f.3
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749020520; x=1749625320; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DuSRADIQYpDUlm0Asxm8ygDtZTGqJ0YWdvhVF4BjwFQ=;
 b=I16Ep38MWZRqMHrb1RQM4BHNrB93oM64p2Sh3fFVg/pcNK/qDe3GRZndj6ij5F3UBI
 Jxrd1RBJMaestSkB00bD8IL2OBpNBEEf09twTG/dh+QMZ28GnLcBLPKzttYX4knomclP
 qOAyfQVmsSGHPcqZKgE3q1FCBW6s9ohGpT6UoyLrGCDE1IEygv+nOlAYmSeDjKdnMfA5
 tWtBXk2Zf7VRFgLHonc1KwwBK/uAEnvdEwgjInh1sZT+MKkw2q2dbVMX8SDAZLdKQgRA
 qY8ak+qTPr8XSZH/GfG0UbKgxjwmCAP7K8sU78QDmS7OjmP1P95E+iZMURfyJPkIQ0/s
 +CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749020520; x=1749625320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DuSRADIQYpDUlm0Asxm8ygDtZTGqJ0YWdvhVF4BjwFQ=;
 b=k1VYznUjff9XAG/aWiXOo0+LfyzTxLRriN4BHlZXzOATQt5/3q37PuQTyZ9q0LOD0w
 NLaxh0je0hrxvQuXK/gmK9w978RHUVWiC6E6AQ9UGepZHCqN5y1wH650tp0svKSyvhxy
 vm7EDmaNFunl59539jvHoxO1HUMTfjwy93gtdZZv+Rk2Kk9Tr0FYCuYe2HNqi8xAiN4H
 VbARw2bJpnvhx+WaqmtXLntHkWqn/ikasJqm9SiRY1hPy+jujWfosv0KMszGdh3GlqQc
 ftLKVxJUbvTqn51cUa8OSCgJsc65QNehT+iDD1Y46YRf/2aqEoRqJdKPNtf2zWtK+zP9
 rZZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkcMHhCqoRcq5sXz9PWTqPRxO18b5dBZCefOa0T77SLcGJdXq2toto5LRtBpsTsW5b2xY=@lists.linux.it
X-Gm-Message-State: AOJu0YyIgEPFBOSbronfc7DxsgjB+tZXnNdAIwx+uSL8D+FWcEgDR56a
 6Y47FQyl5tdKzAnqlRpvFbzfC/8cWJKapjBo3z04tVDppeoWuDne6XS0gg7goov/DPI=
X-Gm-Gg: ASbGncsw998h/oTWy/dEEE8qOpl7dmiahAASKNPsLZt9uzf4BqDRASrXpiQtlXc0WkS
 +XwfHVSMxPPT6UDIxQApff1gl4DW66Mp8wHDKjzwFsvEn+ewqKM0lt/SzfHgalGFXIiuClXUWtu
 rh5HPMfPwc/THpDsCzQls41mypM0Xk9F91f3BydfGs86vnY/q+/pjJ+PYpt5CgFLpJ+HMLlVjRU
 WgVY8QC1nrdYJ8NzxAS6SRnDVQi1fZlQ5SQDH0AyK+yNPRKJsPNW87+gEfVVRvrtUr54W84KdEl
 dXtbfpBhJrpo3lq8QALi8NXD867o7zbTEZEUbfmJipjGYl6gciHhhQauue1x7g46a/MAiPPBkE7
 5neRdlOwfcbmmos584+ndrSTDQ8ixUE4lph5ehuDsvnyPuxb0GR/ICHF5CYubWrfhadDENOZf5P
 jwo9B5x1WjoIEkJjzrfQwuNTPWbetNVIZhheQ=
X-Google-Smtp-Source: AGHT+IHTk4p/M4a0s2ZNOOW0KTNzqWssCzGW1Ea+XdQHZROGiumr4rNqwUYO4WtcLmpNRF5snhaxPQ==
X-Received: by 2002:a05:6000:1a8d:b0:3a4:cbc6:9db0 with SMTP id
 ffacd0b85a97d-3a51dc49afcmr1008813f8f.51.1749020519770; 
 Wed, 04 Jun 2025 00:01:59 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affcf9ffsm10820021b3a.135.2025.06.04.00.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:01:59 -0700 (PDT)
Message-ID: <f999a4a2-7eca-45fe-b297-77c25bb72c55@suse.com>
Date: Wed, 4 Jun 2025 09:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250603152253.214656-1-mdoucha@suse.cz>
 <20250603152253.214656-2-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250603152253.214656-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] epoll_pwait: Refactor timeout to struct
 timespec
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

Reviewed-by: Andrea Cervesato <andrea.cevesato@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
