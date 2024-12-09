Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9094DE77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 07:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E7FE3E5374
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 08:10:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F22AA3E2CED
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 08:10:09 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5019A60DBD9
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 08:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733728207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKTFWNKR0TvozqXKm9whtrVM6X1hWvzchEKnDzTlSEQ=;
 b=Lswrkh9XdOC5U622Z8d5kcV9wBdfc2mONwlOez/Mub7fXJ/H3D76xuOE0VYhJ1gb78KSUu
 Lp10i3K7zKkPXlkobdIoEjHQBdDWZyvr+IUMFPHq78TQqHocDYchvdnHHROWi7xJoFC4uz
 qF6RV/0BgdpB8NsPJ4Y5v78Lk63koMQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-MenxcvcON0WGbH9N6tTBQw-1; Mon, 09 Dec 2024 02:10:04 -0500
X-MC-Unique: MenxcvcON0WGbH9N6tTBQw-1
X-Mimecast-MFC-AGG-ID: MenxcvcON0WGbH9N6tTBQw
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee86953aeaso4000443a91.2
 for <ltp@lists.linux.it>; Sun, 08 Dec 2024 23:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733728203; x=1734333003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKTFWNKR0TvozqXKm9whtrVM6X1hWvzchEKnDzTlSEQ=;
 b=qGPzRD5gG52T2/A3lwl9w6M9MwltRxgjOQ2Q6XTMr1XCrmepnDstJke0MHTTYxHPK1
 a8fQCFwjHoq6Zo4un28mP+q2PC9eUTTx9d8Zeh1dRWdQIC/oCtKfY6GgF55Bk7YjSej4
 haqWtojzS4QaTZNbaRfLrApK69lOF46IhvzyYGRaG9xqZ49gbTBPXDl55LBXGc5DZ9EN
 zvOkDklOjsCszvAoycOeR58vdar05syudFxdi8Ot7S8jkJbTwcx0PaHodX17UtKlkFVM
 t/hAZF1oR7sM22gqDxnt8y9isCLPKYRsf2J3f+R/rSCYPnYMuNR83NTESJyn13QkgB6N
 oEPw==
X-Gm-Message-State: AOJu0YyviZmssClbAAyQSk/LA1kIQovpJgpItCccmReGyOcnIds35DIK
 yTcimLNEOqfEbbnrKKhLoFtUF+afqYmisnqQSL4d5RBTOzu54zfKD6nvjvSA6q3N23EA6wQ6f3h
 WzlHm6jq1SgECq5XJiDKq+qjMXGHZX6F1SCpB4b0gsN7KJ6FPMWIEV9O0T6G9WdwqpTkL+RKguy
 Ol/fpR+K8AhjJK5j3VxIC0Sbs=
X-Gm-Gg: ASbGnctUgqbMUFmH3yyBDXigdYp2YV20r6y38YZuEou+GlL91+M3pqYbftJ1oOY+zAD
 73YijAa3LY/nBdSf8iTKUJYJSutxa4b6iqDwI
X-Received: by 2002:a17:90a:d88e:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2ef6ab10332mr16075831a91.28.1733728203374; 
 Sun, 08 Dec 2024 23:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOq3p0xT3dP3NlZGq6aW6dNVRRIhm8Ueh0OZ9PsQfkOQ3dD/xsk/u9k5wq3Eert5EZYK6v1WBjoh/rUWMJqXI=
X-Received: by 2002:a17:90a:d88e:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2ef6ab10332mr16075819a91.28.1733728203164; Sun, 08 Dec 2024
 23:10:03 -0800 (PST)
MIME-Version: 1.0
References: <Z1LTvZEBUvK744Ye@yuki.lan>
 <cab714b22f1b2bb055dcc6732aa065c625c23c30.1733492099.git.jstancek@redhat.com>
In-Reply-To: <cab714b22f1b2bb055dcc6732aa065c625c23c30.1733492099.git.jstancek@redhat.com>
From: Li Wang <liwan@redhat.com>
Date: Mon, 9 Dec 2024 15:09:49 +0800
Message-ID: <CAEemH2fNhasDxdjtuMYKpG4ie6b-TsQ3kz=H+UNF5sxfahVb2Q@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vzh66E_V8o9gBf4gfS7rV8BRPO8DCGMw21GYi_BM7nc_1733728203
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] syscalls/getrandom05: add test variants
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

T24gRnJpLCBEZWMgNiwgMjAyNCBhdCA5OjM24oCvUE0gSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPiBBbmQgc2tpcCBFRkFVTFQgZm9yIGdsaWJjIGFzIGl0IGNhbiBz
ZWdmYXVsdCBpbiBWRFNPOgo+ICAgIzAgIF9fYXJjaF9jaGFjaGEyMF9ibG9ja3Nfbm9zdGFjayAo
KSBhdAo+IGFyY2gveDg2L2VudHJ5L3Zkc28vdmdldHJhbmRvbS1jaGFjaGEuUzoxNDYKPiAgIDE0
NiAgICAgICAgICAgICBtb3Z1cHMgICAgICAgICAgc3RhdGUwLDB4MDAob3V0cHV0KQo+Cj4gICAo
Z2RiKSBidAo+ICAgIzAgIF9fYXJjaF9jaGFjaGEyMF9ibG9ja3Nfbm9zdGFjayAoKSBhdAo+IGFy
Y2gveDg2L2VudHJ5L3Zkc28vdmdldHJhbmRvbS1jaGFjaGEuUzoxNDYKPiAgICMxICAweDAwMDA3
ZmNkM2NlNjQxN2EgaW4gX19jdmRzb19nZXRyYW5kb21fZGF0YQo+IChybmdfaW5mbz0weDdmY2Qz
Y2U1ZjI4MCwgYnVmZmVyPTB4ZmZmZmZmZmZmZmZmZmZmZiwgbGVuPTY0LCBmbGFncz0xLAo+IG9w
YXF1ZV9zdGF0ZT0weDdmY2QzY2U1ZGYwMCwKPiAgICAgICBvcGFxdWVfbGVuPTxvcHRpbWl6ZWQg
b3V0PikgYXQKPiBhcmNoL3g4Ni9lbnRyeS92ZHNvLy4uLy4uLy4uLy4uL2xpYi92ZHNvL2dldHJh
bmRvbS5jOjIzNwo+ICAgIzIgIF9fY3Zkc29fZ2V0cmFuZG9tIChidWZmZXI9PG9wdGltaXplZCBv
dXQ+LCBsZW49NjQsIGZsYWdzPTEsCj4gb3BhcXVlX3N0YXRlPTB4N2ZjZDNjZTVkZjAwLCBvcGFx
dWVfbGVuPTxvcHRpbWl6ZWQgb3V0PikKPiAgICAgICBhdCBhcmNoL3g4Ni9lbnRyeS92ZHNvLy4u
Ly4uLy4uLy4uL2xpYi92ZHNvL2dldHJhbmRvbS5jOjI1OQo+ICAgIzMgIF9fdmRzb19nZXRyYW5k
b20gKGJ1ZmZlcj0weGZmZmZmZmZmZmZmZmZmZmYsIGxlbj02NCwgZmxhZ3M9MSwKPiBvcGFxdWVf
c3RhdGU9MHg3ZmNkM2NlNWRmMDAsIG9wYXF1ZV9sZW49PG9wdGltaXplZCBvdXQ+KQo+ICAgICAg
IGF0IGFyY2gveDg2L2VudHJ5L3Zkc28vdmdldHJhbmRvbS5jOjExCj4gICAjNCAgMHgwMDAwN2Zj
ZDNjYzdmYWYzIGluIGdldHJhbmRvbV92ZHNvIChidWZmZXI9MHhmZmZmZmZmZmZmZmZmZmZmLAo+
IGxlbmd0aD02NCwgZmxhZ3M9MCwgY2FuY2VsPTxvcHRpbWl6ZWQgb3V0PikKPiAgICAgICBhdCAu
Li9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9nZXRyYW5kb20uYzoyMDQKPiAgICM1ICAweDAwMDAw
MDAwMDA0MDFmZjcgaW4gdmVyaWZ5X2dldHJhbmRvbSAoaT0wKSBhdCBnZXRyYW5kb20wNS5jOjQw
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPgoK
VGhpcyBvbmUgbG9va3MgYmV0dGVyLgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPgoKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
