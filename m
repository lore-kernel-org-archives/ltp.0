Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ABAC3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747060559; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dLqggrvD47FxmtH1NgoSco0nBNHUuFe2om7IXW0ivNM=;
 b=jClEyIKi1SwpAO9c3nhBkRByXbL0i8C2VzeDBv+69kFABC80j4gnQPISu9hJepC5SHgha
 0uUibuoYGj1204kpgZGMiZ/KMkXauctOMqmdEKiUtFKdNiALRkLTXT3chxQHdo3gkdI1NtD
 xfF/TyXVQgnnrhka93zpprmKPgN8jKY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7FD13CC2B5
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 16:35:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EF613CC2A7
 for <ltp@lists.linux.it>; Mon, 12 May 2025 16:35:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5410D60083C
 for <ltp@lists.linux.it>; Mon, 12 May 2025 16:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747060535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iAuNrr/BfGaoku9z0Xe9rqetHdVp04O6BMEJDhPABQ=;
 b=NfhCTjGojIS+RHKGg74GogR4F+5/WRL9IpLI0O2tLhCPghPxtWr6TeHEtXaRP857lIgBry
 pmerny87yx0YhDoK8UBqK5NXHKoY2aXiFKcUMDASk1UANOzfrcmVcY66zE6/Xu7B51OMYT
 ebM3C0teYvivM5lHMXkleGUj2diCAgU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-gdM3NTi7Pee2Yt5aytbXRA-1; Mon, 12 May 2025 10:35:33 -0400
X-MC-Unique: gdM3NTi7Pee2Yt5aytbXRA-1
X-Mimecast-MFC-AGG-ID: gdM3NTi7Pee2Yt5aytbXRA_1747060532
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e39ff4ad4so59554005ad.3
 for <ltp@lists.linux.it>; Mon, 12 May 2025 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747060532; x=1747665332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iAuNrr/BfGaoku9z0Xe9rqetHdVp04O6BMEJDhPABQ=;
 b=jzsDEsy5MPSZAqLD4Z7htJpGMDCKmhZrKdsHM5ZrG089/Sqyqk+Mzz4vZC2IJIgFzm
 I6qFUkr8UsWp4e/S/kcFN2NW5iYZp1jWLyYD0eyIAsvTcinF2QM/rqJFX1FknW371uoy
 sCxxCcGJOTB/FeodCwKQba5T5oEZfQV52qkO+JLI9MYm6FbkKC1pAMrYSOQthVHLgChf
 AGx98QnXM7PfH4SOm58yYH5uWIf3b2BGNAWemHaqVl4u9jyux7CezduTNlGgpC9tF5OT
 9CjkDX6AXpEIrunh0zHsYPK9MEHr/WdkEl4r01ID7KyG817+ghH9VhRgIlEb3PRbHGBD
 Tqig==
X-Gm-Message-State: AOJu0YwKPeM1utWTahvjDKWMILFfKhRdYboNwPcOBHjSK7CU7VxMY31d
 mD6I2ojmzADos4iK0UIgqTN3qn8zIkA5bK+BwQSE42RfAS+Uyyywz02mxdeZqvW55WrD3DWf8UD
 faMryM3038li52wYiSeVVK+LnFgRhE/kb4NUqNEw9UIvD1WSyZ59CIAS7U58AYUGWze/i3yjQZr
 ekfrVpFJyj3S+3HkC80mrrVBU=
X-Gm-Gg: ASbGncuDpsI2/dtTbmPdNBrptirR9WZh2lmngfgTRHMTsfhl/51xqFX40TtWt/qCek5
 dH03e1CjxEokwdbv3/YkSt4KYfxLNWTUYFMzVTvaJSF5wAe9ZgDgeMhlebb3vTDq6SF13uA==
X-Received: by 2002:a17:903:283:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22fc8b3e16cmr146845005ad.8.1747060532065; 
 Mon, 12 May 2025 07:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRccjWWjNZ9CMVmXU/ewdxFB7cPL3qWTbAnjdqv2VO/QzhehdctaKuXqC3yhPhgUirGpUkeqByIN6e+MNTviw=
X-Received: by 2002:a17:903:283:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22fc8b3e16cmr146844825ad.8.1747060531708; Mon, 12 May 2025
 07:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250509113206.59574-1-mdoucha@suse.cz>
 <20250509123410.22406-1-liwang@redhat.com>
 <20250512132629.GA213602@pevik>
In-Reply-To: <20250512132629.GA213602@pevik>
Date: Mon, 12 May 2025 22:35:19 +0800
X-Gm-Features: AX0GCFuTNeGKemH1zW5BMlVG7_wPbR_3XjIjmWbGtpQQU8tL_jBDCjjvsDHOqxg
Message-ID: <CAEemH2fjkL+-55+kChbdWrpcWF=oUzvbWvSgz6DXq=2OkB0mBw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xMPVBpl0nLoAXB2EdYOGuqNqsjjcBd1r1LzJsM_-vls_1747060532
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mmap_24-1: update code comments
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

T24gTW9uLCBNYXkgMTIsIDIwMjUgYXQgOToyNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IEZvbGxvdy11cDogbW1hcF8yNC0xOiBDaGFuZ2Ug
dm0ubWF4X21hcF9jb3VudCBpZiBuZWVkZWQKPgo+IFRoYW5rcyEKPiAuLi4KPiA+ICsrKyBiL3Rl
c3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21tYXAv
MjQtMS5jCj4gPiBAQCAtNywxNSArNywyMyBAQAo+ID4gICAqIHNvdXJjZSB0cmVlLgo+ID4gICAq
Cj4gPiAgICogVGhlIG1tYXAoKSBmdW5jdGlvbiBzaGFsbCBmYWlsIGlmOgo+ID4gLSAqIFtFTk9N
RU1dIE1BUF9GSVhFRCB3YXMgc3BlY2lmaWVkLCBhbmQgdGhlIHJhbmdlIFthZGRyLGFkZHIrbGVu
KQo+ID4gKyAqIFtFTk9NRU1dIE1BUF9GSVhFRCB3YXMgc3BlY2lmaWVkLCBhbmQgdGhlIHJhbmdl
IFthZGRyLCBhZGRyK2xlbikKPiA+ICAgKiBleGNlZWRzIHRoYXQgYWxsb3dlZCBmb3IgdGhlIGFk
ZHJlc3Mgc3BhY2Ugb2YgYSBwcm9jZXNzOwo+ID4gLSAqIG9yLCBpZiBNQVBfRklYRUQgd2FzIG5v
dCBzcGVjaWZpZWQgYW5kCj4gPiAtICogdGhlcmUgaXMgaW5zdWZmaWNpZW50IHJvb20gaW4gdGhl
IGFkZHJlc3Mgc3BhY2UgdG8gZWZmZWN0IHRoZQo+IG1hcHBpbmcuCj4gPiArICogb3IsIGlmIE1B
UF9GSVhFRCB3YXMgbm90IHNwZWNpZmllZCBhbmQgdGhlcmUgaXMgaW5zdWZmaWNpZW50IHJvb20K
PiA+ICsgKiBpbiB0aGUgYWRkcmVzcyBzcGFjZSB0byBlZmZlY3QgdGhlIG1hcHBpbmc7Cj4gPiAr
ICogb3IsIGlmIHRoZSBwcm9jZXNzIGV4Y2VlZHMgdGhlIG1heGltdW0gbnVtYmVyIG9mIGFsbG93
ZWQgbWVtb3J5Cj4gbWFwcGluZ3MKPiA+ICsgKiAoYXMgZGVmaW5lZCBieSAvcHJvYy9zeXMvdm0v
bWF4X21hcF9jb3VudCkuCj4gPiAgICoKPiA+ICAgKiBUZXN0IFN0ZXBzOgo+ID4gLSAqIDEuIElu
IGEgdmVyeSBsb25nIGxvb3AsIGtlZXAgbWFwcGluZyBhIHNoYXJlZCBtZW1vcnkgb2JqZWN0LAo+
ID4gLSAqICAgIHVudGlsIHRoZXJlIHRoaXMgaW5zdWZmaWNpZW50IHJvb20gaW4gdGhlIGFkZHJl
c3Mgc3BhY2U7Cj4gPiAtICogMy4gU2hvdWxkIGdldCBFTk9NRU0uCj4gPiArICogMS4gSW4gYSB2
ZXJ5IGxvbmcgbG9vcCwgY29udGludW91c2x5IG1hcCBhIHNoYXJlZCBtZW1vcnkgb2JqZWN0Cj4g
d2l0aG91dAo+ID4gKyAqICAgIHVubWFwcGluZyBwcmV2aW91cyBvbmVzLgo+ID4gKyAqIDIuIFRo
ZSBsb29wIGNvbnRpbnVlcyB1bnRpbCBtbWFwKCkgZmFpbHMgd2l0aCBFTk9NRU0uCj4gPiArICoK
PiA+ICsgKiBOb3RlOgo+ID4gKyAqIFRoaXMgZmFpbHVyZSBtYXkgb2NjdXIgZHVlIHRvIGVpdGhl
ciBleGhhdXN0aW5nIHRoZSBwcm9jZXNzJ3MKPiA+ICsgKiB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2Us
IG9yIGhpdHRpbmcgdGhlIHN5c3RlbS13aWRlIGxpbWl0IG9uCj4gPiArICogdGhlIG51bWJlciBv
ZiBtZW1vcnkgbWFwcGluZ3MgKGVzcGVjaWFsbHkgb24gc3lzdGVtcyB3aXRoIGxhcmdlIFJBTSku
Cj4gPiArICoKPiBuaXQ6IHBsZWFzZSByZW1vdmUgYmVmb3JlIGNvbW1pdCB0aGlzIGJsYW5rIGxp
bmUuCj4KCkFoIHN1cmUsIG1lcmdlZCBhcyB5b3Ugc3VnZ2VzdGVkLgpUaGFua3MhCgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
