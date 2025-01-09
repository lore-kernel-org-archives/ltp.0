Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0BE7719A
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 573903C1DAA
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 07:32:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E23B3C1C38
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:32:21 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDA2A1BCD692
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736404339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCOAwqmBEmLAS/XTH+8+CTyvB5l+vbZ96FftlgqlQlo=;
 b=UEWIzh1QR1FqFPkMCc5FutDzfn9iJLard3/XWu3yBXxnbPud6Xv+nP0aOAYodm+V7cPp8U
 0hHGVyNe0FfUt4zQ0A2cQSMWWA1as0+010aMcPkRyCFb/KIHmmYaeDpYDe8Q3K9N+CgBDQ
 c2MqyboPWPEdOHh3M/HL/TdrfAYxEds=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-wG0tdFhDMqyNQjRXYXR5Iw-1; Thu, 09 Jan 2025 01:32:16 -0500
X-MC-Unique: wG0tdFhDMqyNQjRXYXR5Iw-1
X-Mimecast-MFC-AGG-ID: wG0tdFhDMqyNQjRXYXR5Iw
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so51993066b.0
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 22:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404335; x=1737009135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCOAwqmBEmLAS/XTH+8+CTyvB5l+vbZ96FftlgqlQlo=;
 b=jkQPZnVL6xCJ+U4Xdu1bx7xk4UPkWhtFBfxKwRcnb78vsIAjOyqDrRos5BfiXSm0fw
 4IL3GdOI59+w0c4b3YKsnzlVaTfiGiX9Wdb4kGuqqcLSBn5963zRVZXKOlixZ2E6JKTg
 gGKjV2lFy3J2e70Y1bVavHXMH/h6LUNa/3eIMuzl71Jw1qoAB1aYiFUBO8PhyjZ1pS90
 oDJjpou6POjdcxLB9ish8PvPnutZxupOis0E2BIbECelZn6aU+ycax0LXvDYYIMDbXTt
 RDwKiEx4n15//jvZPxyRD7y3z/J8o+nBjuYUhF+1ZK61DFK2DeDuBCBEVTquPIC486sO
 63dg==
X-Gm-Message-State: AOJu0YwS8I94Q0Kedo4EV3x/xcP0K2Ykgg9xT+EnKiKbmeHQ+kaJ6pFJ
 hGDs07vcf8E0Ar322Lfh3+e6GxE8l3zA87dF3MKJ3qjxVs7YHjbyxSwcfEiIGlJOAODgLNsjXxA
 /B01AlFd4eWMQMKIGn6tM5zB7XNGAZP+LZ7byQYuLtMrASZ3HZ/4kbY8RSIw7drrjiZKhMLvZ5w
 +xTvvo2mTwzCtlDJ5z9Y1cB8g=
X-Gm-Gg: ASbGncuMyOPXx9NQsxDeW4RL5FDHZFEAe8yWWlhcTXcO28gmZz4VzIluEr2rjTwGwgl
 xq6xtIjCML6x/QvcqhonnaZIcmGAJVuEnYsY4bYg=
X-Received: by 2002:a17:907:3e21:b0:aa6:2b8b:20c6 with SMTP id
 a640c23a62f3a-ab2ab70afdfmr421049066b.20.1736404334765; 
 Wed, 08 Jan 2025 22:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETRoW1kFDIjIbbr30BWb/XLLYh0r2D/UxwlU4w1x8avyfFUyIsLwwDQxQp3xhWRbgU6sFmZ8orh2YI2EdBKpE=
X-Received: by 2002:a17:907:3e21:b0:aa6:2b8b:20c6 with SMTP id
 a640c23a62f3a-ab2ab70afdfmr421047266b.20.1736404334427; Wed, 08 Jan 2025
 22:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
 <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
 <Z35wmODIV_vuYBOA@rei>
In-Reply-To: <Z35wmODIV_vuYBOA@rei>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 14:31:58 +0800
X-Gm-Features: AbW1kvbL4y5-iSAeeG5fO0VE5jlmYdAT6JsqeWXZd4HF0m14MVuiPoIfBpNV6K0
Message-ID: <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wM595Xlt2v934RggzQ17-hqIL4QfjhpyJsNBa-LdCiU_1736404335
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gOCwgMjAyNSBhdCA4OjI54oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gQnR3LCB3ZSBoYXZlIHNvbWUgdGVzdHMgdGhhdCBp
bXBsaWNpdGx5IGludm9rZSB0c3RfcmVtYWluaW5nX3J1bnRpbWUsCj4gPiA+IGZvciBleGFtcGxl
LCB1c2luZyB0aGUgZnV6enlfc3luYyBsaWJyYXJ5LCB3aGljaCBhbHNvIG5lZWRzIC5ydW50aW1l
Cj4gPiA+IGJ1dCBub3QgLnRpbWVvdXQuCj4gPiA+Cj4gPgo+ID4gQWxzbywgdGVzdHMgdGhhdCB1
c2UgJ3Rlc3QucnVudGltZScgZGlyZWN0bHkgKGUuZy4gcmVhZGFoZWFkMDIuYywKPiA+IHNldF9t
ZW1wb2xpY3kwMS5jKQo+ID4gbXVzdCBjb250aW51ZSB0byBiZSBtYXJrZWQgYXMgdXNpbmcgLnJ1
bnRpbWUuCj4KPiBJIHRoaW5rIHRoYXQgcmVhZGFoZWFkMDIgaXMgYSBjYXNlIHdoZXJlIHdlIHNo
b3VsZCBzd2l0Y2ggdG8gdGltZW91dAo+IGJlY2F1c2UgdGhhdCBpcyBleGFjdGx5IHRoZSBzaXR1
YXRpb24gd2hlcmUgd2FudCB0aGUgdGltZW91dCB0byBiZQo+IG11bHRpcGxpZWQgd2hlbiB0aGUg
c3lzdGVtIGlzIHNsb3dlci4gVGhlIHdheSB0aGUgdGVzdCBhZGp1c3QgdGhlCj4gcnVudGltZSBk
eW5hbWljYWxseSBpcyB3cm9uZyBhbnl3YXlzLCBiZWNhdXNlIGl0IGluY3JlYXNlcyB0aGUgdGlt
ZW91dAo+IGZvciBlYWNoIGl0ZXJhdGlvbi4gV2Ugc2hvdWxkIGp1c3QgcHV0IHRoZSB3b3JzdGNh
c2UgcnVudGltZSBpbnRvIHRoZQo+IC50aW1lb3V0IGluc3RlYWQuCj4KCkkgaGF2ZSBhIGRpZmZl
cmVudCB2aWV3IG9uIHRoZSByZWFkYWhlYWQwMiB0ZXN0LCBiZWNhdXNlIHRoZSBydW50aW1lCnJl
c2V0dGluZyBpcyBiYXNlZCBvbiBwaWVjZXMgb2YgZWFjaCBJTyB0ZXN0IGVsYXBzZWQgdGltZSwg
dGhlbiByZXNldApydW50aW1lIGZvciBuZXh0IHRpbWUuIFRoaXMgYXBwbGllcyB0byBhbnkga2Vy
bmVscywgbm8gbWF0dGVyIHRoZSBmYXN0ZXIKb3Igc2xvd2VyLCB0aGUgZWxhcHNlZCB0aW1lIHdp
bGwgYmUgZW5vdWdoIGZvciB0aGUgbmV4dCB0Y2FzZXNbXS4KCklmIHdlIHB1dCB0aGUgd29yc3Qt
Y2FzZSBydW50aW1lIGludG8gLnRpbWVvdXQgYW5kIHJlc2V0IGZvciB0aGUgbmV4dAp0Y2FzZXNb
XSwgd2hpY2ggd2lsbCBiZSBtdWx0aXBsaWVkIGFnYWluIG9uIGRlYnVnIGtlcm5lbCwgYWN0dWFs
bHkgd2UKZG9uJ3QgbmVlZCB0aGF0IHNpbmNlIHRoZSBkeW5hbWljIHJ1bnRpbWUgY29tZXMgZnJv
bSBhIHJlYWwgdGVzdC4KCk1heWJlIEkgbWlzc2VkIHNvbWV0aGluZyBpbiB0aGUgdGVzdCwgYnV0
IHdlIGNhbiB0cmVhdCByZWFkYWhlYWQwMgppbiBhIHNlcGFyYXRlIHdvcmsuIFRoZSBuZXcgcGF0
Y2ggNC80IHNob3VsZCBiZSBtb2RpZmllZCB1c2luZyAucnVudGltZQppbnN0ZWFkIG9mIC50aW1l
b3V0LiBGZWVsIGZyZWUgdG8gY29tbWVudCB5b3VyIHRob3VnaHRzIHRoZXJlLgoKCgo+Cj4gQW5k
IHNpbWlsYXJpbHkgZm9yIHRoZSB0aGUgbWVtcG9saWN5IGl0IGxvb2tzIGxpa2Ugd2Ugc2hvdWxk
IHNldCB0aGUKPiB0aW1lb3V0IGR5bmFtaWNhbHkgaW4gdGhlIHRlc3R1cCB3aXRoIHRzdF9zZXRf
dGltZW91dCgpIGluc3RlYWQgb2YKPiBydW50aW1lLgo+CgpBZ3JlZWQgdGhpcyBjaGFuZ2Ugb24g
bWVtcG9saWN5MDEuYy4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
