Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2543AE77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 06:28:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A6D3C6C96
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 07:28:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 396F53C638F
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 07:28:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F1671BBBB89
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 07:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736231309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yu1Nuqa2wE0KhxB/Df5e4nGa0bsFdMFF1bK0vyA7FV4=;
 b=J8oGz5cALiR0wiqY645RGZMGAV1ZKu/R2lUhxL4G/yG8LP3mRYD+o6Kvmvi4qpdRW2C+uW
 gzwAgghzGZtG4byuCy/M+TFuCMQ4pElV/AfJ8cP9d6NctGChUtl0EOUKJK2dTzF8youPNM
 fUWqlQtpBwQn+oQIWnIu/KGEO4oCg90=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-M7dpRUjeMhSjszY96abFug-1; Tue, 07 Jan 2025 01:28:25 -0500
X-MC-Unique: M7dpRUjeMhSjszY96abFug-1
X-Mimecast-MFC-AGG-ID: M7dpRUjeMhSjszY96abFug
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee46799961so34174268a91.2
 for <ltp@lists.linux.it>; Mon, 06 Jan 2025 22:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736231304; x=1736836104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yu1Nuqa2wE0KhxB/Df5e4nGa0bsFdMFF1bK0vyA7FV4=;
 b=RpgoZ//u5DUJgsZWtmM/FoqQLH2bmS4yzskUY7qF4sToZ7MGPaIEzuh9JIlXAseZmi
 HTYUmOQworfnDK2WLPv0h+8EUNDLbqE6k5e3cmp/YLSpCiKvhn1n3mhNuOW2chEsD3u3
 yim3JTmEssD4kB1RgMNY/ArSLUe/dYNOs9U8e2m1f9BZpC+IR9X1L5KuFDoQJAfW7u6L
 9SbsXgJQatpUOBItMvYh6YLO651v6faj1cnuuRyVZdRRXekKnK72pwTs2DQIP+CU9tKN
 CXK0RiEkV0dAgPERrXVgVZZB6hoisXWRz5l4465b9WV1xmHpKpBszaNrS4tALX5uMyxO
 kutw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNrzf4gVVu3g+lPUIJGwbESVzctgOpASUExITmQZtjSO2FdpvtsWWFHpMvD8dzmb/gits=@lists.linux.it
X-Gm-Message-State: AOJu0YzDZTOOl2ClJ2pTFdIoAYbWfEABezy1Mn5+biSINjbE75lILDTK
 0p4SXxFf5CmG0wlEhmg8UD3+jbJuLQM3euWanIXBvjFqKvqFxJhrlUELkM02rMrUEV6+qnGLPu6
 dmseB50Wi6eOXd8RKYlHZbktmraSxrffPsrNGvNEqV7TZE3y8SIByyhlnxvgXj4NATMzIYLeCHA
 Qr9u8r9rT8DbJy5t9NJMT/XKg=
X-Gm-Gg: ASbGncsuztbJRPfcwCeDtv/DGRYmeAt2+1hYrMznUoUTLUTmqvMcSxL/IgFQomsVSee
 l3oflKmK+w+58F+Cn9kMkdZMad6XphCt0PWuGaIU=
X-Received: by 2002:a17:90b:2dc9:b0:2ee:8c98:a965 with SMTP id
 98e67ed59e1d1-2f452f01608mr80958364a91.34.1736231304401; 
 Mon, 06 Jan 2025 22:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfwSAcYLfIb9MFFkQeTBCtIH6bN1+zNIzy6G1rieIC7JsVs/wZ3ZXNqRnGQr8NC2VyLrK0B4UVrxYllr59ZGQ=
X-Received: by 2002:a17:90b:2dc9:b0:2ee:8c98:a965 with SMTP id
 98e67ed59e1d1-2f452f01608mr80958351a91.34.1736231304118; Mon, 06 Jan 2025
 22:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
 <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan> <20250106125255.GC302614@pevik>
 <Z3vc-PafjaXVIcRJ@yuki.lan> <20250106153624.GB323533@pevik>
 <Z3wCr3LG_ztyQYHj@yuki.lan>
 <CAEemH2c28ob0=3tq94i7AiwFZW0EyGnb=WAP3P3Qftwb6hLkuw@mail.gmail.com>
In-Reply-To: <CAEemH2c28ob0=3tq94i7AiwFZW0EyGnb=WAP3P3Qftwb6hLkuw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Jan 2025 14:28:11 +0800
Message-ID: <CAEemH2c_PLCAg4ScxCgbDvFYORfsR3R-xw5-dEWxhzdrNvmp9w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: im04mVm2zB4ON4FNO9NGZpvdP68bmVZu6syOkpCZqp0_1736231304
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigsD
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKYW4gNywgMjAyNSBhdCAxOjM34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gVHVlLCBKYW4gNywgMjAyNSBhdCAxMjoyOeKAr0FNIEN5cmls
IEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+PiBIaSEKPj4gPiBBbmQgaWYgdmFs
dWUgZG9lcyBub3QgZ2V0IGNoYW5nZWQgaXQncyB0aGUgZGVmYXVsdCB2YWx1ZS4gQWxzbyBuYW1l
IGlzCj4+IGEgYml0Cj4+ID4gY29uZnVzaW5nICh5b3Ugc3VnZ2VzdCB0byBoYXZlIG1lbWJlcnMg
InRpbWVvdXQiLCAicnVudGltZSIpLCB3aGljaAo+PiBzdWdnZXN0IHRoZQo+PiA+IHNwZWNpYWwg
dmFsdWUgaXMgcmVsYXRlZCB0byBib3RoLgo+PiA+Cj4+ID4gT0ssIGZsYWcgd2hpY2ggd291bGQg
YWxsb3cgdXMgdG8gc2VlIHRoYXQgdGltZSB3aWxsIGJlIGNoYW5nZWQuCj4+ID4KPj4gPiA+IFRo
ZW4gYWxsIGxvbmcgcnVubmluZyB0ZXN0IHdvdWxkIGhhdmUgZWl0aGVyIHRzdF90ZXN0LT50aW1l
b3V0IG9yCj4+ID4gPiB0c3RfdGVzdC0+cnVudGltZSBzZXQuCj4+ID4KPj4gPiA+IFRlY2huaWNh
bGx5IHdlIHdvdWxkIG5lZWQgdHdvIHNwZWNpYWwgdGltZW91dCB2YWx1ZXMKPj4gPiA+IFRTVF9V
TkxJTUlURURfVElNRU9VVCBhbmQgVFNUX1JVTlRJTUVfVElNRU9VVC4KPj4gPgo+PiA+IE9LLCBU
U1RfVU5MSU1JVEVEX1RJTUVPVVQgaXMgZXF1aXZhbGVudCBvZjoKPj4gPgo+PiA+ICNkZWZpbmUg
VFNUX1VOTElNSVRFRF9SVU5USU1FICgtMSkKPj4gPgo+PiA+IE1heWJlIGhhdmUganVzdCBzaW5n
bGUgZGVmaW5pdGlvbiBUU1RfVU5MSU1JVEVELCB3aGljaCBjb3VsZCBiZSB1c2VkIGluCj4+IGJv
dGgKPj4gPiB0c3RfdGVzdC0+dGltZW91dCBhbmQgdHN0X3Rlc3QtPnJ1bnRpbWU/IEJ1dCB0aGF0
J3MganVzdCBhbgo+PiBpbXBsZW1lbnRhdGlvbgo+PiA+IGRldGFpbC4KPj4KPj4gVGhlIFVOTElN
SVRFRF9SVU5USU1FIHdvdWxkIG5vdCBiZSBuZWVkZWQgYW55bW9yZS4gQmVjYXVzZSBydW50aW1l
IHdpbGwKPj4gbWVhbiBfb25seV8gZm9yIGhvdyBsb25nIHdpbGwgYSBmZXcgdGVzdHMgc3BlbmQg
aW4gdGhlIG1haW4gbG9vcC4KPj4gSW5maW5pdGUgbG9vcCBkb2VzIG5vdCBtYWtlIGFueSBzZW5z
ZS4gVGhlIHRzdF9ydW50aW1lIHdpbGwgYmUgYmFzaWNhbGx5Cj4+IHJlbmFtZWQgdG8gdGltZW91
dCBhbmQgVFNUX1VOTElNSVRFRF9SVU5USU1FIGJlY29tZXMKPj4gVFNUX1VOTElNSVRFRF9USU1F
T1VULgo+Pgo+PiA+ID4gPiA+IE1heWJlIHdlIHNob3VsZCBoYXZlIGNhbGxlZCB0aGUgbWF4X3J1
bnRpbWUgYSB0aW1lb3V0IGFuZCBhZGQKPj4gcnVudGltZQo+PiA+ID4gPiA+IGZvciB0ZXN0cyB0
aGF0IG5lZWRzIGl0LiBUaGF0IHdheSB3ZSB3b3VsZCBoYXZlIHRpbWVvdXQKPj4gY29tcHJvbWlz
aW5nIG9mCj4+ID4gPiA+ID4gdHdvIHBhcnRzLCBvbmUgd291bGQgYmUgdGhlIDMwcyB0aGF0IGlz
IHVzZWQgZm9yIGFsbCB0ZXN0cyBhbmQKPj4gc2Vjb25kCj4+ID4gPiA+ID4gcGFydCBmcm9tIHRo
ZSB0c3RfdGVzdCBzdHJ1Y3R1cmUuIEFuZCB0aGVuIHRoZSBzdW0gb2YgdGhlc2UgdHdvCj4+IHdv
dWxkIGJlCj4+ID4gPiA+ID4gbXVsdGlwbGllZCBieSB0aGUgdGltZW91dCBtdWx0aXBsaWVycy4g
VGhlbiB3ZSB3b3VsZCBoYXZlIGEKPj4gcnVudGltZSwKPj4gPiA+ID4gPiB3aGljaCB3b3VsZCBi
ZSB1c2VkIG9ubHkgYnkgdGVzdHMgdGhhdCBjYWxsCj4+IHRzdF9yZW1haW5pbmdfcnVudGltZSgp
Lgo+PiA+Cj4+ID4gT0ssIHRoZSBwb2ludCBvZiB3aG9sZSBjaGFuZ2UgaXMgdG8gc2VwYXJhdGUg
c29tZSBnZW5lcmFsIHRpbWVvdXQgKDMwCj4+IHNlYykgZnJvbQo+PiA+IHJ1bnRpbWUgKHVzZWQg
Zm9yIHRzdF9yZW1haW5pbmdfcnVudGltZSgpKSwgcmlnaHQ/Cj4+Cj4+IFRoZSBwb2ludCBpcyB0
byBzZXBhcmF0ZSB0aW1lb3V0LCB3aGljaCBpcyBhIGd1ZXNzIG9uIHVwcGVyIGJvdW5kIG9uIHRo
ZQo+PiB0aW1lIHRoZSB0ZXN0IHdpbGwgc3BlbmQgZXhlY3V0aW5nIGZyb20gYSBydW50aW1lIHdo
aWNoIGlzIHRoZSBleGFjdAo+PiB0aW1lIGEgZmV3IHRlc3RzIHdpbGwgc3BlbmQgbG9vcGluZyBp
biB0aGUgdGVzdCBmdW5jdGlvbi4KPj4KPj4gPiA+ID4gPiBUaGUgb3ZlcmFsbCB0ZXN0IHRpbWVv
dXQgd291bGQgYmUgdGhlbjoKPj4gPgo+PiA+ID4gPiA+IChkZWZhdWx0XzMwc190aW1lb3V0ICsg
dHN0X3Rlc3QtPnRpbWVvdXQpICogVElNRU9VVF9NVUwgKwo+PiB0c3RfdGVzdC0+cnVudGltZSAq
IFJVTlRJTUVfTVVMCj4+ID4KPj4gPiAoZGVmYXVsdF8zMHNfdGltZW91dCArIHRzdF90ZXN0LT50
aW1lb3V0KSAqIFRJTUVPVVRfTVVMIGlzIG1lYW50IGZvcgo+PiBzZXR1cCBvcgo+PiA+IGNsZWFu
dXAgYW5kIGxpYnJhcnkgb3ZlcmhlYWQsIHRzdF90ZXN0LT5ydW50aW1lICogUlVOVElNRV9NVUwg
Zm9yCj4+IHJ1bm5pbmcgdGVzdAo+PiA+IGZ1bmN0aW9uPwo+Pgo+PiBObywgaXQncyB0aGUgb3Ro
ZXIgd2F5IGFyb3VuZC4gVGhlIHRpbWVvdXQgaXMgYSBndWVzc2VkIHVwcGVyIGJvdW5kIGZvcgo+
PiBhIHRlc3QgZXhlY3V0aW9uIHRpbWUuIEl0J3MgZm9yIGV2ZXJ5dGhpbmcgdGhlIHRlc3QgZG9l
cyBhbmQgaW4gbW9zdCBvZgo+PiB0aGUgY2FzZXMgb25seSB0aGUgZGVmYXVsdCB0aW1lb3V0ICh3
aGljaCBpcyBraW5kIG9mIHNhZmV0eSBtZWFzdXJlKSBpcwo+PiBzdWZmaWNpZW50LiBUaGVuIHRo
ZXJlIGFyZSB0ZXN0cyB0aGF0IGRvIHNvbWUgd29yayB0aGF0IGlzIG5vdCB0aW1lCj4+IGJvdW5k
LCBlLmcuIEkvTy4gSW4gdGhhdCBjYXNlIHdlIHNldCB0aGUgdGltZW91dCBpbiB0aGUgdHN0X3Rl
c3QKPj4gc3RydWN0dXJlIHRvIHNvbWUgdmFsdWUgd2UgbWVhc3VyZWQgaW4gcHJhY3RpY2UgYW5k
IHRoYXQgcGx1cyB0aGUKPj4gZGVmYXVsdCB0aW1lb3V0IHdpbGwgYmVjb21lIHRoZSBvdmVyYWxs
IHRlc3QgdGltZW91dC4KPj4KPj4gVGhlbiB3ZSBoYXZlIGEgZmV3IHRlc3RjYXNlcyB0aGF0IGRv
IGEgbG9vcCBpbiB0aGUgdGVzdCBmdW5jdGlvbiB0aGF0Cj4+IHRha2VzIGV4YWN0IHRpbWUuIElu
IHRoYXQgY2FzZSB3ZSBrbm93IHRoYXQgd2Ugc3BlbmQgZXhhY3RseSBydW50aW1lIGluCj4+IHRo
ZSB0ZXN0IGZ1bmN0aW9uLCBidXQgdGhlcmUgaXMgYSBzZXR1cCBhbmQgY2xlYW51cCBhcyB3ZWxs
LiBTbyB3ZSBhZGQKPj4gdGhlIGRlZmF1bHQgdGltZW91dCB0byB0aGUgcnVudGltZSB0byBnZXQg
dGhlIG92ZXJhbGwgdGltZW91dC4gVGhlcmUgbWF5Cj4+IGJlIGFsc28gYSBjYXNlIHdoZXJlIHRo
ZSB0ZXN0IHNldHVwIGZvciBzdWNoIHRlc3QgdGFrZXMgc29tZSB0aW1lLCBpbgo+PiB0aGF0IGNh
c2Ugd2Ugd291bGQgc2V0IGJvdGggdGhlIHRpbWVvdXQgYW5kIHJ1bnRpbWUgaW4gdGhlIHRzdF90
ZXN0Cj4+IHN0cnVjdHVyZS4gVGhlIHRpbWVvdXQgd291bGQgYmUgdXBwZXIgYm91bmQgZm9yIHRo
ZSB0ZXN0IHNldHVwIGFuZAo+PiBydW50aW1lIHdvdWxkIGJlIGV4YWN0bHkgZm9yIGhvdyBsb25n
IHdpbGwgdGhlIHRlc3QgZnVuY3Rpb24gbG9vcC4KPj4KPgo+IEZhaXIgZW5vdWdoLCBJIGFncmVl
IHdpdGggdGhhdC4KPgo+IFRodXMgd2Ugd2lsbCBoYXZlIHRzdF90ZXN0LT50aW1lb3V0IHVzZWQg
Zm9yIHNldHVwIHRpbWUgY29udHJvbCwgYW5kCj4gdHN0X3Rlc3QtPnJ1bnRpbWUgbWVhbnMgdGhl
IGV4YWN0IGV4ZWN1dGFibGUgdGltZSBvZiB0aGUgbWFpbiBmdW5jdGlvbiwKPiB0c3RfcmVtYWlu
aW5nX3J1bnRpbWUoKSBvbmx5IHJlbHkgb24gdHN0X3Rlc3QtPnJ1bnRpbWUgdG8gY291bnQuCj4K
PiBBcyB5b3UgcG9pbnRlZCBvdXQgYWJvdmU6Cj4gIChkZWZhdWx0XzMwc190aW1lb3V0ICsgdHN0
X3Rlc3QtPnRpbWVvdXQpICogVElNRU9VVF9NVUwgKwo+IHRzdF90ZXN0LT5ydW50aW1lICogUlVO
VElNRV9NVUwKPgo+IEJ1dCwgcXVlc3Rpb25zIGNvbWUgYmFjayB0byB0aGUgaXRlbSwgd2hpY2gg
cGFydCBzaG91bGQgYmUgZXh0ZW5kZWQKPiB3aGVuIGRldGVjdGluZyBzbG93IGtlcm5lbCBjb25m
aWdzPyB0aGUgVElNRU9VVF9NVUw/Cj4gSWYgc28gaXQgbG9va3Mgb25seSByZW5hbWluZyBzb21l
dGhpbmcgYmFzZWQgb24gbXkgcGF0Y2ggbm8gZXNzZW50aWFsCj4gY2hhbmdlcy4KPgoKPgo+Cj4+
Cj4+IE1haW5seSB0aGlzIHdvdWxkIG1ha2Ugc3VyZSB0aGF0IGlmIHRpbWVvdXQgcGFydCBvZiB0
aGUgb3ZlcmFsbCB0ZXN0Cj4+IHRpbWUgbGltaXQgZ2V0cyBtdWx0aXBsaWVkLCBiZWNhdXNlIHdl
IGFyZSBydW5uaW5nIG9uIGEgc2xvdyBzeXN0ZW0sIHRoZQo+PiBydW50aW1lIHdpbGwgbm90LiBC
ZWNhdXNlIHdlIGNvdWxkIGNvbnRyb2wgdGhlIHRpbWVvdXQgYW5kIHJ1bnRpbWUKPj4gc2VwYXJh
dGVseS4KPj4KPgoKQWgsIHlvdSBtZWFuIHdlIG11bHRpcGx5IHRoZSBvdmVyYWxsIHRlc3QgdGlt
ZSBsaW1pdCByZXN1bHRzLT50aW1lb3V0LApyaWdodD8KZS5nLgoKICAgIHJlc3VsdHMtPnRpbWVv
dXQgPSAgKGRlZmF1bHRfMzBzX3RpbWVvdXQgKyB0c3RfdGVzdC0+dGltZW91dCkgKgpUSU1FT1VU
X01VTCArIHRzdF90ZXN0LT5ydW50aW1lICogUlVOVElNRV9NVUw7CiAgICBpZiAodHN0X2hhc19z
bG93X2tjb25maWcoKSkKICAgICAgICAgICAgcmVzdWx0cy0+dGltZW91dCAqPSA0OwoKCgoKPgo+
PiA+ID4gTm90IG9ubHksIHRoZSBkZWZhdWx0IDMwcyB0aW1lb3V0IGlzIGZvciB0aGUgd2hvbGUg
dGVzdHJ1biBmb3IgdGVzdHMKPj4gPiA+IHRoYXQgYXJlIHF1aWNrIGVub3VnaC4gV2UgaGF2ZSBh
IGxvdCBvZiB0ZXN0cyB0aGF0IHJ1biBqdXN0IGZvciBsZXNzCj4+ID4gPiB0aGFuIDFzIGV2ZW4g
b24gc21hbGwgZW1iZWRkZWQgYm9hcmRzLgo+PiA+Cj4+ID4gQW5kIHllcywgd2l0aCBwcm9wZXJs
eSBzZXQgZGF0YSwgMzBzIGNvdWxkIGJlIGNhcmVmdWxseSBsb3dlcmVkIGRvd24gYQo+PiBiaXQu
Cj4+Cj4+IFRoYXQgd2FzIG15IGxvbmcgdGVybSBwbGFuLgo+Pgo+PiAtLQo+PiBDeXJpbCBIcnVi
aXMKPj4gY2hydWJpc0BzdXNlLmN6Cj4+Cj4+Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gTGkgV2FuZwo+
CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
