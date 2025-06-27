Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603AFC77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751016383; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Gx9UNPJKCNJ0P78bhHoF78Q2TH4PL6LsR1UJ1R/IY3I=;
 b=etIPMdjk0NZLR8nYERZp04fxbh36cLqo3dTpbZXCKKPnYuQVo4dSXyZmcqy+1ruoe6Xmv
 5D87QyIfGVWQZQ4AO9cTCJnb0cw5Oyplxg6KkqFi/1YjmwO6GL21yCsgaR3rClMuT+th5/R
 33R5JnYM8f3joW2Ct1q9kRrRS/axbL0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 900E13C7615
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 11:26:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD64A3C1924
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:26:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24A4960094C
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751016357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lASmMrye5Y4kxlh0UPTaJv+KTRS4u9u8kbq0qcIZC1w=;
 b=arcTB07fKyRi/lkKX2EgwmVgmi8dLMd3OW6vsTFHM8JK6LvfSdDj8iDMJEFjmJXfvvZe68
 m2jzVGug0eRa3eJUC5KJYEYN3JcWVwG63E0okIegKrsDsSesxsaiGF2oQUPv9tRsDmGt57
 V+I+AWr+mTaN7Sp2SFBiHUuo3Cg8JFg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-dyml_stINkOlTDt7wYwtEQ-1; Fri, 27 Jun 2025 05:25:53 -0400
X-MC-Unique: dyml_stINkOlTDt7wYwtEQ-1
X-Mimecast-MFC-AGG-ID: dyml_stINkOlTDt7wYwtEQ_1751016352
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-311e7337f26so1651688a91.3
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 02:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751016352; x=1751621152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lASmMrye5Y4kxlh0UPTaJv+KTRS4u9u8kbq0qcIZC1w=;
 b=KVeiOaFQCwNDZq93BrzHBk9bIF5bKAkv2sXYLL/FCSmhKZcJUPgq/DhyboZmwueSe8
 yOn29OlznyGTaZcpfWJLERRpKhLZj2p+/z0laJIWqI1HxS+l+8wAMvzns/984R4RaWCm
 /i/mLF8ZQszSektkyUgyLErqyL8PyDjnRl8sdiPrB+wb5WaAWMdYKLE0BJknU/5a98UR
 X/PuPZklvtNEMnN2XF1nLEFwMM2gMkLXWZPYBLzcx/BeN2SVUx54FlztDfJUcMMEXUpQ
 mu5x9kkZeouKCyKM0g13aRj6US0xiHzV9zB62DnLMGzfgK+t+1bRaEPGq1T9OAjzRGBS
 +EXQ==
X-Gm-Message-State: AOJu0Yxa0boA9kZutIKdJ3zoc650+rkEKKcy6eO9UoXPGbQzh8sBn9K2
 TGj8ynb3HUtnXMsPL3jcdOAmHCA84NdjpL5K7zVaL/7hg5hpNkLS4+4l7a0Tz3eCasANT/vPogL
 BisCS6MS2vgDbuB+FHyFvWywLs6eNa+9D0dJnvyOfaWPpX5qV6OTXusUhINzS8EA13oTEOTxhQv
 dc5j+L1dYbykicc5zpJMV6rFNNEmQ=
X-Gm-Gg: ASbGncsIJJYYe4r8WlQiLcQdGsrDlyn6ptmdfmrfEpXjs3tpvaznOanTEVHYwaWaPtO
 vEYE4OSxtIa03ZjbFmLvwuorvJHN2fIbQDAN1MvKElYNQBsw3MVKSFntur5SI7CX0A8KszqiWBo
 dD1u0N
X-Received: by 2002:a17:90b:224b:b0:311:ad7f:3299 with SMTP id
 98e67ed59e1d1-318c92fc896mr3353974a91.25.1751016352094; 
 Fri, 27 Jun 2025 02:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDsCl5pGJVz7Pk5YDJTwa+XObMat5HLeqVljY6hWk0eoKMAqaZeco9tY4HF0cK/SKZMDG+SLipfEcnq5EKyXE=
X-Received: by 2002:a17:90b:224b:b0:311:ad7f:3299 with SMTP id
 98e67ed59e1d1-318c92fc896mr3353935a91.25.1751016351576; Fri, 27 Jun 2025
 02:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250616102619.54254-1-liwang@redhat.com>
 <aF1KmkMhXNWBbUwi@yuki.lan>
 <CAEemH2esWnKqv2q-UM3tHoTRfR6caLp-0yZN1yF6XCk79XSOyA@mail.gmail.com>
 <aF5NFP5KpuebdkwV@yuki.lan>
In-Reply-To: <aF5NFP5KpuebdkwV@yuki.lan>
Date: Fri, 27 Jun 2025 17:25:39 +0800
X-Gm-Features: Ac12FXzD39rmqfdzBIa6HP1UIbyKfVjtWeDpoNsatNVz-pemps1iXocqbX61gvc
Message-ID: <CAEemH2fsxXGfE60UP3EU9s8HzPb7msQSoYMg85h6-R5rvD2JKA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rkQlQKtqbYpyXbkEUJskNDiMqBGe-b844jS-E5UBbM0_1751016352
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/3] checkpoint: Refactor and unify shell/C reinit
 support
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

T24gRnJpLCBKdW4gMjcsIDIwMjUgYXQgMzo0OeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+IEkgdGhpbmsgdGhhdCB0aGUgcm9vdCBvZiB0aGUg
cHJvYmxlbSBpcyB0aGF0IHRoZSBzaGVsbCBmdW5jdGlvbgo+ID4gPiBfdHN0X2luaXRfY2hlY2tw
b2ludHMoKSBkb2VzIG5vdCBjcmVhdGUgdGhlIElQQyByZWdpb24gd2l0aCB0aGUgbWFnaWMuCj4g
PiA+Cj4gPiA+IFdoYXQgYWJvdXQgdGhpcyBwYXRjaDoKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2ggYi90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCj4g
PiA+IGluZGV4IGMzMmJkOGIxOS4uYTMxMGQzOTIyIDEwMDY0NAo+ID4gPiAtLS0gYS90ZXN0Y2Fz
ZXMvbGliL3RzdF90ZXN0LnNoCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gK
PiA+ID4gQEAgLTYyNyw2ICs2MjcsNyBAQCBfdHN0X2luaXRfY2hlY2twb2ludHMoKQo+ID4gPiAg
ICAgICAgICAgICAgICAgdHN0X2JyayBUQlJPSyAidHN0X2dldGNvbmYgUEFHRVNJWkUgZmFpbGVk
Igo+ID4gPiAgICAgICAgIGZpCj4gPiA+ICAgICAgICAgUk9EX1NJTEVOVCBkZCBpZj0vZGV2L3pl
cm8gb2Y9IiRMVFBfSVBDX1BBVEgiIGJzPSIkcGFnZXNpemUiCj4gPiA+IGNvdW50PTEKPiA+ID4g
KyAgICAgICBST0RfU0lMRU5UIHByaW50ZiBMVFBNIHwgZGQgb2Y9IiRMVFBfSVBDX1BBVEgiIGJz
PTEgc2Vlaz0wCj4gPiA+IGNvbnY9bm90cnVuYwo+ID4gPgo+ID4KPiA+IE5vLCBJJ20gYWZyYWlk
IHRoaXMgd29uJ3Qgd29yayBhcyBleHBlY3RlZC4KPiA+Cj4gPiBUaGUgUEVDIGZhaWx1cmUgd2Fz
bid0IGNhdXNlZCBieSB0aGUgc2hlbGwgY2hlY2twb2ludCBtaXNzaW5nIHRoZSAiTFRQTSIKPiA+
IG1hZ2ljLiBJbnN0ZWFkLCB0aGUgcm9vdCBjYXVzZSB3YXMgdGhhdCB0aGUgcmVpbml0aWFsaXph
dGlvbiBsb2dpYwo+ID4gKHRzdF9yZWluaXQoKSkKPiA+IGV4cGVjdGVkIGEgZGlmZmVyZW50IElQ
QyBmb3JtYXQuCj4KPiBJIGRvIG5vdCB0aGluayBzbywgYm90aCB0aGUgUEVDIEMgaGVscGVycyBh
bmQgdGhlIHRzdF9jaGVja3BvaW50LmMgY2FsbAo+IHRzdF9yZWluaXQoKSBzbyBhcyBsb25nIGFz
IHRoZSBmdW5jdGlvbiBzdWNjZWVkcyB0aGUgbWVtb3J5IGxheW91dCB3aWxsCj4gYmUgdGhlIHNh
bWUuIFRoZSBjaGVja3BvaW50cyB3aWxsIHN0YXJ0IGF0IHNvbWUgb2Zmc2V0IGluIHRoZSBwYWdl
IG9mCj4gdGhlIElQQyBtZW1vcnksIGJ1dCB0aGF0IHdhcyBhbHdheXMgdGhlIGNhc2UuCj4KPiBB
bmQgaXQgdHVybnMgb3V0IHRoYXQgdGhlIHBhdGNoIEkndmUgc2VuZCB5ZXN0ZXJkYXkgZG9lcyBu
b3Qgd29yawo+IGJlY2F1c2Ugb2YgZW5kaWFuaXR5LiBUaGUgbWFnaWMgaW4gdGhlIElQQyByZWdp
b24gaXMgTVBUTCBvbiBsaXR0bGUKPiBlbmRpYW4uCj4KClRoZSBlbmRpYW5pdHkgaXNzdWUgc291
bmRzIHJlYXNvbmFibGUsIEkgdGhvdWdodCBhYm91dCBpdCBhIGJpdCBhbmQgdGVzdGVkCml0IG9u
IG15IHg4Nl82NC9zMzkweCwgaXQgdHVybnMgb3V0IHlvdSdyZSByaWdodCwgdHN0X2NoZWNrcG9p
bnQuYyB1c2VzCnRzdF9yZWluaXQoKSB0byBtYWtlIHRoZSBJUEMgbGF5b3V0IHdvcmsgZm9yIHNo
ZWxsIHRlc3RzIGFzIHdlbGwuCgpNeSBuZXcgdHN0X2NoZWNrcG9pbnRfcmVpbml0IG1ldGhvZCBp
cyBhY3R1YWxseSBhIGJpdCBtb3JlIGNvbXBsaWNhdGVkLApyZXF1aXJpbmcgdGhlIGludHJvZHVj
dGlvbiBvZiB0d28gc2VwYXJhdGUgSVBDcyBmb3IgQyBhbmQgc2hlbGwuClRoaXMgaXMgc29tZXdo
YXQgdW5uZWNlc3NhcnkuCgpTbywgd2lsbCB5b3Ugc2VuZCBhIG5ldyBwYXRjaCAob3IgSSBkbyB0
aGF0IGluIG15IG5leHQgdmVyc2lvbik/CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
