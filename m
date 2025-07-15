Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251C8C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752568863; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=0afzV+bRU96cMO76wDCCohm9seps4Ldn1hj9fPPUW3w=;
 b=O0GX4cyonLhk3obAmTgj6M6WVA1LFL0Ae/hh/EdoZtcagfh/WE9KzFV17viYYWpweoewz
 c/aB5xSqELxSgGKt8Nz8TL7uvbny5KWrXA+lU3m0UpFqqREc7EcLkeBlgXKpseejLCsZe9s
 UQhZPvdyDcb/JSbLxYX4O5YE4drvBg0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDDC3CCC7E
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:41:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 784233CCB72
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:40:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C37A210000CD
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:40:41 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso37331995e9.2
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752568841; x=1753173641; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FNuyznZTGK0fHpjCfMAv4uhhAdQMfxbAWJF4s2uDeLU=;
 b=PAlbMMNEDTVnjc6aZM6yOHb0Fes8tM9PjLltvjVeRMHU3KLN7GuJXjpk//DutbDrkt
 qbha6EnYIFPlWmQyy6KGJkT55Tx1j7bmRwSGvH5NYGCANEe8gdLqhJQZs7sqfu8IG5p4
 NuZpqI0ISU6iotsS6ToDgeuV1qbma01rKH+IlxNpVbqwAznv3m9Z1RzEF74K+0s8FDWd
 qp4ddAVlf9Hccv3GVHyYXMtQ9i6/5AY9DkEDXATFCOa4lKM0mVW7KE4XzF8sjja6XeFU
 ovX/EZ+lauaJvi9u+4DBkkE3kJ64d8OeWGUEoYuvccIIvVVie/MUPNjWZpknr+D+vYcb
 Pqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752568841; x=1753173641;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FNuyznZTGK0fHpjCfMAv4uhhAdQMfxbAWJF4s2uDeLU=;
 b=af++eFcKziR11LDh8KUdBGsEHAJWBvulsjT3/ZbUkZ0FqmhIfgzia1qUbzbJZYBq4s
 NIw176UjcSqiJDV1ZbvfXOqt12mDL8Ze4uGYDk+ALAJuI0i4Jeb8jzVkhrHtRhexpNvC
 5tTnirnmneWbeP/6y3BzxPjRXZ3fZRYphTK3HaC1wHTGWiA/ALBLJg8jv6H4bFLlY2HS
 bQVQ3eY+0aK5ORB8FoRTZv4KqOfNgQS93afW/GKHVicctROpugZAaSyZIsA4mHkXOXhl
 i36HzANvecRTbw8OogiN/A2trxC64378JCz7lPZBTW/bcR28Rk+jSRyAcDQ5qtBsZFLS
 bQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViS0hph+clSjxNmu8ES9yQSPJSSV+PpsrJzGsacRlAQbdyMeEDUcp5bQh6Sn1BitN0dcI=@lists.linux.it
X-Gm-Message-State: AOJu0YwF0WlxOeY+zjEAMQ1lvCRH+hvYM3QLiCnoytObznaNpQm7sAO2
 +cIKrB85aaY3NVxYYwwJOUbMyGD9uy4Ku4M6lpjyeNkvvHb+tjnVDnu5BzLPwiOnhK9ps7EILHH
 U9CXavCY=
X-Gm-Gg: ASbGncsyP98lcY8GQZGUtoPA8XkWlWdK06AJJl4bIZfPSsxHHYbOA8dxkUPl3az6N8R
 w+XL/FIU9X3K9htLyKnwrJ1qQoer+sTRvkrBRpTybnvbUeY208GLTBRtMPUqnNJFf/oJlzLa5Ri
 MwqXHhJwj1VJArQ4yuj7F04VufBLkC3Ijp/jYsCrEtnuVf0Gme2WZ9KMIntg07GYyz9GAQREvAc
 ZMgQ6kivMilFxx30ECLdQ+8HnvJVHqnDIhuzM8mk8255+ipUFF5qnKEbvvwUegF7At6FhriGmeA
 L/K8gxsW6VQWH2Eb8+hmqqQ4vr+fLEdN0djM/4bqM3V6hFuCafFmhxnn2XZ8j+0VMhew/GpkJBT
 yFKyqbXMyMrKqanFc3EhAdw6zCWE+I3tQFu1ftplc7tuUld5lVeI5T7vOoxcZSsOLKkZo5VBZoK
 DBD/gdd/mjIRjjjEPSWeJHAlT9hrSzgHO5+ql8UQSLU2CYs/q+2dzmHOmWkF0EOQ==
X-Google-Smtp-Source: AGHT+IEM9d2TvnRPbu4w2Jiqfh0uR0X2hUswduTrbrYK2/HEw6523azh2gBXnqBNxRLUYGY6a+ugcA==
X-Received: by 2002:a05:600c:1382:b0:453:7713:546a with SMTP id
 5b1f17b1804b1-454ec16cd4bmr162053505e9.14.1752568841163; 
 Tue, 15 Jul 2025 01:40:41 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm14287346f8f.46.2025.07.15.01.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:40:40 -0700 (PDT)
Message-ID: <dc3fb6d5-0914-42c5-8b4a-579f7c6f21a3@suse.com>
Date: Tue, 15 Jul 2025 10:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250702-conversions-kill12-v1-1-4ba219bbfe52@suse.com>
Content-Language: en-US
In-Reply-To: <20250702-conversions-kill12-v1-1-4ba219bbfe52@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill12
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

SGkhCgpPbiA3LzIvMjUgNDoxMyBQTSwgUmljYXJkbyBCLiBNYXJsacOocmUgdmlhIGx0cCB3cm90
ZToKPiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+Cj4gVGhlIHRl
c3Qgc2NlbmFyaW8gaXMgYWxyZWFkeSBjb3ZlcmVkIGluIGtpbGwxMS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gSGVsbG8sCj4K
PiBhZnRlciBjb252ZXJ0aW5nIHRoaXMgdGVzdCB0byB0aGUgbmV3IEFQSSB3ZSBoYXZlIHRoaXM6
Cj4KPiBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiB7Cj4gCWludCBwaWQ7Cj4gCWludCBzdGF0dXM7
Cj4KPiAJZm9yIChpbnQgc2lnID0gMTsgc2lnIDwgMTQ7IHNpZysrKSB7Cj4gCQkvKiBTSUdLSUxM
IGFuZCBTSUdTVE9QIGNhbid0IGJlIGNhdGNoZWQgKi8KPiAJCWlmIChzaWcgPT0gU0lHS0lMTCB8
fCBzaWcgPT0gU0lHU1RPUCkKPiAJCQljb250aW51ZTsKPgo+IAkJcGlkID0gU0FGRV9GT1JLKCk7
Cj4gCQlpZiAoIXBpZCkgewo+IAkJCVNBRkVfU0lHTkFMKHNpZywgU0lHX0lHTik7Cj4gCQkJVFNU
X0NIRUNLUE9JTlRfV0FLRSgwKTsKPiAJCQlfZXhpdCgxKTsKPiAJCX0KPgo+IAkJVFNUX0NIRUNL
UE9JTlRfV0FJVCgwKTsKPgo+IAkJU0FGRV9LSUxMKHBpZCwgc2lnKTsgLyogY2hpbGQgc2hvdWxk
IGlnbm9yZSB0aGlzIHNpZyAqLwo+IAkJU0FGRV9XQUlUKCZzdGF0dXMpOwo+Cj4gCQlUU1RfRVhQ
X0VRX0xJKFdURVJNU0lHKHN0YXR1cyksIDApOwo+IAkJVFNUX0VYUF9FUV9MSShXSUZFWElURUQo
c3RhdHVzKSwgMSk7Cj4gCX0KPiB9Cj4KPiBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7
Cj4gCS50ZXN0X2FsbCA9IHJ1biwKPiAJLmZvcmtzX2NoaWxkID0gMSwKPiAJLm5lZWRzX2NoZWNr
cG9pbnRzID0gMSwKPiB9OwoKSSBndWVzcyB0aGUgcmVhc29uIHdoeSBraWxsMTIgaXMgc3RpbGwg
dGhlcmUgaXMgdGhhdCB3ZSBhcmUgYWxzbyB0ZXN0aW5nIApzaWduYWxzIHdoaWNoIHdlcmUgbm90
IGRlZmluZWQgaW4gYmV0d2VlbiAxLTE0LgpBcyBmYXIgYXMgSSBzZWUsIG5vd2FkYXlzIGl0IG1h
a2VzIHNlbnNlIHRvIHJlbW92ZSBraWxsMTIuCgpAQ3lyaWwgV0RZVCA/CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
