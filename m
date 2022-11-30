Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DCFC4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:43:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A654C3CC522
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:43:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D79AE3CC504
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:43:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 6BC631400DD5
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:43:14 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B8DD6E;
 Wed, 30 Nov 2022 05:43:19 -0800 (PST)
Received: from [10.57.40.140] (unknown [10.57.40.140])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C900F3F73D;
 Wed, 30 Nov 2022 05:43:11 -0800 (PST)
Message-ID: <b90f144e-4165-0192-a3ac-59edf6712374@arm.com>
Date: Wed, 30 Nov 2022 13:43:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221129130350.219082-1-tudor.cretu@arm.com>
 <87a649ubuq.fsf@suse.de> <Y4YQL2TezOp2dcnD@pevik>
 <eff8f05f-fd4b-4cad-86bc-d039aab0a56a@arm.com> <Y4YiL/Os2G+cZMFp@pevik>
From: Tudor Cretu <tudor.cretu@arm.com>
In-Reply-To: <Y4YiL/Os2G+cZMFp@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] safe_macros: Fix undefined behaviour in
 vararg handling
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

CgpPbiAyOS0xMS0yMDIyIDE1OjE1LCBQZXRyIFZvcmVsIHdyb3RlOgo+IAo+IAo+PiBPbiAyOS0x
MS0yMDIyIDEzOjU5LCBQZXRyIFZvcmVsIHdyb3RlOgo+Pj4gSGkgYWxsLAo+IAo+Pj4+IEhlbGxv
LAo+IAo+Pj4+IFNvIEknbSBoYXBweSB3aXRoIHRoaXMsIGJ1dCBJIHRoaW5rIEN5cmlsJ3MgY29t
bWVudCBkZXNlcnZlcyBhIHJlc3BvbnNlOgo+IAo+PiBJbmRlZWQsIEkgbm90aWNlZCBpdCB0b28g
bGF0ZSBhZnRlciBzZW5kaW5nIHRoZSB2Mi4KPiAKPj4+ICsxCj4gCj4+Pj4+IExvb2tpbmcgYXQg
aG93IGdsaWJjIGhhbmRsZXMgdGhpcywgdGhlIGNvZGUgbG9va3MgbGlrZToKPiAKPj4+Pj4gCWlu
dCBtb2RlID0gMDsKPiAKPj4+Pj4gCWlmIChfX09QRU5fTkVFRFNfTU9ERShvZmxhZykpIHsKPj4+
Pj4gCQkuLgo+Pj4+PiAJCW1vZGUgPSB2YV9hcmcoYXJnLCBpbnQpOwo+Pj4+PiAJCS4uCj4+Pj4+
IAl9Cj4gCj4+Pj4+IFRoYXQgc291bmRzIG11Y2ggZWFzaWVyIHRoYW4gbWVzc2luZyB3aXRoIHRo
ZSBtYWNyb3MgYW5kIHNob3VsZCBhdm9pZAo+Pj4+PiB1bmRlZmluZWQgYmVoYXZpb3IuCj4gCj4+
IEkgY29uc2lkZXJlZCB0aGlzIGFuZCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGZvY3VzIHN0cmlj
dGx5IG9uIHRoZSBoYW5kbGluZwo+PiB0aGUgdmFyaWFkaWNuZXNzIGlzc3VlLCBhbmQgd2FudGVk
IHRvIGF2b2lkIGR1cGxpY2F0aW5nIGxvZ2ljIGZyb20gbGliY3MuCj4gCj4+PiArMQo+IAo+Pj4+
IEkgZG9uJ3Qgc2VlIHdoeSwgX19PUEVOX05FRURTX01PREUgaXMgZ29pbmcgdG8gYmUgZGlmZmVy
ZW50IGJldHdlZW4KPiAKPj4+PiBmdW5jdGlvbnMgYW5kIGxpYmMva2VybmVsIHZlcnNpb25zLgo+
IAo+PiBIYXZlbid0IHRob3VnaHQgYWJvdXQgdGhhdCwgdGhhdCdzIGEgZ29vZCBwb2ludCBpbiBt
eSBvcGluaW9uLgo+IAo+IAo+Pj4gTG9va2luZyBhdCBnbGliYydzIF9fT1BFTl9ORUVEU19NT0RF
IGRlZmluaXRpb24sIHRoZSBsb2dpYyBpcyBvYnZpb3VzbHkgdGhlIHNhbWUKPj4+IGFzIG11c2wg
Y29kZSBmb3Igb3BlbiAoaXQganVzdCB1c2UgT19UTVBGSUxFIGluc3RlYWQgb2YgX19PX1RNUEZJ
TEUgdGhlcmVmb3JlIG5vCj4+PiBuZWVkIHRvIGNoZWNrIGZvciAjaWZkZWYgX19PX1RNUEZJTEUp
Lgo+IAo+PiBJIGFncmVlLCBmb3Igb3Blbi9vcGVuYXQgdGhpcyBhcHByb2FjaCB3b3VsZCBiZSBm
YWlybHkgc2ltcGxlLCB0aGVyZSBpcwo+PiBzZW1jdGwgdG9vIHRob3VnaCwgSSdsbCBuZWVkIHRv
IGhhdmUgYSBsb29rIGhvdyBnbGliYyBhbmQgbXVzbCBoYW5kbGUgaXQuCj4gCj4gVGhhbmtzIGEg
bG90IGZvciB5b3VyIHRpbWUgVHVkb3IhCgpNeSBwbGVhc3VyZSEgTWFueSB0aGFua3MgZm9yIHRo
ZSBmZWVkYmFjaywgYWxsLiBJIGhhdmUgcG9zdGVkIGEgdjMuIEkgCmxvb2sgZm9yd2FyZCB0byB5
b3VyIG9waW5pb25zLgoKS2luZCByZWdhcmRzLApUdWRvcgoKPiAKPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+IAo+PiBLaW5kIHJlZ2FyZHMsCj4+IFR1ZG9yCj4gCj4gCj4+PiBLaW5kIHJlZ2FyZHMs
Cj4+PiBQZXRyCj4gCj4+Pj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgUGFsZXRob3JwZSA8cnBhbGV0
aG9ycGVAc3VzZS5jb20+Cj4gCj4+Pj4gVHVkb3IgQ3JldHUgPHR1ZG9yLmNyZXR1QGFybS5jb20+
IHdyaXRlczoKPiAKPj4+Pj4gQWNjZXNzaW5nIGVsZW1lbnRzIGluIGFuIGVtcHR5IHZhX2xpc3Qg
cmVzdWx0cyBpbiB1bmRlZmluZWQgYmVoYXZpb3VyWzBdCj4+Pj4+IHRoYXQgY2FuIGluY2x1ZGUg
YWNjZXNzaW5nIGFyYml0cmFyeSBzdGFjayBtZW1vcnkuIFdoaWxlIHR5cGljYWxseSB0aGlzCj4+
Pj4+IGRvZXNuJ3QgcmFpc2UgYSBmYXVsdCwgc29tZSBuZXcgbW9yZSBzZWN1cml0eS1vcmllbnRl
ZCBhcmNoaXRlY3R1cmVzCj4+Pj4+IChlLmcuIENIRVJJWzFdIG9yIE1vcmVsbG9bMl0pIGRvbid0
IGFsbG93IGl0Lgo+IAo+Pj4+PiBUaGVyZWZvcmUsIHJlbW92ZSB0aGUgdmFyaWFkaWNuZXNzIGZy
b20gc2FmZV8qIHdyYXBwZXJzIHRoYXQgYWx3YXlzIGNhbGwKPj4+Pj4gdGhlIGZ1bmN0aW9ucyB3
aXRoIHRoZSBvcHRpb25hbCBhcmd1bWVudCBpbmNsdWRlZC4KPiAKPj4+Pj4gQWRhcHQgdGhlIHJl
c3BlY3RpdmUgU0FGRV8qIG1hY3JvcyB0byBoYW5kbGUgdGhlIGNoYW5nZSBieSBwYXNzaW5nIGEK
Pj4+Pj4gZGVmYXVsdCBhcmd1bWVudCBpZiB0aGV5J3JlIG9taXR0ZWQuCj4gCj4+Pj4+IFswXTog
W0lTTy9JRUMgOTg5OToyMDExXSBQcm9ncmFtbWluZyBMYW5ndWFnZXPigJRDLCAzcmQgZWQsIHBh
cmFncmFwaCA3LjE2LjEuMQo+Pj4+PiBbMV06IGh0dHBzOi8vd3d3LmNsLmNhbS5hYy51ay9yZXNl
YXJjaC9zZWN1cml0eS9jdHNyZC9jaGVyaS8KPj4+Pj4gWzJdOiBodHRwczovL3d3dy5tb3JlbGxv
LXByb2plY3Qub3JnLwo+IAo+Pj4+PiB2Mi4udjE6Cj4+Pj4+ICAgICAtIFBBVENIIDE6IFJlbW92
ZSB0aGUgTlVMTCBhcmd1bWVudCBmb3IgbW9kZSBmcm9tIFNBRkVfT1BFTiBpbnN0YW5jZXMKPj4+
Pj4gICAgICAgdG8gYXZvaWQgdGhlIHBvaW50ZXIgdG8gaW50IGNvbnZlcnNpb24uCj4gCj4+Pj4+
IFR1ZG9yIENyZXR1ICgzKToKPj4+Pj4gICAgIHNhZmVfb3BlbjogRml4IHVuZGVmaW5lZCBiZWhh
dmlvdXIgaW4gdmFyYXJnIGhhbmRsaW5nCj4+Pj4+ICAgICBzYWZlX29wZW5hdDogRml4IHVuZGVm
aW5lZCBiZWhhdmlvdXIgaW4gdmFyYXJnIGhhbmRsaW5nCj4+Pj4+ICAgICBzYWZlX3NlbWN0bDog
Rml4IHVuZGVmaW5lZCBiZWhhdmlvdXIgaW4gdmFyYXJnIGhhbmRsaW5nCj4gCj4+Pj4+ICAgIGlu
Y2x1ZGUvb2xkL3NhZmVfbWFjcm9zLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysr
LS0KPj4+Pj4gICAgaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAzICsrLQo+Pj4+PiAgICBpbmNsdWRlL3RzdF9zYWZlX2ZpbGVfYXQuaCAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTAgKysrKysrLS0tLQo+Pj4+PiAgICBpbmNsdWRlL3RzdF9zYWZl
X21hY3Jvcy5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKy0tCj4+Pj4+ICAgIGlu
Y2x1ZGUvdHN0X3NhZmVfc3lzdl9pcGMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAxNCArKysr
KysrKystLS0tLQo+Pj4+PiAgICBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTMgKy0tLS0tLS0tLS0tLQo+Pj4+PiAgICBsaWIvdHN0X2Nncm91cC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPj4+Pj4gICAgbGliL3Rz
dF9zYWZlX2ZpbGVfYXQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExICsrKy0tLS0t
LS0tCj4+Pj4+ICAgIGxpYi90c3Rfc2FmZV9zeXN2X2lwYy5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxMCArLS0tLS0tLS0tCj4+Pj4+ICAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmdldHhhdHRyL2ZnZXR4YXR0cjAxLmMgfCAgMiArLQo+Pj4+PiAgICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMi5jIHwgIDIgKy0KPj4+Pj4gICAgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mZ2V0eGF0dHIvZmdldHhhdHRyMDMuYyB8ICAyICstCj4+Pj4+
ICAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNldHhhdHRyL2ZzZXR4YXR0cjAxLmMgfCAg
MiArLQo+Pj4+PiAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0eGF0
dHIwMi5jIHwgIDIgKy0KPj4+Pj4gICAgMTQgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KSwgNDkgZGVsZXRpb25zKC0pCj4gCj4+Pj4+IC0tIAo+Pj4+PiAyLjI1LjEKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
