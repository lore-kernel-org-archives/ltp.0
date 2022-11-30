Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35242C433FE
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 12:49:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E147D3CC52E
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:49:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C22CA3C6D55
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 13:49:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 7B1C31000A47
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 13:49:15 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEAE4D6E;
 Wed, 30 Nov 2022 04:49:19 -0800 (PST)
Received: from [10.57.37.211] (unknown [10.57.37.211])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7C2A3F73D;
 Wed, 30 Nov 2022 04:49:12 -0800 (PST)
Message-ID: <573ed22b-d091-d8c0-1c50-36a5568510ab@arm.com>
Date: Wed, 30 Nov 2022 12:49:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Petr Vorel <pvorel@suse.cz>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y4UMUqkLijWXOWu6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/1] brk: use direct syscalls
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

T24gMjgvMTEvMjAyMiAxOTozMCwgUGV0ciBWb3JlbCB3cm90ZToKCj4+IEhlbGxvIExUUCBtYWlu
dGFpbmVycywKPj4gVGhpcyBwYXRjaCBzbGlnaHRseSByZXdvcmtzIHRoZSBicmswMSBhbmQgYnJr
MDIgdGVzdHMgdG8gdXNlIGRpcmVjdAo+PiBzeXNjYWxscyB3aXRoIHRzdF9zeXNjYWxsIHJhdGhl
ciB0aGFuIGNhbGxpbmcgdGhyb3VnaCB0aGUgbGliYy4KPj4gV2hpbGUgcnVubmluZyBMVFAgb24g
YSBtdXNsLWJhc2VkIGRpc3RyaWJ1dGlvbiwgd2Ugbm90aWNlZCB0aGF0IHRoZSBicmsKPj4gdGVz
dHMgd2VyZSBmYWlsaW5nLiBJdCB0dXJucyBvdXQgdGhhdCBNdXNsIHByZXZlbnRzIHRoZSB1c2Ug
b2YgYnJrCj4+IHdpdGggdGhlaXIgd3JhcHBlcjogaXQgYWx3YXlzIHJldHVybnMgYW4gZXJyb3Iu
Cj4+IFRoaXMgaXNuJ3QgdG9vIGVncmVnaW91cyBhcyB1c2luZyBicmsgaXMgZGVwcmVjYXRlZCBp
biBmYXZvciBvZiBtYWxsb2MKPj4gYW5kIGl0IGlzbid0IHBhcnQgb2YgUE9TSVggYW55bW9yZSBz
aW5jZSBQT1NJWC4xLTIwMDEsIGJ1dCBpdCBfaXNfCj4+IGRpZmZlcmVudCBmcm9tIGdsaWJjJ3Mg
YmVhdmlvciwgd2hpY2ggYWxsb3dzIHVzaW5nIGl0Lgo+PiBUaGlzIHBhdGNoIGFsbG93cyBwcm9w
ZXIgdGVzdGluZyBvZiBicmsncyBmdW5jdGlvbmFsaXR5LCBpbmRlcGVuZGVudCBvZgo+PiBsaWJj
IHNwZWNpZmljcywgYW5kIHRodXMgYWxsb3dzIHRoZSB0ZXN0cyB0byBwYXNzIG9uIE11c2wtYmFz
ZWQKPj4gZGlzdHJpYnV0aW9ucyBsaWtlIEFscGluZS4KPj4gRG8geW91IHRoaW5rIHRoaXMgaXMg
YSBjb3JyZWN0IGFwcHJvYWNoIGZvciBMVFAgPwo+PiAgRnJvbSB3aGF0IEkgY291bGQgc2VlIHRo
ZXJlIGFyZSBhIGZldyB0ZXN0cyB0aGF0IHVzZSB0c3Rfc3lzY2FsbCBkaXJlY3RseQo+PiBhbmQg
aXQgZG9lc24ndCBhZmZlY3QgdGhlIGxvZ2ljIG11Y2ggZm9yIGJyay4KPiBMR1RNLgpUaGFua3Mg
Zm9yIGhhdmluZyBhIGxvb2sgIQo+Cj4gSSB3b25kZXIgaWYgaXQgbWFrZXMgc2Vuc2UgdG8gYWRk
IC50ZXN0X3ZhcmlhbnRzIFsxXSBmb3IgZ2xpYmMgYW5kIHVjbGliYywKPiBlLmcuIGZvciBicmsw
MSgpOgo+Cj4gdm9pZCB2ZXJpZnlfYnJrKHZvaWQpCj4gewo+IAlpZiAodHN0X3ZhcmlhbnQpIHsK
PiAJCXRzdF9yZXMoVElORk8sICJUZXN0aW5nIHNicmsoKSIpOwo+IAkJY3VyX2JyayA9ICh1aW50
cHRyX3Qpc2JyaygwKTsKPiAJfSBlbHNlIHsKPiAJCXRzdF9yZXMoVElORk8sICJUZXN0aW5nIF9f
TlJfYnJrIik7Cj4gCQljdXJfYnJrID0gKHZvaWQgKil0c3Rfc3lzY2FsbChfX05SX2JyaywgMCk7
Cj4gCX0KPgo+IH0KCkkgZ3Vlc3MgSSBjYW4gc2VlIGhvdyBpdCBjb3VsZCBiZSB1c2VmdWwsIGJ1
dCBMVFAgYWxyZWFkeSBoYXMgdGVzdHMgZm9yIApzYnJrOiBzaG91bGQgdGhlcmUgcmVhbGx5IGJl
IHRlc3RpbmcgZm9yIHNicmsgaW4gdGhlIGJyayB0ZXN0cyA/CgpJIHdpbGwgc2VuZCBhbm90aGVy
IHJlcGx5IGRvd24gdGhlIHRocmVhZCByZWdhcmRpbmcgdGhlIHJlc3Qgb2YgdGhlIApkaXNjdXNz
aW9uICEKCkJlc3QgcmVnYXJkcywKVMOpbwoKPgo+IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+
IAkuLi4KPiAjaWZkZWYgX19HTElCQ19fCj4gCS50ZXN0X3ZhcmlhbnRzID0gMiwKPiAjZWxzZQo+
IAkudGVzdF92YXJpYW50cyA9IDEsCj4gI2VuZGlmCj4gCS4uLgo+Cj4gTm90IHN1cmUgaWYgaXQg
c2hvdWxkIGJlIHRlc3RlZWQgYWxzbyBvbiBhbmRyb2lkLCBpLmU6Cj4gI2lmIGRlZmluZWQoX19H
TElCQ19fKSB8fCBkZWZpbmVkKF9fQU5EUk9JRF9fKQo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIK
Pgo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL0Mt
VGVzdC1BUEkjMTMwLXRlc3Rpbmctc2ltaWxhci1zeXNjYWxscy1pbi1vbmUtdGVzdAo+Cj4+IEdy
ZWVuIGJ1aWxkOgo+PiBodHRwczovL2dpdGh1Yi5jb20vVGVvLUNEL2x0cC9hY3Rpb25zL3J1bnMv
MzU2MzE5MzUwNwo+PiBUaGlzIHdhcyBkaXNjb3ZlcmVkIGluIHRoZSBjb250ZXh0IG9mIHRoZSBN
b3JlbGxvIHByb2plY3RbMF0uCj4+IFswXTogaHR0cHM6Ly93d3cubW9yZWxsby1wcm9qZWN0Lm9y
Zy8KPj4gVGVvIENvdXByaWUgRGlheiAoMSk6Cj4+ICAgIHN5c2NhbGxzL2JyazogdXNlIGRpcmVj
dCBzeXNjYWxsCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9icmsvYnJrMDEuYyB8IDE1
ICsrKysrKy0tLS0tLS0tLQo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYnJrL2JyazAy
LmMgfCAxNCArKysrKystLS0tLS0tLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMTcgZGVsZXRpb25zKC0pCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
