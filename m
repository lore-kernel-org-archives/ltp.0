Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C726D262B0
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 07:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768980385; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9BWDsFCyT4ZqVXDEE2+AjHJk6dA1M945qHANV9XKJNY=;
 b=LXGFwyB8tRP4JVlOdUdN+GZ/daJasjwgVwYVA1pb2oyCzTZB167cV4PlaW2lXQBbdsSJZ
 rszVpYS4ZQ0+zrsKcD/SYGc0iqSFpAJ/SKyrvJ3My/ykf2biLo5YSi/GRQaz3fwbIQGjnK0
 JbMMjCZQD71XEmkci4G4KrmW28kSSfU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D9983CB05E
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 08:26:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76D753CA67C
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 08:26:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D2CB1400044
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 08:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768980358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBxxNbGmz18HN+G9NHcDnbvalsRAYf0TPaXZwEBv5To=;
 b=g4bVKSR9pPYagutljtjzQnZAt/JxdM7YeGLr0gdkGkqy03nRCzyCj5tHDDLHZCGFx/iqZc
 sf/SXEFMW5Fv2FMLRp5UiPTszaLjelkpUW3m/P6qhH0m6R+u2muy3VNnxuuwlSzzZqgqRz
 UFvRd8lMYz1Ain/++3+adLnnjlt+C7g=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-boB1ilFhPgOrVBzuoB3pRQ-1; Wed, 21 Jan 2026 02:25:56 -0500
X-MC-Unique: boB1ilFhPgOrVBzuoB3pRQ-1
X-Mimecast-MFC-AGG-ID: boB1ilFhPgOrVBzuoB3pRQ_1768980356
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b6a8afb513so7342135eec.0
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 23:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768980356; x=1769585156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eBxxNbGmz18HN+G9NHcDnbvalsRAYf0TPaXZwEBv5To=;
 b=QGJC57VfoRJJrTOZ5I24gczhKU4Q04OJw9p8vKhboiniKAJk1W74na77Q+MbBS21Qw
 1JwT1i5av3kGceEbtbrGagKVRlix8h5i6hTQxZhVU9/UOAb4HXvIciS4A62m10hgKHug
 f14uwPj0C5xAVE9PCCmD129af609cYS9wqnmLZmkQ/oPhn7LGLGOBRNbM6LN0HxBWS9n
 C6w5WTu0AtV4GeplaWenzHyVw/dybyfU9/xbeHeksFP0Qv4S9wjN9nORYoCGCCgOqYvv
 s/zMqbJxxHDGdzeZpYOV6Uy1Nb6CByX8sTbZYSarZbMmz1Cjjid9i0cb5izuVP+jiYvG
 eWVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTS8P4OuQUZTHGVWOJ4gKWaMURyAr5kujvLkIsUS75UpLJHGRL8i/8Ij000VtntLoHbA=@lists.linux.it
X-Gm-Message-State: AOJu0Yw4P7JS61qt6qYu6EUx46JS9v7kFN1QRmfv12FnukRBvp2VPlVz
 MhU1OPjA7s9Ci3kmtlxg8O3l+RRaA3b61rTlX68+MlSe+bJF/j7V1xaR5sCMXLkle6FJWYUArWo
 TYJ0qgJg3SjHpcY3/NJCz55At0carcFltNrmY94IdNjmEciOjpaB3QUlY2ieKK/w/4F0CqFJ0OG
 T6PrtVTUygsWeY8yoXar5aLtgHiG0=
X-Gm-Gg: AZuq6aJXnKwRlZyihXSmGESEJjeJE3knrh13g4r8mn1JNsIDIKTbs0etq1o9+mD99K0
 gPLAUk4XNIkH1hil8OoBlRlLs4K4OocZE2N8gzzvf+OdlScRV+iRudpxvGHYwqQnFFMfbUzRmkV
 Ri7RH5psN60WN+bISbb83CH55vbcOc3c0WPwStPF2XjsE4TnmdkCV4ICByjBaTqi5YoyQ=
X-Received: by 2002:a05:7300:a889:b0:2b7:1abc:a6e9 with SMTP id
 5a478bee46e88-2b71abca8d3mr82518eec.12.1768980355603; 
 Tue, 20 Jan 2026 23:25:55 -0800 (PST)
X-Received: by 2002:a05:7300:a889:b0:2b7:1abc:a6e9 with SMTP id
 5a478bee46e88-2b71abca8d3mr82506eec.12.1768980355202; Tue, 20 Jan 2026
 23:25:55 -0800 (PST)
MIME-Version: 1.0
References: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
 <CAEemH2edx23hnGmxW=EsapU0cgESGt1mws+GC-yCHFSN3ZVp9Q@mail.gmail.com>
 <aXBRli319H7PaOJj@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aXBRli319H7PaOJj@autotest-wegao.qe.prg2.suse.org>
Date: Wed, 21 Jan 2026 15:25:42 +0800
X-Gm-Features: AZwV_QjlH4-2zWQIL4WbdKGq7o20Pe4cwBPIoZGh6WtS22DWcwlUyBZ_gaGXnAA
Message-ID: <CAEemH2cJ1B=UK=7f8W65X79eQxzRwtAH8O9OvP-_GQMPuXDBPw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yQMczA7nb7db7Y4g9-EDO4a_ne4a6hrc6zanNpSm-A0_1768980356
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone10.c failed on 32bit compilation
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

V2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgoKPiA+IFdlbGwsIHRoaXMgaW5kaWNhdGVz
IHRoYXQgdGhlIENoaWxkIGRvZXMgbm90IHN3aXRjaCB0byBpdHNlbGYgVExTCj4gPiBjb3JyZWN0
bHksIHN0aWxsIHVzZSB0aGUgcGFyZW50LCBhbmQgc28gdGhlICdfX3RocmVhZCB0bHNfdmFyJyB2
YWx1ZQo+ID4gZ2V0cyBtb2RpZmllZC4KPiA+Cj4gPiBXaXRoIHR3byBkYXlzIG9mIHJlc2VhcmNo
LCBJIHJvdWdobHkgZHJldyB0aGUgcGljdHVyZSBvZiB0aGUgcG9zc2libGUKPiA+IHJlYXNvbiBh
cyBiZWxvdzoKPiA+Cj4gPiBVc2luZyBhIG5ha2VkIGNsb25lKCkgdG8gdmVyaWZ5IHRoYXQgQ0xP
TkVfU0VUVExTIGlzIHVucmVsaWFibGUKPiA+IHdoZW4gcnVubmluZyAzMi1iaXQgb24geDg2XzY0
LCBzaW5jZSBpMzg2IFRMUyByZXF1aXJlcyB0d28gc3RlcHM6Cj4gPiB3cml0aW5nIHRoZSBkZXNj
cmlwdG9yIGFuZCBzd2l0Y2hpbmcgdGhlIHNlbGVjdG9yLCBidXQgQ0xPTkVfU0VUVExTCj4gPiBv
bmx5IG92ZXJyaWRlcyB0aGUgZm9ybWVyOgo+ID4KPiA+IFRoaXMgaXMgdGhlIHNpbXBsaWZpZWQg
Y2FsbCBjaGFpbjoKPiA+Cj4gPiBrZXJuZWxfY2xvbmUoKQo+ID4gICAgY29weV9wcm9jZXNzKCkK
PiA+ICAgICAgIGNvcHlfdGhyZWFkKCkKPiA+ICAgICAgICAgICBzZXRfbmV3X3RscygpCj4gPiAg
ICAgICAgICAgICAgZG9fc2V0X3RocmVhZF9hcmVhKCkKPiA+Cj4gPiBJbiBjb3B5X3RocmVhZCgp
LCB0aGUgY2hpbGTigJlzIHJlZ2lzdGVyIGZyYW1lIGlzIGNvcGllZCBmcm9tIHRoZSBwYXJlbnQK
PiA+ICpjaGlsZHJlZ3MgPSAqY3VycmVudF9wdF9yZWdzKCk7IGFuZCBvbiB0aGUgMzItYml0IHNp
ZGUgaXQgYWxzbyBkb2VzCj4gPiBzYXZlc2VnbWVudChncywgcC0+dGhyZWFkLmdzKTsgc2F2aW5n
IHRoZSBjdXJyZW50ICVncyBpbnRvIHRocmVhZF9zdHJ1Y3QuCj4gPgo+ID4gVG9nZXRoZXIsIHRo
aXMgbWVhbnMgdGhhdCB1bmxlc3Mgc29tZXRoaW5nIGV4cGxpY2l0bHkgb3ZlcndyaXRlcyBpdCBs
YXRlciwKPiA+IHRoZSBjaGlsZOKAmXMgaW5pdGlhbCAlZ3Mgc2VsZWN0b3IgaXMgaW5oZXJpdGVk
IGZyb20gdGhlIHBhcmVudC4KPiA+Cj4gPiAgIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y2LjE4L3NvdXJjZS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jI0wyNDMKPiA+Cj4gPiBU
aGVuLCBpbiBkb19zZXRfdGhyZWFkX2FyZWEoKSwgdGhlIGtlcm5lbCB1cGRhdGVzIHRoZSBUTFMg
ZGVzY3JpcHRvcgo+ID4gc2V0X3Rsc19kZXNjKHAsIGlkeCwgJmluZm8sIDEpOyBIb3dldmVyLCB3
aGVuIChwICE9IGN1cnJlbnQpLCB0aGUgeDg2XzMyIHBhdGgKPiA+IGRvZXMgbm90IHVwZGF0ZSBv
ciByZWZyZXNoIGFueSBzZWdtZW50IHNlbGVjdG9yLiBTbyBpdCB1cGRhdGVzIHRoZSBkZXNjcmlw
dG9yCj4gPiBidXQgZG9lcyBub3Qgc3dpdGNoIHRoZSBjaGlsZOKAmXMgJWdzIHNlbGVjdG9yIHRv
IHRoZSBuZXcgbW9kaWZpZWRfc2VsLgo+ID4KPiA+ICAgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuMTgvc291cmNlL2FyY2gveDg2L2tlcm5lbC90bHMuYyNMMTUwCj4gPgo+ID4g
VGhlcmVmb3JlLCByZWx5aW5nIG9uIENMT05FX1NFVFRMUyBhbG9uZSBjYW4gbGVhdmUgdGhlIGNo
aWxkIGV4ZWN1dGluZwo+ID4gd2l0aCB0aGUgcGFyZW504oCZcyAlZ3Mgc2VsZWN0b3IsIHNvIFRM
UyBhY2Nlc3NlcyBzdGlsbCByZXNvbHZlIHRvIHRoZQo+ID4gb2xkIFRMUyBiYXNlLgo+ID4KPiA+
IEluIHN1bW1hcnksIGlmIHRoaXMgYW5hbHlzaXMgaXMgbWFrZSBzZW5zZSwgd2UgbmVlZCB0byBj
b25maWd1cmUgdGhlIFRDT05GCj4gPiB0ZXN0IGJyYW5jaCBza2lwIG9uIGkzODYuCj4KPiBZb3Vy
IGFuYWx5c2lzIGlzIGNvcnJlY3Qgd2hlbiB3ZSB1c2UgMTMgYXMgdGxzX2Rlc2MtPmVudHJ5X251
bWJlci4gSWYgd2UKPiBub3QgY2hhbmdlIGtlcm5lbCBsb2dpYyAoZm9yY2Ugc3dpdGNoIGNoaWxk
J3MgJWdzIHRvIHBvaW5nIGdkdCAxMyBlbnRyeSB0aGVuCj4gd2UgY2FuIG5vdCB0ZXN0IHRoaXMg
ZmVhdHVyZSkuCgpXaGVuIHdlIGFsbG9jYXRlIGEgbmV3IFRMUyBlbnRyeSAoZS5nLiwgMTMpIGFu
ZCBkb27igJl0IGFjdHVhbGx5CnN3aXRjaCAlZ3MgdG8gaXQsIHRoYXQncyBub3QgYnJlYWtpbmcg
YW55dGhpbmcsIHVzZXIgc3BhY2UgY29udGludWVzCnRvIHJ1biB3aXRoIHRoZSBvcmlnaW5hbCAl
Z3MsIHNvIGl0IHN1cnZpdmVzLgoKCj4gU28gY29ycmVjdCBzb2x1dGlvbiBpcyBub3QgY3JlYXRl
IG5ldyBHRFQgVExTIGVudHJ5IGJ1dCByZXVzZSBleGlzdAoKTm8sIHdlIHNob3VsZG4ndCBkbyB0
aGlzIGZvciBjbG9uZTEwLgoKVGhlIHB1cnBvc2Ugb2YgY2xvbmUxMCBpcyB0byB0ZXN0IHRoYXQg
dGhlIGNsb25lZCBjaGlsZCBwcm9jZXNzIHdpbGwKY3JlYXRlIGEgbmV3IFRMUyBhcmUgYW5kIHZl
cmlmeSB0aGF0IGl0IGlzIGRpZmZlcmVudCBmcm9tIHRoZSBwYXJlbnQncy4KCj4gZW50cnksIGJ5
IGRlZmF1bHQgcGFyZW50IHdpbGwgdXNlIEdEVF9FTlRSWV9UTFNfTUlOIHdoaWNoIG51bWJlciBp
cyAxMi4KPiBTbyB3ZSBjbG9uZSB3aXRoIHRsc19kZXNjLT5lbnRyeV9udW1iZXIgdG8gMTIgYW5k
IE9OTFkgY2hhbmdlCj4gdGxzX2Rlc2MtPmJhc2VfYWRkciwgd2hlbiBzd2l0Y2ggdG8gY2hpbGQg
JWdzIHN0aWxsIHNhbWUgYnV0IEdEVAo+IG51bWJlciAxMiBlbnRyeSBhbHJlYWR5IHVwZGF0ZWQg
YnkgbmV3IGJhc2VfYWRkci4gQnV0IG5vdyBpIGVuY291bnRlciBzdHJhbmdlCj4gU0lHU0VHViBl
cnJvciB3aGVuIHN3aXRjaCB0byBjaGlsZCwgbm8gaWRlYSB3aHkuCgpJZiB5b3UgcmV1c2UgdGhl
IGN1cnJlbnRseSBhY3RpdmUgZW50cnkgKG9mdGVuIDEyKSBhbmQgY2hhbmdlIG9ubHkKdGhlIGRl
c2NyaXB0b3IgYmFzZSwgeW91IGFyZSBlZmZlY3RpdmVseSBjaGFuZ2luZyBHUy5iYXNlIHdoaWxl
IGtlZXBpbmcKJWdzIHRoZSBzYW1lLiBUaGF0IG1lYW5zIGFsbCBleGlzdGluZyBUTFMgcmVmZXJl
bmNlcyBub3cgbGFuZCBhdCBhCmRpZmZlcmVudCBiYXNlLCBhbG1vc3QgY2VydGFpbmx5IG5vdCBh
IHZhbGlkIFRDQiwgc28geW91IGNyYXNoIHF1aWNrbHkuCgoKPiBCVFc6IGlmIHdlIHVzZSBwdXJl
IDMyYml0IHdlIHNob3VsZCByZXN1c2UgZW50cnlfbnVtYmVyIHRvIDYsIHNvIGJhc2ljbHkKPiBp
biBjb2RlIHdlIHNob3VsZCBmaXJzdCB1c2UgX19OUl9nZXRfdGhyZWFkX2FyZWEgZ2V0IGN1cnJl
bnRseSB1c2luZwo+IGVudHJ5X251bWJlci4KPgo+IEkgYWdyZWUgd2UgY2FuIHNraXAgdGVzdCBv
biBpMzg2IGZpcnN0bHkgc2luY2Ugd2UgYXJlIGN1cnJlbnRseSBzdGlsbCBub3Qgc3VwcG9ydAo+
IGluIHRoaXMgdGVzdCBjYXNlLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
