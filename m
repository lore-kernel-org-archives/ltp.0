Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F06C3ABA5
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745939855; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=cvJAc22Ii19YYdnb7g4Q1JXU4tLSynIb5e//yjS6/do=;
 b=dImwuM65h9u5wUU7nyCxGPpMIPH+VQZDtNDFh3g6ngpT59ui9PAgdQe2NAkUQT+YOzG0e
 odKQzIcdcdxoe3z9FUWkhZeBKwl8wkqonnewG7zM7rcwhjMyRSefqeZt+1VN50B8m2gGG0u
 76394cCFhVZV/R4I4F3oHpHqeLvpfoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB7B63CBC24
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 17:17:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD8D33C2B3A
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:17:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14A5E60070E
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:17:13 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso39281305e9.0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745939833; x=1746544633; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9yZnz37si9MjXbV17ZoSNmXeCdNnXiirxBhSp6OK+QA=;
 b=XYJCfWhZQoOvdJbUEnlcMGrfSpRoedND/ghTEZK8TTo4im5jI4E7oRzlbUwoUEuid9
 7MHm8redeLBe/9v6QfMuPrhg/qjAulwPvw+v4LFioiy1iK8P8n5KL0JIUHY/CDz+izlS
 1koYw8c/OKR5EWCpw4M8DnZRkwF4UHyzL3w+nV112BiOYiNrI+Pw3uKyxLaHTeSvVyv2
 wUbOCQOcIGiLFiMqMTwCSL/eimKB/Iiu3Jd6Zp3DbP09VzxpVkoUdNuw6CdDAA7HOaxC
 FwbMaojq2P5boB9AvHLUKA4Uo3yC8VACoWtBkCODL6mS02zYyGVx6Y4beWMkRXlJSMsk
 K15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745939833; x=1746544633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9yZnz37si9MjXbV17ZoSNmXeCdNnXiirxBhSp6OK+QA=;
 b=smr+tBhWwuZH7d6D2HktlNI/XeSUE3TGSBjLxG2Q5/PEccvkfnnQRUp/U3DHwPZ86J
 F9jRY6AACG9N29AxeceIh15kfq2nfsrQLR9C7F71HY0kkirl0RgoEpZOk5oKF8tHE0Kh
 N7G6tQFTW6O5jXrZdrMDNu/pKTP7Q9NFXGmAqaM1i+3JnAjf+ZaRb2tpTAc1PlGg0kiS
 CtPp7BC0I/sZYmbnl1L3IR3eMFY65jETWu6C0BwAC8ysc1eCWrTbwWGbHJKHmxPxMuOo
 Q6aasfPHOvfsuR16l9+GYzTO+9+MJxoGrKp6cfqOtOqUGcDHvLqrQaBZ1EJ2Za9ixzFj
 ie8w==
X-Gm-Message-State: AOJu0YwGSlsVIClw5ysxRWWwsGYeHFKl3QV1pXc0HMB1gLKahErTeHYj
 t74Vg49mYV8eaudI/9nUJg09xmoZovhVZ0WzZ4cKXHX29cGZLPhfPl5ibJo2fDKaXxVZ+HP7tkO
 d
X-Gm-Gg: ASbGncuhC0nWrLbN/SZaS6WNmQSRSdPPByGCIgMKutwPIFSoZKt+BvhFdOap7A4PPRA
 EEhkTBuGJyM0jfKiv1nvoVdz9ZtM0VAEUihAoEWChbAZGKqSQp4VcaIY6yFi8FoD/4/zKtDlFbp
 Q1uF5NveKSIZqkEHU7Go/r3RQWEIeoZdklX2UOQW/FKT1X178z29gpf81AsBE78MTSgfTZ7FXpm
 Kj1Ra/TRO9zfUoENMd5K+btxvyLDz90jkeBaL+msbd3O8si9fKRrKdcjAlWJXk9qGtuijRbF58x
 7g5mPNxYh6bzreVplEJsCxGic4MTJ0aUfEj1uuvhD0UsxtYti2aMTa/EsYkSsc8tri+qe66bVMU
 W0PBwR5gbAIjVmlHtXew6wDZyiNpcsjI0P12wzBT82tNM7Y/LxF7eHSbU3g7tr+nlQsT/Fqakki
 A9yQF25TapSG2PYQ==
X-Google-Smtp-Source: AGHT+IGHX/v1RjndTDj3lZatN448Z9jVZBPftQKFjdCJV7G6wZNL4qpiA8LI/+KlTJE7yg2QPxRmZg==
X-Received: by 2002:a05:600c:501f:b0:43d:97ea:2f4 with SMTP id
 5b1f17b1804b1-441ac85791bmr41741045e9.12.1745939833321; 
 Tue, 29 Apr 2025 08:17:13 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1d1sm162499975e9.26.2025.04.29.08.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 08:17:13 -0700 (PDT)
Message-ID: <f2a81424-b035-433e-b299-07634039ef3c@suse.com>
Date: Tue, 29 Apr 2025 17:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250429135542.19680-1-chrubis@suse.cz>
 <6d9e6e5c-2453-4f81-add3-01c193776e7e@suse.com> <aBDq6PobtIDF2_nV@yuki.lan>
Content-Language: en-US
In-Reply-To: <aBDq6PobtIDF2_nV@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgd2l0aCBUU1RfVEVTVF9UQ09ORigpIHRoZSBzdXBw
b3J0ZWQgYXJjaGl0ZWN0dXJlCj4gaXMgbm90IGV4cG9ydGVkIGludG8gdGhlIG1ldGFkYXRhLgo+
Cj4gVGhlcmUgYXJlIHR3byBjYXNlcyB3aGVyZSBUU1RfVEVTVF9UQ09ORigpIGlzIHVzZWQgaW4g
TFRQOgo+Cj4gLSB1c3VwcG9ydGVkIGFyY2hpdGVjdHVyZSBmb3IgdGhlIHRlc3QKPiAtIG1pc3Np
bmcgaGVhZGVycyBkdXJpbmcgY29tcGlsYXRpb24KPgo+IFRoZSBmaXJzdCBjYXNlIHNob3VsZCBp
ZGVhbGx5IGJlIGNvbnZlcnRlZCBzbyB0aGF0IHdlIGhhdmUgdGhlIHN1cHBvcnRlZAo+IGFyY2hp
dGVjdHVyZXMgaW4gdGhlIHRlc3QgbWV0YWRhdGEuCj4KPiBBbm90aGVyIG9wdGlvbiBpcyBqdXN0
IHRvIGFkZCBtZXRhZGF0YSB0byB0aGUgdHN0X3Rlc3Qgc3RydWN0dXJlIGFuZAo+IGtlZXAgVFNU
X1RFU1RfVENPTkYoKSwgYnV0IEkgZG8gbm90IGxpa2UgdGhhdCBzb2x1dGlvbiwgYmVjYXVzZSB0
aGUKPiBpZmRlZnMgYW5kIC5zdXBwb3J0ZWRfYXJjaHMgY2FuIGdvIG91dCBvZiBzeW5jIGVhc2ls
eSBiZWNhdXNlIHRzdF90ZXN0Cj4gc3RydWN0dXJlIGlzIG5vdCB1c2VkIHdoZW4gVFNUX1RFU1Rf
VENPTkYoKSBpcyB1c2VkLgo+Ck9rIG5vdyBpdCdzIG1vcmUgY2xlYXIgdGhhbmtzLgpXaGF0IGFi
b3V0IGFkZGluZyBhIG1hY3JvIGxpa2UgVFNUX1RFU1RfVENPTkYgdGhhdCBzZXRzIGFyY2hzPyBB
dCB0aGUgCmVuZCwgdGhhdCdzIHdoYXQgd2UgYWN0dWFsbHkgZG8gYWxyZWFkeSBpbiB0aGUgdHN0
X3Rlc3Qgc3RydWN0dXJlIGZvciAKdGNvbmZfbXNnOgoKI2RlZmluZSBUU1RfVEVTVF9UQ09ORiht
ZXNzYWdlKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgXAogwqDCoMKgwqDCoMKgwqAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0
ZXN0ID0geyAudGNvbmZfbXNnID0gbWVzc2FnZcKgIH0gXAoKU29tZXRoaW5nIGxpa2U6CgojZGVm
aW5lIFRTVF9URVNUX1RDT05GMihtZXNzYWdlLCBhcmNocynCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCiDCoMKgwqDCoMKgwqDCoCBzdGF0aWMgc3RydWN0IHRz
dF90ZXN0IHRlc3QgPSB7IC50Y29uZl9tc2cgPSBtZXNzYWdlLCAKLnN1cHBvcnRlZF9hcmNocyA9
IGFyY2hzwqAgfSBcCgpJIGtub3cgaXQncyB1Z2x5IHRoZSB3YXkgSSBpbXBsZW1lbnRlZCBpdCBo
ZXJlLCBidXQgaXQncyBqdXN0IHRvIAp1bmRlcnN0YW5kLiBTbyB3ZSBjb3VsZCBoYXZlIG9ubHkg
b25lIHByZXByb2Nlc3NvciBkaXJlY3RpdmUgY2hlY2tpbmcgCmZvciBhcmNoZXMgYW5kIFRTVF9U
RVNUX1RDT05GMiBzZXR0aW5nIHVwIHRoZSBtZXRhZGF0YSBhbnl3YXkuCkluIGdlbmVyYWwsIEkg
ZG9uJ3QgbGlrZSBhZGRpbmcgbXVsdGlwbGUgcHJlcHJvY2Vzc29yIHN0YXRlbWVudHMgaW5zaWRl
IAp0ZXN0cyBiZWNhdXNlIGNvZGUgd291bGQgYmUgcHV6emxlZCB3aXRoIG11bHRpcGxlIGFyY2gg
ZGVmaW5pdGlvbnMgCmNoZWNrcy4gTWF5YmUgeW91IGhhdmUgYSBiZXR0ZXIgaWRlYSB0aGFuIG1l
IGZvciB0aGlzIFRTVF9URVNUX1RDT05GMiAKaW1wbGVtZW50YXRpb24uCgotIEFuZHJlYQoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
