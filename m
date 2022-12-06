Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1804C352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 14:46:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D4103CC1A0
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 15:46:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BB503CC161
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 15:45:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 1D52E100035D
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 15:45:44 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95AEA23A;
 Tue,  6 Dec 2022 06:45:49 -0800 (PST)
Received: from [10.57.37.186] (unknown [10.57.37.186])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C36E3F73B;
 Tue,  6 Dec 2022 06:45:42 -0800 (PST)
Message-ID: <fe1c5bac-0ed1-92ef-3c28-e3758dc3465d@arm.com>
Date: Tue, 6 Dec 2022 14:45:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Petr Vorel <pvorel@suse.cz>
References: <20221206122604.212528-1-teo.coupriediaz@arm.com>
 <20221206140421.GB21839@pevik>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <20221206140421.GB21839@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/brk: add direct syscall tst_variant
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIDA2LzEyLzIwMjIgMTQ6MDQsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgVGVv
LAo+Cj4+IERpcmVjdCB1c2FnZSBvZiBicmsgaXMgZGlzY291cmFnZWQgaW4gZmF2b3Igb2YgdXNp
bmcgbWFsbG9jLiBBbHNvLCBicmsgd2FzCj4+IHJlbW92ZWQgZnJvbSBQT1NJWCBpbiBQT1NJWC4x
LTIwMDEuCj4+IEluIHBhcnRpY3VsYXIsIHRoZSBNdXNsIGxpYmMncyBicmsgYWx3YXlzIHJldHVy
bnMgLUVOT01FTSB3aGljaCBjYXVzZXMKPj4gdGhlIExUUCB0ZXN0cyB0byBleGl0IHByZW1hdHVy
ZWx5LiBJbnZva2luZyB0aGUgc3lzY2FsbCBkaXJlY3RseSBhbGxvd3MKPj4gdGhlbSB0byBwcm9w
ZXJseSB2YWxpZGF0ZSBicmsgYmVoYXZpb3IuIEFkZCBhIG5ldyB0ZXN0IHZhcmlhbnQgaGFuZGxp
bmcgaWYKPj4gdGhlIGxpYmMgd3JhcHBlcnMgYXJlIG5vdCBpbXBsZW1lbnRlZCBhbmQgdGVzdGlu
ZyB0aGUgZGlyZWN0IHN5c2NhbGwuCj4+IFVzZSB0c3Rfc3lzY2FsbCgpIGFuZCBoYW5kbGUgdGhl
IGZhaWx1cmUgY2FzZXMgb3Vyc2VsdmVzLCBhcwo+PiB3ZSBkb24ndCBkZXBlbmQgb24gdGhlIGxp
YmMgdG8gZG8gaXQgYW55bW9yZS4KPj4gVGhlIHBhdGNoIGFsc28gd29ya3MgYXJvdW5kIHRoZSBk
ZXBlbmRlbmN5IG9uIHNicmsgdG8gZ2V0IHRoZSBjdXJyZW50IGJyZWFrCj4+IGFzIGl0IGhhcyB0
aGUgc2FtZSBpc3N1ZXMuIEluc3RlYWQsIGNhbGwgdHN0X3N5c2NhbGwoX19OUl9icmssIDApIHdo
aWNoCj4+IGFsd2F5cyByZXR1cm5zIHRoZSBjdXJyZW50IGJyZWFrLgo+PiBVcGRhdGUgYnJrMDEg
dG8gdXNlIHZvaWQqIHRvIHVuaWZ5IGl0IHdpdGggYnJrMDIuCj4gVGhhdCBicm91Z2h0IHdhcm5p
bmdzLCBzZWUgYmVsb3cuCj4KPiAuLi4KPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9icmsvYnJrMDIuYwo+PiBAQCAtMTQsMjQgKzE0LDUxIEBACj4+ICAgI2luY2x1ZGUgPHVuaXN0
ZC5oPgo+PiAgICNpbmNsdWRlIDxzeXMvbW1hbi5oPgo+PiAgICNpbmNsdWRlICJ0c3RfdGVzdC5o
Igo+PiArI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPj4gKwo+PiAraW5saW5lIHZvaWQgKmJy
a192YXJpYW50cyh2b2lkICphZGRyKQo+PiArewo+PiArCXZvaWQgKmJya19hZGRyOwo+PiArCWlm
ICh0c3RfdmFyaWFudCkgewo+PiArCQlicmtfYWRkciA9ICh2b2lkICopdHN0X3N5c2NhbGwoX19O
Ul9icmssIGFkZHIpOwo+PiArCX0gZWxzZSB7Cj4+ICsJCWJya19hZGRyID0gKHZvaWQgKilicmso
YWRkcik7Cj4gTk9URSB1c2luZyBwb2ludGVyIGZvciBicmsoKSBpcyBwcm9ibGVtYXRpYywgdGhl
cmUgYXJlIGNvbXBsYWluczoKPgo+IGJyazAyLmM6IEluIGZ1bmN0aW9uIOKAmGJya192YXJpYW50
c+KAmToKPiBicmswMi5jOjI2OjI4OiB3YXJuaW5nOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRl
Z2VyIG9mIGRpZmZlcmVudCBzaXplCj4gWy1XaW50LXRvLXBvaW50ZXItY2FzdF0KPiAgICAgMjYg
fCAgICAgICAgICAgICAgICAgYnJrX2FkZHIgPSAodm9pZCAqKWJyayhhZGRyKTsKPiAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4KPiBOb3Qgc3VyZSBob3cgdG8gZml4
IHRoaXMuIFByb2JsZW0gaXMgaW4gYm90aCBDIGZpbGVzLCBvbiBzZXZlcmFsIHBsYWNlcy4KCkFo
IHllcywgb2YgY291cnNlLiBUaGF0J3MgbXkgbWlzdGFrZTogSSBqdXN0IHJlYWxpemVkIHRoYXQg
SSB1c2VkIHRoZSAKbGliYyBicmsgYXMgaWYgaXQgcmV0dXJuZWQgdGhlIGJyZWFrLCBidXQgaXQg
ZG9lc24ndC4gSXQganVzdCByZXR1cm5zIGFuIAplcnJvciwgc28gdGhlIHdhcm5pbmcgaXMganVz
dGlmaWVkIChhbmQgYSBkcm93bmVkIGluIG90aGVyIG1lc3NhZ2VzIGZyb20gCm15IGJ1aWxkIHN5
c3RlbSkuCgpJJ2xsIHJld29yayBhbmQgY2hhbmdlIHRoYXQsIEkgYmVsaWV2ZSBpdCB3aWxsIHdv
cmsgd2l0aG91dCB3YXJuaW5ncyAKb25jZSBpdCBpcyBwcm9wZXJseSB1c2VkLgoKPiBUaGVyZSBh
cmUgYWxzbyBjb2RlIHN0eWxlIHByb2JsZW1zICh5b3UgY2FuIHNlZSBpdCB3aGVuIHJ1bm5pbmcg
bWFrZSBjaGVjayBpbgo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYnJrLyksIGJ1dCB0aGF0
J3MgYSBtaW5vciBkZXRhaWwuCkkgd2Fzbid0IGF3YXJlIG9mIHRoYXQsIGdvb2QgdG8ga25vdyB0
aGFua3MgISBJIHdpbGwgdGFrZSBjYXJlIG9mIGl0IGFzIAp3ZWxsLgo+IEtpbmQgcmVnYXJkcywK
PiBQZXRyClRoYW5rcyBmb3IgZ2l2aW5nIGl0IGEgbG9vaywKVMOpbwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
