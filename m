Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5BAD609C8
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 10:09:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3F13DB5C4
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 11:09:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A732E3DB5B9
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 11:09:00 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 89E6C1BDD09E
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 11:08:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732702137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XUNbZt+w8SXjlfu0i0UdbSqSMSTmDrwpfGkm/sH790E=;
 b=JEMw1J2whD/sMbJTWnfSdF5WcZNQLqyJTldccKynfSUae6BWSajaSzN/wXenN7Mo1BJmBx
 dT1HFRw++jQZyfGy0o58ikowdecUEBTvcvXutXV1dC1aKbEcrwWWK+cReqUajKl3XcUMK2
 VMMqgolnwF87LCiJ699N2IJGlc51NQs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-7CdokNTTNNa3bo_kFiWATg-1; Wed, 27 Nov 2024 05:08:55 -0500
X-MC-Unique: 7CdokNTTNNa3bo_kFiWATg-1
X-Mimecast-MFC-AGG-ID: 7CdokNTTNNa3bo_kFiWATg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ea6b37ed73so654222a91.0
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 02:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732702135; x=1733306935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUNbZt+w8SXjlfu0i0UdbSqSMSTmDrwpfGkm/sH790E=;
 b=hLAUwAYyi1U7QDyIxDkuHGP47xYeiCe1O4ZaRNz/M4M0r+Hh0SQ2OknbusTPVjJnkB
 7BhwOEwN6lo8xMKLYHvM34Bw6QDslh9Y8R2cB7lkPDKzLzKveV4YFYjpr5oO1nAYx+xy
 30Wquz2W3qT3pUBMqx+Ga4rHNcSwX3Po6QkgqP9WzzDHlLmRCayNbedKTrXIVBfDfeSc
 J1MZNbR80+QMj9nEPdQWwaVYz/6286aByYFT7+GtUzGQ12DAeQwCRtMJZi0Y0/GftfWi
 F3ZSsdvVq5wUdVpUtdQfOGGBW8GSYstWJ4Bz+g0cnfbJseY35hfQix2kEGCMhPeZvzOp
 WF5Q==
X-Gm-Message-State: AOJu0Yz5QsIEE2NBaVqyEnolg918G1SLVSu5WIeEYvxfA6ivERWxMVM7
 PakXD5XpCO1FPWJFI8+6hnOcSTmscyUzHVO0lrbWArsqZQsFEQuYVjmIqZrXkaiDsX9zYqTV/J2
 lfY2+tGT7ksJwOK7WJiC7EutSkp/l40YOvFGJClOQxy4KFd+JOhB5Fr2bZTpAjcgHatN+jBLFyg
 Zdhd4kIhqtw57ZQ8x/DC79QRU=
X-Gm-Gg: ASbGnctjmhgsxZctjXr9CLpi76GwUnsAa21EKqgCs09FIF2rN8jpvIpiNRuhwQdZxQA
 TIPU99RInDWuPkQ+NsRq6XgKe/9TXUf7Q
X-Received: by 2002:a17:90b:1004:b0:2ea:9f3a:7d9 with SMTP id
 98e67ed59e1d1-2edeb68cff8mr10035574a91.3.1732702134896; 
 Wed, 27 Nov 2024 02:08:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi8OyHxoBfnXHGtv+xSMmfi+CFhCJxNgUU2fGAJJOtTdU5wtNcWXfvWuLTniICppRdwcoy7FWTDewrFEyqOwE=
X-Received: by 2002:a17:90b:1004:b0:2ea:9f3a:7d9 with SMTP id
 98e67ed59e1d1-2edeb68cff8mr10035550a91.3.1732702134474; Wed, 27 Nov 2024
 02:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20241126100445.17133-1-liwang@redhat.com>
 <Z0WitZsMZat6wdA2@yuki.lan>
 <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
 <Z0Wvsq571rTt46Ie@yuki.lan>
 <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
 <Z0bqZAiaOo7E3E9I@yuki.lan>
In-Reply-To: <Z0bqZAiaOo7E3E9I@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Nov 2024 18:08:42 +0800
Message-ID: <CAEemH2cJmBra=SajChZ-KKe9GimCBtdvwcnWNiwEz2dHFP8f4Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IzpoFpeal8_b1KB53HSmQBRpZqNVj54sn2Q1rsWDD8c_1732702135
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMjcsIDIwMjQgYXQgNTo0NuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJIGhhdmUgY2FyZWZ1bGx5IGNvbXBhcmVkIHRoZSBk
aWZmZXJlbmNlcyBiZXR3ZWVuIHRoZSBnZW5lcmFsCj4gPiBrZXJuZWwgY29uZmlnLWZpbGUgYW5k
IHRoZSBkZWJ1ZyBrZXJuZWwgY29uZmlnLWZpbGUuCj4gPgo+ID4gQmVsb3cgYXJlIHNvbWUgY29u
ZmlndXJhdGlvbnMgdGhhdCBhcmUgb25seSBlbmFibGVkIGluIHRoZSBkZWJ1Zwo+ID4ga2VybmVs
IGFuZCBtYXkgY2F1c2Uga2VybmVsIHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uLgo+ID4KPiA+IFRo
ZSByb3VnaCB0aG91Z2h0cyBJIGhhdmUgaXMgdG8gY3JlYXRlIGEgU0VUIGZvciB0aG9zZSBjb25m
aWd1cmF0aW9ucywKPiA+IElmIHRoZSBTVVQga2VybmVsIG1hcHMgc29tZSBvZiB0aGVtLCB3ZSBy
ZXNldCB0aGUgdGltZW91dCB1c2luZyB0aGUKPiA+IHZhbHVlIG11bHRpcGxpZXIgb2J0YWluZWQg
ZnJvbSBjYWxpYnJhdGlvbi4KPiA+Cj4gPiBlLmcuIGlmIG1hcHBlZCBOIG51bWJlciBvZiB0aGUg
Y29uZmlncyB3ZSB1c2UgKHRpbWVvdXQgKiBOKSBhcyB0aGUKPiA+IG1heF9ydW50aW1lLgo+ID4K
PiA+IE9yIG5leHQsIHdlIGV4dHJhY3QgdGhpcyBtZXRob2QgdG8gdGhlIHdob2xlIExUUCB0aW1l
b3V0IHNldHRpbmcgaWYKPiA+IHBvc3NpYmxlPwo+Cj4gVGhhdCBhY3R1YWxseSBzb3VuZHMgZ29v
ZCB0byBtZSwgaWYgd2UgZGV0ZWN0IGNlcnRhaW4ga2VybmVsIG9wdGlvbnMKPiB0aGF0IGFyZSBr
bm93IHRvIHNsb3cgZG93biB0aGUgcHJvY2VzcyBleGVjdXRpb24gaXQgbWFrZXMgYSBnb29kIHNl
bnNlCj4gdG8gbXVsdGlwbHkgdGhlIHRpbWVvdXRzIGZvciBhbGwgdGVzdHMgZGlyZWN0bHkgaW4g
dGhlIHRlc3QgbGlicmFyeS4KPgoKVGhhbmtzLgoKQWZ0ZXIgdGhpbmtpbmcgaXQgb3ZlciwgSSBn
dWVzcyB3ZSdkIGJldHRlciBfb25seV8gYXBwbHkgdGhpcyBtZXRob2QKdG8gc29tZSBzcGVjaWFs
IHNsb3cgdGVzdHMgKGFrYS4gbW9yZSBlYXNpbHkgdGltZW91dCB0ZXN0cykuIElmIHdlIGRvCnRo
ZSBleGFtaW5hdGlvbiBvZiB0aG9zZSBrZXJuZWwgb3B0aW9ucyBpbiB0aGUgbGlicmFyeSBmb3Ig
YWxsLCB0aGF0Cm1heWJlIGEgYnVyZGVuIHRvIG1vc3QgcXVpY2sgdGVzdHMsIHdoaWNoIGFsd2F5
cyBmaW5pc2ggaW4gYSBmZXcKc2Vjb25kcyAoZmFyIGxlc3MgdGhhbiB0aGUgZGVmYXVsdCAzMHMp
LgoKVGhlcmVmb3JlLCBJIGNhbWUgdXAgd2l0aCBhIG5ldyBvcHRpb24gZm9yIC5tYXhfcnVudGlt
ZSwgd2hpY2ggaXMKVFNUX0RZTkFNSUNBTF9SVU5USU1FLiBTaW1pbGFyIHRvIHRoZSBUU1RfVU5M
SU1JVEVEX1JVTlRJTUUKd2UgZXZlciB1c2UuIFRlc3QgYnkgYWRkaW5nIHRoaXMgLm1heF9ydW50
aW1lID0gVFNUX0RZTkFJTUNBTF9SVU5USU1FCnRoYXQgd2lsbCB0cnkgdG8gZmluZCBhIHByb3Bl
ciB0aW1lb3V0IHZhbHVlIGluIHRoZSBydW5uaW5nIHRpbWUgZm9yIHRoZQp0ZXN0LgoKU2VlOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNC1Ob3ZlbWJlci8wNDA5OTAu
aHRtbAoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
