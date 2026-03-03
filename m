Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69E1EC1430
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 11:32:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56B473DA1A9
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 12:32:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17D673D900A
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 12:31:49 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B286600BCB
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 12:31:48 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65c5a7785b4so8028101a12.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 03:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537508; cv=none;
 d=google.com; s=arc-20240605;
 b=hXE8LNG9sga9vqcw6HBC9FIjPd5G4GimjaGMzDMVpB9a4XT6M2Hze61O5WjKOmdz1Y
 Gr/WNw9HuOZH/i7MJqotaw5R1we6N4tOGA1LdqcH19V16u3VPBgQAZW3QZnl+tdHjOJN
 hoqy/3uEXq9ZliOOht836e0Bl2kE/lCl37WyU3IoEjOpuDfBgfhKbITzjcXdysmkNhBT
 VKgVlF74w37WHjFu0xz5QZ/RtxjedXiqsJ2Q4q8l8wHuHL6fwmfk0n4tXCZJWg4fpChl
 brULy38CKV1Bj/XLiiLMH8dUs+yWGZb30Tkqi+XR7QAASksTYweRQxlzMviljwyX22gw
 227w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dQXrCwiWVNHVqhdzwmWlK6iTPPdCKxmsCBBKowt3e7I=;
 fh=ZTCwY+NM0BPYz9vZyRaVQMTdiZ0zqJfTjloOAj+sMXg=;
 b=c+pR5MiUr1pjTLJknvjPPdgzRvNLCU2zf63fo66KHw+ExZo2ySB4FYIPvfZvZvIlbo
 3iVT4+E9ZNLRkw6bsez13FmO6UTfWySdAXX7TJ4ZtHgvtkr5BzOf3KQZxcK0rsF3xjo1
 YqnQ/Nqzw5AEWT5zaw7CVRrPtjMuB26P+AUf7K029Qs5HSh/ohLGsX6w3mzu+5iuy9Hx
 qH67fUi6dGJ8xY/u4H8vUYopvRfREc7ifOrlntlor38kWA2eB8kocJpxeLzNIDzBL2/i
 zXsmvbl89j8OJ+R3rjtkQrPqAkECNO2dyumkpwvZ6vl4FX6F4yE8IvQI0/QyK9n5yp4c
 f2Yg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772537508; x=1773142308; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQXrCwiWVNHVqhdzwmWlK6iTPPdCKxmsCBBKowt3e7I=;
 b=ijZ90CjTYzMh5G+yiUprUrzpXo3QnUscOnbfwhCctFvwi9kvN6BhfKqZP/+z6Eckv8
 2himg9AM6oSoORShjSOtm68+P4ufXKm31KAPJLIjrMN15C997SbXNOi+O2LFXKAUyswd
 kny/+JXLKtzRu+d5MHp7mzUUshnxG8WnVdXczWBkiTr+G1rCEK07i46hnU6jfsfWBnBz
 Gj/7SdWRQqLtgX+QeF1B2wUUl7Xh7er3unu91W08vusStKA3/dZziSM9HmupiFxlgVpA
 T8wd2QiBj4g7DkIloF+FPTH3YHvJmgfIIUDksxdN+hzBEAWvn7eOx4TOfKah1C4leCxf
 o1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537508; x=1773142308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQXrCwiWVNHVqhdzwmWlK6iTPPdCKxmsCBBKowt3e7I=;
 b=mwzGr+Jj59k4qfYjRFYUAfOGIBUJ2GjxspKg+AvP9/aSvKn88eEWOsWkrP/hP25Ktg
 T6ZsMGZ3YojPHsWpiSKXTXhEuTDLaZ2twTEG8vW50CJDe8EXqt+BkhTbqBQE76INA3nZ
 fp8VANWNRJAGR9T87XOfJLs/cCJPrdWaL1INwcZPlobtcEDEJFd5tmWAzYg29tuVpfW7
 CFr23wAoAMi8TXGod+sszwZm5hE/BD5ngSAAcwac89twyTP3ZMBq/BlCYKvzU/OVQ/Qb
 dvE+AC1/w3XNdDtiBU6CEXD4v3ipoEf+dAzdqSqhXjW+KyhNM4cfQgA4MuGJ1FaRjj0Q
 cQNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZU3aEnOHWTLnMpgaHlOo8jsgC5yMHw7rS+VnZZKxOGLoS9jeTUeQCvJGVKcZa72Wt8OY=@lists.linux.it
X-Gm-Message-State: AOJu0Ywgf3fzcV250fEL3DiexTwM5qr26zxmuJAUzRpTeN9BIHggeoBd
 JBiuD2m8muCMLUTUayeIMJkQL+dunx+oIy4r0izqNhDBk250yiuuPU6AB19md9/GYom2blnxJRj
 oZyynkHhLTrUnXiZibn8ANxmZLv3/GZetwMI7
X-Gm-Gg: ATEYQzwU9MLVL9oiMRirllj6qTaCWrVwj+hUfrOzK16Qg7qMp8khI24DIsuvOh1ugpI
 V81wKPwpHa1q8qlk6InFa1fLCEQz1/WB+W+mDTxa2s5gvh/8fFUCy1UqYXbCjXvxb3EGC75/U3J
 +1X1DN2r7Mn3oItgMbhBkAr0vden7y4jLToCr2w02sU1TdxdjLgNvjO2Jqr4FkgJJUHiEnTpkSP
 izb2UoaU6ty55RXXUklB2TQIuG0+jWi9QO4GcGBVf1Lb1myFZk4Ju061sFJt8Jw3UShzK8Xr0xj
 5z3UEJl1HwYUzlCuCNiQ4dnMQawvO7bApZ1SWfx0
X-Received: by 2002:a17:907:7255:b0:b8d:7172:1948 with SMTP id
 a640c23a62f3a-b937639b970mr1049581066b.13.1772537507393; Tue, 03 Mar 2026
 03:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20260302144446.1291724-1-amir73il@gmail.com>
 <aaWvOIlfyIDH7J8A@yuki.lan>
 <CAOQ4uxhpcC76cpj21Dv-279FnVgHLSjCXmYKxu526jV-Uo7G_w@mail.gmail.com>
 <10488dc1-a369-4ad1-b26b-23118f6c9801@suse.cz>
 <CAOQ4uxhqubq4wy8Y5TkOVgtU0VgTcztJnrbycVC=idO_-XbKww@mail.gmail.com>
 <65ea5139-5b0b-41c0-9262-403b9a75fe35@suse.cz>
 <CAOQ4uxgpzhh3a4sDk5LVHP5MC+vPVRWTFNa551xYYu6pCsdSGg@mail.gmail.com>
 <13f0f6bc-425c-4f8a-a03e-805ed9886de8@suse.cz>
In-Reply-To: <13f0f6bc-425c-4f8a-a03e-805ed9886de8@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 12:31:35 +0100
X-Gm-Features: AaiRm52F49v3VpEgmLDSR0Hz2HhUF_Ms4UML1Vn6Nf1a4JxGiexM-MmInskbQLU
Message-ID: <CAOQ4uxiJZJM3fiMk+ipXw8iT-cu-uaG4pa=VEUEDG7zeXWvJSQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: fix test failure on kernel with
 CONFIG_MODULES=n
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMywgMjAyNiBhdCAxMTo1MOKAr0FNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBPbiAzLzMvMjYgMTE6MTAsIEFtaXIgR29sZHN0ZWluIHdyb3Rl
Ogo+ID4gT24gVHVlLCBNYXIgMywgMjAyNiBhdCAxMDo1OeKAr0FNIE1hcnRpbiBEb3VjaGEgPG1k
b3VjaGFAc3VzZS5jej4gd3JvdGU6Cj4gPj4gSSd2ZSB3cml0dGVuIHRoZSB0ZXN0IHRvIHRlc3Qg
YSBzcGVjaWZpYyBmYW5vdGlmeSByZWdyZXNzaW9uLiBUcmFjaW5nIGEKPiA+PiBzeXNjYWxsIHRo
YXQgZ2V0cyBjYWxsZWQgdG9vIG9mdGVuIGNvdWxkIGluY3JlYXNlIHN5c3RlbSBsb2FkIGFuZCBj
aGFuZ2UKPiA+PiB0aW1pbmcgb2YgdGhlIHJhY2Ugd2hpY2ggSSdtIHRyeWluZyB0byB0cmlnZ2Vy
IHdpdGggaXQuCj4gPj4KPiA+Cj4gPiBXaGljaCBmYW5vdGlmeSByZWdyZXNzaW9uPwo+ID4gQXMg
YSByZXZpZXdlciwgSSBnb3Qgbm8gaW5kaWNhdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsCj4g
PiBUZXN0IGRlc2NyaXB0aW9uLCBub3IgaW4gTFRQIHRzdF90ZXN0IHRhZ3MgdGhhdCB0aGlzIGlz
IGEgdGVzdCBmb3IgYSByZWdyZXNzaW9uLgo+ID4KPiA+IEkgaGF2ZSBubyBvYmplY3Rpb24gd2hh
dHNvZXZlciB0byB1c2luZyBhbnkgb3RoZXIgc3ltYm9sIGF2YWlsYWJsZQo+ID4gaW4gbW9zdCBv
ZiB0aGUgY29tbW9uIGJ1aWxkcy4KPiA+IEFsdGVybmF0aXZlbHksIHRoZSB0ZXN0IGNvdWxkIHRl
c3QgZm9yIHRoZSBkZXNpcmVkIGNvbmZpZ3VyYXRpb24uCj4gPgo+ID4gQnV0IGlmIHRoZSB0ZXN0
IGlzIG1lYW50IHRvIHRyYWNrIGEgcmVncmVzc2lvbiwgdGhlbiAqcGxlYXNlKiBkb2N1bWVudAo+
ID4gdGhlIHJlZ3Jlc3Npb24gaW4gdGhlIHRlc3QgZGVzY3JpcHRpb24gYW5kIHRoZSBmaXggY29t
bWl0IGlmIHN1Y2ggZml4Cj4gPiBleGlzdHMgaW4gTFRQIHRzdF90ZXN0IHRhZ3MuCj4KPiBUaGUg
cmVncmVzc2lvbiBpbiBxdWVzdGlvbiB3YXMgbm90IGluIHVwc3RyZWFtIGJ1dCBhIGJyb2tlbiBi
YWNrcG9ydCBpbgo+IGEgY3VzdG9tIGtlcm5lbCBicmFuY2guIEl0IHdhcyBmaXhlZCBieSByZXZl
cnRpbmcgdGhlIGJhY2twb3J0ZWQgcGF0Y2guCj4gU28gd2hpbGUgdGhlIHRlc3Qgd2lsbCBiZSB1
c2VmdWwgZm9yIGRldGVjdGluZyBzaW1pbGFyIHJlZ3Jlc3Npb25zIGluCj4gdXBzdHJlYW0sIHRo
ZXJlIGlzIG5vdGhpbmcgSSBjYW4gcHVibGljbHkgZG9jdW1lbnQgYWJvdXQgaXQuCj4KCkZhaXIg
ZW5vdWdoLCBidXQgd2hlbiBjaG9vc2luZyB0aGUgZnVuY3Rpb24gdG8gdHJhY2UsIHBsZWFzZQpk
b2N1bWVudCB0aGUgcmVhc29uIGZvciBjaG9vc2luZyB0aGlzIGZ1bmN0aW9uIGFuZCBkb2N1bWVu
dAp0aGUgZmFjdCB0aGUgZXhwZWN0YXRpb24gdGhhdCB0aGlzIGV2ZW50IHdpbGwgbm90IGJlIHRy
aWdnZXJlZCBkdXJpbmcgdGhlCnRlc3Qgb3Igd2lsbCBub3QgYmUgdHJpZ2dlcmVkIHRvbyBmcmVx
dWVudGx5LCB3aGljaGV2ZXIgaXMgdGhlIGNhc2UuCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
