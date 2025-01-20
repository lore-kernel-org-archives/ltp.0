Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECD5C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:32:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75A853C194C
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 11:32:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C87703C036A
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:32:07 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28CBF1B610DF
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737369125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+OUSvXm4N4oKFkDfL63/a0OpmIEBrJ/ek7dPiBq828=;
 b=BF5ODAn4WDVg6gD7O9f5eFuEAiWYv7BAeOYCGFPOMV8c19gz9Dbh+yA0UPw40ueJ62go9s
 CtpUQhH5tg3r5WW1UBBnzLjoGZ54ML+izmFXfQM/vjHjvofG3W9Hxvml03BrwvSx0a+Y8w
 NUlCXoFkA57eGqMLQjlOrXIUFjQBRyw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-aarNhk3-MXmz51Ih773pWw-1; Mon, 20 Jan 2025 05:32:03 -0500
X-MC-Unique: aarNhk3-MXmz51Ih773pWw-1
X-Mimecast-MFC-AGG-ID: aarNhk3-MXmz51Ih773pWw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2efc3292021so12361480a91.1
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 02:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737369121; x=1737973921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+OUSvXm4N4oKFkDfL63/a0OpmIEBrJ/ek7dPiBq828=;
 b=HOJ8YTtVrv9eisRq9CQxvOoRv7QSTccHdck9REqq1xL0D4oRMS+xaHkS099dTITMCo
 rR/+34zkRoT7RUEo01CiGX3ESIccoRnIfrRPz4U2f/kop423ztqj3poaDC9qwr5jo+YN
 bOi+g+I6XMMo8gXLPYisV4e9VY89ksmzp+jzuf5xuY/KfmpZDSxFI7f/qOi3B3o07zS6
 GsRSFUm1u89pPrtIs15ZISXW//jf8ktjjJauPLb/QjxbNpfdsmgsmdvXqoiMoewZNAbs
 Pm9Gvkn4ueDs+H0zT48oT9U0BG0mmgAIlWEmGQ/2SdpnBS0zezRpkk/zUAXqlx7Lvm/M
 bQOw==
X-Gm-Message-State: AOJu0Yxcp8BuGRpFq/6bXDHmhJFGDbaS61DMB6Lag/GcaObnapngccku
 +fMAaDH4j8fn/Kevnme/CT1HK1fc+ls6rJl4+Dja2tmNa08P+XvngsRKsVL8vHOdHAZl9E4K2Gw
 lIJHWBu+DOnTjzbPBaPaN57OgDqBsL9s68JjunTSPTFqll6GWkuBKkYLn6eWRoFSstLaMEyD+o/
 7SLmhonJWTDeTwyf8o6774gg+IBweE+/WCBQF/
X-Gm-Gg: ASbGncvOG483MHYWp69VCve5gXmmmJ2iM+TS3kEwNto0cKUixbIyXl/TtvqaoVL1jiV
 i9F5CT8Bd5wZ72t4ZhjFpelvZeQRRiievpzx/KxRraLaHubTM0Zk=
X-Received: by 2002:a17:90b:2543:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2f782d9a1e1mr20275093a91.33.1737369121361; 
 Mon, 20 Jan 2025 02:32:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSsC8btq82ODFxqNZ4A7+Q363k11dG/ysyjeeAeUQMBf7h0WGmykH7V9kVdp1OV/d3lscx/r4lSvIDJL/oOeQ=
X-Received: by 2002:a17:90b:2543:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2f782d9a1e1mr20275069a91.33.1737369120972; Mon, 20 Jan 2025
 02:32:00 -0800 (PST)
MIME-Version: 1.0
References: <Z3vJ6zXDVPACBIGd@yuki.lan> <Z4pj78casC9Ioyga@yuki.lan>
In-Reply-To: <Z4pj78casC9Ioyga@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jan 2025 18:31:48 +0800
X-Gm-Features: AbW1kvY9chED7dxKUfGkESS6opH8eqNHMM0gYbZn9MUIxqYqwQZZOslom2Sxowo
Message-ID: <CAEemH2fCiT3Sn-SwEAcmvWXaPQVVPa=zKzLv5As2ug8vn=JT8Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qKt9-2UmBLCtFmaawGN6i2--2_RfqyKN3IWSCWbkD_4_1737369122
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgMTA6MDfigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+IENhbiB3ZSBmcmVlemUgZ2l0IHRvZGF5PyBUaGVyZSBh
cmUgc29tZSBmaXhlcyB0aGF0IGFyZSBzdGlsbAo+IHdvcmstaW4tcHJvZ3Jlc3MgYnV0IHRoZXNl
IGNhbiBnbyBpbiBhZnRlciB0aGUgZnJlZXplLgo+Cj4gSWYgdGhlcmUgYXJlIGFueSBwYXRjaGVz
IHRoYXQgYWRkIG5ldyBmdW5jdGlvbmFsaXR5IGFuZCBzaG91bGQgYmUKPiByZXZpZXdlZCBiZWZv
cmUgdGhlIHJlbGVhc2UgcGxlYXNlIGxldCBtZSBrbm93IG5vdy4KPgoKSSBoYXZlIGZpbmlzaGVk
IG15IGZpcnN0IHJvdW5kIExUUCBwcmUtcmVsZWFzZSB0ZXN0IG9uIGJvdGggUkhFTC05LjYKYW5k
IFJIRUwtMTAsIGV2ZXJ5dGhpbmcgbG9va3MgZ29vZCBiZXNpZGVzIHRoZSBvbmx5IG9uZSBjb21w
aWxlciBlcnJvcgpvZiBjdmUtMjAxNS0zMjkwLmMuCgpMaWtlIEhhbnhpYW8gcG9pbnRlZCBvdXQg
dGhhdCBnY2MtMTQuMi4xLTYuZWwxMC54ODZfNjQgbm90IGFsbG93IHRoZQpicCB0byBiZSB1c2Vk
IGluICdhc20nOgpodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNS1KYW51
YXJ5LzA0MTU2NS5odG1sCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
