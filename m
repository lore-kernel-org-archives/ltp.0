Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFFBC52D7C
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 11:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0137B3D20D7
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 13:40:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95D813CBC79
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 13:40:39 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DF5D81400E75
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 13:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723203636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeA27LMtF1F6GMt6EVcjGoFtnuPxIWLLpJlTeuANcEg=;
 b=ENjlU7rb/iMZ4FlyN8GxKg6ceq9xPGi5RHA7N1T2Hem3eBBN1bLLdCY9HHAzsNFTu1VLFt
 NF4v/xhhxoVL3TCXD8FheSBL4xOyPcJoFYhokddPAu+WGaDnyVOaBiHXaLKjpA783zvORP
 ti23V9q1TPMtmQk7I45G3L/No0U6U/w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-pjU5_8HkOdqwnQK4rBO_TA-1; Fri, 09 Aug 2024 07:40:35 -0400
X-MC-Unique: pjU5_8HkOdqwnQK4rBO_TA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb5ba80e77so2476922a91.1
 for <ltp@lists.linux.it>; Fri, 09 Aug 2024 04:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723203634; x=1723808434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AeA27LMtF1F6GMt6EVcjGoFtnuPxIWLLpJlTeuANcEg=;
 b=bcsBXBLziyoMX35cKhtJRYv1dluWK3QzfrNamWZ/PUg1zJ0maJKwrKMUOte4Tgeyug
 kKGdPD1Z8caemaCVaA/C+mllFK6UbJWHeJc1AZlHelHMIAaIGx0BeqQHO3FPsrBznUi3
 8t5yQml2oecEWy1wbSkkUQlJrbN3ETc3wWvCk0JWyqXFhMNf/TQIoblr/IBw+zNArjcl
 F7EejYMXP8cfMD8TEcXtQJ/vg/Sdf1L+9UXobONHL1H5o/yPKNq6cE/JHG6cSgvowXXF
 PrXcMw8L6cNyrsoCcocM8CpFaXyw8Jk955I/JFIUC/kCl2GxGTpaoWb3x0h2CjvYLwUG
 +HiA==
X-Gm-Message-State: AOJu0Yzi4ETJPdMv4Ag3m7/AKXQnCsqN5KfL3nNRhM67YqqoYHMD11M6
 t42rwPhzis1rFegUq9gO5UdqNNA/DnWqhDyWe8Mb1rUiXxQOVKDdxTauN5Z7I2STaxDs9j+y6t2
 S6pZprl6RSW4eBUooCLxAV1tQ7eNiyyx5Kt7139/TdGregeOdIBvwRhsP6aO47D0xmDFZbHYgg4
 fxhki2fTKLXjHC6TwDdcb+w+k=
X-Received: by 2002:a17:90a:62c9:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2d1e7ff24a8mr1280639a91.23.1723203634023; 
 Fri, 09 Aug 2024 04:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ9tq372GgOD504OqrMvLw48qwNMCcjWz1mnnQQuHCCTs1aFwsOFb2EXlWOUZM5Ck38CWM1DspYY4egJ1/SnE=
X-Received: by 2002:a17:90a:62c9:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2d1e7ff24a8mr1280623a91.23.1723203633652; Fri, 09 Aug 2024
 04:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240809095505.352377-1-pvorel@suse.cz>
In-Reply-To: <20240809095505.352377-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Aug 2024 19:40:21 +0800
Message-ID: <CAEemH2dVqP+r-u6XexYifVAyzNwSdeOsBk-NNrpdWgM3eNssew@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] pkey01: Fix TBROK due missing results
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

SGkgUGV0ciwKCk9uIEZyaSwgQXVnIDksIDIwMjQgYXQgNTo1NeKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gUEtFWV9ESVNBQkxFX0VYRUNVVEUgaXMgcHBjNjRsZSBz
cGVjaWZpYyB0ZXN0LiBEdWUgbWVzc2FnZXMgYmVpbmcKPiBUSU5GTyB0ZXN0IG9uIG90aGVyIGFy
Y2hzIGZhaWxzOgo+Cj4gICAgIHRzdF90ZXN0LmM6MTQ5ODogVEJST0s6IFRlc3QgMiBoYXZlbid0
IHJlcG9ydGVkIHJlc3VsdHMhCj4KCkFoIHllcywgSSB0aGluayBvZiB3aHkgSSB1c2VkIHRzdF9i
cmsgaW4gbXkgcHJldmlvdXMgcGF0Y2guCgoKPgo+IENoYW5naW5nIG1lc3NhZ2VzIHRvIFRDT05G
LiBBbHNvIGV4aXQgbG9vcCBvbiAhZXhlY3V0ZV9zdXBwb3J0ZWQgVENPTkYKPiAobm8gbmVlZCB0
byBoYXZlIDMweCBUQ09ORiB3aXRoIHRoZSBzYW1lIGVycm9yIG1lc3NhZ2UsIGJlY2F1c2Ugd2Ug
aGF2ZQo+IFBLRVlfRElTQUJMRV9FWEVDVVRFIGxhc3QpLiBUaGUgb3RoZXIgVENPTkYgKG9uIE1B
UF9IVUdFVExCKSBtdXN0IGJlCj4gcmVwZWF0ZWQuCj4KCkFncmVlZC4KCgo+IEZpeGVzOiBkMmI4
YTQ3NmMyICgicGtleTAxOiBBZGRpbmcgdGVzdCBmb3IgUEtFWV9ESVNBQkxFX0VYRUNVVEUiKQo+
IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+IEhpIExp
LCBhbGwsCj4KPiBpZiB5b3UgZG9uJ3QgbGlrZSBQS0VZX0RJU0FCTEVfRVhFQ1VURSBoYXZpbmcg
dG8gYmUgdGhlIGxhc3QsIHdlIGNhbgo+IGp1c3QgaGF2ZSAzMHggVENPTkYgKGp1c3QgdG8gY2hh
bmdlIGJvdGggVElORk8gdG8gVENPTkYpLiBXaGF0ZXZlciB5b3UKPiBwcmVmZXIuCj4KCkl0J3Mg
b2theSwgSSBndWVzcyBQS0VZX0RJU0FCTEVfRVhFQ1VURSBpcyBhbHJlYWR5IHRoZSBsYXN0IGZl
YXR1cmUKZm9yIG1lbSBwcm90ZWN0aW9uLCBSRUFELCBXUklURSwgRVhFQywgYW5kIEkgZG9uJ3Qg
ZXhwZWN0IHRoZXJlIHdpbGwKYmUgYSBuZXcgcGVybWlzc2lvbiB0byBhcHBlYXIgOikuCgpGZWVs
IGZyZWUgdG8gYWRkOgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
