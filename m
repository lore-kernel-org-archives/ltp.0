Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A9E77188
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 07:20:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27A63E57E1
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 08:19:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4DDC3E4E9E
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 08:19:41 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC48164AD3B
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 08:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734679179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RPIScJWeXgqkNleV4a8cKuKBhi2/v1Mw6WkQWC6dNQ=;
 b=DQtD8j3/wy0tj/WzTHr7/tP0VKbN32uG2SMbFKwfL+QCtsgpnVgzdJhhYEqocGkJJfoxqs
 c2OfcOdC62yLRyRoExZC5Oi1HC5huD/BBTjBjuBHgwgS5hzPab7qq4PnJrIuXTvottSRLf
 KE/VbuCMS1iEMxcCsscN1XXjanFVf+k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-9zQB-BiKNLeziYHgBSl3wg-1; Fri, 20 Dec 2024 02:19:37 -0500
X-MC-Unique: 9zQB-BiKNLeziYHgBSl3wg-1
X-Mimecast-MFC-AGG-ID: 9zQB-BiKNLeziYHgBSl3wg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee6b027a90so2127291a91.1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 23:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734679176; x=1735283976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5RPIScJWeXgqkNleV4a8cKuKBhi2/v1Mw6WkQWC6dNQ=;
 b=c22mHqAe3Ai7Jl/HXYJRtML9QPqU7FHL0eaJKrosLTiKbS+ufISQZu8h/nAarnp+0y
 kCIhHT/aoRrhfcLFEIJG+SKJx8q6cIKIi3iQ0hic4IbIYNorxZ/ufLc7Yn2dc8bHUFvS
 cUWBvtQTpH8Z9t2o1OMjcyNBNizVoSHcgRDI+8VWm4AEZlETOfg8c3KRF6jM2wi9P+Zg
 7o01ETPejv6TxtWotimhvtyroyH3hnzQJ3eESTZHEdKLj9X2vKp76Bqr27RlJF30I05o
 Mxo3C/OH0uBDEwU6KtD2xQx+uifjJHRGxq/8eBJhFP/wbP/BsvD9RLaaDZ/D8EJgFwtV
 3R0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZE/WsxbWkIil9xGIhxLqa2sCG9ouXOh+Wl6VpLYlTEMPVYPe5eQyIxXzo/4Hhe6PeDTU=@lists.linux.it
X-Gm-Message-State: AOJu0YzhkqtH4dx28HUve9caoxYgi/548NEm6P/G5w7eicrD2v+k9kwj
 ziYX8RHYWJJsrET/JIS4zohjrDlZBZvsWYhuExDSDdskJCxQfNKfYVzaeinJpdWtDwmPoCcstOm
 aXUf48wSu18xbiy/KHrehpktV4lH8x/juxgfXtJCxpPUXVvx0u1TeLUccfHgDI+sEGj5H7kfsmG
 gdjV9CaS9CJT+m0yuLKlutidE=
X-Gm-Gg: ASbGncsp3EMs4ZhkiE1/0O/jxcvsYSRidt6yhhH69mpfpB5v/H9InM13RP1VPpPFOaz
 ou7JdiWTU7+M4cAy7SnWSixDfGZeZxOCVjRZ+lqA=
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2f452dfccdcmr2988745a91.4.1734679176046; 
 Thu, 19 Dec 2024 23:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMUV6ilTLvIEiLKnUvFqReCPJNl8E3gZdHoS4exycMABc0YQf/nFMkPd5dt07B8HVLm0uT1PM4vKfC+xtMXLs=
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2f452dfccdcmr2988727a91.4.1734679175812; Thu, 19 Dec 2024
 23:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <20241219130738.GA111004@pevik>
 <CAEemH2d_P7y+y+P91Lxxi8jBVN1mEjWtt4fh6CRQ07+Bv0yp9Q@mail.gmail.com>
 <20241219132800.GC111004@pevik> <Z2Qfs0C6_TAre2-o@yuki.lan>
 <CAEemH2fqyVyUbOr=tMdxFQdKNTFvOU34LUwBYnfqFaZfGFbKNw@mail.gmail.com>
In-Reply-To: <CAEemH2fqyVyUbOr=tMdxFQdKNTFvOU34LUwBYnfqFaZfGFbKNw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Dec 2024 15:19:24 +0800
Message-ID: <CAEemH2d9Ag5e=Aw+Jg8hvXg3PTHdEL+dL61eFjqwqX1Fbi0SRA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dWIft6es4e_43ju1mgRW2H2ValM0F2iNz3nMteXeeg0_1734679176
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

T24gRnJpLCBEZWMgMjAsIDIwMjQgYXQgMTE6NTnigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+IEhpIEFsbCwKPgo+IEl0IHN1ZGRlbmx5IG9jY3VycmVkIHRvIG1lIHRo
YXQgd2UgbWlnaHQgYmUgb24gdGhlIHdyb25nIHRyYWNrIGluCj4gc29sdmluZyB0aGUgdGltZW91
dCBwcm9ibGVtLiBCZWNhdXNlICdtYXhfcnVudGltZScgaXMgaW50ZW5kZWQgdG8KPiBzZXQgdGhl
IGV4cGVjdGVkIHJ1bnRpbWUgZm9yIHRoZSBtYWluIHBhcnQgb2YgdGhlIHRlc3QsIGFuZCBpcyBh
bHNvCj4gdXNlZCBhcyB0aGUgbG9vcCB0ZXJtaW5hdGlvbiB0aW1lIGJ5IHRzdF9yZW1haW5pbmdf
dGltZSgpLiBTbyB0aGUKPiBtdWx0aXBsaWVyIGhhcyBhIHNpZGUgZWZmZWN0IG9mIGV4dGVuZGlu
ZyB0aGUgbG9vcGluZyB0aW1lIG9mIG1hbnkgdGVzdHMuCj4KPiBCdXQgb3VyIG9yaWdpbmFsIGlu
dGVudGlvbiB3YXMgdG8gYXZvaWQgdGVzdCB0aW1lb3V0cyBvbiBzbG93IHN5c3RlbXMKPiAoZS5n
LiBkZWJ1ZyBrZXJuZWxzKSwgYW5kIHRoZSB0aW1lb3V0IGlzIGEgaGFyZCB1cHBlciBib3VuZCB0
byBwcmV2ZW50Cj4gdGhlIHRlc3QgZnJvbSBoYW5naW5nIGluZGVmaW5pdGVseSBkdWUgdG8gZW52
aXJvbm1lbnRhbCBmYWN0b3JzCj4gKGUuZy4sIHNsb3cgc3lzdGVtcywga2VybmVsIGRlYnVnIG1v
ZGUpLgo+Cj4gU28sIHNob3VsZG4ndCB3ZSBvbmx5IHRhcmdldCB0byBleHRlbmQgdGhlIHRpbWVv
dXQgdmFsdWU/Cj4KPgo+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gKysrIGIvbGliL3RzdF90ZXN0
LmMKPiBAQCAtNTU1LDkgKzU1NSw2IEBAIHN0YXRpYyBpbnQgbXVsdGlwbHlfcnVudGltZShpbnQg
bWF4X3J1bnRpbWUpCj4KPiAgICAgICAgIHBhcnNlX211bCgmcnVudGltZV9tdWwsICJMVFBfUlVO
VElNRV9NVUwiLCAwLjAwOTksIDEwMCk7Cj4KPiAtICAgICAgIGlmICh0c3RfaGFzX3Nsb3dfa2Nv
bmZpZygpKQo+IC0gICAgICAgICAgICAgICBtYXhfcnVudGltZSAqPSA0Owo+IC0KPiAgICAgICAg
IHJldHVybiBtYXhfcnVudGltZSAqIHJ1bnRpbWVfbXVsOwo+ICB9Cj4KPiBAQCAtMTcwNiw2ICsx
NzAzLDkgQEAgdW5zaWduZWQgaW50IHRzdF9tdWx0aXBseV90aW1lb3V0KHVuc2lnbmVkIGludAo+
IHRpbWVvdXQpCj4gICAgICAgICBpZiAodGltZW91dCA8IDEpCj4gICAgICAgICAgICAgICAgIHRz
dF9icmsoVEJST0ssICJ0aW1lb3V0IG11c3QgdG8gYmUgPj0gMSEgKCVkKSIsIHRpbWVvdXQpOwo+
Cj4gKyAgICAgICBpZiAodHN0X2hhc19zbG93X2tjb25maWcoKSkKPiArICAgICAgICAgICAgICAg
dGltZW91dCAqPSA0Owo+ICsKPiAgICAgICAgIHJldHVybiB0aW1lb3V0ICogdGltZW91dF9tdWw7
Cj4gIH0KPgoKClJlZ2FyZGluZyB0aGUgc3RhcnZhdGlvbi5jIHRlc3QsIGlzIG5vdCBhIGNvbW1v
biBpc3N1ZSwgdGhlIHRlc3QKdXNpbmcgbWF4X3J1bnRpbWUgdG8gY29tcGxldGUgMTAwMDAwMCBs
b29wcyBpbiBzdWNoIHJlcXVpcmVkCnRpbWUgc2xvdCB0byBqdWRnZSBGQUlMIG9yIFBBU1MgaXMg
bm90IHBlcmZlY3QsIHdoaWxlIHRoZSBkZWJ1ZwprZXJuZWwgd2lsbCB0aHJvdyBhIGZhbHNlIHBv
c2l0aXZlIG9uY2UgdGhlIHJ1bnRpbWUgaXMgbm90IGVub3VnaApmb3IgbG9vcGluZy4KCkl0J3Mg
bm90IGFib3V0IGZpbmRpbmcgdGhlIHJpZ2h0IG1heF9ydW50aW1lIHZhbHVlIGZvciBhbGwgc2Nl
bmFyaW9zLAp3aGljaCBpbnRlcmZlcmVzIHdpdGggb3VyIHNpZ2h0LiBCZWNhdXNlIHRoZWlyIGNh
bGxpYnJhdGUoKSBkb2Vzbid0CmhhdmUgbXVjaCBkaWZmZXJlbmNlIGZyb20gZ2VuZXJhbCBvciBk
ZWJ1ZyBrZXJuZWwgZXZhbHVhdGlvbiwgaXQKb25seSByZWxpZXMgb24gQ1BVIG1vZGVscy4KCldl
IGNhbiB0cmVhdCBpdCBhcyBhIGRlZGljYXRlZCBjYXNlIG9yIHNraXAgZnJvbSBkZWJ1Zy1rZXJu
ZWwgZGlyZWN0bHkuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
