Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38AEC54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 12:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2BC73CFC03
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 13:28:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2E53CE6CF
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 13:28:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A32AB1401703
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 13:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710851306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5h9TXdZ3+9bStKndfLBTGQQvbCGMERPPt5lRGuMcP3E=;
 b=YXZGVTudJlc4gpSKyLLWzak8Tq6ODLjMFamvOO6hZUyU0gRJl+nK42zVJjB9nGzMbclOfj
 H0Ccxb33jsfaJJ5EeiQ13qfmkOYAhMw+nMUcCCeZbeuDB3/s+m36asHiisl01W9rf3GKH+
 kchygEyphVufVEbc552xjGNB+kfigcw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-Pijnt7jrNJSA1GnPWuNloA-1; Tue, 19 Mar 2024 08:28:24 -0400
X-MC-Unique: Pijnt7jrNJSA1GnPWuNloA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29df180bedcso3554052a91.3
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 05:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710851302; x=1711456102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5h9TXdZ3+9bStKndfLBTGQQvbCGMERPPt5lRGuMcP3E=;
 b=poE93IrnZMd713q7eJhBI5hSp2eGeX+6CRE3kzJoP2CZSAjTKX48jB8SxwJvtD5tZm
 WoguqGk0J/F/Ma/8yAPCXQP6wLefKP46sKuTJsDevGySz7KsMLlv72pnm6SP0v7MaDJK
 DcXIG5dAImIG6QnJYWh2hptYylcas0AScFQ2ZmPVossuygktd0s4N5d2YesIjG7g3ZhA
 Yqqmk80ToJJ9L4hAkNFTjHXSPZocIHnVzHX2CIqU2AP4R9ues2DporE//oBjpowBhhLS
 FgorpydQIUOwwmXLPkfOJqAvtzLU0yAyE5IXgPUIMreCW5GCKi8sD252XZStKxEJx2/X
 eb0g==
X-Gm-Message-State: AOJu0YzL+Wt70bgDXX5XCL88flPOEeAgz5ghRnJoKt/32pDlOsGZjmr4
 ndKx24QwvV01kddQuTIZFu2pHKb5jrTBUGHujwsJoWKRRkSeZBs8brFIoeNZEzADS+t+pr7hmSK
 /3Iv1p+mX1klYxARXjgkFyL/4eu2u94uq30HucLfXEFTdr+pmqGOnMkj2EFyekWeSm996RLQbu2
 MBlWgg80o/GcizvGixHrTkYptKqR9Ld1c+okFM
X-Received: by 2002:a17:90a:f416:b0:29b:efcb:7e83 with SMTP id
 ch22-20020a17090af41600b0029befcb7e83mr10835322pjb.3.1710851302562; 
 Tue, 19 Mar 2024 05:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvmJxH0Rbe9LKLFiaQFounVN/9e70Kwm8QvFtvQgRYMr+Witp4KCIrUmTPD4JZDL2CXuaVVmr98CpOTMdAiJg=
X-Received: by 2002:a17:90a:f416:b0:29b:efcb:7e83 with SMTP id
 ch22-20020a17090af41600b0029befcb7e83mr10835308pjb.3.1710851302150; Tue, 19
 Mar 2024 05:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
In-Reply-To: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2024 20:28:09 +0800
Message-ID: <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] New LTP documentation!
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgODo0MeKAr1BNIEFuZHJlYSBDZXJ2
ZXNhdG8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gSGVsbG8gZXZlcnlv
bmUsCj4KPiBhcyBhbHJlYWR5IG1lbnRpb25lZCBpbiB0aGUgbW9udGhseSBMVFAgbWVldGluZywg
TGludXggVGVzdCBQcm9qZWN0Cj4gbGFja3Mgb2YgYSBuaWNlIGFuZCBjbGVhbiBkb2N1bWVudGF0
aW9uIHRoYXQgY2FuIGJlIGVhc2lseSBhY2Nlc3NlZCBieQo+IHVzZXJzLCBkZXZlbG9wZXJzIGFu
ZCBtYWludGFpbmVycy4KPiBUaGUgY3VycmVudCBMVFAgZG9jdW1lbnRhdGlvbiBpcyBhbHNvIG5v
dCBtYXRjaGluZyB3aXRoIG91ciBleHBlY3RhbmN5Cj4gdG93YXJkcyB0aGUgZW50aXJlIHByb2pl
Y3QsIHdoaWNoIGlzIGhhcyBiZWVuIGhlYXZpbHkgcmVmYWN0b3JlZCBhbmQgaXQKPiBoYXMgY2hh
bmdlZCBpbiB0aGUgcGFzdCB5ZWFycywgcHJvdmlkaW5nIGEgaGlnaGVyIHF1YWxpdHkgY29kZSBh
bmQgbmV3Cj4gdGVzdGluZyBmZWF0dXJlcy4KPgo+IEZvciB0aGlzIHJlYXNvbnMsIHdlIHRoaW5r
IGl0J3MgdGltZSB0byBtb3ZlIGZvcndhcmQgYW5kIHRvIHN0YXJ0Cj4gd29ya2luZyBvbiBkb2N1
bWVudGF0aW9uLCBoZWxwaW5nIHBlb3BsZSB0byB1c2UsIHRvIGRldmVsb3AgYW5kIHRvCj4gbWFp
bnRhaW4gTFRQIGluIGFuIGVhc2llciB3YXksIGluY3JlYXNpbmcgcXVhbGl0eSBvZiB0aGUgb3Zl
cmFsbCBwcm9qZWN0Cj4gYW5kIHRvIGNhbGwgbW9yZSBkZXZlbG9wZXJzIGluIHRoZSBjb21tdW5p
dHkuCj4KPiBJIHN0YXJ0ZWQgdG8gd29yayBvbiBkb2N1bWVudGF0aW9uIHJlZmFjdG9yaW5nLCBy
ZS1vcmdhbml6aW5nIHRoZQo+IG92ZXJhbGwgc3RydWN0dXJlLiBUaGUgZmlyc3QgcHJvdG90eXBl
IGNhbiBiZSBmb3VuZCBoZXJlOgo+Cj4gaHR0cHM6Ly9sdHAtYWNlcnYucmVhZHRoZWRvY3MuaW8v
ZW4vbGF0ZXN0L2luZGV4Lmh0bWwKCgpMb29rcyBncmVhdCEgVGhhbmtzIGZvciBicmluZ2luZyB0
aGlzLgoKQW5kIEkganVzdCB0cmllZCB0aGF0IHRoZSBsYXRlc3QgTFRQIGNvbXBpbGVkICYgZXhl
Y3V0ZWQgc3VjY2VlZCBvbgpSSEVMLTcuOS4KQ2FuIHlvdSB1cGRhdGUgdGhlICJPbGRlc3QgdGVz
dGVkIGRpc3RyaWJ1dGlvbnMiIFsxXSBwYXJ0IGJ5IGFkZGluZzoKCiAgUkhFTC03LjkgTWFpcG8g
KERpc3RybykgIDMuMTAgKGtlcm5lbCkgIDQuOC41KGdjYykgIDIuMTcoZ2xpYmMpICAtKGNsYW5n
KQoKWzFdIGh0dHBzOi8vbHRwLWFjZXJ2LnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC91c2Vycy9z
dXBwb3J0ZWRfc3lzdGVtcy5odG1sCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
