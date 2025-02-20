Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6320EC021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 13:44:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC3BC3C6BA8
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 14:44:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CC8F3C0546
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 14:44:34 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F081114291DC
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 14:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740059072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKZRzH7xOb/zX7dhq3FZaXMs3ivRx93eXP/jbcBlk7o=;
 b=N+I84IqXit1JY/R7EKJ3o1Wb/j/gOPwbFGyD1vNR8G9leloinGYeXEMh2lcfwRkLdQw1Zg
 fvCsFjfcXR3/OnWtAOSXHVF4h8LSpODWfgaxwFn6csb5PbvqWQxiEQlKv5o7QCBjcrWNwc
 GpWG4Bx9Sn73ZZBJwEmx1ycf44VTr6k=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-brIc82ohMDiUA7PRtJOPtA-1; Thu, 20 Feb 2025 08:44:30 -0500
X-MC-Unique: brIc82ohMDiUA7PRtJOPtA-1
X-Mimecast-MFC-AGG-ID: brIc82ohMDiUA7PRtJOPtA_1740059070
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-4bd52b8ca69so203891137.1
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 05:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059070; x=1740663870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKZRzH7xOb/zX7dhq3FZaXMs3ivRx93eXP/jbcBlk7o=;
 b=vPDthpz4Vn4hAFxiwv4RLQ1auhEZ37qB2Kx96Oyw1RFLuugcGQFCbk4hWJCGl5Z7vb
 6Unnohyt9qnWW3R3Mzjvce33XMpDW8/Np8rf4S2TyHvP5b0OI18g4Dxwu3Hs3lRSG/Yo
 s9ggv61YW8rO315x+WlojHQsZpBpq8bt83MguYzxEDI7Qm1I75EhkpodpDVNFckxNsPG
 GVpAVkRpmLTfxQT7WUxywtYFy+uoRGpuZ87P0mvv/2QzgoYu16DdzXShezGwfw97uQQ4
 J06wwq8LBybVDs3GPr7QoiRoTdaqpXW9AQYVtBwDxQykb6B5C3FRsplZq8iOD9rt1+P3
 vRPw==
X-Gm-Message-State: AOJu0YxRw2klhGd/jGMkwHiuvwlI0pa3qtYH1fcdoTd5y5TsYCotBSvZ
 HtiyFa2dT+VeQszPStIGdWl2dDReH7i4nj5mbAghZo2otJOFCxYvgKaazKNbwxsEdVwKsXPjCDS
 eQ6P5SLGFDx3Cp09pCNaackqzNF3KWzZ1RPfobO14qx08zRajQVNIXLE7w7SpiRKPBIe2mg2Jnl
 axSLLv2ohUNCE0Mfhaz/fF204=
X-Gm-Gg: ASbGncuUfcSIwJujMZcIQ4godzgYD8+wZh2/0VkTZ+dtI87xDD2zHbBd1AJgv0ltASP
 I1D2iywCPh+M4pF68Ks6FsRkzybqEy5AV6/K8zBIsue9mHDmEWkqdqWA+8Uk=
X-Received: by 2002:a05:6102:2c05:b0:4bb:c490:7d88 with SMTP id
 ada2fe7eead31-4bd3fcfea26mr14429727137.12.1740059070430; 
 Thu, 20 Feb 2025 05:44:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECiiHoBxYLn5sfuuBWpC7z6xrH1uC37Wap2NdOMN/RSMKtp26SrNhpbKzumRIiy4Az0hPSZIw6kuip+d1kEGc=
X-Received: by 2002:a05:6102:2c05:b0:4bb:c490:7d88 with SMTP id
 ada2fe7eead31-4bd3fcfea26mr14429720137.12.1740059070001; Thu, 20 Feb 2025
 05:44:30 -0800 (PST)
MIME-Version: 1.0
References: <b379b9603036d9d4877f562f750e2d1515dfd962.1740042744.git.jstancek@redhat.com>
 <Z7cPUCOZeJZipmo0@yuki.lan>
In-Reply-To: <Z7cPUCOZeJZipmo0@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 20 Feb 2025 14:44:14 +0100
X-Gm-Features: AWEUYZlMdeCo1HEzM4KJCnMrXKhXM_UBgCAewvW9iaxspbb7hbYkGZlqHVTLQnw
Message-ID: <CAASaF6xatMLYako=PojafDZxEn_GorTcB1NhKtV1kv=BZogsOQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bOVdeYx3VkyGd1jla0jXfpieO43JC7-xdYWLdklA00w_1740059070
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/utime03: relax the check for 1 second
 difference
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBGZWIgMjAsIDIwMjUgYXQgMTI6MTfigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiA+IFRoZSB0ZXN0IGlzIHVzaW5nIHRzdF9nZXRfZnNf
dGltZXN0YW1wKCkgd2hpY2ggaXMgdXNpbmcgUkVBTFRJTUVfQ09BUlNFCj4gPiBjbG9jaywgd2hp
Y2ggaXMgc2xpZ2h0bHkgbGVzcyBhY2N1cmF0ZS4gQmFjayBpbiAyMDIyIHdlIGFkZGVkIGV4dHJh
IGxvZwo+ID4gbWVzc2FnZSB0byBwcmludCBhbHNvIG1pbiBhbmQgbWF4IHRpbWUuIEluIHRob3Nl
IHJhcmUgaW5zdGFuY2VzIHdoZXJlCj4gPiBpdCBmYWlscyB0aGlzIGV4dHJhIGxvZyBzaG93cyBp
dCBmYWlsZWQgYnkgb25lIHNlY29uZCBkaWZmZXJlbmNlLgo+ID4KPiA+IFJlbGF4IHRoZSBjaGVj
ayBhIGxpdHRsZS4gVGVzdGVkIG9uIGFhcmNoNjQgVk1zLCB3aGVyZSBpdCdzIHVzdWFsbHkKPiA+
IHJlcHJvZHVjaWJsZSBhZnRlciBjb3VwbGUgaHVuZHJlZCBpdGVyYXRpb25zLgo+Cj4gQXJlbid0
IHdlIGp1c3QgbWFza2luZyBhIGtlcm5lbCBidWcgaGVyZT8gQmFjayB0aGVuIHdlIGRpc2N1c3Nl
ZCB0aGlzCj4gd2l0aCBrZXJuZWwgZGV2cyBhbmQgdGhleSB0b2xkIHVzIHRoYXQgZmlsZXN5c3Rl
bXMgdXNlIFJFQUxUSU1FX0NPQVJTRQo+IGludGVybmFsbHksIHNvIHRoaXMgc2hvdWxkbid0IHJl
YWxseSBmYWlsLgoKSSBzZWUgdGhlIGZhaWx1cmVzIHJlc3VyZmFjaW5nIGFyb3VuZCA2LjEzLXJj
MS4KRnJvbSBjb21taXQgNGU0MGVmZjBiNTczICgiZnM6IGFkZCBpbmZyYXN0cnVjdHVyZSBmb3Ig
bXVsdGlncmFpbiB0aW1lc3RhbXBzIikKdGhlIGNvbW1lbnQgb24gY3VycmVudF90aW1lKCkgbm93
IHNheXMgIlJldHVybiBGUyB0aW1lIChwb3NzaWJseSBmaW5lLWdyYWluZWQpIi4KCk1heWJlIHdl
IGhpdCBhIHBvaW50IHdoZXJlIGludGVybmFscyBjaGFuZ2VkPyBJJ2xsIHNlZSBpZiBJIGNhbiBu
YXJyb3cKaXQgZG93biBmdXJ0aGVyCndpdGggYmlzZWN0LgoKPgo+IFdoYXQgZmlsZXN5c3RlbSBp
cyB0aGlzPyBEb2VzIGl0LCBieSBjaGFuY2UsIHVzZSBtb3JlIGdyYW51YWwKPiB0aW1lc3RhbXBz
PwoKSSBzYXcgaXQgZmFpbCBvbiBleHQyLCBleHQzIGFuZCB4ZnMuCgo+Cj4gLS0KPiBDeXJpbCBI
cnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
