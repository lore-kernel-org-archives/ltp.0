Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE21E7718B
	for <ltp@archiver.kernel.org>; Wed, 25 Dec 2024 11:39:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E9A63E558E
	for <ltp@archiver.kernel.org>; Wed, 25 Dec 2024 12:39:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A9973E271E
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 12:38:57 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D9F4638308
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 12:38:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735126730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=79cTYVg8W0j4RmEE4HngHeiYR9PhZjfrcuTPI9mYId0=;
 b=eYn3jcQl/3ispqUM9xWrRU/53vPok0+T2YT9RN9+tUoHplpBVwUhOtTOARgTrMz2JRRgen
 nhZZHq57srFmcSJ7NlePsAImOBmL8vyDhp4W+HRruwY+LdH84fhbq8VoNDvdOBU4cE6X2T
 AV6AOetG/eeUnUBcfXuhs2Oxv+OeXlk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-hLSG8KD6MxmLur-1f91uaA-1; Wed, 25 Dec 2024 06:38:47 -0500
X-MC-Unique: hLSG8KD6MxmLur-1f91uaA-1
X-Mimecast-MFC-AGG-ID: hLSG8KD6MxmLur-1f91uaA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2efa74481fdso6584668a91.1
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735126727; x=1735731527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79cTYVg8W0j4RmEE4HngHeiYR9PhZjfrcuTPI9mYId0=;
 b=W/K5aawlWZkhNgBx012O163ZH1/Z9vVX4hjtuZgK9Q/rIz9TexjMyvITNatECy7zsN
 u9dHzoOu6QDc+4GHvvLFct0Wo0FyQrmoTD2wtMyHOmkw5BXjXYucULFXFwR/TWoGIbyx
 2tyyq1SR8WcO5yB6P38vqXogvdwh3UbpK2el3gX661orJZxV0ittHNEEcAHxLuDtH4rV
 hFLmFKWqr9hhHbazp63+hf420/T5JdIb2nLRd7OfpbgE7mcCMJDVFTY74NdHBTwbwcHP
 bXCYRiCv9cENafD/FHxOmR3Uk89y3iF6U5VjfgSPdORY0xYH/Fy0OuAEArIt2+RgHdSg
 FT+Q==
X-Gm-Message-State: AOJu0YwMAp4SZgigIxtFYn8UQ++oUpmG5Sc1W8XDTtiZJ4XmS8niX2ky
 26jSygi847IW0HmE/zIZuQCYXoPd7GjPmBXsSBvdw0n7Z9Dp+M620jsyuEyriKa5uzbYvZAOAJ9
 smgIbhNMv4ccVpdtc5jVRKvggtuk7KClHzHljcmWOzdEmVOE/dxkQ3pQaFFtgcigeKwJZOkjgLn
 V15SafCvT1QajUv3OStDSViKw=
X-Gm-Gg: ASbGncuFj2CLwnF2eJTCDv7DWt961Q6KSHBWqIEK3LuoJ59nA/KKCORNNuUhj0z39yx
 sYb6v7Snhb+icWdtQZGjdW1cbjfqswzofhWtk2KE=
X-Received: by 2002:a17:90b:54c3:b0:2ee:8439:dc8 with SMTP id
 98e67ed59e1d1-2f452ee6374mr26429312a91.34.1735126726818; 
 Wed, 25 Dec 2024 03:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIpsTIbvwe6h14HEo5eBOQAN8iu8r9+o30ZKCd/23Rb43ByPK4LdPTn4/Dr/T9nmHGxwmGj6/awcZXVWCBeOc=
X-Received: by 2002:a17:90b:54c3:b0:2ee:8439:dc8 with SMTP id
 98e67ed59e1d1-2f452ee6374mr26429290a91.34.1735126726452; Wed, 25 Dec 2024
 03:38:46 -0800 (PST)
MIME-Version: 1.0
References: <31564d54-4fea-4450-997d-45e14c4957f4.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSO4HM9aBWEyCszC3-VrYvyv5DCs2ofaheHpsw0j7jiXQ@mail.gmail.com>
In-Reply-To: <CA+B+MYSO4HM9aBWEyCszC3-VrYvyv5DCs2ofaheHpsw0j7jiXQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Dec 2024 19:38:32 +0800
Message-ID: <CAEemH2cFissakwU4N7s+XPLrWvZu4Do5nsEZ8aFohP7zA-TVyg@mail.gmail.com>
To: Jin Guojie <guojie.jin@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _msrPQ9OmejAJq6uMLC_ngWl9394W629LsF3qchPHDA_1735126727
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it,
 Richard Palethorpe <richard.palethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmluLAoKT24gVGh1LCBEZWMgMTksIDIwMjQgYXQgMjowOeKAr1BNIEppbiBHdW9qaWUgPGd1
b2ppZS5qaW5AZ21haWwuY29tPiB3cm90ZToKCj4gVjI6Cj4gKiBDaGFuZ2UgdGhlIGV4cGVjdGVk
IGV2ZW50cyBpbiBGIGRlcGVuZGluZyBvbiBtZW1vcnlfcmVjdXJzaXZlcHJvdAo+Cj4gSW4gUGF0
Y2ggdjFbMV0sIHRoZSByb2xlIG9mIHJlY3Vyc2l2ZV9wcm90ZWN0aW9uIGluIGNnb3VwIHYyIHdh
cyBub3QKPiBjb25zaWRlcmVkLgo+Cj4gQnkgY2FyZWZ1bGx5IHJlYWRpbmcgdGhlIGFsZ29yaXRo
bSBpbiB0aGUga2VybmVsIGZ1bmN0aW9uCj4gZWZmZWN0aXZlX3Byb3RlY3Rpb24oKS4gV2hlbiBt
ZW1vcnlfcmVjdXJzaXZlcHJvdCBpcyBlbmFibGVkLCBhCj4gc3ViZ3JvdXAgd2l0aCB1c2FnZSA+
IDAgY2FuIGdldCB1bmNsYWltZWQgZ3JlYXRlciB0aGFuIDAuCj4KPiBUaGUgcHVycG9zZSBvZiBk
b2luZyB0aGlzIHNob3VsZCBiZSB0byBhY2hpZXZlIHRoZSBlc3NlbnRpYWwgcHVycG9zZQo+IG9m
IHJlY3Vyc2l2ZV9wcm90ZWN0aW9uOiB0aGUgc3VtIG9mIGFsbCBzdWJncm91cHMnIHVucHJvdGVj
dGVkIHZhbHVlcwo+IGlzIGVxdWFsIHRvIHBhcmVudCdzIHVucHJvdGVjdGVkIHZhbHVlcy4KPgo+
IEV2ZW4gdGhvdWdoIHRoZSBkb2N1bWVudGF0aW9uIGRvZXMgbm90IGdpdmUgYW4gZXhwbGljaXQg
ZGVzY3JpcHRpb24KPiBmb3IgcmVjdXJzaXZlX21lbW9yeXByb3QsIGl0IGxvb2tzIGxpa2UgdGhl
IGtlcm5lbCdzIHByb2Nlc3NpbmcKPiBhbGdvcml0aG0gaXMgcmVhc29uYWJsZS4KPgo+IEJhc2Vk
IG9uIHRoZSBpZGVhIG9mIFsyXSwgUGF0Y2ggdjIgaXMgcmV3cml0dGVuIHRvIGRldGVybWluZSB3
aGV0aGVyCj4gbWVtb3J5X3JlY3Vyc2l2ZXByb3QgaXMgZW5hYmxlZC4KPgo+IE9uIGRpc3RyaWJ1
dGlvbnMgd2l0aCBtZW1vcnlfcmVjdXJzaXZlcHJvdCBlbmFibGVkIGJ5IGRlZmF1bHQgKGZyb20K
PiBVYnVudHUgMjIuMDQgdG8gMjQuMTApLCBydW5uaW5nIHRoaXMgcGFzc2VzOgo+Cj4gbWVtY29u
dHJvbDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoQyBvb20gZXZlbnRzPTApID09IDAKPiBtZW1j
b250cm9sMDQuYzoyMTE6IFRQQVNTOiBFeHBlY3Q6IChDIGxvdyBldmVudHM9OTY2KSA+IDAKPiBt
ZW1jb250cm9sMDQuYzoyMDg6IFRQQVNTOiBFeHBlY3Q6IChEIG9vbSBldmVudHM9MCkgPT0gMAo+
IG1lbWNvbnRyb2wwNC5jOjIxMTogVFBBU1M6IEV4cGVjdDogKEQgbG93IGV2ZW50cz05NjYpID4g
MAo+IG1lbWNvbnRyb2wwNC5jOjIwODogVFBBU1M6IEV4cGVjdDogKEUgb29tIGV2ZW50cz0wKSA9
PSAwCj4gbWVtY29udHJvbDA0LmM6MjE0OiBUUEFTUzogRXhwZWN0OiAoRSBsb3cgZXZlbnRzPTAp
ID09IDAKPiBtZW1jb250cm9sMDQuYzoyMDg6IFRQQVNTOiBFeHBlY3Q6IChGIG9vbSBldmVudHM9
MCkgPT0gMAo+IG1lbWNvbnRyb2wwNC5jOjIxMTogVFBBU1M6IEV4cGVjdDogKEYgbG93IGV2ZW50
cz04NzQpID4gMAo+Cj4gWzFdIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8y
MDI0LU5vdmVtYmVyLzA0MDk0Ni5odG1sCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0
cC8yMDIyMDIyMjE0NDUxMS5HQTEyMDM3QGJsYWNrYm9keS5zdXNlLmN6Lwo+Cj4gU2lnbmVkLW9m
Zi1ieTogSmluIEd1b2ppZSA8Z3VvamllLmppbkBnbWFpbC5jb20+Cj4gU3VnZ2VzdGVkLWJ5OiBS
aWNoYXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPgo+IFN1Z2dlc3RlZC1ieTog
TWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvdHN0X2Nn
cm91cC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKwo+ICBsaWIvdHN0X2Nn
cm91cC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrKysr
Cj4gIHRlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMgfCAg
MiArLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9jZ3JvdXAuaCBiL2luY2x1ZGUvdHN0X2Nncm91
cC5oCj4gaW5kZXggZDIzYThlNjUyLi4wNjhmZjgzMDYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90
c3RfY2dyb3VwLmgKPiArKysgYi9pbmNsdWRlL3RzdF9jZ3JvdXAuaAo+IEBAIC0yNTYsNCArMjU2
LDYgQEAgaW50IHNhZmVfY2dfb2NjdXJzaW4oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50Cj4g
bGluZW5vLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpjb25zdCBmaWxl
X25hbWUsCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0IG5lZWRs
ZSk7Cj4KPiAraW50IHRzdF9jZ19tZW1vcnlfcmVjdXJzaXZlcHJvdChzdHJ1Y3QgdHN0X2NnX2dy
b3VwICpjZyk7Cj4gKwo+ICAjZW5kaWYgLyogVFNUX0NHUk9VUF9IICovCj4gZGlmZiAtLWdpdCBh
L2xpYi90c3RfY2dyb3VwLmMgYi9saWIvdHN0X2Nncm91cC5jCj4gaW5kZXggNjA1NTAxNWViLi45
ZTNiMjFlZDAgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9jZ3JvdXAuYwo+ICsrKyBiL2xpYi90c3Rf
Y2dyb3VwLmMKPiBAQCAtNzYsNiArNzYsOCBAQCBzdHJ1Y3QgY2dyb3VwX3Jvb3Qgewo+ICAgICAg
ICAgaW50IHdlX21vdW50ZWRfaXQ6MTsKPiAgICAgICAgIC8qIGNwdXNldCBpcyBpbiBjb21wYXRh
YmlsaXR5IG1vZGUgKi8KPiAgICAgICAgIGludCBub19jcHVzZXRfcHJlZml4OjE7Cj4gKwo+ICsg
ICAgICAgaW50IG1lbW9yeV9yZWN1cnNpdmVwcm90OjE7Cj4KCkkgcHJlZmVyIHRvIG1vdmUgaXQg
dXAgdG8gcHV0IGl0IHRvZ2V0aGVyIHdpdGggdGhlIG5zZGVsZWdhdGUuCgoKCj4gIH07Cj4KPiAg
LyogQ29udHJvbGxlciBzdWItc3lzdGVtcyAqLwo+IEBAIC01OTIsNiArNTk0LDcgQEAgc3RhdGlj
IHZvaWQgY2dyb3VwX3Jvb3Rfc2Nhbihjb25zdCBjaGFyICpjb25zdAo+IG1udF90eXBlLAo+ICAg
ICAgICAgfQo+ICAgICAgICAgZm9yICh0b2sgPSBzdHJ0b2sobW50X29wdHMsICIsIik7IHRvazsg
dG9rID0gc3RydG9rKE5VTEwsICIsIikpIHsKPiAgICAgICAgICAgICAgICAgbnNkZWxlZ2F0ZSB8
PSAhc3RyY21wKCJuc2RlbGVnYXRlIiwgdG9rKTsKPiArICAgICAgICAgICAgICAgcm9vdC0+bWVt
b3J5X3JlY3Vyc2l2ZXByb3QgfD0KPiAhc3RyY21wKCJtZW1vcnlfcmVjdXJzaXZlcHJvdCIsIHRv
ayk7Cj4KCgpXaHkgbm90IGRlZmluZSBhIHNpbmdsZSB2YXJpYWJsZSBtZW1vcnlfcmVjdXJzaXZl
cHJvdCB0byBzYXZlIHRoZSB2YWx1ZQphbmQgbW92ZSB0aGUgcm9vdC0+bWVtb3J5X3JlY3Vyc2l2
ZXByb3QgYXNzaWdubWVudCB0byB0aGUgImJhY2tyZWYiIHBhcnQ/CihqdXN0IGxpa2Ugd2hhdCB3
ZSBkaWQgZm9yIG5zZGVsZWdhdGUpCgoKCj4gICAgICAgICB9Cj4KPiAgICAgICAgIGlmIChyb290
LT52ZXIgJiYgY3RybF9maWVsZCA9PSByb290LT5jdHJsX2ZpZWxkKQo+IEBAIC03MTgsNiArNzIx
LDcgQEAgbW91bnQ6Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJNb3VudGVkIFYy
IENHcm91cHMgb24gJXMiLCBtbnRfcGF0aCk7Cj4gICAgICAgICAgICAgICAgIHRzdF9jZ19zY2Fu
KCk7Cj4gICAgICAgICAgICAgICAgIHJvb3RzWzBdLndlX21vdW50ZWRfaXQgPSAxOwo+ICsgICAg
ICAgICAgICAgICByb290c1swXS5tZW1vcnlfcmVjdXJzaXZlcHJvdCA9IDE7Cj4KClRoaXMgaXMg
Y29tcGxldGVseSB3cm9uZywgYXMgdGhlIGZpcnN0IG1vdW50IG9wZXJhdGlvbiBtYXkgZmFpbCwK
d2hpbGUgQ0dyb3VwVjIgZmFsbHMgYmFjayB0byB0aGUgZGVmYXVsdCBtb3VudCBhbmQgc3VjY2Vl
ZHMuCgpIZW5jZSB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBsaW5lIGhlcmUsIGFzIHRzdF9jZ19zY2Fu
KCkgaGVscHMKdG8gYXV0b21hdGljYWxseSBkZXRlY3QgYW5kIHNldCAicm9vdC0+bWVtb3J5X3Jl
Y3Vyc2l2ZXByb3QiCnRvIHRoZSBjb3JyZWN0IHZhbHVlLgoKCgo+ICAgICAgICAgICAgICAgICBy
ZXR1cm47Cj4gICAgICAgICB9Cj4KPiBAQCAtMTUwOSwzICsxNTEzLDExIEBAIGludCBzYWZlX2Nn
X29jY3Vyc2luKGNvbnN0IGNoYXIgKmNvbnN0IGZpbGUsCj4gY29uc3QgaW50IGxpbmVubywKPgo+
ICAgICAgICAgcmV0dXJuICEhc3Ryc3RyKGJ1ZiwgbmVlZGxlKTsKPiAgfQo+ICsKPiAraW50IHRz
dF9jZ19tZW1vcnlfcmVjdXJzaXZlcHJvdChzdHJ1Y3QgdHN0X2NnX2dyb3VwICpjZykKPiArewo+
ICsgICAgICAgaWYgKGNnICYmIGNnLT5kaXJzX2J5X2N0cmxbMF0tPmRpcl9yb290KQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gY2ctPmRpcnNfYnlfY3RybFswXS0+ZGlyX3Jvb3QtPm1lbW9yeV9y
ZWN1cnNpdmVwcm90Owo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMKPiBpbmRleCAx
YjhkMTE1ZjguLjllOWQ2YWI2ZSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRy
b2xsZXJzL21lbWNnL21lbWNvbnRyb2wwNC5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250
cm9sbGVycy9tZW1jZy9tZW1jb250cm9sMDQuYwo+IEBAIC0yMDcsNyArMjA3LDcgQEAgc3RhdGlj
IHZvaWQgdGVzdF9tZW1jZ19sb3codm9pZCkKPgo+ICAgICAgICAgICAgICAgICBUU1RfRVhQX0VY
UFIob29tID09IDAsICIoJWMgb29tIGV2ZW50cz0lbGQpID09IDAiLCBpZCwKPiBvb20pOwo+Cj4g
LSAgICAgICAgICAgICAgIGlmIChpIDwgRSkgewo+ICsgICAgICAgICAgICAgICBpZiAoaSA8IEUg
fHwgKChpID09IEYpICYmCj4gdHN0X2NnX21lbW9yeV9yZWN1cnNpdmVwcm90KGxlYWZfY2dbRl0p
KSkgewo+ICAgICAgICAgICAgICAgICAgICAgICAgIFRTVF9FWFBfRVhQUihsb3cgPiAwLAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiKCVjIGxvdyBldmVudHM9JWxkKSA+
IDAiLCBpZCwgbG93KTsKPiAgICAgICAgICAgICAgICAgfSBlbHNlIHsKPiAtLQo+IDIuMzQuMQo+
Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
