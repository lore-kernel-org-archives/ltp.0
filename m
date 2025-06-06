Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D22C5B555
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749219243; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=0bZcJ8O3XDeg9GIZyE345wl81OWB9fsCJ4sS9K/Zw0Y=;
 b=qUM4E9W8e7TViuEwk9iS+cNs0DOIa17pMimZ/Smldse+CXEXMJMqCT0aCAHObm5IZ9wuy
 BQLib8DqxOp6TRxXxsfIhXGNtOSdwhU0vTaY+dDmLtjQlearnPcn94kecpSCz1ckLdQK4tA
 u4CifZvE9ko9q3CtynidMEq/eZtmA1c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FB563CA55C
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 16:14:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70DE53C9B27
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 16:13:41 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76A8C1400527
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 16:13:40 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso1989974f8f.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749219220; x=1749824020; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+YDUY0ZEbA7MdlEaVYCdMBkqxQbASFloqyCTi3vN7SM=;
 b=KW5HDvW1n4FglpE1nkb5MT9A1umDtENJR64RWZnwUPgFBR7whKvtfS3o8SbcaM2VQM
 TFJQo6Xn7m15rYOxcf35n+F8KNpF6O+TFt4/T5sXk6eNWy6eV66p98iztotN4xS8atNs
 y6/fSyk07sLCaGcxGrons4IVPP3CLypQ26bqS9MUB0GTLLbWonezaMINc7+0H8fnr5sA
 t4XW9n0Fk6/zWH2HqsBDVTd2pHlMgX8RTf0NrqXKdmJpMuUrhoDrr6rYLfieGm1zodAl
 ifScy0pds9XY+OZK8RMXo8Z6Fs02beV9j2ioH78VzdkT+2PRgLF+bqV6P35OKVlBGXP0
 tpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219220; x=1749824020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+YDUY0ZEbA7MdlEaVYCdMBkqxQbASFloqyCTi3vN7SM=;
 b=lT+oUxmswXjLCW1QOMGozZtUTY+LJ82EsvhueuV067fCIy4lil5ZjSXHocHXuWoyOl
 D8g/RnXO+3rsBSlw+KaowSSMpbuA0mOfCSqvOKPNvEigKJlTVXqKZ208zs0djNwINBSW
 cd+WDpcJ2ktFLkSDpKtXD8mWGJ6++/gjpW/ELXkfWZiaz0qE/h74cBf0pTjBbCJsoKSt
 yyQaiNUsPccWmK7htJ8rymaamtKB3HjL1JCHvi4y7d1pjglIQ7VoLIxP30gqB6ObpGyw
 /lMYUyn8tagLoXbqnwlojQ66fej0akKcbmdthYY+KeiPobGvL7SwtAjDgt6WrGWElySr
 t+Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05JJuhMVoGegXKQL8xs9/Ll9HDSZzmVO10qcksO4UqJ25nkAzja/AisW69B1L/lK6GR0=@lists.linux.it
X-Gm-Message-State: AOJu0Yy3rXIBRudGD/HTf8nbFLjS/qEkXpMQ71SrubSx5qo5Dv6xSKSS
 qeuLrxeYa06F0vWC0w95Fk/p3Utx+xVAQ+qc/sJaG4vMH19zZYXFl2t4n5CoJmMFSAwnUB01/e2
 bcfZH
X-Gm-Gg: ASbGncvOTTxfAgoGyF9n+rEGXGJlNoPDhiqXb4CHsfClyfL4gL5IQ4wK6P7s/y1mfAc
 jLnEXPBDUxFUfaBkJ/uAkA2yC4oxmjzlblU06ghQ78X0+TqBj7zpOxbBCEmquJwxe/Pev1CwM3a
 Kj3ONzwggJUr1e3WFRIrDyS2EUlf+e4NB61WgEi2JdSiDG0tDUo4Zwo31pJGucKt9Uxu3wsYlwL
 OiJPuJgXwzUMFjA4MfTZuWz8DRK3q60hYX9ezxHOS4AK6rQKzN45MkHmw+rQ2Vcayu5N2LYJ6lo
 6wXTTCQFcZ1R62ObISGu3ZNihLaTn+UX5+57BJ3o58JOAIwbvGpX6oVUbca3XDPvFHWBKSMBys2
 XspL7Uu8AFAYpa9P/nWFUGx2vWX3+b8wxrZUv+FdhPFQBjSeE+d4TMgpGgePPyZdvDdMTaRNBUM
 2O8oeuZz8B9GGR2COeuR57IZib
X-Google-Smtp-Source: AGHT+IFOlxj3/jRjPSZtY7rIK1lZqdi6W1IfcBSc/TP2ynJj4WZ9/lpACPexT+oE9Kry7rN1gMWAzw==
X-Received: by 2002:a05:6000:109:b0:3a4:e75f:53f5 with SMTP id
 ffacd0b85a97d-3a5318a0719mr2859227f8f.35.1749219219688; 
 Fri, 06 Jun 2025 07:13:39 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603077f8asm12757285ad.12.2025.06.06.07.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 07:13:39 -0700 (PDT)
Message-ID: <ee456371-4f20-4be7-9cc6-ab20b3bc4c5a@suse.com>
Date: Fri, 6 Jun 2025 16:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250606132100.20145-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250606132100.20145-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] doc: Add testers guide
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

It looks really good to me. Nice idea!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
