Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CAEC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 633813C7C2A
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:41:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 725EB3C02C9
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:40:56 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D003140DE60
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737117653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2m9HJyXL2R/rA9dXv6r2edU6NeTBxjZWPClD16eOU00=;
 b=Q2D+v+m5zlwpXOBebxNl0rBRPceBvPuB6n60mqGojselxEpXwnpzH2byYxUSJgTFQTa8+Y
 ycumdRqu1ZBcdy+s5m8MyidKU0zrw26kbBPe5Iy6cfe7krFDOZ9+2EsOlNSK+BxrG6UXX4
 0rY2etiYE8/6y+QyB7AVkhPvCFtVz4Y=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-xBJ45Hd9Oo6DJm9ZosCpsQ-1; Fri, 17 Jan 2025 07:40:52 -0500
X-MC-Unique: xBJ45Hd9Oo6DJm9ZosCpsQ-1
X-Mimecast-MFC-AGG-ID: xBJ45Hd9Oo6DJm9ZosCpsQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef35de8901so3999634a91.3
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 04:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737117650; x=1737722450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2m9HJyXL2R/rA9dXv6r2edU6NeTBxjZWPClD16eOU00=;
 b=b+IIbk5hr3IRv2AbG5O5Qvwcn9gVHxekb2ic45Hm+9Ycktc/f7hu8kbLQzru2ZE80/
 9k93tSJVp8g7rbClfvDaP0EQP/43eQn9RZXgo3by6xipjNAs5rB1zXvg5k3XS6toTuMv
 Rjz79PaTB1NnJ+NFZgsGmUTyUdXyr1KjhUhFt1uPndFgtNtcFrbzsC/vDefczrFE2zTP
 +sifEXI24I6hx3/nx8nQ3ZlUKaopTbW4+mTu19oFSxcfVi/HhAmtibr5Gprr0WPOQw3m
 Cv6qUqUnWN1eGkbVO3HCYCkeB8h2raZw8w2gGjwLdg6Dhhl815lE7vDsCqRI56QkgbRW
 hHuQ==
X-Gm-Message-State: AOJu0Yw6u5depDjqyFhvg7fP/Ta1zqzKWJnr5AVYr20fL0/uGy4JA1iG
 XFlOF3FkCrQXyBYDI3BqR3WCQIBIfso0slyDxOhlI9KRFqCV2GWS/74eM3dFiCOPvb1RGDsTTmF
 QSabb70VYcTAARl10KQ5OM88P7cF6Xucddwy34jJ6YFO6jZwibvEYxvN8SmS/UvzyyEMf+ps1gQ
 elIPV0wMKhCA3Rk4h1drXVFpYudaQ5zrllHds3
X-Gm-Gg: ASbGncuTJtLOnRzZlk8jUmG2xdEfaP0IGLRxXJDw49WOYuWQyuZ/be460pgH3Lqd9If
 Zi2QgHJL1RBmbeESbQMSH3g0GEtiDfxrkxK1VS6uWPGIqhrJzeS/X
X-Received: by 2002:a17:90b:2c84:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f782c7de14mr3917054a91.14.1737117649989; 
 Fri, 17 Jan 2025 04:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0HMpAfaJHvkn5Rc70MfoR5vHad0mtdebh+59nvda0M8zb+jek7Uo+6O805AzQx1CrqQ836GeUZi/1fyLmuqg=
X-Received: by 2002:a17:90b:2c84:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f782c7de14mr3917014a91.14.1737117649586; Fri, 17 Jan 2025
 04:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20250117122455.7989-1-chrubis@suse.cz>
 <20250117122455.7989-2-chrubis@suse.cz>
In-Reply-To: <20250117122455.7989-2-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 20:40:37 +0800
X-Gm-Features: AbW1kvacia88TfyDOQnPRCFTElf4PlTPbw6AXb4H49P_j1QFxy4jYeTM8ay_KT0
Message-ID: <CAEemH2dRa-ZXwZTDMRcMRU5EKstCCz=bestSv+8bsa2cgrVVhw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iBepA3QhBFtrIQ6aAi2spHQ1Vhst6FJnKop-tkQqOPs_1737117651
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] testcases/lib: tst_net.sh: Do not use stderr
 in tst_rhost_run()
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgODoyNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gVGhpcyBpcyBhbm90aGVyIHBsYWNlIHRoYXQgYnJva2UgdGhlIG5l
dHdvcmsgdGVzdCBvbiB0aGUgdW5yZWxhdGVkCj4gY2hhbmdlcyB0aGF0IGNhdXNlZCB0aGUgU0FG
RV9DTE9ORSgpIHRvIHByb2R1Y2UgVElORk8gbWVzc2FnZXMuIFRoZSB0ZXN0Cj4gbGlicmFyeSBw
cmludHMgbWVzc2FnZXMgaW50byB0aGUgc3Rkb3V0LCBiZWNhdXNlIHRoaXMgaXMgc29tZXRoaW5n
IHRoYXQKPiBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgdGhlIGNvbW1hbmQgb3V0cHV0IGJ1dCByYXRo
ZXIgZGlhZ25vc3RpYyBtZXNzYWdlcy4KPiBTbyB0aGVyZSB3YXMgbm8gZ29vZCByZWFzb24gdG8g
aW5jbHVkZSB0aGUgc3RkZXJyIGluIHRoZSBkYXRhIHdlIGdvdAo+IGZyb20gdGhlIHRzdF9yaG9z
dF9ydW4oKS4KPgo+IElmIHRoaXMgcGF0Y2ggZG9lcyBub3QgYnJlYWsgYW55dGhpbmcgaXQgc2hv
dWxkIGJlIHB1c2hlZCBzaW5jZSB0aGlzCj4gd2lsbCBmaXggdGhlIHRzdF9uc18qIGhlbHBlcnMg
ZXZlbiBpZiB0aGUgdGhleSBzdGFydCBwcmludCBkaWFnbm9zdGljcwo+IFRJTkZPIG1lc3NhZ2Vz
IGFnYWluLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+
Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgotLS0KPiAgdGVz
dGNhc2VzL2xpYi90c3RfbmV0LnNoIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3RzdF9u
ZXQuc2ggYi90ZXN0Y2FzZXMvbGliL3RzdF9uZXQuc2gKPiBpbmRleCBlZTBhZTFjYWQuLjYwYmMy
NWI3OSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvbGliL3RzdF9uZXQuc2gKPiArKysgYi90ZXN0
Y2FzZXMvbGliL3RzdF9uZXQuc2gKPiBAQCAtMjU3LDcgKzI1Nyw3IEBAIHRzdF9yaG9zdF9ydW4o
KQo+ICAgICAgICAgICAgICAgICB0c3RfcmVzXyBUSU5GTyAiJHVzZTogJHJjbWQgXCIkc2hfY21k
XCIgJG91dCAyPiYxIgo+ICAgICAgICAgZmkKPgo+IC0gICAgICAgb3V0cHV0PSQoJHJjbWQgIiRz
aF9jbWQiICRvdXQgMj4mMSB8fCBlY2hvICdSVEVSUicpCj4gKyAgICAgICBvdXRwdXQ9JCgkcmNt
ZCAiJHNoX2NtZCIgJG91dCB8fCBlY2hvICdSVEVSUicpCj4KPiAgICAgICAgIGVjaG8gIiRvdXRw
dXQiIHwgZ3JlcCAtcSAnUlRFUlIkJyAmJiByZXQ9MQo+ICAgICAgICAgaWYgWyAkcmV0IC1lcSAx
IF07IHRoZW4KPiAtLQo+IDIuNDUuMgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
