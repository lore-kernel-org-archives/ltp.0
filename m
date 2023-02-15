Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05220C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2799A3CBF1D
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 16:35:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 455153CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:35:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 8FA61600BE3
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:35:02 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E7C1042;
 Wed, 15 Feb 2023 07:35:44 -0800 (PST)
Received: from [10.1.196.169] (unknown [10.1.196.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32493F881;
 Wed, 15 Feb 2023 07:35:00 -0800 (PST)
Message-ID: <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
Date: Wed, 15 Feb 2023 15:34:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
References: <20230215144225.25008-1-mdoucha@suse.cz> <Y+z4MNO+jwydz1w8@pevik>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y+z4MNO+jwydz1w8@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: Fix tst_syscall() return value
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKT24gMTUvMDIvMjAyMyAxNToyMCwgUGV0ciBWb3JlbCB3cm90ZToKPiBIaSBhbGws
Cj4KPj4gVGhlIG1vZGlmeV9sZHQoKSBzeXNjYWxsIHJldHVybnMgMzItYml0IHNpZ25lZCBpbnRl
Z2VyIHZhbHVlLiBSZWNlbnQgY2hhbmdlcwo+PiBpbiB0c3Rfc3lzY2FsbCgpIGNhdXNlZCB0aGUg
dmFsdWUgdG8gYmUgaW50ZXJwcmV0ZWQgYXMgdW5zaWduZWQgb24gb2xkZXIKPj4ga2VybmVscy9n
bGliYywgd2hpY2ggYnJlYWtzIHRoZSBjdmUtMjAxNS0zMjkwIHRlc3QuIEFkZCBleHBsaWNpdCB0
eXBlIGNhc3QKPj4gdG8gZml4IGl0Lgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KPgo+IFRoaXMgaXMgY2F1c2VkIGJ5IGU1ZDJhMDVhOSAoInJlZ2VuLnNoOiBVc2Ug
aW50cHRyX3QgZm9yIHRzdF9zeXNjYWxsIHJldHVybiIpCj4gd2hpY2ggY2hhbmdlZCByZXR1cm5p
bmcgdHN0X3JldCBmcm9tIGludCB0byBpbnRwdHJfdCAod2hpY2ggaXMgYWxzbyBpbnQgZm9yIDMy
Cj4gYml0IGFyY2hzLCBidXQgbG9uZyBmb3IgNjQgYml0IGFyY2hzKS4gVGhpcyBjb21taXQgaXMg
YWxzbyBuZWVkZWQsIHRodXMgSSBkb24ndAo+IHN1Z2dlc3QgdG8gcmV2ZXJ0IGl0LCBidXQgSSB3
b25kZXIgaG93IG1hbnkgb3RoZXIgdGVzdHMgaXQgYnJva2UuCgpJIHNlbnQgdGhlIHRzdF9zeXNj
YWxsIHJldHVybiBwYXRjaC4gSSBkaWQgc29tZSB0ZXN0aW5nIHdpdGggd2hhdCBzeXN0ZW1zIEkK
aGFkIGF2YWlsYWJsZSB3aGVuIHdvcmtpbmcgb24gaXQgYW5kLCBhdCB0aGUgdGltZSwgZGlkbid0
IHNlZSBhbnkgCnJlZ3Jlc3Npb25zLAppbmNsdWRpbmcgZm9yIGN2ZS0yMDE1LTMyOTAuCgpIb3dl
dmVyIHRoaXMgd2FzIHdpdGggZmFpcmx5IHJlY2VudCBrZXJuZWxzIGFuZCBsaWJjcywgYW5kIGFj
Y29yZGluZyB0byAKTWFydGluCnRoZSB0ZXN0IGZhaWxlZCBmb3IgdGhlbSBvbiBhbiBvbGRlciBj
b21iaW5hdGlvbi4KCkkgc2hhcmVkIHRoZSB0ZXN0IHN1aXRlWzBdIEkgdGVzdGVkIHRoZSBwYXRj
aCB3aXRoLCBjb250YWluaW5nIGFsbCB0aGUgCnVzZXMgSSBmb3VuZC4KSXQgbWlnaHQgYmUgd29y
dGh3aGlsZSB0byBydW4gaXQgb24gYSBzeXN0ZW0gd2hlcmUgd2Ugbm93IGtub3cgb25lIG9mIAp0
aGUgdGVzdHMKd2FzIGFmZmVjdGVkID8gSG9wZWZ1bGx5LCBub25lIG1vcmUsIGJ1dCBoYXZpbmcg
YSByZXN1bHQgd291bGQgYmUgYmV0dGVyLgoKQmVzdCByZWdhcmRzLApUw6lvCgpbMF06IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDIyLU5vdmVtYmVyLzAzMTY0MC5odG1s
Cgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91
Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4+IC0tLQo+PiAgIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUt
MzI5MC5jIHwgMyArKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYyBi
L3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jCj4+IGluZGV4IGY2MWQyODA5Yi4uYTJhOGZj
ZWRkIDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+PiArKysg
Yi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+PiBAQCAtMTk1LDcgKzE5NSw4IEBAIHN0
YXRpYyB2b2lkIHNldF9sZHQodm9pZCkKPj4gICAJCS51c2VhYmxlCSA9IDAKPj4gICAJfTsKPj4g
LQlURVNUKHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgMSwgJmRhdGFfZGVzYywgc2l6ZW9m
KGRhdGFfZGVzYykpKTsKPj4gKwlURVNUKChpbnQpdHN0X3N5c2NhbGwoX19OUl9tb2RpZnlfbGR0
LCAxLCAmZGF0YV9kZXNjLAo+PiArCQlzaXplb2YoZGF0YV9kZXNjKSkpOwo+PiAgIAlpZiAoVFNU
X1JFVCA9PSAtRUlOVkFMKSB7Cj4+ICAgCQl0c3RfYnJrKFRDT05GIHwgVFJFUlJOTywKPj4gICAJ
CQkibW9kaWZ5X2xkdDogMTYtYml0IGRhdGEgc2VnbWVudHMgYXJlIHByb2JhYmx5IGRpc2FibGVk
Iik7CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
