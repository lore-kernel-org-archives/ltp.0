Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C8AC54E64
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 07:40:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B965A3CFB47
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 08:40:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EA783CE52E
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 08:40:24 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2294D1A011D4
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 08:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711352422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZYwNfLC0kjDH9tAtw32Bnyrv5VQXjj0RwNvBfqfz2A=;
 b=FPS3gkhJt9ZoduliPolwW8X0978WjRFxNW8XH0OfJdnF1fmrLlRnrEM38HX2D+ojInrx9J
 Ic7yZHy3izYRSO7+p4CPn6w1uHeQPFW9Tk/klRx/i+K/u3XEzvM7+i7CcgSkkrspC/KEbt
 DDhCunZG2hs11c33aKsPMGedZg1a29Y=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-yqRPaKkOPXCZF5H08lV5tA-1; Mon, 25 Mar 2024 03:40:20 -0400
X-MC-Unique: yqRPaKkOPXCZF5H08lV5tA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a52b4b76c0so1520755eaf.0
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 00:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711352420; x=1711957220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZYwNfLC0kjDH9tAtw32Bnyrv5VQXjj0RwNvBfqfz2A=;
 b=I1Ewi9lJQDhvF/5GNW9+NrZQdUkr0VQ9q0LQs8O5b6f80vA9w+hg88HWw3wnMtJdrO
 oCbFFFtxfoGqFQC4K6LMr/PKgz6dDpq5tA5inkr5TegopdkvuDaZi8DndCLqiLhDMrn0
 OwvvC+3S7RjVJmABjM3WId8mwZb9hQIkNTmcUhaFhn3N0GxP2o+Pj3Ycn2jw1tCHdLoM
 VjgsQCrg8tKIWlO8jKIiPyzmWj9+QgvOYh39kZ0joj+i+Yk09qYYLULwL1qx87+RzYh5
 wqTFbQyahEwcLT/uBnMU5ZHjVOAuPxyga+G3lvR2vIRwm+aUMtoEJg6TO/k7bWIwZR8V
 znVQ==
X-Gm-Message-State: AOJu0YxpEEXlhW9Q6QeYahTQeuxkkuQwoRcL9Tq71HrSO2603H02zZj0
 ZdT3vkbs9Hx0YNBUAoeZBHuuaA2yIsOxPoIw+42eLBdXDcm9csv3qppyTu5bRFJZVGN1hgDnwuh
 U0xYc+znyHXKhjNJM6XVyn6+JIz3T3C1asxM6DBVdx+K/M0XsfUni1WOOPus0rMiyJzeyd2Ry2I
 Vmu3ronnTzupM355pAsiUV5Is=
X-Received: by 2002:a05:6820:308d:b0:5a5:3b23:8494 with SMTP id
 eu13-20020a056820308d00b005a53b238494mr4331726oob.9.1711352419815; 
 Mon, 25 Mar 2024 00:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEagHoZQpNHw2VeRrOrMb4Am9UyqdpxKojuZpaJmgDzWCNFePr2NsH93L3Y3AYQFyhUkabIGAZbPnu8b+Sv3+0=
X-Received: by 2002:a05:6820:308d:b0:5a5:3b23:8494 with SMTP id
 eu13-20020a056820308d00b005a53b238494mr4331720oob.9.1711352419444; Mon, 25
 Mar 2024 00:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
 <cf3287a8009ab6104a4dec45b7b8160f35a358b0.1711045522.git.jstancek@redhat.com>
 <20240322051132.GB572447@pevik>
 <CAASaF6wqF_avAiziA-OSEfoAi6n9xCPeEERNu=OswCa078_1YA@mail.gmail.com>
 <20240322093452.GA604328@pevik>
In-Reply-To: <20240322093452.GA604328@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Mar 2024 08:40:55 +0100
Message-ID: <CAASaF6xFTSx3PnNMXb_39k+X_2CRJw+mApmvZTMEO-+PXYhaqA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/timer_getoverrun01: use
 kernel_timer_t type
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

T24gRnJpLCBNYXIgMjIsIDIwMjQgYXQgMTA6MzXigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+IE9uIEZyaSwgTWFyIDIyLCAyMDI0IGF0IDY6MTHigK9BTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gSGkgSmFuLAo+Cj4gPiA+IC4u
Lgo+ID4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdGltZXJfZ2V0b3ZlcnJ1
bi90aW1lcl9nZXRvdmVycnVuMDEuYwo+ID4gPiA+IEBAIC0xOSwxMCArMTksMTEgQEAKPiA+ID4g
PiAgI2luY2x1ZGUgPHRpbWUuaD4KPiA+ID4gPiAgI2luY2x1ZGUgInRzdF9zYWZlX2Nsb2Nrcy5o
Igo+ID4gPiA+ICAjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+ID4gPiA+ICsjaW5jbHVkZSAi
bGFwaS9jb21tb25fdGltZXJzLmgiCj4KPiA+ID4gPiAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4g
PiA+ID4gIHsKPiA+ID4gPiAtICAgICB0aW1lcl90IHRpbWVyOwo+ID4gPiA+ICsgICAgIGtlcm5l
bF90aW1lcl90IHRpbWVyOwo+Cj4gPiA+IEdvb2QgY2F0Y2guCj4gPiA+IFJldmlld2VkLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KClB1c2hlZC4KCj4KPiA+ID4gQlRXIGluIHYxIHlv
dSB1c2VkIG1lbXNldCgmdGltZXIsIDAsIHNpemVvZih0aW1lcl90KSk7Cj4gPiA+IENvdWxkIGhh
dmUgd2UgdXNlZCB3aXRoIGN1cnJlbnQgY29tcGlsZXJzIGp1c3QgdGltZXJfdCB0aW1lciA9IHt9
IGluc3RlYWQgb2YKPiA+ID4gbWVtc2V0KCk/IE9yIHdoYXQgaXMgdGhlIHJlYXNvbiB3ZSBrZWVw
IHVzaW5nIG1lbXNldCgpIGluc3RlYWQgb2Yge30/Cj4KPiA+IEkgdHJlYXRlZCBpdCBhcyBvcGFx
dWUgdHlwZS4gSWYgaXQgd2FzIGEgc2NhbGFyLCBwbGFpbiB7fSBkb2Vzbid0IHdvcmsgd2l0aCBh
bGwKPiA+IGNvbXBpbGVycy4gRm9yIGV4YW1wbGUgdGhpcyBmYWlscyB0byBjb21waWxlIGZvciBt
ZSB3aXRoIGdjYyAxMToKPiA+IGludCBtYWluKCkgeyBpbnQgaSA9IHt9OyByZXR1cm4gaTsgfQo+
Cj4gPiAkIGdjYyAgLVdwZWRhbnRpYyBhLmMKPiA+IGEuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKA
mToKPiA+IGEuYzoxOjIyOiB3YXJuaW5nOiBJU08gQyBmb3JiaWRzIGVtcHR5IGluaXRpYWxpemVy
IGJyYWNlcyBbLVdwZWRhbnRpY10KPiA+ICAgICAxIHwgaW50IG1haW4oKSB7IGludCBpID0ge307
IHJldHVybiBpOyB9Cj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIF4KPiA+IGEuYzox
OjIyOiBlcnJvcjogZW1wdHkgc2NhbGFyIGluaXRpYWxpemVyCj4gPiBhLmM6MToyMjogbm90ZTog
KG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yIOKAmGnigJkpCj4KPiA+ICJ7MH0iIHNob3VsZCB3b3Jr
IC0gSSBndWVzcyBJIHdhcyBqdXN0IGJlaW5nIHRvbyBjYXJlZnVsLgo+Cj4gVGhhbmtzIGZvciBp
bmZvLCBKYW4uIEkgc3VwcG9zZSB0aGUgcHJvYmxlbSBpcyBhbHNvIG9uIG9sZGVyCj4gZ2NjIChu
b3RoaW5nIGdjYyAxMSBzcGVjaWZpYykuIFdlIGNvbXBpbGUgYWxzbyBvbiBnY2MgNC44IGFuZCA3
LjMuCj4KPiBJcyBpdCBhbHNvIHByb2JsZW0gZm9yIG9sZGVyIGNsYW5nPwoKSXQgaXMgd2l0aCBj
bGFuZyAxNjoKCiMgY2xhbmcgYS5jCmEuYzoxOjIyOiBlcnJvcjogc2NhbGFyIGluaXRpYWxpemVy
IGNhbm5vdCBiZSBlbXB0eQppbnQgbWFpbigpIHsgaW50IGkgPSB7fTsgcmV0dXJuIGk7IH0KCj4K
PiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IGl0IHNob3VsZCBiZSBzYWZlIHRvIHVzZSB7MH0s
IGFuZCB7fSBwcm9iYWJseSB3YWl0cwo+IGZvciB0aGUgZnV0dXJlLgo+Cj4gS2luZCByZWdhcmRz
LAo+IFBldHIKPgo+ID4gPiBLaW5kIHJlZ2FyZHMsCj4gPiA+IFBldHIKPgo+CgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
