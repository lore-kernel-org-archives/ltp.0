Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E3D3569A
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769594139; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=68AdyA4Pz7Nb8ur0l/ZLqbAuE306sov3JekCAj+56U8=;
 b=EuIS35c08qLsW9ICMOCWebdF2ihpVKagNgADJ0sByUEVB6TesoLpyAFL/o4KscHLHWdmj
 LEIiTHlHvuIi0BOfb55Zc5iJvN+RE8DAegK/kAQrK24AF8LBvaFUCYmG2/Go+51Q/0l59vc
 Ys6fOxvUcjNROlqAMux608qSIuJ5v+g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E97153CAD15
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 10:55:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B0CD3C4C0F
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 10:55:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B9F1600077
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 10:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769594109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpa7/mdnOTSWD5oK5c6W8B4+3zXOoriqgvg77qYghi0=;
 b=cLTjAeQJuxd2RbBhJRSeNNfaCaIyXdlmmRV4H+jHlWmd+mVMsMAkpVreRldcKnFohnHZ10
 Dz//SHLSNuoo1c01xjYVCBk3U6Y3YSDQlwVHvRyt+sfG+SiiYa0oTMa1fCA3ZVfj0awMm+
 sCGbJUobNhd0K2GjGSPjDXtS40eU9bs=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-I3G2mzUvOByefEfQM_0ENg-1; Wed, 28 Jan 2026 04:55:08 -0500
X-MC-Unique: I3G2mzUvOByefEfQM_0ENg-1
X-Mimecast-MFC-AGG-ID: I3G2mzUvOByefEfQM_0ENg_1769594107
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b70d8095daso6521906eec.1
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769594106; x=1770198906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpa7/mdnOTSWD5oK5c6W8B4+3zXOoriqgvg77qYghi0=;
 b=jKLqPIsPBZnCmYFFO5mi8FN5bu1GIHFX8byb1ZrYuU9MW9d1wZ4N+sjnuQYUwVXbWq
 CWBzBFRBxqpntSDRHrAf++eTzbSY4SDFVMeKj6iXBY4NDyZbiNRAxk2Xg+JmaMdqUo2e
 rTXUF6l1o1tB4smAHNq3A7cFvrEoqki1VyF28QJbKnOtExw8AFGQSahM6t8eDMVMWhei
 8VymczR0JfNZWI0x5nqi/xxuWGeih8wircCbXf6sgoKuoRJPfnhCSehLSMklIMTFyjI5
 a6Y7N1/2GfzTmdIdO7vJweUoL0571SCK7lP4Uhe4vyMBuxl32ViW+OxcIlDn0GNm3Ap2
 eciw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyccxZuVfAAUHma7/TLWJwhp3dLpoQeFIvoMZasxH/Y6vsch7CoCnBvxjtHsgQy+w/r28=@lists.linux.it
X-Gm-Message-State: AOJu0YxX5k3X2fJh79DPO0r76qi2CjDqb03JVnstlVOkQHho5EWaSCjL
 pDw6lu31fcZBYZSNQYPVVuu5idy9Vm79uVtrxxZlYaC7i0FRLdKqeu7LiNRUSgDkPwdGPvU7yPF
 pNvAJMO+8DM3GLy9mZ/Kfql/M6zchLQHsQHQ7DWDZunvYh7w3qgO8bZ9CDp/xDxix1Nw4chu6gi
 bd4pQRvJq8NxN0RAbc5YRTGy5QOtEqeFApI8k=
X-Gm-Gg: AZuq6aJmW+oE3/S4FcFhDgCHIuY83kpP6EI+vjjP7HPHd9bl3+9zWiQAtaeT0p6hjyd
 iaBdHn1lDxqYf8CmCqsxbiuQ22waEDu5Nr8csPkx+az1XmlY2quiqZOI687E93BB1+vAko7mzOj
 rfXEopOnnRwRX1fCDS/Wh4KVN+ko/HOMhy5koPBT7+3QZp8Ysigvts8SomVTVEx4fwYiI=
X-Received: by 2002:a05:7300:fd0a:b0:2b7:33a6:b270 with SMTP id
 5a478bee46e88-2b78d951cb4mr2935863eec.19.1769594105991; 
 Wed, 28 Jan 2026 01:55:05 -0800 (PST)
X-Received: by 2002:a05:7300:fd0a:b0:2b7:33a6:b270 with SMTP id
 5a478bee46e88-2b78d951cb4mr2935824eec.19.1769594104057; Wed, 28 Jan 2026
 01:55:04 -0800 (PST)
MIME-Version: 1.0
References: <aWjZX0fsrTJMqq49@yuki.lan> <DG03V1ZOO5Z5.2R0ON903EMW93@suse.com>
In-Reply-To: <DG03V1ZOO5Z5.2R0ON903EMW93@suse.com>
Date: Wed, 28 Jan 2026 17:54:52 +0800
X-Gm-Features: AZwV_Qj6oBqtVmVY_UdBqbvVYabVs-H-IZVeno64Th3cItd4C6pO3nQLFjFI598
Message-ID: <CAEemH2dMzK82ZTzc+gpEb_LDNu8Z0DvVNQSjox7WsGe_3u3YCg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OEmuBItj5IvMmxsI7CmUqU4Pt9ad88Aexxzv6KSR4sw_1769594107
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preprations
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMjgsIDIwMjYgYXQgNToxM+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gSGkhCj4KPiBPbiBUaHUgSmFuIDE1LCAy
MDI2IGF0IDE6MTEgUE0gQ0VULCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gPiBIaSEKPiA+IEl0J3Mg
YWJvdXQgd2Ugc3RhcnQgdG8gcHJlcGFyZSBmb3IgdGhlIEphbnVhcnkgcmVsZWFzZS4gV2UgaGF2
ZSByb3VnaGx5Cj4gPiBhIHdlZWsgZm9yIGdldHRpbmcgaW4gYWxsIHBhdGNoZXMgdGhhdCBzaG91
bGQgZ28gaW4uIFNvIGlmIHRoZXJlIGlzCj4gPiBhbnl0aGluZyB0aGF0IHNob3VsZCBiZSByZXZp
ZXdlZCBwbGVhc2UgcG9pbnQgaXQgb3V0IEFTQVAuCj4gPgo+ID4gQXMgZm9yIG1lIEknbSBnb2lu
ZyB0byAoaG9wZWZ1bGx5KSBmaW5hbGl6ZSB0aGUgZ3JvdW5kIHJ1bGVzIHBhdGNoIGFuZAo+ID4g
c2VuZCBhbm90aGVyIHZlcnNpb24gdG9kYXkuCj4KPiBUaGVyZSdzIG9uZSBtb3JlIHRoaW5nIHRv
IGRvIGFuZCBpdCdzIHRvIHB1c2ggYSBuZXcgdmVyc2lvbiBvZiBraXJrIGEKPiBtaW5vciBmaXgu
IExUUCBzaG91bGQgdXBkYXRlIGl0IGFjY29yZGluZ2x5Lgo+CgorMQoKCj4gSSBkaWRuJ3Qgc2Vl
IGFueSBpc3N1ZSB3aXRoIGtpcmsgc28gZmFyLCBzbyB3ZSBzaG91bGQgZG8gdGhpcyBub3cgYmVm
b3JlCj4gdGhlIHJlbGVhc2UsIFdEWVQ/Cj4KClllcywgYmV0dGVyIHRvIGhhdmUgdGhhdCB2My4y
LjEgdmVyc2lvbiB0b2dldGhlciwgdGhhbmtzIQoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
