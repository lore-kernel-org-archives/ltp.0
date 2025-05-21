Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17998C54E71
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747846330; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=NEUKZKOnNIK9D/mNix4/+Gxcn3dbr2na9snu4LB/TiA=;
 b=f8g6Z6QVm9XnJTdxJUjAXW1hVREzcBgmmB+1BBbvbK+uIvsJ0tOAIztz7AKdEnKkgJBje
 JGWT5CoDPg7Ry5NbrTBZXkJSUf+ZK5644GU7DEh1aIoUojOui38wd5XfhKKz/3/XeyW9pt1
 PJS+U863llWcg/Vk547XfOilTbs6Q1o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F1D03CC814
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 18:52:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160523CC6F0
 for <ltp@lists.linux.it>; Wed, 21 May 2025 18:51:47 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F03A6601F99
 for <ltp@lists.linux.it>; Wed, 21 May 2025 18:51:46 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so6232763f8f.3
 for <ltp@lists.linux.it>; Wed, 21 May 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747846306; x=1748451106; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gCK3f+6hBTK5OJolOpfPJarUVqTROQfzfH2rdTCd0yA=;
 b=YgWh77yxYGqVGd1g1AXEmDzEEO5wCa93Wst9hF1PAnBAtqhSxwYbRJnga8gFxv3khR
 NYKRYvNDACW6hwUi8883CE+THLwhs8VvSqNYaNF0ztwjbs+x5d6Dyn5g3S/1l75RIycK
 6mFU0M9Ls8et2opf8RlN7s5dpdsJ8GB1kO1E1oRSrePb08GkGb5GRkwVxxD9r91I2oES
 1eVLnuHAEQ03GfAdjRlIenOezL8/wqk1AP79h9O7nWG5LrfHsQhhOfgExJyrysmK962B
 UgD8GGev4YSIPlArYS1kbIUcz9KcI/8mpJ0fUjtGfzHFOlnkHzL66/xlqgCFONWk0mkB
 lmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747846306; x=1748451106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCK3f+6hBTK5OJolOpfPJarUVqTROQfzfH2rdTCd0yA=;
 b=ui0Z3xWk0OEk4ZUj5fqpSiWoKyKJOiTJgYy2s0gwvftQJ37UkJYvWUsckkchVyGS/f
 B0z/0wMhfZZUlISeYLKpz8aZ8jBA6X5y+zP4H4KvymSYwBf+Zd290gvkTopAW7N14Y50
 kPp0sBoEt41swgK5zpht03DM8g5Lzke9qYUSfxsLqsympKVG+hGYLkTVUYtPqgw0IjNQ
 Sw/ALlivP+jbgTcTSChUOcKp9tlpKYZCgtQRCy/iHYExbZc2guuQXWWFm65VLicbUrvp
 i2BQYhMMW5Iyl+juC0gHqT2GfJg2yguA60wu8UhFs47mRSbdvCF0p8jkPLGFzILKsHUV
 PWJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk9TWhW7qPW4qiSTjqOaniv0almrWxDP1OwzjMBZFQbwFLYTiRd5bgIVEfX9HipW3iA0k=@lists.linux.it
X-Gm-Message-State: AOJu0Yy95n56vjwFnnWqjF8exxEnmgRxj/qF0Z+kusopEWR+rNt0Ivdl
 saF29ace7GfNXrFdl+/Xzdlb8eBFHP1gTRHq1t+WYkKLvt6xXLADAkdoa/D/edz/xXQ=
X-Gm-Gg: ASbGncsTUHcdgJw6L8xttCyYWtyGgj126InOKftS4zfwDEQggM/IilWhnyc/wJ+M/zc
 sqpUbJk0RMALbjj8gLYdTGUpKT2S5/okrj3xa1y0ADHY5Vy/8cwS6SQobokkM55XdsRGhLDhmbA
 O4JTAGAKt7AEs3jFXpJ0Z6lj60z5QkHexw5/fMz+UBwLyIRfFBY7itBHb6zpoc8jdehYvb22tZx
 MtEZeEsrJti/9xinOOSGFfiT5031dXdbKaj3+f0E/6OTJCk/loAHpzlPZlMXfKESkqw/UWUMMwg
 H70k5z8g2cvh6ARghzg0dIkmeNdKl7zLqdGkn0EV8IuWCgnn70C1E7h+R7YNslv3pnDMrbsQqF1
 33+U18evmTQy8CzXY8Cnku6URwtdm1ysYO+dRZYPyN/f+bNcTISrpfStTiBZcqFCGie45dzJFCc
 9yZbgFG2+4HQqnG220m7KR/jIM
X-Google-Smtp-Source: AGHT+IE2JV8PLZUeJLkFF5nuR+TVxlZMaXQE3TGFcHV/xlnwOwbgFL8dBpBrccYdsKelXoms6rmG8A==
X-Received: by 2002:a05:6000:430a:b0:3a3:648d:aa84 with SMTP id
 ffacd0b85a97d-3a3648dab2fmr15480916f8f.5.1747846306366; 
 Wed, 21 May 2025 09:51:46 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d?
 (p200300ef2f169a00bba9aeb9310bcc0d.dip0.t-ipconnect.de.
 [2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a365bc0b5esm16501890f8f.9.2025.05.21.09.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 09:51:45 -0700 (PDT)
Message-ID: <5b5d35bb-67ef-4a53-b13c-2c8cadd8b6d4@suse.com>
Date: Wed, 21 May 2025 18:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Linux Test Project <ltp@lists.linux.it>
References: <20250521-fixes-modify_ldt-v1-1-1fe46dfd7b89@suse.com>
 <975f1d41-3185-4c96-8833-e23642a8014c@suse.com>
 <97998273-88ad-48ba-95cd-ff80115fdf68@suse.cz>
Content-Language: en-US
In-Reply-To: <97998273-88ad-48ba-95cd-ff80115fdf68@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ldt.h: Fix typo in modify_ldt()
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

TWVyZ2VkLCB0aGFua3MhCgpPbiA1LzIxLzI1IDE1OjEzLCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+
IE9uIDIxLiAwNS4gMjUgMTQ6MzUsIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4+IEhpLAo+Pgo+
PiB0aGFua3MgZm9yIGZpeGluZyBpdC4gQE1hcnRpbiBmZWVsIGZyZWUgdG8gbWVyZ2UgaWYgeW91
IHRoaW5rIGl0J3MgZmluZS4KPgo+IFNvcnJ5LCBJIGRvbid0IGhhdmUgcHVzaCBhY2Nlc3MgdG8g
dGhlIG1haW4gTFRQIHJlcG8uIEFsc286Cj4KPiBSZXZpZXdlZC1ieTogTWFydGluIERvdWNoYSA8
bWRvdWNoYUBzdXNlLmN6Pgo+Cj4KPj4gQWNrZWQtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4+Cj4+IE9uIDUvMjEvMjUgMTM6NDEsIFJpY2FyZG8gQi4g
TWFybGnDqHJlIHZpYSBsdHAgd3JvdGU6Cj4+PiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8
cmJtQHN1c2UuY29tPgo+Pj4KPj4+IEZpeGVzOiA1ZDhjYjVhM2VmMzcgKCJsZHQuaDogQWRkIHdv
cmthcm91bmQgZm9yIHg4Nl82NCIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxp
w6hyZSA8cmJtQHN1c2UuY29tPgo+Pj4gLS0tCj4+PiDCoCBpbmNsdWRlL2xhcGkvbGR0LmggfCAy
ICstCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2xkdC5oIGIvaW5jbHVkZS9sYXBpL2xk
dC5oCj4+PiBpbmRleCAKPj4+IDE3MzMyMWRkOWFjMzRiYTg3ZWZmMGVlZTk2MDYzNWYzMGQ4Nzg5
OTEuLjMzMWYyNWI0NDRhNDhjNGM3ZjE4MzNjMzc2ZmI2OTQwNDAyOTg0NmMgCj4+PiAxMDA2NDQK
Pj4+IC0tLSBhL2luY2x1ZGUvbGFwaS9sZHQuaAo+Pj4gKysrIGIvaW5jbHVkZS9sYXBpL2xkdC5o
Cj4+PiBAQCAtNDYsNyArNDYsNyBAQCBzdGF0aWMgaW5saW5lIGludCBtb2RpZnlfbGR0KGludCBm
dW5jLCBjb25zdCAKPj4+IHN0cnVjdCB1c2VyX2Rlc2MgKnB0ciwKPj4+IMKgwqDCoMKgwqAgaWYg
KHJ2YWwgPiAwICYmIChpbnQpcnZhbCA8IDApIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB0c3Rf
cmVzKFRJTkZPLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIldBUk5JTkc6IExpYmMg
bWlzaGFuZGxlZCBtb2RpZnlfbGR0KCkgcmV0dXJuIHZhbHVlIik7Cj4+PiAtwqDCoMKgwqDCoMKg
wqAgZXJybm8gPSAtKGludCllcnJubzsKPj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJubyA9IC0oaW50
KXJ2YWw7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcnZhbCA9IC0xOwo+Pj4gwqDCoMKgwqDCoCB9
Cj4+PiDCoCAjZW5kaWYgLyogX194ODZfNjRfXyAqLwo+Pj4KPj4+IC0tLQo+Pj4gYmFzZS1jb21t
aXQ6IDVkOGNiNWEzZWYzNzQ5ZWIyNmVlMjJkOTZjOTY1NGJmZGU0MzAzMGYKPj4+IGNoYW5nZS1p
ZDogMjAyNTA1MjEtZml4ZXMtbW9kaWZ5X2xkdC05ZWI5OWFiMTcxZWQKPj4+Cj4+PiBCZXN0IHJl
Z2FyZHMsCj4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
