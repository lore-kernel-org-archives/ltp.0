Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCBCD12695
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:01:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D2EC3D1F66
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:01:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DE423D1F66
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 13:01:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C855605651
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 13:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730808062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aQxZF/5Qlbi2y/kU5njLwQCQMWYkPVqNe/x292gz7g=;
 b=i56virmILbBdNmTYEnDkLFJFs8StIWuI27N9VP2/CLD8wWhIhVEg+4jNY7zePOJpoE8STr
 75iTTo8MOj8lrtdBdOOwcNrLfH0RH8XBZXlTVIDQRTb3zLxmEmCarzie8hlrpDsi4c6VAT
 h/kE/1Bcrl79gP3uTyjRNwb+EViGKQQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-ueBxyRV5M3aNtVbOuxd8lw-1; Tue, 05 Nov 2024 07:01:01 -0500
X-MC-Unique: ueBxyRV5M3aNtVbOuxd8lw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e2d396c77fso6936541a91.2
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 04:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730808058; x=1731412858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8aQxZF/5Qlbi2y/kU5njLwQCQMWYkPVqNe/x292gz7g=;
 b=a1bZsccnYC29zl104sR/diSGXY7gN+uKATkf+bMVjHvPtUshVfHeCSGTANkOXp7vUp
 to0iVEeY7CyVdif7HrDAp1xo9ZyRhcNO+UMVD3WmQhwiRRnrMPd7X0vsih1v9OQ9OaTC
 fDNEj61HK2A0AEbXU3C7jeP6QRWmVGn4OUpSXXFAqbhOilIX3rTTKKg5A+jmMQnIbiTb
 H65vYePZLESdUFqFjBCI8RHxgshyBbWp0gl/VFx+dBEpUCEMPtUe7j+0gUiZFhOEdEhs
 +6eZ+J9PBN1RxHFyLaP7FPmtRqCAZudNDS4pYCBtcHGwUHIrZltBH571xV/S9QRbn3/L
 o4aA==
X-Gm-Message-State: AOJu0Ywqz2nQxopiarkcROlc+4wN6GtGE4jnewdZpRoDgpx0DUX8rjkw
 r6VOgtXClBI6DGQjD5lxFCG6+Zk5SCx8++If29rz4eEGfe5qGWSwDB7rDGFRgAG7p/sMFN8wDPo
 ZYSaUD76c0ZCuwUd5ROfqDltqgcTz632IenEAb9FAhpNqL2rKuuFTcnE0B2oqPbCbznf6KgOPAu
 LMk4tCYwCr2CWiY88TkGob5VuFvsQifSgCjKbO
X-Received: by 2002:a17:90b:1bd2:b0:2e0:9d3e:bc2a with SMTP id
 98e67ed59e1d1-2e94c51c5f2mr22002064a91.32.1730808056923; 
 Tue, 05 Nov 2024 04:00:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWCoa8IrdDKhnfH8NWXmqiEWRBYqVCV2eZN06mMRcLiEmA53qusJ5NULuzlngGsBsHiU2rn1nlB8rUvZIC6GU=
X-Received: by 2002:a17:90b:1bd2:b0:2e0:9d3e:bc2a with SMTP id
 98e67ed59e1d1-2e94c51c5f2mr22001952a91.32.1730808055557; Tue, 05 Nov 2024
 04:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20241105041326.18531-1-liwang@redhat.com>
 <20241105041326.18531-2-liwang@redhat.com> <Zyn2wDmgcI+ri9SH@wegao>
In-Reply-To: <Zyn2wDmgcI+ri9SH@wegao>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Nov 2024 20:00:43 +0800
Message-ID: <CAEemH2c+zZYM1gLeJh3=wMFMknzPYJvnEJ=O9UPNDGNKp8CiPQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] landlock01: used fixed size for
 rule_small_size
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

T24gVHVlLCBOb3YgNSwgMjAyNCBhdCA2OjQz4oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
IHdyb3RlOgoKPiBPbiBUdWUsIE5vdiAwNSwgMjAyNCBhdCAxMjoxMzoyNVBNICswODAwLCBMaSBX
YW5nIHdyb3RlOgo+ID4gVGhlIGxhbmRsb2NrMDEgdGVzdCBpcyBmYWlsaW5nIG9uIGtlcm5lbCB2
Ni4xMi1yYzYgd2l0aCB0aGUKPiA+IGZvbGxvd2luZyBlcnJvcjoKPiA+Cj4gPiAgIGxhbmRsb2Nr
MDEuYzo0OTogVEZBSUw6IFNpemUgaXMgdG9vIHNtYWxsIGV4cGVjdGVkIEVJTlZBTDogRU5PTVNH
ICg0MikKPiA+Cj4gPiBQcmV2aW91c2x5LCBydWxlX3NtYWxsX3NpemUgd2FzIGNhbGN1bGF0ZWQg
Y29uZGl0aW9uYWxseSBiYXNlZAo+ID4gb24gdGhlIHByZXNlbmNlIG9mIHRoZSBoYW5kbGVkX2Fj
Y2Vzc19uZXQgZmllbGQgaW4gdGhlIHN0cnVjdAo+ID4gbGFuZGxvY2tfcnVsZXNldF9hdHRyLgo+
ID4KPiA+IEhvd2V2ZXIsIHRoZSBrZXJuZWwncyBsYW5kbG9ja19jcmVhdGVfcnVsZXNldCgpIGZ1
bmN0aW9uIHN0aWxsIHVzZXMKPiA+IHRoZSBzaXplIHVwIHRvIGhhbmRsZWRfYWNjZXNzX2ZzIHRv
IGRldGVybWluZSB0aGUgbWluaW1hbCBhY2NlcHRhYmxlCj4gPiBzaXplIGZvciBiYWNrd2FyZCBj
b21wYXRpYmlsaXR5LCByZWdhcmRsZXNzIG9mIGFueSBuZXcgZmllbGRzIGFkZGVkLgo+ID4KPiA+
IEFjY29yZGluZyB0byB0aGUgTGFuZGxvY2sgbWFpbnRhaW5lclsxXSwgdGhpcyBiZWhhdmlvciB3
aWxsIHJlbWFpbgo+ID4gZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgcmVhc29ucy4gVGhlcmVm
b3JlLCBpdCdzIHVubmVjZXNzYXJ5IHRvCj4gPiBjb25kaXRpb25hbGx5IGFkanVzdCBydWxlX3Nt
YWxsX3NpemUgYmFzZWQgb24gbmV3IGZpZWxkcy4KPiA+Cj4gPiBUaGlzIHBhdGNoIHNpbXBsaWZp
ZXMgdGhlIHRlc3QgYnkgc2V0dGluZyBydWxlX3NtYWxsX3NpemUgdG8KPiA+ICdzaXplb2YoX191
NjQpIC0gMScsIHdoaWNoIGVmZmVjdGl2ZWx5IHRlc3RzIHRoZSBtaW5pbWFsIHNpemUgYmFzZWQK
PiA+IG9uIGhhbmRsZWRfYWNjZXNzX2ZzLgo+ID4KPiA+IFsxXSBodHRwczovL2xpc3RzLmxpbnV4
Lml0L3BpcGVybWFpbC9sdHAvMjAyNC1KdWx5LzAzOTA4NC5odG1sCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDEuYyB8IDE2ICsrKysrKysrKysrLS0t
LS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
PiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9s
YW5kbG9jazAxLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxv
Y2swMS5jCj4gPiBpbmRleCAwODM2ODVjNjQuLmMzNzVlNTE1NCAxMDA2NDQKPiA+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxvY2swMS5jCj4gPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDEuYwo+ID4gQEAgLTYy
LDExICs2MiwxNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4KPiA+ICAgICAgIHJ1bGVf
c2l6ZSA9IHNpemVvZihzdHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9hdHRyKTsKPiA+Cj4gPiAtI2lm
ZGVmIEhBVkVfU1RSVUNUX0xBTkRMT0NLX1JVTEVTRVRfQVRUUl9IQU5ETEVEX0FDQ0VTU19ORVQK
PiA+IC0gICAgIHJ1bGVfc21hbGxfc2l6ZSA9IHJ1bGVfc2l6ZSAtIHNpemVvZih1aW50NjRfdCkg
LSAxOwo+ID4gLSNlbHNlCj4gPiAtICAgICBydWxlX3NtYWxsX3NpemUgPSBydWxlX3NpemUgLSAx
Owo+ID4gLSNlbmRpZgo+IFNpbmNlIHdlIGRvIG5vdCBuZWVkIEhBVkVfU1RSVUNUX0xBTkRMT0NL
X1JVTEVTRVRfQVRUUl9IQU5ETEVEX0FDQ0VTU19ORVQKPiBhbnltb3JlLCBzbyBpIHN1cHBvc2Ug
d2UgY2FuIHJlbW92ZQo+IGZvbGxvd2luZyBjaGFuZ2UgaW4gY29uZmlndXJlLmFjPwo+CgpUaGVp
cmVjYWxseSB0aGF0J3MgY29ycmVjdCwgYnV0IEkgc2VlIEFuZHJlYSBhY2hpZXZpbmcgVjIgcGF0
Y2hzZXQgZm9yCmxhbmRsb2NrLgpMZXQncyBub3QgZGVsZXRlIHRoZSBtYWNybyB5ZXQgYnV0IGNo
ZWNrIHdoaWNoIG1ldGhvZCB3b3JrcyBmaXJzdC4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
