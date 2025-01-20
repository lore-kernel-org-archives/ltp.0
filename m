Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03673C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:18:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075E93C18AB
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 11:18:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03CCA3C016A
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:18:22 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 399F4102C3BF
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737368300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggXdB6D+dhPgopsrEZa0s1EapolcAuaJjYL2okd8enc=;
 b=LiVFHbvabXRE+zGFF1mgAtWYcyLWvd9AoZVJezEIeLq+k97vA1R9cvmTeoYa2QGuIWnkYH
 dIZe1exabQBJIptk77J13D5uIc4vIWoetilydMNcy0cO45iobXnK6dr66nu+eYPxpyqcXa
 vn/kXM5MDVvc2iqQ17KOR8VqdHmTi/o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-UOMxJISYPqm_kJBGEisIwg-1; Mon, 20 Jan 2025 05:18:16 -0500
X-MC-Unique: UOMxJISYPqm_kJBGEisIwg-1
X-Mimecast-MFC-AGG-ID: UOMxJISYPqm_kJBGEisIwg
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2166f9f52fbso135404495ad.2
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 02:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737368295; x=1737973095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggXdB6D+dhPgopsrEZa0s1EapolcAuaJjYL2okd8enc=;
 b=cis4YLgrllX2EtrrCfzSc9kCvoTE+KzXA0aRTXS8/AJXwL2bzais8AZOvOzy4W/h0q
 nl6/1Xxw/u26j180nCv2QJHOqc4rhyJBpHNLFCqd2vGDgN3+kHodhIR/f9tgBqDFrAvq
 GStMqM2ydD7QUeidIup/aLNKzvIyc4+RC94o7DX4siadKaI4Fd8trYpajC20oe2NBk46
 IPtoLjHdDgMal2Y5Yk6ENOxLGthCb29UTl+e4VUwIxDeL9FKlGA2HwWnlBLvp1k93xA5
 o1NkYLpNakV/xzRWA85ttWpnFoY003OI9/6bL5nO0ARVMF2/e3C+M0owoEIRaHQA4aiU
 rEBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8LvKx4mjI/Z6cMDYrBIY3Ym2XJ+VckFW6apqujJ9JzlMSSadhE6+OjnBmGVcLVs7G56Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yzu5FDW8/HlT9Ki1adTJ/npHE94/Eldw4oAs9639p8pm67x10jI
 b94cthoLvJUpQ9ohIrSdcKiKX6+s3W/q3DMWGqH+He3BuG0Xu3Mg6mJaksgZPe/SYcjwOVKmr3f
 MECj6Jocbq81m2fj+7ojD6cLe2OEWdK48IXPbXoaip7lrIiPXA8s3IOkOc3n3GkscM1G1W+2D06
 tq5/5ceyrkrfs1aF1L5I46xLQ=
X-Gm-Gg: ASbGnctSkieM2aLORkZlAm0u9JFjopNDGLEBCvjdoLu6up9hvDWreNrEBu7ZqusX9Xm
 zyXm6ehSSmz8EXWFAYnKP4mVKOib0gSjMGyF46JI6MhUq+yh/An4=
X-Received: by 2002:a17:902:f78f:b0:216:7cde:523 with SMTP id
 d9443c01a7336-21c35630682mr182818295ad.32.1737368295327; 
 Mon, 20 Jan 2025 02:18:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe+KlN/+AYjnBBrZsLakIwiIz9VlAyv6zof2+YYk+WqmoOwz+HSXZ4EUHYU9OHJrLCAg6QoRy3T4/frTjkyAE=
X-Received: by 2002:a17:902:f78f:b0:216:7cde:523 with SMTP id
 d9443c01a7336-21c35630682mr182817995ad.32.1737368294898; Mon, 20 Jan 2025
 02:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250120090740.GB794282@pevik> <20250120091137.GC794282@pevik>
In-Reply-To: <20250120091137.GC794282@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jan 2025 18:18:02 +0800
X-Gm-Features: AbW1kvajaFUX6DTZ-eP0xwx8L-er6svkVRZwshsh-5KDXV5hw-rHFJ2zkad7llY
Message-ID: <CAEemH2e03yTcWBDw=BK7O6SU69mVXhO4zv2LUDgPLe0kD=w12Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yQ0YiZg5q2TVuJdmA7sIx6Kb0JMCyXJ-hytlIB28G2E_1737368295
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [REGRESSION] pidns05 timeout (was: [PATCH 1/2] lib:
 multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKYW4gMjAsIDIwMjUgYXQgNToxMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiA+IE9uIFRodSwgSmFuIDE2LCAyMDI1IGF0IDY6NDLigK9BTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gPiBIaSBMaSwgQ3lyaWwsIGFs
bCwKPgo+ID4gPiA+IC4uLgo+ID4gPiA+ID4gKysrIGIvbGliL3RzdF90ZXN0LmMKPiA+ID4gPiA+
IEBAIC01NTUsOSArNTU1LDYgQEAgc3RhdGljIGludCBtdWx0aXBseV9ydW50aW1lKGludCBtYXhf
cnVudGltZSkKPgo+ID4gPiA+ID4gICAgICAgcGFyc2VfbXVsKCZydW50aW1lX211bCwgIkxUUF9S
VU5USU1FX01VTCIsIDAuMDA5OSwgMTAwKTsKPgo+ID4gPiA+ID4gLSAgICAgaWYgKHRzdF9oYXNf
c2xvd19rY29uZmlnKCkpCj4gPiA+ID4gPiAtICAgICAgICAgICAgIG1heF9ydW50aW1lICo9IDQ7
Cj4gPiA+ID4gPiAtCj4gPiA+ID4gPiAgICAgICByZXR1cm4gbWF4X3J1bnRpbWUgKiBydW50aW1l
X211bDsKPiA+ID4gPiA+ICB9Cj4KPiA+ID4gPiA+IEBAIC0xNzA2LDYgKzE3MDMsOSBAQCB1bnNp
Z25lZCBpbnQgdHN0X211bHRpcGx5X3RpbWVvdXQodW5zaWduZWQKPiBpbnQKPiA+ID4gPiB0aW1l
b3V0KQo+ID4gPiA+ID4gICAgICAgaWYgKHRpbWVvdXQgPCAxKQo+ID4gPiA+ID4gICAgICAgICAg
ICAgICB0c3RfYnJrKFRCUk9LLCAidGltZW91dCBtdXN0IHRvIGJlID49IDEhICglZCkiLAo+IHRp
bWVvdXQpOwo+Cj4gPiA+ID4gPiArICAgICBpZiAodHN0X2hhc19zbG93X2tjb25maWcoKSkKPiA+
ID4gPiA+ICsgICAgICAgICAgICAgdGltZW91dCAqPSA0Owo+Cj4gPiA+ID4gRllJIHRoaXMgY2hh
bmdlLCBtZXJnZWQgYXMgODkzY2EwYWJlNyAoImxpYjogbXVsdGlwbHkgdGhlIHRpbWVvdXQgaWYK
PiA+ID4gPiBkZXRlY3Qgc2xvdwo+ID4gPiA+IGtjb25maWdzIikgY2F1c2VkIGEgcmVncmVzc2lv
biBvbiAqYWxsKiB0ZXN0cyB3aGljaCB1c2UgdHN0X25ldC5zaC4KPiA+IC4uLgo+Cj4gPiBGWUkg
YWxzbyBhdCBsZWFzdCBwaWRuczA1LmMgc29tZXRpbWVzIGZhaWxzIGR1ZSB0aW1lb3V0IHdpdGgg
dGhpcyBjaGFuZ2UuCj4gPiBPbiBzb21lIG9mIFNMRVMgcHJvZHVjdCBwcmV2aW91c2x5IHBpZG5z
MDUuYyBydW4gZm9yIDMgc2VjLiBXaXRoIHRoaXMKPiBjaGFuZ2UgaXQKPiA+IHJ1bnMgMTJzIGFu
ZCB0aGVyZWZvcmUgdGltZW91dHMuCj4KPiBJJ20gc29ycnkgZm9yIGEgd3JvbmcgcmVwb3J0LiBM
b29raW5nIGFib3V0IGl0IHR3aWNlIHRoZXJlIGlzICIqKiogc3RhY2sKPiBzbWFzaGluZyBkZXRl
Y3RlZCAqKio6IHRlcm1pbmF0ZWQiID0+IHNvbWUgb3RoZXIgcHJvYmxlbSwgd2hpY2ggY2F1c2Vz
IHNsb3cKPiBkb3duLiBJTUhPIGl0J3Mgbm90IG9wdGltYWwgdG8gcnVuIHRoZSBkZXRlY3Rpb24g
bWFueSB0aW1lcyArIGJhc2ljYWxseSBub3cKPiByZXF1aXJpbmcga2VybmVsIGNvbmZpZyBmb3Ig
ZWFjaCBMVFAgdGVzdCwgYnV0IHBlcmZvcm1hbmNlIGltcGFjdCBpcwo+IHByb2JhYmx5Cj4gbG93
Lgo+CgpZZXMsIEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4uIEkgYWdyZWUgdGhhdCB3ZSBjYW4g
YXZvaWQgdGhlCmtjb25maWcgZGV0ZWN0aW9uIGZvciBtb3N0IGZhc3RlciB0ZXN0IGNhc2VzLgoK
QWZ0ZXIgcmV2aWV3aW5nIG15IHByZXZpb3VzIHByZS1yZWxlYXNlIExUUCB0ZXN0IGFuZCBjb21w
YXJlIHRvCnRoZSBjdXJyZW50IG1haW4gYnJhbmNoIHRlc3QsIGl0IGRvZXNuJ3Qgc2hvdyBtdWNo
IG1vcmUgdGltZS1jb25zdW1pbmcsCm1heWJlIHRoZXJlIGlzIGRpZmZlcmVudCBIVy9rZXJuZWwg
ZmFjdG9ycywgYnV0IHRoZSBwZXJmb3JtYW5jZQppbXBhY3QgY2FuIGJlIGlnbm9yZWQuCgoKCgo+
Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gSW4gcGlkbnMwNS5jIGNhc2UgY2hpbGQgaXMg
cnVuIDV4LiBGb3IgZWFjaCBvZiB0aGlzIGNoaWxkIHdlIGFnYWluCj4gZGV0ZWN0IGlmIHdlCj4g
PiBydW4gb24gc2xvdyBjb25maWcuIE1heWJlIHdlIHNob3VsZCBoYXZlIHVzZWQgc3RydWN0IHRz
dF90ZXN0IG1lbWJlciB0bwo+IGNhY2hlCj4gPiB0aGUgdmFsdWUuCj4KPiA+IFdoYXQgYm90aGVy
cyBtZSBtb3JlIHRoYXQgaG93IG11Y2ggdGltZSB3ZSB3YXN0ZSBmb3Igd2hvbGUgTFRQIHRlc3Rp
bmcKPiB3aXRoCj4gPiByZXBlYXRlZGx5IGRldGVjdGluZyBzbG93IGNvbmZpZyBmb3IgYWxsIHRl
c3RzIChydW50ZXN0L3N5c2NhbGxzIGhhcwo+IDE0NTcgaXRlbXMsCj4gPiB3ZSBydW4gaXQgbW9y
ZSB0aW1lcyBmb3IgZWFjaCBwcm9kdWN0IHdpdGggZGlmZmVyZW50IGtlcm5lbCBjbWRsaW5lCj4g
cGFyYW1ldGVycykuCj4gPiBJIGRvbid0IGtub3cgd2hhdCB3YXMgc3VwcG9zZWQgdG8gYmUgZml4
ZWQgYnkgdGhpcyBmZWF0dXJlLCBpcyBpdCByZWFsbHkKPiB3b3J0aAo+ID4gb2Ygc2xvd2Rvd24/
IFdoeSBub3QganVzdCBzZXQgTFRQX1JVTlRJTUVfTVVMPTIgb24gc2xvdyBrZXJuZWxzPyBXZQo+
IGNvdWxkIGhhdmUKPiA+IHRvb2wgd2hpY2ggd291bGQgJ2V4aXQgMScgb24gInNsb3ciIGtlcm5l
bCBhbmQgJ2V4aXQgMCcgb24gbm9ybWFsIGtlcm5lbAo+IHRvIGRvCj4gPiBhdXRvbWF0aWMgZGV0
ZWN0aW9uLCB3aGljaCBjb3VsZCBiZSBydW4gYnkgZnJhbWV3b3JrcyBqdXN0IG9uY2UuCj4KPiA+
IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
