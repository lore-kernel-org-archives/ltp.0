Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F2C35FFF
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742558794; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zzjI1Zub/XBGjadAugzO0AEWWpBBE+q3SlMiwCwlvxU=;
 b=qvnW2MXnk8x37FcXI2wMPd3YigYEtGhdeLzWu9mPZTy+UVTRvS+BgeAIIAqESc1mciwKj
 kA9hrFbhYvi4CovB3feFTihJaZrY2BheNVU4VYvnnsxVY8yf30gnlBhcB1Y9q5I3rfC+GxJ
 XiyfCGStBFsSgueCRTPw4wRMyQrnrX4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB2333CA7A3
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 13:06:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 362823CA7A3
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 13:06:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01C6E1000405
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 13:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742558769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XJ/JuhpHDpegcEFDqx9dejcCZ1dqy6D377ACQ3HjbEY=;
 b=Gmz5IFfYtQzHn+vkcq9ogu2nFw1ji2Nyl3oSr1tPSLV8otIhzB+FrLvYc1lOXy7345qEQE
 zV5+73SIdYh52r+x7kuMPTCi9Dq9BbdwVcHVIYvMG+dztb8RMiDVr4nBQAG2UesTo+MMEd
 48yv9ChfKknMQitDGV4FExlBJZUigTg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-C8foemO3Md-UrPmZaX57rA-1; Fri, 21 Mar 2025 08:06:08 -0400
X-MC-Unique: C8foemO3Md-UrPmZaX57rA-1
X-Mimecast-MFC-AGG-ID: C8foemO3Md-UrPmZaX57rA_1742558767
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff8a2c7912so3187642a91.1
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742558766; x=1743163566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XJ/JuhpHDpegcEFDqx9dejcCZ1dqy6D377ACQ3HjbEY=;
 b=C4tC2mzS3k0RpWFqypCN3LFi9NWS+TLg1g369dDSx/a3HCVd5Vs8B0Rbqy0wAJ9reu
 luEhaO60LX2gFYeYlxiHd+HT3PTN2peo5N3mp6CH7Mh5Tq8lIoiiGQ9u3SDzox4VeWx0
 j3IXmyKHkf66sV683d1VGtLEwidarpx+mXXbvb6WwBDAGRjBRChZhPPZgUEX/oASe1Ez
 HUMmKAx+M3JATxgBDTBTLqduWGNSnrAZ6NHBj8jwgKWGWny9kvYqOaU7vgq81dFDZZUB
 8Yy3VQNoLitDoUPBTBU3nGuptioD9fIP8vnYp5qAYqOdquk4G8zr4nnOVYNNaaPF6ghG
 iA/A==
X-Gm-Message-State: AOJu0Yx70D+85NOPhZTarffQUsMOqUc1mc8xicz/QxZ6iraNhVVF8IKU
 MhzkxFB6g/LFJC4fl2uh+AbNB1sNGd/9FObCyVKCY/DYBBuU9aPUTF+QTuWRoFBHCl/uUN/hnmV
 KDoUoH5jSSSjwm9d0b72v7Xc4mBvGSHs/UkMWhjvs12nCqC//ivUuuzUorgXBHqcFxaNMXWLtHf
 F+kJUfRVmOXSZ8WViCvkzSs5A9BQUpFJpdZG2S
X-Gm-Gg: ASbGncuRkcoX9A3ONUsEgc+d6kq5CrucOTFSTudTLgFS6Dcewh23mDMAueiR19ZIZpW
 E7nVLzvlsK0fhAxOdn/WSc7EndJji7uyF/qzSBu5SLiJzqCU83UDQ8d8NXKkKINim1wu/Kr6/tw
 ==
X-Received: by 2002:a17:90b:5824:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-3030eb32170mr5322297a91.5.1742558765765; 
 Fri, 21 Mar 2025 05:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQY0H00MJ3Vs7ooLQYemj+KrpS4ZBe46peF89Bx9XTGjecw2e09DMvIOJtvek+fLwOqhvHec5o7ghKDOJD2gM=
X-Received: by 2002:a17:90b:5824:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-3030eb32170mr5322225a91.5.1742558765075; Fri, 21 Mar 2025
 05:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250321075234.1829966-1-liwang@redhat.com>
 <20250321101830.GA163226@pevik>
In-Reply-To: <20250321101830.GA163226@pevik>
Date: Fri, 21 Mar 2025 20:05:52 +0800
X-Gm-Features: AQ5f1Jq0z_vErygQaK_lVBDgspS2rvhRU7LTBJd0OXeJVp-YZ7cQo84yZfhSYSk
Message-ID: <CAEemH2eiDA2aH_9AfXpsO0YzzKVJWTf7GY80iJuAstyMUxUHmg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iogOenJpOAadw3NOndOS57tMe7_1PtlAzkQUuI-KP5c_1742558767
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_test: Add TCONF when no required filesystems
 are available
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

T24gRnJpLCBNYXIgMjEsIDIwMjUgYXQgNjoxOOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IEN1cnJlbnRseSwgd2hlbiBubyByZXF1aXJlZCBm
aWxlc3lzdGVtcyAoZmlsZXN5c3RlbVtpXS50eXBlKSBhcmUKPiBhdmFpbGFibGUsCj4gPiB0aGUg
dGVzdCBzaWxlbnRseSBkb2VzIG5vdGhpbmcsIGxlYWRpbmcgdG8gYSBtaXNsZWFkaW5nIHRlc3Qg
c3VtbWFyeS4KPgo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgY2hlY2sgdG8gaXNzdWUgVENPTkYgd2hl
biBubyB2YWxpZCBmaWxlc3lzdGVtcyBhcmUKPiBmb3VuZCwKPiA+IGVuc3VyaW5nIGNsZWFyZXIg
dGVzdCByZXN1bHRzLgo+Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+IFRlc3RlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBUaGFua3MhCj4K
PiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiAgICMgLi9pb2N0bF9maWNsb25lMDMKPiA+ICAg
dHN0X2J1ZmZlcnMuYzo1NzogVElORk86IFRlc3QgaXMgdXNpbmcgZ3VhcmRlZCBidWZmZXJzCj4g
PiAgIHRzdF90bXBkaXIuYzozMTc6IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9pb2NTS0xTOWwgYXMg
dG1wZGlyICh0bXBmcwo+IGZpbGVzeXN0ZW0pCj4gPiAgIHRzdF9kZXZpY2UuYzo5OTogVElORk86
IEZvdW5kIGZyZWUgZGV2aWNlIDAgJy9kZXYvbG9vcDAnCj4gPiAgIHRzdF90ZXN0LmM6MTkwMDog
VElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0xNjYtZzE3OTYwZDk1Mgo+ID4gICB0c3RfdGVz
dC5jOjE5MDQ6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA0LjUuMC0wMDAwMi1nMjJiZDMzMmYxMWQ0
ICMxNjIKPiBTTVAgVGh1IE1hciAyMCAxODowMDoxMCBDRVQgMjAyNSB4ODZfNjQKPiA+ICAgdHN0
X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnLy5jb25maWcnCj4g
PiAgIHRzdF90ZXN0LmM6MTcyNDogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBo
IDAwbSAzMXMKPiA+ICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVs
IHN1cHBvcnRzIGV4dDIKPiA+ICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjYyOiBUSU5GTzog
bWtmcy5leHQyIGRvZXMgZXhpc3QKPiA+ICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBU
SU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDMKPiA+ICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5j
OjYyOiBUSU5GTzogbWtmcy5leHQzIGRvZXMgZXhpc3QKPiA+ICAgdHN0X3N1cHBvcnRlZF9mc190
eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDQKPiA+ICAgdHN0X3N1cHBvcnRl
ZF9mc190eXBlcy5jOjYyOiBUSU5GTzogbWtmcy5leHQ0IGRvZXMgZXhpc3QKPiA+ICAgdHN0X3N1
cHBvcnRlZF9mc190eXBlcy5jOjEwNTogVElORk86IFNraXBwaW5nIGJjYWNoZWZzIGJlY2F1c2Ug
b2YgRlVTRQo+IGJsYWNrbGlzdAo+ID4gICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTc6IFRJ
TkZPOiBLZXJuZWwgc3VwcG9ydHMgdmZhdAo+ID4gICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6
NjI6IFRJTkZPOiBta2ZzLnZmYXQgZG9lcyBleGlzdAo+ID4gICB0c3Rfc3VwcG9ydGVkX2ZzX3R5
cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPiA+ICAgdHN0X3N1cHBvcnRl
ZF9mc190eXBlcy5jOjQ5OiBUSU5GTzogbWtmcyBpcyBub3QgbmVlZGVkIGZvciB0bXBmcwo+Cj4g
PiAgIFN1bW1hcnk6Cj4gPiAgIHBhc3NlZCAgIDAKPiA+ICAgZmFpbGVkICAgMAo+ID4gICBicm9r
ZW4gICAwCj4gPiAgIHNraXBwZWQgIDAKPiA+ICAgd2FybmluZ3MgMAo+Cj4gPiBSZXBvcnRlZC1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIGxpYi90c3RfdGVzdC5jIHwgNSArKysr
Kwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+ID4gZGlmZiAtLWdpdCBh
L2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKPiA+IGluZGV4IDM4MjNlYTEwOS4uOWEy
M2NkNGEwIDEwMDY0NAo+ID4gLS0tIGEvbGliL3RzdF90ZXN0LmMKPiA+ICsrKyBiL2xpYi90c3Rf
dGVzdC5jCj4gPiBAQCAtMTg1NSw2ICsxODU1LDcgQEAgc3RhdGljIGludCBydW5fdGNhc2VzX3Bl
cl9mcyh2b2lkKQo+ID4gIHsKPiA+ICAgICAgIGludCByZXQgPSAwOwo+ID4gICAgICAgdW5zaWdu
ZWQgaW50IGk7Cj4gPiArICAgICBib29sIGZvdW5kX3ZhbGlkX2ZzID0gZmFsc2U7Cj4gbml0OiBJ
IHdvdWxkIGNob3NlIHNsaWdodGx5IHNob3J0ZXIgdmFyaWFibGUgbmFtZSAoZS5nLiB0ZXN0ZWQp
LCBidXQKPiB0aGF0J3Mgbm90Cj4gaW1wb3J0YW50Lgo+CgonZm91bmRfdmFsaWRfZnMnIGlzIG1v
cmUgdW5kZXJzdGFuZGFibGUsIEkgbWVyZ2VkIGl0IGludG8gdGhlIG9yaWdpbmFsCnZlcnNpb24u
ClRoYW5rcyBmb3IgeW91ciB0ZXN0aW5nIGFuZCByZXZpZXcuCgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
