Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50A3CA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 06:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756967385; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7BJb4Bo4tD+sbADtMY9c9sh59NjpexkLofc037KTD5E=;
 b=Dp/YZEd/eeZIWpqi15uwHRyYldSsJiMNWAbxgUlGVQgtIpifFfbxKjpty1NYxyh2xWIrp
 Txmj4GKVlegk5Mx7KgpQtWXYYVv2txeb5ccykcJXBCqws9iv9dro5wRReeGKqf3sIh0sGKJ
 mLOQrEha8jHByQiMRRU6GEV2vSA4O1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 294893CD3E9
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 08:29:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DFBC3CC913
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 08:29:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1030D60048F
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 08:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756967360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYwtSzT3dvPg7xpJRu5It3h57TiKy5MsFZ7S/MpEIv4=;
 b=ZigqgfFJRRIzSbGHJlomYZcOH7mUYZwQV2ggjl/ddif6aw5kX1uHCbFckZB+1w9aNXWlWA
 Z4IhstEQ6FLgZNgDuilSwdbQ/8WzZvpjWj9a8eG7eDCU3REMpl/MvK5gDCy70adf//a/az
 nysovRCsNcgs6j+AZ+BpYCoeIikpJEI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-u3GyaB32P7aC4CTR61lJoA-1; Thu, 04 Sep 2025 02:29:18 -0400
X-MC-Unique: u3GyaB32P7aC4CTR61lJoA-1
X-Mimecast-MFC-AGG-ID: u3GyaB32P7aC4CTR61lJoA_1756967358
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24ae30bd2d0so7790625ad.3
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 23:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756967358; x=1757572158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vYwtSzT3dvPg7xpJRu5It3h57TiKy5MsFZ7S/MpEIv4=;
 b=lr9LXSZA1XB23tQOHe8AgS/3tBHVndk9uAGsbo6BSomxf2T1Ai8gkAOWE2y2yMiZ8q
 vnc8yjD2dDvW+N2C9wijOvIZORs8W2nU1q/hQmc2rAgDGn08fVmRQ4DgFVc9YFK3tS0i
 Lho/a5s348x21LpL96Fkos2hJcqzfJG6J9kfbEVftlicFnkNlcYPeA3Bqp6yogP2kfoA
 pTsDPhZt8ObjY/3Gnb9G1DmctB3qjjbYc3eILDaOzx/tXg3RFfUKVQLkFJICBjDBL6R0
 lNhPodXfrDA15vBx4xW9cePbnRdzvckmgw9Fvp9qp9LMRZzii8j3YV6Daspwhdj06eJZ
 GxAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZubTMomdZw2i7J2vEGJ1Feb293xD79jZ4GI3SQTgGsU1b6/SIPoUBiz4Bxavr4Kij+C4=@lists.linux.it
X-Gm-Message-State: AOJu0YydrL5Zcrb7IdwDTpXSLfwaWZlNPxSMpUu/v1fpI6hHsUpvAm5u
 VwhGEZWyaQwVs6Fp01Y553HGViWeP9agNinCS6Nw8TQ5IU91eQ34f5GVrLF0NqaaqGI0I3QCV85
 KXI5t0RcXk9mdWYBCTooVPyHCht3htFJuR18mqUqMgBcVUbyJDKHiHrPwf4zbkLifQcn4OKL+Zi
 6L27T8b7UXyB40sOgJzY8UPfBRaOY=
X-Gm-Gg: ASbGncs2++Bjp985LvinCjZwYv2O4ljHTNC2r5yukdpM/XSi4PXFWNbkKLB1bMlDsEp
 JquVTioYhxmz0MDhmrprk2J+iyrTYmemWa7iBVRSrhCLY7ykAs0CprzLXA4yVPz/YXdHDqqoezK
 u122fH1j7u/L95onbQdXeLeg==
X-Received: by 2002:a17:903:1a67:b0:24c:b83f:c6bc with SMTP id
 d9443c01a7336-24cb83fcae1mr36906565ad.56.1756967357566; 
 Wed, 03 Sep 2025 23:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfcis9iXNMnK+e8Ra+vgrvJYx7Okaqc4jd8dQADJx2PBa2DjZLYDzTrEkRmuxRtD4mjKd6vwBBYgB2H2XfjMU=
X-Received: by 2002:a17:903:1a67:b0:24c:b83f:c6bc with SMTP id
 d9443c01a7336-24cb83fcae1mr36906265ad.56.1756967357151; Wed, 03 Sep 2025
 23:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com>
 <aLgxmUJ7e05X1seP@yuki.lan> <aLhAj_-gzjmzvOoX@yuki.lan>
 <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
 <CAEemH2dPTgYX3LZ4Ux6YUZ3vuddNsOSoGw=eN-dD=-qOodkLzg@mail.gmail.com>
 <a991f7b9-0493-46e4-b0e2-a3ec284b3e13@suse.com>
In-Reply-To: <a991f7b9-0493-46e4-b0e2-a3ec284b3e13@suse.com>
Date: Thu, 4 Sep 2025 14:29:05 +0800
X-Gm-Features: Ac12FXyRq9XdvIWGuMEFmmPsNBu44XSEUzxj7gukXcG0n7D6-o8QSzdmBMSddOg
Message-ID: <CAEemH2cuVP5n0HuMQBZjXjyL0BLv4=2AfZU+8Y7DtMjRyPx0KA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FyCCdBbX-tUBetgIofvrAZIoBmFAuzGEf0KHnSyAuG0_1756967358
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCAxOjQy4oCvUE0gQW5kcmVhIENlcnZlc2F0byA8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbT4Kd3JvdGU6Cgo+IEhpIExpLAo+IE9uIDkvNC8yNSA1OjA2IEFN
LCBMaSBXYW5nIHdyb3RlOgo+Cj4KPgo+IE9uIFRodSwgU2VwIDQsIDIwMjUgYXQgMTA6MznigK9B
TSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4gSGkgQ3lyaWwsIEFuZHJl
YSwKPj4KPj4gT24gV2VkLCBTZXAgMywgMjAyNSBhdCA5OjIw4oCvUE0gQ3lyaWwgSHJ1YmlzIDxj
aHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+Pgo+Pj4gSGkhCj4+PiA+ID4gQWZ0ZXIgYW4gYW5hbHlz
aXMgd2UgYXJlIG5vdyBzdXJlIHRoYXQgaXQncyBub3QgYSBwcm9kdWN0IGJ1ZyBidXQgYQo+Pj4g
dGVzdAo+Pj4gPiA+IGlzc3VlLiBUaGVyZSBtaWdodCBiZSBhIG5lZWQgdG8gZmFsbGJhY2sgdGhl
IHBhdGNoIGlmIHdlIGNhbid0IGZpeAo+Pj4gdGhlCj4+PiA+ID4gdGVzdCBiZWZvcmUgcmVsZWFz
ZS4gQExpIFdEWVQ/Cj4+Cj4+ID4KPj4+ID4gVHJ5IHRoaXM6Cj4+PiA+Cj4+PiA+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFs
bC5jCj4+PiBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3NjaGVkX2Zvb3RiYWxsL3NjaGVkX2Zv
b3RiYWxsLmMKPj4+ID4gaW5kZXggMDYxN2JkYjg3Li4wZDY0MjEwYjAgMTAwNjQ0Cj4+PiA+IC0t
LSBhL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3NjaGVkX2Zvb3RiYWxsL3NjaGVkX2Zvb3RiYWxs
LmMKPj4+ID4gKysrIGIvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJhbGwvc2No
ZWRfZm9vdGJhbGwuYwo+Pj4gPiBAQCAtMTE1LDggKzExNSw4IEBAIHZvaWQgcmVmZXJlZShpbnQg
Z2FtZV9sZW5ndGgpCj4+PiA+ICAgICAgICAgbm93ID0gc3RhcnQ7Cj4+PiA+Cj4+PiA+ICAgICAg
ICAgLyogU3RhcnQgdGhlIGdhbWUhICovCj4+PiA+IC0gICAgICAgdHN0X2F0b21pY19zdG9yZSgw
LCAmdGhlX2JhbGwpOwo+Pj4gPiAgICAgICAgIHB0aHJlYWRfYmFycmllcl93YWl0KCZzdGFydF9i
YXJyaWVyKTsKPj4+ID4gKyAgICAgICB0c3RfYXRvbWljX3N0b3JlKDAsICZ0aGVfYmFsbCk7Cj4+
PiA+ICAgICAgICAgYXRyYWNlX21hcmtlcl93cml0ZSgic2NoZWRfZm9vdGJhbGwiLCAiR2FtZV9z
dGFydGVkISIpOwo+Pj4gPgo+Pj4gPgo+Pj4gPiBXZSBoYXZlIHRvIGJlIHN1cmUgdGhhdCB0aGUg
ZGVmZW5zZSBoYXMgc3RhcnRlZCBiZWZvcmUgd2UgY2xlYXIgdGhlCj4+PiA+IGJhbGwuIFByZXZp
b3VzbHkgd2UgaGFkIHRoZSBsb29wIHRoYXQgd2FpdGVkIGZvciB0aGUgcGxheWVycyB0byBiZQo+
Pj4gcmVhZHkKPj4+ID4gYmVmb3JlIHdlIGNhbGxlZCByZWZlcmVlKCkgZnVuY3Rpb24gc28gYWxs
IHRoZSBwbGF5ZXJzIHdlcmUgcmVhZHkgd2hlbgo+Pj4gPiB3ZSBjbGVhcmVkIGl0Lgo+Pj4KPj4+
IFVmZiBhbmQgd2UgaGF2ZSB0byBnZXQgdGhlIGZpbmFsIGJhbGwgcG9zaXRpb24gYmVmb3JlIHdl
IHN0b3AgdGhlCj4+PiB0aHJlYWRzIGFzIHdlbGwsIG90aGVyd2lzZSB0aGVyZSBpcyBhbHdheXMg
Y2hhbmNlLCB0aGF0IHdlIG1heSBlbmQgdXAKPj4+IG1vdmluZyB0aGUgYmFsbCByaWdodCBhZnRl
ciB0aGUgaGlnaCBwcmlvcml0eSBkZWZlbmNlIHRocmVhZHMgaGFzIGJlZW4KPj4+IHN0b3BwZWQ6
Cj4+Pgo+Pgo+PiBUaGlzIG1ha2VzIHNlbnNlISBIb3dldmVyLCBmcm9tIG15IGV4dGVuc2l2ZSB0
ZXN0aW5nLCBJIHN0aWxsIHNlZQo+PiBvY2Nhc2lvbmFsIGZhaWxzIG9uIEtWTS9EZWJ1ZyBwbGF0
Zm9ybXMuCj4+Cj4+IEkgc3VzcGVjdCB0aGUgZXhpc3RpbmcgYmFycmllcnMgZW5zdXJlIGFsbCB0
aHJlYWRzIGFyZSBjcmVhdGVkIGJlZm9yZQo+PiB0aGUgZ2FtZSBzdGFydHMsIGJ1dCBzbWFsbCBz
Y2hlZHVsZXIgc2tld3MgY2FuIHN0aWxsIGFsbG93IHRoZSBhdHRhY2tpbmcKPj4gdGhyZWFkIHRv
IHJ1biBmb3IgYSBmZXcgY3ljbGVzIGJlZm9yZSB0aGUgZGVmZW5kaW5nIHRocmVhZCBtaWdyYXRl
cywKPj4gZXNwZWNpYWxseSBvbiBkZWJ1Zy9SVCBrZXJuZWxzLgo+Pgo+Cj4gU29ycnkgdHlwbywg
UlQgLS0+IG5vbi1SVCBrZXJuZWxzLgo+Cj4gU2luY2UgcmVndWxhciBrZXJuZWxzIHVzZSB0aGUg
Q0ZTIHNjaGVkdWxlciwgd2hpY2ggaXMgbW9yZSBsaWtlbHkgdG8KPiBoYXZlIHN1Y2ggZGV2aWF0
aW9ucywgSSB0aG91Z2h0IGl0IHdvdWxkIGJlIGJldHRlciB0byBydW4gdGhpcyB0ZXN0IHVzaW5n
Cj4gdGhlIFJUIGtlcm5lbC4KPgo+IEFmdGVyIGxvb2tpbmcgeW91ciB0ZXN0IGpvYiwgaXQgYXBw
ZWFycyB0aGF0IDYuMTYuMy0xLWRlZmF1bHQgaXMgYSBzdG9jawo+IGtlcm5lbCwKPiBzbyBJJ20g
bm90IHN1cnByaXNlZCBieSB0aGUgZmFpbHVyZS4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5n
Cj4KPiBJIHNlZSwgYXJlIHlvdSBwbGFubmluZyB0byBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoZSB0
ZXN0Pwo+CgpZZXMsIEkgd2lsbCBzZW5kIGEgc3RyZW5ndGhlbmVkIHBhdGNoIGJhc2VkIG9uIEN5
cmlsJ3MgbWV0aG9kLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
