Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA57C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:32:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8BE13CE23A
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:32:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1EAB3CB23F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:32:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8457760190A
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705915957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KG9ThUFiCLZoD/XZgvhTvyxMDAUynisEbg1iioYe6ys=;
 b=VI9CIsTom0QKrpAFGmvhttQUKr6NFlvD0d4b8Dp5/l2tOWHDZsVTFgWeZCm4O4er/tlLXL
 34UwY4qr1fk2/5CtRiLaKCN5o7CUSkqnmxfH7ydBoO7t2Nd68vcTc9UcU8UsHnypcWAzAQ
 PPzxeFIAVVIUlhWq0Ko2rGrTy7hFdY4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-dhhcZ6AKP2mZIX0fk5lSYQ-1; Mon, 22 Jan 2024 04:32:34 -0500
X-MC-Unique: dhhcZ6AKP2mZIX0fk5lSYQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6dde8cf78c4so4237836a34.1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705915953; x=1706520753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KG9ThUFiCLZoD/XZgvhTvyxMDAUynisEbg1iioYe6ys=;
 b=Sag7NvrOJU7S46EI+7jx9+NC4EnYEfxmuB++S1WzmjYgE2yqGP1SRv4Sdj0wGkSFTW
 gs4KOKGYI/MIL/HzRW89rTvSQDNzynbyZSAMNrwpslkHKNr5AJt1hFjTzFhh1/Tmt8M1
 I37ub4IfO1fnMGMEl9n1gFRYpQPEC3XP4u+Nd76SRM5jFSymvT6jwxLT8805ESdAROmi
 CVHju+LIz+FU+eG73GAle0SIuN1a54Mu02jzz9PQBlFHUzhKR8lJWnBFXe5u3k4JyLZp
 xAou96Iz2FWEcGzcVy9oZqnAdUaWixrvp4+seCl4x5aHNfHKrWBuLH9y+nVliUa1zKY7
 RG1w==
X-Gm-Message-State: AOJu0YwZ3ZjYKGiCLYnQJDZoyP7RHz/wgy0DtrcRbBwWiy9L71CmEI7u
 D/2CjVKu8Nr4AM9SKGUNuGWUYN5QHr49uD1yQLxPhOTr9WB+h7XdGjuw7wrcxc1ylR5mlI2h3e2
 8Ovup/76pOmwAsx4FYwtzqzA1hS7PQdgx8Zp+G6WXZvbkSkV8LIaxl9TQe/3v/qfOhT4cj3EaZZ
 G6toJr0y3Ptl7jhdvVy/phj+k=
X-Received: by 2002:a05:6359:458b:b0:176:5a5e:4b7c with SMTP id
 no11-20020a056359458b00b001765a5e4b7cmr845805rwb.6.1705915953371; 
 Mon, 22 Jan 2024 01:32:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0A5zgEg3nTgr0mh553Kxz8Ufh+qX5pPf/qlNzvFTzUtBm7VmLnfEwYGRLVXHiv9zFWe/tkoKwcB7S35KNJz0=
X-Received: by 2002:a05:6359:458b:b0:176:5a5e:4b7c with SMTP id
 no11-20020a056359458b00b001765a5e4b7cmr845797rwb.6.1705915952987; Mon, 22 Jan
 2024 01:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
In-Reply-To: <20240122091356.GF76754@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 17:32:21 +0800
Message-ID: <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

SGkgUGV0ciwKCk9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDU6MTTigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBUaGlzIGludHJvZHVjZSBhbiBl
bmhhbmNlbWVudCB0byB0aGUgbGlicmFyeSdzIGlzX3N3YXBfc3VwcG9ydGVkCj4gPiBmdW5jdGlv
biB0byBjaGVjayBmb3IgZmlsZXN5c3RlbSBjb21wYXRpYmlsaXR5IGJlZm9yZSBhdHRlbXB0aW5n
Cj4gPiB0byBjcmVhdGUgYW5kIGVuYWJsZSBhIHN3YXAgZmlsZS4gIEEgbGlzdCBvZiBzdXBwb3J0
ZWQgZmlsZXN5c3RlbXMKPiA+IGlzIGFkZGVkIChleHQyLCBleHQzLCBleHQ0LCB4ZnMsIHZmYXQs
IGV4ZmF0LCBudGZzKSwgYW5kIGEgY2hlY2sKPiA+IGFnYWluc3QgdGhpcyBsaXN0IGlzIHBlcmZv
cm1lZCB0byBlbnN1cmUgdGhhdCB0aGUgc3dhcCBvcGVyYXRpb25zCj4gPiBhcmUgb25seSBhdHRl
bXB0ZWQgb24ga25vd24gY29tcGF0aWJsZSBmaWxlc3lzdGVtcy4KPgo+ID4gSWYgdGhlIG1ha2Vf
c3dhcGZpbGUgZnVuY3Rpb24gZmFpbHMsIHRoZSBlcnJvciBoYW5kbGluZyBpcyBub3cKPiA+IG1v
cmUgZGVzY3JpcHRpdmU6IGl0IGRpc3Rpbmd1aXNoZXMgYmV0d2VlbiBmYWlsdXJlcyBkdWUgdG8g
dGhlCj4gPiBmaWxlc3lzdGVtIG5vdCBzdXBwb3J0aW5nIHN3YXAgZmlsZXMgYW5kIG90aGVyIHR5
cGVzIG9mIGZhaWx1cmVzLgo+ID4gU2ltaWxhcmx5LCB3aGVuIGF0dGVtcHRpbmcgdG8gZW5hYmxl
IHRoZSBzd2FwIGZpbGUgd2l0aCBzd2Fwb24sCj4gPiB0aGUgcGF0Y2ggZW5zdXJlcyB0aGF0IGNs
ZWFyZXIgZXJyb3IgbWVzc2FnZXMgYXJlIHByb3ZpZGVkIGluCj4gPiBjYXNlcyB3aGVyZSB0aGUg
b3BlcmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGZpbGVzeXN0ZW0uCj4KPiArMQo+Cj4g
UmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gZm9ybWF0dGluZyBp
c3N1ZXMgKHRhYnMpIGFyZSBhY3R1YWxseSBtb3N0bHkgZnJvbSB0aGlzIGNvbW1pdCwgcGxlYXNl
IGZpeAo+IHRoZW0KPiBiZWZvcmUgbWVyZ2UuCj4KClRoYW5rcyB2ZXJ5IG11Y2gsIFBldHIuCgpU
aGUgcGF0Y2hzZXQgVjIgKGJhc2VkIG9uIHlvdXIgc3VnZ2VzdGlvbnMpIGlzIHB1Ymxpc2hlZCBp
biBteSBnaXQgYnJhbmNoLgpJbiBjYXNlIHlvdSB3YW50IHRvIGRvIG1vcmUgdGVzdHMgdG9kYXku
CgpodHRwczovL2dpdGh1Yi5jb20vd2FuZ2xpNTY2NS9sdHAvdHJlZS9saWJzd2FwCgpBbmQsIEkg
cHJlZmVyIHRvIHdhaXQgZm9yIENyeWlsJ3MgZmVlZGJhY2sgYmVmb3JlIHBvc3RpbmcgdGhlbSBp
biBNTDopCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
