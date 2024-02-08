Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9086C48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707398734; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=plz/k7IZGGCTcgV/IKI7BWS/1gGN2P0hIoHRh0oOJvI=;
 b=jwf6w88CL+0iHakvdvxNrr1WvELEoRXekzwji0FBg7krSrG5OhKSFxizCwBVE8NvodOyO
 rpDORher13RYhCP3OXCZZIIa4sx6UMwxT73vL3qpqDHCKiGKZvU03ufknj2NFnKDhpma+kx
 Ev7kYv3jRHI1Q5eNN1Z9Eo79+t97Lhc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3C963CF556
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 14:25:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75BD03CC3F8
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 14:25:07 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D082208E1A
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 14:25:06 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4101eb5a115so13408115e9.1
 for <ltp@lists.linux.it>; Thu, 08 Feb 2024 05:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707398705; x=1708003505; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r8SYfNPJGeQlAnTv/xb4tAQVrodiEzdTLUePjrO4ml4=;
 b=E6OwLxDppJPqP1MWciCkSyUyN+/ZoyL8Vhl+NeDIBYAMfl6EdNPV+bj3aVDkjjYAgc
 GrA/ZaRcNk9WUFxosnvKqCZPhKWkM5HjWjYTR7bPo185i/f42FT81c6oyuUA4bhbUVh7
 kgQ/Z+p09tGcPVwnw+IK8lFdV13ER4f72Ac4h3EDpcE2PXumLnMkxGAMc1gEUyaWir8w
 U8sBg9vQl7tO5wMOrVmpjArvyE/C8oeQpLuBBssiv8bTRr16hb6xD0Stblm0MsRwwZcg
 00LhY702PrG42Mwh6ZU0CP1uiII86ehUrbpNyjm8s51GIEa2p77NeS+OQKfFGH6ojfNF
 lQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707398705; x=1708003505;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8SYfNPJGeQlAnTv/xb4tAQVrodiEzdTLUePjrO4ml4=;
 b=KwGsj3bNhDjcoNFZ39k5u4E1AkDpeHtvjlGyH57UOfklDzbQ0/keGN0PC/8TfgtT3g
 PG2jjlB5PfgKjBc+3t1E8jEeX4W3N0cCpGyhFgv24LmavrvNNhyNe2zVQHYdO1T1oMmF
 yBNas3VTulXvPlTQxznvj5+lN59RZvFnUN7UP4RxWe9TUrHadDJHtWa0dPkAS9D5oZ5T
 FcFoyZyG7Ah+dEaN1Ks+lMF9Nz9v+/XX+bcYsyJYtX94UxhNH1/O8LUN2Um6XArd7y7G
 sjuKwLahy4x1GQfK1RIuyIhrE/4PDM6fK0LJ4H9bF/AwTcJZJ1aUYgrIT9JFJg4B6aLZ
 t8lQ==
X-Gm-Message-State: AOJu0YyeSJuVxEkQx8oS7RizJY4fIVkFPtwLEMEkqcv+PeFrvbp+guPB
 ZAAX8xX3hxCTkGFlhephNgMh9V+kRk1+5CB1rqJHwb40cCgqRA3iHlcgbhDz90nLK7sESNpfBRY
 vpFs=
X-Google-Smtp-Source: AGHT+IFtCQ9yMP+TKO892Mko2ZuDZXppf5T9rQXLAybPXxdOaoPEIUeQWKwmF7pVmQoKjAJ3RYb4oQ==
X-Received: by 2002:adf:eccc:0:b0:33b:4668:8496 with SMTP id
 s12-20020adfeccc000000b0033b46688496mr5690072wro.64.1707398705029; 
 Thu, 08 Feb 2024 05:25:05 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.176])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a056000181400b0033b43a5f53csm3576796wrh.103.2024.02.08.05.25.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 05:25:04 -0800 (PST)
Message-ID: <1b20cc16-314a-4c0a-92d1-d696037e899c@suse.com>
Date: Thu, 8 Feb 2024 14:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231108074935.1409644-1-pvorel@suse.cz>
In-Reply-To: <20231108074935.1409644-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] link05: Return on link() failure
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

SGkhCgpMR1RNCgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbT4KClJlZ2FyZHMsCkFuZHJlYQoKT24gMTEvOC8yMyAwODo0OSwgUGV0ciBWb3Jl
bCB3cm90ZToKPiBJZiBsaW5rKCkgZmFpbHMgdG8gYmUgY3JlYXRlZCwgdGhlIGZvbGxvd2luZyBz
dGF0KCkgZmFpbGVkOgo+Cj4gbGluazA1LmM6Mzk6IFRCUk9LOiBzdGF0KGxrZmlsZV8xMzkxODIy
XzEsMHg3ZmZkNjFlNWYwMDApIGZhaWxlZDogCj4gRU5PRU5UICgyKQo+Cj4gVGhlcmVmb3JlIHNr
aXAgdGVzdGluZyBhbmQgaW1wcm92ZSB0aGUgZXJyb3IgbWVzc2FnZToKPiA1OiBsaW5rKGxrZmls
ZV8xNDA0ODc5LCBsa2ZpbGVfMTQwNDg3OV81KSBmYWlsZWQ6IEVOT0VOVCAoMikKPgo+IEFsc28g
Zml4IGNudCBhbmQgbmxpbmtzIGNvbmRpdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+IEBYdSwgcGxlYXNlIG1lcmdlIHlvdXIgImxpbmsw
NTogQ29udmVydCBkb2NzIHRvIGRvY3BhcnNlIiBwYXRjaHNldCBbMV0KPiBmaXJzdCwgSSdsbCBy
ZWJhc2UgbXkgYWZ0ZXJ3YXJkcy4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjMxMTA4MDUzMTIyLkdBMTM4MzkwOEBwZXZpay8K
Pgo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGluay9saW5rMDUuYyB8IDE2ICsrKysrKysr
KystLS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xpbmsvbGluazA1
LmMgCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xpbmsvbGluazA1LmMKPiBpbmRleCA5
YjgxZWYzZmQuLjFkNzA4YzZmNiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2xpbmsvbGluazA1LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xpbmsv
bGluazA1LmMKPiBAQCAtMjIsMTMgKzIyLDE2IEBAIHN0YXRpYyBpbnQgbmxpbmtzID0gMTAwMDsK
Pgo+IHN0YXRpYyB2b2lkIHZlcmlmeV9saW5rKHZvaWQpCj4gewo+IC3CoMKgwqAgaW50IGNudDsK
PiArwqDCoMKgIGludCBjbnQgPSAwLCBjcmVhdGVkOwo+IMKgwqDCoMKgY2hhciBsbmFtZVsxMDI0
XTsKPiDCoMKgwqDCoHN0cnVjdCBzdGF0IGZidWYsIGxidWY7Cj4KPiAtwqDCoMKgIGZvciAoY250
ID0gMTsgY250IDwgbmxpbmtzOyBjbnQrKykgewo+IC3CoMKgwqDCoMKgwqDCoCBzcHJpbnRmKGxu
YW1lLCAiJXNfJWQiLCBmbmFtZSwgY250KTsKPiAtwqDCoMKgwqDCoMKgwqAgVFNUX0VYUF9QQVNT
X1NJTEVOVChsaW5rKGZuYW1lLCBsbmFtZSksICJsaW5rKCVzLCAlcykiLCAKPiBmbmFtZSwgbG5h
bWUpOwo+ICvCoMKgwqAgZm9yIChjcmVhdGVkID0gMTsgY3JlYXRlZCA8IG5saW5rczsgY3JlYXRl
ZCsrKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHNwcmludGYobG5hbWUsICIlc18lZCIsIGZuYW1lLCBj
cmVhdGVkKTsKPiArwqDCoMKgwqDCoMKgwqAgVFNUX0VYUF9QQVNTX1NJTEVOVChsaW5rKGZuYW1l
LCBsbmFtZSksICIlZDogbGluayglcywgJXMpIiwgCj4gY3JlYXRlZCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZuYW1lLCBsbmFtZSk7
Cj4gK8KgwqDCoMKgwqDCoMKgIGlmICghVFNUX1BBU1MpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBjbGVhbnVwOwo+IMKgwqDCoMKgfQo+Cj4gwqDCoMKgwqBTQUZFX1NUQVQoZm5hbWUs
ICZmYnVmKTsKPiBAQCAtNDgsMTMgKzUxLDE0IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9saW5rKHZv
aWQpCj4gwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgfQo+Cj4gLcKgwqDCoCBpZiAoY250ID49
IG5saW5rcykgewo+ICvCoMKgwqAgaWYgKGNudCA9PSBubGlua3MpIHsKPiDCoMKgwqDCoMKgwqDC
oCB0c3RfcmVzKFRQQVNTLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAibGluayglcywgJXNb
MS0lZF0pIHJldCAlbGQgZm9yICVkIGZpbGVzLCBzdGF0IGxpbmtjb3VudHMgCj4gbWF0Y2ggJWQi
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbmFtZSwgZm5hbWUsIG5saW5rcywgVFNUX1JF
VCwgbmxpbmtzLCAoaW50KWZidWYuc3RfbmxpbmspOwo+IMKgwqDCoMKgfQo+Cj4gLcKgwqDCoCBm
b3IgKGNudCA9IDE7IGNudCA8IG5saW5rczsgY250KyspIHsKPiArY2xlYW51cDoKPiArwqDCoMKg
IGZvciAoY250ID0gMTsgY250IDwgY3JlYXRlZDsgY250KyspIHsKPiDCoMKgwqDCoMKgwqDCoCBz
cHJpbnRmKGxuYW1lLCAiJXNfJWQiLCBmbmFtZSwgY250KTsKPiDCoMKgwqDCoMKgwqDCoCBTQUZF
X1VOTElOSyhsbmFtZSk7Cj4gwqDCoMKgwqB9CgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
