Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20F8E95A91
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 09:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 726053C8AD2
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 11:49:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A27723C8B61
 for <ltp@lists.linux.it>; Sat,  7 Oct 2023 10:58:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB4C91A01991
 for <ltp@lists.linux.it>; Sat,  7 Oct 2023 10:58:30 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2269160BB5;
 Sat,  7 Oct 2023 08:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3BDC433C7;
 Sat,  7 Oct 2023 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1696669107;
 bh=63/dX8Mo5xru8ooy9lCm1E4eme6V3fkD4TYeT7/GxT8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l1i/NIDAMmZft2wxUCk+uo6l9YM0hOIgb4Ksq3nEmXl7j8swBvb1Th5UI1cO+oYFi
 Mgc3JIhYrOjNZIIjl/JaMbWo7w5X+M7j/N9LdJ3OWL3toXnmtH2hC/t3/sP57Rit/R
 g7QNjJ1hxzMZrMDUM8TmaY7ZVatkHKPDyQsOCEAk=
Date: Sat, 7 Oct 2023 10:58:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Message-ID: <2023100755-livestock-barcode-fe41@gregkh>
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 09 Oct 2023 11:49:17 +0200
Subject: Re: [LTP] [PATCH 6.1 000/259] 6.1.56-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 Olga Kornievskaia <kolga@netapp.com>, stable@vger.kernel.org, shuah@kernel.org,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, srw@sladewatkins.net,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LTP List <ltp@lists.linux.it>, linux-nfs@vger.kernel.org,
 Eryu Guan <eguan@redhat.com>, rwarsow@gmx.de, pavel@denx.de,
 linux-kernel@vger.kernel.org, conor@kernel.org, sudipm.mukherjee@gmail.com,
 Benjamin Coddington <bcodding@redhat.com>, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBPY3QgMDYsIDIwMjMgYXQgMTI6NDI6MDRQTSAtMDYwMCwgRGFuaWVsIETDrWF6IHdy
b3RlOgo+IEhlbGxvIQo+IAo+IE9uIFRodSwgNSBPY3QgMjAyMyBhdCAxMDo0MCwgTmFyZXNoIEth
bWJvanUgPG5hcmVzaC5rYW1ib2p1QGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gT24gV2VkLCA0IE9j
dCAyMDIzIGF0IDIzOjQxLCBHcmVnIEtyb2FoLUhhcnRtYW4KPiA+IDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPiA+Cj4gPiA+IFRoaXMgaXMgdGhlIHN0YXJ0IG9mIHRoZSBz
dGFibGUgcmV2aWV3IGN5Y2xlIGZvciB0aGUgNi4xLjU2IHJlbGVhc2UuCj4gPiA+IFRoZXJlIGFy
ZSAyNTkgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywgYWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVz
cG9uc2UKPiA+ID4gdG8gdGhpcyBvbmUuICBJZiBhbnlvbmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0
aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UKPiA+ID4gbGV0IG1lIGtub3cuCj4gPiA+Cj4gPiA+
IFJlc3BvbnNlcyBzaG91bGQgYmUgbWFkZSBieSBGcmksIDA2IE9jdCAyMDIzIDE3OjUxOjEyICsw
MDAwLgo+ID4gPiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRpbWUgbWlnaHQgYmUgdG9v
IGxhdGUuCj4gPiA+Cj4gPiA+IFRoZSB3aG9sZSBwYXRjaCBzZXJpZXMgY2FuIGJlIGZvdW5kIGlu
IG9uZSBwYXRjaCBhdDoKPiA+ID4gICAgICAgICBodHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi9s
aW51eC9rZXJuZWwvdjYueC9zdGFibGUtcmV2aWV3L3BhdGNoLTYuMS41Ni1yYzEuZ3oKPiA+ID4g
b3IgaW4gdGhlIGdpdCB0cmVlIGFuZCBicmFuY2ggYXQ6Cj4gPiA+ICAgICAgICAgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUt
cmMuZ2l0IGxpbnV4LTYuMS55Cj4gPiA+IGFuZCB0aGUgZGlmZnN0YXQgY2FuIGJlIGZvdW5kIGJl
bG93Lgo+ID4gPgo+ID4gPiB0aGFua3MsCj4gPiA+Cj4gPiA+IGdyZWcgay1oCj4gPgo+ID4gUmVz
dWx0cyBmcm9tIExpbmFyb+KAmXMgdGVzdCBmYXJtLgo+ID4gUmVncmVzc2lvbnMgb24gYXJtNjQg
YmNtMjcxMS1ycGktNC1iIGRldmljZSBydW5uaW5nIExUUCBkaW8gdGVzdHMgb24KPiA+IE5GUyBt
b3VudGVkIHJvb3Rmcy4KPiA+IGFuZCBMVFAgaHVnZXRsYiBodWdlbW1hcDExIHRlc3QgY2FzZSBm
YWlsZWQgb24geDg2IGFuZCBhcm02NCBiY20yNzExLXJwaS00LWIuCj4gPgo+ID4gUmVwb3J0ZWQt
Ynk6IExpbnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4KPiA+
Cj4gPiBMVFAgaHVnZXRsYiB0ZXN0cyBmYWlsZWQgbG9nCj4gPiAgIHRzdF9odWdlcGFnZS5jOjgz
OiBUSU5GTzogMSBodWdlcGFnZShzKSByZXNlcnZlZAo+ID4gICB0c3RfdGVzdC5jOjE1NTg6IFRJ
TkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDVtIDAwcwo+ID4gICBodWdlbW1hcDExLmM6NDc6
IFRGQUlMOiBNZW1vcnkgbWlzbWF0Y2ggYWZ0ZXIgRGlyZWN0LUlPIHdyaXRlCj4gPgo+ID4gTFRQ
IGRpbyB0ZXN0cyBmYWlsZWQgbG9nCj4gPiAgIGNvbXBhcmVfZmlsZTogY2hhciBtaXNtYXRjaDog
aW5maWxlIG9mZnNldCA0MDk2OiAweDAxIC4gICBvdXRmaWxlCj4gPiBvZmZzZXQgNDA5NjogMHgw
MCAuCj4gPiAgIGRpb3Rlc3QwMSAgICAxICBURkFJTCAgOiAgZGlvdGVzdDEuYzoxNTg6IGZpbGUg
Y29tcGFyZSBmYWlsZWQgZm9yCj4gPiBpbmZpbGUgYW5kIG91dGZpbGUKPiAKPiBCaXNlY3Rpb24g
bGVkIHRvICJORlM6IEZpeCBPX0RJUkVDVCBsb2NraW5nIGlzc3VlcyIgKHVwc3RyZWFtIGNvbW1p
dAo+IDdjNjMzOTMyMmNlMGM2MTI4YWNiZTM2YWFjYzFlZWI5ODZkZDdiZjEpLiBSZXZlcnRpbmcg
dGhhdCBwYXRjaCBhbmQKPiAiTkZTOiBGaXggZXJyb3IgaGFuZGxpbmcgZm9yIE9fRElSRUNUIHdy
aXRlIHNjaGVkdWxpbmciICh1cHN0cmVhbQo+IGNvbW1pdCA5NTQ5OThiNjBjYWE4ZjJhM2JmM2Fi
ZTQ5MGRlNmYwOGQyODM2ODdhKSAobm90IGEgY2xlYW4gcmV2ZXJ0Cj4gdGhpcyBvbmUpIG1hZGUg
bHRwLWRpbyBwYXNzIGFnYWluLgoKU28gdGhpcyBpcyBhbHNvIGFuIGlzc3VlIGluIExpbnVzJ3Mg
dHJlZT8gIE9yIGlzIGl0IG9ubHkgb24gdGhlIDYuMS55CnRyZWUuCgp0aGFua3MsCgpncmVnIGst
aAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
