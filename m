Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92A9CD37B6
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 09:27:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00F883C1D2A
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 11:27:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BFE43C0E0A
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:26:50 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8DB5C1A01922
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725442007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifK4NrgM9fWh1kWSY5/Ykv2PkQ+Pc/Fwe+JvzkTW1PI=;
 b=c7AA2nHlFhv3UgoFyCwS4annkWmwCxNTss2sqolKjqe4vh/OsJExwFp0FPbKqNj4P86zSU
 +iUrf6zTfVIHHRUAqYLH5Hh2Vtb2x2NkRNxqz+4IZt+WUMXWRhmtd6QI35mh87m8oggqAh
 HM4c1VSxtj84S/9hNGfZPrvIEkPSuUg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-TGDgv0DZN-yLsUB7s6luOA-1; Wed, 04 Sep 2024 05:26:43 -0400
X-MC-Unique: TGDgv0DZN-yLsUB7s6luOA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7cda25df5a5so5495586a12.3
 for <ltp@lists.linux.it>; Wed, 04 Sep 2024 02:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725442002; x=1726046802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifK4NrgM9fWh1kWSY5/Ykv2PkQ+Pc/Fwe+JvzkTW1PI=;
 b=oqrB1V5rZ2PJMbOjW+10hEJGrPIzh/4QTbrqc4eDr6O/iDgx1qbx360623BDywzLGk
 HfYvyg8mWxavvEVaTocQvPdQXvp/NHE+nkg1NLGQGPZGjSOkGzCK6MMuDnSXmxh5ZRF4
 m47MD/ba1rGrgd2ux65G7bcO6ad2wZpfggbQYFVb37w0/6rQmoT/Y44I16+B2oVq0Tq4
 LUhlnjZ1VHDfuhh4habBhCvnQdPxwPQ4lhgCo8UlGQ9il6mOENRhu6BJeH/bgyZzg8hK
 qrJKqRr0wmXhvpPG0ha3sbBMl9oq5+OcHh9fDRkvb+hLbRz1T5C37S/Lie/KgGrcs++O
 sP/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhTiq0fAOKYkWIYUzG/siOGHWj7AfVblqKOG08mbHv5WDRtmhC1uf0809gVN5qXAIO3PQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yx643Eagxg6BpONNF7Ton5juSZps1nXXyKRPORHNb/s1C/oVNce
 2SEJd6bBm8/8F+/1ijgKEX0lxHwwxWnfHrqW4gZk7i+XhfFy0OEEaYGR8hxJlctbz2Uo+54QniA
 vibHVQJHBrtY2xQGpsqIN2OETm0yO7+XeSNaQI2fdaFXX712/awHvEaoEw5dMCKLSCKOyaT1iSi
 hmy02Fn9iVQA2PE398o4Uil94=
X-Received: by 2002:a05:6a20:c78f:b0:1c4:82fa:a5a4 with SMTP id
 adf61e73a8af0-1ced6088166mr9894436637.18.1725442002621; 
 Wed, 04 Sep 2024 02:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENzFD1485MoXiOEHY2Pf3K7ESTUjdj6Nvd5SygiQk45MfqYv9+dHnom6l6Jk3XiKow6t9dpdOGp6aMBNn8m3w=
X-Received: by 2002:a05:6a20:c78f:b0:1c4:82fa:a5a4 with SMTP id
 adf61e73a8af0-1ced6088166mr9894426637.18.1725442002282; Wed, 04 Sep 2024
 02:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240903140326.773060-1-pvorel@suse.cz>
 <ZtcoDmsWrMu8Qaze@yuki.lan>
 <20240904053157.GA836933@pevik> <Ztgfu4bTVyw7hvdP@yuki.lan>
In-Reply-To: <Ztgfu4bTVyw7hvdP@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Sep 2024 17:26:30 +0800
Message-ID: <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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

T24gV2VkLCBTZXAgNCwgMjAyNCBhdCA0OjUz4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gPiA+IFNvIHllcyBpdCBsb29rcyBsaWtlIHRoZSBhY3R1
YWwgdGVzdCBuZWVkcyBzb21lIHJ1bnRpbWUgZGVmaW5lZCwKPiA+ID4gYWx0aG91Z2ggSSdtIG5v
dCBzdXJlIGhvdyBsb25nIGl0IHNob3VsZCBiZS4gV2UgcHJvYmFibHkgbmVlZCBhCj4gPiA+IHJl
ZmVyZW5jZSBtYWNoaW5lIHRvIGNhbGxpYnJhdGUgdGhpcyBvbi4gSSB3b3VsZCBhdm9pZCBhbnkg
ZW11bGF0ZWQgQ1BVCj4gPiA+IGFuZCBjaG9vc2UgYSByZWFsIGhhcmR3YXJlLiBJIGd1ZXNzIG9u
ZSBvZiB0aGUgUlBpcyBlLmcuIFBpIFplcm8gd291bGQKPiA+ID4gYmUgYSBnb29kIGNob2ljZSBz
aW5jZSB0aGV5IGFyZSB3aWRlbHkgYXZhaWxhYmxlIGFuZCBzbG93IGJ5IGFueSBtb2Rlcm4KPiA+
ID4gc3RhbmRhcmRzLgo+ID4KPiA+IFRoaXMgbWFrZXMgc2Vuc2UuCj4KPiBTbyBJIGR1c3RlZCBv
ZmYgbXkgUGkgWmVybyBhbmQgaW5kZWVkIHRoZSB0ZXN0IHRpbWVvdXRzIHRoZXJlIGFzIHdlbGwu
Cj4gVGhlIG50ZnMgZmlsZXN5c3RlbSB0YWtlcyA3OHMsIGV4dDIgMjlzLCBleGZhdCAyMHMuIFNv
IEkgd291bGQgc2F5IHRoYXQKCkknbSB3b25kZXJpbmcgd2hpY2ggZGlzdHJpYnV0aW9uIChhbmQg
a2VybmVsIHZlcnNpb24pIGRpZCB5b3UgdXNlIG9uIHJhc3BpLTA/CgpNeSByYXNwaTQodWJ1bnR1
LTI0LCA2LjguMC0xMDEwLCBDb3J0ZXgtQTcyKSB0YWtlcyBhIGxpdHRsZSBmYXN0ZXIuCgpleHQy
OiAxMnMKZXh0MzogMTJzCmV4dDQ6IDAuNHMKbnRmczogNDZzCmV4ZmF0OiBza2lwCgo+IG1heF9y
dW50aW1lIHNob3VsZCBiZSBhdCBsZWFzdCBhIG1pbnV0ZS4gSSBndWVzcyBJIHdpbGwgdHJ5IHRv
IHJ1biB0aGUKCkFncmVlLgoKPiB3aG9sZSBydW4gdGhlcmUgYmVmb3JlIHRoZSByZWxlYXNlIGFu
ZCBjaGVjayBmb3IgdGltZW91dHMgc28gdGhhdCB3ZSBhcmUKPiBzdXJlIHRoYXQgdGhlIHJ1bnRp
bWUgaXMgc2V0IHJlYXNvbmFibHkgZXZlbiBmb3IgdmVyeSBzbG93IGhhcmR3YXJlLgoKKzEKCgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
