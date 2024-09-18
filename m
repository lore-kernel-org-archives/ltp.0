Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50F6CAC5B2
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 03:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B7A03C2E49
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 05:20:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C83F3C2DF4
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 05:19:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDBC31016BBE
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 05:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726629581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuAOSHcvna8F8HrAn2xA/VjjhEMwlLsk2FFs+e7dbHw=;
 b=U+fMDFC3b/Gk/lpwt7Ze2IYjNNGO3LlN3hk4d6zZ3ZX3Jo9M065pfpK5g/UEh64aFvs48A
 9nTYKAZJhrkNDdvekF/G9Msd+LBEcx57uvVZUKryLJS5V+Bs86wdIHUE8j9rjgp+S+P9nB
 1Nl4psWM66IARnotbzJzqHPH8TYmDbI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-MHNY66AJNF64dK_TYYTNJg-1; Tue, 17 Sep 2024 23:19:38 -0400
X-MC-Unique: MHNY66AJNF64dK_TYYTNJg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d8e7e427d5so380624a91.0
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 20:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726629577; x=1727234377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tuAOSHcvna8F8HrAn2xA/VjjhEMwlLsk2FFs+e7dbHw=;
 b=lZMVgtiD7W4YZ2w+FcK2fBcnwssWVPZe5VtD19HJhT7MQM5JOlqtYc4LBRAoYq55CN
 /kTvbpUJVOt/fusldnkg4x+TwN7vEI+EMy1KrndQgVarHFR7csiEzrybLfphcyBQT4/j
 YGeon0AlMW7pMv36lM+KBYS+2x+tcKj525OcDMSHsGDi6bX4NlXFtX24P7cOLUcM/4SD
 kgmH5ebZfODC1+JyDv5yyomkIRkPE2RzDbFvdROG6M4J7vvi1WOZU6Do3CcRrAYlM1aK
 uyAYxLXFZIE37lOUhINhqASHN1PVM700R/wz0Mwd+vdyXFD52K1sSBc9hLlcoeuyae/Y
 +8XQ==
X-Gm-Message-State: AOJu0YzK7HTWodCP7hz5Dk/cyb9T19mEJmkVP5+XSJFF6XKtp81WT9aA
 MKwQ1z7iUn1ccLVGBOEC68hRWtcvLnvibz3B/HpkeCwset3dQxN1Y3AhVsipWG6tQ8yIJZPqWEq
 EbYOvFpmIYFWO833fCnYDuWuKQ8YbLTztosyS0LZeSsCwFpROzUaJ4eZSVW2J5uLZDS2jEN9czS
 6U2EhjXA3aKUdpd2bUkNUabiE=
X-Received: by 2002:a17:90a:d301:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2db671ae042mr42955895a91.12.1726629577446; 
 Tue, 17 Sep 2024 20:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErvbUtGjpRedS1Rd0YbTIYNxML6WgL/1PLNpQGc3+GN0s7v00wQParqjGVTYteIn7y8F1PUMcGGtkaWNuY2Ro=
X-Received: by 2002:a17:90a:d301:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2db671ae042mr42955861a91.12.1726629576884; Tue, 17 Sep 2024
 20:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240805063616.12572-1-liwang@redhat.com>
 <ZullFLOc6fLJyCts@yuki.lan>
In-Reply-To: <ZullFLOc6fLJyCts@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Sep 2024 11:19:25 +0800
Message-ID: <CAEemH2dHDiE53cpL2nHx=G9=0q2SHsrqS9ca3RcaNB5bjZcjFA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getrusage03: Forcing context switches to update
 resource usage
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
Cc: Scott Weaver <scweaver@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMTcsIDIwMjQgYXQgNzoxOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBPdXIgQ0kgc3BvcmFkaWNhbGx5IGNvbXBsYWlucyB0
aGF0IHRoaXMgdGVzdCBncmFuZGNoaWxkJ3MgTUFYUlNTIGRpZCBub3QKPiByZWFjaAo+ID4gdGhl
IGV4cGVjdGVkIDMwME1CIHNpemUuCj4gPgo+ID4gICAgIDEyIGdldHJ1c2FnZTAzLmM6ODY6IFRG
QUlMOiBjaGlsZC5jaGlsZHJlbiA9IDI1ODA0OCwgZXhwZWN0ZWQgMzA3MjAwCj4gPgo+ID4gQXMg
dGhlIHJ1X21heHJzcyB2YWx1ZSBpcyBnZW5lcmFsbHkgdXBkYXRlZCBhdCBjZXJ0YWluIGludGVy
dmFscyBvciB1bmRlcgo+ID4gc3BlY2lmaWMgY29uZGl0aW9ucywgc3VjaCBhcyBwYWdlIGZhdWx0
cyBvciBjb250ZXh0IHN3aXRjaGVzLiBUaGVyZSBtYXkKPiBiZQo+ID4gZGVsYXkgYmV0d2VlbiB0
aGUgY29tcGxldGlvbiBvZiBtZW1zZXQoKSBhbmQgdGhlIHVwZGF0ZSBvZiBydV9tYXhyc3MuCj4g
Pgo+ID4gVG8gYWRkcmVzcyB0aGlzIGlzc3VlLCB3ZSBjcmVhdGUgYSBmdW5jdGlvbiB0byBmb3Jj
ZSBjb250ZXh0IHN3aXRjaGVzIGJ5Cj4gPiBjYWxsaW5nIHNjaGVkX3lpZWxkKCkgbXVsdGlwbGUg
dGltZXMuIFRoaXMgYXBwcm9hY2ggaGVscHMgdG8gZW5zdXJlIHRoYXQKPiA+IHRoZSBzeXN0ZW0g
aGFzIHRoZSBvcHBvcnR1bml0eSB0byB1cGRhdGUgdGhlIHJ1X21heHJzcyB2YWx1ZSBtb3JlCj4g
cHJvbXB0bHkuCj4gPgo+ID4gUmVwcm90ZWQtYnk6IFNjb3R0IFdlYXZlciA8c2N3ZWF2ZXJAcmVk
aGF0LmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+
Cj4gVGhpcyBsb29rcyBmb3Jnb3R0ZW4gYnV0IHNob3VsZCBwcm9iYWJseSBnbyBpbiBiZWZvcmUg
dGhlIHJlbGVhc2UuLi4KPgo+IEFueXdheXM6Cj4KPiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+Cj4KClRoYW5rIHlvdSwgcGF0Y2ggcHVzaGVkLgoKVGhlIHdvcnRo
IHRvIHNheSB0aGF0IEkgY3JlYXRlZCB0aGUgc2VwYXJhdGVkIGZ1bmN0aW9uCmZvcmNlX2NvbnRl
eHRfc3dpdGNoZXMKdG8gYWNjZXB0IGFuIGFyZ3VtZW50IGZvciBzZXR0aW5nIGNvbnRleHQgc3dp
dGNoIHRpbWVzLCBiZWNhdXNlIEkgdGhpbmsKbWF5YmUKb3RoZXIgdGVzdHMgYWxzbyBuZWVkIHRo
YXQsIHNvIGluIHRoZSBmdXR1cmUgaWYgd2UgY2F0Y2ggc29tZXRoaW5nIGZhaWx1cmUKbGlrZQpy
dV9tYXhyc3MgdXBkYXRpbmcgaXNzdWUsIHdlIGNvdWxkIG1vdmUgdGhpcyBmdW5jdGlvbiB0byBM
VFAgbGlicmFyeS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
