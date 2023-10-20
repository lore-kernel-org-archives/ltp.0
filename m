Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27739CDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 15:56:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7C883CFBE5
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 17:56:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EE923CD1A8
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:55:57 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E26B140076D
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:55:56 +0200 (CEST)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d09b6d007so6594836d6.1
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697817355; x=1698422155; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFrzuP79ucT1eM5w01dgH6+q7RdEGj0QHt50/6HYSuU=;
 b=XI4YmEw+peVhEZfnYCy2YSTPDERbKDeb+lj5en0vYI5u4s2ttMH8GGmgf/5Smq4sg4
 aT6JZKovVFGYL2/Bhy2zhShZa79sSO9257NdGL8dS4BSNc+kYKeWhidg8zUGwjGYdAia
 A+CFheTb80nT7akuAMrsh8TNVCSGvCrqkl+XFRQFwF055N/l8nAs0wbZACExRtLhimqZ
 LF0WnRwZoDkACguv7Tqx1LwzbmwdL/OCekxoJ+jMswthNyM4TqEG5GThL/E28rwuMaBp
 1BiTLfJYrRP5QvsdrIMcENyq61jzNy+U5m9cL9oCkiXGbXNRCCOF9Xl/zFHLCnyIZVEt
 NTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697817355; x=1698422155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFrzuP79ucT1eM5w01dgH6+q7RdEGj0QHt50/6HYSuU=;
 b=aRcVlv4ybVpgLv1jdgeZtn6DJr6NcdA+7IctAqzFlMJmp718/8Ilg8HA+rq7FP9xsE
 uFWPCJUQB2Q1qzVXr6acwoVi+yTOrnjjcRvyGFyIDy5pxLds8gngNF9O7e26kD3VnfOy
 KeKyZ283MTP5OQNk20jTVOg0AG7w9SFepYj632nL09SNiDfWzFnihwSschnxdrwrJeNh
 /IWRR321Q4yW2TFLHmvxtY8ws6SZFteqGUobHV1JKP1JITDkdaBCxtEHbOPBMX7Ku8hw
 56Uu32ttfKcKRGVh6nmXqKP6P8xNJy8QaEtYxGYmHFFZFHfJPJ42ptzzI49g/MsKK5qS
 HWYQ==
X-Gm-Message-State: AOJu0YyGdw1jcHWIWBFnYJcOUgWkgD+CZYTHGRWYLp1ku4X9xFQm5pqd
 CdrC+10+TCA2qlgbR9bBRaglF/nLjh2WM3bbZSQ=
X-Google-Smtp-Source: AGHT+IGb4xEaXgwl/3RgjQ2+z+yz5SdHXSpOfaRCLyoMjgHspqiO3Ohez7TzYNPmBi0v02B6GpwQMy8QJ2r01V3qZQI=
X-Received: by 2002:a05:6214:2465:b0:66d:1217:18fd with SMTP id
 im5-20020a056214246500b0066d121718fdmr2585432qvb.26.1697817355033; Fri, 20
 Oct 2023 08:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231020150749.21165-1-mdoucha@suse.cz>
 <20231020150749.21165-2-mdoucha@suse.cz>
In-Reply-To: <20231020150749.21165-2-mdoucha@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Oct 2023 18:55:43 +0300
Message-ID: <CAOQ4uxiS_+AyRG3goSFrw4omz+UfVMwCS5LnNz_caok0bgzjkg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Add fanotify_get_supported_init_flags()
 helper function
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

T24gRnJpLCBPY3QgMjAsIDIwMjMgYXQgNjowN+KAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBTaW5jZSBGQU5fQUxMX0lOSVRfRkxBR1MgY29uc3RhbnQgaXMg
ZGVwcmVjYXRlZCwgdGhlIGtlcm5lbCBoYXMgYWRkZWQKPiBuZXcgZmFub3RpZnkgZmVhdHVyZSBm
bGFncyBhbmQgdGhlcmUgaXMgbm8gb3RoZXIgd2F5IHRvIGNoZWNrCj4gZm9yIHRoZWlyIHN1cHBv
cnQsIHdlIG5lZWQgdG8gbWFudWFsbHkgY2hlY2sgd2hpY2ggaW5pdCBmbGFncyBuZWVkZWQKPiBi
eSBvdXIgdGVzdHMgYXJlIGF2YWlsYWJsZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBEb3Vj
aGEgPG1kb3VjaGFAc3VzZS5jej4KPiAtLS0KPgo+IENoYW5nZXMgc2luY2UgdjE6Cj4gLSBGaXhl
ZCBjaGVjayBmb3IgRkFOX1JFUE9SVF9OQU1FCj4gLSBBZGRlZCBsb25nZXIgcGF0Y2ggZGVzY3Jp
cHRpb24KPgo+IENoYW5nZXMgc2luY2UgdjI6Cj4gLSBBZGRlZCBhIHRhYmxlIG9mIGZsYWcgZGVw
ZW5kZW5jaWVzIHNvIHRoYXQgZWFjaCBpbmRpdmlkdWFsIGZsYWcgaXMgdGVzdGVkCj4gICB0b2dl
dGhlciB3aXRoIGFsbCBhZGRpdGlvbmFsIHJlcXVpcmVkIGZsYWdzCj4KPiBUaGUgaGVscGVyIGZ1
bmN0aW9uIGFsc28gY2hlY2tzIHRoYXQgaXQgd2Fzbid0IGNhbGxlZCB3aXRoIGEgbmV3IHVrbm93
bgo+IGZsYWcgd2hpY2ggbWlnaHQgcmVxdWlyZSBkZXBlbmRlbmN5IHRhYmxlIHVwZGF0ZS4gSW4g
dGhhdCBjYXNlLCB0aGUgdGVzdAo+IHdpbGwgZmFpbCBhbmQgYWR2aXNlIHRoZSBkZXZlbG9wZXIg
dG8gcmV2aWV3IGRvY3VtZW50YXRpb24gYW5kIHVwZGF0ZQo+IHRoZSBkZXBlbmRlbmN5IHRhYmxl
Lgo+CgpUaGlzIGlzIG11Y2ggbW9yZSBzYW5lIHRoYW4gdGhlIHByZXZpb3VzIHZlcnNpb24gOikK
WW91IG1heSBhZGQ6CgpSZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWls
LmNvbT4KCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaCB8
IDQzICsrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zh
bm90aWZ5LmggYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmgK
PiBpbmRleCA3NWEwODFkYzkuLjc4NDI0YTM1MCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiBAQCAtMjE3LDYgKzIxNyw0OSBAQCBzdGF0
aWMgaW5saW5lIGludCBmYW5vdGlmeV9pbml0X2ZsYWdzX3N1cHBvcnRlZF9ieV9rZXJuZWwodW5z
aWduZWQgaW50IGZsYWdzKQo+ICAgICAgICAgcmV0dXJuIGZhbm90aWZ5X2luaXRfZmxhZ3Nfc3Vw
cG9ydGVkX29uX2ZzKGZsYWdzLCBOVUxMKTsKPiAgfQo+Cj4gKyNkZWZpbmUgVFNUX0ZBTk9USUZZ
X0lOSVRfS05PV05fRkxBR1MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
PiArICAgICAgIChGQU5fUkVQT1JUX0RGSURfTkFNRV9UQVJHRVQgfCBGQU5fUkVQT1JUX1RJRCB8
IEZBTl9SRVBPUlRfUElERkQgfCBcCj4gKyAgICAgICBGQU5fQ0xBU1NfTk9USUYgfCBGQU5fQ0xB
U1NfQ09OVEVOVCB8IEZBTl9DTEFTU19QUkVfQ09OVEVOVCkKPiArCj4gKy8qCj4gKyAqIENoZWNr
IHN1cHBvcnQgb2YgZ2l2ZW4gaW5pdCBmbGFncyBvbmUgYnkgb25lIGFuZCByZXR1cm4gdGhvc2Ug
d2hpY2ggYXJlCj4gKyAqIHN1cHBvcnRlZC4KPiArICovCj4gK3N0YXRpYyBpbmxpbmUgdW5zaWdu
ZWQgaW50IGZhbm90aWZ5X2dldF9zdXBwb3J0ZWRfaW5pdF9mbGFncyh1bnNpZ25lZCBpbnQgZmxh
Z3MsCj4gKyAgICAgICBjb25zdCBjaGFyICpmbmFtZSkKPiArewo+ICsgICAgICAgdW5zaWduZWQg
aW50IGksIGZsZywgYXJnLCByZXQgPSAwOwo+ICsgICAgICAgc3RhdGljIGNvbnN0IHN0cnVjdCB7
IHVuc2lnbmVkIGludCBmbGFnLCBkZXBzOyB9IGRlcGxpc3RbXSA9IHsKPiArICAgICAgICAgICAg
ICAge0ZBTl9SRVBPUlRfTkFNRSwgRkFOX1JFUE9SVF9ESVJfRklEfSwKPiArICAgICAgICAgICAg
ICAge0ZBTl9SRVBPUlRfVEFSR0VUX0ZJRCwgRkFOX1JFUE9SVF9ERklEX05BTUVfRklEfSwKPiAr
ICAgICAgICAgICAgICAgezAsIDB9Cj4gKyAgICAgICB9Owo+ICsKPiArICAgICAgIGlmIChmbGFn
cyAmIH5UU1RfRkFOT1RJRllfSU5JVF9LTk9XTl9GTEFHUykgewo+ICsgICAgICAgICAgICAgICB0
c3RfYnJrKFRCUk9LLCAiZmFub3RpZnlfaW5pdCgpIGZlYXR1cmUgY2hlY2sgY2FsbGVkIHdpdGgg
dW5rbm93biBmbGFncyAleCwgcGxlYXNlIHVwZGF0ZSBmbGFnIGRlcGVuZGVuY3kgdGFibGUgaWYg
bmVlZGVkIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBmbGFncyAmIH5UU1RfRkFOT1RJRllf
SU5JVF9LTk9XTl9GTEFHUyk7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgZm9yIChmbGcgPSAx
OyBmbGc7IGZsZyA8PD0gMSkgewo+ICsgICAgICAgICAgICAgICBpZiAoIShmbGFncyAmIGZsZykp
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gKwo+ICsgICAgICAgICAgICAg
ICBhcmcgPSBmbGc7Cj4gKwo+ICsgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBkZXBsaXN0W2ld
LmZsYWc7IGkrKykgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChkZXBsaXN0W2ldLmZs
YWcgPT0gZmxnKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmcgfD0gZGVw
bGlzdFtpXS5kZXBzOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICB9Cj4gKwo+ICsgICAg
ICAgICAgICAgICBpZiAoIWZhbm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKGFyZywg
Zm5hbWUpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCB8PSBmbGc7Cj4gKyAgICAgICB9
Cj4gKwo+ICsgICAgICAgcmV0dXJuIHJldDsKPiArfQo+ICsKPiAgdHlwZWRlZiB2b2lkICgqdHN0
X3Jlc19mdW5jX3QpKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGludCB0dHlwZSwgY29uc3QgY2hhciAqZm10LCAuLi4p
Owo+Cj4gLS0KPiAyLjQyLjAKPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
