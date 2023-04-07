Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9DBC6FD1D
	for <ltp@archiver.kernel.org>; Fri,  7 Apr 2023 10:19:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEDEC3CC713
	for <ltp@archiver.kernel.org>; Fri,  7 Apr 2023 12:18:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338033C6C67
 for <ltp@lists.linux.it>; Fri,  7 Apr 2023 12:18:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 56DE91400FA7
 for <ltp@lists.linux.it>; Fri,  7 Apr 2023 12:18:48 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2768D1424;
 Fri,  7 Apr 2023 03:19:30 -0700 (PDT)
Received: from [10.57.58.204] (unknown [10.57.58.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49EF53F762;
 Fri,  7 Apr 2023 03:18:45 -0700 (PDT)
Message-ID: <c766ddbe-f991-9304-0dec-ecf795a788db@arm.com>
Date: Fri, 7 Apr 2023 11:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Edward Liaw <edliaw@google.com>, ltp@lists.linux.it
References: <20230331000747.2294390-1-edliaw@google.com>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <20230331000747.2294390-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setpgid02: use 1 instead of getpgid(1)
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRWR3YXJkLCBMVFAgZm9sa3MsCgpPbiAzMS8wMy8yMDIzIDAxOjA3LCBFZHdhcmQgTGlhdyB2
aWEgbHRwIHdyb3RlOgo+IE9uIEFuZHJvaWQsIGluaXQgZG9lcyBub3Qgc2V0cGdpZCwgc28gZ2V0
cGdpZCgxKSByZXR1cm5zIDAgYW5kIHRoZSB0aGlyZAo+IGNhc2Ugb2Ygc2V0dGluZyBwZ2lkIHRv
IGEgZGlmZmVyZW50IHNlc3Npb24ncyBwcm9jZXNzIGdyb3VwIGRvZXMgbm90Cj4gYmVoYXZlIGFz
IGV4cGVjdGVkOiBzZXRwZ2lkIHRyZWF0cyAwIGFzIHNldHRpbmcgdGhlIHBnaWQgdG8gdGhlIHBp
ZC4KPgo+IEluc3RlYWQsIHJlcGxhY2UgU0FGRV9HRVRQR0lEKDEpIHdpdGggdGhlIGV4cGVjdGVk
IHZhbHVlIG9mIDEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFZHdhcmQgTGlhdyA8ZWRsaWF3QGdvb2ds
ZS5jb20+Cj4gLS0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0cGdp
ZDAyLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBnaWQv
c2V0cGdpZDAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0cGdpZDAy
LmMKPiBpbmRleCA0YjYzYWZlZTguLmJmN2IzMTc2YiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0cGdpZDAyLmMKPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0cGdpZDAyLmMKPiBAQCAtNDQsNyArNDQsNyBAQCBzdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICAgCSAqIEdldHRpbmcgcGdpZCBvZiBpbml0L3N5c3RlbWQg
cHJvY2VzcyB0byB1c2UgaXQgYXMgYQo+ICAgCSAqIHByb2Nlc3MgZ3JvdXAgZnJvbSBhIGRpZmZl
cmVudCBzZXNzaW9uIGZvciBFUEVSTSB0ZXN0Cj4gICAJICovCj4gLQlpbml0X3BnaWQgPSBTQUZF
X0dFVFBHSUQoMSk7Cj4gKwlpbml0X3BnaWQgPSAxOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9p
ZCBydW4odW5zaWduZWQgaW50IG4pCgpUaGUgY2hhbmdlIGxvb2tzIGdvb2QgYW5kIG1ha2VzIHNl
bnNlOgpSZXZpZXdlZC1ieTogVGVvIENvdXByaWUgRGlheiA8dGVvLmNvdXByaWVkaWF6QGFybS5j
b20+CgpIb3dldmVyLCBJIGhhdmUgZW5jb3VudGVyZWQgYW4gaXNzdWUgb24gdGhlIHNhbWUgY2hl
Y2sgb2YgdGhpcyB0ZXN0LCAKdW5yZWxhdGVkIHRvIEVkd2FyZCdzIGlzc3VlLgoKSW5kZWVkLCBv
biBzeXN0ZW1zIHRoYXQgcnVuIHRoZSBzaGVsbCBhcyBQSUQgMSAoZm9yIGV4YW1wbGUgYSBiYXNp
YyAKYnVzeWJveCByb290ZnMpIHRoZSBFUEVSTSBjaGVjayB3b3VsZG4ndCB3b3JrLgpUaGlzIGlz
IGJlY2F1c2UgTFRQIHdvdWxkIHJ1biB3aXRoaW4gdGhlIHNhbWUgc2Vzc2lvbiBJRCBhcyBpbml0
LCB3aGljaCAKd291bGQgYWxsb3cgdGhlIHRlc3QgdG8gY2hhbmdlIHRoZSBQR0lEIGFuZCBub3Qg
dHJpZ2dlciB0aGUgRVBFUk0uCgpJIGFtIHdvcmtpbmcgb24gYSBwYXRjaCBhbmQgd2FudGVkIHRv
IGdldCBzb21lIGlucHV0LiBNeSBjdXJyZW50IGlkZWEgCndvdWxkIGJlIHRvIGZvcmsgYSBjaGls
ZCB0aGF0IHdvdWxkIGNyZWF0ZSBhIG5ldyBzZXNzaW9uIGFuZCB0cnkgdG8Kc2V0cGdpZCgpIHRo
ZSBjaGlsZC4KVGhpcyB3b3VsZCBhbHNvIGFsbG93IHRvIHVzZSB0aGUgbWFpbiBwcm9jZXNzJyBQ
R0lELCBhcyBpdCB3b3VsZCBiZSBpbiAKYW5vdGhlciBzZXNzaW9uIGZyb20gdGhlIGNoaWxkIGFu
eXdheS4gVGhpcyB3b3VsZCByZW1vdmUgdGhlIG5lZWQgdG8KZ2V0cGdpZCgpIGluaXQsIHdoaWNo
IGhvcGVmdWxseSBzaG91bGQgZml4IHlvdXIgaXNzdWUgb24gQW5kcm9pZCBhcyB3ZWxsLgoKSG93
ZXZlciwgdGhpcyBhZGRzIGEgbG90IG1vcmUgY29tcGxleGl0eSBpbiB0aGUgdGVzdDogbmVlZGlu
ZyB0byBmb3JrIAphbmQgc3luY2hyb25pemUgd2l0aCB0aGUgY2hpbGQgYXMgdGhlIG1haW4gcHJv
Y2VzcyBuZWVkcyB0byB3YWl0IGZvciB0aGUKY2hpbGQgdG8gY2hhbmdlIGl0cyBzZXNzaW9uIElE
LCBvdGhlcndpc2UgdGhlIHRlc3Qgd291bGQgZmFpbC4KCkRvIHlvdSB0aGluayB0aGlzIGlkZWEg
bWFrZXMgc2Vuc2UgPyBJIHdvdWxkIHNlbmQgaXQgZm9yIHJldmlldyBvbmNlIEkgCmlyb25lZCBv
dXQgdGhlIHBhdGNoLgpBbm90aGVyIHNvbHV0aW9uIHdvdWxkIGJlIGZvciBMVFAgdG8gY2hhbmdl
IGl0cyBzZXNzaW9uIElEIGJ5IGRlZmF1bHQsIAp3aGljaCB3b3VsZCBwcmV2ZW50IHRoZSBuZWVk
IGZvciBhIGNoYW5nZSB0byBzZXRwZ2lkMDIgb24gdG9wIG9mIEVkd2FyZCdzLgpIb3dldmVyLCBJ
IGRvbid0IGZ1bGx5IHVuZGVyc3RhbmQgdGhlIHBvc3NpYmxlIGNvbnNlcXVlbmNlcyBvZiBoYXZp
bmcgCkxUUCBjaGFuZ2UgaXRzIFNJRCBmb3IgYWxsIHRlc3RzLgoKSGFwcHkgdG8gZGlzY3VzcyBv
ciBzZW5kIGFuIFJGQyBwYXRjaC4KVGhhbmtzIHZlcnkgbXVjaCBpbiBhZHZhbmNlLApUw6lvLUNE
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
