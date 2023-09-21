Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43397E706F2
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 08:43:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A0693CDEA5
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 10:43:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 577643CDE7C
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 10:43:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2C08F1A05C7E
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 10:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695285812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UHJh1AZeooSK9GTu1bzllXmFLvbVT3a+nlznWIF8/w=;
 b=JD5qURs62BAHVTX3q8NibeZq9JbU5u+OAmpTHIkLRyxSqYuYA4ClA2yAHfHHnZGBwtZIZf
 ZSuK9xkUCl9s0N9EUi+yVhgagDAUsvES+e1kEarFUFf4s7rMn8Ei/vvYxIws3kU+7+qUg0
 c0BDv8t6fcz5o8lofqjQLnZEBTxKE+4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-DkQhlLJ3PzWL_XIAbR0oiw-1; Thu, 21 Sep 2023 04:43:31 -0400
X-MC-Unique: DkQhlLJ3PzWL_XIAbR0oiw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-450a8011aa4so301953137.2
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 01:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695285810; x=1695890610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UHJh1AZeooSK9GTu1bzllXmFLvbVT3a+nlznWIF8/w=;
 b=UAl/Kxb0suptRQ/OGPL2CU5sCocE/8yOuBL8eHOUeQVubBmqYlDLGdY85oZnjnavO3
 Qsv9T8MSVLww6txf2yNv80rY/c7BoPxswykHF6+O0kbnVxr+cLf9Ng2qkaNc53s0z8ZX
 adNKKu8mJrhUvHOMnF69vvUuxrGGJjQn3EdI8r5phlA7Hi0lLI8+Ztq+gy/DVWCWY1Yw
 uG9sjVsMoJ1dNPKWsqjsVuzRWIVEzpAvS8toTM5uH4tO/XsBOYgm4uz20tepd9Dy6+Il
 a2vLxD92pcoqMooVcjvg5AxyhiHEaaTk3tHKPV9RZAA8DnLU0IN8NGDjBfMzxzpqRkIO
 URaA==
X-Gm-Message-State: AOJu0YwhtO31lZO3JIzBh3b3YLpy8GtiX1K3LrRyFL6jb1TXKNiFFBBX
 yWVcJpH/gPsmKRqukLRvEyldAgyM+xrKQafiJPMWgh4XyWUIMwIDvOQtdJ2u7S7n8UOvsNdsQoP
 9Sau77BiZ/XVN+qCQ+TV3M5WPn3I=
X-Received: by 2002:a67:efd6:0:b0:44e:89bd:9a5c with SMTP id
 s22-20020a67efd6000000b0044e89bd9a5cmr4847115vsp.10.1695285809881; 
 Thu, 21 Sep 2023 01:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkTVRaAM4MRAm+gJwLcWHqkxHF6UN50Nl9HEg48uoohyvI/wcTUYmWKj6w96t43AG44CIRmR4/6P955+KD3Mw=
X-Received: by 2002:a67:efd6:0:b0:44e:89bd:9a5c with SMTP id
 s22-20020a67efd6000000b0044e89bd9a5cmr4847103vsp.10.1695285809578; Thu, 21
 Sep 2023 01:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230920095318.340582-1-pvorel@suse.cz>
 <CAEemH2fKvKrN_S1j34UpfzDpqob_sasuxGt8Ji81TkzEFpt_UQ@mail.gmail.com>
In-Reply-To: <CAEemH2fKvKrN_S1j34UpfzDpqob_sasuxGt8Ji81TkzEFpt_UQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Sep 2023 10:43:13 +0200
Message-ID: <CAASaF6xMijTern9QA4B3zT93kDaZdxK_JMa=+bVMctOtdG5m7g@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] Release scripts and docs
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMTA6MTjigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBIaSBQZXRyLCBBbGwsCj4KPiBUaGFua3MgZm9yIHdyaXRpbmcgZG93
biB0aGUgcmVsZWFzZSBwcm9jZWR1cmUsIHZlcnkgdXNlZnVsLgoKKzEgZm9yIGhhdmluZyBkb2N1
bWVudGVkIHN0ZXBzCgo+Cj4gQnV0IEkgZG91YnQgdGhhdCB3ZSByZWFsbHkgbmVlZCB0aGUgc2Ny
aXB0cyB0byBkbyByZWxlYXNlIHdvcmsKPiBhdXRvbWF0aWNhbGx5IHNpbmNlIHdlIF9vbmx5XyBk
byB0aGUgcmVsZWFzZSBldmVyeSBmb3VyIG1vbnRocy4KPiBJdCBzZWVtcyB0byBicmluZyBhZGRp
dGlvbmFsIG1haW50ZW5hbmNlIHdvcmsgdW5uZWNlc3NhcmlseS4KPgo+IEkgcGVyc29uYWxseSB0
aGluayB0aGUgbWFudWFsIHN0ZXAgaXMgZGV0YWlsZWQgZW5vdWdoIGZvciB1cy4KPiBCdXQgYW55
d2F5LCBub3cgeW91IGhhdmUgZG9uZSB0aGUgYXV0b21hdGlvbiwgSSBkb24ndCBoYXZlCj4gYW4g
b2JqZWN0aW9uIHRvIHlvdXIgcGF0Y2ggc2V0LCBqdXN0IGZlZWwgdGhhdCB3ZSBhdXRvbWF0ZSBm
b3IgdGhlCj4gc2FrZSBvZiBhdXRvbWF0aW9uIDopLgo+Cj4gSSdkIGxpa2UgdG8gaGVhciBtb3Jl
IG9waW5pb25zLCBidXQgaWYgbW9zdCBvZiB1cyB0aGluayB0aGUgc2NyaXB0IGlzCj4gbmVjZXNz
YXJ5LCBJJ20gaGFwcHkgdG8gYWNjZXB0IHRoZW0gYXMgd2VsbC4KCkFzIHNvbWVvbmUgd2hvIGhh
c24ndCBkb25lIHJlbGVhc2UgYmVmb3JlLCBJJ2QgcHJvYmFibHkgZG8gaXQKbWFudWFsbHkgZmly
c3QtdGltZSB0byBkb3VibGUtY2hlY2sgZWFjaCBzdGVwLgoKSXQncyBwcm9iYWJseSBub3QgbmVj
ZXNzYXJ5LCBidXQgcGVvcGxlIHdobyBkaWQgcmVsZWFzZXMgbWFueSB0aW1lcyBtYXkKZmluZCBp
dCB1c2VmdWwgLSBJJ20gYXNzdW1pbmcgdGhlIHJlbGVhc2UgcHJvY2VkdXJlIGlzbid0IGNoYW5n
aW5nCnRoYXQgZnJlcXVlbnRseS4KCj4KPgo+IE9uIFdlZCwgU2VwIDIwLCAyMDIzIGF0IDU6NTPi
gK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4+Cj4+IEhpLAo+Pgo+PiBj
b3B5IHBhc3RpbmcgcmVsZWFzZSBpcyBlcnJvciBwcm9uZSwgdGh1cyBJIHdyb3RlIHJlbGVhc2Ug
c2NyaXB0cy4KPj4gQW55IGNoYW5nZSB5b3Ugd291bGQgaGF2ZSBsb29rIG9uIGl0IGJlZm9yZSBy
ZWxlYXNlPwo+Pgo+PiAyIGNvbW1pdHMgd2VyZSBhbHJlYWR5IHBvc3RlZCBiZWZvcmUsIExpIGhh
ZCBzb21lIG5vdGVzIGFib3V0IHRoZQo+PiBwcm9jZWR1cmUsIHRodXMgSSB1cGRhdGVkIGl0Lgo+
Pgo+PiBLaW5kIHJlZ2FyZHMsCj4+IFBldHIKPj4KPj4gUGV0ciBWb3JlbCAoNSk6Cj4+ICAgdG9v
bHM6IEFkZCBhIHNjcmlwdCBmb3IgdGFnZ2luZyB0aGUgcmVsZWFzZQo+PiAgIHRvb2xzOiBBZGQg
c2NyaXB0IGZvciBjcmVhdGluZyB0YXJiYWxscyBhbmQgbWV0YWRhdGEKPj4gICBkb2M6IFJlbmFt
ZSBmaWxlcyB0byBuYW1lcyBmcm9tIGx0cC53aWtpLmdpdAo+PiAgIGRvYzogQWRkIFJlbGVhc2Ug
cHJvY2VkdXJlCj4+ICAgZG9jOiBVcGRhdGUgcmVsZWFzZSBwcm9jZWR1cmUKPj4KPj4gIC5naXRo
dWIvd29ya2Zsb3dzL3dpa2ktbWlycm9yLnltbCAgICAgICAgICAgICB8ICAxNiArLS0KPj4gIC4u
LmlsZC1zeXN0ZW0tZ3VpZGUudHh0ID0+IEJ1aWxkLVN5c3RlbS5yZXN0fSB8ICAgMAo+PiAgZG9j
L3tjLXRlc3QtYXBpLnR4dCA9PiBDLVRlc3QtQVBJLmFzY2lpZG9jfSAgIHwgICAwCj4+ICAuLi5t
cGxlLnR4dCA9PiBDLVRlc3QtQ2FzZS1UdXRvcmlhbC5hc2NpaWRvY30gfCAgIDAKPj4gIC4uLi1j
LWFwaS50eHQgPT4gQy1UZXN0LU5ldHdvcmstQVBJLmFzY2lpZG9jfSB8ICAgMAo+PiAgLi4ua3Zt
LXRlc3QtYXBpLnR4dCA9PiBLVk0tVGVzdC1BUEkuYXNjaWlkb2N9IHwgICAwCj4+ICAuLi5QLUxp
YnJhcnktQVBJLVdyaXRpbmctR3VpZGVsaW5lcy5hc2NpaWRvY30gfCAgIDAKPj4gIGRvYy9MVFAt
UmVsZWFzZS1Qcm9jZWR1cmUuYXNjaWlkb2MgICAgICAgICAgICB8IDExNiArKysrKysrKysrKysr
KysrKysKPj4gIC4uLmFpbnRhaW5lci1QYXRjaC1SZXZpZXctQ2hlY2tsaXN0LmFzY2lpZG9jfSB8
ICAgMAo+PiAgLi4ubC10ZXN0LWFwaS50eHQgPT4gU2hlbGwtVGVzdC1BUEkuYXNjaWlkb2N9IHwg
ICAwCj4+ICAuLi5rZXJuZWwsLWxpYmMsLXRvb2xjaGFpbi12ZXJzaW9ucy5hc2NpaWRvY30gfCAg
IDAKPj4gIC4uLnMudHh0ID0+IFRlc3QtV3JpdGluZy1HdWlkZWxpbmVzLmFzY2lpZG9jfSB8ICAg
MAo+PiAgLi4uc2VyLWd1aWRlLnR4dCA9PiBVc2VyLUd1aWRlbGluZXMuYXNjaWlkb2N9IHwgICAw
Cj4+ICB0b29scy9jcmVhdGUtdGFyYmFsbHMtbWV0YWRhdGEuc2ggICAgICAgICAgICAgfCAgNTIg
KysrKysrKysKPj4gIHRvb2xzL2xpYi5zaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzMSArKysrKwo+PiAgdG9vbHMvdGFnLXJlbGVhc2Uuc2ggICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDgwICsrKysrKysrKysrKwo+PiAgMTYgZmlsZXMgY2hhbmdlZCwgMjgyIGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+PiAgcmVuYW1lIGRvYy97YnVpbGQtc3lzdGVtLWd1
aWRlLnR4dCA9PiBCdWlsZC1TeXN0ZW0ucmVzdH0gKDEwMCUpCj4+ICByZW5hbWUgZG9jL3tjLXRl
c3QtYXBpLnR4dCA9PiBDLVRlc3QtQVBJLmFzY2lpZG9jfSAoMTAwJSkKPj4gIHJlbmFtZSBkb2Mv
e2MtdGVzdC10dXRvcmlhbC1zaW1wbGUudHh0ID0+IEMtVGVzdC1DYXNlLVR1dG9yaWFsLmFzY2lp
ZG9jfSAoMTAwJSkKPj4gIHJlbmFtZSBkb2Mve25ldHdvcmstYy1hcGkudHh0ID0+IEMtVGVzdC1O
ZXR3b3JrLUFQSS5hc2NpaWRvY30gKDEwMCUpCj4+ICByZW5hbWUgZG9jL3trdm0tdGVzdC1hcGku
dHh0ID0+IEtWTS1UZXN0LUFQSS5hc2NpaWRvY30gKDEwMCUpCj4+ICByZW5hbWUgZG9jL3tsaWJy
YXJ5LWFwaS13cml0aW5nLWd1aWRlbGluZXMudHh0ID0+IExUUC1MaWJyYXJ5LUFQSS1Xcml0aW5n
LUd1aWRlbGluZXMuYXNjaWlkb2N9ICgxMDAlKQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9M
VFAtUmVsZWFzZS1Qcm9jZWR1cmUuYXNjaWlkb2MKPj4gIHJlbmFtZSBkb2Mve21haW50YWluZXIt
cGF0Y2gtcmV2aWV3LWNoZWNrbGlzdC50eHQgPT4gTWFpbnRhaW5lci1QYXRjaC1SZXZpZXctQ2hl
Y2tsaXN0LmFzY2lpZG9jfSAoMTAwJSkKPj4gIHJlbmFtZSBkb2Mve3NoZWxsLXRlc3QtYXBpLnR4
dCA9PiBTaGVsbC1UZXN0LUFQSS5hc2NpaWRvY30gKDEwMCUpCj4+ICByZW5hbWUgZG9jL3tzdXBw
b3J0ZWQta2VybmVsLWxpYmMtdmVyc2lvbnMudHh0ID0+IFN1cHBvcnRlZC1rZXJuZWwsLWxpYmMs
LXRvb2xjaGFpbi12ZXJzaW9ucy5hc2NpaWRvY30gKDEwMCUpCj4+ICByZW5hbWUgZG9jL3t0ZXN0
LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQgPT4gVGVzdC1Xcml0aW5nLUd1aWRlbGluZXMuYXNjaWlk
b2N9ICgxMDAlKQo+PiAgcmVuYW1lIGRvYy97dXNlci1ndWlkZS50eHQgPT4gVXNlci1HdWlkZWxp
bmVzLmFzY2lpZG9jfSAoMTAwJSkKPj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy9jcmVhdGUt
dGFyYmFsbHMtbWV0YWRhdGEuc2gKPj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy9saWIuc2gK
Pj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy90YWctcmVsZWFzZS5zaAo+Pgo+PiAtLQo+PiAy
LjQwLjEKPj4KPgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
