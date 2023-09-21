Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FEDCD4F35
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:01:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44D3E3CDE66
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 11:01:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 435843C99B5
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 15:01:24 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B89D200065
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 15:01:23 +0200 (CEST)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4526efb9d9eso181603137.1
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695301282; x=1695906082; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aeIHPWTGATrUs6XEoFwQhn9L4+s6K5ToW4DooEQeZdQ=;
 b=es7lVwkS+Jx0g+vlQGuSBjE80rh5e/wfTbaMCBBNUA55OH1Hxn6YOk4IdZheBHp+5/
 Q3vDfDc2az7ftOJrS4w+y/LDx5P9uG+EN6f2Ta8q+mJnynpiKaz5NJtOAn+6w1o9KYBz
 QOpMelllaMrsMiK8YPh7glTnZULNCWRI9ApyRTE1JuPFgE1DejaaX2DbtnQlSykjbg+X
 4Xn3cp+Pi2v8xcf5iBlwzd+otsm8AbG6bk0Bo6K4f53F4u1SvFjTcifWUgpRBnNywJvb
 irrD9+bFNyGIFzb6YbGy555mQJ2JWlXsbt5z5xu3Lv5MIcA+iT+FUqEreKdDIM7ChBVG
 B8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695301282; x=1695906082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeIHPWTGATrUs6XEoFwQhn9L4+s6K5ToW4DooEQeZdQ=;
 b=Zf0Vi7Gwmg3J5Of2baMcr50N+b7oGBvlp37R44S1tXbqTtyymDbwi7D4cuQNvgHfRx
 VCdJck96PRaX4s7P+ps/D3DO6V/mKtwaQUfg9E+MXST+fLLDdOgT/ibisg6JoJn5joDW
 XHWAueX/X3EdYkPooY6L9Rjl0ynoSm4BlSnXlZDaaoA8Achy9AVZir8f8IP+/Df834Up
 IuuOFOeU31tFHboxQqCfkRwtNOmsgmxgBUOHxvBslgK83z0iZySUTOT3N6N6wlStZ0Hr
 sz9tDScW2ft/C3XCWC3Tllo7PYmO50X1TchnVEy23sGne7CskvQ/mXpLsQmXfb2nG44l
 wldw==
X-Gm-Message-State: AOJu0YwkVOnPBDd9thd9KQFMJmnd1GhAKgSatmSCBGYVGwtyu234isQX
 L7QX3MpCKN5V8itnnEODhEC16BToGJIOXlKF0q8z6yn9
X-Google-Smtp-Source: AGHT+IG08FRRSiz7DN5owJ4EB79W8YJBPvtixNGSRBEW/oQ58le36QzUJy4acIrGRcKFWCwzjhXWaDl9slRYbIAU1mE=
X-Received: by 2002:a05:6102:3586:b0:452:b7c1:1d7d with SMTP id
 h6-20020a056102358600b00452b7c11d7dmr988131vsu.0.1695301282268; Thu, 21 Sep
 2023 06:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Thu, 21 Sep 2023 08:01:11 -0500
Message-ID: <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 22 Sep 2023 11:01:30 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMzo0M+KAr0FNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+IHdyb3RlOgoKPiBPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCA1OjQ34oCvQU0g
a2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4KPiB3cm90ZToKPiA+Cj4g
Pgo+ID4KPiA+IEhlbGxvLAo+ID4KPiA+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgImx0cC5y
ZWFkYWhlYWQwMS5mYWlsIiBvbjoKPiA+Cj4gPiBjb21taXQ6IGY0OWEyMGM5OTJkN2ZlZDE2ZTA0
YzRjZmE0MGU5ZjI4ZjE4ZjgxZjcgKCJbUEFUQ0hdIHZmczogZml4Cj4gcmVhZGFoZWFkKDIpIG9u
IGJsb2NrIGRldmljZXMiKQo+ID4gdXJsOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWIt
bGtwL2xpbnV4L2NvbW1pdHMvUmV1YmVuLUhhd2tpbnMvdmZzLWZpeC1yZWFkYWhlYWQtMi1vbi1i
bG9jay1kZXZpY2VzLzIwMjMwOTA5LTEyNDM0OQo+ID4gYmFzZTogaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0Cj4gMzJiZjQzZTRl
ZmRiODdlMGY3ZTkwYmEzODgzZTA3Yjg1MjIzMjJhZAo+ID4gcGF0Y2ggbGluazoKPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MDkwNDM4MDYuMzUzOS0xLXJldWJlbmh3a0BnbWFp
bC5jb20vCj4gPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0hdIHZmczogZml4IHJlYWRhaGVhZCgyKSBv
biBibG9jayBkZXZpY2VzCj4gPgo+ID4gaW4gdGVzdGNhc2U6IGx0cAo+ID4gdmVyc2lvbjogbHRw
LXg4Nl82NC0xNGMxZjc2LTFfMjAyMzA3MTUKPiA+IHdpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6
Cj4gPgo+ID4gICAgICAgICBkaXNrOiAxSERECj4gPiAgICAgICAgIGZzOiBleHQ0Cj4gPiAgICAg
ICAgIHRlc3Q6IHN5c2NhbGxzLTAwL3JlYWRhaGVhZDAxCj4gPgo+ID4KPiA+Cj4gPiBjb21waWxl
cjogZ2NjLTEyCj4gPiB0ZXN0IG1hY2hpbmU6IDQgdGhyZWFkcyAxIHNvY2tldHMgSW50ZWwoUikg
Q29yZShUTSkgaTMtMzIyMCBDUFUgQAo+IDMuMzBHSHogKEl2eSBCcmlkZ2UpIHdpdGggOEcgbWVt
b3J5Cj4gPgo+ID4gKHBsZWFzZSByZWZlciB0byBhdHRhY2hlZCBkbWVzZy9rbXNnIGZvciBlbnRp
cmUgbG9nL2JhY2t0cmFjZSkKPiA+Cj4gPgo+ID4KPiA+Cj4gPiBJZiB5b3UgZml4IHRoZSBpc3N1
ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldwo+IHZlcnNp
b24gb2YKPiA+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRh
Z3MKPiA+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRl
bC5jb20+Cj4gPiB8IENsb3NlczoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1sa3AvMjAy
MzA5MTkxMDE4LjY4ZWM4N2Q3LW9saXZlci5zYW5nQGludGVsLmNvbQo+ID4KPiA+Cj4gPgo+ID4g
Q09NTUFORDogICAgL2xrcC9iZW5jaG1hcmtzL2x0cC9iaW4vbHRwLXBhbiAgIC1lIC1TICAgLWEg
MzkxNyAgICAgLW4KPiAzOTE3IC1wIC1mIC9mcy9zZGIyL3RtcGRpci9sdHAtUjhCcWh0c3Y1dC9h
bGx0ZXN0cyAtbAo+IC9sa3AvYmVuY2htYXJrcy9sdHAvcmVzdWx0cy9MVFBfUlVOX09OLTIwMjNf
MDlfMTMtMjBoXzE3bV81M3MubG9nICAtQwo+IC9sa3AvYmVuY2htYXJrcy9sdHAvb3V0cHV0L0xU
UF9SVU5fT04tMjAyM18wOV8xMy0yMGhfMTdtXzUzcy5mYWlsZWQgLVQKPiAvbGtwL2JlbmNobWFy
a3MvbHRwL291dHB1dC9MVFBfUlVOX09OLTIwMjNfMDlfMTMtMjBoXzE3bV81M3MudGNvbmYKPiA+
IExPRyBGaWxlOgo+IC9sa3AvYmVuY2htYXJrcy9sdHAvcmVzdWx0cy9MVFBfUlVOX09OLTIwMjNf
MDlfMTMtMjBoXzE3bV81M3MubG9nCj4gPiBGQUlMRUQgQ09NTUFORCBGaWxlOgo+IC9sa3AvYmVu
Y2htYXJrcy9sdHAvb3V0cHV0L0xUUF9SVU5fT04tMjAyM18wOV8xMy0yMGhfMTdtXzUzcy5mYWls
ZWQKPiA+IFRDT05GIENPTU1BTkQgRmlsZToKPiAvbGtwL2JlbmNobWFya3MvbHRwL291dHB1dC9M
VFBfUlVOX09OLTIwMjNfMDlfMTMtMjBoXzE3bV81M3MudGNvbmYKPiA+IFJ1bm5pbmcgdGVzdHMu
Li4uLi4uCj4gPiA8PDx0ZXN0X3N0YXJ0Pj4+Cj4gPiB0YWc9cmVhZGFoZWFkMDEgc3RpbWU9MTY5
NDYzNjI3NAo+ID4gY21kbGluZT0icmVhZGFoZWFkMDEiCj4gPiBjb250YWN0cz0iIgo+ID4gYW5h
bHlzaXM9ZXhpdAo+ID4gPDw8dGVzdF9vdXRwdXQ+Pj4KPiA+IHRzdF90ZXN0LmM6MTU1ODogVElO
Rk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMm0gMzBzCj4gPiByZWFkYWhlYWQwMS5jOjM2OiBU
SU5GTzogdGVzdF9iYWRfZmQgLTEKPiA+IHJlYWRhaGVhZDAxLmM6Mzc6IFRQQVNTOiByZWFkYWhl
YWQoLTEsIDAsIGdldHBhZ2VzaXplKCkpIDogRUJBREYgKDkpCj4gPiByZWFkYWhlYWQwMS5jOjM5
OiBUSU5GTzogdGVzdF9iYWRfZmQgT19XUk9OTFkKPiA+IHJlYWRhaGVhZDAxLmM6NDU6IFRQQVNT
OiByZWFkYWhlYWQoZmQsIDAsIGdldHBhZ2VzaXplKCkpIDogRUJBREYgKDkpCj4gPiByZWFkYWhl
YWQwMS5jOjU0OiBUSU5GTzogdGVzdF9pbnZhbGlkX2ZkIHBpcGUKPiA+IHJlYWRhaGVhZDAxLmM6
NTY6IFRQQVNTOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpIDogRUlOVkFMICgy
MikKPiA+IHJlYWRhaGVhZDAxLmM6NjA6IFRJTkZPOiB0ZXN0X2ludmFsaWRfZmQgc29ja2V0Cj4g
PiByZWFkYWhlYWQwMS5jOjYyOiBURkFJTDogcmVhZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6
ZSgpKSBzdWNjZWVkZWQKPiA+Cj4KPiBSZXViZW4sCj4KPiBUaGlzIHJlcG9ydCBpcyBvbiBhbiBv
bGQgdmVyc2lvbiBvZiB5b3VyIHBhdGNoLgo+IEhvd2V2ZXI6Cj4gMS4gTFRQIHRlc3QgcmVhZGFo
ZWFkMDEgd2lsbCBuZWVkIHRvIGJlIGZpeGVkIHRvIGFjY2VwdCBhbHNvIEVTUElQRQo+IDIuIEkg
YW0gc3VycHJpc2VkIHRoYXQgd2l0aCB0aGUgb2xkIHBhdGNoIHJlYWRhaGVhZCBvbiBzb2NrZXQg
ZGlkIG5vdAo+ICAgICBmYWlsLiBEb2VzIHNvY2tldCBoYXZlIGFvcHM/Cj4KPiBQbGVhc2UgdHJ5
IHRvIHJ1biBMVFAgdGVzdCByZWFkYWhlYWQwMSBvbiB0aGUgcGF0Y2ggdGhhdCBDaHJpc3RpYW4g
cXVldWVkCj4gYW5kIHNlZSBob3cgaXQgYmVoYXZlcyBhbmQgaWYgYW55dGhpbmcgbmVlZHMgdG8g
YmUgZml4ZWQgd3J0IHNvY2tldHMuCj4KPiBUaGFua3MsCj4gQW1pci4KPgoKYWNrLiAgV2lsbCB0
cnkgdG8gdGVzdC4gIE15IFVidW50dSAyMi4wNCBzeXN0ZW0gd2Fzbid0IGFibGUgdG8gZmluZApw
YWNrYWdlcyBjYWxsZWQKZm9yIGJ5IHRoZSB0ZXN0IGNhc2UsIHNvIGl0J2xsIHRha2UgbWUgYSBs
aXR0bGUgd2hpbGUgdG8gZmlndXJlIG91dCBob3cgdG8KZ2V0IHRoZQp0ZXN0IGNhc2Ugd29ya2lu
Zy4uLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
