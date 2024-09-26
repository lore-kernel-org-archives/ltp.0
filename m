Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE07CDE025
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 16:51:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 988A03C4F0A
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 18:51:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 228983C2D1D
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 18:51:23 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3AC660094E
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 18:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727369481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hXpR99ZXH0ag2XiuxaFdUAdnit2v3qcMA/7UrXRCrps=;
 b=HLvSyZQF//fZnJpmsO6jP8MzARYcmGQT8BqnxIC8R3JdqZvO3+GPZYf6JnvWzMP24IdCUv
 /6TRBs5MyxGpNTXz/st1O61m5PB71gbyf8kg1wpAHnyMwLF/ell0yc2/KzJ3rSM4r/nqDq
 gbWUacHfloZ6UP0VVyk/2ZGLvNB1Rbw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-kZjz_pBJM6yOeG4SHOJ1iw-1; Thu, 26 Sep 2024 12:51:18 -0400
X-MC-Unique: kZjz_pBJM6yOeG4SHOJ1iw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb471a230so8711895e9.3
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727369477; x=1727974277;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hXpR99ZXH0ag2XiuxaFdUAdnit2v3qcMA/7UrXRCrps=;
 b=mOupJ5Y1eKk9ho9vKkFvBWQOPSwkaE0ZxEQ188EzgVaTLgPACWiLYocrwY+DW9iXK/
 +aRZOAErJyUj6I6TGvvmIKlpTnytK0AkGB7UvO7FYn0z2avWQap2sdWjkm18wm5bZyAD
 BR26rJsLzJ6BNPXko/PU2WZ5n9prpu1eMZw8+RyCRRnSPxSA3rqRmmip8Xzr9oi11aJ7
 Wkgu57ERAGjx/r26uzFf3gI+YGICx2PUDMErY07wXGrM0yG9gMHI2iCvtUS58M43iWfV
 WMXfrinpN4lK7QBx87UlVvWyjB6E8MfrEnZMSHpe3ltrmwOjARLwnTQ0wD9LEMdtsQX7
 hUSA==
X-Gm-Message-State: AOJu0YxijUuXJ71edehjnb31e20RnjIf3Eb/GyLDTod29c+yb+UzQR96
 gVjiLogXhUP7CPEnVB7mXubmhS/WNkSSrqpx5a2HAp98bP7R8YiXt7U9U/lvhcYeVFGG0X/kSrX
 b/6cLInyWPz+7PrBYiks8P3i6njVtadehGnHO4UQJscZndcm0
X-Received: by 2002:a05:600c:1d20:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42f58497f3emr657035e9.27.1727369477283; 
 Thu, 26 Sep 2024 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMPpyGruDd+gtki5H+b+K4CHklpObqyWd9ah8e0e8F5dinysC22cC48lDjVBzBZcvthsEP3A==
X-Received: by 2002:a05:600c:1d20:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42f58497f3emr656835e9.27.1727369476823; 
 Thu, 26 Sep 2024 09:51:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a?
 (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de.
 [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57de120esm4164195e9.17.2024.09.26.09.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 09:51:16 -0700 (PDT)
Message-ID: <fba9918e-92c2-47ad-b662-bbb83516907a@redhat.com>
Date: Thu, 26 Sep 2024 18:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, "Hrubis, Cyril" <chrubis@suse.cz>,
 Li Wang <liwang@redhat.com>
References: <20240829141002.1962303-1-david@redhat.com>
 <CAASaF6y4R1ESyEjJszM91XAkOa-5Qr_ADuzVYgHy-forQw0eOA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAASaF6y4R1ESyEjJszM91XAkOa-5Qr_ADuzVYgHy-forQw0eOA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjYuMDkuMjQgMTE6MDksIEphbiBTdGFuY2VrIHdyb3RlOgo+IE9uIFRodSwgQXVnIDI5LCAy
MDI0IGF0IDQ6MTDigK9QTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IFdoaWxlIHRoZSBrZXJuZWwgY29tbWl0IGQ4OTk4NDRlOWM5OCAoIm1tOiBmaXgg
c3RhdHVzIGNvZGUgd2hpY2gKPj4gbW92ZV9wYWdlcygpIHJldHVybnMgZm9yIHplcm8gcGFnZSIp
IGZpeGVkIHRoZSByZXR1cm4gdmFsdWUgd2hlbiB0aGUKPj4gc2hhcmVkIHplcm8gcGFnZSB3YXMg
ZW5jb3VudGVyZWQgdG8gbWF0Y2ggd2hhdCB3YXMgc3RhdGUgaW4gdGhlIG1hbiBwYWdlLAo+PiBp
dCB1bmZvcnR1bmF0ZWx5IGFsc28gY2hhbmdlZCB0aGUgYmVoYXZpb3Igd2hlbiBubyBwYWdlIGlz
IG1hcHBlZCB5ZXQgLS0KPj4gd2hlbiBubyBwYWdlIHdhcyBmYXVsdGVkIGluL3BvcHVsYXRlZCBv
biBkZW1hbmQuCj4+Cj4+IFRoZW4sIHRoaXMgdGVzdCBzdGFydGVkIGZhaWxpbmcsIGFuZCB3ZSB0
aG91Z2h0IHdlIHdvdWxkIGJlIHRlc3RpbmcgZm9yCj4+IHRoZSAiemVybyBwYWdlIiBjYXNlLCBi
dXQgYWN0dWFsbHkgd2Ugd2VyZSB0ZXN0aW5nIGZvciB0aGUgIm5vIHBhZ2UgbWFwcGVkIgo+PiBj
YXNlLCBhbmQgZGlkbid0IHJlYWxpemUgdGhhdCB0aGUga2VybmVsIGNvbW1pdCBoYWQgdW5pbnRl
bmRlZCBzaWRlCj4+IGVmZmVjdHMuCj4+Cj4+IEFzIHdlIGFyZSBjaGFuZ2luZyB0aGUgYmVoYXZp
b3IgYmFjayB0byByZXR1cm4gIi1FTk9FTlQiIGluIHRoZSBrZXJuZWwKPj4gZm9yIHRoZSAibm8g
cGFnZSBtYXBwZWQiIGNhc2UsIHdoaWxlIHN0aWxsIGtlZXBpbmcgdGhlICJzaGFyZWQgemVybwo+
PiBwYWdlIiBjYXNlIHRvIHJldHVybiAiLUVGQVVMVCIgdGhlIHRlc3Qgc3RhcnRzIGZhaWxpbmcg
YWdhaW4gLi4uCj4+Cj4+IFRoZSBtYW4gcGFnZSBjbGVhcmx5IHNwZWxscyBvdXQgdGhhdCB0aGUg
ZXhwZWN0YXRpb24gZm9yIHRoZSB6ZXJvIHBhZ2UgaXMKPj4gIi1FRkFVTFQiLCBhbmQgdGhhdCAi
LUVGQVVMVCIgY2FuIGFsc28gYmUgcmV0dXJuZWQgaWYgInRoZSBtZW1vcnkgYXJlYSBpcwo+PiBu
b3QgbWFwcGVkIGJ5IHRoZSBwcm9jZXNzIiAtLSB3aGljaCBtZWFucyB0aGF0IHRoZXJlIGlzIG5v
IFZNQS9tbWFwKCkKPj4gY292ZXJpbmcgdGhhdCBhZGRyZXNzLgo+Pgo+PiBUaGUgbWFuIHBhZ2Ug
YWxzbyBkb2N1bWVudHMgdGhhdCAiLUVOT0VOVCIgaXMgcmV0dXJuZWQgd2hlbiAiVGhlIHBhZ2Ug
aXMKPj4gbm90IHByZXNlbnQiLCB3aGljaCBpbmNsdWRlcyAidGhlcmUgaXMgbm90aGluZyBtYXBw
ZWQiLgo+Pgo+PiBTbyBsZXQncyBmaXggdGhlIHRlc3QgYW5kIHByb3Blcmx5IHRlc3RpbmcgZm9y
IGFsbCB0aHJlZSBzZXBhcmF0ZSB0aGluZ3M6Cj4+ICJpbnZhbGlkIGFyZWEvcGFnZSIsICJubyBw
YWdlIG1hcHBlZCIgYW5kICJzaGFyZWQgemVybyBwYWdlIG1hcHBlZCI+Cj4+Cj4+IENjOiBDeXJp
bCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVu
YnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4+IC0tLQo+Pgo+PiBUaGUga2VybmVsIGNoYW5nZVsx
XSB0aGF0IHdpbGwgcmV2ZXJ0IHRvIHRoZSBkb2N1bWVudGVkIGJlaGF2aW9yIC0tIHJldHVybgo+
PiAtRU5PRU5UIHdoZW4gbm8gcGFnZSBpcyBtYXBwZWQgeWV0IC0tIGlzIG5vdCB1cHN0cmVhbSB5
ZXQsIGJ1dCB0aGUKPj4gYXNzdW1wdGlvbiBpcyB0aGF0IGl0IHdpbGwgZ28gdXBzdHJlYW0gaW4g
dGhlIG5leHQgbWVyZ2Ugd2luZG93LCB0byBsYW5kCj4+IGluIHY2LjEyLgo+IAo+IFRoYW5rcyBm
b3IgcGF0Y2gsIGxvb2tpbmcgYXQgdGhlIExpbnVzJyB0cmVlIEkgdGhpbmsgdGhpcyBsYW5kZWQg
YWxyZWFkeS4KClllcywgaXQncyB1cHN0cmVhbS4KCj4gCj4+Cj4+IENvbnNlcXVlbnRseSwgdGhp
cyB0ZXN0IHdpbGwgbm93IGZhaWwgKGFzIGV4cGVjdGVkKSBvbiBrZXJuZWxzIGJldHdlZW4KPj4g
djQuMyBhbmQgY3VycmVudCBtYWlubGluZS4KPj4KPj4gV2Ugc2VlbWVkIHRvIGhhdmUgImhhY2tl
ZCIgdGhlIHRlc3QgdG8gbWFrZSBrZXJuZWxzIDwgNC4zIHN0aWxsIHBhc3MsCj4+IGV2ZW4gdGhv
dWdoIHRoZXkgd2VyZSBoYW5kbGluZyB6ZXJvIHBhZ2VzIHRoZSB3cm9uZyB3YXkuCj4+Cj4+IFNo
b3VsZCB3ZSBhZGQgYSBzaW1pbGFyICJoYWNrIiBmb3Iga2VybmVscyA+PSA0LjMgdXAgdG8gdGhl
IG9uZSB3aGVyZQo+PiB0aGUga2VybmVsIGJlaGF2aW9yIHdpbGwgY2hhbmdlPyAobGlrZWx5IHY2
LjEyKT8KPiAKPiBJJ20gbGVhbmluZyB0b3dhcmRzIHJlbW92aW5nIHRoZSAiPCA0LjMgaGFjayIg
KGluIGZvbGxvdy11cCBwYXRjaCksIGJlY2F1c2UKPiBvbiBkaXN0cm9zIHRoYXQgZG8gYmFja3Bv
cnRzIGl0J3MgZ29pbmcgdG8gYmUgZXZlbiBtb3JlIGNvbmZ1c2luZy4KCk1ha2VzIHNlbnNlLCBz
byB3ZSB3b3VsZCByZWFsbHkgdGVzdCBhZ2FpbnN0IHRoZSBkb2N1bWVudGVkK2V4cGVjdGVkIApi
ZWhhdmlvci4KCkkgd2lsbCByZXNlbmQgd2l0aDoKCigxKSBUaGlzIHBhdGNoLCBpbmNsdWRpbmcg
dGhlIHByb3BlciBwYXRjaCBkZXNjcmlwdGlvbgooMikgQSBwYXRjaCByZW1vdmluZyB0aGUgPCA0
LjMgaGFjawooMykgQSBwYXRjaCB0byBjb252ZXJ0IHRoaXMgdGVzdCB0byB0aGUgbmV3IEFQSQoK
ClNvdW5kcyBnb29kPwoKLS0gCkNoZWVycywKCkRhdmlkIC8gZGhpbGRlbmIKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
