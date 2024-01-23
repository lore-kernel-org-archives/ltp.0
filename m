Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6E4C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:54:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71CDB3CE212
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 13:54:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F37A43C8919
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:54:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3F24200AD9
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706014466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n00n76Gf8wJ3B7O7pReAgOVgsHdFVozBvWVRmIxEkJo=;
 b=f5u3sM7WseAoeLND5hCWhDDq+CH5w7+OzImmxVR4PgKKX/RmTlcGtxUZj5uGb8szqkJdXm
 68RqP5G/LMbPamaOpstps11Lufz3pMqnmffYbIEYq5943pS4AWJeS0Pqv886LrqcnamWIr
 NRy87t19qBWEgz6epRAWXRLFqlz2Xvg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Hlz3tIeLNriNWLSCQ2TN8g-1; Tue, 23 Jan 2024 07:54:24 -0500
X-MC-Unique: Hlz3tIeLNriNWLSCQ2TN8g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28bd4766346so2421615a91.3
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 04:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706014462; x=1706619262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n00n76Gf8wJ3B7O7pReAgOVgsHdFVozBvWVRmIxEkJo=;
 b=UFQXF1DDkmvOQZ3X5umOt1ItRTcq/uKXJ3YSEmbV8oDq0HtG+8jvitSAy3JVlmJy7W
 3jQKAHabizQ6e3mnw9OSMDKNYESsi38ii8R368DopDaxZsEiu7ftznKZptf7mtHSwRJR
 m1a5MhU/9eR+0K0WUbiSHzinTISy1r5FVO0ZHo09YZ2ATWvU3+rrvhrziR2TYZbM7CuL
 Mz+zDHz9J+z6UyAZ1ybAanXsoyYNhEiMjuhPpvVFjnxrnh9T0MkUsucYbfy+ktmZFxcq
 7+HRkeLcPc3+ubXzIxFOQo37HESx3uiWm+B3c7Zy0XbuBtn8m12E39QqKzOpG49F/VAf
 ehvQ==
X-Gm-Message-State: AOJu0Ywfmyp7qqStJxXzF8pXN+5ZzjC7m7JKFBZiosjG24grr1vRm2II
 xTD/IvgJKr96R4/VU1FkBIb1Bm9OzT/P/TWa3O0yNx4RUXDa2tkbbbA/Sm46NXVQK3dYqLWSCSV
 mzpLwRTEUdIySbRFTm41yZSDz9PXmg3PeX7ej7SHVJmjOjsva1VjAO95UwOILljg81JP5jxDVSu
 zsZWC6GvaPdbqbx9I+OjjEBOJW10uD5EUQf65q
X-Received: by 2002:a17:90a:bf16:b0:290:f24:25a9 with SMTP id
 c22-20020a17090abf1600b002900f2425a9mr2303228pjs.82.1706014462064; 
 Tue, 23 Jan 2024 04:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5i9h3az8mCar1LAsUm4uudq7lOa9xTs1XfTv90ByWjiBzc5ExqYoHQidlO27rRfNPP9lPSdLXZtL6Ha9CDZE=
X-Received: by 2002:a17:90a:bf16:b0:290:f24:25a9 with SMTP id
 c22-20020a17090abf1600b002900f2425a9mr2303220pjs.82.1706014461656; Tue, 23
 Jan 2024 04:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
 <20240123121156.GA175806@pevik> <20240123123740.GC175806@pevik>
In-Reply-To: <20240123123740.GC175806@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2024 20:54:09 +0800
Message-ID: <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3 4/5] libswap: add function to prealloc
 contiguous file
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

SGkgUGV0ciwKCk9uIFR1ZSwgSmFuIDIzLCAyMDI0IGF0IDg6MzfigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBIaSBMaSwKPgo+ID4gc3dhcG9m
ZjAxIGZhaWxzIG9uIFRNUERJUiBvbiBidHJmcyAocmVnYXJkbGVzcyBrZXJuZWwgdmVyc2lvbik6
Cj4KPiBGWUkgaXQgd29ya3Mgb24gVHVtYmxld2VlZCB3aXRoIDYuNyBrZXJuZWwuIEl0J3MgYnJv
a2VuIG9uIHNvbWUgb2xkZXIgU0xFUwo+IHdpdGggNS4xNCBhbmQgYWxsIG9sZGVyIGtlcm5lbHMu
IEkgc3VwcG9zZSB3aXRoIG5vY293IChmaXhlcyBJIHN1Z2dlc3RlZAo+IHByZXZpb3VzbHkpIHdv
dWxkIHdvcmsgYXMgZXhwZWN0ZWQgKFRQQVNTLCBvciBUQ09ORiBvbiBrZXJuZWwgPCA1LjApLgo+
CgpZb3UncmUgcmlnaHQuCgpXZSBoYXZlIHRvIGd1YXJhbnRlZSB0aGUgc3dhcGZpbGUgaXMgYSBj
b250aWd1b3VzIGZpbGUgd2hhdGV2ZXIgdGhlIEZTIHR5cGUKaXMuClNvIGhlcmUgbWFraW5nIHVz
ZSBvZiBtYWtlX3N3YXBmaWxlKCkgaXMgYSBoYXJkIHJlcXVpcmVtZW50LgpBbmQsIEkgZG9uJ3Qg
dGhpbmsgdGhlIGZpbGUgZmlyc3Qgd2l0aCA2NTUzNiBibG9ja3MgKGluIHN3YXBvZmYwMSkgaXMg
bm90Cm5lY2Vzc2FyeS4KCgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+ICMgLi9zd2Fwb2Zm
MDEKPiA+IHJtIC1mIC1mIC1yIHN3YXBvZmYwMSBzd2Fwb2ZmMDIgICoubyAqLnB5YyAuY2FjaGUu
bWsgKi5kd28gLiouZHdvCj4gPiBCVUlMRCBsaWJsdHBzd2FwLmEKPiA+IG1ha2VbMV06IE5vdGhp
bmcgdG8gYmUgZG9uZSBmb3IgJ2FsbCcuCj4gPiBDQyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N3YXBvZmYvc3dhcG9mZjAxCj4gPiBDQyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBv
ZmYvc3dhcG9mZjAyCj4gPiB0c3RfdGVzdC5jOjE3MDk6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAy
MzA5MjktMjk1LWdjMjBhYjQ5OWEKPiA+IHRzdF90ZXN0LmM6MTU5NTogVElORk86IFRpbWVvdXQg
cGVyIHJ1biBpcyAwaCAwMG0gMzBzCj4gPiB0c3RfaW9jdGwuYzoyMTogVElORk86IEZJQk1BUCBp
b2N0bCBpcyBOT1Qgc3VwcG9ydGVkOiBFSU5WQUwgKDIyKQo+ID4gbGlic3dhcC5jOjMzOiBUSU5G
TzogRlNfTk9DT1dfRkwgYXR0cmlidXRlIHNldCBvbiAuL3RzdHN3YXAKPiA+IHN3YXBvZmYwMS5j
OjI0OiBURkFJTDogRmFpbGVkIHRvIHR1cm4gb24gdGhlIHN3YXAgZmlsZSwgc2tpcHBpbmcgdGVz
dAo+IGl0ZXJhdGlvbjogRUlOVkFMICgyMikKPgo+ID4gPT4gSSBndWVzcyB3ZSB3b3VsZCBuZWVk
IHRvIHJlcGxhY2UgdHN0X2ZpbGxfZmlsZSgpIHdpdGgKPiA+IHByZWFsbG9jX2NvbnRpZ3VvdXNf
ZmlsZSgpICh3aGljaCBpcyBub3QgcHVibGljKSwgb3IgdXNlIG1ha2Vfc3dhcGZpbGUoKQo+ID4g
ZGlyZWN0bHkuIEJ1dCBoZXJlIHdlIGNyZWF0ZSBmaWxlIGZpcnN0IHdpdGggNjU1MzYgYmxvY2tz
IGFuZAo+IG1ha2Vfc3dhcGZpbGUoKQo+ID4gY3JlYXRlcyAxMCBibG9jayBmaWxlICh3aXRoIHBy
ZWFsbG9jX2NvbnRpZ3VvdXNfZmlsZSgpIG9yIHByZXZpb3VzbHkKPiBhbHNvIHdpdGgKPiA+IHRz
dF9maWxsX2ZpbGUoKSkuCj4KPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKPgo+ID4gLS0tIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYwo+ID4gKysrIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYwo+ID4gQEAgLTQ0LDExICs0
NCw4IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAgICAgICAgICAgICAgdHN0X2Jy
ayhUQlJPSywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICJJbnN1ZmZpY2llbnQgZGlzayBz
cGFjZSB0byBjcmVhdGUgc3dhcCBmaWxlIik7Cj4KPiA+IC0gICAgICAgaWYgKHRzdF9maWxsX2Zp
bGUoInN3YXBmaWxlMDEiLCAweDAwLCAxMDI0LCA2NTUzNikpCj4gPiArICAgICAgIGlmIChtYWtl
X3N3YXBmaWxlKCJzd2FwZmlsZTAxIiwgMSkpCj4gPiAgICAgICAgICAgICAgICAgdHN0X2JyayhU
QlJPSywgIkZhaWxlZCB0byBjcmVhdGUgZmlsZSBmb3Igc3dhcCIpOwo+ID4gLQo+ID4gLSAgICAg
ICBpZiAoc3lzdGVtKCJta3N3YXAgc3dhcGZpbGUwMSA+IHRtcGZpbGUgMj4mMSIpICE9IDApCj4g
PiAtICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgIkZhaWxlZCB0byBtYWtlIHN3YXBmaWxl
Iik7Cj4gPiAgfQo+Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
