Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D4E7718B
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D1F53E4EFC
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:12:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C88AE3E4EFC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:12:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DD4A63D7B6
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734613938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRpg493CE7DLpZKQjRRgx+drlIVDgUGLYBK12eRkUF0=;
 b=W86H8T0azQhwsIGe50fXb3k6p0ERhG0ubCh2a4Zct3ulZs+4NDF84L3xLwKOqM5F4PyusF
 sizbAGypSr47Rx7Y6QOYYLarqN6bXxbiWEBWcpITi3F3t9h125ELhW4+HMtmIbmQtlgM9c
 kFn+SSkjSjmk+pKcLq/jXw2lAl5OBTc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-36YYa7b0PBmiqywscS-LRw-1; Thu, 19 Dec 2024 08:12:17 -0500
X-MC-Unique: 36YYa7b0PBmiqywscS-LRw-1
X-Mimecast-MFC-AGG-ID: 36YYa7b0PBmiqywscS-LRw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f2a9743093so741348a91.3
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 05:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734613934; x=1735218734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRpg493CE7DLpZKQjRRgx+drlIVDgUGLYBK12eRkUF0=;
 b=jh4EIIFnITGTzB4RPaDa1QCzyQr2dDASlcHJ8XdMU1uCbYvTlmWnUCaCvzv/Y7eYG/
 KTAmwqjcX8LFQk2nMYhH4RA6WVg40mNKd9AXNjLDbqv0jJvciZz3fog006PIpPHVjjDA
 hurW2Q4y30ZTRHNTx4oucqbuu1WCuKcGb3W8RQhNvbYkZCRCpVP/MuW+ni9Nyyr3F00S
 1pDwqr361ikaETTzKyJ8+wMx7eascAtBG3ULxff6CdlLFFqBdSX+b6CHfsKRQ1AsMC2t
 cBNblqlejYmKg6D3GgDj3i2WK7JbePoUDVJdw0mdgt1RQVzUOvBDF7aadgl4puYbsm9k
 nBIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3D4mnfg2+OCg7DKfjFn29KgDrh5l4IsYUEo7E4nhXaxynJ7BFXqvkpSoxo9wXZhopqkY=@lists.linux.it
X-Gm-Message-State: AOJu0YwoRnzLYk5EqiXeX+6PGKtvKQmYAqzp+ZMM14HdjvEPuspFTvTB
 D1hcRjfg0EWv0FkB9++UCe5lHLPLrkuXQ7aMeMZmHHWbGJjG/xjY3n6N53nE5RyAZmAIsMz0Vu6
 LL0I+iRSKjHx+gT5OexGDnlbIVu036wSeSeeY6CBzh+YAE4p61j0o2Y9lW9grVXPdnqysDGSiyt
 DWsAVrAtmSGGO0YeP4OJniHk94QJm273ZJjOzZ
X-Gm-Gg: ASbGncsPHQ99wUB47uu7Sojnh3dE7B2u9F6iNCFpLbtGcjtNyYGCazN1dFdy7HYUP5a
 ESZ6pXrOZgdAJVVpyIFX5b/evPZZtpw42vQjvees=
X-Received: by 2002:a17:90b:37c6:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2f443d0081amr4371640a91.20.1734613934056; 
 Thu, 19 Dec 2024 05:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0fmm/+vyOIzx2k7jnOyDqdhgRLfmWahEsOkF20Ar+IhWZzzF4L0Ir2sQKwzGzago3EKcfmXJkRfhPMs1KnZY=
X-Received: by 2002:a17:90b:37c6:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2f443d0081amr4371620a91.20.1734613933727; Thu, 19 Dec 2024
 05:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <20241219130738.GA111004@pevik>
In-Reply-To: <20241219130738.GA111004@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 21:12:01 +0800
Message-ID: <CAEemH2d_P7y+y+P91Lxxi8jBVN1mEjWtt4fh6CRQ07+Bv0yp9Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hFH228na814DWpM_8lKyEy2V9uMGmuSn5suWrxjvJMg_1734613936
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

T24gVGh1LCBEZWMgMTksIDIwMjQgYXQgOTowN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBIaSEKPgo+ID4gT24gMTIuIDEyLiAyNCA3OjA0LCBMaSBXYW5nIHdy
b3RlOgo+ID4gPiBUaGUgbWV0aG9kIGFkanVzdHMgdGhlIG1heF9ydW50aW1lIGZvciB0ZXN0IGNh
c2VzIGJ5IG11bHRpcGx5aW5nCj4gPiA+IGl0IGJ5IGEgZmFjdG9yICg0eCkgaWYgYW55IHNsb3dl
ciBrZXJuZWwgb3B0aW9ucyBhcmUgZGV0ZWN0ZWQuCj4gPiA+IERlYnVnIGtlcm5lbCBjb25maWd1
cmF0aW9ucyAoc3VjaCBhcyBDT05GSUdfS0FTQU4sCj4gQ09ORklHX1BST1ZFX0xPQ0tJTkcsIGV0
Yy4pCj4gPiA+IGFyZSBrbm93biB0byBkZWdyYWRlIHBlcmZvcm1hbmNlLCBhbmQgdGhpcyBhZGp1
c3RtZW50IGVuc3VyZXMKPiA+ID4gdGhhdCB0ZXN0cyBkbyBub3QgZmFpbCBwcmVtYXR1cmVseSBk
dWUgdG8gdGltZW91dHMuCj4KPiA+ID4gQXMgQ3lyaWwgcG9pbnRlZCBvdXQgdGhhdCBhIGRlYnVn
IGtlcm5lbCB3aWxsIHR5cGljYWxseSBydW4KPiA+ID4gc2xvd2VyIGJ5IGEgZmFjdG9yIG9mIE4s
IGFuZCB3aGlsZSBkZXRlcm1pbmluZyB0aGUgZXhhY3QgdmFsdWUKPiA+ID4gb2YgTiBpcyBjaGFs
bGVuZ2luZywgc28gYSByZWFzb25hYmxlIHVwcGVyIGJvdW5kIGlzIHN1ZmZpY2llbnQKPiA+ID4g
Zm9yIHByYWN0aWNhbCBwdXJwb3Nlcy4KPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICAgaW5jbHVkZS90c3Rfa2NvbmZpZy5o
IHwgMTMgKysrKysrKysrKysrKwo+ID4gPiAgIGxpYi90c3Rfa2NvbmZpZy5jICAgICB8IDM5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAgIGxpYi90c3RfdGVz
dC5jICAgICAgICB8ICAzICsrKwo+ID4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9u
cygrKQo+Cj4gPiA+IDxzbmlwPgo+Cj4gPiA+IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBi
L2xpYi90c3RfdGVzdC5jCj4gPiA+IGluZGV4IDhkYjU1NGRlYS4uZjRlNjY3MjQwIDEwMDY0NAo+
ID4gPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+ID4gPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+ID4g
PiBAQCAtNTU1LDYgKzU1NSw5IEBAIHN0YXRpYyBpbnQgbXVsdGlwbHlfcnVudGltZShpbnQgbWF4
X3J1bnRpbWUpCj4gPiA+ICAgICBwYXJzZV9tdWwoJnJ1bnRpbWVfbXVsLCAiTFRQX1JVTlRJTUVf
TVVMIiwgMC4wMDk5LCAxMDApOwo+ID4gPiArICAgaWYgKHRzdF9oYXNfc2xvd19rY29uZmlnKCkp
Cj4gPiA+ICsgICAgICAgICAgIG1heF9ydW50aW1lICo9IDQ7Cj4gPiA+ICsKPiA+ID4gICAgIHJl
dHVybiBtYXhfcnVudGltZSAqIHJ1bnRpbWVfbXVsOwo+ID4gPiAgIH0KPgo+ID4gV2UgaGF2ZSBw
bGVudHkgb2YgdGVzdHMgd2hpY2gga2VlcCBsb29waW5nIHVudGlsIHRoZXkgcnVuIG91dCBvZiBy
dW50aW1lCj4gYW5kCj4gPiB0aGVuIGF1dG9tYXRpY2FsbHkgc3RvcC4gVGhlc2UgdGVzdHMgYXJl
IG5vdCBhdCByaXNrIG9mIHRpbWluZyBvdXQgYW5kCj4gdGhpcwo+ID4gcGF0Y2ggb25seSBtYWtl
cyB0aGVtIHJ1biAzIHRpbWVzIGxvbmdlciB0aGFuIG5lY2Vzc2FyeS4KPgoKV2UgY2FuIGJ5cGFz
cyB0aGUgbXVsdGlwbHkgd2hlbiByZWNvZ25pemluZyB0aG9zZSB0ZXN0LgoKCgo+Cj4gPiBJJ2Qg
cmVjb21tZW5kIHRlbXBvcmFyaWx5IHJldmVydGluZyB0aGlzIHBhdGNoIGFuZCBhZGRpbmcgaXQg
YmFjayB3aXRoIGEKPiBuZXcKPiA+IHRzdF90ZXN0IGZsYWcgdG8gaWRlbnRpZnkgdGVzdHMgd2hp
Y2ggZXhpdCB3aGVuIHJ1bnRpbWUgZXhwaXJlcy4KPgo+ICsxLiBMaSwgY291bGQgeW91IHBsZWFz
ZSBkbyBpdD8KPgoKU3VyZSwgYnV0IEkgYW0gd29uZGVyaW5nIGRvIHlvdSBydW5uaW5nIHRoZSBs
YXRlc3QgTFRQIGJyYW5jaCBpbiBwcm9kdWN0aXZlCmVudj8KSWYgc28gSSBhbSBzb3JyeSB0byBt
YWtlIHRoZSB0ZXN0IHRpbWUgcHJvbG9uZy4KT3IgaWYgbm90LCBjb3VsZCB5b3UgZ2l2ZSBtZSBh
IHBlcmlvZCB0byByZXNvbHZlIGl0IGluIGEgbmV3IHBhdGNoPwoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
