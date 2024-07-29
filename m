Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E36C3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 15:44:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4AF83D1D78
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 17:44:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 523FA3D0B2B
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 17:43:51 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 399681A0153A
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 17:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722267828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sUXB7Z6OFWxjstQdhq5JHnSI+W/8G/mcC641I5alm8=;
 b=fDLGiM+yJbCthOG8PdPg0uag+7RkebfZeDFUvnHFLlxlODAkNawgQkBRDzBsKdzy4f4D2A
 3TtRX3eQk6HWbZPT5dVk6lMLOqCJG/EizmZSkYCYx1ZNfrbNGUO2G78Y9wC2wSXgpxH9WM
 fEEbiewABKZofDF/mWJ9n/9u62hTnAU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-zszMQafVOw6lLWZon2qkaA-1; Mon, 29 Jul 2024 11:43:45 -0400
X-MC-Unique: zszMQafVOw6lLWZon2qkaA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42808efc688so18571505e9.0
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 08:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722267821; x=1722872621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4sUXB7Z6OFWxjstQdhq5JHnSI+W/8G/mcC641I5alm8=;
 b=Dc2LkZITVD/QNbEI2VRUuGlUzHgXa5/583AoNVWOuBN77pKXsXswaQ881o5wqp5JKd
 SH/Bq1wvj/t0ktLhXPb2LkhNAqnZpXx3wNttHaPwHl1X1x+uScixBxK0f1CtgIB1/8X8
 OGF5qPUEsR7KT/CyxHaHEC7KIH9kz2+rAzrvZnycNbcC9j+W+JfGtPApfnamFiUtbwKo
 OPxtEOt8T6luYVyz5uQUKQNdSSyBvGHmXPHFFX8EybYnTOiL47OHeoH1scTT/BYErMqd
 Q1YXwpOp8NnOFuyeoFardMI6JMMXTxiYMaVhY8p7bNve9agvnbt2qhaHkO45OmmluTvq
 VXUw==
X-Gm-Message-State: AOJu0YxkipHo2gPqFDoyxaoJWF59OFsq67nd4aA6LPGW4vGEt8UiRZJM
 phf5vL2GeSL02kowYQOplf6Qkh92b/C0hxgjlU1RgTdcM4n1Q5AxtkahhROmD+yK0NLFMMrP8EA
 AJd4zQXXh/rqiBa+7LXaq4+b19GkgdulFrA7mrzLamgQB1AvyA/twhJ48NlnmmEX+/vT4erlOQ9
 cKMFM8bXOJSErWJF3igJwxK4k=
X-Received: by 2002:a5d:54cc:0:b0:367:89d3:5d4f with SMTP id
 ffacd0b85a97d-36b5cee49e5mr4763745f8f.12.1722267821698; 
 Mon, 29 Jul 2024 08:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGprxE3lgNLpPYoW6Akz94XGTG/JDYz8wqCK9jnV0C439qnPUw+dmMzw1Ss/qXvhiQTIeIfug0k7g01MI2sTgY=
X-Received: by 2002:a5d:54cc:0:b0:367:89d3:5d4f with SMTP id
 ffacd0b85a97d-36b5cee49e5mr4763723f8f.12.1722267821073; Mon, 29 Jul 2024
 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240724130553.126252-1-fstornio@redhat.com>
 <ZqEaRwixo1dHiBEC@yuki>
In-Reply-To: <ZqEaRwixo1dHiBEC@yuki>
From: Filippo Storniolo <fstornio@redhat.com>
Date: Mon, 29 Jul 2024 17:43:30 +0200
Message-ID: <CAHzY_-55nD2yUQRL0wUT9ddD5ESSnBJAqiYZ5PscJF=bU4+j=A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mlock05: add log details about the success/failure
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

SGkhCgpPdXIgdGVzdCBsb2dzIHdpbGwgYmUgcmV2aWV3ZWQgYnkgcGVvcGxlIG5vdCBmYW1pbGlh
ciB3aXRoIHRoZSB0ZXN0IHB1cnBvc2UKb3IgaXRzIGltcGxlbWVudGF0aW9uLiBUaGVzZSB3aWxs
IGJlIHBlb3BsZSB3aG8gbWF5IG5vdCBoYXZlIHRoZSBiYWNrZ3JvdW5kCm9yIHRpbWUgbmVjZXNz
YXJ5IHRvIHJlYWQgYW5kIHVuZGVyc3RhbmQgdGhlIHNvdXJjZSBjb2RlLgoKSG93ZXZlciwgaW1w
cm92aW5nIHRoZSBUU1RfRVhQX0VRX0xVKCkgbWFjcm8gdG8gcHJpbnQgYWRkaXRpb25hbAppbmZv
cm1hdGlvbiBsb29rcyBncmVhdCBhbmQgSSBiZWxpZXZlIGl0IHdvdWxkIGJlIHRoZSBiZXR0ZXIg
YXBwcm9hY2gsIGFzCml0IHdvdWxkIGFsc28gYmUgdXNlZnVsIGZvciBmdXR1cmUgY29udHJpYnV0
aW9ucy4KRG8geW91IGFscmVhZHkgaGF2ZSBzb21ldGhpbmcgaW4gbWluZCBmb3IgYSBwb3NzaWJs
ZSBpbXBsZW1lbnRhdGlvbj8KSSB3YXMgdGhpbmtpbmcgb2YgY3JlYXRpbmcgYSBuZXcgb25lIHRo
YXQgbG9va3MgbGlrZSB0aGlzOgpUU1RfRVhQX0VRX0xVX01TRygpIHNvIHRoYXQgdGhlIHRlc3Qg
d3JpdGVyIGNhbiBhZGQgYSBjdXN0b20gbWVzc2FnZSB3aGVyZQp0aGUgdGVzdCBwYXNzZXMvZmFp
bHMuCgpGaWxpcHBvIFN0b3JuaW9sbwoKT24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgNToxNOKAr1BN
IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJbiBzb21l
IHRlc3RpbmcgZW52aXJvbm1lbnRzLCBzdWNoIGFzIHRob3NlIHJlbGF0ZWQgdG8gc2FmZXR5Cj4g
PiBjcml0aWNhbCByZXF1aXJlbWVudHMsIG1vcmUgZGV0YWlsZWQgbG9ncyBhcmUgbmVlZGVkIHdo
ZW4KPiA+IHRoZSBleGVjdXRlZCB0ZXN0IHBhc3NlcyBvciBmYWlscy4KPiA+IFRoaXMgZm9ybWF0
IGFscmVhZHkgZXhpc3RzIGluIG90aGVyIExUUCB0ZXN0cywgc3VjaCBhcwo+ID4ga2VybmVsL3Nl
Y3VyaXR5L2thbGxzeW1zL2thbGxzeW1zLmMKPgo+IFdoYXQgZXhhY3RseSBhcmUgdGhlIHJlcXVp
cmVtZW50cz8gSXQgd291bGQgbWFrZSBtb3JlIHNlbnNlIHRvIGltcHJvdmUKPiB0aGUgVFNUX0VY
UF9FUV9MVSgpIG1hY3JvIHRvIHByaW50IHRoZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGluc3Rl
YWQuLi4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
