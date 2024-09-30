Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9692ACF6497
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 05:42:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 337793C558B
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 07:42:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85EDB3C2F10
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 07:42:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B41111A00890
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 07:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727674943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vy8YkIBe8pJ8b1ir723gfxTxR30tF6f6hotaxQTZjJE=;
 b=J+2rOkcAiDqKGF6n3CgqA9bmBv63rw6bLd4x5xQt1ta5KDHzDHrhNeZIYTU5jQKm1hi3Yu
 iV2U1+6FTh9jZZWe2yybrOaciZia2hsxx2a5y74uWOQBoxG0hh9mWVedmXC2enVslicaAI
 vtqVCVKqCpDjVXzem9ylxls79WREJa0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-dnKfsK-pPL-M6DEovs3bsA-1; Mon, 30 Sep 2024 01:42:20 -0400
X-MC-Unique: dnKfsK-pPL-M6DEovs3bsA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5e1c26c85c2so3758495eaf.0
 for <ltp@lists.linux.it>; Sun, 29 Sep 2024 22:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727674939; x=1728279739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vy8YkIBe8pJ8b1ir723gfxTxR30tF6f6hotaxQTZjJE=;
 b=QJnHhZQWgPaQi9bnnxKTKVAv0SAyqLs+xATepTN4bN9tFY72R2RHM2vTqEmtsxe4Tb
 50GiY1iKaET46nJ8SoaOv16KcbkpWZqQQoX3iLqWzSIRPAavDdAMOm4Mr0xhDKHbYALd
 ru6HhIsjpgActqp4lj2ekhLhbzJmTm8UuNCSb0xn58k2gb21nQL/l1iJOTPcQH4Hvqd6
 0SKgFIa4p0NpP4RSXfdl+5rw2Z5tQkh/4aNrJf8q6J41uKa6wcmvwpw1oMBbE1M10Z1p
 9/MUKbMEjitSuzSmJu50G7kIwmC9iK57ux8W9/q4fQ0OE7KLUTwmeYYK9+ZLp8GHp1TR
 ilFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdD2Sk1Me0NLax/Lol78LsYfa9zz+dTvqMpOyJkKn3fierCF+/FL840M7/hoXUmb5Nbv8=@lists.linux.it
X-Gm-Message-State: AOJu0Yxs/UkCFxd08Q15mHRGjfzoUKzLGTeLWFEl/CIHXmXUp8a8HZZl
 umOkC9Jwo9kHYJ1N1+CFvltOKUlw+5/W5bd8/VZwFAL2PZ4BCZMMfEmYhUkyT35bF9AZpy4/t7K
 9OsbKGe56OFtzJhmlqep4luInmyQ+aVCllZm/SNU984/vJ1svYn6NDaO1zxCBmGD4667bx8SsuG
 p3eFV6LauMNyyhUCqIt8iBQgg=
X-Received: by 2002:a05:6870:3893:b0:277:fbac:1f71 with SMTP id
 586e51a60fabf-28710a0126fmr6216032fac.3.1727674939533; 
 Sun, 29 Sep 2024 22:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwD+fEjloUKqUsxLsTFQUSWAR5QW6VjjNnX9xEYeIC9bwRCmFtDr4J/8wKS1jjtS8YKDouYu/z+DZrBPItr34=
X-Received: by 2002:a05:6870:3893:b0:277:fbac:1f71 with SMTP id
 586e51a60fabf-28710a0126fmr6216028fac.3.1727674939277; Sun, 29 Sep 2024
 22:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240829141002.1962303-1-david@redhat.com>
 <CAASaF6y4R1ESyEjJszM91XAkOa-5Qr_ADuzVYgHy-forQw0eOA@mail.gmail.com>
 <fba9918e-92c2-47ad-b662-bbb83516907a@redhat.com>
In-Reply-To: <fba9918e-92c2-47ad-b662-bbb83516907a@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 30 Sep 2024 07:41:58 +0200
Message-ID: <CAASaF6wTMba9bvp6gXxD4geHLx0nGamaSu2NOiEGjPgs1YMLcA@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] move_pages04: check for "invalid area",
 "no page mapped" and "shared zero page mapped"
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

T24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgNjo1MeKAr1BNIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZp
ZEByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIDI2LjA5LjI0IDExOjA5LCBKYW4gU3RhbmNlayB3
cm90ZToKPiA+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDQ6MTDigK9QTSBEYXZpZCBIaWxkZW5i
cmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBXaGlsZSB0aGUga2VybmVs
IGNvbW1pdCBkODk5ODQ0ZTljOTggKCJtbTogZml4IHN0YXR1cyBjb2RlIHdoaWNoCj4gPj4gbW92
ZV9wYWdlcygpIHJldHVybnMgZm9yIHplcm8gcGFnZSIpIGZpeGVkIHRoZSByZXR1cm4gdmFsdWUg
d2hlbiB0aGUKPiA+PiBzaGFyZWQgemVybyBwYWdlIHdhcyBlbmNvdW50ZXJlZCB0byBtYXRjaCB3
aGF0IHdhcyBzdGF0ZSBpbiB0aGUgbWFuIHBhZ2UsCj4gPj4gaXQgdW5mb3J0dW5hdGVseSBhbHNv
IGNoYW5nZWQgdGhlIGJlaGF2aW9yIHdoZW4gbm8gcGFnZSBpcyBtYXBwZWQgeWV0IC0tCj4gPj4g
d2hlbiBubyBwYWdlIHdhcyBmYXVsdGVkIGluL3BvcHVsYXRlZCBvbiBkZW1hbmQuCj4gPj4KPiA+
PiBUaGVuLCB0aGlzIHRlc3Qgc3RhcnRlZCBmYWlsaW5nLCBhbmQgd2UgdGhvdWdodCB3ZSB3b3Vs
ZCBiZSB0ZXN0aW5nIGZvcgo+ID4+IHRoZSAiemVybyBwYWdlIiBjYXNlLCBidXQgYWN0dWFsbHkg
d2Ugd2VyZSB0ZXN0aW5nIGZvciB0aGUgIm5vIHBhZ2UgbWFwcGVkIgo+ID4+IGNhc2UsIGFuZCBk
aWRuJ3QgcmVhbGl6ZSB0aGF0IHRoZSBrZXJuZWwgY29tbWl0IGhhZCB1bmludGVuZGVkIHNpZGUK
PiA+PiBlZmZlY3RzLgo+ID4+Cj4gPj4gQXMgd2UgYXJlIGNoYW5naW5nIHRoZSBiZWhhdmlvciBi
YWNrIHRvIHJldHVybiAiLUVOT0VOVCIgaW4gdGhlIGtlcm5lbAo+ID4+IGZvciB0aGUgIm5vIHBh
Z2UgbWFwcGVkIiBjYXNlLCB3aGlsZSBzdGlsbCBrZWVwaW5nIHRoZSAic2hhcmVkIHplcm8KPiA+
PiBwYWdlIiBjYXNlIHRvIHJldHVybiAiLUVGQVVMVCIgdGhlIHRlc3Qgc3RhcnRzIGZhaWxpbmcg
YWdhaW4gLi4uCj4gPj4KPiA+PiBUaGUgbWFuIHBhZ2UgY2xlYXJseSBzcGVsbHMgb3V0IHRoYXQg
dGhlIGV4cGVjdGF0aW9uIGZvciB0aGUgemVybyBwYWdlIGlzCj4gPj4gIi1FRkFVTFQiLCBhbmQg
dGhhdCAiLUVGQVVMVCIgY2FuIGFsc28gYmUgcmV0dXJuZWQgaWYgInRoZSBtZW1vcnkgYXJlYSBp
cwo+ID4+IG5vdCBtYXBwZWQgYnkgdGhlIHByb2Nlc3MiIC0tIHdoaWNoIG1lYW5zIHRoYXQgdGhl
cmUgaXMgbm8gVk1BL21tYXAoKQo+ID4+IGNvdmVyaW5nIHRoYXQgYWRkcmVzcy4KPiA+Pgo+ID4+
IFRoZSBtYW4gcGFnZSBhbHNvIGRvY3VtZW50cyB0aGF0ICItRU5PRU5UIiBpcyByZXR1cm5lZCB3
aGVuICJUaGUgcGFnZSBpcwo+ID4+IG5vdCBwcmVzZW50Iiwgd2hpY2ggaW5jbHVkZXMgInRoZXJl
IGlzIG5vdGhpbmcgbWFwcGVkIi4KPiA+Pgo+ID4+IFNvIGxldCdzIGZpeCB0aGUgdGVzdCBhbmQg
cHJvcGVybHkgdGVzdGluZyBmb3IgYWxsIHRocmVlIHNlcGFyYXRlIHRoaW5nczoKPiA+PiAiaW52
YWxpZCBhcmVhL3BhZ2UiLCAibm8gcGFnZSBtYXBwZWQiIGFuZCAic2hhcmVkIHplcm8gcGFnZSBt
YXBwZWQiPgo+ID4+Cj4gPj4gQ2M6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+ID4+
IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgo+ID4+
IC0tLQo+ID4+Cj4gPj4gVGhlIGtlcm5lbCBjaGFuZ2VbMV0gdGhhdCB3aWxsIHJldmVydCB0byB0
aGUgZG9jdW1lbnRlZCBiZWhhdmlvciAtLSByZXR1cm4KPiA+PiAtRU5PRU5UIHdoZW4gbm8gcGFn
ZSBpcyBtYXBwZWQgeWV0IC0tIGlzIG5vdCB1cHN0cmVhbSB5ZXQsIGJ1dCB0aGUKPiA+PiBhc3N1
bXB0aW9uIGlzIHRoYXQgaXQgd2lsbCBnbyB1cHN0cmVhbSBpbiB0aGUgbmV4dCBtZXJnZSB3aW5k
b3csIHRvIGxhbmQKPiA+PiBpbiB2Ni4xMi4KPiA+Cj4gPiBUaGFua3MgZm9yIHBhdGNoLCBsb29r
aW5nIGF0IHRoZSBMaW51cycgdHJlZSBJIHRoaW5rIHRoaXMgbGFuZGVkIGFscmVhZHkuCj4KPiBZ
ZXMsIGl0J3MgdXBzdHJlYW0uCj4KPiA+Cj4gPj4KPiA+PiBDb25zZXF1ZW50bHksIHRoaXMgdGVz
dCB3aWxsIG5vdyBmYWlsIChhcyBleHBlY3RlZCkgb24ga2VybmVscyBiZXR3ZWVuCj4gPj4gdjQu
MyBhbmQgY3VycmVudCBtYWlubGluZS4KPiA+Pgo+ID4+IFdlIHNlZW1lZCB0byBoYXZlICJoYWNr
ZWQiIHRoZSB0ZXN0IHRvIG1ha2Uga2VybmVscyA8IDQuMyBzdGlsbCBwYXNzLAo+ID4+IGV2ZW4g
dGhvdWdoIHRoZXkgd2VyZSBoYW5kbGluZyB6ZXJvIHBhZ2VzIHRoZSB3cm9uZyB3YXkuCj4gPj4K
PiA+PiBTaG91bGQgd2UgYWRkIGEgc2ltaWxhciAiaGFjayIgZm9yIGtlcm5lbHMgPj0gNC4zIHVw
IHRvIHRoZSBvbmUgd2hlcmUKPiA+PiB0aGUga2VybmVsIGJlaGF2aW9yIHdpbGwgY2hhbmdlPyAo
bGlrZWx5IHY2LjEyKT8KPiA+Cj4gPiBJJ20gbGVhbmluZyB0b3dhcmRzIHJlbW92aW5nIHRoZSAi
PCA0LjMgaGFjayIgKGluIGZvbGxvdy11cCBwYXRjaCksIGJlY2F1c2UKPiA+IG9uIGRpc3Ryb3Mg
dGhhdCBkbyBiYWNrcG9ydHMgaXQncyBnb2luZyB0byBiZSBldmVuIG1vcmUgY29uZnVzaW5nLgo+
Cj4gTWFrZXMgc2Vuc2UsIHNvIHdlIHdvdWxkIHJlYWxseSB0ZXN0IGFnYWluc3QgdGhlIGRvY3Vt
ZW50ZWQrZXhwZWN0ZWQKPiBiZWhhdmlvci4KPgo+IEkgd2lsbCByZXNlbmQgd2l0aDoKPgo+ICgx
KSBUaGlzIHBhdGNoLCBpbmNsdWRpbmcgdGhlIHByb3BlciBwYXRjaCBkZXNjcmlwdGlvbgo+ICgy
KSBBIHBhdGNoIHJlbW92aW5nIHRoZSA8IDQuMyBoYWNrCj4gKDMpIEEgcGF0Y2ggdG8gY29udmVy
dCB0aGlzIHRlc3QgdG8gdGhlIG5ldyBBUEkKPgo+Cj4gU291bmRzIGdvb2Q/CgpTb3VuZHMgZ29v
ZCB0byBtZS4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
