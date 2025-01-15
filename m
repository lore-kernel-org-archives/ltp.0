Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB3C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922743C7AD8
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:50:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 539E53C1FE9
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:49:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3CCEF656153
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736945390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/cTmycSCp3R57BreZeS4TpXrp78ZSfRgBjx+EwPcRw=;
 b=Cq5bgiFHpm16NMqOB3K7wVoKgUYyMq44FcpPuYwntXkxF71Hdb1/ooU+Zapgw/7jM+Zod3
 k6Xx1qe12gSX5MB69p0qe7K8PBkT021tBJIFNlKsHX23D1OZ5qY/S5ZZegsZ9HQfDDINP6
 T+kZb28eeuEVphU/Nc/5Lm2d1zgZwoY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-ZQyMXEhwN5m_ex5xP2aMNg-1; Wed, 15 Jan 2025 07:49:47 -0500
X-MC-Unique: ZQyMXEhwN5m_ex5xP2aMNg-1
X-Mimecast-MFC-AGG-ID: ZQyMXEhwN5m_ex5xP2aMNg
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee9f66cb12so12002174a91.1
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 04:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736945386; x=1737550186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z/cTmycSCp3R57BreZeS4TpXrp78ZSfRgBjx+EwPcRw=;
 b=YHFacQntqSqbDYxD8GbKqJ9tcYN2dFktgJ7bykVHx0o/z/aeKHI5aJlGlJECh1xntP
 rYB+rUYXYsmxz1zIeCfO6FMHFt0QeSgYA0etTZP3pRUOT87W5DoGFEb1ZhEjgloAVbQk
 im7nkJhAf3mbn6AUzayysfX2JDqRKPphcvybU8+mUReyN+Oby7R7qdlTkosOokyz4ghJ
 YlsY3ed8jk+AFUu4444KQcJJGEQhI/HU9lLNFuNrnHYMzQgpxHJ1Yu/XOg/fbTKc/Nkd
 vYpGP++4a33vEReLW73WhUHQe8KKY8VzB4piMGs4xO7cFFWeQWCrFKeJ+rWZqWhdzXvx
 /8lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4iL5NJmK+BQIkTcR70I0J9+1clk7VixWKa5xVy4SiRz3oZtnGk8bKCGrbPnNmlyoUOEc=@lists.linux.it
X-Gm-Message-State: AOJu0YzZ9n7k9lWEfCGF3uKj+27uk7ENTnx0DIEa6f2JEHaM859NsMtx
 u96FxP7z1xHFcw7wY7sJkfEdPZgykl+8aCRpcCvasHfy2Oa4WdD6gbG7aGfu7m6wUmqC/i2aYm+
 F8Vmf5Qkuf7UwF6Iv7TKmNiHspWgaV8Z2wCPK0/wghTDJTLXUNGCEgW76qsc7HRA/UpMx3+vAyj
 XHKgsB2co1xSZopfn6hxc5KFTBS3ldg4vcdg==
X-Gm-Gg: ASbGncvBuNWPZgY+Pof31/2NQoneF7xt1pOoSdH5tAPfV/722UtFztepL53Jiik+1U7
 NUcJURcUtFuANmKxPpYciS4sUzHAO99Ozy9Iq3OA=
X-Received: by 2002:a17:90b:54cb:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2f548ec9267mr46408989a91.17.1736945386213; 
 Wed, 15 Jan 2025 04:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUVIOHAYqGLiOzw2Mndx7Nn6lJWXvypU1/Sa+pmW2YdD6sX/6Lq90oGVt7duxkLmswr1iNsXhREuUUg/2udWc=
X-Received: by 2002:a17:90b:54cb:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2f548ec9267mr46408950a91.17.1736945385910; Wed, 15 Jan 2025
 04:49:45 -0800 (PST)
MIME-Version: 1.0
References: <5a87594f-9066-4ee1-8bc7-5f9f2d71829a.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSmAjFQTbt98AZj-CRFSWT-dMc-3dAd5mQ=S6rDEYq+Sw@mail.gmail.com>
 <CAEemH2eMPDjSf0ShgsQc-4=Pg5M_9z6HnUMJRDM8OONkydDndg@mail.gmail.com>
 <20250115121744.GA648257@pevik>
In-Reply-To: <20250115121744.GA648257@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Jan 2025 20:49:34 +0800
X-Gm-Features: AbW1kvZgB7dgvLL_Cn9NBc98uMmgGZbaoC8oPK2JduSsRZN0fc8egHqeKAfJRXM
Message-ID: <CAEemH2djpaSi4sTngsRhFpro3J2_vmhe84dW2vy9K_wS=eioeA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AWXMfmeSbHJHt1A71j_DW066UAYyDCago9PrUQfGr9g_1736945387
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMTUsIDIwMjUgYXQgODoxN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEppbiBHdW9qaWUgYWxsLAo+Cj4gPiBPbiBXZWQsIEphbiAx
NSwgMjAyNSBhdCAyOjMz4oCvUE0gSmluIEd1b2ppZSA8Z3VvamllLmppbkBnbWFpbC5jb20+IHdy
b3RlOgo+Cj4gSmluIEd1b2ppZSwgdGhhbmtzIGZvciBoYW5kbGluZyB0aGlzIQo+Cj4gPiA+IFYz
Ogo+ID4gPiAqIEZpeCBpbml0aWFsaXphdGlvbiBvZiByb290LT5tZW1vcnlfcmVjdXJzaXZlcHJv
dAo+ID4gPiAqIFRoZSB1c2Ugb2YgdHN0X2NnX21lbW9yeV9yZWN1cnNpdmVwcm90KGxlYWZfY2db
Rl0pIGlzIGNoYW5nZWQgdG8gc2FmZQo+ID4gPiBjaGVjawo+ID4gPiAqIFRoZSB0eXBlIG9mIG1l
bW9yeV9yZWN1cnNpdmVwcm90IGlzIGNoYW5nZWQgdG8gdW5zaWduZWQgaW50Cj4gPiA+ICogUmVi
YXNlIHRoZSBjb2RlIHRvIHRoZSBsYXRlc3QgYnJhbmNoCj4gbml0OiBpZiB5b3UgYWRkIG5vdGVz
IGxpa2UgdmVyc2lvbiBjaGFuZ2Vsb2cgKG9yIG90aGVyIG5vdGVzIHdoaWNoIHNob3VsZAo+IG5v
dCBiZQo+IHBhcnQgb2YgdGhlIGZpbmFsIGNvbW1pdCBtZXNzYWdlKSBiZWxvdyAtLS0gKGFib3Zl
IG9mIHRoZSBsaXN0IG9mIGNoYW5nZWQKPiBmaWxlcykgd2Ugd2lsbCBzZWUgdGhlbSBpbiBNTCwg
YnV0IGl0IHdpbGwgbm90IGJlIGluIGdpdCBjb21taXQgbWVzc2FnZS4KPgo+ID4gVGhhbmtzIGZv
ciByZWZpbmluZyB0aGlzLCBjb2RlIGxvb2tzIGdvb2QgdG8gbWUsIGJ1dCBhcyBJIHBvaW50ZWQg
b3V0Cj4gPiBjYW4geW91IHJlYmFzZSB0aGUgcGF0Y2ggb24gdGhlIGxhdGVzdCBicmFuY2g/IE90
aGVyd2lzZSwgbWFpbnRhaW5lcgo+ID4gZ2V0cyBhIGNvbmZsaWN0IHdoZW4gYXBwbHlpbmcgeW91
ciBwYXRjaC4KPgo+ID4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+
Cj4gQWNrZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gSSBhbHNvIHVwZGF0
ZWQgcGF0Y2h3b3JrIHN0YXRlcyBmb3IgYWxsIHZlcnNpb25zIG9mIHRoaXMuCj4KPiA+IEBDeXJp
bCwgQFBldHIsIEkgdm90ZSB0byBtZXJnZSB0aGlzIG9uZSBiZWZvcmUgdGhlIHJlbGVhc2UsIGFu
ZCBJIGFsc28KPiB0aGluawo+Cj4gKzEKPgo+ID4gd2UgbmVlZCBhbiBhZGRpdGlvbmFsIHRpbnkg
Zml4IGxpa2UgYmVsb3c6Cj4KPiArMSwgTGksIGNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhIHJlZ3Vs
YXIgcGF0Y2ggZm9yIGl0Pwo+CgpZZXMsIEkgd2lsbCBzZW5kIGl0IG9uY2UgR3VvamllIGdpdmVz
IHBhdGNoIHY0LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
