Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B154E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 05:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12F903C1D72
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 06:03:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAE413C1C5E
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 06:03:14 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 56A131034041
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 06:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736398990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pPhztnp/uFXhOMiHqgodvgfOqZ6LrSWSjCzXJNS+oY0=;
 b=ASub+BF9uFloiUFNhzyvmrGv1D70Di/W5e2OlrAYn7mZ6YeWLxPAzn7UMC6k580hfdpqvL
 NIpydj6s5VG5J1ckX04lrN1wgO+EDayLCJf39Tgz5LtOHwghgLAw+4VEsIZLOUT8k9kO4Z
 zT8FAB1hoE8EmJxTdl2kdXfOggtQpnQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-hiEbSg-jOqCN7hJ-Hjw0zg-1; Thu, 09 Jan 2025 00:03:06 -0500
X-MC-Unique: hiEbSg-jOqCN7hJ-Hjw0zg-1
X-Mimecast-MFC-AGG-ID: hiEbSg-jOqCN7hJ-Hjw0zg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab2b300e5daso49206966b.1
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 21:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736398982; x=1737003782;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pPhztnp/uFXhOMiHqgodvgfOqZ6LrSWSjCzXJNS+oY0=;
 b=iTIA4QvWAbwyfRw980d9A4mjd5FVWo8Tqjfgz7ALcsGx90bThaTe/tu3RCNj7RuCjo
 mocvbJ1BnDe9YY3LufJclCIFaEKHpXNRl28UE1/Z5tdS+CDawA8fpGHklhuFRhqGlQJB
 2lDnUzI0/x9ePEGJ4WpITk30UsiizgxiOfiSiDdYrFf8GC946hox1DA8eJwBXMRaUXHc
 Q/BiwrFXHBNvIlH3L5o/SXe/hV+hLqcWqAQN+azfeVHpGMp4UhEHHbRh/sfBbj1WDtmv
 5ZhBgKJ7BtDqmF+YJNPlihlDc9c7ffpTiGg6gJjEdNALpHw9DSQF+8tc0xqV7BSl4XVV
 /+2w==
X-Gm-Message-State: AOJu0YwJGhy0KC9Ks7DXNTG0fw9PHb849Q2IZVIRaA7J9Fl9WcsRpmwS
 YfFGt60mQEHJlCRGm3VQdyVS1Olwl5I1tkkRBtgju9/4b15gNDokKSmVIi5k0q8VaxzpE9BdO1I
 t6RiPGya6G545WbtU0Gnl/F9onBKHZIwg8T9KMbXL71YQxjBKhHZY0R0N+hZba2m2ufRHxsmsvY
 ah1f65QZc1C0MEle2aKWE91+R+G8trhhnGMg==
X-Gm-Gg: ASbGncsEXD9V+uWndFzjpFV4V/wATQKFn7tCpPC/s89G1CuOYSWMNA9yzOjAXQ7Dx2g
 J6lHaD1j2kEFKOvl+GbGEne0SK2Sre0kTSCpDpzU=
X-Received: by 2002:a17:907:d1b:b0:aa6:7c8e:8085 with SMTP id
 a640c23a62f3a-ab2ab6fda3cmr598789766b.15.1736398982191; 
 Wed, 08 Jan 2025 21:03:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtj1PLmJNfKBIoFw66hA5hw1I/oQEnyS0aUxz1z53VXnFKSOKYr8uaA/KSbZBpOjngMuuXMehhP8pZuQ6oOCw=
X-Received: by 2002:a17:907:d1b:b0:aa6:7c8e:8085 with SMTP id
 a640c23a62f3a-ab2ab6fda3cmr598787866b.15.1736398981680; Wed, 08 Jan 2025
 21:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20250109045532.43017-1-liwang@redhat.com>
In-Reply-To: <20250109045532.43017-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 13:02:47 +0800
X-Gm-Features: AbW1kvYiyOJvkeDBsrAG_2MIt-z9_F6JefLxxaVHt4dZRQkCLrmyDUFxUVF80DE
Message-ID: <CAEemH2fjQsYBzfLbNa75j3mrL9AUkvC_3rxm-nSY==O6=57Log@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lRldYUSjLJ2AWzSesi-lie3U2QRDZufTlFu2KKasRP4_1736398985
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/3] Refine overall timeout and runtime
 management in LTP
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gOSwgMjAyNSBhdCAxMjo1NuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBhIHJlc3RydWN0dXJl
ZCBhcHByb2FjaCB0byBtYW5hZ2luZwo+IHRpbWVvdXRzIGFuZCBydW50aW1lIGxpbWl0cyBpbiB0
aGUgTFRQIGZyYW1ld29yay4gVGhlIGNoYW5nZXMgYWltIHRvCj4gc2ltcGxpZnkgdGltZW91dCBo
YW5kbGluZywgaW1wcm92ZSBjbGFyaXR5LCBhbmQgcHJvdmlkZSBiZXR0ZXIKPiBzZXBhcmF0aW9u
IGJldHdlZW4gdGhlIHBoYXNlcyBvZiBhIHRlc3QgKHNldHVwLCBleGVjdXRpb24sIGFuZCBjbGVh
bnVwKS4KPgo+IFRoZSBtYWluIHVwZGF0ZXMgaW5jbHVkZSByZWZpbmluZyB0aGUgZGVzY3JpcHRp
b24gYW5kIHVzYWdlIG9mIC50aW1lb3V0LAo+IGRlcHJlY2F0aW5nIFRTVF9VTkxJTUlURURfUlVO
VElNRSwgYW5kIGludHJvZHVjaW5nIHRoZSB0c3Rfc2V0X3RpbWVvdXQoKQo+IGZ1bmN0aW9uLiBB
ZGRpdGlvbmFsbHksIHRlc3QgY2FzZXMgdGhhdCBwcmV2aW91c2x5IHJlbGllZCBvbiAubWF4X3J1
bnRpbWUKPiBoYXZlIGJlZW4gdXBkYXRlZCB0byBhZG9wdCB0aGUgcmV2aXNlZCBsb2dpYywgZWl0
aGVyIGJ5IG1vdmluZyB0byAudGltZW91dAo+IGRpcmVjdGx5IG9yIHRyYW5zaXRpb25pbmcgdG8g
LnJ1bnRpbWUgZGVwZW5kaW5nIG9uIHRoZWlyIGJlaGF2aW9yLgo+Cj4gVGhlIHNlcmllcyBlbmRz
IHdpdGggYW4gdXBkYXRlIHRvIHRoZSBzZXRfbWVtcG9saWN5MDEgdGVzdCwgZGVtb25zdHJhdGlu
Zwo+IHRoZSB1c2Ugb2YgdHN0X3NldF90aW1lb3V0KCkgdG8gZGV0ZXJtaW5lIGFuIHVwcGVyIGJv
dW5kIGZvciBpdHMgZXhlY3V0aW9uLgo+Cj4gQ0kgam9iOiBodHRwczovL2dpdGh1Yi5jb20vd2Fu
Z2xpNTY2NS9sdHAvYWN0aW9ucy9ydW5zLzEyNjgzODI2OTA2Lwo+Cj4gTWFqb3IgY2hhbmdlcyBW
MSB0byBWMjoKPgo+ICAgKiBSZWZpbmVkIHRoZSBkZXNjcmlwdGlvbiBvZiAudGltZW91dCB1c2Fn
ZSBhbmQgaXRzIHJlbGF0aW9uc2hpcCB3aXRoCj4gLnJ1bnRpbWUuCj4KPiAgICogTW92ZWQgLm1h
eF9ydW50aW1lIHRvIC50aW1lb3V0IGRpcmVjdGx5IGZvciB0ZXN0cyB3aGVyZSBydW50aW1lIGlz
IG5vdAo+IGV4cGxpY2l0bHkgdXNlZC4KPgo+ICAgKiBUcmFuc2l0aW9uZWQgLm1heF9ydW50aW1l
IHRvIC5ydW50aW1lIGZvciB0ZXN0cyB0aGF0IGNhbGwKPiB0c3RfcmVtYWluaW5nX3J1bnRpbWUo
KQo+ICAgICBvciB1c2UgdGhlIGZ1enp5X3N5bmMgbGlicmFyeS4KPgo+ICAgKiBBZGRlZCB0aGUg
dHN0X3NldF90aW1lb3V0KCkgZnVuY3Rpb24gdG8gYWxsb3cgdGVzdCBjYXNlcyB0byBzZXQgdGhl
Cj4gb3ZlcmFsbAo+ICAgICB0aW1lb3V0IGR5bmFtaWNhbGx5LCBwYXJ0aWN1bGFybHkgdXNlZnVs
IGZvciB0ZXN0cyB0aGF0IGFpbSB0bwo+IGRldGVybWluZQo+ICAgICB1cHBlciBleGVjdXRpb24g
Ym91bmRzLgo+Cj4gICAqIFVwZGF0ZWQgc2V0X21lbXBvbGljeTAxIHRvIG1ha2UgdXNlIG9mIHRz
dF9zZXRfdGltZW91dCgpLgo+Cj4KPiBMaSBXYW5nICgzKToKPiAgIGxpYjogcmVkZWZpbmUgdGhl
IG92ZXJhbGwgdGltZW91dCBsb2dpYyBvZiB0ZXN0Cj4gICBsaWI6IGFkZCB0c3Rfc2V0X3RpbWVv
dXQgZm9yIHJlc2V0IGVudGlyZSB0aW1lb3V0Cj4gICBzZXRfbWVtcG9saWN5MDE6IG1ha2UgdXNl
IG9mIHRzdF9zZXRfdGltZW91dAo+CgpOb3RlOgpTZWVtcyBJIGZvcmdvdCB0byB1cGRhdGUgdGhl
IGNvdmVyLWxldHRlciB0aXRsZSBhbmQgYWRkIHRoZSA0LzQgcGF0Y2gsCmJ1dCB0aGF0IGlzIG5v
dCBhIGJpZyBkZWFsLCBpdCBhbHJlYWR5IGNvdmVycyB0aGUgbWFqb3IgY2hhbmdlcyB0aGVyZS4K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
