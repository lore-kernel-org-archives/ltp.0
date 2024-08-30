Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED927CA0ED0
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 02:11:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6623D2820
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 04:11:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E893D2043
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 04:10:53 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0FACA1A0089D
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 04:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724983851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0y/5lMA5khOX2SxqMDq8TCu5dFNvLtYVvizG5IXQAU=;
 b=FYJFwYoS+lBLYxXInwrbvEygxSd8anpHPvkc0UQu7AeYLpVUkSHdyF2t0tp9FW6EgityVV
 93G/mRlJwk4LlpLg9lSez1M2j4GjoQkBBmG5QvbX6vd463ZIz4N5gXJ+Y4TU3Z9UXI/7x9
 UaYVhWVDcW0AzeNalkbQyujyAYHiYFg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-NHv2zVKhMBW3c0_zI8jbSg-1; Thu, 29 Aug 2024 22:10:49 -0400
X-MC-Unique: NHv2zVKhMBW3c0_zI8jbSg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d5ebec87cdso1442111a91.0
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 19:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724983848; x=1725588648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0y/5lMA5khOX2SxqMDq8TCu5dFNvLtYVvizG5IXQAU=;
 b=hE4nOU9fm0n7UduthvL8I3cA0qvggIVGNa91uD/Gew2cIemY/nZVri0owyoqzNFbA2
 4SwLI+sXU39/92V0Nv0QB+l8FN405z+wpyPzKEkMqWXNCrnvvTlhwb99tm855yxpqSjZ
 ubkSN8FuEKzja6IWXNpCOvGZdQa/TO2VdJPYbPNSvyqi4DDwcIN7tk7lLKVwK8WZt1PE
 0vXatfI6AhPTFLtIqZWGLbXWcPWfgBtEqtFav91Bb78tfIpwDq6dJXWx7rwHGiUfR2sa
 t8FwtNpaIeLYX2IurazmLR6RAIngLdQEtEzkrUM52yVL8Od4bJchbgS7Q4YumYmx/OpP
 Cplg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2AA+NHaieMJKRJKNOBOeV4VlPSAXdSEvmTrKCogA2xtX+C7tDiK2GhQGfJy0tJQx32qQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwxjJugG0ocORjbBot35M/JTe3u1TmjJS6uWyYRN7kTSoUJt14X
 Yv6A+zS006ofm/wzk92PGKBb4ukV3OgRC2IvRbaxP6NpEdP//W5gtl103gfqkyWeGWIPKk9Z52D
 8FY8vVYq5A+117i6W7M8lEFSKWrH8JQbPTTeOzMU0wd41ZPdMg5pPWSvVBfaq2vw7s08imy2/E+
 xn8I3o2eqzxg2OcrbbYkWHvQc=
X-Received: by 2002:a17:90a:460d:b0:2d8:7182:8704 with SMTP id
 98e67ed59e1d1-2d871828751mr260035a91.31.1724983848570; 
 Thu, 29 Aug 2024 19:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9dQxlZo/1qrrz2oDoI3qXx5zn4QN2R4KLVE/3PH9HkH7bJr9rOuw9w/8PNliYa5PtHTFRFmE4KDUKEjqLzfo=
X-Received: by 2002:a17:90a:460d:b0:2d8:7182:8704 with SMTP id
 98e67ed59e1d1-2d871828751mr260016a91.31.1724983848060; Thu, 29 Aug 2024
 19:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
 <20240828224850.GA1773775@pevik>
 <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
 <20240829205007.GA29837@pevik>
 <F46C0EE3-EA5C-45F6-BDE3-C53BFAF65276@oracle.com>
In-Reply-To: <F46C0EE3-EA5C-45F6-BDE3-C53BFAF65276@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 30 Aug 2024 10:10:35 +0800
Message-ID: <CAEemH2dp9_Bq3iE8JDWBMYU1o8ybWjxM5yojBCM7Ss7kmFo5Ow@mail.gmail.com>
To: Chuck Lever III <chuck.lever@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp build broken on Fedora 40?
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMzAsIDIwMjQgYXQgNToyNOKAr0FNIENodWNrIExldmVyIElJSSB2aWEgbHRw
CjxsdHBAbGlzdHMubGludXguaXQ+IHdyb3RlOgo+Cj4KPgo+ID4gT24gQXVnIDI5LCAyMDI0LCBh
dCA0OjUw4oCvUE0sIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPiA+Cj4gPgo+
ID4KPiA+Pj4gT24gQXVnIDI4LCAyMDI0LCBhdCA2OjQ44oCvUE0sIFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PiB3cm90ZToKPiA+Cj4gPj4+IEhpIENodWNrLAo+ID4KPiA+Pj4+IEhpLQo+ID4K
PiA+Pj4+IEknbSBmaW5kaW5nIHRoYXQgbHRwIDIwMjQwNTI0IGRvZXMgbm90IGJ1aWxkIG9uIEZl
ZG9yYSA0MCBkdWUKPiA+Pj4+IHRvIGEgbWlzc2luZyBoZWFkZXI6Cj4gPgo+ID4+PiBJIGd1ZXNz
IHlvdSBuZWVkIHRvIGJhY2twb3J0IGdjYy0xNCBmaXggYjBhZTFlZTIzOSAoInJwY19zdmNfMTog
Rml4IGluY29tcGF0aWJsZQo+ID4+PiBwb2ludGVyIHR5cGUgZXJyb3IiKSBbMV0gKG9yIGJ1aWxk
IHdpdGggb2xkZXIgZ2NjKS4KPiA+Cj4gPj4+PiBsdHAvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2Ut
ZHJpdmVycy90YmlvL3RiaW9fa2VybmVsL2x0cF90YmlvLmM6NDY6MTA6IGZhdGFsIGVycm9yOiBs
aW51eC9nZW5oZC5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Cj4gPj4+PiAgNDYgfCAjaW5j
bHVkZSA8bGludXgvZ2VuaGQuaD4KPiA+Pj4+ICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fgo+ID4+Pj4gY29tcGlsYXRpb24gdGVybWluYXRlZC4KPiA+Cj4gPj4gQnVpbGRpbmcgbHRwIG9u
IGNvbW1pdCBiMGFlMWVlMjM5IGluZGVlZCBmaXhlZCB0aGUgcHJvYmxlbSBvbiBGZWRvcmEgNDAu
Cj4gPj4gSSBndWVzcyB0aGUgImdlbmhkLmgiIGVycm9yIG1pc2RpcmVjdGVkIG1lLiBUaGFua3Ms
IFBldHIhCj4gPgo+ID4gWW91J3JlIHdlbGNvbWUgKHdlIGFwcHJlY2lhdGUgd2hlbiBrZXJuZWwg
bWFpbnRhaW5lcnMgbG9vayBpbnRvIExUUCksCj4gPiBmZWVsIGZyZWUgdG8gYXNrIGlmIHlvdSBl
bmNvdW50ZXIgbW9yZSBwcm9ibGVtcy4KPiA+Cj4gPiBJIHdvdWxkIHNheSBtb3N0bHkgdGhlIGN1
cnJlbnQgbWFzdGVyIGJyYW5jaCBpcyB0aGUgYmVzdCBMVFAsIEkgd291bGQgZmFsbGJhY2sKPiA+
IHRvIHRoZSBsYXRlc3Qgc3RhYmxlIHJlbGVhc2Ugb25seSB3aGVuIG1hc3RlciBkb2VzIG5vdCBi
dWlsZC4KPgo+IEkgdGhpbmsgaW4gZ2VuZXJhbCB3ZSBzdGljayB3aXRoIGEgZml4ZWQgdmVyc2lv
biBvZiB0ZXN0cwo+IHNvIHRoYXQgdGhleSBhcmUgcmVwZWF0YWJsZSBhbmQgZG9uJ3QgY2hhbmdl
IGJlY2F1c2UgdGhlCj4gdGVzdHMgaGF2ZSB1bmV4cGVjdGVkbHkgY2hhbmdlZCByYXRoZXIgdGhh
biBkdWUgdG8gYWN0dWFsCj4gc291cmNlIGNvZGUgYnJlYWthZ2UuCgpZZXMsIGJ1dCBGZWRvcmE0
MCB3YXMgcmVsZWFzZWQgbGF0ZXIgdGhhbiBsdHAtMjAyNDA1MjQsIHRoYXQncyB0aGUKcmVhc29u
IHRoZSBzdGFibGUgTFRQIHlvdSB1c2VkIGRvZXMgbm90IGNvdmVyIHRoZSBjb21waWxlIGZhaWx1
cmUuCgpXZSBkb24ndCBoYXZlIGEgZGVkaWNhdGVkIHBlcnNvbiB0byBtYWludGFpbiBzdGFibGUg
dGVzdCB2ZXJzaW9ucywKd2UganVzdCBkbyBhIHdpZGUgcHJlLXJlbGVhc2UgdGVzdCBmb3IgTFRQ
IChiZWZvcmUgcmVsZWFzZSkgYWdhaW5zdAptb3N0IExpbnV4IGRpc3RyaWJ1dGlvbnMuCgpTbyBm
aW5kIHRoZSBsYXRlc3QgYnJhbmNoIG9mIExUUCBnZW5lcmFsIGNvbnRhaW5zIHRoZSBuZXdlc3Qg
Y2hhbmdlcy9maXhlcy4KCj4KPiBVcGRhdGluZyB0aGUgdGVzdCB2ZXJzaW9uIGlzIHRoZXJlZm9y
ZSBhIG1hbnVhbCBzdGVwLCBidXQKPiB0aGF0IG1lYW5zIHRoZXJlJ3MgYSBicmlnaHQgbGluZSAo
YSBjb21taXQgbWVzc2FnZSBhbmQgc29tZQo+IHRlc3QgcmVzdWx0cyB0aGF0IHNob3cgdGhlIG5l
dyB0ZXN0cyBkb24ndCBpbnRyb2R1Y2UKPiBhbnl0aGluZyB1bmV4cGVjdGVkKS4KPgo+IEl0IHdv
bid0IGJlIGRpZmZpY3VsdCB0byBwdWxsIGIwYWUxZWUyMzkganVzdCBmb3IgbXkKPiBGZWRvcmEg
NDAgc3lzdGVtcyB1bnRpbCB0aGVyZSBpcyBhIHRhZ2dlZCByZWxlYXNlIG9mIGx0cAo+IHdpdGgg
dGhpcyBmaXggYmFrZWQgaW4uIChBcyB5b3Ugbm90aWNlZCwgSSBhbSByZWd1bGFybHkKPiB0ZXN0
aW5nIHRoZSBMVFMga2VybmVscyB0b28sIGFuZCB0aG9zZSBydW4gb2xkZXIgRmVkb3JhCj4gcmVs
ZWFzZXMgd2hpY2ggdXNlIGFuIG9sZGVyIHZlcnNpb24gb2YgZ2NjKS4KPgo+Cj4gPiBBbHNvLCBp
biB5b3VyIGNhc2UsIGZvciBORlMgdGVzdGluZyB5b3UgbmVlZCBqdXN0IHRvIGNvbXBpbGUKPiA+
IHRlc3RjYXNlcy9uZXR3b3JrL25mc3ssdjR9IGRpcmVjdG9yaWVzIGFuZCB0aGVpciBkZXBlbmRl
bmNpZXMKPiA+ICh0ZXN0Y2FzZXMvbGliLyB0ZXN0Y2FzZXMvbmV0d29yay9uZXRzdHJlc3MvKS4K
Pgo+IEp1c3QgdG8gYXZvaWQgYmVpbmcgbXlzdGVyaW91cyBhYm91dCBpdC4uLi4KPgo+IEkgaGF2
ZSBpbnRlZ3JhdGVkIGx0cCBpbnRvIGtkZXZvcHMgWzFdIGFzIGl0cyBvd24gd29ya2Zsb3csCj4g
d2l0aCBzZXZlcmFsIHNlcGFyYXRlbHktZW5hYmxlZCB0ZXN0IGdyb3VwcywgaW5jbHVkaW5nIE5G
UywKPiBSUEMsIGZhbm90aWZ5LCBhbmQgZnMuCj4KPiBUaGUga2Rldm9wcyB3b3JrZmxvdyB0eXBp
Y2FsbHkgYnVpbGRzIGFuZCBpbnN0YWxscyB0aGUgd2hvbGUKPiBzdWl0ZSBpbiBlYWNoIHRlc3Qg
Z3Vlc3QsIHRvIGtlZXAgdGhlIGF1dG9tYXRpb24gc2ltcGxlOwo+IHRoZW4gQW5zaWJsZSBpcyB1
c2VkIHRvIHN0YXJ0IHRoZSBwYXJ0aWN1bGFyIHNldCBvZiB0ZXN0cwo+IHRoYXQgd2Ugd2FudCB0
byBydW4gaW4gdGhhdCB0ZXN0IGdyb3VwLiAoV2UgY291bGQgdHJpbSBkb3duCj4gdGhlIGJ1aWxk
cywgdGhvdWdoISkKPgo+IFRoZSBwb2ludCBvZiBrZGV2b3BzIGlzIHRvIGJlIGEgU3dpc3MgQXJt
eSBrbmlmZSBmb3IgYXV0b21hdGVkCj4gZmlsZSBzeXN0ZW0gdGVzdGluZzsgdGhlc2Ugd29ya2Zs
b3dzIChpbmNsdWRpbmcgbHRwKSBjYW4gcnVuCj4gZm9yIHNldmVyYWwgb3RoZXIgZmlsZSBzeXN0
ZW0gdHlwZXMgaW4gdGhlIGtlcm5lbCBhc2lkZSBmcm9tCj4gTkZTICh0b2RheSwgdGhhdCdzIHhm
cywgZXh0NCwgYnRyZnMsIGFuZCB0bXBmcykuCj4KPiBTbywgY29ycmVjdCwgSSBhbSB1c2luZyBp
dCBmb3IgdXBzdHJlYW0gTkZTIHRlc3RpbmcsIGJ1dCB0aGUKPiBrZGV2b3BzIHdvcmtmbG93IEkg
YnVpbHQgaXMgc3VwcG9zZWQgdG8gYmUgbW9yZSBnZW5lcmljYWxseQo+IHVzZWZ1bC4KPgo+IElu
cHV0IGlzIHdlbGNvbWUgaGVyZTsgdGhlIGx0cCB3b3JrZmxvdyBpcyBwcmV0dHkgZnJlc2gsIHNv
Cj4gbm90IGV2ZXJ5dGhpbmcgaXMgd29ya2luZyAxMDAlIHNtb290aGx5IHlldC4gSXQgd291bGQg
YmUKPiBwcmV0dHkgZWFzeSB0byBhZGQgbW9yZSB0ZXN0IGdyb3VwcyBpZiB5b3UgdGhpbmsgYQo+
IHBhcnRpY3VsYXIgdGVzdCBtaWdodCBiZSB2YWx1YWJsZSBmb3IgdGhlIExpbnV4IGZpbGUgc3lz
dGVtCj4gY29tbXVuaXR5LCBmb3IgZXhhbXBsZS4KPgo+Cj4gLS0KPiBDaHVjayBMZXZlcgo+Cj4g
WzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1rZGV2b3BzL2tkZXZvcHMKPgo+IC0tCj4gTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgoKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
