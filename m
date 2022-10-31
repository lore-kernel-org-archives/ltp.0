Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD854FA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 17:19:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50E453CAA11
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 18:19:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 878433C08D9
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 18:19:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id DD7F41A007FD
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 18:19:26 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09A7A1FB;
 Mon, 31 Oct 2022 10:19:31 -0700 (PDT)
Received: from [10.57.8.25] (unknown [10.57.8.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E0C53F703;
 Mon, 31 Oct 2022 10:19:24 -0700 (PDT)
Message-ID: <99c55c0c-1f51-5282-6198-dbcb6d919ea3@arm.com>
Date: Mon, 31 Oct 2022 17:18:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221027163654.414017-1-teo.coupriediaz@arm.com>
 <20221027163654.414017-2-teo.coupriediaz@arm.com> <Y1/Oh4VCUiUSFIvK@yuki>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y1/Oh4VCUiUSFIvK@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] regen.sh: Use intptr_t for tst_syscall
 return
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

SGVsbG8sCgpPbiAzMS8xMC8yMDIyIDEzOjMyLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkhCj4+
IFNvbWUgc3lzY2FsbHMgZGlyZWN0bHkgcmV0dXJuIHBvaW50ZXJzLCBsaWtlIGJyayBvciBtbWFw
LiBpbnQgaXMgY3VycmVudGx5Cj4+IHVzZWQgZm9yIHRoZSByZXR1cm4gdmFsdWUgaW4gdHN0X3N5
c2NhbGwgYnV0IGlzIG5vdCBsYXJnZSBlbm91Z2gKPj4gdG8gZ3VhcmFudGVlIHRoYXQgc3VjaCBh
IHJldHVybmVkIHZhbHVlIHdpbGwgZml0Lgo+PiBJbnN0ZWFkLCB1c2UgaW50cHRyX3Qgd2hpY2gg
aXMgZ3VhcmFudGVkIHRvIGJlIGNhc3RhYmxlIHRvICh2b2lkICopCj4+IHdpdGhvdXQgbG9zcyBv
ZiBkYXRhLgo+IFNvdW5kcyByZWFzb25hYmxlLCBnbGliYyBzeXNjYWxsIHJldHVybnMgbG9uZyBi
dXQgSSBndWVzcyB0aGF0J3MgYmVjYXVzZQo+IHRoZXJlIHdhcyBubyBpbnRwdHJfdCB3aGVuIHRo
YXQgd2FzIGludHJvZHVjZWQuCj4KPj4gU2lnbmVkLW9mZi1ieTogVGVvIENvdXByaWUgRGlheiA8
dGVvLmNvdXByaWVkaWF6QGFybS5jb20+Cj4+IC0tLQo+PiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxs
cy9yZWdlbi5zaCB8ICAgMiArLQo+PiAgIHJ1bnRlc3QvY2hlY2tfdHN0X3N5c2NhbGwgICAgICB8
IDE5MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDE5MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHJ1bnRlc3QvY2hlY2tfdHN0X3N5c2NhbGwKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGFwaS9zeXNjYWxscy9yZWdlbi5zaCBiL2luY2x1ZGUvbGFwaS9zeXNjYWxscy9yZWdlbi5zaAo+
PiBpbmRleCAzYmYzOGZkMDMuLjk3MDI3ZTJmMyAxMDA3NTUKPj4gLS0tIGEvaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL3JlZ2VuLnNoCj4+ICsrKyBiL2luY2x1ZGUvbGFwaS9zeXNjYWxscy9yZWdlbi5z
aAo+PiBAQCAtNDgsNyArNDgsNyBAQCBjYXQgPDwgRU9GID4gIiR7b3V0cHV0X3BpZH0iCj4+ICAg
I2VuZGlmCj4+ICAgCj4+ICAgI2RlZmluZSB0c3Rfc3lzY2FsbChOUiwgLi4uKSAoeyBcXAo+PiAt
CWludCB0c3RfcmV0OyBcXAo+PiArCWludHB0cl90IHRzdF9yZXQ7IFxcCj4+ICAgCWlmIChOUiA9
PSBfX0xUUF9fTlJfSU5WQUxJRF9TWVNDQUxMKSB7IFxcCj4+ICAgCQllcnJubyA9IEVOT1NZUzsg
XFwKPj4gICAJCXRzdF9yZXQgPSAtMTsgXFwKPj4gZGlmZiAtLWdpdCBhL3J1bnRlc3QvY2hlY2tf
dHN0X3N5c2NhbGwgYi9ydW50ZXN0L2NoZWNrX3RzdF9zeXNjYWxsCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMC4uN2E2MDAzNTkzCj4+IC0tLSAvZGV2L251bGwKPj4g
KysrIGIvcnVudGVzdC9jaGVja190c3Rfc3lzY2FsbAo+IEkgZG8gbm90IHRoaW5rIHRoYXQgd2Ug
c2hvdWQgYWRkIHRoaXMgZmlsZSwgYXQgbGVhc3Qgbm90IGluIHRoaXMgY29tbWl0Cj4gYW5kIHdp
dGhvdXQgYW55IGdvb2QgZGVzY3JpcHRpb24uCgpJIGFncmVlLCBJIHdvdWxkbid0IHdhbnQgdG8g
bWVyZ2UgaXQuCkFzIG1lbnRpb25lZCBpbiB0aGUgY292ZXIsIEkgd2FudGVkIHRvIHNoYXJlIHRo
ZSBsaXN0IG9mIHRlc3RzIEkgaGF2ZSAKdGVzdGVkIHRoZSBwYXRjaCB3aXRoLApib3RoIGZvciBw
ZW9wbGUgdG8gdGVzdCB0aGVtc2VsdmVzIGlmIHRoZXkgd2FudCB0byBhbmQgYXMgYSB3YXkgdG8g
YXNrIAppZiB0aGVyZSB3YXMgYW55dGhpbmcgSSBtaXNzZWQKd2hpbGUgdGVzdGluZyB3aXRoIHRo
YXQuCkkgZGlkbid0IHJlYWxseSBrbm93IGhvdyB0byBzaGFyZSB0aGlzLCBzbyBJIGFkZGVkIGl0
IGFzIHBhcnQgb2YgdGhlIApjb21taXQgZm9yIHRoZSBSRkMuIE1heWJlIGl0IHdvdWxkCmZpdCBi
ZXR0ZXIgYXMgcGFydCBvZiB0aGUgY292ZXIgbGV0dGVyID8gT3IgYWZ0ZXIgdGhlIGNvbW1pdCBk
ZXNjcmlwdGlvbiAKd2l0aCB0aGUgc2hvcnRsb2cgPwpJdCBtaWdodCBiZSBiZXR0ZXIgcmVtb3Zl
ZCBhbHRvZ2V0aGVyIGFuZCBwZW9wbGUgY2FuIHRlc3Qgd2l0aCBhIGxhcmdlciAKc2NvcGUgYW55
d2F5ICEKClRoYW5rcyBmb3IgaGF2aW5nIGEgbG9vaywKQmVzdCByZWdhcmRzClTDqW8gQ291cHJp
ZSBEaWF6CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
