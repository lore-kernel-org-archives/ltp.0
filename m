Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2968C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 247CA3CCD95
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 15:13:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4577B3CCCCC
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:13:39 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8D0A100035B
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:13:38 +0200 (CEST)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso83162555ad.2
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753276417; x=1753881217; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beIqoZWaBSnUSdWMySFFFrDyKVZZCXEPW5E51kqaWDQ=;
 b=H399oz2OtDGRW5t8r33vGFIAUCFTkIKiXrOaOs+68KmZf5i9BeXlPagV6sVSRzjQYd
 CFWYub95ERlneRoDH7FXifoJzuVqhS3zemX2Kib/P+KquMYv2kPzHFTzs7+310zUZH2E
 hK8T4x3pCAifR/lNVFXxYGdhXF3LIauhUfvOV76/V7BIe1Fhl1scUKr0RoIwywGL3EyF
 K5oSvKj97HecJIRGh+marFlK6046ZhuSIAzd/FBvRWA3daZUMOckBoMQ0bUGfS4Z2Ltv
 EBAr86B4fP2UEs8BYD5X/2iu9pToMY5qg9hSUunfKYNcLlQ0Jm0EodT6c58ryAVGEmB4
 zFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753276417; x=1753881217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beIqoZWaBSnUSdWMySFFFrDyKVZZCXEPW5E51kqaWDQ=;
 b=QBu/tiwFJu8T889fe3eLJrbmU9iKN+5lg/DRTe44pzTJ3sF3CyakaSxrvx3lOh16SB
 HSmSB1BH/uLtxb1FehWxudH9P3RD8Wid6RBOCPqwj1wtn/hqyQY5/n5XZ/UApA6DUbYx
 joRDKvaQZ2a1lUazD9pXNaeFf1WbWMtHzdy5rH02MmpVC5gEpe3QuvAsvJnPfMcgw13N
 q2pj7b9NIwHV0Xm2oovKeIdxM/mBHhEAYcRhi6sCzNbnTWsBV4dVoBJmEX/gn/w/SN6c
 CUGpihrPe8brCKKnixBsVlKWOzsxWh2yRRFJY9faNSueSJPpKQGDJ7ktG4ZoDLTXnu2W
 PJZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzChLbU61uHh8UQswxAvcx7Dj9TaVEI4erNGH27LqcODSB1nqZMp589n3OiNuaiL3TW2E=@lists.linux.it
X-Gm-Message-State: AOJu0YxyEmbmYvo0+3OIp7orhQWhgOBD/wakkfokpekIhD31nS2+DSXx
 0Wacj9wHfcYgxWMYpckVRCRidsd3ngqxM+GQL2K/6h9zXE41ndCFB63UZxWl2ASVBdhGVb8lXhS
 5G1kqf88jcp4E1Zfz9e/IENaQYq+u5xY=
X-Gm-Gg: ASbGncums7hH9jejDz4IXLlhOETeKRv9tKxQeB35/4rR3dJwt0FqVpihe8DAYQ88Ll9
 MgV7ijn4M/dxXZGIDtUA6BUL0IMICXDsaOJsttt7SxpovfQKB0GGgIsshsOfMD8gZCqLue7JCwH
 cOlbDZjC+8uF9Tgk63Uz4BItJHxEBJBZxy6zH6zRlRnr7SIldn+qd4DJFHPEvib3zx9y9ZamMNr
 vv3kpA=
X-Google-Smtp-Source: AGHT+IExrJVfX85ocPAGcOAVLoRsLG381RYqweWc6pKncO32uYFvbY3QitGSSueAtTcT9qio7+oc1ksPZcTLweZtKRc=
X-Received: by 2002:a17:903:3d0f:b0:238:2437:ada8 with SMTP id
 d9443c01a7336-23f981d581cmr37899115ad.48.1753276416121; Wed, 23 Jul 2025
 06:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
 <20250723124127.GA154226@pevik>
 <3a8c2634-09d2-4d29-951a-4e5c5b1adef1@suse.com>
 <CAEjxPJ7bj-4_PSKiSuH57UZJWof7ky9QECkUeaeWX8T81wHtjQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7bj-4_PSKiSuH57UZJWof7ky9QECkUeaeWX8T81wHtjQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Jul 2025 09:13:25 -0400
X-Gm-Features: Ac12FXzXSwkWVWLFlmJzLWIa84lAxPPAsVPGkcDEBFs6e891khxaY_6h0wPu7HQ
Message-ID: <CAEjxPJ5g5EGQ-3Vq7b7YTnW6O0O=GM6yxxFa8cvfJ8uSjYTUTw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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

T24gV2VkLCBKdWwgMjMsIDIwMjUgYXQgODo0NuKAr0FNIFN0ZXBoZW4gU21hbGxleQo8c3RlcGhl
bi5zbWFsbGV5LndvcmtAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSnVsIDIzLCAyMDI1
IGF0IDg6NDPigK9BTSBBbmRyZWEgQ2VydmVzYXRvCj4gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5j
b20+IHdyb3RlOgo+ID4KPiA+IE9uIDcvMjMvMjUgMjo0MSBQTSwgUGV0ciBWb3JlbCB3cm90ZToK
PiA+ID4gSGkgYWxsLAo+ID4gPgo+ID4gPj4gT24gNy8yMi8yNSAyOjA2IFBNLCBQZXRyIFZvcmVs
IHdyb3RlOgo+ID4gPj4+ICsrKyBsaWIvdHN0X3NlY3VyaXR5LmMKPiA+ID4+PiBAQCAtMTA3LDcg
KzEwNyw3IEBAIGludCB0c3Rfc2VsaW51eF9lbmFibGVkKHZvaWQpCj4gPiA+Pj4gICAgewo+ID4g
Pj4+ICAgICBpbnQgcmVzID0gMDsKPiA+ID4+PiAtICAgaWYgKHRzdF9pc19tb3VudGVkKFNFTElO
VVhfUEFUSCkpCj4gPiA+Pj4gKyAgIGlmIChhY2Nlc3MoU0VMSU5VWF9TVEFUVVNfUEFUSCwgRl9P
SykgPT0gMCkKPiA+ID4+PiAgICAgICAgICAgICByZXMgPSAxOwo+ID4gPj4+ICAgICB0c3RfcmVz
KFRJTkZPLCAiU0VMaW51eCBlbmFibGVkOiAlcyIsIHJlcyA/ICJ5ZXMiIDogIm5vIik7Cj4gPiA+
PiBUaGlzIGlzIG1vcmUgb3IgbGVzcyB3aGF0IEkgd2FzIGRvaW5nIGF0IHRoZSBiZWdpbm5pbmcs
IGJ1dCBDeXJpbCBzdWdnZXN0ZWQKPiA+ID4+IHRoaXMgYXBwcm9hY2ggd2hpY2ggaXMgbW9yZSBz
aW1pbGFyIHRvIGxpYnNlbGludXguIFBsZWFzZSwgY2hlY2sgdjMuCj4gPiA+IFN1cmUgOikuIEZZ
SSBJIGRpZCBjaGVjayB2MyBiZWZvcmUgcmVwbHlpbmcgdG8gdjQgKEkgYWx3YXlzIHRyeSB0byBn
ZXQgdG8gdGhlCj4gPiA+IGNvbnRleHQgbG9va2luZyBpbnRvIG9sZGVyIHZlcnNpb25zLCBJIGFs
c28gbm90ZWQgdjMgaW4gb25lIG9mIG15IHJlcGxpZXMgOikpLgo+ID4gPgo+ID4gPiBBbmQgeWVz
LCBJIHRoaW5rIHlvdSB3ZXJlIHJpZ2h0LCB0aGF0J3Mgd2h5IEkgcmFpc2VkIG15IGNvbmNlcm4g
YWdhaW4uCj4gPiA+Cj4gPiA+IEJ1dCBvaywgdG8gcXVvdGUgaXQgaGVyZSBDeXJpbCdzIHJlcGx5
IGluIHYzOgo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvYUc1djZlbmhkcUZHZ2lC
akB5dWtpLmxhbi8KPiA+ID4KPiA+ID4gICAgICAgPiArICAgICBpZiAoYWNjZXNzKFNFTElOVVhf
UEFUSCwgRl9PSykgPT0gMCAmJiAhdHN0X2Rpcl9pc19lbXB0eShTRUxJTlVYX1BBVEgsIDApKQo+
ID4gPiAgICAgICA+ICsgICAgICAgICAgICAgcmVzID0gMTsKPiA+ID4KPiA+ID4gICAgICAgTWF5
YmUgd2Ugd2UgY2FuIGRvIHRzdF9pc19tb3VudGVkKFNFTElOVVhfUEFUSCkgaGVyZSBpbnN0ZWFk
LiBBdCBsZWFzdAo+ID4gPiAgICAgICB0aGF0IHNlZW1zIHRvIGJlIHdoYXQgaXNfc2VsaW51eF9l
bmFibGVkKCkgc2VlbXMgdG8gYmUgZG9pbmcuCj4gPiA+IC0tLQo+ID4gPgo+ID4gPiBFbmFibGVk
IFNFTGludXggbWVhbnMgYm90aCAvc3lzL2ZzL3NlbGludXgvZW5mb3JjZSBhbmQgbW91bnRlZCAv
c3lzL2ZzL3NlbGludXgvLgo+ID4gPiBJIGV2ZW4gY2hlY2tlZCB0byBib290IGtlcm5lbCB3aXRo
IFNFTGludXggY29tcGlsZWQgaW4gYnV0IGRpc2FibGVkIGluIHRoZQo+ID4gPiBjb21tYW5kIGxp
bmUgdmlhICdzZWN1cml0eT1zZWxpbnV4IHNlbGludXg9MCBlbmZvcmNpbmc9MCcgYW5kIHRoZSBy
ZXN1bHQgaXMKPiA+ID4gZXhwZWN0ZWQ6IG5vIC9zeXMvZnMvc2VsaW51eCBkaXJlY3RvcnkuCj4g
PiA+Cj4gPiA+IEJvdGggd2F5cyBvZiBjaGVja2luZyBhcmUgT0ssIGp1c3QgImFjY2VzcyhTRUxJ
TlVYX1NUQVRVU19QQVRILCBGX09LKSA9PSAwIiBpcwo+ID4gPiB0aGUgcXVpY2tlc3Qgd2F5IChn
aXZlbiB0ZXN0IHJlcXVpcmVzIGp1c3QgU0VMaW51eCBlbmFibGVkLCBub3QgZW5mb3JjaW5nIG1v
ZGUpLgo+ID4gPgo+ID4gPiBUaGlzIGNhbiBiZSBjaGFuZ2VkIGJlZm9yZSBtZXJnZS4gT3IsIGZl
ZWwgZnJlZSB0byBrZWVwIHRoZSBvcmlnaW5hbCB2ZXJzaW9uIGFzCj4gPiA+IGl0IGFsc28gd29y
a3MuCj4gPiA+Cj4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4gUGV0cgo+ID4gPgo+ID4gPj4gLSBB
bmRyZWEKPiA+Cj4gPiBPayB0aGFua3MsIEkgd2FzIGFsc28gdGhpbmtpbmcgdGhhdCBtYXliZSB3
ZSBjYW4gdmVyaWZ5IGlmIGNlcnRhaW4gTFNNcwo+ID4gYXJlIGVuYWJsZWQgdmlhIC9zeXMva2Vy
bmVsL3NlY3VyaXR5L2xzbSAuIEF0IHRoZSBtb21lbnQgd2Ugb25seSBjaGVjawo+ID4gZm9yIHNl
bGludXgsIGJ1dCBldmVudHVhbGx5IHdlIGNhbiBhbHNvIHZlcmlmeSBpZiBhcHBhcm1vciBpcyBl
bmFibGVkIGJ5Cj4gPiBsb29raW5nIGF0IHRoZSBsaXN0IGluIHRoYXQgZmlsZS4gV0RZVD8KPgo+
IElmIHRoaXMgaXMgdGVzdGluZyBmb3IgdGhlIGxpc3R4YXR0ciBidWcsIHRoZW4geW91IGNhbiBv
bmx5IHRlc3QgZm9yCj4gTFNNcyB0aGF0IGltcGxlbWVudCB0aGVpciBvd24geGF0dHIsIHdoaWNo
IHdvdWxkIGJlIFNFTGludXggYW5kIFNtYWNrLgo+IEFwcEFybW9yIGRvZXNuJ3QgaW1wbGVtZW50
IGFuIHhhdHRyLCBhdCBsZWFzdCBub3QgdXBzdHJlYW0uCgpUbyBiZSBtb3JlIHByZWNpc2UsIHRo
ZSBidWcgaXMgb25seSB0cmlnZ2VyYWJsZSBmb3IgTFNNcyB0aGF0CmltcGxlbWVudCB0aGUgbGlz
dHNlY3VyaXR5IExTTSBob29rICh0byByZXR1cm4gYSBzeW50aGVzaXplZCBzZWN1cml0eQp4YXR0
ciByZWdhcmRsZXNzIG9mIHdoZXRoZXIgb25lIGlzIHNldCBpbiB0aGUgZmlsZXN5c3RlbSksIHdo
aWNoIGFyZQpvbmx5IFNFTGludXggYW5kIFNtYWNrLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
