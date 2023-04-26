Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187CEC77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:09:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F4443CBB91
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 12:09:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7B63C288D
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 12:08:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF39F1A00916
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 12:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682503734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gmcvh2PODpaqDGSbvP27LOl/pl3yXG6SeUd8OS9owm8=;
 b=V16mlO/148KJHJbgSSlBjudG0WwYThckw40NVGyzgpcDTL7C1m08xyjg00iyowIUKUzwUG
 Sdz+s4cEaxUPesmWwEWdVOyYYrBEQYRYZs8bp1uCcdNVwpABNEXbYzScvZpmYE2BAojaF6
 YFmLlbnkD2U59xi4aCZxHtyNORl+zHc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-1BBOJ3xuOwexF-enMWgwcg-1; Wed, 26 Apr 2023 06:08:52 -0400
X-MC-Unique: 1BBOJ3xuOwexF-enMWgwcg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2a8c838c5a9so26578631fa.3
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 03:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682503730; x=1685095730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gmcvh2PODpaqDGSbvP27LOl/pl3yXG6SeUd8OS9owm8=;
 b=hX5XFD0VF0jiYRU4hILjUW563I61zVPqP4ypzCmZD9EInvEvil+ngGXFo8Mct3/94I
 QCBTSh+ImawjW72gY/g5qn+1AGG8bycA9k8xVlmYE8WVLD6Be8dU4wewlNsOXQyQ/GHR
 HJnMh+ic22o0ikWORxrj5WrDx+j7WkxevUP0R+FuQ2vN/Hywskb36ctT4Fv+mZmVvhJV
 evcE2pYm8D4TrpvZvubVMOsru0dqQ+CZZm8KYltsHeOkHySQBHjR83Kf7nLdcgRMm6FY
 hveMXGpSITaxBTvVFZlgjBA7fSuuao2fxc0KzbbJWD2i2aO0tV2pgeNy0Z8KdfqRudfJ
 zdeQ==
X-Gm-Message-State: AAQBX9c2WrO8DXppsneRp1osKV3YTfG2YjqyYTy7QQJ1kSJbpKEvqvvB
 f/AW7awYnayQMs5wBPqZw8D7kr9FET6eMbsNt8QIukOlyMOcJJMj8LhiX3sbs4T13OXxFtaRgs4
 5QY9eVFdKiICYJztqjlwyANBnu3s=
X-Received: by 2002:a2e:95c4:0:b0:298:b333:4267 with SMTP id
 y4-20020a2e95c4000000b00298b3334267mr4618451ljh.18.1682503730755; 
 Wed, 26 Apr 2023 03:08:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350apB01Xseo+E+laXvV+iiGeR+ZzBKgn9zzlDemNetza8+GLF/EcRoqfmqkWV6Gzoc0o6uz0lh0YMGdOl4S2NU8=
X-Received: by 2002:a2e:95c4:0:b0:298:b333:4267 with SMTP id
 y4-20020a2e95c4000000b00298b3334267mr4618447ljh.18.1682503730465; Wed, 26 Apr
 2023 03:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
In-Reply-To: <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Apr 2023 18:08:38 +0800
Message-ID: <CAEemH2cfjYFYQaM3SuDuaOtC+QFFz7p672T4MqvNF+N5_ivEJw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preparations
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

T24gV2VkLCBBcHIgMjYsIDIwMjMgYXQgNjowMeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIFdlZCwgQXByIDI2LCAyMDIzIGF0IDU6MTnigK9QTSBDeXJp
bCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cj4KPj4gSGkhCj4+IEkgd291bGQgbGlr
ZSB0byBzdGFydCB3aXRoIExUUCBwcmUtcmVsZWFzZSBwcmVwYXJhdGlvbnMgYSBiaXQgc29vbmVy
Cj4+IHRoYW4gdXN1YWxsLCBzaW5jZSBxdWl0ZSBhIGxvdCBvZiB0aGluZ3MgaGF2ZSBhY2N1bXVs
YXRlZCBpbiBNYXksIGUuZy4KPj4gdGhlcmUgaXMgYSBTVVNFIExhYnMgY29uZmVyZW5jZSByaWdo
dCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBtb250aC4KPj4KPj4gSSB3b3VsZCBsaWtlIHRvIHN0YXJ0
IHdpdGggcmV2aWV3ZSBvZiBwYXRjaGVzIHRoYXQgc2hvdWxkIGdvIGluIG5vdywKPj4gZnJlZXpl
IHRoZSBnaXQgc29tZXdoZXJlIGF0IHRoZSBlbmQgb2YgdGhlIGZpcnN0IHdlZWsgb2YgTWF5IGFu
ZCBhaW0gZm9yCj4+IGEgcmVsZWFzZSBzb21ld2hlcmUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgbW9u
dGguIERvZXMgdGhhdCBzb3VuZCBPayB0bwo+PiBldmVyeW9uZT8KPj4KPgo+IEJhc2ljYWxseSBh
Z3JlZSwgYnV0IGl0J2QgYmUgYmV0dGVyIGlmIHdlIGV4dGVuZCBvbmUgbW9yZSB3ZWVrIGluIE1h
eS4KPiBTaW5jZSB0aGUgZmlyc3Qgd2VlayBpcyBDaGluYSdzIHB1YmxpYyBob2xpZGF5LCBJIGRv
bid0IHdhbm5hIG1pc3MgdGhlCj4gcmVsZWFzZSB0aGlzIHRpbWUgYWdhaW4uCj4KCkFoLCB5b3Vy
IHBsYW4gc2hvdWxkIGJlIHdlbGwsIEkganVzdCBjaGVjayBteSBjYWxlbmRhciwgdGhlIGhvbGlk
YXkgaXMKb25seSB0aHJlZSBkYXlzIGluIE1heSAoMS0zKS4gVGhhdCB3b3VsZG4ndCBpbXBhY3Qg
YSBsb3QsIHNvcnJ5LgoKCgo+Cj4KPgo+Pgo+PiBFaXRoZXIgd2F5IGlmIHlvdSBoYXZlIHBhdGNo
ZXMgdGhhdCBzaG91bGQgbGFuZCBpbiB0aGUgdXBjb21taW5nCj4+IHJlbGVhc2UsIHBsZWFzZSBw
b2ludCB0aGVtIG91dCBub3csIHNvIHRoYXQgd2UgaGF2ZSBhIGNoYW5jZSB0byByZXZpZXcKPj4g
dGhlbS4KPj4KPgo+IEknbGwgYmUgd29ya2luZyBvbiB0aGUgaHVnZW1tYXAyNCBmYWlsdXJlIHlv
dSBwb2ludGVkIG91dCBiZWZvcmUsCj4gdG8gc2VuZCBhbiBlZmZlY3RpdmUgZml4aW5nIHBhdGNo
Lgo+IGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDIzLU1hcmNoLzAzMzEx
Ny5odG1sCj4KPiBBbHNvLCBJJ2Qgdm90ZSBmb3IgdGhlIGNncm91cF9jb3JlMDMuYyB0ZXN0LCB3
aGljaCBiYXNpY2FsbHkgZ2V0cyBwYXNzZWQKPiBvbiBteSByZXZpZXcgYW5kIHRlc3RpbmcuCj4g
SSB3aWxsIGFkZGl0aW9uYWxseSBzdGFydCBhIHNlcGFyYXRlIHBhdGNoIG9uIG5ldyBpbXByb3Zl
bWVudHMgYmFzZWQgb24KPiBXZWkncyBwYXRjaHNldCB0byBsZXQgTFRQIENncm91cCB0ZXN0IGF2
b2lkIFYxblYyIG1peGluZyB0ZXN0Lgo+IGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWls
L2x0cC8yMDIzLUFwcmlsLzAzMzYwNC5odG1sCj4gaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBl
cm1haWwvbHRwLzIwMjMtQXByaWwvMDMzNjA1Lmh0bWwKPgo+IE1vcmUgd2lkZWx5IExUUCBMVFAg
cHJlLXJlbGVhc2Ugd2lsbCBiZSBkZXBsb3llZCBiYXNlIG9uIFJIRUwgcHJvZHVjdHMgYXMKPiB3
ZWxsLgo+Cgo9PT0+IExUUCBwcmUtcmVsZWFzZSB0ZXN0LgoKc29ycnkgZm9yIHRoZSB0eXBvcy4K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
