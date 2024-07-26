Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED490C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 12:04:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7553C3D1C97
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 14:04:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD50F3CF2B6
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 14:04:02 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C6CBA20A6DA
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 14:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721995440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9kGIaCp/hj6GOo9apXTwDq8mX8gqmt7XdGGre83O4w=;
 b=DM08xtMgx2Az+V3Tk+a5fQQ5TVoLigYvPUeT7o17IWkHrzDAQSCDFZ32H811L04gKER8YN
 4HDDyMPoVRU9sqEd2KrbakvJaXjR/C36sbK4jNYsCdr2UPRoe7oOPlHLEzVrLFo97fMbCg
 jYD/WweSxOLiYX95xEETEDUM3RXGyuw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-cM4FLwFsNYSkAxQvnsHEpw-1; Fri, 26 Jul 2024 08:03:57 -0400
X-MC-Unique: cM4FLwFsNYSkAxQvnsHEpw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb4c2276b9so999098a91.0
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 05:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721995437; x=1722600237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9kGIaCp/hj6GOo9apXTwDq8mX8gqmt7XdGGre83O4w=;
 b=nZ8TzPvOk3k21rVDdji4VKCW9vqI6BsdEZhn6oxuNoaaKcRMvZYKuxMbTL7RKogZKV
 LEzC8xEGOz7b85kj9rK47i9eIgOBKShinUMdShtaKfSgR9rcFmOsyFnGrU3L6+wDbnts
 5pHqkoDS9C1oN24EW80dZd1xvbLAgpxUd1BsTujMHdJXdLZgWZN5kxFbeyQbCquibHLf
 O4LxG9IdoSJZXmHojEGvUrMKUFD96tV1PNf3e+en2lFfWb0z6YSDq6Mf5+lbMB10kxxe
 8535bfTTOc5d9c30YKTFQkoPRcCUpEvGCfnKy6yoaILNEWUvZGJDbytDkR1kynbZA0d4
 fhHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhHYl6AbWyEMis8VvQyZ+Egf1jE9iGYO2DJXuV35dk7kzRHJ37ixkVpyFN6cYYVuXnUqbAPjOwjGiaknqCCf0Kw6s=
X-Gm-Message-State: AOJu0YyD5Iu+JdGvILfWaxFYm2jw1xVxcRo6pyWrWOMgADI4O0pGMBgn
 708nsp1FVYfpOxmpkKW+KKQ3IEucN5QyIHdovAeRM7e4aGXeQeIHuuopCjYs2R14MVwfWpaDrr7
 YXUfgZpS41bbMt4b//VO8v0OHKvIwAn31A3cssSTXbMhmDeecqIPtPK7wF7w+Ynuspif2vVJSU4
 fDOQUY2tcnLOdF5Y4JQaPhb1g=
X-Received: by 2002:a17:90b:4a44:b0:2c9:e0be:d0ef with SMTP id
 98e67ed59e1d1-2cf237d887emr6719667a91.22.1721995436776; 
 Fri, 26 Jul 2024 05:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELQiIViNio6FBdqIRm4s8NK2FdGAZeOx5EHO2LTLa9HW2cK54uYLFwcZom7g92pkhhypAhBUOhCp+9uEYrMNw=
X-Received: by 2002:a17:90b:4a44:b0:2c9:e0be:d0ef with SMTP id
 98e67ed59e1d1-2cf237d887emr6719639a91.22.1721995436437; Fri, 26 Jul 2024
 05:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com> <ZqErzC4PMRrrk929@yuki>
 <CAEemH2eaTSuyD3GT5QGwq7wDUe0eX79+-XpfnzhQqN8ztJ2Vog@mail.gmail.com>
 <20240725125516.GA987417@pevik> <ZqJshM8YUQKwLR5s@yuki>
In-Reply-To: <ZqJshM8YUQKwLR5s@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Jul 2024 20:03:44 +0800
Message-ID: <CAEemH2dFGHkd5SAc0t_J3ZQ=NV+ADHpT=mDNybEHB_z5EALRSw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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

T24gVGh1LCBKdWwgMjUsIDIwMjQgYXQgMTE6MTfigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gPiBIb3dldmVyLCBpZiB3ZSB3YW50IExUUCBjb3Vs
ZCBiZSBidWlsdCB3aXRoIGFsbCB0aGUgbWlkZGxlIGdsaWJjCj4gdmVyc2lvbnMKPiA+ID4gKDIu
MjIgPCBnbGliYyA8IDIuMzYpCj4gPiA+IHRoaXMgbWlnaHQgYmUgdGhpbmtpbmcgb3Zlci4gQmVj
YXVzZSB3ZSBhbm5vdW5jZSBzdXBwb3J0IHRoZSBtaW5pbWFsCj4gPiA+IGdsaWJjLXZlcnNpb24g
aXMgMi4yMi4KPiA+Cj4gPiBIbSwgaXQgbWFrZXMgc2Vuc2UgdG8ga2VlcCBpdC4gQnV0IG5vYm9k
eSB3aWxsIHJlbWVtYmVyIG9uY2Ugd2UgcmFpc2UgdGhlCj4gPiBzdXBwb3J0Lgo+Cj4gTWF5YmUg
d2Ugc2hvdWxkIGF0IGxlYXN0IGFkZCBhIGNvbW1lbnQgZ2xpYmMtMi4yMiB3b3JrYXJvdW5kIG9y
Cj4gc29tZXRoaW5nIHRoYXQgY291bGQgYmUgZm91bmQgd2l0aCBncmVwLgo+CgpTb3VuZHMgZ29v
ZC4KCgo+ID4gQWxzbywgcmVtb3ZpbmcgSEFWRV9MSU5VWF9GU19IIFsxXSB3b3JrcyBpbiB0aGUg
Q0kgWzJdLCBpbmNsdWRpbmcKPiBkaXN0cm9zIHdpdGgKPiA+IGdsaWJjIDIuMzYgKG1pbmltYWwg
YnVpbGQgWzNdIG9yIGFsbCBjcm9zcy1jb21waWxlIGJ1aWxkcywgZS5nLiBbNF0pLgo+ID4KPiA+
IEkgd29uZGVyIGhvdyByZWFsaXN0aWMgaXMgdGhhdCBzb21lYm9keSBpcyBzdGlsbCBhZmZlY3Rl
ZCBieSB0aGlzIGlzc3VlLgo+Cj4gVGhhdCdzIGEgZ29vZCBxdWVzdGlvbiBidXQgSSdtIGFmcmFp
ZCB0aGUgb25seSB3YXkgdG8gZmluZCBvdXQgaXMgdG8KPiByZW1vdmUgdGhlIHdvcmthcm91bmQg
YW5kIHdhaXQgZm9yIHBlb3BsZSBjb21wbGFpbiB0aGF0IHRoZSBuZXh0IExUUAo+IHJlbGVhc2Ug
aXMgYnJva2VuLi4uCj4KCkkgcmVtZW1iZXIgdGhlIGJyb2tlbiB3YXMgZm91bmQgYnkgb3VyIENJ
IGF1dG9tYXRpb24gdGVzdHMKb24gRmVkb3JhLXJhd2hpZGUgYXQgdGhhdCBtb21lbnQuIFRoYXQg
aXMgYSB0ZW50YXRpdmUgdmVyc2lvbgphbmQgZml4ZWQgaW1pdGF0aXZlbHkgYnkgbXkgcGF0Y2gs
IHNvIHllcywgd2UgY2FuIHJlbW92ZSB0aGF0CnRvIHNlZSBpZiBpdCBpbXBhY3RzIG90aGVyIHVz
ZXJzLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
