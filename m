Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4A7E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 07:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E39EA3E538F
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 08:31:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A33BC3E2D27
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 08:31:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04C9F201759
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 08:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733729480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bs5eFddDyIBhhFOnwNKrprRlOefKrabgGve1f4TAowI=;
 b=bDC6O5idK3Xs1Vtz/0VOKYFmTnFl+KOC7qddXc/yAkZlOZDZZJnKjmsHy6u+8GpfOKshDk
 +z54pEytT7m84lIaPDA/0kKglIwBzeP1X8RFNT0mbrdsfVTLVqftqssAVeXNht3IuLTVWG
 iUMRIgU3OAq91P4cDVvx+/FCWKbH+yA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-nmihQEtdNRqeSWkPRoTafQ-1; Mon, 09 Dec 2024 02:31:19 -0500
X-MC-Unique: nmihQEtdNRqeSWkPRoTafQ-1
X-Mimecast-MFC-AGG-ID: nmihQEtdNRqeSWkPRoTafQ
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3ea540db525so3147479b6e.1
 for <ltp@lists.linux.it>; Sun, 08 Dec 2024 23:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733729478; x=1734334278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bs5eFddDyIBhhFOnwNKrprRlOefKrabgGve1f4TAowI=;
 b=arjGSb8R526RWAVHxSztofg+d+Jg8VKk5LhCgX3Oa8BKK2hIPbnJYKjK7eWCiVTi05
 gJRvAHPS4A12pH544OMZAfVy7adZ+3plT8XbTJMcY8d+mVLyQoR2m4rJv8AFaxU227ZD
 VvjBvwH1Epdufx95zOEs7pwgieCPYJoym9rk1RsIccjJKr44iEhNH/YA4AtE2uIHiMSg
 cLf9cc3Bb92wGndbBlF1o1u6PbzmjoK8nR7K+mwYbRIqJk5rs7AI12rCdCEmqwFNt5Dk
 mY3JoPUB47rJ5ZzqRDBDLhTR9vTs/rwrs86ZPTa08HsiKwFarSx/mfbwCwq38MuKoVUH
 4DVw==
X-Gm-Message-State: AOJu0YzMGnkjIS0D0AQIBCThlfec3/0egcZ5OE9UXhV32arQ6qLkHZpC
 iPgXzzEZad93OKiX+kqjxHRgsNilQoieVZPhlK7obNkLrL7Tsa1BY++Rpfqg5ltqrGPHbq7r9FC
 gskIgL/Ln2v6slHCpmRnBVYYgSvyQnl+xs/QlrZq4had9Gb4hrCnwH30fL4NkUrcsQMXm63oPut
 0YubtyuwF1UzJ6W3B++MTh9BI=
X-Gm-Gg: ASbGncuF1vXXJovU/eZhTcng8h5P+H1oyrkVEDoZb+TnEQG1ccektOWI49pDA/mxk3e
 NUl+YB7yHiPX5EwX6bBpqhUuJIhM81J4=
X-Received: by 2002:a05:6808:3cc:b0:3eb:3b69:8ff7 with SMTP id
 5614622812f47-3eb3b69910emr3374142b6e.26.1733729478551; 
 Sun, 08 Dec 2024 23:31:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGDw8P6uFNDZcj1d7bDAZfDx5wKw3/KU+BnjDxeeJtSREFBwdg0spowEqnc5hc8XRMTvsC9VQxF6vqGViqnv4=
X-Received: by 2002:a05:6808:3cc:b0:3eb:3b69:8ff7 with SMTP id
 5614622812f47-3eb3b69910emr3374133b6e.26.1733729478173; Sun, 08 Dec 2024
 23:31:18 -0800 (PST)
MIME-Version: 1.0
References: <Z1LTvZEBUvK744Ye@yuki.lan>
 <cab714b22f1b2bb055dcc6732aa065c625c23c30.1733492099.git.jstancek@redhat.com>
 <CAEemH2fNhasDxdjtuMYKpG4ie6b-TsQ3kz=H+UNF5sxfahVb2Q@mail.gmail.com>
In-Reply-To: <CAEemH2fNhasDxdjtuMYKpG4ie6b-TsQ3kz=H+UNF5sxfahVb2Q@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 9 Dec 2024 08:31:02 +0100
Message-ID: <CAASaF6wRYt5k3dk84JLcf-zBupyH0ZDVhN0QNo+EcWZ9=ajJhg@mail.gmail.com>
To: Li Wang <liwan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E2BRb8SPaJUfBsxHtgnsCdBI-kh3mON4owW36fMNYoo_1733729478
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
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

T24gTW9uLCBEZWMgOSwgMjAyNCBhdCA4OjEw4oCvQU0gTGkgV2FuZyA8bGl3YW5AcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPgo+Cj4gT24gRnJpLCBEZWMgNiwgMjAyNCBhdCA5OjM24oCvUE0gSmFuIFN0
YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiBBbmQgc2tpcCBFRkFVTFQg
Zm9yIGdsaWJjIGFzIGl0IGNhbiBzZWdmYXVsdCBpbiBWRFNPOgo+PiAgICMwICBfX2FyY2hfY2hh
Y2hhMjBfYmxvY2tzX25vc3RhY2sgKCkgYXQgYXJjaC94ODYvZW50cnkvdmRzby92Z2V0cmFuZG9t
LWNoYWNoYS5TOjE0Ngo+PiAgIDE0NiAgICAgICAgICAgICBtb3Z1cHMgICAgICAgICAgc3RhdGUw
LDB4MDAob3V0cHV0KQo+Pgo+PiAgIChnZGIpIGJ0Cj4+ICAgIzAgIF9fYXJjaF9jaGFjaGEyMF9i
bG9ja3Nfbm9zdGFjayAoKSBhdCBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZnZXRyYW5kb20tY2hhY2hh
LlM6MTQ2Cj4+ICAgIzEgIDB4MDAwMDdmY2QzY2U2NDE3YSBpbiBfX2N2ZHNvX2dldHJhbmRvbV9k
YXRhIChybmdfaW5mbz0weDdmY2QzY2U1ZjI4MCwgYnVmZmVyPTB4ZmZmZmZmZmZmZmZmZmZmZiwg
bGVuPTY0LCBmbGFncz0xLCBvcGFxdWVfc3RhdGU9MHg3ZmNkM2NlNWRmMDAsCj4+ICAgICAgIG9w
YXF1ZV9sZW49PG9wdGltaXplZCBvdXQ+KSBhdCBhcmNoL3g4Ni9lbnRyeS92ZHNvLy4uLy4uLy4u
Ly4uL2xpYi92ZHNvL2dldHJhbmRvbS5jOjIzNwo+PiAgICMyICBfX2N2ZHNvX2dldHJhbmRvbSAo
YnVmZmVyPTxvcHRpbWl6ZWQgb3V0PiwgbGVuPTY0LCBmbGFncz0xLCBvcGFxdWVfc3RhdGU9MHg3
ZmNkM2NlNWRmMDAsIG9wYXF1ZV9sZW49PG9wdGltaXplZCBvdXQ+KQo+PiAgICAgICBhdCBhcmNo
L3g4Ni9lbnRyeS92ZHNvLy4uLy4uLy4uLy4uL2xpYi92ZHNvL2dldHJhbmRvbS5jOjI1OQo+PiAg
ICMzICBfX3Zkc29fZ2V0cmFuZG9tIChidWZmZXI9MHhmZmZmZmZmZmZmZmZmZmZmLCBsZW49NjQs
IGZsYWdzPTEsIG9wYXF1ZV9zdGF0ZT0weDdmY2QzY2U1ZGYwMCwgb3BhcXVlX2xlbj08b3B0aW1p
emVkIG91dD4pCj4+ICAgICAgIGF0IGFyY2gveDg2L2VudHJ5L3Zkc28vdmdldHJhbmRvbS5jOjEx
Cj4+ICAgIzQgIDB4MDAwMDdmY2QzY2M3ZmFmMyBpbiBnZXRyYW5kb21fdmRzbyAoYnVmZmVyPTB4
ZmZmZmZmZmZmZmZmZmZmZiwgbGVuZ3RoPTY0LCBmbGFncz0wLCBjYW5jZWw9PG9wdGltaXplZCBv
dXQ+KQo+PiAgICAgICBhdCAuLi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9nZXRyYW5kb20uYzoy
MDQKPj4gICAjNSAgMHgwMDAwMDAwMDAwNDAxZmY3IGluIHZlcmlmeV9nZXRyYW5kb20gKGk9MCkg
YXQgZ2V0cmFuZG9tMDUuYzo0MAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0
YW5jZWtAcmVkaGF0LmNvbT4KPgo+Cj4gVGhpcyBvbmUgbG9va3MgYmV0dGVyLgo+Cj4gUmV2aWV3
ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKUHVzaGVkLgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
