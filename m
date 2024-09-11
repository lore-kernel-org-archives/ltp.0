Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB78EE020D
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 06:02:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8D453C1CAE
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 08:02:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECFBA3C1C14
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:02:25 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBBCD613374
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726034543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyNU6DlxwJnLRRSoVxTJS39HzV4AkXH07nd+xq7LGso=;
 b=Ogn1U9hHDvq8SYhUvV6uOaRa9ZadkoJ9EnvSOOKinvHjPtq+xTBxo4A+yqsvn0j1dgiidX
 zXE0KuGILe5y9Zjwk3uwffLbYD/lHLwoRech8krSQ1x2LF8IzXscmOtP2CM0ln7T8dGev2
 r2E6O4vP9z8V4kKiiv4H6TVEjbcqbto=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-BrCzmleqPZq8TIHW36bTOQ-1; Wed, 11 Sep 2024 02:02:20 -0400
X-MC-Unique: BrCzmleqPZq8TIHW36bTOQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-718dd4aa409so434823b3a.1
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 23:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726034540; x=1726639340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyNU6DlxwJnLRRSoVxTJS39HzV4AkXH07nd+xq7LGso=;
 b=P/X9FnkZhx9ItGQEVzX8bcogbZW/Kq5KdmC7YtJJaFmWfCuu40hsDLwnb1ritZlDD0
 1URyADiexjg2hO2usb7eXNOV2ZZd/vQKuEXBsZ43WLi2lLrr7aNQifIADrpPu2XQ8r+j
 aXhTXTQlOFjugUHzTyPxUlhziIPS/Mf77X9rV8isYxAbD9RKANgy839TxjykUOh3k5xg
 sviy7XLPeAB36I9YdJujEENEL0uQLsLqsXZMkqMjzkNWWEH0Lr/rdASocDfLXy5VE4u0
 OlxDH+eSnXNcCcfsZKGvEYJcWwAgJd1K3z9OIU9dD70AoklWp34TYhYy/Drlo9llu1f3
 jyMA==
X-Gm-Message-State: AOJu0Yxf99kGnaQw28pwVNtgZ9ztwudUcjz09QzWlfhptDe96aEWqN3G
 rd9asGQ2gXy8Clhrybzdb8O/Nt1IB+pO5Mb/3/DUCTG1XACoNtVVPN4LnDBj4xzy+eL/KL/xcjQ
 ZZWgwPslEPFnASP50sh2MDnkFV5MHczjNrIPuCUXuayZFgH+lzMo6WU/AeSPIOBl3J0oaGNuH6z
 dDS7KinkywBy+DfnUNM2yZzD8=
X-Received: by 2002:a05:6a00:1d96:b0:714:2336:fa91 with SMTP id
 d2e1a72fcca58-71907f71a66mr10031964b3a.14.1726034539705; 
 Tue, 10 Sep 2024 23:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDwNOy+S5sjQDivr6YFG/Xb4iB3mATyvSw9mzkDm9ffk+M2+U/Ky+ofULV4yWCNvFC716b30Ui2X3Oo4YKthU=
X-Received: by 2002:a05:6a00:1d96:b0:714:2336:fa91 with SMTP id
 d2e1a72fcca58-71907f71a66mr10031907b3a.14.1726034539132; Tue, 10 Sep 2024
 23:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240910071019.551379-1-liwang@redhat.com>
 <ZuAIzfQCWY-6d2SR@yuki.lan>
In-Reply-To: <ZuAIzfQCWY-6d2SR@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Sep 2024 14:02:07 +0800
Message-ID: <CAEemH2fNCrdkWOyksLzh9vWnVk-w8ACD7ygA-z2OzYjT8w3EDQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tmpdir: rename tst_tmpdir_mkpath to
 tst_tmpdir_genpath
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

T24gVHVlLCBTZXAgMTAsIDIwMjQgYXQgNDo1M+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBXaGVuIEkgcmV2aWV3ZWQgdGhlIHJlbmFtZTE1IHBh
dGNoIEkgZmVsdCBjb25mdXNlZCBhIHdoaWxlIG9uCj4gPiBmdW5jdGlvbiBsaWtlIHRzdF90bXBk
aXJfbWtwYXRoIChyZW1pbmRzIG1lIG9mOiBta2RpcikuCj4gPgo+ID4gQmVjYXVzZSB0aGUgbmFt
ZSBjb3VsZCBiZSBtaXNsZWFkaW5nIHNpbmNlIGl0IHN1Z2dlc3RzIHRoYXQgYQo+ID4gZmlsZSBv
ciBkaXJlY3RvcnkgaXMgYmVpbmcgY3JlYXRlZCwgd2hlbiBpbiBmYWN0IGl0IGlzIHNpbXBseQo+
ID4gY29uc3RydWN0aW5nIGEgcGF0aCBpbnNpZGUgYSB0ZW1wb3JhcnkgZGlyZWN0b3J5IHdpdGhv
dXQKPiA+IGFjdHVhbGx5IGNyZWF0aW5nIGFueSBmaWxlcy4KPgo+IEdvb2QgY2F0Y2gsIHRoaXMg
aXMgaW5kZWVkIGNvbmZ1c2luZy4KPgo+ID4gVG8gbWFrZSB0aGUgZnVuY3Rpb24ncyBwdXJwb3Nl
IGNsZWFyZXIsIHRoZSBuYW1lIHNob3VsZCByZWZsZWN0Cj4gPiB0aGF0IGl0IGlzIG9ubHkgY29u
c3RydWN0aW5nIG9yIGdlbmVyYXRpbmcgYSBwYXRoLCBub3QgY3JlYXRpbmcKPiA+IGFueSBmaWxl
cyBvciBkaXJlY3Rvcmllcy4KPiA+Cj4gPiBTbyBJIHRoaW5rIGVpdGhlciAndHN0X3RtcGRpcl9n
ZW5wYXRoJyBvciAndHN0X3RtcGRpcl9idWlsZHBhdGgnCj4gPiB3b3VsZCBiZSBjb25jaXNlIGFu
ZCBjbGVhciBvcHRpb25zLgo+Cj4gTWF5YmUgdHN0X3RtcGRpcl9nZXRwYXRoKCk/Cj4KCkhtbSwg
SSBmZWVsICdnZW4nIGlzIGJldHRlciB0aGFuICdnZXQnLCBiZWNhdXNlIGdldCBsb29rcyBsaWtl
IHRoZXJlIGFscmVhZHkKZXhpc3QgYW5kIHdlIGp1c3QgZ2V0IHRoZSBwYXRoIGluIGEgcG9pbnRl
ci4gJ2dlbicgaXMgbW9yZSBsaWtlIGdlbmVyYXRpbmcKYSBzdHJpbmcgYnV0IG5vdCBjcmVhdGlu
ZyBpdC4KCk1heWJlIG90aGVycyBoYXZlIGRpZmZlcmVudCBvcGluaW9ucy4KCgotLSAKUmVnYXJk
cywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
