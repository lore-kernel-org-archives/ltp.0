Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE1AC369BA
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 04:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744778691; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Je6lDXQ+5A/7qoX8mnnZ1BMmqzQS3/vOkRpgWYXVGdQ=;
 b=KNSnzZ2estUqt1fLkM7V23/lkua8SaeGozRRsRYL7NBOoQwXM6MO4Nf1kzJLYAeE6WEli
 0pBvXtFlD8vrDTMeS3jg5oJTCmRB55esxkYyjETPI0CjlOK1of9ID+LA7wj+xmRA1W51yar
 JpJY2ipDmuysidRUtJqtCyL4ec4ETc0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1700A3CB954
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 06:44:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B984A3CB91D
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 06:44:30 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9B254100048E
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 06:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744778667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h7HSl1HtDkHRUbdCcPj4np/WDA1lYWikfjFp6NpXihA=;
 b=esU64meDP2UowAiBo1gb9/daqDp4jNp2A8R/VY19v81X8Uex3GZDMTgRvKU6L+mgCnRpxX
 Pv6TBogUmhQytNnTHuezl1IF36oqvv9rMRxJTXCu6wiHcPw+dzE8fkN+ELV3e8JdVeexCA
 N09KVGfx2MUVeWSQh1AHRjUPWTAZPQw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-NYDweouLOBKzv99ACZQpSQ-1; Wed, 16 Apr 2025 00:44:25 -0400
X-MC-Unique: NYDweouLOBKzv99ACZQpSQ-1
X-Mimecast-MFC-AGG-ID: NYDweouLOBKzv99ACZQpSQ_1744778664
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff7f9a0b9bso5209932a91.0
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 21:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744778664; x=1745383464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7HSl1HtDkHRUbdCcPj4np/WDA1lYWikfjFp6NpXihA=;
 b=dd8n9Zg5ac5JNL5CkTLXBQWST7UjNFSbtAikdK0a4MLB3sbo9hjDdXunBFLxBLm2wX
 e+p98qWKA+zcVjkIxWuavt35KDZ2uX8elbbI1YtPfjC7jwBYe+hbAajqmAW0hjT9ql4t
 0w7YCu6CnIhi7s2Bm2AG10v81ZnpP775ILrEOnX04BjohuQSFSazvUToZEV68/DoUfwJ
 rslSe/mgi7w6OjtO5+47jjibc6/VmVp/mWRv02u7rtYRe1vouRKwTREiM50L0koUdNUd
 tKUFF3GTK7Q2p9LjoyQgMzbgfcqVHKQSMBLUn8ROJ2jMbU6bEJvRFDTg3zxsox2iIlyd
 lX2g==
X-Gm-Message-State: AOJu0Yz1NnesEXjl2tXAP9anJT83N5ZoCj641xfmqQ0n7RLztWsYhHf1
 3o99CFDnTTe1bfv+NcwcTaIaUIudD3yWpe9Ht1CEiTK7AIRCTYKGmExGV05CxzUBku5AE1ocTbH
 09DGvyB2r9zRJeRe4Oc0snZZg5fMuT2hFOKdPq8FRYcOfZCMiL4qpWNgkt4dztpBX6I1W78kj/1
 ZNeutmhJEMZAq9wKZUm0ewByc=
X-Gm-Gg: ASbGncsdLD3RMH2t2gok5gDeuIOXMa19Y4i9+UAXdgdXoi7lYlO4+NtRERITyX3IQkF
 CcZNCHrqTWKn4rH0u5iflkUefgo9HnBfNp53iCGrRSgQ3BrepF7t1l815k2sDX+OnL88u
X-Received: by 2002:a17:90b:520f:b0:2f4:49d8:e6f6 with SMTP id
 98e67ed59e1d1-30863d201b9mr530723a91.3.1744778664489; 
 Tue, 15 Apr 2025 21:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFme84MXIr06LreehLGsnYZLnZ18TzQ9IeXRbNPrxXvK8o2wcDMfsq6Y0uD95hPuZp+uERnxgwGU0+oRbbzbSM=
X-Received: by 2002:a17:90b:520f:b0:2f4:49d8:e6f6 with SMTP id
 98e67ed59e1d1-30863d201b9mr530704a91.3.1744778664130; Tue, 15 Apr 2025
 21:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250415220845.548155-1-pvorel@suse.cz>
In-Reply-To: <20250415220845.548155-1-pvorel@suse.cz>
Date: Wed, 16 Apr 2025 12:44:11 +0800
X-Gm-Features: ATxdqUE-WEHDAsJi4v-8-KsnPKJHIC67Q72r9hi5FLdDbYUwRSzlmL7i8q6rO1g
Message-ID: <CAEemH2ciYNmtKLz-ZM+wACTQwAvUA=EcOoJNdQprtRxCMA0azA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZotLa7qtT3u8wDJY2IS8v1mqrOQWpL_fhN4C_Wt880E_1744778664
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] tst_cgroup: Add "dmem" cgroup controller
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

SGkgUGV0ciwgQXZpbmVzaCwKCk9uIFdlZCwgQXByIDE2LCAyMDI1IGF0IDY6MDjigK9BTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ICJkbWVtIiBjZ3JvdXAgY29udHJvbGxl
ciBbMV0gd2FzIGFkZGVkIGluIDYuMTQgWzJdLiBBZGQgaXQgdG8gZml4Cj4gY2dyb3VwX3JlZ3Jl
c3Npb25fdGVzdC5zaDoKPgo+IGNncm91cF9yZWdyZXNzaW9uX3Rlc3QgMSBUSU5GTzogVGVzdGVk
IGtlcm5lbDogTGludXggc3VzZXRlc3QKPiA2LjE0LjAtMS1kZWZhdWx0ICMxIFNNUCBQUkVFTVBU
X0RZTkFNSUMgVHVlIE1hciAyNSAwNjoyMzoxOCBVVEMgMjAyNQo+IChhYjk5ZDRjKSB4ODZfNjQg
eDg2XzY0IHg4Nl82NCBHTlUvTGludXgKPiAuLi4KPiBjZ3JvdXBfcmVncmVzc2lvbl90ZXN0IDcg
VEJST0s6ICd0c3RfY2djdGwgcmVxdWlyZScgZXhpdGVkCj4KPiBOZXcgY2dyb3VwIHNob3VsZCBi
ZSB2MiBvbmx5Lgo+Cj4gWzFdIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL25leHQvYWRtaW4tZ3Vp
ZGUvY2dyb3VwLXYyLmh0bWwjZG1lbQo+IFsyXQo+IGh0dHBzOi8va2VybmVsbmV3Ymllcy5vcmcv
TGludXhfNi4xNCNkbWVtX2Nncm91cF9mb3JfYmV0dGVyX2NvbnRyb2xfb2ZfR1BVX21lbW9yeV9y
ZXNvdXJjZXMKPgo+IFJlcG9ydGVkLWJ5OiBBdmluZXNoIEt1bWFyIDxha3VtYXJAc3VzZS5kZT4K
PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgbGli
L3RzdF9jZ3JvdXAuYyB8IDkgKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9saWIvdHN0X2Nncm91cC5jIGIvbGliL3RzdF9jZ3JvdXAu
Ywo+IGluZGV4IDczYjY5NmM1ODguLjBjYjcyODIxMTMgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9j
Z3JvdXAuYwo+ICsrKyBiL2xpYi90c3RfY2dyb3VwLmMKPiBAQCAtODQsNiArODQsNyBAQCBlbnVt
IGNncm91cF9jdHJsX2luZHggewo+ICAgICAgICAgQ1RSTF9NRU1PUlkgPSAxLAo+ICAgICAgICAg
Q1RSTF9DUFUsCj4gICAgICAgICBDVFJMX0NQVVNFVCwKPiArICAgICAgIENUUkxfRE1FTSwKPiAg
ICAgICAgIENUUkxfSU8sCj4gICAgICAgICBDVFJMX1BJRFMsCj4gICAgICAgICBDVFJMX0hVR0VU
TEIsCj4gQEAgLTIwNyw2ICsyMDgsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjZ3JvdXBfZmls
ZSBjcHVzZXRfY3RybF9maWxlc1tdID0KPiB7Cj4gICAgICAgICB7IH0KPiAgfTsKPgo+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGNncm91cF9maWxlIGRtZW1fY3RybF9maWxlc1tdID0gewo+ICsgICAg
ICAgeyAiZG1lbS5jYXBhY2l0eSIsIE5VTEwsIENUUkxfRE1FTSB9LAo+ICsgICAgICAgeyAiZG1l
bS5jdXJyZW50IiwgTlVMTCwgQ1RSTF9ETUVNIH0sCj4KCkl0IGlzIG5vIGhhcm0gdG8gYWRkIG1v
cmUgY3RybF9maWxlcyBsaWtlIGRtZW0ubWF4LCBkbWVtLm1pbiwgZG1lbS5sb3csCndoaWNoIG1p
Z2h0IGJlIHVzZWZ1bCBpbiB0aGUgZnV0dXJlLgoKQW55d2F5LCBsb29rcyBnb29kIHRvIG1lLgoK
VGVzdGVkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IExpIFdh
bmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCgoKPiArICAgICAgIHsgfQo+ICt9Owo+ICsKPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBjZ3JvdXBfZmlsZSBpb19jdHJsX2ZpbGVzW10gPSB7Cj4gICAgICAg
ICB7ICJpby5zdGF0IiwgTlVMTCwgQ1RSTF9JTyB9LAo+ICAgICAgICAgeyB9Cj4gQEAgLTIxOCw2
ICsyMjUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNncm91cF9maWxlIHBpZHNfY3RybF9maWxl
c1tdID0gewo+ICAgICAgICAgeyB9Cj4gIH07Cj4KPiArCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
Y2dyb3VwX2ZpbGUgaHVnZXRsYl9jdHJsX2ZpbGVzW10gPSB7Cj4gICAgICAgICB7IH0KPiAgfTsK
PiBAQCAtMjg5LDYgKzI5Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2dyb3VwX2N0cmwgY29udHJvbGxl
cnNbXSA9IHsKPiAgICAgICAgIENHUk9VUF9DVFJMX01FTUJFUihwZXJmX2V2ZW50LCBDVFJMX1BF
UkZFVkVOVCksCj4gICAgICAgICBDR1JPVVBfQ1RSTF9NRU1CRVIoZGVidWcsIENUUkxfREVCVUcp
LAo+ICAgICAgICAgQ0dST1VQX0NUUkxfTUVNQkVSKHJkbWEsIENUUkxfUkRNQSksCj4gKyAgICAg
ICBDR1JPVVBfQ1RSTF9NRU1CRVIoZG1lbSwgQ1RSTF9ETUVNKSwKPiAgICAgICAgIENHUk9VUF9D
VFJMX01FTUJFUihiYXNlLCBDVFJMX0JBU0UpLAo+ICAgICAgICAgeyB9Cj4gIH07Cj4gLS0KPiAy
LjQ5LjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
