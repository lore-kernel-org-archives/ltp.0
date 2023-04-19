Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D5BC77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 11:11:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5929F3CC001
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 13:11:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3151F3C7E58
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:11:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13D81200B37
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681902703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ab5Khx88GqYyQSNOOcrbNYyjvKNVzLSqwCK4gdkQ5SA=;
 b=ZledGoLQ4K5246ofLxCWagjJHWU0B9fWgQJ3Mi4nn8Y536cOc70OJ64FwuAC5vMIcX00xi
 528E7r/sQM11CB7W9nmRAj8GWecuqmkm7cLYggMBlGRTvNJtRWBeMxnBTwa7rEqZql0hQ5
 dvyReANKHi/6qDyViKZ/cfS/V9riFhE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-4Dk8oyCuOG-483yAdJJPqg-1; Wed, 19 Apr 2023 07:11:42 -0400
X-MC-Unique: 4Dk8oyCuOG-483yAdJJPqg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f40f52c604so1844061f8f.0
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 04:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681902701; x=1684494701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ab5Khx88GqYyQSNOOcrbNYyjvKNVzLSqwCK4gdkQ5SA=;
 b=AiYIpMOChg7/qDfRJ1GcwngCDNMMcYiUDr0Or78vcUdpr2bLX47i6GwhfvQyekawAR
 h52KtZkEHSBu0NI8Nc97vit8ahMvv1pP58DLLFFG/Ny2e4tiejaSaifc2OB9CAimjZ6y
 XiTDJxMyNtSDZzb05saijFrOn8YtMAOEv2WmzucaYOUCFMocSJjUmAtsdYPfRyAOu9vB
 0oCcFOeZ7AR9t2is6otTCUIoz4uMA8YkZiPlpSJKERcibQkMdyxzN/o9UEONadma03IV
 AQ50gyydzgWEmfylwrfpxn9pXICA7Q5adr4uvA7I9WAkmjnEnDkHFu/fhQX3/mq3ctCa
 /49A==
X-Gm-Message-State: AAQBX9cofKqMepnZjlnmjNWtRGb9GDlUPJ7lXwzz873FgB2rdkb6B6/+
 1s0FBSD+fv2U8wUq60NNfhoEgroYPRVM2qokMBTbvu8eTMhD2dkaKzrk6Rc+AsTgG11meyb3p3D
 f/ttJDIR2jgMPbrnliF/kTQvDZN0=
X-Received: by 2002:a05:6000:1a47:b0:2f8:fd30:4a7d with SMTP id
 t7-20020a0560001a4700b002f8fd304a7dmr4466635wry.50.1681902700901; 
 Wed, 19 Apr 2023 04:11:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YLW7/04Fs0rUHnE0fUBnjMZNP9/nZwbj3Yi6KwUlvbY+G1wCrBkiK1UH63SgSJgNV5s81E82lG8CscPfCnZrc=
X-Received: by 2002:a05:6000:1a47:b0:2f8:fd30:4a7d with SMTP id
 t7-20020a0560001a4700b002f8fd304a7dmr4466625wry.50.1681902700619; Wed, 19 Apr
 2023 04:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230418130944.181716-1-teo.coupriediaz@arm.com>
 <ZD/JxunXsz7Lms9U@yuki>
In-Reply-To: <ZD/JxunXsz7Lms9U@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2023 19:11:29 +0800
Message-ID: <CAEemH2caEaXVzrgVD70VvvnVYRvo4BLRs1GvbMJutma9p-OW1Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] setpgid02: Use pid_max as PGID for EPERM
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgNjo1OeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJbiBzb21lIHNpbXBsZSBzeXN0ZW1zIChsaWtlIEJ1
c3lib3gpLCB0aGUgbG9naW4gc2hlbGwgbWlnaHQgYmUgcnVuCj4gPiBhcyBpbml0IChQSUQgMSku
Cj4gPiBUaGlzIGxlYWRzIHRvIGEgY2FzZSB3aGVyZSBMVFAgaXMgcnVuIGluIHRoZSBzYW1lIHNl
c3Npb24gYXMgaW5pdCwKPiA+IHRodXMgc2V0cGdpZCBpcyBhbGxvd2VkIHRvIHRoZSBQR0lEIG9m
IGluaXQgd2hpY2ggcmVzdWx0cyBpbiBhIHRlc3QgZmFpbC4KPiA+IEluZGVlZCwgdGhlIHRlc3Qg
cmV0cmlldmVzIHRoZSBQR0lEIG9mIGluaXQgdG8gdHJ5IGFuZCBnZW5lcmF0ZSBFUEVSTS4KPiA+
Cj4gPiBJbnN0ZWFkLCBnZXQgdGhlIFBHSUQgd2UgdXNlIHRvIGdlbmVyYXRlIEVQRVJNIGZyb20g
dGhlIGtlcm5lbCBwaWRfbWF4Lgo+ID4gSXQgc2hvdWxkIG5vdCBiZSB1c2VkIGJ5IGFueSBwcm9j
ZXNzLCBndWFyYW50ZWVpbmcgYSBkaWZmZXJlbnQgc2Vzc2lvbgo+ID4gYW5kIGdlbmVyYXRpbmcg
YW4gRVBFUk0gZXJyb3IuCj4KPiBTbyBJIHN1cHBvc2UgdGhhdCB3ZSBoaXQgc2xpZ2h0bHkgZGlm
ZmVyZW50IGNvbmRpdGlvbiBpbiB0aGUga2VybmVsOgo+Cj4gICAgICAgICBpZiAocGdpZCAhPSBw
aWQpIHsKPiAgICAgICAgICAgICAgICAgc3RydWN0IHRhc2tfc3RydWN0ICpnOwo+Cj4gICAgICAg
ICAgICAgICAgIHBncnAgPSBmaW5kX3ZwaWQocGdpZCk7Cj4gICAgICAgICAgICAgICAgIGcgPSBw
aWRfdGFzayhwZ3JwLCBQSURUWVBFX1BHSUQpOwo+ICAgICAgICAgICAgICAgICBpZiAoIWcgfHwg
dGFza19zZXNzaW9uKGcpICE9IHRhc2tfc2Vzc2lvbihncm91cF9sZWFkZXIpKQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICAgICAgICAgfQo+Cj4gUHJldmlvdXNseSB3ZSB3
ZXJlIHN1cHBvc2VkIHRvIGhpdCB0aGUgdGFza19zZXNzaW9uKGcpICE9Cj4gdGFza19zZXNzaW9u
KGdyb3VwX2xlYWRlcikgbm93IHdlIGhpdCAhZy4KPgoKQWgsIHllcywgdGhhbmtzIGZvciBwb2lu
dGluZyBvdXQgdGhlIGRpZmZlcmVuY2UgZnJvbSB0aGUga2VybmVsIGxheWVyLgoKCgo+Cj4gQWxz
byBJIGd1ZXNzIHRoYXQgdGhlIG9ubHkgd2F5IHRvIGhpdCB0aGUgc2Vjb25kIHBhcnQgb2YgdGhl
IGNvbmRpdGlvbgo+IGlzIHRvIGFjdHVhbGx5IG9wZW4gYW5kIGluaXRpYWxpemUgYSBwdHkgc28g
dGhhdCB3ZSBoYXZlIGEgcHJvY2Vzcwo+IG91dHNpZGUgb2YgdGhlIGN1cnJlbnQgc2Vzc2lvbi4K
PgoKKzEsIHRoaXMgc291bmRzIGNvcnJlY3Qgd2F5IHRvIHJlYWNoIHRoYXQgYnJhbmNoLgpXZSBj
YW4gYWRkIG9uZSBtb3JlIGl0ZW0gaW4gdGhlIHRjYXNlIHN0cnVjdCB0byBjb3ZlciBpdC4KCgoK
Pgo+IFRoZSBwYXRjaCBpdHNlbGYgbG9va3Mgb2theSwgYnV0IHdlIHNob3VsZCBhdCBsZWFzdCB1
cGRhdGUgdGhlCj4gZG9jdW1lbnRhdGlvbiBjb21tZW50IHN1Y2ggYXM6Cj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRwZ2lkL3NldHBnaWQwMi5jCj4gYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0cGdpZDAyLmMKPiBpbmRleCA0YjYzYWZl
ZTguLjY4YjY2MzYzMyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Nl
dHBnaWQvc2V0cGdpZDAyLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBn
aWQvc2V0cGdpZDAyLmMKPiBAQCAtMTMsOCArMTMsOCBAQAo+ICAgKiAtIEVJTlZBTCB3aGVuIGdp
dmVuIHBnaWQgaXMgbGVzcyB0aGFuIDAuCj4gICAqIC0gRVNSQ0ggd2hlbiBwaWQgaXMgbm90IHRo
ZSBjYWxsaW5nIHByb2Nlc3MgYW5kIG5vdCBhIGNoaWxkIG9mCj4gICAqIHRoZSBjYWxsaW5nIHBy
b2Nlc3MuCj4gLSAqIC0gRVBFUk0gd2hlbiBhbiBhdHRlbXB0IHdhcyBtYWRlIHRvIG1vdmUgYSBw
cm9jZXNzIGludG8gYSBwcm9jZXNzCj4gLSAqIGdyb3VwIGluIGEgZGlmZmVyZW50IHNlc3Npb24u
Cj4gKyAqIC0gRVBFUk0gd2hlbiBhbiBhdHRlbXB0IHdhcyBtYWRlIHRvIG1vdmUgYSBwcm9jZXNz
IGludG8gYSBub25leGlzdGluZwo+ICsgKiAgIHByb2Nlc3MgZ3JvdXAuCj4gICAqLwo+Cj4gQW5k
IGlkZWFsbHkgd3JpdGUgYSB0ZXN0IGZvciB0aGUgc2Vjb25kIGNhc2UgYXMgd2VsbC4KPgo+IC0t
Cj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
