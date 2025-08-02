Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757B8C87FC9
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 03:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754107186; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2Q0G4jHLeNz6ftMBCpyx6wYt7dEmgUmatMwDR5AXbXE=;
 b=k0MlD0WHa6M4gcURMmHVKu5RndZQLHr98jVnTEx3dk0lRpBYlNkBOBeYvHH5cVtrqYgA1
 xSXKnbu5gj+ssAX+6LbPgYEgm8V8KCz/cTvrA7liG4iaSZJV5TPbfcC9ZeUiekiqz9iRi2x
 P/+mpLb89HwVGBqFWuyKTesFyPmrgAg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5B63CCBA3
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 05:59:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DFF23CCAA6
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 05:59:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F41C01A004B3
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 05:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754107161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xncmB2TARq/rJT2T8XpEGgafKO2duZWWNErey36VkA=;
 b=OpQLZL7j89vjsu4oE5Y77VIDuyl9AaKhXaGDpyHVCr1azB1OwHBMTMnqzeghFZeKvIKK68
 o3BeNbcdd17cAUdwDgmlX4AJMuK7a3tXdGRc2PiD8eTozQ1NY83JRYpDJAeQPrFPMnBgN8
 V1CGMZgUlAmclfB5X6eLFXsk1I9QGjg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-eOQ3490hOD6cevrGqj_TjQ-1; Fri, 01 Aug 2025 23:59:19 -0400
X-MC-Unique: eOQ3490hOD6cevrGqj_TjQ-1
X-Mimecast-MFC-AGG-ID: eOQ3490hOD6cevrGqj_TjQ_1754107159
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24011c9da24so22843575ad.1
 for <ltp@lists.linux.it>; Fri, 01 Aug 2025 20:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754107159; x=1754711959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6xncmB2TARq/rJT2T8XpEGgafKO2duZWWNErey36VkA=;
 b=AGVSPbOBhlrJI5p2xrAzOT2sky2LAnMt3RCZVgfy1ivUDqHYYC0oESfDO2rFvDi4Cq
 25TzPuDqqe9gsye1rZbt+rf0nw+XEYY6l+euCtq28EhhtyJWiHCaBhcssAsmh/YPvOxr
 JuabjbWyoug8OZSX+4m8HYYxBV80EfDuYRunVmS7wvSboGd/3nphEC3qWHEt4v/rHh5o
 EQ/r6U9c373W0qG7380QABDAwbF3U0Borh+thlUPbgpp1PszPOdhT9R6fSlo2S0o+Bm6
 0dlblAloe0o7lvAoHSNKuci0gMk5ZVxAta1GZtE97DwvNoGKjrYOiDNNXxaiKwe8oX6r
 8CYA==
X-Gm-Message-State: AOJu0YxMZdrv+trZ+fZclP5Bo7mnkJIaN4uJrFfpxsV0GuID8+1/REHo
 DfBvQ1qwI3mN88DnMZcL6Fm8ZKKQOqtnNRb+3P6WOgVyjfaX7qSu0G5K1xRd8HqAuom+Eao/WvM
 QFQW8gD14cv/5w2p1re0qRJOzideORdIVLRMbk3BBmRIKs8D91mArYDlmoiAze+jyGlWItQ1ULU
 IPHUhUTRUu+qycCcq//N5iLu29VH8=
X-Gm-Gg: ASbGncuMXiUl6bd2uiCLOcAoJRVAo0E793hUlYrIam0Y0mnVXknCx+TjsGtCgcNJ7eQ
 2s9K8CS3qVh/wSgtbk1MvfViffHs8nF9vsUdtjxxgo5ygIb5tbxoODigsu9oSOWRBqKYycnGrwe
 4bqL1aZjc9Hoz2Z9GlwD45/A==
X-Received: by 2002:a17:903:18c:b0:235:efbb:9537 with SMTP id
 d9443c01a7336-24200a161d7mr122527595ad.3.1754107158693; 
 Fri, 01 Aug 2025 20:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrji5E+JfEQdIv8vTMEEibgno5AMyD5EacQfHK6Mb5IjDuhm+I1gLeALK1IXbUoqYz57IJePZA4fSfJ0psCc=
X-Received: by 2002:a17:903:18c:b0:235:efbb:9537 with SMTP id
 d9443c01a7336-24200a161d7mr122527355ad.3.1754107158298; Fri, 01 Aug 2025
 20:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250801100935.974351-1-pvorel@suse.cz>
 <20250801102047.GA974145@pevik>
In-Reply-To: <20250801102047.GA974145@pevik>
Date: Sat, 2 Aug 2025 11:59:06 +0800
X-Gm-Features: Ac12FXx8ZLdzI4MGVWElGS-lSxF2PqLeqLoxXcvJLqaabKDSQ63TRI993w9Pfq8
Message-ID: <CAEemH2eEqMMpueDY9s=Bv2JfQ-oAckA8Y8GFTaV04b5bsfPN+A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SMN0-BJbSaWZ0cEtJQurfADASC3o8QKqO8iFvw83NpY_1754107159
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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

T24gRnJpLCBBdWcgMSwgMjAyNSBhdCA2OjIx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSwKPgo+ID4gQ2hhbmdlcyB2MS0+djI6Cj4gPiAqIEFkZCBhbHNvIG1v
ZHVsZXMtY2xlYW4gYW5kIG1vZHVsZXMtaW5zdGFsbAo+ID4gVGhpcyBpcyBuZWVkZWQgYXMgJ21h
a2UgbW9kdWxlcyBjbGVhbicgb3IgJ21ha2UgbW9kdWxlcyBpbnN0YWxsJwo+ID4gd291bGQgYmUg
cnVubmluZyAyIHNlcGFyYXRlIHRhcmdldHMuCj4KPiBBbHNvLCBJIHdvbmRlcmVkIGFib3V0IGZh
aWwgd2hlbiBrZXJuZWwgbW9kdWxlcyBhcmVuJ3QgYnVpbGQ6Cj4KPiBpbmNsdWRlL21rL21vZHVs
ZS5tayBjb250YWluczoKPgo+IGlmZXEgKCQoV0lUSF9NT0RVTEVTKSxubykKPiBTS0lQIDo9IDEK
PiBlbHNlCj4gaWZlcSAoJChMSU5VWF9WRVJTSU9OX01BSk9SKSQoTElOVVhfVkVSU0lPTl9QQVRD
SCksKQo+IFNLSVAgOj0gMQo+IGVsc2UKPiBTS0lQID89ICQoc2hlbGwgXAo+ICAgICAgICAgWyAi
JChMSU5VWF9WRVJTSU9OX01BSk9SKSIgLWd0ICIkKFJFUV9WRVJTSU9OX01BSk9SKSIgXSB8fCBc
Cj4gICAgICAgICBbICIkKExJTlVYX1ZFUlNJT05fTUFKT1IpIiAtZXEgIiQoUkVRX1ZFUlNJT05f
TUFKT1IpIiAtYSBcCj4gICAgICAgICAgICIkKExJTlVYX1ZFUlNJT05fUEFUQ0gpIiAtZ2UgIiQo
UkVRX1ZFUlNJT05fUEFUQ0gpIiBdOyBlY2hvICQkPykKPiBlbmRpZgo+IGVuZGlmCj4KPiBpZm5l
cSAoJChTS0lQKSwwKQo+IE1BS0VfVEFSR0VUUyA6PSAkKGZpbHRlci1vdXQgJS5rbywgJChNQUtF
X1RBUkdFVFMpKQo+IGVuZGlmCj4KPiAjIElnbm9yaW5nIHRoZSBleGl0IHN0YXR1cyBvZiBjb21t
YW5kcyBpcyBkb25lIHRvIGJlIGZvcndhcmQgY29tcGF0aWJsZQo+IHdpdGgKPiAjIGtlcm5lbCBp
bnRlcm5hbCBBUEkgY2hhbmdlcy4gVGhlIHVzZXItc3BhY2UgdGVzdCB3aWxsIHJldHVybiBUQ09O
RiwgaWYgaXQKPiAjIGRvZXNuJ3QgZmluZCB0aGUgbW9kdWxlIChpLmUuIGl0IHdhc24ndCBidWls
dCBlaXRoZXIgZHVlIHRvIGtlcm5lbC1kZXZlbAo+ICMgbWlzc2luZyBvciBtb2R1bGUgYnVpbGQg
ZmFpbHVyZSkuCj4gJS5rbzogJS5jIC5kZXBfbW9kdWxlcyA7Cj4gLS0tLS0KPgo+IFdlIGNvdWxk
IGFsbG93IHRvIGZhaWwgYnVpbGQgd2l0aDoKPiAkIG1ha2UgbW9kdWxlcyBGT1JDRT0xCj4KPiB3
aXRoIHRoZXNlIGNoYW5nZXMgdG8gaW5jbHVkZS9tay9tb2R1bGUubWs6Cj4KPiBpZm5lcSAoJChT
S0lQKSwwKQo+IE1BS0VfVEFSR0VUUyA6PSAkKGZpbHRlci1vdXQgJS5rbywgJChNQUtFX1RBUkdF
VFMpKQo+CgoKPiBpZmVxICgkKEZPUkNFKSwxKQo+ICQoZXJyb3IgTW9kdWxlcyBub3QgYnVpbHQp
Cj4KClRoaXMgc3VnZ2VzdGlvbiBsb29rcyBnb29kLCBtYXliZSB3ZSBjYW4gYWxzbyBhZGQgYSBo
ZWxwZnVsIGVycm9yCm1lc3NhZ2Ugc2hvd2luZyBob3cgdG8gZml4IGl0OgoKaWZlcSAoJChGT1JD
RSksMSkKJChlcnJvciBLZXJuZWwgbW9kdWxlcyBub3QgYnVpbHQhIFwKQ2hlY2sgdGhhdCBrZXJu
ZWwtZGV2ZWwva2VybmVsLWhlYWRlcnMgZm9yCiQoTElOVVhfVkVSU0lPTl9NQUpPUikuJChMSU5V
WF9WRVJTSU9OX1BBVENIKSBhcmUgaW5zdGFsbGVkLCBcCmFuZCB0cnkgYWdhaW4uIFlvdSBjYW4g
YnVpbGQgYW55d2F5IGJ5IG9taXR0aW5nIEZPUkNFPTEuKQoKCmVuZGlmCj4gZW5kaWYKPgo+IGlm
bmVxICgkKEZPUkNFKSwxKQo+ICUua286ICUuYyAuZGVwX21vZHVsZXMgOwo+IGVuZGlmCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
