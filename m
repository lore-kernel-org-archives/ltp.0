Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CDAC31D97
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 12:03:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0128C3D3CFD
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 14:03:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C23383D3CBA
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 14:03:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E4EB31BC1BF6
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 14:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720094592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9perKbxAzPyHsqsj43tLLMBTrlu4FrRjzgadVyHrhU=;
 b=Jqg7rksAd8jbii7YDfVCe30U5jKX53UK8XeZyhMe8U76HFqDitGRoOhP8cGs2z3TpnmTx1
 5eZj45PB68lQjALH9hC1LH7fPJbhRnRNhLxJybMVDpO77bOh64yiKsiYg58jPjx4v3DVn0
 m7ZnZ8bM2XJ4vNwYDkZw5gak8tZ5EA4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-_muom0VBPceFXET8LlKI2A-1; Thu, 04 Jul 2024 08:03:00 -0400
X-MC-Unique: _muom0VBPceFXET8LlKI2A-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-715e59afb63so458422a12.2
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 05:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720094579; x=1720699379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9perKbxAzPyHsqsj43tLLMBTrlu4FrRjzgadVyHrhU=;
 b=TSR4HbTScFW8WszaKYOf3VVI1jYVkeJiAHx1APR1K0SHkDn87ZvtFGGsDTVldhVZDx
 /j8Oe4bab7iVHvF+pfVfyBJcYDPpxZa3vAPQbBSwpPBgX95onD2BRyDuWYEiJN/GyBwA
 5cO843xCMIPESVYIgMYJ70aOs9rFj1DH+nocYXWrVSMrlajnjVWUHRmBmZKXDEiM6F9I
 gYyvM6nR2M0aS9J98hLtmbV+p7CijdNB3rK5Fw1jBgfuM5avQtGD2wokwmNmDJdOx41J
 OdCmkREf4ExY+XwOGYDXdvbSFwBRp4A5v/piBD7uOAUgwRXhZgs3hK57Cvbx4Bff+oFN
 0UgA==
X-Gm-Message-State: AOJu0YzVMc+XyXSKyF3wg8X05xLzIMk/MnyktnpSyeUTeb0ofbe1eKZy
 MS3wGZoay+qK11vTWu4czrdPQF/UbYsaHgn2MvWlDRJx/J+FATUl/ICtp8grIPzkUNejFnX72Q3
 f89034nUb2RAlUsgZjaOQPmb7V2WI1YXMgAWJ5d4MXQ7v/SFd6r4LzVgud6N+3G1pRGC8dk8MYp
 32TxrK9MpmzjnWGdiDVL1ML0gmvEUBD8dNGL3c
X-Received: by 2002:a05:6a20:3943:b0:1bd:234f:ea6c with SMTP id
 adf61e73a8af0-1c0cc727f6bmr1452026637.13.1720094579079; 
 Thu, 04 Jul 2024 05:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyg5VR5JyoRECkPEVdd1R/BPxRk79uLb7yM92MlA6QAtfYfgQk6yBWITXoPP777HiC7OZfgMzt/UZkZizajQM=
X-Received: by 2002:a05:6a20:3943:b0:1bd:234f:ea6c with SMTP id
 adf61e73a8af0-1c0cc727f6bmr1451989637.13.1720094578637; Thu, 04 Jul 2024
 05:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-1-e27d9953210d@suse.com>
 <CAEemH2dcP695G=Lef+kJfusLoKMZSti_rFYPyEGBHATbnVzKiQ@mail.gmail.com>
 <ZoZov55YEzVMogMd@yuki> <ZoZp_DbLtR-Y4NIh@yuki>
 <CAEemH2cB8naFy3Mjm01D42m4F7OFtYjivMivcS+RJzo+e+n6Dg@mail.gmail.com>
 <ZoaNzek2_dEr6CMD@yuki>
In-Reply-To: <ZoaNzek2_dEr6CMD@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 20:02:46 +0800
Message-ID: <CAEemH2ft0kNKCMQ8q8eM=8BQXnTiKrH-2pwWvnYM0c8zcoZkOg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/5] Add stat04 test
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

T24gVGh1LCBKdWwgNCwgMjAyNCBhdCA3OjU24oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gQW5kIGlmIHlvdSBhcmUgYXNraW5nIGlmIHRoZSB0
ZXN0IHdpbGwgcnVuIGZpbmUgd2l0aG91dCB0aGUgc2xlZXAsIGl0Cj4gPiA+IHdpbGwgcnVuIGFu
ZCBpdCB3aWxsIHBhc3MsIGJ1dCB0aGUgdGltZXN0YW1wcyB3aWxsIGJlIHNhbWUgZm9yIHRoZSBs
aW5rCj4gPiA+IGFuZCB0aGUgZmlsZSwgc28gaWYga2VybmVsIHBpY2tzIHVwIHdyb25nIHRpbWVz
dGFtcCB3ZSB3aWxsIG5vdCBmaW5kCj4gPiA+IG91dC4KPiA+ID4KPiA+Cj4gPiBJJ20gY29uZnVz
ZWQsIGRvIHlvdSBtZWFuIGlmIHRoZSBrZXJuZWwgc2V0cyBhIHdyb25nIHRpbWVzdGFtcCBpdCBj
b3VsZAo+ID4gcmVwb3J0IFRGQUlMPwo+ID4KPiA+IEZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGUg
c3RhdChzeW1fcGF0aCwpIGFsc28gcmV0cmlldmVzIGluZm9ybWF0aW9uIG9mCj4gPiB0aGUgdGFy
Z2V0IGZpbGUsCj4gPiBzaG91bGRuJ3QgdGhhdCBhbHdheXMgZXF1YWwgdGhlIHN0YXQoZmlsZV9w
YXRoLCkgdGltZXN0YW1wPyAgQXMgbG9uZyBhcwo+IHRoZQo+ID4gc3RhdCgpCj4gPiB3b3JrcyBj
b3JyZWN0bHksIHdpdGggc2xlZXAoMSkgb3Igbm90IHdvbid0IGltcGFjdCBhbnl0aGluZy4KPgo+
IFRoZSB0ZXN0IHRyaWVzIHRvIGFzc2VydCB0aGF0IHN0YXQoKSBmb2xsb3dzIHRoZSBzeW1saW5r
IGFuZCB0aGlzIHRlc3QKPiBpcyBhIHVuaXQgdGVzdCBmb3IgdGhpcyBhc3NlcnRpb24uIEhvd2V2
ZXIgaWYgd2UgZG8gbm90IHNwZW5kIHNvbWUKPiBlZmZvcnQgb24gbWFraW5nIHRoZSBsaW5rIGFu
ZCB0YXJnZXQgYXR0cmlidXRlcyBhY3R1YWxseSBkaWZmZmVyZW50IHRoZQo+IHRlc3Qgd291bGQg
cGFzcyBldmVuIGlmIGtlcm5lbCByZXR1cm5lZCB0aGUgYXR0cmlidXRlcyBmb3IgdGhlIHN5bWxp
bmsKPiBpbnN0ZWFkLgo+CgpPaCB5ZXMsIEkgc2VlLiBUaGF0IHdhaXQgYSBtb21lbnQgaXMgcXVp
dGUgbmVjZXNzYXJ5LCB0aGFua3MhCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
