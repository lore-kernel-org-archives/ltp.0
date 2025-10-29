Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E29CCF9EE
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761725776; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8Ybl94ZvCYpRmmTUJ0GbCCGqMZqpJMrtz8RgVpWzL1o=;
 b=K3ZExMzpESpWK99kDH3JIFqATEgu5NgexehSvSZf9UpanJxUTvVhsGYBIgRNQVeRXv4F0
 t6thps2RPvZkZp0xrC55LdQH3dNM46P222W26t5IbmEAhC+EuOIYK4QYxDF5O3fg35wXHEu
 dNq+FWkbhH8Yg8cvPL20SxRUWivzMMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A01E3CA900
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 09:16:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80B253C9D1E
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:15:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C8ED11A00914
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761725753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sx9r+DDdOeYzwFQpxKNg0QMMMLd5GH9PiA7L9EI/0ac=;
 b=TKxKzdkLoOZ9YuPICXwRtX57bpR04jPLCpWjCteLdth5lxoasDRMKX2/HN0mZi1Wo93BTh
 EGXXb3tpXDignN7toqPuE58U1D4znPO4x+Aaa6kYWdlJ3K8DH0LvQmHjTLJuJxfQzF7EzW
 29hFXgKT4d5MXMJOZDALpHyDoRdUOww=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-bJ_cDzWlOWmKfqQe9CqWQQ-1; Wed, 29 Oct 2025 04:15:51 -0400
X-MC-Unique: bJ_cDzWlOWmKfqQe9CqWQQ-1
X-Mimecast-MFC-AGG-ID: bJ_cDzWlOWmKfqQe9CqWQQ_1761725751
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-290d860acbcso146054875ad.1
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 01:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725750; x=1762330550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sx9r+DDdOeYzwFQpxKNg0QMMMLd5GH9PiA7L9EI/0ac=;
 b=Z5w2MTdVnreCMlIlVfljeX/FImEkPTzJ4Fj/4MDIiK+Q9DNXGxEY2VQvce2I9wLbu5
 8asGef9cVDEjWyilc2SFOSsHmvlZtnKMi2sPkEzopMsyRWiSqF5ln/uXbcHTVBa3zID/
 60GtPjGg+vK+29MESKJ4SIURwcGWm42oWh3e4d1i0nubgPjhorZqbwZUEPaGfJTyLU/9
 jHT34KNmjnTpECZzQ4cG3yfg2iYzgezgUD9pqoJ1vNkkxtC/X5zUxdVitjc564acVnGK
 pMyfQbwVeGmFdrZ9GXgkHEWKocBydJZbQzt7fS3ThcIGDbQISk2qZFOaGEQnfCxmCLPR
 rr2g==
X-Gm-Message-State: AOJu0Yy1tvRO47kLKRkagBCaC8rVihKEyMujNUaEk+zhnYb0s48fIn1X
 brdtLcdNXYaSdS6W3/LCUJRpKa9zNCsAn4ltpy01YV94QX4lJbVZChNAoSQWp19hXFI4ziDmWPo
 m3V0oEFgbAe2RL7ByH1ayattPal3gMXvZHrklPRqJmaHh4LeAWCcVE6Q8ubACEE6kRTgjcL2Gqc
 D6yRTSovsqS1SQTSTaDiNZZH7bwRiyc7v+cTI7tQ==
X-Gm-Gg: ASbGncvPKwh8qBPZ8H360uOZmNDiX6WD/hpydtYlzd+x1NSIFSspwpOjuklw6UGzLp8
 ZeBeSTnLnoKcc+8TTp5c3QwprPvdZORILQlb1ZbyBB1Tcd5OE8PtkeCDS0ztXglrhkUjhgOkebI
 VhbDimlWZnnfpdGIiAe7nmw51dXJki0oB278ycv81JNocO2UboiZLo0NA/
X-Received: by 2002:a17:902:c943:b0:27e:ed0d:f4ef with SMTP id
 d9443c01a7336-294deebf6c0mr26986895ad.41.1761725750083; 
 Wed, 29 Oct 2025 01:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE4hBeQDiAq9aKSMMOkX8AyjnT6xVdyR5KYj8R8is6ExCJn+rfNmqk0iVqNYN4ge+QGR4xe9cns7Eya+qVeSk=
X-Received: by 2002:a17:902:c943:b0:27e:ed0d:f4ef with SMTP id
 d9443c01a7336-294deebf6c0mr26986575ad.41.1761725749493; Wed, 29 Oct 2025
 01:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251024084456.581607-1-pvorel@suse.cz>
In-Reply-To: <20251024084456.581607-1-pvorel@suse.cz>
Date: Wed, 29 Oct 2025 16:15:37 +0800
X-Gm-Features: AWmQ_bkJfS_qlqlaR55e_Z_Gj9QyYbzNwCopzbv6BAcdLZt4lol43VlHgYJJRak
Message-ID: <CAEemH2eANOOOgKbwa9KUB=CsmZTms4FoXGxcfpDO8xhQJQWD6Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ZAvSR4y3Ve-co7Hl19_3XlWCI4OBytMW-Cpp7Q63Ng_1761725751
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.0
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

T24gRnJpLCBPY3QgMjQsIDIwMjUgYXQgNDo0NeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9raXJr
L3JlbGVhc2VzL3RhZy92My4wCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KPgoKS2lyay12My4wIHdvcmtzIHdlbGwgb24gbXkgcXVpY2sgdGVzdC4KClJldmll
d2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+ICB0b29scy9raXJrIHwg
MiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS90b29scy9raXJrIGIvdG9vbHMva2lyawo+IGluZGV4IDJiNWQwYmU3ZjAu
LmUwZWY5ZjI4YmMgMTYwMDAwCj4gLS0tIGEvdG9vbHMva2lyawo+ICsrKyBiL3Rvb2xzL2tpcmsK
PiBAQCAtMSArMSBAQAo+IC1TdWJwcm9qZWN0IGNvbW1pdCAyYjVkMGJlN2YwY2RkZmMwNWQ5YzYw
NjY1NjIxOWM3YTAzMjY1MTJjCj4gK1N1YnByb2plY3QgY29tbWl0IGUwZWY5ZjI4YmNmMTVkMDBj
ZjhhMDM5MTVkZjg5NGJiMzhhNWQ4ZWEKPiAtLQo+IDIuNTEuMAo+Cj4KPiAtLQo+IE1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
