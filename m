Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361ADC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751901054; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=uqIa1HkCwOnUA+x2zSdp7zLC2I1y7Sy0Ik2XW5fQcXE=;
 b=iksiYTLCI16nuxMnWV0optFRQtSCPOYs+poXVzwi4j8Fk7l7yZuo8ULn/SB0HDSXRoTnM
 eoBRReyaUguuHGOdhF7sOzXR16Y4LvEsV0CPZxTwkqZb5XRni9CRaF5rsCdD0xPSxfbzwBF
 h1fljrkZ26XgURgP9S0W0LvMnmywP9s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F35D33CA0F2
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:10:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64F713C9AF7
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:10:32 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 87D4F100034A
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:10:31 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ae0dd7ac1f5so598590266b.2
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751901031; x=1752505831; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EDHGfiQTxrKsqZLfbOeWxt89S979jHVvVsSdrqnv4OY=;
 b=C7K2HdnsupTbcBkW4IAONFFrmsnyollsgWgGAvT+6nnDrUA6b0p3xIZZc2DXMNoi24
 sjXkuYlrNVbY8WLxAJosHCIuLycPXwrAoMCYSbnfqRTLzIw7xYdrVyOPw1ZzKiMXg4Ls
 wc5HPb0IACQmWeu+4RchRy+NCQcYrIuOqURTDploFoKZvM+G6x4HPusSd3CJPiaHCH6L
 0Ql34kry/eN6J4/N77fLEVB8gghm1wCdW7LfjTwk/6mnxJhEOTwFV+FmGpidc+K7WMNu
 fIP2cfABqzXJ3EGa6nfY65pIYpIsdNJr2px90g4qYSQm4Tihqvv4f7zZuS72/nSVGwyZ
 oUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751901031; x=1752505831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDHGfiQTxrKsqZLfbOeWxt89S979jHVvVsSdrqnv4OY=;
 b=wq8OLoGYRXOlFe4k6yYZAf/Fl74LmIrECco3grygxO3w7IoFOILq65kZdZrYsxNGmS
 vezNFoNGOsOZ/M6fw74FsN5OaZZWNtb0XeWQohWAeduEwzwgvjXGESCD5LgfVG6ZABbt
 j8kf3TNLr1pVm4HIJgFiSaD3J+HDAy59uLOmAgUBvWc7ag/eUDsjU35GKVnjEYIuNLVq
 0UDjKWZpcxEt8EPcdCqQ9Iy7TNMSpuk9e15JmNKqdc2hY7opyIb9GRcrHTKK1th9EcMu
 LgNlXxYEsnOimvK80kIWxPRmBbmXmY/YkPMygjU2fQ3MmSVBd/B6cGFIYl2fklaEz+Rv
 8wFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvCfhAJwB06lz9jC0Hfy+W9PpbWpFV2+FG6/prkSSxA3VHU52XdnO3Rt//984l4NjmqdU=@lists.linux.it
X-Gm-Message-State: AOJu0Yxc1cZrYemrVPi+Mt1lKDAXwS/GlkcuOFJwc9kCu3YQ5AxxC3x7
 8k7cbI/5Mtej99jbb4gbaAE3+YB0mKOm6TFcol4iiaLkNHqvJEPmgm/zqyQCoYW+oXg=
X-Gm-Gg: ASbGncuPvpUKayabk/yRd4+CqKkQnPWXCpM9QsKbgY0lkjIjX3Csq9Sr08JRlU0/RHy
 y3GOUO51QFYwz+Vd/LMr/CBh3ePDkRYGkxM0bCaDT8bLJg4UQx+NGWI7u5t78QnxYNGr53lQ1u3
 FWa9v6ZFB8n5DLDdxcOILxxK3dTcEix26Dc1buGlpRYXA7DCcXc0fnUh7YpOtHzj0d5z+IgZohE
 zpP992KdmxNHxa4aRYl/mnLmpA4skZKTZ4Dmj1DHIAE78ipxzEMc4nGRVwgNVklfs1SnJSLR7/w
 WCffTB7glrMkB96hXXVdu3jIdG6fJExQZtP5BO9OSrT06bigjybbCkFskQDUzwj5LKLHzMqvLRf
 xL27lF5bch0RzuzSb1FNulaKKxMqMlQ==
X-Google-Smtp-Source: AGHT+IFL5gkOB/DGyqTHnrV/OtarSmWhz3wUhz9EBPklAimOd36h1zvnqMNHLzcvCxcXK02RUWFGoQ==
X-Received: by 2002:a17:907:868d:b0:ae0:ce90:4b6c with SMTP id
 a640c23a62f3a-ae410a28fe2mr960666266b.49.1751901030817; 
 Mon, 07 Jul 2025 08:10:30 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-178-88.web.vodafone.de.
 [109.40.178.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f7dsm728562366b.37.2025.07.07.08.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 08:10:30 -0700 (PDT)
Message-ID: <fff4c709-ec07-4d13-88e0-d37df0a6c863@suse.com>
Date: Mon, 7 Jul 2025 17:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250707-conversions-munmap-v3-0-0632537a6c8d@suse.com>
 <20250707-conversions-munmap-v3-1-0632537a6c8d@suse.com>
Content-Language: en-US
In-Reply-To: <20250707-conversions-munmap-v3-1-0632537a6c8d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] syscalls: munmap01: Convert to new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA3LzcvMjUgMTo1OSBQTSwgUmljYXJkbyBCLiBNYXJsacOocmUgdmlhIGx0cCB3cm90
ZToKPiAtCQkqYWRkciA9IDUwOwo+ICsJU0FGRV9NVU5NQVAobWFwX2FkZHIsIG1hcF9sZW4pOwo+
ICAgCgpOb3cgd2UgYXJlIG1pc3NpbmcgdG8gc2V0IG1hcF9iYXNlIHRvIE5VTEwuIFdpdGhvdXQg
aXQsIHdoZW4gY2xlYW51cCgpIAppcyBjYWxsZWQgd2Ugd2lsbCBwZXJmb3JtIGEgbXVubWFwKCkg
Zm9yIHRoZSBzZWNvbmQgdGltZSBvbiB0aGUgbWVtb3J5IAp0aGF0IGhhcyBiZWVuIHJlbGVhc2Vk
IGFscmVhZHkuCgotIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
