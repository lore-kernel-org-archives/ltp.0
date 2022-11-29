Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D0C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C023A3CC5CF
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 15:04:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0521E3C0367
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 15:04:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 32F3610007B2
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 15:04:21 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09AE1D6E;
 Tue, 29 Nov 2022 06:04:25 -0800 (PST)
Received: from [10.1.30.171] (e129169.cambridge.arm.com [10.1.30.171])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78E2B3F73D;
 Tue, 29 Nov 2022 06:04:17 -0800 (PST)
Message-ID: <eff8f05f-fd4b-4cad-86bc-d039aab0a56a@arm.com>
Date: Tue, 29 Nov 2022 14:04:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Richard Palethorpe <rpalethorpe@suse.de>
References: <20221129130350.219082-1-tudor.cretu@arm.com>
 <87a649ubuq.fsf@suse.de> <Y4YQL2TezOp2dcnD@pevik>
From: Tudor Cretu <tudor.cretu@arm.com>
In-Reply-To: <Y4YQL2TezOp2dcnD@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

CgpPbiAyOS0xMS0yMDIyIDEzOjU5LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIGFsbCwKPiAKPj4g
SGVsbG8sCj4gCj4+IFNvIEknbSBoYXBweSB3aXRoIHRoaXMsIGJ1dCBJIHRoaW5rIEN5cmlsJ3Mg
Y29tbWVudCBkZXNlcnZlcyBhIHJlc3BvbnNlOgoKSW5kZWVkLCBJIG5vdGljZWQgaXQgdG9vIGxh
dGUgYWZ0ZXIgc2VuZGluZyB0aGUgdjIuCgo+ICsxCj4gCj4+PiBMb29raW5nIGF0IGhvdyBnbGli
YyBoYW5kbGVzIHRoaXMsIHRoZSBjb2RlIGxvb2tzIGxpa2U6Cj4gCj4+PiAJaW50IG1vZGUgPSAw
Owo+IAo+Pj4gCWlmIChfX09QRU5fTkVFRFNfTU9ERShvZmxhZykpIHsKPj4+IAkJLi4KPj4+IAkJ
bW9kZSA9IHZhX2FyZyhhcmcsIGludCk7Cj4+PiAJCS4uCj4+PiAJfQo+IAo+Pj4gVGhhdCBzb3Vu
ZHMgbXVjaCBlYXNpZXIgdGhhbiBtZXNzaW5nIHdpdGggdGhlIG1hY3JvcyBhbmQgc2hvdWxkIGF2
b2lkCj4+PiB1bmRlZmluZWQgYmVoYXZpb3IuCgpJIGNvbnNpZGVyZWQgdGhpcyBhbmQgSSB0aGlu
ayBpdCdzIGJldHRlciB0byBmb2N1cyBzdHJpY3RseSBvbiB0aGUgCmhhbmRsaW5nIHRoZSB2YXJp
YWRpY25lc3MgaXNzdWUsIGFuZCB3YW50ZWQgdG8gYXZvaWQgZHVwbGljYXRpbmcgbG9naWMgCmZy
b20gbGliY3MuCgo+ICsxCj4gCj4+IEkgZG9uJ3Qgc2VlIHdoeSwgX19PUEVOX05FRURTX01PREUg
aXMgZ29pbmcgdG8gYmUgZGlmZmVyZW50IGJldHdlZW4KPiAKPj4gZnVuY3Rpb25zIGFuZCBsaWJj
L2tlcm5lbCB2ZXJzaW9ucy4KCkhhdmVuJ3QgdGhvdWdodCBhYm91dCB0aGF0LCB0aGF0J3MgYSBn
b29kIHBvaW50IGluIG15IG9waW5pb24uCgo+IAo+IExvb2tpbmcgYXQgZ2xpYmMncyBfX09QRU5f
TkVFRFNfTU9ERSBkZWZpbml0aW9uLCB0aGUgbG9naWMgaXMgb2J2aW91c2x5IHRoZSBzYW1lCj4g
YXMgbXVzbCBjb2RlIGZvciBvcGVuIChpdCBqdXN0IHVzZSBPX1RNUEZJTEUgaW5zdGVhZCBvZiBf
X09fVE1QRklMRSB0aGVyZWZvcmUgbm8KPiBuZWVkIHRvIGNoZWNrIGZvciAjaWZkZWYgX19PX1RN
UEZJTEUpLgoKSSBhZ3JlZSwgZm9yIG9wZW4vb3BlbmF0IHRoaXMgYXBwcm9hY2ggd291bGQgYmUg
ZmFpcmx5IHNpbXBsZSwgdGhlcmUgaXMgCnNlbWN0bCB0b28gdGhvdWdoLCBJJ2xsIG5lZWQgdG8g
aGF2ZSBhIGxvb2sgaG93IGdsaWJjIGFuZCBtdXNsIGhhbmRsZSBpdC4KCktpbmQgcmVnYXJkcywK
VHVkb3IKCj4gCj4gS2luZCByZWdhcmRzLAo+IFBldHIKPiAKPj4gUmV2aWV3ZWQtYnk6IFJpY2hh
cmQgUGFsZXRob3JwZSA8cnBhbGV0aG9ycGVAc3VzZS5jb20+Cj4gCj4+IFR1ZG9yIENyZXR1IDx0
dWRvci5jcmV0dUBhcm0uY29tPiB3cml0ZXM6Cj4gCj4+PiBBY2Nlc3NpbmcgZWxlbWVudHMgaW4g
YW4gZW1wdHkgdmFfbGlzdCByZXN1bHRzIGluIHVuZGVmaW5lZCBiZWhhdmlvdXJbMF0KPj4+IHRo
YXQgY2FuIGluY2x1ZGUgYWNjZXNzaW5nIGFyYml0cmFyeSBzdGFjayBtZW1vcnkuIFdoaWxlIHR5
cGljYWxseSB0aGlzCj4+PiBkb2Vzbid0IHJhaXNlIGEgZmF1bHQsIHNvbWUgbmV3IG1vcmUgc2Vj
dXJpdHktb3JpZW50ZWQgYXJjaGl0ZWN0dXJlcwo+Pj4gKGUuZy4gQ0hFUklbMV0gb3IgTW9yZWxs
b1syXSkgZG9uJ3QgYWxsb3cgaXQuCj4gCj4+PiBUaGVyZWZvcmUsIHJlbW92ZSB0aGUgdmFyaWFk
aWNuZXNzIGZyb20gc2FmZV8qIHdyYXBwZXJzIHRoYXQgYWx3YXlzIGNhbGwKPj4+IHRoZSBmdW5j
dGlvbnMgd2l0aCB0aGUgb3B0aW9uYWwgYXJndW1lbnQgaW5jbHVkZWQuCj4gCj4+PiBBZGFwdCB0
aGUgcmVzcGVjdGl2ZSBTQUZFXyogbWFjcm9zIHRvIGhhbmRsZSB0aGUgY2hhbmdlIGJ5IHBhc3Np
bmcgYQo+Pj4gZGVmYXVsdCBhcmd1bWVudCBpZiB0aGV5J3JlIG9taXR0ZWQuCj4gCj4+PiBbMF06
IFtJU08vSUVDIDk4OTk6MjAxMV0gUHJvZ3JhbW1pbmcgTGFuZ3VhZ2Vz4oCUQywgM3JkIGVkLCBw
YXJhZ3JhcGggNy4xNi4xLjEKPj4+IFsxXTogaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL3Jlc2Vh
cmNoL3NlY3VyaXR5L2N0c3JkL2NoZXJpLwo+Pj4gWzJdOiBodHRwczovL3d3dy5tb3JlbGxvLXBy
b2plY3Qub3JnLwo+IAo+Pj4gdjIuLnYxOgo+Pj4gICAgLSBQQVRDSCAxOiBSZW1vdmUgdGhlIE5V
TEwgYXJndW1lbnQgZm9yIG1vZGUgZnJvbSBTQUZFX09QRU4gaW5zdGFuY2VzCj4+PiAgICAgIHRv
IGF2b2lkIHRoZSBwb2ludGVyIHRvIGludCBjb252ZXJzaW9uLgo+IAo+Pj4gVHVkb3IgQ3JldHUg
KDMpOgo+Pj4gICAgc2FmZV9vcGVuOiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcg
aGFuZGxpbmcKPj4+ICAgIHNhZmVfb3BlbmF0OiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2
YXJhcmcgaGFuZGxpbmcKPj4+ICAgIHNhZmVfc2VtY3RsOiBGaXggdW5kZWZpbmVkIGJlaGF2aW91
ciBpbiB2YXJhcmcgaGFuZGxpbmcKPiAKPj4+ICAgaW5jbHVkZS9vbGQvc2FmZV9tYWNyb3MuaCAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKystLQo+Pj4gICBpbmNsdWRlL3NhZmVfbWFj
cm9zX2ZuLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKystCj4+PiAgIGluY2x1ZGUv
dHN0X3NhZmVfZmlsZV9hdC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKystLS0t
Cj4+PiAgIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNiArKysrLS0KPj4+ICAgaW5jbHVkZS90c3Rfc2FmZV9zeXN2X2lwYy5oICAgICAgICAgICAg
ICAgICAgICAgICB8IDE0ICsrKysrKysrKy0tLS0tCj4+PiAgIGxpYi9zYWZlX21hY3Jvcy5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMyArLS0tLS0tLS0tLS0tCj4+PiAgIGxp
Yi90c3RfY2dyb3VwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+
Pj4gICBsaWIvdHN0X3NhZmVfZmlsZV9hdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MTEgKysrLS0tLS0tLS0KPj4+ICAgbGliL3RzdF9zYWZlX3N5c3ZfaXBjLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEwICstLS0tLS0tLS0KPj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mZ2V0eGF0dHIvZmdldHhhdHRyMDEuYyB8ICAyICstCj4+PiAgIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmdldHhhdHRyL2ZnZXR4YXR0cjAyLmMgfCAgMiArLQo+Pj4gICB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMy5jIHwgIDIgKy0KPj4+ICAg
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mc2V0eGF0dHIvZnNldHhhdHRyMDEuYyB8ICAyICst
Cj4+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNldHhhdHRyL2ZzZXR4YXR0cjAyLmMg
fCAgMiArLQo+Pj4gICAxNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA0OSBkZWxl
dGlvbnMoLSkKPiAKPj4+IC0tIAo+Pj4gMi4yNS4xCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
