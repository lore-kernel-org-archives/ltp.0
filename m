Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8108DC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 08:31:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E84A63CFF84
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 10:31:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42CD53CC544
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 10:31:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3548C1A01476
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 10:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714120271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3etFJymGEh7Fnke1JiLsnwMpxPPMcrpIxIvg2gYiNA=;
 b=gcbf0Te1lBocFY87IPcDKxh3T9MS3XM7WbYCiyPrjq3CxAhm/8f4WAne7k+kL0XvkQC3yN
 L/HiE7woDVqRU0NpLVEveNsPQ/GeAPjp7oxqVas27ZVu3s1zNcRVrJ3RgZ9LOQiaY0uaNw
 3QJ9BecY/omPyHN9+dUd/NEo2viR0LM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-XwVRZjH_Oy-nth94KKDsWw-1; Fri, 26 Apr 2024 04:31:07 -0400
X-MC-Unique: XwVRZjH_Oy-nth94KKDsWw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a2e0a51adfso2399914a91.0
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 01:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714120266; x=1714725066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3etFJymGEh7Fnke1JiLsnwMpxPPMcrpIxIvg2gYiNA=;
 b=p2du4O+FsXDyaNVIvC38XdvLEmspzfejHgi1SJo/e7teUvLoctdzCH8/uRenzwDf23
 oB66EUJ/HBBTBXoe6Vdy0gA/CC4Zy7VsVnvnAKV9rmN6R3Vtn2fI7LC2gG+0vYGWGzko
 Ox4Yr3BMV2iF1aAHJkofasOnNm/BL4+ZnlGfrYKkateem8cnEXbdmbnTtZw+9dbW1W5D
 8lkR3UnO+nFyh/qt17WoXn1cGOxVoyKNTD2JHu7QWKYYFf0+F62P4Ol3mULF6ze3sloY
 /wNs38rNosdnh4ZVL5Md95v4Zm43Nos2QHQdXuCD+AvcmQkQTUx0qwfZ9uy2jM7/hHsS
 tspQ==
X-Gm-Message-State: AOJu0Yw/IQSLPDEGdAplgVkpuHgjBAzJL6kJ3837WYzJD+VgB+T43i6a
 VDFa5slzsTfE/jxIfbAF6QdZ229pEuLlpDTMankSAya9PqtdErxTmg6muLZIsnI2RJ5Y+A38Z/c
 I1QqhQ3qRqxacyyaDPAN2hwezmwB8HYcAZK7KlJlke0gWTC/oVfMdp+bPE8rKUSsYWtunUcXUPg
 USGAqBrmH9dO38JVdB7/Jr9PQ=
X-Received: by 2002:a17:90a:654c:b0:2a2:97ce:24f5 with SMTP id
 f12-20020a17090a654c00b002a297ce24f5mr2039557pjs.35.1714120266297; 
 Fri, 26 Apr 2024 01:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgs4PI4rmtPey90IQMzoPu5clFY4CWiXMrAj/veXHF5fix5tQTfGvTgkVz4c/oUndFSKkAaPzdb3irPJRCzB8=
X-Received: by 2002:a17:90a:654c:b0:2a2:97ce:24f5 with SMTP id
 f12-20020a17090a654c00b002a297ce24f5mr2039537pjs.35.1714120265892; Fri, 26
 Apr 2024 01:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240426042851.333269-1-pvorel@suse.cz>
 <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
In-Reply-To: <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Apr 2024 16:30:53 +0800
Message-ID: <CAEemH2dzzZp5kMF5cQPQQ=Z-Eb55JkEtqvh2E8UOt6UOE7gr7w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] doc: libltpswap: Add kerneldoc
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgMzo0NOKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gSGkhCj4KPiBPbiA0LzI2LzI0IDA2OjI4
LCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4gPiAtLS0KPiA+ICAgZG9jL2RldmVsb3BlcnMvYXBpX2NfdGVzdHMucnN0IHwg
IDQgKysrCj4gPiAgIGluY2x1ZGUvbGlic3dhcC5oICAgICAgICAgICAgICB8IDYxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZG9jL2RldmVs
b3BlcnMvYXBpX2NfdGVzdHMucnN0Cj4gYi9kb2MvZGV2ZWxvcGVycy9hcGlfY190ZXN0cy5yc3QK
PiA+IGluZGV4IDJjMGM4NDE5ZC4uZWM1M2FiMzNjIDEwMDY0NAo+ID4gLS0tIGEvZG9jL2RldmVs
b3BlcnMvYXBpX2NfdGVzdHMucnN0Cj4gPiArKysgYi9kb2MvZGV2ZWxvcGVycy9hcGlfY190ZXN0
cy5yc3QKPiA+IEBAIC0zMSwzICszMSw3IEBAIENhcGFiaWxpdGllcwo+ID4gICAtLS0tLS0tLS0t
LS0KPiA+Cj4gPiAgIC4uIGtlcm5lbC1kb2M6OiAuLi8uLi9pbmNsdWRlL3RzdF9jYXBhYmlsaXR5
LmgKPiA+ICsKPiA+ICtsaWJsdHBzd2FwCj4gPiArLS0tLS0tLS0tLQo+ID4gKy4uIGtlcm5lbC1k
b2M6OiAuLi8uLi9pbmNsdWRlL2xpYnN3YXAuaAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGli
c3dhcC5oIGIvaW5jbHVkZS9saWJzd2FwLmgKPiA+IGluZGV4IGY3NTcwNzNjYy4uNjgxODQ5MTY2
IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saWJzd2FwLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGli
c3dhcC5oCj4gPiBAQCAtMSwxMSArMSwxMiBAQAo+ID4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ID4gICAvKgo+ID4gICAgKiBDb3B5cmlnaHQgKGMpIDIw
MTMgT3JhY2xlIGFuZC9vciBpdHMgYWZmaWxpYXRlcy4gQWxsIFJpZ2h0cwo+IFJlc2VydmVkLgo+
ID4gKyAqIENvcHlyaWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0LCAyMDIxLTIwMjQKPiA+ICAg
ICogQXV0aG9yOiBTdGFuaXNsYXYgS2hvbG1hbnNraWtoIDxzdGFuaXNsYXYua2hvbG1hbnNraWto
QG9yYWNsZS5jb20+Cj4gPiAgICAqLwo+ID4KPiA+ICAgLyoKPiA+IC0gKiBDb250YWlucyBjb21t
b24gY29udGVudCBmb3IgYWxsIHN3YXBvbi9zd2Fwb2ZmIHRlc3RzCj4gPiArICogQ29udGFpbnMg
Y29tbW9uIGNvbnRlbnQgZm9yIGFsbCBzd2Fwb24vc3dhcG9mZiB0ZXN0cy4KPiA+ICAgICovCj4g
Pgo+ID4gICAjaWZuZGVmIF9fTElCU1dBUF9IX18KPiA+IEBAIC0yNyw2MCArMjgsOTYgQEAgaW50
IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiA+ICAg
I2RlZmluZSBNSU5JTUFMX1NXQVBfU0laRV9NQiAxCj4gPgo+ID4gICAvKioKPiA+IC0gKiBNYWNy
byB0byBjcmVhdGUgbWluaW1hbCBzd2FwZmlsZS4KPiA+ICsgKiBNQUtFX1NNQUxMX1NXQVBGSUxF
IC0gY3JlYXRlIHNtYWxsIHN3YXAgZmlsZS4KPiA+ICsgKgo+ID4gKyAqIE1hY3JvIHRvIGNyZWF0
ZSBzbWFsbCBzbWFsbCBzd2FwIGZpbGUuIFNpemUgZGVmaW5lZCB3aXRoCj4gTUlOSU1BTF9TV0FQ
X1NJWkVfTUIuCj4gInNtYWxsIHNtYWxsIiBzb3VuZHMgd2VpcmQuIE1heWJlICJyZWFsbHkgc21h
bGwiCj4KCisxIEkgZ3Vlc3MgdGhhdCBtaWdodCBiZSBvbmUgdHlwby4KCk90aGVyd2lzZSBsb29r
cyBnb29kIHRvIG1lLCB0aGFua3MhCgoKCj4gPiArICoKPiA+ICsgKiBAc3dhcGZpbGU6IHN3YXAg
ZmlsZW5hbWUuCj4gPiAgICAqLwo+ID4gICAjZGVmaW5lIE1BS0VfU01BTExfU1dBUEZJTEUoc3dh
cGZpbGUpIFwKPiA+ICAgICAgIG1ha2Vfc3dhcGZpbGUoX19GSUxFX18sIF9fTElORV9fLCBzd2Fw
ZmlsZSwgTUlOSU1BTF9TV0FQX1NJWkVfTUIsCj4gMCwgXAo+ID4gICAgICAgICAgICAgICAgIFNX
QVBGSUxFX0JZX1NJWkUpCj4gPgo+ID4gICAvKioKPiA+IC0gKiBNYWNybyB0byBjcmVhdGUgbWlu
aW1hbCBzd2FwZmlsZS4KPiA+ICsgKiBTQUZFX01BS0VfU01BTExfU1dBUEZJTEUgLSBjcmVhdGUg
c21hbGwgc3dhcCBmaWxlIChzYWZlIHZlcnNpb24pLgo+ID4gKyAqCj4gPiArICogTWFjcm8gdG8g
Y3JlYXRlIHNtYWxsIHNtYWxsIHN3YXAgZmlsZS4gU2l6ZSBkZWZpbmVkIHdpdGgKPiBNSU5JTUFM
X1NXQVBfU0laRV9NQi4KPiA+ICAgICogSW5jbHVkZXMgc2FmZXR5IGNoZWNrcyB0byBoYW5kbGUg
cG90ZW50aWFsIGVycm9ycy4KPiBTYW1lIGhlcmUKPiA+ICsgKgo+ID4gKyAqIEBzd2FwZmlsZTog
c3dhcCBmaWxlbmFtZS4KPiA+ICAgICovCj4gPiAgICNkZWZpbmUgU0FGRV9NQUtFX1NNQUxMX1NX
QVBGSUxFKHN3YXBmaWxlKSBcCj4gPiAgICAgICBtYWtlX3N3YXBmaWxlKF9fRklMRV9fLCBfX0xJ
TkVfXywgc3dhcGZpbGUsIE1JTklNQUxfU1dBUF9TSVpFX01CLAo+IDEsIFwKPiA+ICAgICAgICAg
ICAgICAgICBTV0FQRklMRV9CWV9TSVpFKQo+ID4KPiA+ICAgLyoqCj4gPiAtICogTWFjcm8gdG8g
Y3JlYXRlIHN3YXBmaWxlIHNpemUgaW4gbWVnYWJ5dGVzIChNQikuCj4gPiArICogTUFLRV9TV0FQ
RklMRV9TSVpFIC0gY3JlYXRlIHN3YXAgZmlsZSAoTUIpLgo+ID4gKyAqCj4gPiArICogTWFjcm8g
dG8gY3JlYXRlIHN3YXAgZmlsZSwgc2l6ZSBzcGVjaWZpZWQgaW4gbWVnYWJ5dGVzIChNQikuCj4g
PiArICoKPiA+ICsgKiBAc3dhcGZpbGU6IHN3YXAgZmlsZW5hbWUuCj4gPiArICogQHNpemU6IHN3
YXAgc2l6ZSBpbiBNQi4KPiA+ICAgICovCj4gPiAgICNkZWZpbmUgTUFLRV9TV0FQRklMRV9TSVpF
KHN3YXBmaWxlLCBzaXplKSBcCj4gPiAgICAgICBtYWtlX3N3YXBmaWxlKF9fRklMRV9fLCBfX0xJ
TkVfXywgc3dhcGZpbGUsIHNpemUsIDAsCj4gU1dBUEZJTEVfQllfU0laRSkKPiA+Cj4gPiAgIC8q
Kgo+ID4gLSAqIE1hY3JvIHRvIGNyZWF0ZSBzd2FwZmlsZSBzaXplIGluIGJsb2NrIG51bWJlcnMu
Cj4gPiArICogTUFLRV9TV0FQRklMRV9CTEtTIC0gY3JlYXRlIHN3YXAgZmlsZSAoYmxvY2tzKS4K
PiA+ICsgKgo+ID4gKyAqIE1hY3JvIHRvIGNyZWF0ZSBzd2FwIGZpbGUsIHNpemUgc3BlY2lmaWVk
IGluIGJsb2NrIG51bWJlcnMuCj4gPiArICoKPiA+ICsgKiBAc3dhcGZpbGU6IHN3YXAgZmlsZW5h
bWUuCj4gPiArICogQGJsb2NrczogbnVtYmVyIG9mIGJsb2Nrcy4KPiA+ICAgICovCj4gPiAgICNk
ZWZpbmUgTUFLRV9TV0FQRklMRV9CTEtTKHN3YXBmaWxlLCBibG9ja3MpIFwKPiA+ICAgICAgIG1h
a2Vfc3dhcGZpbGUoX19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwgYmxvY2tzLCAwLAo+IFNX
QVBGSUxFX0JZX0JMS1MpCj4gPgo+ID4gICAvKioKPiA+IC0gKiBNYWNybyB0byBzYWZlbHkgY3Jl
YXRlIHN3YXBmaWxlIHNpemUgaW4gbWVnYWJ5dGVzIChNQikuCj4gPiArICogU0FGRV9NQUtFX1NX
QVBGSUxFX1NJWkUgLSBjcmVhdGUgc3dhcCBmaWxlIChNQiwgc2FmZSB2ZXJzaW9uKS4KPiA+ICsg
Kgo+ID4gKyAqIE1hY3JvIHRvIHNhZmVseSBjcmVhdGUgc3dhcCBmaWxlLCBzaXplIHNwZWNpZmll
ZCBpbiBtZWdhYnl0ZXMgKE1CKS4KPiA+ICAgICogSW5jbHVkZXMgc2FmZXR5IGNoZWNrcyB0byBo
YW5kbGUgcG90ZW50aWFsIGVycm9ycy4KPiA+ICsgKgo+ID4gKyAqIEBzd2FwZmlsZTogc3dhcCBm
aWxlIG5hbWUuCj4gPiArICogQHNpemU6IHN3YXAgc2l6ZSBpbiBNQi4KPiA+ICAgICovCj4gPiAg
ICNkZWZpbmUgU0FGRV9NQUtFX1NXQVBGSUxFX1NJWkUoc3dhcGZpbGUsIHNpemUpIFwKPiA+ICAg
ICAgIG1ha2Vfc3dhcGZpbGUoX19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwgc2l6ZSwgMSwK
PiBTV0FQRklMRV9CWV9TSVpFKQo+ID4KPiA+ICAgLyoqCj4gPiAtICogTWFjcm8gdG8gc2FmZWx5
IGNyZWF0ZSBzd2FwZmlsZSBzaXplIGluIGJsb2NrIG51bWJlcnMuCj4gPiArICogU0FGRV9NQUtF
X1NXQVBGSUxFX0JMS1MgLSBjcmVhdGUgc3dhcCBmaWxlIChibG9jaywgc2FmZSB2ZXJzaW9uKQo+
ID4gKyAqCj4gPiArICogTWFjcm8gdG8gc2FmZWx5IGNyZWF0ZSBzd2FwIGZpbGUsIHNpemUgc3Bl
Y2lmaWVkIGluIGJsb2NrIG51bWJlcnMuCj4gPiAgICAqIEluY2x1ZGVzIHNhZmV0eSBjaGVja3Mg
dG8gaGFuZGxlIHBvdGVudGlhbCBlcnJvcnMuCj4gPiArICoKPiA+ICsgKiBAc3dhcGZpbGU6IHN3
YXAgZmlsZSBuYW1lLgo+ID4gKyAqIEBibG9ja3M6IG51bWJlciBvZiBibG9ja3MuCj4gPiAgICAq
Lwo+ID4gICAjZGVmaW5lIFNBRkVfTUFLRV9TV0FQRklMRV9CTEtTKHN3YXBmaWxlLCBibG9ja3Mp
IFwKPiA+ICAgICAgIG1ha2Vfc3dhcGZpbGUoX19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwg
YmxvY2tzLCAxLAo+IFNXQVBGSUxFX0JZX0JMS1MpCj4gPgo+ID4gLS8qCj4gPiArLyoqCj4gPiAr
ICogaXNfc3dhcF9zdXBwb3J0ZWQoKSAtIENoZWNrIHN3YXBvbi9zd2Fwb2ZmIHN1cHBvcnQuCj4g
PiArICoKPiA+ICAgICogQ2hlY2sgc3dhcG9uL3N3YXBvZmYgc3VwcG9ydCBzdGF0dXMgb2YgZmls
ZXN5c3RlbXMgb3IgZmlsZXMKPiA+ICAgICogd2UgYXJlIHRlc3Rpbmcgb24uCj4gPiArICoKPiA+
ICsgKiBAZmlsZW5hbWU6IHN3YXAgZmlsZSBuYW1lLgo+ID4gKyAqIFJldHVybjogdHJ1ZSBpZiBz
d2FwIGlzIHN1cHBvcnRlZCwgZmFsc2UgaWYgbm90Lgo+ID4gICAgKi8KPiA+ICAgYm9vbCBpc19z
d2FwX3N1cHBvcnRlZChjb25zdCBjaGFyICpmaWxlbmFtZSk7Cj4gPgo+ID4gLS8qCj4gPiAtICog
R2V0IGtlcm5lbCBjb25zdGFudCBNQVhfU1dBUEZJTEVTIHZhbHVlLgo+ID4gKy8qKgo+ID4gKyAq
IHRzdF9tYXhfc3dhcGZpbGVzKCkgLSBHZXQga2VybmVsIGNvbnN0YW50IE1BWF9TV0FQRklMRVMg
dmFsdWUuCj4gPiAgICAqCj4gPiArICogUmV0dXJuOiBNQVhfU1dBUEZJTEVTIHZhbHVlLgo+ID4g
ICAgKi8KPiA+ICAgaW50IHRzdF9tYXhfc3dhcGZpbGVzKHZvaWQpOwo+ID4KPiA+IC0vKgo+ID4g
LSAqIEdldCB0aGUgdXNlZCBzd2FwZmlsZXMgbnVtYmVyLgo+ID4gKy8qKgo+ID4gKyAqIHRzdF9j
b3VudF9zd2FwcygpIC0gR2V0IHRoZSB1c2VkIHN3YXBmaWxlcyBudW1iZXIuCj4gPiArICoKPiA+
ICsgKiBSZXR1cm46IHVzZWQgc3dhcGZpbGVzIG51bWJlci4KPiA+ICAgICovCj4gPiAgIGludCB0
c3RfY291bnRfc3dhcHModm9pZCk7Cj4gPgo+Cj4gQW5kcmVhCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
