Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A062FC83F0F
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751971839; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+uFuBALPdXmvSy15/s1Vfo6Fb9UxUiPcEeTuBeWrjWE=;
 b=F1VwV1CPveKu482aGBefg7P+BBVLuSADPO21RvYL90NLiuLfqeNb0zKRumz+qJ8SZlYld
 byH5QGwrupkUsiLhs7dnmt7z8AHy3Rn+5+v6vUOyZmJ+9bco0vplpsKgqZB1JmWuBmn+mgC
 SzBuFuNFDE4IaZD0Xwj+cGTDf2Q/fgs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C3533CA1BE
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 12:50:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 627D03C7A03
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 12:50:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FF0248CCC74
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 12:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751971815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hrqp944PTPQhwUmloft2t3tRjf8YfdNkhAkVjB+ao0=;
 b=FwdSI973RnqT8pX9f5GU9Wo2oojwraG4VsHJGVAGDnA+qTbCXLcLSX5FeMTF1qkT5y69r/
 hos5wwqMhrPESvm7qMCWi9U+zNCxRseX8YJei6bl0p+x8xKZq2LBvtsj9kMiqiill2fcVS
 +m+BDwX7nFS6AwYFA2RmUbX8ZXLTJy4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-gDC6-1L-MnCCMSlp9jUFPg-1; Tue, 08 Jul 2025 06:50:14 -0400
X-MC-Unique: gDC6-1L-MnCCMSlp9jUFPg-1
X-Mimecast-MFC-AGG-ID: gDC6-1L-MnCCMSlp9jUFPg_1751971813
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-312df02acf5so4077221a91.1
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 03:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751971811; x=1752576611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hrqp944PTPQhwUmloft2t3tRjf8YfdNkhAkVjB+ao0=;
 b=A9gECk7/WNDSCTwhACzbBfIu12retyaYjmOSGuKRca4XNK6npXiWQNwOTubpGV8/uT
 WcqZ9bzlVxb4EcCnMwI4uADavNPKrizrvA567jynec/wxfzr1fLA0NstByFnW8pgldru
 7QtPzcnYI+5/Td1PlumgGvwZXYyfWyCpiWiST1mk2IlZT4BUQTY0vvY+nszFHWKOqd39
 WY04vqP+8QzvgEzbtGzWihs9QzXFJ0EZEgn77pYdopNLts5tAU0Ya9mXeCPWwemCTIpa
 zfzUEtSTxfiqf2NKGA9Y3sszPYPxHji4er89rT/TXdeHA2uCd3mJh66Q20jbtwttLkX4
 CRFA==
X-Gm-Message-State: AOJu0YxpIF6oU2VLKc0UTwn8+2lJa0v9yO1c4/GVR+abN4g17YupPCFc
 Nosw8HhYx8nTBTC2Lb4pklIisYePMDair8/OnK0DuGHRm2qCvOu1Vr2Yn36xD6E38B/SVRehlIk
 b5cw5Y+gwcEDy01syu0A59seYc9G9Rvzfv1lAPlWueJSIzGv3i5VVYgJoSs1AafbACSvXEjB6nC
 ONLZ9UJ9YOjl3QMl3fd4kz5iozswCtFb6DtjU=
X-Gm-Gg: ASbGncuEzhRJAcFQQT0nEEIdUc2fIs5Oyq8GNgRssnM4SaNRNhdupsdYNlwQr6Ex2u9
 STbmGFAYjWSlrfsnwvr7p9rZnDHJjYkv2bpfOC79AYp5FDJgSfLI5WEVJQ3LvP55tpnhxTjbQhR
 kgkVoD
X-Received: by 2002:a17:90b:258d:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-31c229a9486mr3078052a91.10.1751971811524; 
 Tue, 08 Jul 2025 03:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzK2As+ei2aOX/dFXm7cH+698NPYPv0Y+6bbur6sqkRPATl3jgmkvMUgWWW7J+89XWi+GLKlky3o7sZw7ZniU=
X-Received: by 2002:a17:90b:258d:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-31c229a9486mr3078029a91.10.1751971811139; Tue, 08 Jul 2025
 03:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250708071706.19639-1-yangtiezhu@loongson.cn>
 <ca899670-c391-c214-f0ad-c762cccd201b@loongson.cn>
In-Reply-To: <ca899670-c391-c214-f0ad-c762cccd201b@loongson.cn>
Date: Tue, 8 Jul 2025 18:49:58 +0800
X-Gm-Features: Ac12FXxtLaATQIQ2uFAPba0N5Fsdm0mwUni4UI8HGllvvO_rYQqGojJARe4Vimw
Message-ID: <CAEemH2d26zB+867EJdr2dfYE=mMdxv=T+fB_7hxrHtf+sYQFUw@mail.gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0VzR3WIQtGHQC_z-Ek2Q-Lq-7BsWyKYfKvFBBwwvPfg_1751971813
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit not implemented
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdWwgOCwgMjAyNSBhdCA1OjE24oCvUE0gVGllemh1IFlhbmcgPHlhbmd0aWV6aHVA
bG9vbmdzb24uY24+IHdyb3RlOgoKPiBPbiAyMDI1LzcvOCDkuIvljYgzOjE3LCBUaWV6aHUgWWFu
ZyB3cm90ZToKPiA+IEluIHRoZSBMaW51eCBrZXJuZWwsIExvb25nQXJjaCB1c2VzIHRoZSBnZW5l
cmljIHN5c2NhbGwgdGFibGUgd2hpY2gKPiA+IGlzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL2Fz
bS1nZW5lcmljL3VuaXN0ZC5oLCBhbmQgYWxzbyB0aGVyZSBpcwo+ID4gbm8gX19BUkNIX1dBTlRf
U0VUX0dFVF9STElNSVQgaW4gYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vdW5pc3RkLmgsCj4g
PiBzbyBfX05SX2dldHJsaW1pdCBpcyBub3QgaW1wbGVtZW50ZWQgb24gTG9vbmdBcmNoLgo+ID4K
PiA+IFRoYXQgaXMgdG8gc2F5LCBnZXRybGltaXQgYXJlIHN1cGVyc2VkZWQgd2l0aCBwcmxpbWl0
NjQuIFRoZXJlIGlzIG5vCj4gPiBuZWVkIHRvIGNvbXBhcmUgdGhlIHJldHVybiB2YWx1ZSBhbmQg
ZXJybm8gYWJvdXQgdGhlIHN5c2NhbGwgbnVtYmVycwo+ID4gX19OUl9wcmxpbWl0NjQgYW5kIF9f
TlJfZ2V0cmxpbWl0LCBqdXN0IGNoZWNrIHRoaXMgY2FzZSBhbmQgdGhlbiBza2lwCj4gPiB0aGUg
dGVzdC4KPgo+IC4uLgo+Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0
aWV6aHVAbG9vbmdzb24uY24+Cj4gPiAtLS0KPiA+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9nZXRybGltaXQvZ2V0cmxpbWl0MDMuYyB8IDUgKysrKysKPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2dldHJsaW1pdC9nZXRybGltaXQwMy5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2dldHJsaW1pdC9nZXRybGltaXQwMy5jCj4gPiBpbmRleCA2MDQwODJjY2YuLjJkNzkwNTdk
YSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmxpbWl0L2dl
dHJsaW1pdDAzLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmxpbWl0
L2dldHJsaW1pdDAzLmMKPiA+IEBAIC0xNjIsNiArMTYyLDExIEBAIHN0YXRpYyB2b2lkIHJ1bih1
bnNpZ25lZCBpbnQgcmVzb3VyY2UpCj4gPiAgICAgICBlcnJubyA9IDA7Cj4gPiAgICAgICByZXRf
dWwgPSBnZXRybGltaXRfdWxvbmcocmVzb3VyY2UsICZybGltX3VsKTsKPiA+ICAgICAgIGVycm5v
X3VsID0gZXJybm87Cj4gPiArICAgICBpZiAoZXJybm9fdWwgPT0gRU5PU1lTKSB7Cj4gPiArICAg
ICAgICAgICAgIHRzdF9yZXMoVENPTkYgfCBURVJSTk8sCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgIiVzIG5vdCBpbXBsZW1lbnRlZCIsIF9fTlJfZ2V0cmxpbWl0X3Vsb25nX3N0cik7Cj4KPiBT
ZWxmIHJldmlldzoKPgo+IEkgYW0gbm90IHN1cmUgd2hldGhlciBpdCBzaG91bGQgYWRkIHRoZSBm
b2xsb3dpbmcgY29kZToKPgo+ICsgICAgICAgICAgICAgICB0ZXN0LnRjbnQgPSAxOwo+Cj4gdG8g
c2tpcCBvbmx5IG9uY2UgaWYgX19OUl9nZXRybGltaXRfdWxvbmdfc3RyIChtYXliZSBfX05SX2dl
dHJsaW1pdAo+IG9yIF9fTlJfdWdldHJsaW1pdCkgbm90IGltcGxlbWVudGVkLgo+Cj4gPiArICAg
ICAgICAgICAgIHJldHVybjsKPiA+ICsgICAgIH0KPiA+Cj4gPiAgICAgICBpZiAoY29tcGFyZV9y
ZXR2YWwocmVzb3VyY2UsIHJldF91NjQsIGVycm5vX3U2NCwgcmV0X3VsLCBlcnJub191bCwKPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX05SX2dldHJsaW1pdF91bG9uZ19zdHIpIHx8Cj4g
Pgo+Cj4gSWYgeWVzLCBpdCBpcyBuZWNlc3NhcnkgdG8gbW9kaWZ5IGFub3RoZXIgcGxhY2UgaW4g
dGhpcyBmdW5jdGlvbiwKPiBzb21ldGhpbmcgbGlrZSB0aGlzOgo+Cj4gQEAgLTE4Niw2ICsxODcs
NyBAQCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IHJlc291cmNlKQo+ICAgICAgICAgIGlm
IChlcnJub19sID09IEVOT1NZUykgewo+ICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiB8
IFRFUlJOTywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgIl9fTlJfZ2V0cmxpbWl0KCVkKSBu
b3QgaW1wbGVtZW50ZWQiLAo+IF9fTlJfZ2V0cmxpbWl0KTsKPiArICAgICAgICAgICAgICAgdGVz
dC50Y250ID0gMTsKPiAgICAgICAgICAgICAgICAgIHJldHVybjsKPiAgICAgICAgICB9Cj4KPiBQ
bGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGluaW9ucywgc2hvdWxkIEkgc3F1YXNoIHRoZSBhYm92
ZSBjaGFuZ2VzCj4gaW50byB0aGlzIHBhdGNoIG9yIHNob3VsZCBJIHNlbmQgYSBzbWFsbCBwYXRj
aCBzZXJpZXMgd2l0aCB0d28gcGF0Y2hlcz8KPgoKWWVzLCBpZiBib3RoIF9fTlJfZ2V0cmxpbWl0
IGFuZCBfX05SX3VnZXRybGltaXQgYXJlIHVuZGVmaW5lZCBvbiBMb29uZ0FyY2gsCmFwcGFyZW50
bHkgdGhlcmUgaXMgdW5uZWNlc3NhcnkgdG8gaXRlcmF0ZSB0aGUgVENPTkYgZm9yIFJMSU1fTkxJ
TUlUUyB0aW1lcy4KCkkgdGhpbmsgeW91IGNhbiBzcXVhc2ggd2l0aCB0ZXN0LnRjbnQ9MSB3aGVu
IEVOT1NZUyBpcyBkZXRlY3RlZC4KCkZlZWwgZnJlZSB0byBhZGQgbXkgUkJUOgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
