Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A0C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 08:20:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C6703D0DD8
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 10:20:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EF093CB2A8
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 10:20:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 92A642102EF
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 10:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718871621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaAwN3A2iLyJNP+NVAv4H8/wBrthoOdhEC9ZVHxp5Uo=;
 b=Xqxw348+bqfTibJqB8XzsCDswi7+cVsmammXrTTKFoJcjQGtv1OvkHffTiPjAH/pQ26aIr
 qfqfo5sk5jLjGGJpquT5p/ENqv9b2tRw3Yiigy9opCudsRciYxKtLiK4bU7RigkgPrZZ58
 krGVZOpmTMXppWJVzPOneKmOubyglpI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-dDc-KvP7OrWxniQapfkwzw-1; Thu, 20 Jun 2024 04:20:18 -0400
X-MC-Unique: dDc-KvP7OrWxniQapfkwzw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c7c3069f37so806595a91.0
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 01:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718871617; x=1719476417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jaAwN3A2iLyJNP+NVAv4H8/wBrthoOdhEC9ZVHxp5Uo=;
 b=YfIfWxEcOhH0RIZz6WHCqp38uieTmYBfQfoSFSzPvkrA0KLKmm2f2Q/Q2A+ZCPukYC
 R0qr7Ta/t35vtk8iM1yXHa6fpyx4NDAQCO1vDtFeok0yfJzEt1ItHjCoEEsrtDXYFWIZ
 DRrFKsnNANHXGzYyvGkP+TcptmHImoWWY2C7BWkwG/xTI6frfaoqAm5K+dEo+4KODeur
 W2x5mPkOhaeNiz2BcRoPn5g/8Wmirchc1t+1g5jrTVsk6Tlx+Zaazo5iY5b+i5WaIQ1r
 rK7rAkmTwDDZE31FgHxyYbQtgx38QC8QvsZJNrT4gCZiOr/YLHVVbaNw0IYGXc88sPte
 pSug==
X-Gm-Message-State: AOJu0Yw0PVbC53ZJ0qYfBXdLUYU8xy6/BQ7DrO1sBUHwPUq4jPkQVvoo
 8MY6vFVjbAs5h35e4x1PVXRCNwue8kvVnhaj6okV4UBNr4oyaUkO6JRV1RfvrpafcF50lhCpmve
 rnRxor3dLQh8PXAUuVxRsZAN/QB0gDQQYOeGNtDx+lJmiw7wUyhhj84pMSxCBXEOlD2uLl/wc5q
 sHl19pFyCeVeeoggVQezGrAN0=
X-Received: by 2002:a17:90a:744d:b0:2c3:1f27:e7e2 with SMTP id
 98e67ed59e1d1-2c7b5dab38amr4531311a91.40.1718871617682; 
 Thu, 20 Jun 2024 01:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG4fsueVA5b6lHwGKbatOS3im8qbySKJ6JUgHgHptwamNjK0J8qe1H4uAZ7Kf4NRPfLnHmGLv1Rtp4mVkadrI=
X-Received: by 2002:a17:90a:744d:b0:2c3:1f27:e7e2 with SMTP id
 98e67ed59e1d1-2c7b5dab38amr4531303a91.40.1718871617371; Thu, 20 Jun 2024
 01:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240620021635.489505-1-liwang@redhat.com>
 <CAEemH2ctF+3AEZkm4Y+KkcTUgYGM4XD24pkfwdJo=6ynQ-Wgxg@mail.gmail.com>
 <20240620052100.GC537887@pevik>
In-Reply-To: <20240620052100.GC537887@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jun 2024 16:20:05 +0800
Message-ID: <CAEemH2fd-b-apt-ifnAMDcq5ogCD1FJm+rHpq6R_6D9yvxuDbA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_kconfig: Avoid reporting buffer overflow
 when parsing /proc/cmdline
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

T24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMToyMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiAgTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4g
PiBXaGVuIHRoZSB0ZXN0IGlzIHJ1biB3aXRoIGEga2VybmVsIGJvb3Rpbmcgd2l0aCBtYW55IHBh
cmFtZXRlcnMsIHRoZQo+ID4gPiBidWZmZXIgc2l6ZSBpcyBvZnRlbiBub3QgbGFyZ2UgZW5vdWdo
IHRvIHN0b3JlIHRoZSBjb21wbGV0ZSBjb21tYW5kCj4gPiA+IGxpbmUuIFRoaXMgcmVzdWx0cyBp
biBhIGJ1ZmZlciBvdmVyZmxvdyBhbmQgdGhlIHRlc3QgY29tcGxhaW5zIHdpdGgKPiA+ID4gdGhl
IGZvbGxvd2luZyBtZXNzYWdlOgo+Cj4gPiA+ICAgdHN0X2tjb25maWcuYzo2MDk6IFRXQVJOOiBC
dWZmZXIgb3ZlcmZsb3dlZCB3aGlsZSBwYXJzaW5nCj4gL3Byb2MvY21kbGluZQo+Cj4gPiA+IE5v
dGU6Cj4KPiA+ID4gUGV0ciBwb2ludCBvdXQgdGhhdCB0aGVzZSBjb25maWdzLCB3aGljaCBhcmUg
Z2VuZXJhdGVkIGJ5IHRvb2xjaGFpbgo+IHdpbGwKPiA+ID4gYmUgbG9uZ2VyIHRoYW4gMTI4IGNo
YXJzIHNvbWVkYXksIGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgdGhlIHJlYXNvbgo+ID4gPiB3
ZSBuZWVkIHJhaXNlIG91ciBwYXJzZWQgYnVmZmVyLCBzaW5jZSB0c3Rfa2NtZGxpbmVfcGFyc2Uo
KSB3YXMganVzdAo+IGFkZAo+ID4gPiBmb3IgcG9wdWxhciBwYXJhbWV0ZXIgKHdoaWNoIGFsd2F5
cyBwYXNzIGJ5IHVzZXIgYW5kIHNob3J0KS4gU28gZmFyIEkKPiA+ID4gZG9uJ3Qgc2VlIGFueSBM
VFAgdGVzdCBwYXJzZSBhIGxvbmdlciBwYXJhbWV0ZXJzLgo+Cj4gPiA+IEZpeGVzOiAxODA4MzQ5
ODIgKCJrY29uZmlnOiBhZGQgZnVudGlvbiB0byBwYXJzZSAvcHJvYy9jbWRsaW5lIikKPiA+ID4g
U2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiA+IENjOiBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+ID4gLS0tCj4gPiA+ICBpbmNsdWRlL3RzdF9rY29u
ZmlnLmggfCAyICstCj4gPiA+ICBsaWIvdHN0X2tjb25maWcuYyAgICAgfCA0ICsrLS0KPiA+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9rY29uZmlnLmggYi9pbmNsdWRlL3RzdF9rY29uZmln
LmgKPiA+ID4gaW5kZXggZGNiMzcwNTc0Li4yM2Y4MDc0MDkgMTAwNjQ0Cj4gPiA+IC0tLSBhL2lu
Y2x1ZGUvdHN0X2tjb25maWcuaAo+ID4gPiArKysgYi9pbmNsdWRlL3RzdF9rY29uZmlnLmgKPiA+
ID4gQEAgLTg3LDcgKzg3LDcgQEAgaW50IHRzdF9rY29uZmlnX2NoZWNrKGNvbnN0IGNoYXIgKmNv
bnN0IGtjb25maWdzW10pOwo+ID4gPiAgICovCj4gPiA+ICBzdHJ1Y3QgdHN0X2tjbWRsaW5lX3Zh
ciB7Cj4gPiA+ICAgICAgICAgY29uc3QgY2hhciAqa2V5Owo+ID4gPiAtICAgICAgIGNoYXIgdmFs
dWVbMTI4XTsKPiA+ID4gKyAgICAgICBjaGFyIHZhbHVlWzI1Nl07Cj4gPiA+ICAgICAgICAgYm9v
bCBmb3VuZDsKPiA+ID4gIH07Cj4KPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi90c3Rfa2NvbmZpZy5j
IGIvbGliL3RzdF9rY29uZmlnLmMKPiA+ID4gaW5kZXggZTE2Y2ExNDAwLi44ZWIxYjgwM2YgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2xpYi90c3Rfa2NvbmZpZy5jCj4gPiA+ICsrKyBiL2xpYi90c3Rfa2Nv
bmZpZy5jCj4gPiA+IEBAIC01NjksNyArNTY5LDcgQEAgY2hhciB0c3Rfa2NvbmZpZ19nZXQoY29u
c3QgY2hhciAqY29uZm5hbWUpCj4KPiA+ID4gIHZvaWQgdHN0X2tjbWRsaW5lX3BhcnNlKHN0cnVj
dCB0c3Rfa2NtZGxpbmVfdmFyIHBhcmFtc1tdLCBzaXplX3QKPiA+ID4gcGFyYW1zX2xlbikKPiA+
ID4gIHsKPiA+ID4gLSAgICAgICBjaGFyIGJ1ZlsxMjhdLCBsaW5lWzUxMl07Cj4gPiA+ICsgICAg
ICAgY2hhciBidWZbMjU2XSwgbGluZVs1MTJdOwo+Cj4KPiA+IFBldHIsIGlmIHlvdSBhcmUgc3Rp
bGwgd29ycmllZCwgZmVlbCBmcmVlIHRvIGVubGFyZ2UgdGhlbSB0byBjaGFyCj4gPiAnYnVmWzUx
Ml0sIGxpbmVbMjA0OF07JyBkdXJpbmcgbWVyZ2UgOikuCj4KPiBMaSwgSSdtIG9rIHdpdGggMjU2
IDopLgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKVGhhbmtz
LgoKCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzKFRXQVJOLCAiQnVm
ZmVyIG92ZXJmbG93ZWQgd2hpbGUKPiBwYXJzaW5nIC9wcm9jL2NtZGxpbmUiKTsKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJCdWZmZXIgb3ZlcmZsb3dl
ZCB3aGlsZQo+IHBhcnNpbmcgL3Byb2MvY21kbGluZSIpOwo+Cj4KCj4gQnV0IEkgd29uZGVyIGlm
IHdlIHNob3VsZCBrZWVwIFRXQVJOLiBPciBhdCBsZWFzdCBhZGQKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJXQVJOSU5HOiBCdWZmZXIgb3ZlcmZsb3dl
ZAo+IHdoaWxlIHBhcnNpbmcgL3Byb2MvY21kbGluZSIpOwo+CgorMSwgSSdkIG1lcmdlIGxpa2Ug
dGhpcyBpZiBDeXJpbCBoYXMgbm8gbW9yZSBjb21tZW50cy4KCgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
