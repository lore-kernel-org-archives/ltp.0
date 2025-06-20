Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8588C7115B
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 05:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750398534; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uw+O8LIx21tCrKxIWCIz34G1nDfXtf4i+mutKXqxh0k=;
 b=INy2xWdwaWpFUEKf3mla1owySbY0vskSjV2wbkiqnE066ZLsAoJ4c7ioeGAO9nQ1DQ2Ok
 L9bHkj7heiPL1fyqLgrEHN5Qb7wrMGGhaXYh8iIa0rRJnXXWMjx7hPlxLKWDS1PMEO/kImv
 yvodeSoAMf+BJfmNG+iKOS9dinBuqIA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57C1C3CC81F
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 07:48:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 405533CAFC4
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 07:48:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0F70200923
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 07:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750398509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5izQvjNN85Ed48TNd+qzcqgdbBe0sNPDZL3Y1mzbfc=;
 b=hAzwZKyKxc7gvr9nnl0uS6Qr+p096I+PwoEH0zHO5zwUnBfvMFs6LMQee2+xuK3PekhiMz
 My0+MEGW0uO8vvYfTkMQXY2GdRDKkK6duN59dx3x81OE4wFV53y61Vht+3H9tdsKmtK60m
 INd3Yv8OV483ks+KsCjv55yVKN1uaNA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-JLF1Zx8UMxOctPF5ZZ8nhg-1; Fri, 20 Jun 2025 01:48:27 -0400
X-MC-Unique: JLF1Zx8UMxOctPF5ZZ8nhg-1
X-Mimecast-MFC-AGG-ID: JLF1Zx8UMxOctPF5ZZ8nhg_1750398506
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3138f5e8ff5so1484032a91.3
 for <ltp@lists.linux.it>; Thu, 19 Jun 2025 22:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750398506; x=1751003306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j5izQvjNN85Ed48TNd+qzcqgdbBe0sNPDZL3Y1mzbfc=;
 b=m8nWE8iNQmV8uw/b208/1jqxvB/bq1oyNjFcA7axGJI5FAa/tdegChVIKZ3A9dcCHr
 ZpgKB2h9seN2MpBQN0wXAsSkY1oQPo117Cavd++k9+u7MgQWs3ipXpvRavkxiBrgmcPq
 N9QiyAopZlhGInl0vwYziSvqycVI6ZxoORSmzXB6wSt/DNQ3D1it0/ht2GCofzQM5MK0
 mkD4SV+8ARgTZ1q8SJBejuOnoiZptJv5LzqGW0rJCkgqPrg+ERjmDmDzwaIma/Wfjpp0
 7/YvUfWaDWSmCj0ybMxHD6UYZsgn7qslMelTLuq1QWlhM9ffacG2qZrvZosWHe9IiA4C
 HX+Q==
X-Gm-Message-State: AOJu0YyrzDHyPjzFrT/FPAdOYFeIgaghdL1c/1crCDM7SWDSz6BpG9k/
 xmDEAEEL8BQk9hY6r/ID8SAo2L/INXQ75qzXKbvH+jonY5dSNB03JwBPJhdy+csZFojDAV6grRx
 Le+ROATEqLziXM1WnbmFtEp/cGmnAUdwGXtwpo3dOO/hGakd2QgbvWNBwAMCt1vs3dRLtfB9z64
 qPgNazs3/AFl/9+Bi5YDAM9hG+Tes=
X-Gm-Gg: ASbGnctGZJxyE7DmfP6hrL8XJQIDCCseNjPf4AQJZFeu1Sw9xrav+PjLxd3j/3OakOA
 1WEcOxMJOT0d3OPEXl0xKd97q62w1LtRokAIETJ2NJHn4+jIU0WESdGe4+N3C4BcThJ6xebUCWi
 g2+7Wc
X-Received: by 2002:a17:90b:2ec3:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3159d62c276mr2454975a91.5.1750398506332; 
 Thu, 19 Jun 2025 22:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiIk7s76ivgIy9X+lB2Xh4AoChJ/CZBpN+GFwTvzYFd6St1fYJ0CMhr4rwjP0FDszWaFPnzjSjZ1vRlPRoZqU=
X-Received: by 2002:a17:90b:2ec3:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3159d62c276mr2454951a91.5.1750398505914; Thu, 19 Jun 2025
 22:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <aDcRHXhOBcqVDp05@yuki.lan>
 <CAEemH2f6qeojmFXfisc-_o3iFbda98p2JCVAV_K09gbKtVQp1g@mail.gmail.com>
In-Reply-To: <CAEemH2f6qeojmFXfisc-_o3iFbda98p2JCVAV_K09gbKtVQp1g@mail.gmail.com>
Date: Fri, 20 Jun 2025 13:48:14 +0800
X-Gm-Features: Ac12FXz_5bo9Sima6te94ZpPZ-lXPTWbKbEnyW1Z1E_YD3wHsGnbP3DKpYu02bk
Message-ID: <CAEemH2f8B5aJffcnbkYsr9j5KfZutgQkken8vbokNhsu19C8MA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Ian Wienand <iwienand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rPYm_vkDpTxgSJ0nyb-sEEoLhucCZx_JUJreummCzNc_1750398506
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQWxsLAoKQWZ0ZXIgYSByb3VuZCBvZiBleHBlcmltZW50cyBhbmQgaW50ZXJuYWwgZGlzY3Vz
c2lvbnMgKHRoYW5rcyB0bwpJYW4gV2llbiBmb3Igc2hhcmluZyBoaXMgdGhvdWdodHMgd2l0aCBt
ZSksIHdlIHRoaW5rIHRoYXQgbWFraW5nCkxUUF9SVU5USU1FX01VTCBzdXBwb3J0IGZsb2F0aW5n
IHBvaW50IG51bWJlcnMgWzAsIDFdIG1heQphIHBvc3NpYmxlIHdheSB0byByZWR1Y2UgdGhlIC5y
dW50aW1lIHZhbHVlcyBzZXQgaW4gdGVzdHMuCgpGb3IgZXhhbXBsZSwgc2V0dGluZyBMVFBfUlVO
VElNRV9NVUwgdG8gMC4xIGNhbiBvYnZpb3VzbHkKcmVkdWNlIHRoZSB0ZXN0IHRpbWUgb2YgNjAw
IHNlY29uZHMgdG8gNjAgc2Vjb25kcy4KCk9uZSBtYXkgdGhpbmsgdGhhdCByZWR1Y2luZyB0aGUg
LnJ1bnRpbWUgdmFsdWUgaW4gYXByb2R1Y3Rpb24KZW52aXJvbm1lbnQgaXMgcG90ZW50aWFsbHkg
cmlza3ksIGFuZCB0byBzb21lIGV4dGVudCB0aGUgYW5zd2VyCmlzIHllcy4KCkJ1dCBsb29raW5n
IGJhY2ssIExUUCBpcyB0cmlnZ2VyZWQgdmVyeSBmcmVxdWVudGx5IGluIENJIGFuZCB2YXJpb3Vz
CnByb2R1Y3Rpb24gZmxvd3MsIHNvIHRvIGNvbXBlbnNhdGUgZm9yIHRoaXMgbG9zcywgd2UgY2Fu
IHVzZSBmbG9hdGluZwpwb2ludCBMVFBfUlVOVElNRV9NVUwgb25seSBpbiBkZXNpZ25hdGVkIHF1
aWNrIENJLCBpbnN0ZWFkIG9mCnVzaW5nIGl0IGluIGRhaWx5IHRlc3RzLiBUaGlzIHdpbGwgaGVs
cCBjb3ZlciBtb3JlIHNjZW5hcmlvcy4KCkZyb20gb3VyIENJIHJlcG9ydCwgdXNlIDAuMSBpbiBy
dW50aW1lX211bCBmaW5kIGEgZmV3IGZhaWx1cmVzIGluIHRoZSByb3VuZApkb3duIHByb2JsZW0g
d2l0aCBuaWNlMDUuYyAoLnJ1bnRpbWUgPSAzKSwgdGhpcyBpcyBhIGRlZmVjdCBvZgptdWx0cGx5
X3J1bnRpbWUoKS4KQWxzbywgYW5vdGhlciBwcmVhZHYyMDMgcG9zc2libGUgZmFpbHVyZSByZWxh
dGVkIHRoaXMuIEJ1dCB0aGV5IGFyZSB0aW55Cmlzc3Vlcy4gQW5kIHRoZSByZXN0IC5ydW50aW1l
IHRlc3RzIHNvIGZhciBubyBvYnZpb3VzIHByb2JsZW0gb24gdGhhdC4KClNvIEkgd291bGQgbGlr
ZSB0byBzdGFydCB0aGUgd29yayBmcm9tIHRoaXMgcG9pbnQgdG8gcmVkdWNlIGV4ZWN1dGlvbiB0
aW1lLgoKUmVnYXJkaW5nIGNhbGlicmF0aW5nIHRoZSBudW1iZXIgb2YgbG9vcHMsIEkgdGhpbmsg
dGhhdCBpcyBhbm90aGVyIGdvb2QKZGlyZWN0aW9uIHRvIHdvcmssIGJ1dCBtYXkgbmVlZCBtb3Jl
IHRpbWUgdG8gZXZhbHVhdGUuIEkgdGhpbmsgdGhhdCdzIGEKbG9uZy10ZXJtIGdvYWwuCgoKT24g
VGh1LCBNYXkgMjksIDIwMjUgYXQgOTo1M+KAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gV2VkLCBNYXkgMjgsIDIwMjUgYXQgOTozNeKAr1BNIEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPiA+Cj4gPiBIaSEKPiA+ID4gQWZ0ZXIgcmV2aWV3
aW5nIHNvbWUgTFRQIEhUTUwgdGVzdCByZXBvcnRzLCBJIG5vdGljZWQgdGhhdCB0aGUgdGVuCj4g
dGVzdHMKPiA+ID4gYWxvbmUgdGFrZSBuZWFybHkgMjAgbWludXRlcyB0byBjb21wbGV0ZS4gRm9y
IGV4YW1wbGU6Cj4gPiA+Cj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+IGJpbmQwNiAg
ICAgICAgICAgMzAwLjE1cwo+ID4gPiBtc2dzdHJlc3MwMSAgICAgIDE4MC40NHMKPiA+Cj4gPiBJ
c24ndCB0aGlzIGJldHRlciBhZnRlcjoKPiA+Cj4gPiBjb21taXQgZTNiODVlNTA0NzFiMzg5MjMx
NmEyYjJjN2M3MzBlOWRjOGQ5MTM5ZQo+ID4gQXV0aG9yOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8
cmJtQHN1c2UuY29tPgo+ID4gRGF0ZTogICBXZWQgTWF5IDIxIDA1OjMxOjEyIDIwMjUgLTAzMDAK
PiA+Cj4gPiAgICAgc3lzY2FsbHMvbXNnc3RyZXNzMDE6IFNldCB1cHBlciBib3VuZCBmb3IgbnVt
X21lc3NhZ2VzCj4KPiBUaGlzIGNvbW1pdCBoYXNuJ3QgYmVlbiBiYWNrcG9ydGVkIHRvIG91ciBD
SSBsdHAsIHNvIGl0IGhhc24ndCBnb3R0ZW4gdGhlCj4gY291bnQuCj4gQnV0IGxhdGVyIEkgd2ls
bCBmb2N1cyBvbiB0aGF0IG9uY2Ugd2UgdXBncmFkZSB0byB0aGUgTWF5IHJlbGVhc2UuCj4KPiA+
Cj4gPgo+ID4gPiBmc3gyMiAgICAgICAgICAgIDE3MC40N3MKPiA+ID4gcHR5MDcgICAgICAgICAg
ICAxNTAuMDRzCj4gPiA+IHB0eTA2ICAgICAgICAgICAgMTUwLjAycwo+ID4gPiBnZjE4ICAgICAg
ICAgICAgIDEyMS4wOXMKPiA+ID4gZ2YxNyAgICAgICAgICAgICAxMjAuODJzCj4gPiA+IGdmMTYg
ICAgICAgICAgICAgMTIwLjEzcwo+ID4gPiBkaXJ0eWMwd19zaG1lbSAgIDEyMC4xMXMKPiA+ID4g
c2V0c29ja29wdDA3ICAgICAgNzYuNDdzCj4gPgo+ID4gQXMgUGV0ZXIgcG9pbnRlZCBvdXQsIG1v
c3Qgb2YgdGhlc2UgYXJlIGZ1enp5IHN5bmMgdGVzdHMgYW5kIHRoZSBydW50aW1lCj4gPiBpcyBj
YWxsaWJyYXRlZCBpbiBvcmRlciB0byBnZXQgcmVhc29uYWJsZSBjaGFuY2Ugb2YgcmVwcm9kdWNp
bmcgdGhlCj4gPiByZXN1bHRzLiBCdXQgaW5kZWVkIHRoZSBydW50aW1lIGRvZXMgbm90IHNjYWxl
IHdpdGggdGhlIHNwZWVkIG9mIHRoZQo+ID4gbWFjaGluZSBhbmQgd2UgYXJlIG5vdCBzZXR0aW5n
IHRoZSBwYWlyIGV4ZWNfbG9vcHMgaW4gdGhlIHRlc3RzIHRoYXQgcnVuCj4KPiA+IGZvciBzbyBs
b25nLCBzbyBJIHN1cHBvc2UgdGhhdCBjYWxsaWJyYXRpbmcgdGhlIG51bWJlciBvZiBsb29wcyBm
b3IKPiA+IHRoZXNlIHRlc3RzIHRoYXQgZG9lcyBub3QgbWFrZSB0aGUgYnVnIGxlc3MgcmVwcm9k
dWNpYmxlIHdvdWxkIG1ha2UKPiA+IHRoaW5ncyBiZXR0ZXIuCj4KPiBBZ3JlZSwgdGhpcyBpcyB0
aGUgZGlyZWN0aW9uIHRoYXQgd2UgbmVlZCB0byBmb2N1cyBvbiBpbXByb3ZpbmcuCj4KPiAtLQo+
IFJlZ2FyZHMsCj4gTGkgV2FuZwo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
