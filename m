Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26079C25B7C
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 09:56:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7DEC3D053D
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 11:56:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02E93D0512
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:56:38 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C28941A0027B
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716890196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDM4PAr++RgQc1+LlWGkJI4kbcHW4BiLk47Cvzlkw7A=;
 b=NGmJmPGmg86nEjlldN9Tx6bgTBFyr26LuWhqr3zxf8a4Utif6WRBLkmvMQvaCYb6Eiz5Vy
 Lu42AWTfRhJPrSbNSvhtZZzY+mmkfpv2wLGevg97wBp0JVO+RImAlrmb0iIS1Dfyd2OWE/
 wZ/K4Q+eWU/ji0h/mrb86uJISWt/jIU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-o1p7cDUlOxWTmYHE9YU3Mw-1; Tue, 28 May 2024 05:56:32 -0400
X-MC-Unique: o1p7cDUlOxWTmYHE9YU3Mw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b9b5d6c64bso611764eaf.2
 for <ltp@lists.linux.it>; Tue, 28 May 2024 02:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890191; x=1717494991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDM4PAr++RgQc1+LlWGkJI4kbcHW4BiLk47Cvzlkw7A=;
 b=s1C2driHQWLRc76jH02okMLLjvi2NSDZVE1ccQbgkhLw3Q+LlFO+4UDHSSPGtCkZkM
 rlY7dWetRe0CW8fnaUNIqVB8wAUL2YrmdgNMAONptGSlgRhyJgGv6MLJI2BrmnAskFof
 Jvam20nwL8AeATlR5sMs2FvthWZwRgXpV33Z3deQQhrHCD/qCrcEPdFjlx8H9GJHyIqi
 /hIQ5kVV57ByV9Rx980faFgt5KgASgVbcBgnj9XwuMjBL7HVpf4CSIhCrIHK6e2Wwi5t
 NKO8uwDEup+mkqN7/HQTlQeOm+pYA+VahiAbQq74F63kk/uH7BS3O7kjrUdL+CcxKd48
 H36g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCocLtf5wYsy9PpAugUOIw5EnHENR3QtLgLTlEUkDJQkSuYtV1uFSR7wgJ/3NiJRUAIhvR0KLxAqQvxcWYvectUm0=
X-Gm-Message-State: AOJu0YwBAQHo2qkZOnCjrHFMl8qyBjwzSqTvcD3TGCo3C+7/UljpTVj1
 5E023cOIauKhF4Mp2FjxFi76PP6mIGJy3JkwRU76ucD9NKsG5xcRHbemi9EkYK9CjeyYRJ7ZtBS
 vKBmRL6LjZcQ7LfELjB/zUHvcUX6U8cUNDhSf4OuNxcQwD27sJ6iMQ8yfGVrKtFlRXZ1TCDxTJN
 pDN65xWGD1WjxQ59k4H1qwamc=
X-Received: by 2002:a05:6820:1620:b0:5b8:80f1:8f3 with SMTP id
 006d021491bc7-5b9bdcffb68mr2730517eaf.1.1716890191457; 
 Tue, 28 May 2024 02:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVxOlINvdwgHOva12jJdHFN4pJx70r0dC7+jkbUsaAk+QEfgBozux7UV5h7pzzosOL304X22t00NUeg0rFeZk=
X-Received: by 2002:a05:6820:1620:b0:5b8:80f1:8f3 with SMTP id
 006d021491bc7-5b9bdcffb68mr2730499eaf.1.1716890191000; Tue, 28 May 2024
 02:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240527135718.29451-1-mdoucha@suse.cz>
 <20240527223551.GA374567@pevik>
 <8774370a-d6c7-42f6-a135-57fdf23032d9@suse.cz> <20240528093752.GA408250@pevik>
In-Reply-To: <20240528093752.GA408250@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 May 2024 11:56:14 +0200
Message-ID: <CAASaF6yh-xaVZXK8yQkrHWN7sLcSSrpWrF1NBgrSR_h=Ye_NYg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kvm_pagefault01: Do not write into tdp_mmu sysfile
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

T24gVHVlLCBNYXkgMjgsIDIwMjQgYXQgMTE6MzjigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+IE9uIDI4LiAwNS4gMjQgMDozNSwgUGV0ciBWb3JlbCB3cm90ZToK
PiA+ID4gPiArCj4gPiA+ID4gKyBpZiAocmVhZF9ib29sX3N5c19wYXJhbShURFBfTU1VX1NZU0ZJ
TEUpID4gMCkKPiA+ID4gPiArICAgICAgICAgdHN0X3JlcyhUSU5GTywgInRkcF9tbXUgaXMgZW5h
YmxlZCwgYmV3YXJlIG9mIGZhbHNlIG5lZ2F0aXZlcyIpOwo+Cj4gPiA+IFdvdWxkbid0IGl0IGJl
IGJldHRlciB0byBhZGQgIldBUk5JTkc6IiB0byBtYWtlIGl0IG1vcmUgdmlzaWJsZT8KPiA+ID4g
ICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgIldBUk5JTkc6IHRkcF9tbXUgaXMgZW5hYmxlZCwg
YmV3YXJlIG9mIGZhbHNlIG5lZ2F0aXZlcyIpOwo+Cj4gPiA+IChpZiB5b3UgYWdyZWUsIEkgY2Fu
IGNoYW5nZSBpdCBiZWZvcmUgbWVyZ2UpCj4KPiA+IEkgdGhvdWdodCBhYm91dCBpdCBmb3IgYSB3
aGlsZSBhbmQgSSBzZWUgZ29vZCByZWFzb25zIGZvciBib3RoIFRJTkZPIGFuZAo+ID4gVFdBUk4u
IEl0IHNob3VsZG4ndCBtYXR0ZXIgZm9yIG91ciB0ZXN0cyBiZWNhdXNlIHRkcF9tbXUgZGVmYXVs
dHMgdG8gb2ZmIG9uCj4gPiBTTEUtMTVTUDQgYW5kIFNMRS0xNVNQNS4gSWYgb3RoZXIgcmV2aWV3
ZXJzIGFncmVlLCBmZWVsIGZyZWUgdG8gY2hhbmdlIGl0IHRvCj4gPiBUV0FSTi4KPgo+IEkgc2xp
Z2h0bHkgcHJlZmVyIHRzdF9yZXMoVElORk8sICJXQVJOSU5HOiAuLi4iLCB0aGFuIFRXQVJOLiBB
bHRob3VnaCBmYWxzZQo+IG5lZ2F0aXZlIGlzIHNlcmlvdXMsIHN0aWxsIGZhaWxpbmcgdGhlIHRl
c3QgYmFzZWQgb24gc3VzcGljaW9uIG9mIGZhbHNlCj4gcG9zaXRpdmVzIGlzIG5vdCBnb29kLgo+
Cj4gQExpLCBASmFuLCBATWV0YW46IGFueSBvcGluaW9uIG9uIGl0PwoKSSdkIGdvIHdpdGggVElO
Rk8gaGVyZSwgYXMgeW91IHN1Z2dlc3RlZC4KCj4KPiBBbHNvLCBJIHNlbmQgYSBwYXRjaCB0byBh
ZGQgVElORk9fV0FSTiBmbGFnICh5ZWFoLCB1Z2x5IG5hbWUpIHRvIHByaW50IFRJTkZPCj4gYnV0
IHNsaWdodGx5IG1vcmUgdmlzaWJsZSBkdWUgdGhlIGNvbG9yLgo+Cj4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0Lz9zZXJpZXM9NDA4Mzk0JnN0YXRlPSoKPgo+
IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
