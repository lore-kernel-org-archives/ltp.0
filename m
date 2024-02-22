Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7F7C48BF8
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 07:58:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C5943CD8D4
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 08:58:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0DAA3CD507
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 08:58:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 43E07140872C
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 08:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708588693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAwv7DJejeaUkO8II+PEWL+pEQeGLt92a1QFpm1OJ54=;
 b=AY4JclHkPzyb9I3pgYx/t9YIsazWrTVMtps6fNt6RKBhRz8r8tK/GnKheDv5ySblBlHnKI
 6OOtJfoh0/HnYArZM+yLX6laMC7JiS4kxMAgbPmuJ9lBAD9lWik44NQIKBAjOJIUYzyPUU
 hO3ESMOJULuV8G/G3Tb7gwJXqLAuTwE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-dfN36n-iMV2EWM4ltjomlQ-1; Thu, 22 Feb 2024 02:58:10 -0500
X-MC-Unique: dfN36n-iMV2EWM4ltjomlQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2995baae8b4so4701515a91.0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 23:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708588689; x=1709193489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAwv7DJejeaUkO8II+PEWL+pEQeGLt92a1QFpm1OJ54=;
 b=Qxgza4hQbyORaJbkps3nLWPbsJwAA4oEDkThjECTOZIugvLVKoS2KYmG/jA2JI7qIJ
 suMxkAwO4/zbeJmnoivXXT+cnIZ98nFY1b1LZRwfY2KMyCb2xka5eVpCh/g+jKR5oHtt
 kNlVgJMayY4+260bKYoTF75X8XJl9VDiQ2t/J9goFgAXX/BTDNfZEgyp42vX67otufYO
 7Uit0fxbAudXpJs2BRva1V4Z6rGm8MuAHwC5YItOP07/PWh8fX3bql56ESvmuWJBm91o
 Rc3cw4lhF3g3AqI2TdDkXPRERS6vcRQONRj2FDGLvG63QqdJxLcEoFd5+ZXumLrjJxTw
 3QdQ==
X-Gm-Message-State: AOJu0YxXMtrsoZz4OwNIIinfpVVf+bX2OEQfGsC5QKXHyCTbGsWFg8Tg
 /2KQ/o3PBi9y+YnaveCHHAZOiKdUXiYyFyKRmzPYJ5ug8tMEI/C2MptlzOUqbCs7/8J8QxTcbQK
 CPZP3v6hLx/4ofXepI6KhKqIz5FprNh607v901G+poaCbDdipHwIP5+E0g4uG3+KiqmpccJiour
 5J6CHwLJrprDtXNFqpBSIJ9oM=
X-Received: by 2002:a17:90a:c50:b0:299:906b:488e with SMTP id
 u16-20020a17090a0c5000b00299906b488emr10380306pje.18.1708588689668; 
 Wed, 21 Feb 2024 23:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFursPdPUATsj1NWf0A6YM0QAxN10lsMLhS6Eq1StBIUIM+DGIBVpPU4oIVKM2TFCt48iI/4Q3ggCir5BHfDJ4=
X-Received: by 2002:a17:90a:c50:b0:299:906b:488e with SMTP id
 u16-20020a17090a0c5000b00299906b488emr10380289pje.18.1708588689193; Wed, 21
 Feb 2024 23:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20240222044119.28500-1-wegao@suse.com>
In-Reply-To: <20240222044119.28500-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Feb 2024 15:57:57 +0800
Message-ID: <CAEemH2ehUO8=2K0RtPfuFCouGQU+Gn9ouzh+SVB5-hrQxedoaA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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

T24gVGh1LCBGZWIgMjIsIDIwMjQgYXQgMTI6NDHigK9QTSBXZWkgR2FvIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IFRoZSBtYWtlX3N3YXBmaWxlIGZ1bmN0aW9uIHdpbGwg
ZW5jb3VudGVyIG5vIHNwYWNlIGVycm9yIGlmIHBhZ2VzaXplCj4gaXMgYmlnZ2VyIHRoZW4gNDA5
Niwgc3VjaCBhcyBwcGM2NCBzeXN0ZW0gdXNlIGRlZmF1bHQgcGFnZXNpemUgNjU1MzUuCj4KCldo
YXQgZXJyb3MgZG9lcyBpdCBzaG93cyBpbiB0aGUgbG9nPwoKSSBjYW4ndCByZXByb2R1Y2UgdGhp
cyBvbiBteSBhYXJjaDY0IChwYWdlc2l6ZSA9PSA2NTUzNikuClNlZW1zIHRoZSAnLmRldl9taW5f
c2l6ZSA9IDM1MCcgaXMgbGFyZ2UgZW5vdWdoIGZvciB0ZXN0aW5nLgoKCgo+Cj4gU2lnbmVkLW9m
Zi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYyB8IDcgKysrKysrLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jCj4gYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9mZjAxLmMKPiBpbmRleCBjMzAzNTg4ZGYuLjcxZDZj
NmMwNCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dh
cG9mZjAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9m
ZjAxLmMKPiBAQCAtNDQsNyArNDQsMTIgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgewo+
ICAgICAgICAgaXNfc3dhcF9zdXBwb3J0ZWQoVEVTVF9GSUxFKTsKPgo+IC0gICAgICAgaWYgKG1h
a2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCA2NTUzNiwgMSkpCj4gKyAgICAgICBpbnQgYmxvY2tzID0g
NjU1MzU7Cj4gKwo+ICsgICAgICAgaWYgKGdldHBhZ2VzaXplKCkgPiA0MDk2KQo+ICsgICAgICAg
ICAgICAgICBibG9ja3MgPSA2NTUzNSAqIDQwOTYgLyBnZXRwYWdlc2l6ZSgpOwo+ICsKPiArICAg
ICAgIGlmIChtYWtlX3N3YXBmaWxlKFNXQVBfRklMRSwgYmxvY2tzLCAxKSkKPiAgICAgICAgICAg
ICAgICAgdHN0X2JyayhUQlJPSywgIkZhaWxlZCB0byBjcmVhdGUgZmlsZSBmb3Igc3dhcCIpOwo+
ICB9Cj4KPiAtLQo+IDIuMzUuMwo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
