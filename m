Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3007BCCD184
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 10:20:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FFA43CF053
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 12:20:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B85CA3CE837
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 12:19:49 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EEB411A00920
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 12:19:48 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso9134884a12.0
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761041988; x=1761646788; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gu+l/8TW6waxPybBR76EODz5zduFxvfNqqIdmQduktU=;
 b=jpPiwVNUr4Vos89F1F1yU+a9QpgedIi+qqGxaHTmwEO7ydXpvBR9xKKKTnF4PJyExe
 789k35l1HoTWou4VT8e7653Sq5nbPVndW7HWLXspCqfNZU5TSvmaq7oVH3VUUanHhPnL
 W0XPUI/XedJdLGrSjQq3owpEwCStKX5EtfucxMoMpl8yfCxfNqKH39nXsTwJQCH0LqoX
 5ysM0yQr4DqCQtx8DcsliMt0yUyClUF2R6InEp5foBd+uUeGESxWnv4a9+aX1UNps9dG
 COha8H8I8+W2D/cpHvlmGIh3+eGkocyuIteSY2E5Yjl1dziEPrzdkkIuim28EBkVXRac
 LRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761041988; x=1761646788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gu+l/8TW6waxPybBR76EODz5zduFxvfNqqIdmQduktU=;
 b=DRK9jvdtbsBEQgjPvlWtHNNyvy84JCo7fi5f6Nqr5Y0H78THfkG4TTZv8tiL60Kc/X
 a5VI+4FKVZeBrRfNjabK8iTpvNU3TaL1rr9D4KGzJpeRdVdHvNekY5Ar5ptFjJ6kxP/2
 3gRJZ9a0rAkqc1zz7k0LycpXF3JZ9+rmeURqfAun94aIklMNz02lx5pS/i6o0+efo1N8
 /iCXMUU4TRxqvEjyQ3Rtcsc17+Ckezj7IVwBWjdd+YNWScjdsYRi6+WC3Tz8jqODKi2U
 QBvL/AjI+a0suyN+2jvfW87j1esd9y9Gy8mnfTtqFTObEuwfcAy6EDOjyrb3R+GlIXDP
 ZDDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvIZNm1iOQ9n/WluALHiHnWXZRo3Taycw6MjP2oeY67/Is7H1xh4dVxtwSzwmw5u21N58=@lists.linux.it
X-Gm-Message-State: AOJu0YwN7qf6Grw+2eC1I3oUnE1and8CEZKhBP9C0dW6ICW395Fk8o1L
 50PUuuMshbeOwcn1qATE+L2UplZvsNqZqTO9Et6S1RNVMqapNGE6Tlzt7/VUqFNYqx+94vyEqdG
 Y1Lqiq3jA3nJtCJ6hpTFjIG/pbQAr5nM=
X-Gm-Gg: ASbGncv68pFui1QgI5/YFA4WM0xAWlAbSS0/rRK7Qan4vEtccn/D6tOu4uEo7OdQ0yQ
 9LsT7Tp/BONtvDKx4OzDTHEueE4MhofrXFRA3e9aXSeUM41IQfGbbI7De+cuyo9MoyloGjuT/i+
 iSxekXoMwoQ7JAuZ7uftg76zGfsbmQlnhl6uQqf6aES8BTzOFUOlVvk3b//3Qw31jFldifO11dE
 zlmdm21wR7sUoOWOJxVn0zXwhVbBIO4o8lKebX8G60Ilwh1LVMcPfRj9JFb1fbLsjb/2gLZqLTU
 LWAQsSubdjgr13d0hZ9cSJD0roaOKg==
X-Google-Smtp-Source: AGHT+IGU88/JxZMpzVIn7hCaKgN3ZOwedQpJznuQldG4iYWlsbr3wJ87f0XrVYuRDEMrICy4+Y6zi8ctORvmYLlPJfE=
X-Received: by 2002:a05:6402:3255:20b0:63e:8f4:88f6 with SMTP id
 4fb4d7f45d1cf-63e08f48b44mr560562a12.33.1761041988121; Tue, 21 Oct 2025
 03:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251017161639.2088158-1-amir73il@gmail.com>
 <20251020202231.GA416401@pevik>
In-Reply-To: <20251020202231.GA416401@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Oct 2025 12:19:37 +0200
X-Gm-Features: AS18NWCXgLGtBIecCQkjIlbx6Vw-QhLBTYzRqyelllOscXwheld2JoUfwk7dQlM
Message-ID: <CAOQ4uxiaFBi-tpTNFincUS=cwbZahKfPNekhu1Usq=qv-yrJ-A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify24: Verify expected count/offset info in
 pre content events
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
Cc: Kiryl Shutsemau <kas@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBPY3QgMjAsIDIwMjUgYXQgMTA6MjLigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBBbWlyLCBhbGwsCj4KPiA+IFRvIHRlc3QgZml4IGNvbW1pdCAy
OGJiYTJjMjkzNWUyICgiZnNub3RpZnk6IFBhc3MgY29ycmVjdCBvZmZzZXQgdG8KPiA+IGZzbm90
aWZ5X21tYXBfcGVybSgpIiksIGRpdmVyc2lmeSB0aGUgb2Zmc2V0cyBhbmQgY291bnQgdXNlZCBm
b3IgbW1hcCgpCj4gPiB3cml0ZSgpIGFuZCByZWFkKCkgYW5kIHZlcmlmeSB0aGF0IHRoZSBGQU5f
UFJFX0FDQ0VTUyBldmVudHMgcmVwb3J0IHRoZQo+ID4gZXhwZWN0ZWQgY291bnQvb2Zmc2V0Lgo+
Cj4gPiBGb3IgdGhlIEZBTl9QUkVfQUNDRVNTIGV2ZW50cyBnZW5lcmF0ZWQgYnkgZXhlY3ZlKCks
IHdlIGNhbm5vdAo+ID4gYW50aWNpcGF0ZSB0aGUgZXhhY3QgcmFuZ2VzLCBzbyB3ZSBzZXQgMCBj
b3VudCB0byBza2lwIHRoaXMgdmVyaWZpY2F0aW9uLgo+Cj4gPiBBbHNvIGFkZCBwcmludHMgb2Yg
cGF0aCBvZiB0aGUgZmQgcGFzc2VkIHdpdGggdGhlIGV2ZW50IChub3QgdmVyaWZpZWQKPiA+IGFn
YWluc3QgZXhwZWN0ZWQgcGF0aCkuCj4KPiA+IE1ha2Ugc3VyZSB0aGF0IHdlIHRha2UgdGhlIGV4
cGVjdGVkIGVycm9yIHZhbHVlIGZvciBhbiBvcGVyYXRpb24KPiA+IChlLmcuIHJlYWQpIGZyb20g
YSBtYXRjaGluZyBldmVudCB0eXBlIChlLmcuIEZBTl9QUkVfQUNDRVNTKS4KPgo+IFRoYW5rcyBm
b3IgdGhlIHVwZGF0ZS4gIExHVE0sIGJ1dCBpdCdkIGJlIGdyZWF0IGlmIHNvbWUgb2Yga2VybmVs
IGRldmVsb3BlcnMKPiBhbHNvIGhhZCBsb29rIGludG8gaXQuIEZldyBtaW5vciBub3RlcyBiZWxv
dy4KPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IEkgYWxz
byByZXN0YXJ0ZWQgZmFpbGluZyBqb2JzIGluIGdpdGh1YiBhY3Rpb25zOgo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2FjdGlvbnMvcnVucy8xODU5OTgxMjQ4Mgo+
Cj4gVW5mb3J0dW5hdGVseSBkdWUgcGF0Y2h3b3JrIEFQSSBsaW1pdGF0aW9uLCB0aGUgZmFpbGlu
ZyBqb2JzIGFyZW4ndCByZXBsYWNlZAo+IHdpdGggc3VjY2Vzc2Z1bCBvbmVzLCBpbnN0ZWFkIHRo
ZSBmaXhlcyBhcmUgYXBwZW5kZWQ6Cj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L2x0cC9wYXRjaC8yMDI1MTAxNzE2MTYzOS4yMDg4MTU4LTEtYW1pcjczaWxAZ21haWwuY29t
Lwo+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29t
Pgo+ID4gLS0tCj4gPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMg
ICAgIHwgMTY3ICsrKysrKysrKysrLS0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDcgaW5z
ZXJ0aW9ucygrKSwgNjAgZGVsZXRpb25zKC0pCj4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyNC5jCj4gPiBpbmRleCAyN2YwNjYzY2UuLjhmMmRl
ZTU1YiAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkv
ZmFub3RpZnkyNC5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MjQuYwo+ID4gQEAgLTksNiArOSw4IEBACj4gPiAgLypcCj4gPiAgICogLSBUZXN0
IGZhbm90aWZ5IHByZS1jb250ZW50IGV2ZW50cwo+ID4gICAqIC0gVGVzdCByZXNwb25kIHRvIHBl
cm1pc3Npb24vcHJlLWNvbnRlbnQgZXZlbnRzIHdpdGggY3V0c29tIGVycm9yIGNvZGUKPiA+ICsg
KiAtIFRlc3QgY291bnQvb2Zmc2V0IGluZm8gYnVnIHRoYXQgd2FzIGZpeGVkIGJ5IGNvbW1pdAo+
ID4gKyAqICAgMjhiYmEyYzI5MzVlMiAiZnNub3RpZnk6IFBhc3MgY29ycmVjdCBvZmZzZXQgdG8g
ZnNub3RpZnlfbW1hcF9wZXJtKCkiCj4gPiAgICovCj4KPiA+ICAjZGVmaW5lIF9HTlVfU09VUkNF
Cj4gPiBAQCAtNDQsNiArNDYsOCBAQAo+ID4gICNkZWZpbmUgRklMRV9FWEVDX1BBVEggTU9VTlRf
UEFUSCIvIlRFU1RfQVBQCj4KPiA+ICBzdGF0aWMgY2hhciBmbmFtZVtCVUZfU0laRV07Cj4gPiAr
c3RhdGljIGNoYXIgc3ltbG5rW0JVRl9TSVpFXTsKPiA+ICtzdGF0aWMgY2hhciBmZHBhdGhbQlVG
X1NJWkVdOwo+ID4gIHN0YXRpYyBjaGFyIGJ1ZltCVUZfU0laRV07Cj4gPiAgc3RhdGljIHZvbGF0
aWxlIGludCBmZF9ub3RpZnk7Cj4gPiAgc3RhdGljIHNpemVfdCBwYWdlX3N6Owo+ID4gQEAgLTU1
LDYgKzU5LDggQEAgc3RhdGljIGNoYXIgZXZlbnRfYnVmW0VWRU5UX0JVRl9MRU5dOwo+ID4gIHN0
cnVjdCBldmVudCB7Cj4gPiAgICAgICB1bnNpZ25lZCBsb25nIGxvbmcgbWFzazsKPiA+ICAgICAg
IHVuc2lnbmVkIGludCByZXNwb25zZTsKPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgcGdjb3VudDsK
PiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgcGdvZmY7Cj4gPiAgfTsKPgo+ID4gIHN0YXRpYyBzdHJ1
Y3QgdGNhc2Ugewo+ID4gQEAgLTY4LDExICs3NCwxMSBAQCBzdGF0aWMgc3RydWN0IHRjYXNlIHsK
PiA+ICAgICAgICAgICAgICAgSU5JVF9GQU5PVElGWV9NQVJLX1RZUEUoSU5PREUpLAo+ID4gICAg
ICAgICAgICAgICBGQU5fT1BFTl9QRVJNIHwgRkFOX1BSRV9BQ0NFU1MsCj4gPiAgICAgICAgICAg
ICAgIHsKPiA+IC0gICAgICAgICAgICAgICAgICAgICB7RkFOX09QRU5fUEVSTSwgRkFOX0FMTE9X
fSwKPiA+IC0gICAgICAgICAgICAgICAgICAgICB7RkFOX1BSRV9BQ0NFU1MsIEZBTl9BTExPV30s
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAge0ZBTl9QUkVfQUNDRVNTLCBGQU5fQUxMT1d9LAo+
ID4gLSAgICAgICAgICAgICAgICAgICAgIHtGQU5fUFJFX0FDQ0VTUywgRkFOX0RFTllfRVJSTk8o
RUlPKX0sCj4gPiAtICAgICAgICAgICAgICAgICAgICAge0ZBTl9PUEVOX1BFUk0sIEZBTl9ERU5Z
X0VSUk5PKEVCVVNZKX0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7RkFOX09QRU5fUEVSTSwg
RkFOX0FMTE9XLDAgLDB9LAo+IG5pdDogc3BhY2UgaXMgdXN1YWxseSBiZWZvcmUgY29tbWEsIG5v
dCBhZnRlci4gSSdsbCBmaXggaXQgYmVmb3JlIG1lcmdlLgo+IEkgYWxzbyBwcmVmZXIgdG8gdXNl
IGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXJzIHdoZW4gdGhlcmUgYXJlIG1vcmUgc3RydWN0IG1lbWJl
cnMKPiBhbmQgc29tZSBvZiB0aGVtIGFyZSB6ZXJvLiBCdXQgaXQncyB1cCB0byB5b3UsIG9yIEkg
Y2FuIGNoYW5nZSBpdCBsYXRlciBpbiBhCj4gc2VwYXJhdGUgcGF0Y2guCj4KClBsZWFzZSBjaGFu
Z2UgaXQgbGF0ZXIuCgpUaGFua3MhCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
