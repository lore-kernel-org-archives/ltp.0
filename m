Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D0ECA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756980952; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MUCoyc37teO0AMLPHzOoFkNfCvA8wueL3jxdTqG/vHs=;
 b=jcyQvS2Uk11ipa4fldpH0rX6sUnAJvVJl3TUuP0Z7AwRAUpOSEjr2gapxdHRRQLh5MWjo
 hzSa8nRrG0CN9O37laFHo8eYlrHL9z4AGhvsUPwm4zmadYSEkj8p/ZVtqcTMvdghkyqZAZ8
 Yw3TsStWBeOGuRopcmSkLwTi6trP0U4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3B213CD43E
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 12:15:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8F453CD421
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:15:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1E12A1A007F4
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756980927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88a4aAKMtyNCJp+GkZ9a4HTPewTdBhByj1LXHHXQ2vU=;
 b=OvKdiiMc3Ys6AclgSosCP7N1zHv+grDypB1oOGkFqrEtUtdHHSe00zbDsgCb5BWwPc2DXo
 VNAjeyVGRFPFAVuBCaan9pjDoR3BYuUGXRHW88DAz4HZVIlTDK1CM4VByIqk6fl1Sx21+4
 B6Xf41OglSjAmjP5T9h8XyxdyI95YJ0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-uieKAk_PMna7YJReKlIA6A-1; Thu, 04 Sep 2025 06:15:25 -0400
X-MC-Unique: uieKAk_PMna7YJReKlIA6A-1
X-Mimecast-MFC-AGG-ID: uieKAk_PMna7YJReKlIA6A_1756980925
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329e1e3b25bso827687a91.2
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 03:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756980925; x=1757585725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=88a4aAKMtyNCJp+GkZ9a4HTPewTdBhByj1LXHHXQ2vU=;
 b=EapdYalU9cn8EuPZClP4cici2dZbEqDjWYQLQklQoPp55SiTWNA6UdOn9/wMHOtDKb
 fXMfEWTfDXCD2nVs9065/85h4vCKapw/7lCiugNZ7MYKBjqbCxLowqHoLrxy0INlWvzN
 l6X8NomhZbJmjZBtw2/XOBdobPyYFQtXJUqtIcqe5CCqGpQflaH9EhEE0D9q13eUMsAV
 Yq25fC75gcVjwEfqoW23XU81I/uvVuNjKmX1e7QM/9c8ZkuGc+oCsiovBeipeNr7nSy5
 U54YBzvsj42ffo4nED8XjexKeo8Z21Xa0Y81D8nFAKBJer4aEMU5zJcRs8q6XNL0jD6R
 vEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiYIV/RKn6KCvKZGL0iA/l75mt17E7lr/UXWUPTJFtSaJUOlscPY1iVk3eZD5bfTufgzk=@lists.linux.it
X-Gm-Message-State: AOJu0YwXcFO62A2/RAhjCqFnkrepujSLDkirhmaoOjR/Go9ZP1RbUuqB
 CtAjngx8LjSwwTWQ36rtFfPrGbGdOQLZRpaA+Dm1WtzOa+sBSRVGJKYw0bZF3+aFqmj9l3+6Nu9
 aJdT39CdJEnElsIi7Ep82TdxQUJXKtqKURbPE9u3frGjnB+Lku+WA1zE+Sybt5psQAR0GFZ5NRN
 9hU38uiQYqndbAkW2l9TXlfJ7clw4=
X-Gm-Gg: ASbGncsaV/8twB3rgS+hwNFfydr33RZAi/QgGHCK1onBxnCetSRpsleDiwPyhDbjEI0
 I40HvlvY5SX+3I3R6gauxMJ5JmeshmvPUp0+V03pIgudiJQpuzQz1tf8D/bbFQ4Bo4X/9/Ksjf4
 r3U2bJGNT0gfJBVEyJLDTsPQ==
X-Received: by 2002:a17:90b:55c7:b0:327:ba77:a47 with SMTP id
 98e67ed59e1d1-3281543610dmr28678705a91.15.1756980924696; 
 Thu, 04 Sep 2025 03:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEjYg3BuUy5Hw7qVeT/uHaRO2/XzjfkoItTiI/i/rv1v8FsElMmZ1XAWjdSrxpMdAm2FczawEHKv9hNzQgcuQ=
X-Received: by 2002:a17:90b:55c7:b0:327:ba77:a47 with SMTP id
 98e67ed59e1d1-3281543610dmr28678666a91.15.1756980924258; Thu, 04 Sep 2025
 03:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com>
 <aLgxmUJ7e05X1seP@yuki.lan> <aLhAj_-gzjmzvOoX@yuki.lan>
 <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
 <aLlhhJcdbx7mPQX_@yuki.lan>
In-Reply-To: <aLlhhJcdbx7mPQX_@yuki.lan>
Date: Thu, 4 Sep 2025 18:15:11 +0800
X-Gm-Features: Ac12FXxcNuvu3NNIJkuVcSsyX6qvD9yvfBB4SuEggbdX84ltkteOzqaTuj9XLm4
Message-ID: <CAEemH2eji3WJJBDb5932VtYaEJdzXsDtkQ6RQ8mGNZzGtB9Swg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: peUynqV3cBzevsAdd5Nv8K4VegMfZeB-8A9ILV5ALrg_1756980925
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCA1OjUy4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFRoaXMgbWFrZXMgc2Vuc2UhIEhvd2V2ZXIsIGZyb20g
bXkgZXh0ZW5zaXZlIHRlc3RpbmcsIEkgc3RpbGwgc2VlCj4gPiBvY2Nhc2lvbmFsIGZhaWxzIG9u
IEtWTS9EZWJ1ZyBwbGF0Zm9ybXMuCj4gPgo+ID4gSSBzdXNwZWN0IHRoZSBleGlzdGluZyBiYXJy
aWVycyBlbnN1cmUgYWxsIHRocmVhZHMgYXJlIGNyZWF0ZWQgYmVmb3JlCj4gPiB0aGUgZ2FtZSBz
dGFydHMsIGJ1dCBzbWFsbCBzY2hlZHVsZXIgc2tld3MgY2FuIHN0aWxsIGFsbG93IHRoZSBhdHRh
Y2tpbmcKPiA+IHRocmVhZCB0byBydW4gZm9yIGEgZmV3IGN5Y2xlcyBiZWZvcmUgdGhlIGRlZmVu
ZGluZyB0aHJlYWQgbWlncmF0ZXMsCj4gPiBlc3BlY2lhbGx5IG9uIGRlYnVnL1JUIGtlcm5lbHMu
Cj4KPiBJIGd1ZXNzIHRoYXQgdGhlcmUgaXMgbm8gZGVmaW5lZCBvcmRlciBpbiB3aGljaCB0aGUg
dGhyZWFkcyBhcmUgd29rZW4gdXAKPiBhZnRlciB0aGUgc2xlZXAgb24gdGhlIGJhcnJpZXIuIEhl
bmNlIGlmIHdlIHdha2UgdXAgdGhlIGxvdyBwcmlvIHRocmVhZAo+IGJ5IGEgY2hhbmNlIGJlZm9y
ZSBhbGwgdGhlIGhpZ2ggcHJpbyB0aHJlYWRzIGFyZSBhd2FrZSB0aGV5IG1hbmFnZSB0byBkbwo+
IGEgZmV3IGN5Y2xlcy4KPgoKWWVzIHRoYXQncyBteSBjb25jZXJuIGFzIHdlbGwuIFNvIHRoYXQn
cyB3aHkgd2UgbmVlZCBhIGJ1c3ktd2FpdCBmb3IgZWFjaApwbGF5ZXIgYmVmb3JlIHRoZSByZWFs
IGtpY2sgb2ZmLgoKCgo+Cj4gPiBTbywgYmFzZWQgb24gdGhpcyBpbXByb3ZlLCB3ZSBtaWdodCBu
ZWVkIGFkZGl0aW9uYWwgc3BpbiBmb3IgYWxsIHBsYXllcgo+ID4gdGhyZWFkcyAob2ZmZW5zZSwg
ZGVmZW5zZSwgZmFucykgd2FpdCBhdCB0aGUgYmFycmllciBhbmQgdGhlbiBzcGluIHVudGlsCj4g
PiB0aGUgcmVmZXJlZSBraWNrcyBvZmYgdGhlIGJhbGwuCj4gPgo+ID4gLS0tIGEvdGVzdGNhc2Vz
L3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYwo+ID4gKysrIGIv
dGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYwo+
ID4gQEAgLTQ0LDYgKzQ0LDcgQEAKPiA+ICBzdGF0aWMgdHN0X2F0b21pY190IHRoZV9iYWxsOwo+
ID4gIHN0YXRpYyBpbnQgcGxheWVyc19wZXJfdGVhbSA9IDA7Cj4gPiAgc3RhdGljIGludCBnYW1l
X2xlbmd0aCA9IERFRl9HQU1FX0xFTkdUSDsKPiA+ICtzdGF0aWMgdHN0X2F0b21pY190IGtpY2tv
ZmZfZmxhZzsKPiA+ICBzdGF0aWMgdHN0X2F0b21pY190IGdhbWVfb3ZlcjsKPiA+Cj4gPiAgc3Rh
dGljIGNoYXIgKnN0cl9nYW1lX2xlbmd0aDsKPiA+IEBAIC01NSw2ICs1Niw5IEBAIHZvaWQgKnRo
cmVhZF9mYW4odm9pZCAqYXJnIExUUF9BVFRSSUJVVEVfVU5VU0VEKQo+ID4gIHsKPiA+ICAgICAg
ICAgcHJjdGwoUFJfU0VUX05BTUUsICJjcmF6eV9mYW4iLCAwLCAwLCAwKTsKPiA+ICAgICAgICAg
cHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOwo+ID4gKyAgICAgICB3aGlsZSAo
IXRzdF9hdG9taWNfbG9hZCgma2lja29mZl9mbGFnKSkKPiA+ICsgICAgICAgICAgICAgICA7Cj4g
PiArCj4gPiAgICAgICAgIC8qb2NjYXNpb25hbGx5IHdha2UgdXAgYW5kIHJ1biBhY3Jvc3MgdGhl
IGZpZWxkICovCj4gPiAgICAgICAgIHdoaWxlICghdHN0X2F0b21pY19sb2FkKCZnYW1lX292ZXIp
KSB7Cj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IHRpbWVzcGVjIHN0YXJ0LCBzdG9wOwo+ID4g
QEAgLTgwLDYgKzg0LDkgQEAgdm9pZCAqdGhyZWFkX2RlZmVuc2Uodm9pZCAqYXJnIExUUF9BVFRS
SUJVVEVfVU5VU0VEKQo+ID4gIHsKPiA+ICAgICAgICAgcHJjdGwoUFJfU0VUX05BTUUsICJkZWZl
bnNlIiwgMCwgMCwgMCk7Cj4gPiAgICAgICAgIHB0aHJlYWRfYmFycmllcl93YWl0KCZzdGFydF9i
YXJyaWVyKTsKPiA+ICsgICAgICAgd2hpbGUgKCF0c3RfYXRvbWljX2xvYWQoJmtpY2tvZmZfZmxh
ZykpCj4gPiArICAgICAgICAgICAgICAgOwo+ID4gKwo+ID4gICAgICAgICAvKmtlZXAgdGhlIGJh
bGwgZnJvbSBiZWluZyBtb3ZlZCAqLwo+ID4gICAgICAgICB3aGlsZSAoIXRzdF9hdG9taWNfbG9h
ZCgmZ2FtZV9vdmVyKSkgewo+ID4gICAgICAgICB9Cj4gPiBAQCAtOTIsNiArOTksOSBAQCB2b2lk
ICp0aHJlYWRfb2ZmZW5zZSh2b2lkICphcmcgTFRQX0FUVFJJQlVURV9VTlVTRUQpCj4gPiAgewo+
ID4gICAgICAgICBwcmN0bChQUl9TRVRfTkFNRSwgIm9mZmVuc2UiLCAwLCAwLCAwKTsKPiA+ICAg
ICAgICAgcHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOwo+ID4gKyAgICAgICB3
aGlsZSAoIXRzdF9hdG9taWNfbG9hZCgma2lja29mZl9mbGFnKSkKPiA+ICsgICAgICAgICAgICAg
ICA7Cj4gPiArCj4gPiAgICAgICAgIHdoaWxlICghdHN0X2F0b21pY19sb2FkKCZnYW1lX292ZXIp
KSB7Cj4gPiAgICAgICAgICAgICAgICAgdHN0X2F0b21pY19hZGRfcmV0dXJuKDEsICZ0aGVfYmFs
bCk7IC8qIG1vdmUgdGhlIGJhbGwKPiBhaGVhZAo+ID4gb25lIHlhcmQgKi8KPiA+ICAgICAgICAg
fQo+ID4gQEAgLTExNSw5ICsxMjUsMTAgQEAgdm9pZCByZWZlcmVlKGludCBnYW1lX2xlbmd0aCkK
PiA+ICAgICAgICAgbm93ID0gc3RhcnQ7Cj4gPgo+ID4gICAgICAgICAvKiBTdGFydCB0aGUgZ2Ft
ZSEgKi8KPiA+IC0gICAgICAgdHN0X2F0b21pY19zdG9yZSgwLCAmdGhlX2JhbGwpOwo+ID4gLSAg
ICAgICBwdGhyZWFkX2JhcnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7Cj4gPiAgICAgICAgIGF0
cmFjZV9tYXJrZXJfd3JpdGUoInNjaGVkX2Zvb3RiYWxsIiwgIkdhbWVfc3RhcnRlZCEiKTsKPiA+
ICsgICAgICAgcHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOwo+ID4gKyAgICAg
ICB0c3RfYXRvbWljX3N0b3JlKDAsICZ0aGVfYmFsbCk7Cj4gPiArICAgICAgIHRzdF9hdG9taWNf
c3RvcmUoMSwgJmtpY2tvZmZfZmxhZyk7Cj4KPiBJcyB0aGlzIHJlYWxseSAxMDAlIGJ1bGV0cHJv
b2Y/IE5vdyB0aGUgdGhyZWFkcyBhcmUgZ29pbmcgdG8gd2FpdCBmb3IKPiB0aGUgcmVmZXJlZSBm
b3IgdGhlIGtpY2sgb2ZmIGJ1dCBpZiB0aGUgcmVmZXJlZSBpcyB0aGUgZmlyc3QgdGhyZWFkIHRv
Cj4gYmUgd29rZW4gdXAgYWZ0ZXIgdGhlIGJhcnJpZXIgdGhlIG9yZGVyIGlzIHN0aWwgbm90IGd1
YXJhbnRlZWQuCj4KCk5vIGl0J3Mgbm90IGEgMTAwJSBndWFyYW50ZWUuCgoKPiBNYXliZSB3ZSBj
YW4ganVzdCBkbyBhIHNob3J0IHNsZWVwIGhlcmUgaW4gb3JkZXIgdG8gbWFrZSBzdXJlIHRoYXQg
dGhlCj4gc2NoZWR1bGxlciBraWNrcyBpbiBhbmQgcmVkaXN0cmlidXRlcyB0aGUgdGhyZWFkcy4g
SSB3b3VsZCBzYXkgc29tZXRoaW5nCj4gYXMgMjBtcyAoc2luY2Ugd2l0aCBDT05GSUdfSFo9MTAw
IHdlIGhhdmUgc2NoZWR1bGxlciB0aWNrcyBldmVyeSAxMG1zKS4KCgpHb29kIHBvaW50LCB0aGlz
IHdpbGwgaW5jcmVhc2UgdGhlIGNoYW5jZXMgb2YgZXZlcnkgcGxheWVyIGJlaW5nIGFjdGl2ZQpi
ZWZvcmUgdGhlIGtpY2tvZmYuCgpTbyBwYXRjaCB2MiBzaG91bGQgYWRkIG9uZSBsaW5lIGhlcmUs
IHJpZ2h0PwogICAgdXNsZWVwKDIwMDAwKTsKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
