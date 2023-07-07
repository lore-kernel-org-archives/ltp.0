Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E058EB64D9
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 12:50:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB9A3CBDFF
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 14:50:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E74503C99C8
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 14:50:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF2311A00CCE
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 14:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688734223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToN94WQyW2IzNVKoe29+D3MuLc5L8biVqlCVnlREzqY=;
 b=MkK3Jh+NYBTJ/W0Fz/YK5kgJ9qK30IPBEXdbdyNjMeH9UEm79PYpWBnLJrWRtwH7nvnkEk
 +vZknjc0CtllaiMzmQlpEh3O2H26ALm2x4K84PTbYkhb+D3iR0XBwov3vyUCtkVP9MPjt0
 ljS79eIxgguMU6KaMEHiqntNOckS21Q=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-kv2al9k4Ml-pn-LR65EdVQ-1; Fri, 07 Jul 2023 08:50:22 -0400
X-MC-Unique: kv2al9k4Ml-pn-LR65EdVQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5618857518dso19418297b3.2
 for <ltp@lists.linux.it>; Fri, 07 Jul 2023 05:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688734221; x=1691326221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToN94WQyW2IzNVKoe29+D3MuLc5L8biVqlCVnlREzqY=;
 b=a7UtLNiivGHjcPxYPM54zFTTBlfKLId0bDt41ZcKPl3iMKIs37pl76Mi5IRGHJh7wc
 bruoCtwptEOC/a3DKMzqWqONkLmMY+YBNFEVXYqkkD+pJwjHzM/GcBzLe+X8Sku0LvBF
 MWyNXXoGVh04/k7P30jDLMeD4LwWxLgiJrwp9pLrinedb3Y8+V+jS9UdxwcE2w4PRjv+
 u2Dsz9PiM4PCZTlBPlTO7LHcU30h9k14idkQWXayu5vhsknel2prLONmPBfcwpU/g0PY
 lP4zKt1AqvkrPVwMojJqb26//8BUyXGjE118QO0lD+TplIcxUIVT9HNvF4aP24OQJE8n
 ozQQ==
X-Gm-Message-State: ABy/qLacpVUqdUmHqMxesxSa+aOWgQn5CNtmtdTG+hqzCcYitfW0KSvM
 5H6rn3hiIUB9TJDvaIvdjSr/zuPVlcfIwdRdR/T89X6A+Z6CF8uNg++l8iukpB0UbCQdqEhIeXA
 OctHtxRPrdDquOqs0sIpcVUUv56s=
X-Received: by 2002:a81:4f4c:0:b0:579:e5fb:f6c5 with SMTP id
 d73-20020a814f4c000000b00579e5fbf6c5mr5213463ywb.2.1688734221535; 
 Fri, 07 Jul 2023 05:50:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGu+8KRLYVLS4Exht0eM3ofySVRi/Jlw0myJLDrIxu8/eMrNWo7CGm1sEFfJoyMmvxSMQ6yCPLM7fYDVHFLX4s=
X-Received: by 2002:a81:4f4c:0:b0:579:e5fb:f6c5 with SMTP id
 d73-20020a814f4c000000b00579e5fbf6c5mr5213449ywb.2.1688734221287; Fri, 07 Jul
 2023 05:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
 <20230621090331.GA365741@pevik>
 <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
 <20230702191813.GB360317@pevik>
 <CAK-6q+hsZxurnnd2snKr12R5UwieCnWhvgr5_OoDKAXorHNhTA@mail.gmail.com>
 <20230707081404.GA571797@pevik>
In-Reply-To: <20230707081404.GA571797@pevik>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 7 Jul 2023 08:50:10 -0400
Message-ID: <CAK-6q+joXWdS5nP6A4dXThSAA99wPuZW0jVzGirZMDoUqzGPSA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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

SGksCgpPbiBGcmksIEp1bCA3LCAyMDIzIGF0IDQ6MTTigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cj4KPiA+IEhpLAo+Cj4gPiBPbiBTdW4sIEp1bCAyLCAyMDIzIGF0IDM6
MTjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gSGkgQWxl
eCwKPgo+ID4gPiAuLi4KPiA+ID4gPiA+ID4gKyAqIFtEZXNjcmlwdGlvbl0KPiA+ID4gPiA+ID4g
KyAqIFRlc3RzIGdmczIgZGxtIHBvc2l4IG9wIHF1ZXVlIGhhbmRsaW5nIGluIHRoZSBrZXJuZWwu
Cj4gPiA+ID4gPiA+ICsgKiBJdCBpcyByZWNvbW1lbmRlZCB0byBydW4gd2F0Y2ggLW4gMC4xICJk
bG1fdG9vbCBwbG9ja3MgJExTIgo+ID4gPiA+ID4gPiArICogYXNpZGUgdG8gbW9uaXRvciBkbG0g
cGxvY2sgaGFuZGxpbmcuCj4gPiA+ID4gPiA+ICsgKgo+ID4gPiA+ID4gPiArICogW0hvdyB0byB1
c2UgaXRdCj4gPiA+ID4gPiA+ICsgKiBDYWxsIGl0IHdpdGggVE1QRElSPS9tbnQgLi9mY250bDQw
IHdoZXJlIFRNUERJUiBpcyBhIGdmczIgbW91bnRwb2ludC4KPiA+ID4gPiA+IEkgd29uZGVyIGlm
IHdlIGNvdWxkIGNoZWNrIGZvciBHRlMyX01BR0lDICh3ZSdkIG5lZWQgdG8gYWRkIGl0IHRvCj4g
PiA+ID4gPiBpbmNsdWRlL3RzdF9mcy5oID0+IDB4MDExNjE5NzApIGFuZCBxdWl0IHRoZSB0ZXN0
IHdpdGggdHN0X2JyayhUQ09ORikgaWYgVE1QRElSCj4gPiA+ID4gPiBpcyBub3Qgb24gZ2ZzMi4K
Pgo+ID4gPiA+ID4gQVRNIHdlIGRvbid0IGhhdmUgYW55IGhlbHBlciBpbiBzdHJ1Y3QgdHN0X3Rl
c3QsIHdoaWNoIHdvdWxkIGRvIGl0Lgo+Cj4KPiA+ID4gPiBJIHdpbGwgbWVudGlvbiB0aGF0IGdm
czIgaXMgb25seSBhbiBleGFtcGxlIGhlcmUuIEl0IGJlY29tZXMKPiA+ID4gPiBpbnRlcmVzdGlu
ZyB3aGVuIGEgZmlsZSBzeXN0ZW0gaW1wbGVtZW50cyBpdHMgb3duIC5sb2NrKCkgY2FsbGJhY2sg
T1IKPiA+ID4gPiBpZiBzb21lYm9keSB3YW50cyB0byB0ZXN0IGZpbGUgc3lzdGVtIGNvcmUsIHdo
ZW4gYSBmaWxlc3lzdGVtIGRvZXMgbm90Cj4gPiA+ID4gaW1wbGVtZW50IGl0cyBvd24gLmxvY2so
KS4KPgo+ID4gPiBJIHNlZSAubG9jayBpcyBpbXBsZW1lbnRlZCBpbiA5cCwgYWZzLCBjZXBoLCBj
aWZzLCBvY2ZzMiwgb3JhbmdlZnMsIGV2ZW4gTkZTLgo+ID4gPiAiZmlsZSBzeXN0ZW0gY29yZSI6
IGRvIHlvdSBtZWFuIFZGUz8gQmVjYXVzZSB0aGF0IHdvdWxkIGJlIG1vcmUgdXNhYmxlIHRoYW4g
dGhlCj4gPiA+IGZpbGVzeXN0ZW1zIGFib3ZlICh3aGljaCBhcmUgcXVpdGUgZXhvdGljKS4KPgo+
Cj4gPiBJdCBkZXBlbmRzIGhlcmUgd2hhdCB0aGV5IGFyZSBkb2luZyBpbiAubG9jaygpIC0gSWYg
dGhleSBqdXN0IGNhbGwKPiA+IGxvY2tzX2xvY2tfZmlsZV93YWl0KCkgb3Igc2ltaWxhciBoZWxw
ZXJzIGRlcGVuZGluZyBvbiB0aGUgY2FsbCwgdGhlbgo+ID4gdGhleSBkb24ndCBkbyBtdWNoIGRp
ZmZlcmVudCB0aGFuIHdoYXQgdmZzIGlzIGRvaW5nLgo+ID4gSW4gY2FzZSBvZiBnZnMyL29jZnMg
aXQgaXMgdmVyeSBzcGVjaWFsLCBpdCByZWRpcmVjdHMgdGhlaXIgY2FsbHMgdG8KPiA+IERMTSBh
bmQgRExNIGhhcyBpdHMgb3duIHdob2xlIHBvc2l4IGltcGxlbWVudGF0aW9uIGJlaGluZCBpdC4g
V2Ugb25seQo+ID4gY2FsbCBsb2Nrc19sb2NrX2ZpbGVfd2FpdCgpIHRvIGtlZXAgdGhlIExpbnV4
IGJvb2trZWVwaW5nIGluCj4gPiAvcHJvYy9sb2Nrcy4KPgo+ID4gV2hhdCBJIGFtIGRvaW5nIGhl
cmUgaXMgbW9zdGx5IHRydXN0aW5nIHRoZSBMaW51eCBpbXBsZW1lbnRhdGlvbiBhbmQKPiA+IGNv
bXBhcmluZyByZXN1bHRzIGZyb20gZS5nLiB0bXBmcyB3aXRoIEdGUzIgYW5kIEkgZm91bmQgaXNz
dWVzLgo+Cj4gPiBGb3Igbm93IEkgdHJ1c3QgdGhlIExpbnV4IGltcGxlbWVudGF0aW9uIGFuZCBj
aGVjayBpZiB3ZSBoYXZlIGEKPiA+IGRpZmZlcmVudCByZXN1bHQgaGVyZS4gSSBuZWVkIHRvIGJl
IHZlcnkgY2FyZWZ1bCBoZXJlIGJlY2F1c2UKPiA+IEdGUzIvT0NGUzIgYXJlIGNsdXN0ZXIgZmls
ZXN5c3RlbXMgYW5kIHRoZSBmY250bCgpIGludGVyZmFjZSB3YXMgbmV2ZXIKPiA+IG1hZGUgZm9y
IGNsdXN0ZXIgZmlsZXN5c3RlbXMuIEhvd2V2ZXIgSSBjdXJyZW50bHkgb25seSB0ZXN0ICJvbmUg
bm9kZSIKPiA+IGxvY2tpbmcgYW5kIHRoaXMgc2hvdWxkIGRlbGl2ZXIgdGhlIHNhbWUgcmVzdWx0
cyBhcyB0bXBmcywgZXRjLgo+Cj4gVGhhbmtzIGZvciBpbmZvLiAgSSdtIHN0aWxsIG5vdCBzdXJl
IGlmIHRoaXMgaXMgdXNlZnVsIG9ubHkgZm9yIGdmczIvb2Nmcwo+IGFuZCB3ZSBzaG91bGQgcHJl
cGFyZSBibG9jayBkZXZpY2Ugd2l0aCBnZnMyIG9yIG9jZnMgYW5kIHRlc3QgZmlsZXN5c3RlbSBv
biBpdC4KPiBPciBpZiBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gdGVzdCBvdGhlciBmaWxlc3lzdGVt
IGltcGxlbWVudGF0aW9uLiBJbiB0aGlzIGxhdHRlcgo+IGNhc2Ugd2UgdXN1YWxseSB1c2UgLmFs
bF9maWxlc3lzdGVtcyAod2UgZG9uJ3QgaGF2ZSBwcm9wZXIgZG9jcyBmb3IKPiAuYWxsX2ZpbGVz
eXN0ZW1zLCB0aGUgY2xvc2VzdCBpcyBbMV0pIGFuZCB0ZXN0IGlzIHRoZW4gcnVuIG9uIHZhcmlv
dXMgY29tbW9uCj4gZmlsZXN5c3RlbXMgKHNlZSBmc190eXBlX3doaXRlbGlzdFtdIGluIGxpYi90
c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMpLCBidXQgaW4KPiB0aGF0IGNhc2UgZ2ZzMiB3b3VsZCBi
ZSBza2lwcGVkIChpdCdzIG5vdCBhIGNvbW1vbiBmaWxlc3lzdGVtKS4KPgo+IEluIGNhc2UgcHJl
cGFyaW5nIGJsb2NrIGRldmljZSB3aXRoIGdmczIgc29tZXRoaW5nIGxpa2UgdGhpcyBtaWdodCB3
b3JrOgo+Cj4gc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLi4uCj4g
ICAgICAgICAuZGV2X2ZzX3R5cGUgPSAiZ2ZzMiIsCj4gICAgICAgICAuZm9ybWF0X2RldmljZSA9
IDEsCj4gICAgICAgICAuZGV2X2ZzX29wdHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10peyAiLXQi
LCAibXljbHVzdGVyOm15Z2ZzMiIsICItcCIsICJsb2NrX2RsbSIsICItaiIgLCAiMiIgLCBOVUxM
fSwKPgoKQ2FuIEkgb3ZlcnJpZGUgdGhpcyBzZXR0aW5nIGJ5IHNvbWUgRU5WIGJlY2F1c2UgSSBh
Y3R1YWxseSB3YW50IHRvIHJ1bgppdCBvbiBhIGRpZmZlcmVudCBmaWxlc3lzdGVtIHdoaWNoIGlz
IHVzaW5nIFZGUyBwb3NpeCBsb2NrCmltcGxlbWVudGF0aW9uLCBiZWNhdXNlIGFzIEkgc2FpZCBJ
IHdhbnQgdG8gY29tcGFyZSB0aGUgcmVzdWx0cy4KCi0gQWxleAoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
