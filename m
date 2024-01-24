Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196EAC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 04:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 862313C7676
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 05:27:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 895DC3C7676
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 05:27:41 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C26E32005C1
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 05:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706070459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ma20BX9+fssr49KlsTQwWdQRQ+1gtmmHW8uh70PFzfc=;
 b=i2mQU03tyQb7/Y4GJQbuawYT/rQbYpIHwiERsSaa8BFDqAyPcOJaq113IzGHe+C586HIJ1
 dzAI/LfJfQiHIUoNlJzpW5qJ3YrSglJjjYzdkphUOR8yaSATK0ZCpXvmFiLNPotm4aoOi0
 2m5B4eY/BY87nr0066MsycVZUVcRi9I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-SHX-hRz0NC2bmVvGiOUE_A-1; Tue, 23 Jan 2024 23:27:36 -0500
X-MC-Unique: SHX-hRz0NC2bmVvGiOUE_A-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bd3bdcd87fso8863346b6e.3
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 20:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706070456; x=1706675256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ma20BX9+fssr49KlsTQwWdQRQ+1gtmmHW8uh70PFzfc=;
 b=XSMa1E4WAeIoj5JGoumGb8+7gp6oDgHNTgBERLuyeYmKLjiInk7o1sWePpoILceyem
 sbe79hWKjieR+Qz43tiyomaJ5o/EKFppVoM+0OaXVGz5qXLFVjG8GyiqCJgzN7U0duQj
 Dez5jHjLWicljoZdMctFUQ5sChEvb2JYKvxLawJ15zBTY5eGkw36njS0yVxD5c6rz21a
 OqGoGRWbpf40NsT3SxUWQNdSJ+W9aH/k+wtg5fZ8HWlMzub7GCostKefBUWHslgFXFBi
 fxuvgoh8JUV8eMYv4gGJ4hlG0xYssJRWoWViYKnUZSQPpNL/dtS1LeHoKtM+W6py8SH+
 m0RA==
X-Gm-Message-State: AOJu0YwTN+b670OvkWtRUoeH8Q49amjA5JtjvVTFwcax90KmBi8aAXuo
 BBoz445YB/grs+DzIwIbETGIi+4ypImNpIZjssZRTXWBrR1jotnIgw7yaMo7dwqwhe1UqEV8o1/
 lEMF+Fa63ZydRIZ1ZzQQh6axZU1UBJgNBG5XtlLxuF7lRcB3yLVSxyGckPkzROtXuX7960M9wRS
 XDgoZOcSFs7kmW0wyUT7jvfEs=
X-Received: by 2002:a05:6808:20a5:b0:3bd:ceb0:d475 with SMTP id
 s37-20020a05680820a500b003bdceb0d475mr657850oiw.101.1706070456276; 
 Tue, 23 Jan 2024 20:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW7qVbosvuqn2+KAUD9aU5ETgMKH7UqgCp2aezbGRpMsPiEW07L3aUHJvlfc5bI/vhGrs0iNrk9Brfh52SlHc=
X-Received: by 2002:a05:6808:20a5:b0:3bd:ceb0:d475 with SMTP id
 s37-20020a05680820a500b003bdceb0d475mr657842oiw.101.1706070455989; Tue, 23
 Jan 2024 20:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
 <20240123121156.GA175806@pevik> <20240123123740.GC175806@pevik>
 <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
 <20240123174005.GB217203@pevik>
In-Reply-To: <20240123174005.GB217203@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jan 2024 12:27:22 +0800
Message-ID: <CAEemH2cgLCmPXo1GPcEJEO+6GriePrnVcKb4LgTU02NXfF-D3w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3 4/5] libswap: add function to prealloc
 contiguous file
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

SGkgUGV0ciwKCk9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDE6NDDigK9BTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBIaSBQZXRyLAo+Cj4gPiBPbiBU
dWUsIEphbiAyMywgMjAyNCBhdCA4OjM34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gPiA+IEhpIExpLAo+Cj4gPiA+ID4gSGkgTGksCj4KPiA+ID4gPiBzd2Fwb2Zm
MDEgZmFpbHMgb24gVE1QRElSIG9uIGJ0cmZzIChyZWdhcmRsZXNzIGtlcm5lbCB2ZXJzaW9uKToK
Pgo+ID4gPiBGWUkgaXQgd29ya3Mgb24gVHVtYmxld2VlZCB3aXRoIDYuNyBrZXJuZWwuIEl0J3Mg
YnJva2VuIG9uIHNvbWUgb2xkZXIKPiBTTEVTCj4gPiA+IHdpdGggNS4xNCBhbmQgYWxsIG9sZGVy
IGtlcm5lbHMuIEkgc3VwcG9zZSB3aXRoIG5vY293IChmaXhlcyBJCj4gc3VnZ2VzdGVkCj4gPiA+
IHByZXZpb3VzbHkpIHdvdWxkIHdvcmsgYXMgZXhwZWN0ZWQgKFRQQVNTLCBvciBUQ09ORiBvbiBr
ZXJuZWwgPCA1LjApLgo+Cj4KPiA+IFlvdSdyZSByaWdodC4KPgo+ID4gV2UgaGF2ZSB0byBndWFy
YW50ZWUgdGhlIHN3YXBmaWxlIGlzIGEgY29udGlndW91cyBmaWxlIHdoYXRldmVyIHRoZSBGUwo+
IHR5cGUKPiA+IGlzLgo+ID4gU28gaGVyZSBtYWtpbmcgdXNlIG9mIG1ha2Vfc3dhcGZpbGUoKSBp
cyBhIGhhcmQgcmVxdWlyZW1lbnQuCj4gPiBBbmQsIEkgZG9uJ3QgdGhpbmsgdGhlIGZpbGUgZmly
c3Qgd2l0aCA2NTUzNiBibG9ja3MgKGluIHN3YXBvZmYwMSkgaXMgbm90Cj4gPiBuZWNlc3Nhcnku
Cj4KPiBVbmZvcnR1bmF0ZWx5IHRoaXMgY29tbWl0IG9yIHRoZSBmb2xsb3dpbmcgKGxpYnN3YXA6
IEludHJvZHVjZSBmaWxlCj4gY29udGlndWl0eQo+IGNoZWNrKSBicmVha3Mgc3dhcG9uMDEuYyBv
biBvbGRlciBTTEVTICg0LjQgYmFzZWQga2VybmVsIGFuZCBvbGRlcikgb24gWEZTOgo+Cj4gdHN0
X2lvY3RsLmM6MjY6IFRJTkZPOiBGSUJNQVAgaW9jdGwgaXMgc3VwcG9ydGVkCj4gbGlic3dhcC5j
OjE5MTogVEZBSUw6IHN3YXBvbigpIG9uIHhmcyBmYWlsZWQ6IEVJTlZBTCAoMjIpCj4KPiBUaGUg
ZmFpbHVyZSBpcyBpbiBpc19zd2FwX3N1cHBvcnRlZCgpLgo+CgpHb29kIGNhdGNoLgoKQWZ0ZXIg
dGVzdGluZyBvbiBteSBzaWRlLCByZXByb2R1Y2VkIHRoYXQgZWFzaWx5IHdpdGggb2xkIFhGUy4K
VGhlIHJlYXNvbiBpcyBwcm9iYWJseSBvbGQgWEZTIGV4cGVjdHMgdGhlIHN3YXAgZmlsZSB0byBi
ZQppbml0aWFsaXplZCBpbiBhIGNlcnRhaW4gd2F5LgoKU28gYSBzaW1wbGUgZml4IGlzIGp1c3Qg
dG8gZmlsbCBmdWxsIG9mIHRoZSBmaWxlIGFmdGVyIHByZWFsbG9jYXRpbmcgc3BhY2U6CgotLS0g
YS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCisrKyBiL2xpYnMvbGlibHRwc3dhcC9saWJzd2Fw
LmMKQEAgLTE0MCw2ICsxNDAsMTEgQEAgaW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dh
cGZpbGUsIGludCBzYWZlKQogICAgICAgIGlmIChwcmVhbGxvY19jb250aWd1b3VzX2ZpbGUoc3dh
cGZpbGUsIHN5c2NvbmYoX1NDX1BBR0VTSVpFKSwgMTApCiE9IDApCiAgICAgICAgICAgICAgICB0
c3RfYnJrKFRCUk9LLCAiRmFpbGVkIHRvIGNyZWF0ZSBzd2FwZmlsZSIpOwoKKyAgICAgICBpZiAo
dHN0X2ZzX3R5cGUoc3dhcGZpbGUpID09IFRTVF9YRlNfTUFHSUMpIHsKKyAgICAgICAgICAgICAg
IGlmICh0c3RfZmlsbF9maWxlKHN3YXBmaWxlLCAwLCBzeXNjb25mKF9TQ19QQUdFU0laRSksIDEw
KQohPSAwKQorICAgICAgICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiRmFpbGVkIHRv
IGNyZWF0ZSBzd2FwZmlsZSIpOworICAgICAgIH0KKwogICAgICAgIC8qIG1ha2UgdGhlIGZpbGUg
c3dhcGZpbGUgKi8KICAgICAgICBjb25zdCBjaGFyICphcmd2WzIgKyAxXTsKCgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
