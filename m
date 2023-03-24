Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8C7C6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 14:35:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13A3B3CD220
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 15:35:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 063B33CA503
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 15:34:55 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 09A2F1401104
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 15:34:53 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4792911FB;
 Fri, 24 Mar 2023 07:35:36 -0700 (PDT)
Received: from [10.57.55.5] (unknown [10.57.55.5])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DFD73F71E;
 Fri, 24 Mar 2023 07:34:51 -0700 (PDT)
Message-ID: <76663541-e9bd-a17a-0ebd-ddd4d1eb68dd@arm.com>
Date: Fri, 24 Mar 2023 14:34:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230323160508.672397-2-teo.coupriediaz@arm.com>
 <ZB2PB6adFr+3sYI8@yuki>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <ZB2PB6adFr+3sYI8@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sockioctl: Align buffer to struct ifreq
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

SGkgQ3lyaWwsCgpPbiAyNC8wMy8yMDIzIDExOjUyLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkh
Cj4+IEluIHNldHVwMywgdGhlIGZvbGxvd2luZyBsaW5lIGNhbiBsZWFkIHRvIGFuIHVuZGVmaW5l
ZCBiZWhhdmlvcjoKPj4gICAgaWZyID0gKihzdHJ1Y3QgaWZyZXEgKilpZmMuaWZjX2J1ZjsKPj4K
Pj4gSW5kZWVkLCBhdCB0aGlzIHBvaW50IGl0IGNhbiBiZSBhc3N1bWVkIHRoYXQgaWZjLmlmY19i
dWYgaXMgc3VpdGFibHkKPj4gYWxpZ25lZCBmb3Igc3RydWN0IGlmcmVxLgo+PiBIb3dldmVyLCBp
ZmMuaWZjX2J1ZiBpcyBhc3NpZ25lZCB0byBidWYgd2hpY2ggaGFzIG5vIGFsaWdubWVudAo+PiBj
b25zdHJhaW50cy4gVGhpcyBtZWFucyB0aGVyZSBleGlzdHMgY2FzZXMgd2hlcmUgYnVmIGlzIG5v
dCBzdWl0YWJseQo+PiBhbGlnbmVkIHRvIGxvYWQgYSBzdHJ1Y3QgaWZyZXEsIHdoaWNoIGNhbiBn
ZW5lcmF0ZSBhIFNJR0JVUy4KPj4KPj4gRm9yY2UgdGhlIGFsaWdubWVudCBvZiBidWYgdG8gdGhh
dCBvZiBzdHJ1Y3QgaWZyZXEuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFRlbyBDb3VwcmllIERpYXog
PHRlby5jb3VwcmllZGlhekBhcm0uY29tPgo+PiAtLS0KPj4gQ0kgQnVpbGQ6IGh0dHBzOi8vZ2l0
aHViLmNvbS9UZW8tQ0QvbHRwL2FjdGlvbnMvcnVucy80NTAyMjA0MTMyCj4+Cj4+ICAgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9jdGwvc29ja2lvY3RsMDEuYyB8IDggKysrKysrKy0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9j
dGwwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9jdGwvc29ja2lvY3RsMDEu
Ywo+PiBpbmRleCA0ODYyMzZhZjlkNmIuLmU2M2FhMTkyMTg3NyAxMDA2NDQKPj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9jdGwvc29ja2lvY3RsMDEuYwo+PiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4+IEBAIC01
Miw3ICs1MiwxMyBAQCBzdGF0aWMgc3RydWN0IGlmcmVxIGlmcjsKPj4gICBzdGF0aWMgaW50IHNp
bmxlbjsKPj4gICBzdGF0aWMgaW50IG9wdHZhbDsKPj4gICAKPj4gLXN0YXRpYyBjaGFyIGJ1Zls4
MTkyXTsKPj4gKy8qCj4+ICsgKiBidWYgaGFzIG5vIGFsaWdubWVudCBjb25zdHJhaW50cyBieSBk
ZWZhdWx0LiBIb3dldmVyLCBpdCBpcyB1c2VkIHRvIGxvYWQKPj4gKyAqIGEgc3RydWN0IGlmcmVx
IGluIHNldHVwMywgd2hpY2ggcmVxdWlyZXMgaXQgdG8gaGF2ZSBhbiBhcHByb3ByaWF0ZSBhbGln
bm1lbnQKPj4gKyAqIHRvIHByZXZlbnQgYSBwb3NzaWJsZSB1bmRlZmluZWQgYmVoYXZpb3IuCj4+
ICsgKi8KPj4gK3N0YXRpYyBjaGFyIGJ1Zls4MTkyXQo+PiArCV9fYXR0cmlidXRlX18oKGFsaWdu
ZWQoX19hbGlnbm9mX18oc3RydWN0IGlmcmVxKSkpKTsKPj4gICAKPj4gICBzdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKTsKPj4gICBzdGF0aWMgdm9pZCBzZXR1cDAodm9pZCk7Cj4gTG9va2luZyBhdCB0
aGUgY29kZSwgc2hvdWxkbid0IHdlIHJhdGhlciB0aGFuIHRoYXQgZGVjbGFyZSB0aGUgYnVmZmVy
IGFzCj4gYW4gc3RydWN0IGlmcmVxIGFycmF5LCB0aGF0IHdvdWxkIG5hdHVyYWxseSBhbGlnbiB0
aGUgYnVmZmVyIHdpdGhvdXQgYW55Cj4gbmVlZCBmb3IgdHJpY2t5IF9fYXR0cmlidXRlX18uCl9f
YXR0cmlidXRlX18rX19hbGlnbm9mX18gaXMgcXVpdGUgdW53aWVsZHkgaW5kZWVkLiBJIGtlcHQg
dGhlIGNoYXIqIHRvIAptYXRjaCB0aGUgc3RydWN0IGRlZmluaXRpb24sCmJ1dCBpdCdzIHJlYWxs
eSBqdXN0IHRvIHJlcHJlc2VudCBhIHBvaW50ZXIgdG8gc29tZXRoaW5nLiBJdCdzIG5vdCB1c2Vk
IAphcyBhbnl0aGluZyBlbHNlIGluIHRoZSB0ZXN0IGFueXdheS4KCklmIHlvdSBmZWVsIHRoZXJl
J3Mgbm8gZ29vZCByZWFzb24gdG8ga2VlcCB0aGUgY2hhciogYnVmZiBhbmQgY2FzdCB0byAKdm9p
ZCogZm9yIHRoZSBzeXNjYWxsLApJIGFncmVlIHRoYXQgaXQgd291bGQgYmUgYmV0dGVyLiBJIHRl
c3RlZCBvbiBvdXIgc3lzdGVtIHdoaWNoIGdlbmVyYXRlZCAKdGhlIGZhdWx0IGluaXRpYWxseQph
bmQgaXQgd29ya3MgZmluZSBhcyBleHBlY3RlZC4KCldoYXQgd291bGQgYmUgdGhlIHByb2NlZHVy
ZSBpbiB0aGlzIGNhc2UgPyBTaGFsbCBJIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCAKeW91ciBjaGFu
Z2VzID8KV291bGQgeW91IGp1c3QgYXBwbHkgaXQgb3Igc2VuZCBpdCB5b3Vyc2VsZiA/IEhhcHB5
IHRvIGZvbGxvdyB1cCBob3dldmVyIAppcyBiZXN0LgoKVGhhbmtzIGZvciB0YWtpbmcgdGhlIHRp
bWUgdG8gbG9vayBpbnRvIGl0LApCZXN0IHJlZ2FyZHMKVMOpbwo+Cj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc29ja2lvY3RsL3NvY2tpb2N0bDAxLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4gaW5kZXggNTFkYWM5
YzE2Li4yMDZhNDk5OWUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9z
b2NraW9jdGwvc29ja2lvY3RsMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
c29ja2lvY3RsL3NvY2tpb2N0bDAxLmMKPiBAQCAtNTIsNyArNTIsNyBAQCBzdGF0aWMgc3RydWN0
IGlmcmVxIGlmcjsKPiAgIHN0YXRpYyBpbnQgc2lubGVuOwo+ICAgc3RhdGljIGludCBvcHR2YWw7
Cj4KPiAtc3RhdGljIGNoYXIgYnVmWzgxOTJdOwo+ICtzdGF0aWMgc3RydWN0IGlmcmVxIGJ1Zlsy
MDBdOwo+Cj4gICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKTsKPiAgIHN0YXRpYyB2b2lkIHNldHVw
MCh2b2lkKTsKPiBAQCAtMjE4LDcgKzIxOCw3IEBAIHN0YXRpYyB2b2lkIHNldHVwMih2b2lkKQo+
ICAgICAgICAgIHMgPSBTQUZFX1NPQ0tFVChjbGVhbnVwLCB0ZGF0W3Rlc3Rub10uZG9tYWluLCB0
ZGF0W3Rlc3Rub10udHlwZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgdGRhdFt0ZXN0bm9d
LnByb3RvKTsKPiAgICAgICAgICBpZmMuaWZjX2xlbiA9IHNpemVvZihidWYpOwo+IC0gICAgICAg
aWZjLmlmY19idWYgPSBidWY7Cj4gKyAgICAgICBpZmMuaWZjX2J1ZiA9ICh2b2lkKilidWY7Cj4g
ICB9Cj4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
