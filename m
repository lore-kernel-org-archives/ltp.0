Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87634C2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 13:48:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10FA23D0ECB
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 15:48:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89BCD3CE037
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:47:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2F55208F6B
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718977670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UohROFHM0Fhb4lEJ6xfUKKF6p4fmjbdmzYrfW4y+r1U=;
 b=JtGjiEPDPgiB1IO/mUI/wBwJuWx9ML8VLpK8RIt5ZYIL++FieAqRFWSLpglKU0qbb6vob+
 CU89qffovWdUfxgGLCHv+hbcXOpX+EGS4xuQiUXZXyeNS/Bv3jZpt6GkBXYHSeBMuwl/sJ
 qlFTayL6NIHISPtKRvXaFjTs3KIk7Mk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ugPMTqGtOw-stTru-etDog-1; Fri, 21 Jun 2024 09:47:48 -0400
X-MC-Unique: ugPMTqGtOw-stTru-etDog-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c716d15884so2100771a91.0
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 06:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718977667; x=1719582467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UohROFHM0Fhb4lEJ6xfUKKF6p4fmjbdmzYrfW4y+r1U=;
 b=qTkQR2VMy0xM9dWHAwPVyDZn8Q7FhTReMGb4gHmocO/J0wSu4f/ez0WqJF5r1DAwpk
 JYlDumtnw0OTYCASfrknK81/z1ZG/mbuBFIklTYpLYXlQyae5B10IQ08s/6XCGqF1ovS
 xtzRACE7v7P7TuhDhd353mg2IJ8LSj5Y51IXmeDZ+h3K3w8I992MdN7+AsWoN0M8ZbO2
 dT3Q//OfSEB/EUSUliwSXNm+2S260ZAFO59sOp0Wl7DO4JOj4DqSrCsrz6IqnTbJYubY
 DKp2JzUzP3GdEfVaSUizrtv/NpI8Dn+iSUewXVbw5eshTZDaJTXsgxP0rY/rABEODGvz
 00Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyAUFt8nPUs+7vh57W/xJ7pgT4lfjDqOmatVrOyVjlWI+97jKNokiXCZesJQqbHaW3rl85NiXMPuC/f771/MpqRwc=
X-Gm-Message-State: AOJu0YyRKyHytc+h5BtPuuCDSKt/spp3zcjg79AUtbQyAgvEFtL/5FV6
 kXYIP8v0w61lQwU9sR+mB/jNWH49BEX4z2p+iHRpTXOH+jR1zNyYzvW5m1stBTKBlhCMsriNHKz
 Y/IiE7cV2pBbpYibNiTZAyh2IFBAFOKybG2GByZjKXjqeMppS1n+XYilEhI8Cc3rmsnwE1YDWGv
 E2VpH+VmXUdQydNsSYNGdD8Q4=
X-Received: by 2002:a17:90a:4217:b0:2c8:81b:e798 with SMTP id
 98e67ed59e1d1-2c8081be805mr3393196a91.30.1718977666883; 
 Fri, 21 Jun 2024 06:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5BYvf60rFqMVGOWSVqnzKaAcfRrxGLWOGa+bqf3a4YBXt4JWdMp0vBdQ9I5q/Cr1heCIm+z19el0F51uVPH8=
X-Received: by 2002:a17:90a:4217:b0:2c8:81b:e798 with SMTP id
 98e67ed59e1d1-2c8081be805mr3393185a91.30.1718977666539; Fri, 21 Jun 2024
 06:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki> <20240620053618.GD537887@pevik>
 <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
 <CAEemH2dVaMfNPP2m8_nEb235=9Q5bo4H1WtQbpFgrcmyyVESfw@mail.gmail.com>
 <20240621133911.GA694629@pevik>
In-Reply-To: <20240621133911.GA694629@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2024 21:47:34 +0800
Message-ID: <CAEemH2fi-7kF-RLCQvgyqJyTCNHCX-3DnxCn1+LFLk1-z09rUA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

T24gRnJpLCBKdW4gMjEsIDIwMjQgYXQgOTozOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IEhpIEFsbCwKPgo+ID4gSSBjb21lIHVwIHdpdGgg
YSB3YXkgdG8gZGVmaW5lIHNpbXBsZSBtYWNyb3MgZm9yIGFsbCBMVFAgcHJpbnQsCj4gZXNwZWNp
YWxseQo+ID4gZm9yIFRGQUlMCj4gPiB3ZSBjb3VsZCBtYWtlIHVzZSBvZiB0aGUgR0VUX01BQ1JP
IHRvIHNlbGVjdCBhIHNwZWNpZmljIG1hY3JvCj4gaW1wbGVtZW50YXRpb24KPiA+IGJhc2VkIG9u
IHRoZSBudW1iZXIgb2YgYXJndW1lbnRzIHByb3ZpZGVkIHRvIGEgdmFyaWFkaWMgbWFjcm8uCj4K
PiA+IFNvbWV0aGluZyBwYXJ0bHkgbGlrZToKPgo+ID4gLS0tIGEvaW5jbHVkZS90c3RfdGVzdF9t
YWNyb3MuaAo+ID4gKysrIGIvaW5jbHVkZS90c3RfdGVzdF9tYWNyb3MuaAo+ID4gQEAgLTM2OCw0
ICszNjgsMjggQEAgY29uc3QgY2hhciAqdHN0X2Vycm5vX25hbWVzKGNoYXIgKmJ1ZiwgY29uc3Qg
aW50Cj4gPiAqZXhwX2VycnMsIGludCBleHBfZXJyc19jbnQpOwo+ID4gICNkZWZpbmUgVFNUX0VY
UF9FUV9TU1ooVkFMX0EsIFZBTF9CKSBcCj4gPiAgICAgICAgICAgICAgICAgVFNUX0VYUF9FUV8o
VkFMX0EsICNWQUxfQSwgVkFMX0IsICNWQUxfQiwgc3NpemVfdCwgIiV6aSIpCj4KPiA+ICsvKlRT
VF9SRVMqLwo+ID4gKyNkZWZpbmUgVFNUX1JFU19USU5GTyhNRVNTQUdFKSBcCj4gPiArICAgICAg
IHRzdF9yZXMoVElORk8sIE1FU1NBR0UpOwo+ID4gKwo+ID4gKyNkZWZpbmUgVFNUX1JFU19UV0FS
TihNRVNTQUdFKSBcCj4gPiArICAgICAgIHRzdF9yZXMoVElORk8sICJXQVJOSU5HICJNRVNTQUdF
KTsKPiA+ICsKPiA+ICsjZGVmaW5lIFRTVF9SRVNfVENPTkYoTUVTU0FHRSkgXAo+ID4gKyAgICAg
ICB0c3RfcmVzKFRDT05GLCBNRVNTQUdFKTsKPiA+ICsKPiA+ICsjZGVmaW5lIFRTVF9SRVNfVFBB
U1MoTUVTU0FHRSkgXAo+ID4gKyAgICAgICB0c3RfcmVzKFRQQVNTLCBNRVNTQUdFKTsKPiA+ICsK
PiA+ICsjZGVmaW5lIFRTVF9SRVNfVEZBSUwoLi4uKSBcCj4gPiArICAgICAgICAgICBHRVRfTUFD
Uk8oX19WQV9BUkdTX18sIFRTVF9SRVNfRkFJTDIsCj4gPiBUU1RfUkVTX0ZBSUwxKShfX1ZBX0FS
R1NfXykKPiA+ICsKPiA+ICsjZGVmaW5lIEdFVF9NQUNSTyhfMSwgXzIsIE5BTUUsIC4uLikgTkFN
RQo+ID4gKwo+ID4gKyNkZWZpbmUgVFNUX1JFU19GQUlMMShNRVNTQUdFKSBcCj4gPiArICAgICAg
ICAgICB0c3RfcmVzKFRGQUlMLCBNRVNTQUdFKQo+ID4gKwo+ID4gKyNkZWZpbmUgVFNUX1JFU19G
QUlMMihmbGFnLCBNRVNTQUdFKSBcCj4gPiArICAgICAgICAgICB0c3RfcmVzKFRGQUlMIHwgZmxh
ZywgTUVTU0FHRSkKPiA+ICsKPiA+ICAjZW5kaWYgLyogVFNUX1RFU1RfTUFDUk9TX0hfXyAqLwo+
ID4gZGlmZiAtLWdpdCBhL2xpYi9uZXdsaWJfdGVzdHMvdHN0X3Jlc19tYWNyb3MuYwo+ID4gYi9s
aWIvbmV3bGliX3Rlc3RzL3RzdF9yZXNfbWFjcm9zLmMKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cj4gPiBpbmRleCAwMDAwMDAwMDAuLmUxNmYzY2JiYQo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysr
IGIvbGliL25ld2xpYl90ZXN0cy90c3RfcmVzX21hY3Jvcy5jCj4gPiBAQCAtMCwwICsxLDIyIEBA
Cj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ICsv
Kgo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4K
PiA+ICsgKi8KPiA+ICsKPiA+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiA+ICsjaW5jbHVkZSAi
dHN0X3Jlc19mbGFncy5oIgo+ID4gKyNpbmNsdWRlICJ0c3RfdGVzdF9tYWNyb3MuaCIKPiA+ICsK
PiA+ICtzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBpKQo+ID4gK3sKPiA+ICsgICAg
ICAgVFNUX1JFU19USU5GTygibWVzc2FnZSIpOwo+ID4gKyAgICAgICBUU1RfUkVTX1RQQVNTKCJt
ZXNzYWdlIik7Cj4gPiArICAgICAgIFRTVF9SRVNfVFdBUk4oIm1lc3NhZ2UiKTsKPiA+ICsgICAg
ICAgVFNUX1JFU19URkFJTCgibWVzc2FnZSIpOwo+ID4gKyAgICAgICBUU1RfUkVTX1RGQUlMKFRF
UlJOTywgIm1lc3NhZ2UiKTsKPiA+ICsgICAgICAgVFNUX1JFU19URkFJTChUVEVSUk5PLCAibWVz
c2FnZSIpOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7
Cj4gPiArICAgICAgIC50ZXN0X2FsbCA9IGRvX3Rlc3QsCj4gPiArfTsKPgo+IFJldmlld2VkLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBUaGFua3MhCj4KClRoYW5rIHlvdSBzbyBt
dWNoLgoKTm90ZToKCkJhc2ljYWxseSwgdGhlIG1ldGhvZCB3b3JrcyB3ZWxsLCBidXQgY29udGFp
bnMgYSB0aW55IGlzc3VlIHRoYXQgcGVvcGxlCnNvbWV0aW1lcyBuZWVkIHRvIHByaW50IHZhcmlh
YmxlIHZhbHVlIGluIHRzdF9yZXMoLCAidmFsID0gJWQiLCB2YWwpLApzbyBpdCBzdGlsbCBuZWVk
cyByZWZpbmVkIGNvZGUgdG8gcmVzb2x2ZSB0aGF0LgoKSSB3aWxsIHNlbmQgb3V0IGEgZnVsbCBz
dXBwb3J0IHBhdGNoIGFmdGVyIHRlc3RpbmcgZ29vZCBvbiBteSBzaWRlLgoobWF5YmUgdG9tb3Jy
b3cpLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
