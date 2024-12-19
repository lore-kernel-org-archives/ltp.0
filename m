Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9670E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:15:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 682293ED42C
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:15:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 765493C02D1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:15:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D29B21037B62
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734614110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QbAQESkNxMkwcwwVlx6Ivb08KyVpRJthBDSLoVtXwyQ=;
 b=NIZkBVXhh/kzY9cX81HPRQhSWQl18r+htUR5UyGaylDIx0Yyinqq9d5t9NW5DI5DqXpWKp
 3ZTx0aa1eW5jRrCGcKfnrQjjeMkspqDq7CyoS5CcdyjjW3+s6Yz4oIck409xdw1m097/O4
 ByeDrD4X9Bg+YS8dOLbF8Rz8PRfQpIU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ZrObqVRkPz6ZhNjMqD8ajw-1; Thu, 19 Dec 2024 08:15:08 -0500
X-MC-Unique: ZrObqVRkPz6ZhNjMqD8ajw-1
X-Mimecast-MFC-AGG-ID: ZrObqVRkPz6ZhNjMqD8ajw
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-21638389f63so7524995ad.1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 05:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734614107; x=1735218907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbAQESkNxMkwcwwVlx6Ivb08KyVpRJthBDSLoVtXwyQ=;
 b=VGHb0qB8WgQztRWn3ecBtGqYxnURtKCGU9x+zlUhzIbOd571ufd9exSMt2DLPzrJJc
 IzysQG1vLRTfWC/3IF4No1eN86szUde7iv69ipRvln+Z5Zoe4Rbenyn/xDCVivMpJOOr
 M7QamFjLkWjLtJkmxFu3vaZavQq2potTBAeboUXt4YecuxYzSSw331D0A2qy8rF7Jb8L
 pR2jef27xLwTX/OQQSpwv4NbfuDBI5rfXsAEJbQrCHte0UarSQkWzKtvWgZ20To6b83k
 qaSh4LQYWzYpM8ZRw/cj8GOYqW268hvMNQgqTK6QubYJjJowDCqU7y1/sZvedpHj3Yry
 8mdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQYuWoYFOI6PImvadKQZk/x0ubdKojcJUDj7f/1d+6Z03d7vNb3HlPnFjlpUrEfby+RkI=@lists.linux.it
X-Gm-Message-State: AOJu0Yz8uaP6fsbWI6auDr0ewyVNIXN7+7Falph2rpJ1NrZMuGKfPdL9
 xQMstiNw9+E5ccEmjq0HeRaG5sfBiZASVES5WxrHkJyCpVRZvghs9mpKcZ8gL8LxcMqKk2q9/3m
 vDf+GDez0kricv1QIXwmQCuENMLFRZl0ygRlJxMaLLLSbBCphg+zG5BZGXZ4NDEtn0HeybL9Jh9
 LGRPARSbr2E1OKWX/nUcb1Wuo=
X-Gm-Gg: ASbGncs9GCwPk+oXktRxaG6ltJfvpnuRRr+ACq2eJCMdNInqih9n7CCYJhCN3Y5BWvh
 or0bXjVY6kJZYiS+7IpS2PTTGIoEBAElAUqNzidk=
X-Received: by 2002:a17:90b:51c6:b0:2f2:3efd:96da with SMTP id
 98e67ed59e1d1-2f2e9353173mr10278554a91.24.1734614107574; 
 Thu, 19 Dec 2024 05:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6eKzjBm6cwpJIZkCBYPt7AR5nN0NOHEXQTDaVTFF8A9MmAD5Umd7NVZ0fwvfEcQjIkodcmtTsaaQxOM4Lwd0=
X-Received: by 2002:a17:90b:51c6:b0:2f2:3efd:96da with SMTP id
 98e67ed59e1d1-2f2e9353173mr10278528a91.24.1734614107243; Thu, 19 Dec 2024
 05:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <Z2QbRxeekZyxhoCc@yuki.lan>
In-Reply-To: <Z2QbRxeekZyxhoCc@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 21:14:55 +0800
Message-ID: <CAEemH2d6_O-JYe1MsDZ4hO5QL+OrDeCESi=GSAYxWVF+1f6J7w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jwm8K9yLyaNgFhW64KWdMjF1ZSP6lQ9VdBLP0DDaFHY_1734614107
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

T24gVGh1LCBEZWMgMTksIDIwMjQgYXQgOToxMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBXZSBoYXZlIHBsZW50eSBvZiB0ZXN0cyB3aGljaCBr
ZWVwIGxvb3BpbmcgdW50aWwgdGhleSBydW4gb3V0IG9mIHJ1bnRpbWUKPiA+IGFuZCB0aGVuIGF1
dG9tYXRpY2FsbHkgc3RvcC4gVGhlc2UgdGVzdHMgYXJlIG5vdCBhdCByaXNrIG9mIHRpbWluZyBv
dXQKPiA+IGFuZCB0aGlzIHBhdGNoIG9ubHkgbWFrZXMgdGhlbSBydW4gMyB0aW1lcyBsb25nZXIg
dGhhbiBuZWNlc3NhcnkuCj4gPgo+ID4gSSdkIHJlY29tbWVuZCB0ZW1wb3JhcmlseSByZXZlcnRp
bmcgdGhpcyBwYXRjaCBhbmQgYWRkaW5nIGl0IGJhY2sgd2l0aCBhCj4gPiBuZXcgdHN0X3Rlc3Qg
ZmxhZyB0byBpZGVudGlmeSB0ZXN0cyB3aGljaCBleGl0IHdoZW4gcnVudGltZSBleHBpcmVzLgo+
Cj4gU291bmRzIGxpa2Ugd2UgbmVlZCB0byBoYXZlIHR3byBkaWZmZXJlbnQgcnVudGltZSB2YWx1
ZXMgaW4gdGhlIHRlc3RzLAo+IG1heF9ydW50aW1lIHdoaWNoIGlzIHRoZSB0aW1lb3V0IGZvciB0
aGUgdGVzdCBhbmQganVzdCBydW50aW1lIHdoaWNoIGlzCj4gZm9yIGhvdyBsb25nIHdpbGwgdGhl
IHRlc3QgbG9vcC4KPgoKQWdyZWUsIGlmIHdlIGRlZmluZSB0aGUgbG9vcGluZyBydW50aW1lIGlu
IGEgc2VwYXJhdGUgdmFsdWUsIHRoYXQgd291bGQgYmUKaGVscGZ1bC4KCgo+IEFuZCBmb3IgdGhl
IHRlc3QgdGhhdCBsb29wIGZvciBhIGdpdmVuIHJ1bnRpbWUgdGhlIG1heF9ydW50aW1lIHdvdWxk
IGJlCj4gYXV0b21hdGljYWxseSBzZXQgdG8gdGhlIHJ1bnRpbWUgaW4gdGhlIHRlc3QgbGlicmFy
eS4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
