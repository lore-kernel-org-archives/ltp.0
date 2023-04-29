Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A46C77B60
	for <ltp@archiver.kernel.org>; Sat, 29 Apr 2023 06:48:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90DE23CBA84
	for <ltp@archiver.kernel.org>; Sat, 29 Apr 2023 08:48:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 321B83CB2CD
 for <ltp@lists.linux.it>; Sat, 29 Apr 2023 08:47:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D00CA1A004D5
 for <ltp@lists.linux.it>; Sat, 29 Apr 2023 08:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682750874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lsleHpN1GtHYGqEDgD3sY94ev0vpxm0AyaUJqSATYc=;
 b=MXQd9rIZpthsjCzZygDUK0elGheYQpRnNzfrHEvdJxZDiY2zMXFze+ZSIqQ4CsKxjQ5tiO
 ZSfsjGIjtJKg9XGdnjUEK8AAsIiQ5JjzlK8f3x6zUngj03qcdaMxESYLb79ryzZ0l93Itw
 UF+mG+Xw7FLODqwYGK6I/D7M/mCZ3no=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-YKiwvCBaM_CAP4C6NbilUg-1; Sat, 29 Apr 2023 02:47:52 -0400
X-MC-Unique: YKiwvCBaM_CAP4C6NbilUg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4eff7227f49so451033e87.2
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 23:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682750869; x=1685342869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lsleHpN1GtHYGqEDgD3sY94ev0vpxm0AyaUJqSATYc=;
 b=gfTjm2DNzZxvrKoaUXuPea6hzo3ax7hx7Q5Qo3w5FZOEf0c++f67LCtn/CJ9n5YP8o
 cM2fdusplPbyn5N5Wf+8qUo5C/0lZsyviP8ItvtKbI9AQhxT/XpsdkTzbaJo0hdz8Ujz
 bnJP6/BJRKvu++EHPcPoXP2oexi9bvYjwv6u+nhyq7qQxjPBGGmO32iGTpTF5YaTEeXN
 2g8vsgma0SjXlJFWarPRK0pn8Z1T4G/p2CvQtp6YJ990c0KRLDFimHF3iCJSYpE/LwZK
 pRVTK2zEPfbKH6/oYjZjptPNsy8gWrplz5BlM330NQfmjslnp7Bj+z+93Lqk6mtnUB8V
 4z0w==
X-Gm-Message-State: AC+VfDzq7QuuciTTefN4INR/kE9a/498YOUStnqTdtTfureO1lQp+Ogy
 p+pQEonhYsE2rU2C5Gsvs4ResrQe5xhwfcUbS+kglKoyt0KGNqP2jXoPEZfZe2zAXosWqZfPsz6
 NKlMHWxxk/xxboY+A0es83/C1sn0=
X-Received: by 2002:ac2:46c7:0:b0:4dc:4b92:dbc4 with SMTP id
 p7-20020ac246c7000000b004dc4b92dbc4mr2165032lfo.14.1682750868916; 
 Fri, 28 Apr 2023 23:47:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/I/tALeuEMj2oZZXctYivmMAZow74jfs03a7t8WlcorUpu8EcFJeVDoNUK303EkIEj7FWX4iTuSZqmk/XMFE=
X-Received: by 2002:ac2:46c7:0:b0:4dc:4b92:dbc4 with SMTP id
 p7-20020ac246c7000000b004dc4b92dbc4mr2165019lfo.14.1682750868614; Fri, 28 Apr
 2023 23:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230428084922.9834-1-liwang@redhat.com> <ZEufJa+TyZdY9gsq@yuki>
 <CAEemH2fcvpRLS7-rdpiGt-fqEwXCiAb-jpRdisb33axhdP3CoA@mail.gmail.com>
 <ZEvGchayVsZfrAH5@yuki>
 <CAEemH2femWH5U98nvsnCR2OrZee1aBjGY7nnS3PX95u2NX6QgQ@mail.gmail.com>
In-Reply-To: <CAEemH2femWH5U98nvsnCR2OrZee1aBjGY7nnS3PX95u2NX6QgQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 29 Apr 2023 14:47:36 +0800
Message-ID: <CAEemH2cFjq8d9ce-GKDwQWsXCMnbNCMTRpoZd37tcGj477AK9Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] tst_cgroup: Avoid mixing mounts V1 and V2
 simultaneously
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpPbiBGcmksIEFwciAyOCwgMjAyMyBhdCA5OjMw4oCvUE0gTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPgo+Cj4gT24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgOTox
MuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+PiBIaSEKPj4g
PiBUaGF0J3MgdGhlIG9yaWdpbmFsIGRlc2lnbi4gV2UgdHJpZWQgdG8ga2VlcCBmbGV4aWJsZSBi
dXQgaWdub3JlZAo+PiA+IG9uZSBleGNlcHRpb24gVjEgbW91bnRzIGFsbCBjb250cm9sbGVycyBh
bmQgVjIgb25seSBiYXNpYyBtb3VudC4KPj4gPiAoTm8gY29udHJvbGxlcnMgY29uZmxpY3QgaW4g
dGhpcyBtb3VudGluZykuCj4+ID4KPj4gPiBGcm9tIG15IG9ic2VydmF0aW9uLCBpZiBhIHN5c3Rl
bShlLmcuIFJIRUw4KSBvbmx5IGFubm91bmNlcwo+PiA+IENncm91cCBWMSBzdXBwb3J0IGJ1dCBk
b2VzIG5vdCBndWFyYW50ZWUgVjIgdG8gYmUgdXNlZC4KPj4gPiBBIHRlc3QgcmVxdWlyZWQgJ0NU
UkxfQkFTRScgY291bGQgbW91bnQgVjIgc3VjY2VzcyBidXQKPj4gPiB0aGF0IFYyIGlzIG9ubHkg
cGFydCB3b3JrIGFuZCB0ZXN0IHdpbGwgZ2V0IFRCUk9LLgo+PiA+IFdlIGFyZSB1bmFibGUgdG8g
c2F5IHRoaXMgc2l0dWF0aW9uIGlzIGEgYnVnLgo+Pgo+PiBTbyB0aGUgVjIgZG9lcyBub3QgYWN0
dWFsbHkgd29yayB1bmxlc3MgdGhlcmUgaXMgYXQgbGVhc3Qgb25lIGNvbnRyb2xsZXIKPj4gZW5h
YmxlZD8gVGhhdCBzb3VuZHMgbGlrZSBhIGJ1ZyB0byBtZSwgbXkgc3lzdGVtIGFjdHVhbGx5IHVz
ZXMgdjEKPj4gY29udHJvbGxlcnMgYW5kIHVuaWZpZWQgaGllcmFyY2h5IGF0IHRoZSBzYW1lIHRp
bWUuIFRoZSB1bmlmaWVkCj4+IGhpZXJhcmNoeSBpcyB1c2VkIHRvIGdyb3VwIGRlYW1vbiBwcm9j
ZXNzZXMgYW5kIGtpbGwgdGhlbSB3aXRoIHRoZQo+PiBjZ3JvcHUua2lsbCBpZiBuZWVkZWQuCj4K
Pgo+IEhtbSwgbGV0IG1lIGludmVzdGlnYXRlLi4uCj4KCkFmdGVyIHRhbGtpbmcgd2l0aCBvdXIg
Q2dyb3VwIGNvbGxlYWd1ZXMuIEkndmUgYmVlbiB0b2xkIHRoYXQgb24gbXkgUkhFTDgsCnRoZSAn
Y2dyb3VwLmtpbGwnIGlzIHRvbyBuZXcgdG8gaGF2ZS4KClRoZSBkZWZhdWx0IENncm91cCBpcyBW
MSBhbmQgaWYgd2Ugd2FudCBWMiBzaW5nbHksICBpdCBjb3VsZCBiZSBleHBsaWNpdGx5CmVuYWJs
ZWQKdmlhICJzeXN0ZW1kLnVuaWZpZWRfY2dyb3VwX2hpZXJhcmNoeT0xIiBrZXJuZWwgcGFyYW1l
dGVycy4gQnV0IHNvIGZhciBWMgppcyBub3Qgc3VwcG9ydGluZyBzdWNoIGEgbmV3IGZlYXR1cmUu
IFRoYXQncyB3aHkgSSBjb3VsZG4ndCBmaW5kCidjZ3JvdXAua2lsbCcKYWZ0ZXIgbW91bnRpbmcg
VjIgb24gUkhFTDguCgpBbmQgdGhlIG1haW5saW5lIGtlcm5lbCBtZXJnZXMgdGhpcyBmZWF0dXJl
IHNpbmNlIHY1LjE0LgokIGdpdCBkZXNjcmliZSAtLWNvbnRhaW5zIDY2MWVlNjI4MDkzMTU0OGYK
djUuMTQtcmMxfjEwOF4yfjgKClNvLCB0aGUgcHJvYmxlbSBpcyBub3QgY2F1c2VkIGJ5IG1peGlu
ZyBWMSBhbmQgVjIuIEkgbWlzdW5kZXJzdG9vZCBpdApiZWZvcmUuCgpQbGVhc2UgaWdub3JlIG15
IHBhdGNoLCB0aGUgcHJvYmxlbSBjYW4gYmUgcmVzb2x2ZWQgYnk6CgorICAgICAgIGlmICghU0FG
RV9DR19IQVMoY2dfY2hpbGRfdGVzdF9zaW1wbGUsICJjZ3JvdXAua2lsbCIpKSB7CisgICAgICAg
ICAgICAgICBjZ19jaGlsZF90ZXN0X3NpbXBsZSA9CnRzdF9jZ19ncm91cF9ybShjZ19jaGlsZF90
ZXN0X3NpbXBsZSk7CisgICAgICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiY2dyb3VwLmtpbGwg
aXMgbm90IHN1cHBvcnRlZCBvbiB5b3VyCmRpc3RyaWJ1dGlvbiIpOworICAgICAgIH0KKwoKdG8g
c2tpcCB0aGUgdGVzdCBncmFjZWZ1bGx5IGlmIHRoZXJlIGlzIG5vICdjZ3JvdXAua2lsbCcgaW50
ZXJmYWNlLgoodGh1cyBHQU8gV2VpIG5lZWRzIHRvIHJlYmFzZSBoaXMgcGF0Y2ggYWdhaW4pCgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
