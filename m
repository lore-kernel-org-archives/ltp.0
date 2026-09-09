Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ADEC79F8C
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788945382; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lgqXZaM0RsKZL3LrWyXZYQHcx7YA+BIM4yLn0X2B6b8=;
 b=aYe8/XYc4myZxyiN76gDG1MVsTdhhQAwEmKo7hJDLwhOxBX11bYZhgDmEHWWWXWA+Covs
 r050xkWcIVEA2joePtuwofxX1/9VtAuP7B/6V2K/vlitw7uO0JLIpku2ZYKUuNmNu/xzjlm
 btMvAMkBraMMb0WGd2SjX0swnRGJD+M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3270A3E72E9
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 11:16:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9119B3E53FB
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 11:16:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B356C1401207
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 11:16:01 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso53392335e9.1
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788945361; x=1789550161; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lmTKxiZWEiIvbIkjdqM4QsoSYPI4bfdZM81uydbuB38=;
 b=AU1oC0yJ9r7GhV6+XmDSsDRqKlZMhg9zVQqciJ0kLA2mLB0n3Pr9gn3efdDjreyaZQ
 pe6dAyHnG3y0iAa0VGw6BHTPwA82gs3fOKPwVtb4lKMrKQHySehEk9Voyk/EqMZDXtMT
 4Y1uF5wff4R9KVHZDyDTCg/0B+MxXmdjflxZc8TlUUkRxZqwzHo87jMxsbnrX614gjhs
 IqGl8kgsulNCNPwah/2LmPr8WdUu/stRnGccX8nd/miepKmgvvIL59WSAtzfkT+RpZHV
 oTzyBITUz4nesA0sjpMSahMkTJwjfKm55bTlOG8Mgz2wwP1CnwKHI/7Bt3QRIUi56WEz
 nH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788945361; x=1789550161;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lmTKxiZWEiIvbIkjdqM4QsoSYPI4bfdZM81uydbuB38=;
 b=P/0d2FUaNlfhwDOdoNBa3vrOzwAJGAVt33heyawPS+aJvSaA2vfeMx8RSdgYhMM5ws
 oFiHMwkeVvRoRyNleUJ37mywZP4QeuJd1puuqJvMNOwXCjLCwZiH13BFQWuYzvhXuboN
 Vtubxr5efb2qGJup0kc3hCpqX9x8RRa4HijXpiViEAaFKGRzVRL/jinMXaWFH70f/IQ6
 UirQYTsQuyMjrj2J8nqFgf0HeeJFcKzbLwqsS1GaeGyHfEDXDGEMtwpb+DUN6iKyi9+c
 mYMOHUxvEBTZ0KuSWZbBGDE9qaoDDdojKv3Vz15B6XxZc7FdHx5238PRWyrieSkUEwez
 bWDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuvsXAWdzBcnPmiTH4nwr01aevb7zg7E/V8EGQSHcvSTlttJlpz9LBZfdP5pZCRCFL+DM=@lists.linux.it
X-Gm-Message-State: AFuF++lUQxmj0SgtKmOsYHV+0f5L4jWsH5gMDU2cqxi1qHM1011Rl6EK
 lo7qr9cCA9BN+4CWeQyDTm36mzkFRjOqvJpINkH5BtFFvOecUVHlG+RuR68leg5/BXDOrA18E+p
 qBOEDaXKBpA==
X-Gm-Gg: AYBFou3XYRjWz4rmo5XDe2/i6E7vNDF/tfdX4lm1+LTbqDD9sPbUDAXq8GY7RPJ7mcg
 eyneqW3dOgZUMfaa93YnH5NP+q5SOJ9zWyKc1X2ieHBHJmMfa5U+Gfq2AtetJryh4GeFUWj3bp/
 JGb6XPiggxyZ9M9Ic/3IjTz4LOdwPiKe6vHXdTGDeMjtDhw5rbXarOGUy0wylOJIcEyK4JSxaQz
 nJdzs9rsMAilx0YY6GjbNidiVhzrQftOwQEjRUNh0g6zVCnTuV8fguABxuAIzvn1w1W6tAPDAhI
 7Mdjwzjoax23zmLDpNgBF9oQOxtHfbgZ9VuNqoVeaspU/tn9BgIuvcv1/9B3DvlPSyGZ4dRVDRP
 a4x+y/flZfbcEv9FG8SHdSKyO32/AcMNoTt29kH0C75seAFzgQM/GfL5dlFuFF4WW+ifkpyM2hp
 lTTBFgrFnUZT/DTORjpblME8tg7rSkUGzie7xH7uxa4+MgHYiusUrLfvSFOwvGNR0mMhq/3HI5o
 z4eDdW422XfcTidlUtrKICoM07N1DDjb9NzXfqXJJkHk0u24iThsAPK9DKIMzfim6yn+SukGXeO
 OtwDaxcFO7IJRRZSpw==
X-Received: by 2002:a05:600c:474c:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-49cf8227619mr309579015e9.5.1788945361027; 
 Wed, 09 Sep 2026 02:16:01 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cc7sm459261605e9.4.2026.09.09.02.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 02:16:00 -0700 (PDT)
Message-ID: <6aa123d0.f6835b30.6e948.fd7f@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aqAwyxICYrC487_p@yuki.lan>
Date: Wed, 09 Sep 2026 09:15:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/2] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgo+IEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGF0IHRoZSBlbGYgaGVhZGVycyBh
cmUgYWxpZ25lZCBwcm9wZXJseSBhbmQKPiBzaW5jZSB3ZSBsb2FkZWQgdGhlIHdob2xlIGZpbGUg
aW50byBhbGlnbmVkIGJ1ZmZlciAobWFsbG9jKCkgYWxpZ25zCj4gcHJvcGVybHkpLCBpdCBzaG91
bGQgYmUgc2FmZSB0byBqdXN0IGNhc3QgdGhlIGRlc2MgcG9pbnRlciBpbnRvIHRoZQo+IHN0cmN1
dCBlbGZfcHJwc2luZm8gKmluZm8gPSBkZXNjOyAgYW5kIGFjY2VzIGluZm8ucHJfbmFtZSBkaXJl
Y3RseSBmcm9tCj4gdGhlIGJ1ZmZlci4KCkkgbWFkZSBhbiBhbmFseXNpcyBhbmQgSSBmb3VuZCBv
dXQgdGhpcyBpcyBub3QgdmFsaWQuCgpJdCBzZWVtcyBsaWtlIHdlIGNhbid0IHVzZSB0aGUgY2Fz
dCBpbiB4ODZfNjQgYmVjYXVzZSBpdCByZXF1aXJlcyBhCjggYnl0ZXMgYWxpZ25lZCBzdHJ1Y3Qu
CgpUaGUga2VybmVsIHdyaXRlczoKCjEyIGJ5dGVzOiBub3RlIGhlYWRlcgogNSBieXRlczogIkNP
UkUiIGFuZCBpdHMgZW5kaW5nIHplcm8KIDMgYnl0ZXM6IHBhZGRpbmcKLS0tCjIwIGJ5dGVzIHRv
dGFsCgpBbHRob3VnaCBtYWxsb2MoKSBhbGlnbnMgdGhlIGJ1ZmZlcuKAmXMgc3RhcnRpbmcgYWRk
cmVzcywgdGhlIGRlc2NyaXB0b3IKaW5zaWRlIGl0IGlzIG5vdCA4LWJ5dGUgYWxpZ25lZC4gRm9y
IGV4YW1wbGU6CgpCdWZmZXIgc3RhcnRzIGF0IGFkZHJlc3M6ICAgIDQwOTYKTm90ZXMgc3RhcnQg
YXQgZmlsZSBvZmZzZXQ6ICA2MjQgICg2NCArIDEwIMOXIDU2KQpGaXJzdCBkZXNjcmlwdG9yIGlz
IGFub3RoZXI6IDIwIGJ5dGVzIGxhdGVyCkRlc2NyaXB0b3IncyBtZW1vcnkgYWRkcmVzczogNDc0
MAoKU28gbWVtb3J5IGlzIG5vdCA4IGJ5dGVzIGFsaWduZWQgYW5kIHdoZW4gd2UgY2FzdCB0byBh
IHBvaW50ZXIgd2UKbWlnaHQgYmUgbWlzYWxpZ25lZCB3aGVuIGFjY2Vzc2luZyBwcl9waWQuCgpX
ZSBzdGlsbCBuZWVkIG1lbWNweSgpLCBzbyB3ZSBtYWtlIHN1cmUgd2UgYXJlIGFjY2Vzc2luZyB0
aGUgcmlnaHQKcG9ydGlvbiBvZiB0aGUgbWVtb3J5LgoKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNF
IFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
