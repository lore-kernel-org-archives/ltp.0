Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB8C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF5A43CC5BB
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:30:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3ADB3C85AE
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:30:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 418A31400974
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:30:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 920F921BD6;
 Tue, 29 Nov 2022 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669728638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YUMwXhO0nwrY2dcJXL4Ody+YQZrhHyfVkTPeIslTMg=;
 b=EViVoVI6k51YQYKP9FRUjBk3nwL2qA7zo8kYTbKWLDwhtmEpGF330fQ6601gQlImL50Ee0
 8XYCLE+zjbM4S6E9LuN3+xI8s90ewqiDNkQbcKNYPFggy1o0+eQ5Ejh9N1Dwzw178Eg/hO
 Yn5ecW6j1C2tfRhCZQRyD/Ot6HAIDws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669728638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YUMwXhO0nwrY2dcJXL4Ody+YQZrhHyfVkTPeIslTMg=;
 b=8qS+SFrVw7Bv+9a13CrhOCmm66AKoz6qqCFtScIHeW8+PeAWJ6an2XtQS+6tkC646gRQ4s
 fLg1RZutW2nMt8Cw==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 535A02C141;
 Tue, 29 Nov 2022 13:30:38 +0000 (UTC)
References: <20221129130350.219082-1-tudor.cretu@arm.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tudor Cretu <tudor.cretu@arm.com>
Date: Tue, 29 Nov 2022 13:23:49 +0000
Organization: Linux Private Site
In-reply-to: <20221129130350.219082-1-tudor.cretu@arm.com>
Message-ID: <87a649ubuq.fsf@suse.de>
MIME-Version: 1.0
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpTbyBJJ20gaGFwcHkgd2l0aCB0aGlzLCBidXQgSSB0aGluayBDeXJpbCdzIGNvbW1l
bnQgZGVzZXJ2ZXMgYSByZXNwb25zZToKCj4gTG9va2luZyBhdCBob3cgZ2xpYmMgaGFuZGxlcyB0
aGlzLCB0aGUgY29kZSBsb29rcyBsaWtlOgoKPiAJaW50IG1vZGUgPSAwOwoKPiAJaWYgKF9fT1BF
Tl9ORUVEU19NT0RFKG9mbGFnKSkgewo+IAkJLi4KPiAJCW1vZGUgPSB2YV9hcmcoYXJnLCBpbnQp
Owo+IAkJLi4KPiAJfQoKPiBUaGF0IHNvdW5kcyBtdWNoIGVhc2llciB0aGFuIG1lc3Npbmcgd2l0
aCB0aGUgbWFjcm9zIGFuZCBzaG91bGQgYXZvaWQKPiB1bmRlZmluZWQgYmVoYXZpb3IuCgpJIGRv
bid0IHNlZSB3aHksIF9fT1BFTl9ORUVEU19NT0RFIGlzIGdvaW5nIHRvIGJlIGRpZmZlcmVudCBi
ZXR3ZWVuCmZ1bmN0aW9ucyBhbmQgbGliYy9rZXJuZWwgdmVyc2lvbnMuCgpSZXZpZXdlZC1ieTog
UmljaGFyZCBQYWxldGhvcnBlIDxycGFsZXRob3JwZUBzdXNlLmNvbT4KClR1ZG9yIENyZXR1IDx0
dWRvci5jcmV0dUBhcm0uY29tPiB3cml0ZXM6Cgo+IEFjY2Vzc2luZyBlbGVtZW50cyBpbiBhbiBl
bXB0eSB2YV9saXN0IHJlc3VsdHMgaW4gdW5kZWZpbmVkIGJlaGF2aW91clswXQo+IHRoYXQgY2Fu
IGluY2x1ZGUgYWNjZXNzaW5nIGFyYml0cmFyeSBzdGFjayBtZW1vcnkuIFdoaWxlIHR5cGljYWxs
eSB0aGlzCj4gZG9lc24ndCByYWlzZSBhIGZhdWx0LCBzb21lIG5ldyBtb3JlIHNlY3VyaXR5LW9y
aWVudGVkIGFyY2hpdGVjdHVyZXMKPiAoZS5nLiBDSEVSSVsxXSBvciBNb3JlbGxvWzJdKSBkb24n
dCBhbGxvdyBpdC4KPgo+IFRoZXJlZm9yZSwgcmVtb3ZlIHRoZSB2YXJpYWRpY25lc3MgZnJvbSBz
YWZlXyogd3JhcHBlcnMgdGhhdCBhbHdheXMgY2FsbAo+IHRoZSBmdW5jdGlvbnMgd2l0aCB0aGUg
b3B0aW9uYWwgYXJndW1lbnQgaW5jbHVkZWQuCj4KPiBBZGFwdCB0aGUgcmVzcGVjdGl2ZSBTQUZF
XyogbWFjcm9zIHRvIGhhbmRsZSB0aGUgY2hhbmdlIGJ5IHBhc3NpbmcgYQo+IGRlZmF1bHQgYXJn
dW1lbnQgaWYgdGhleSdyZSBvbWl0dGVkLgo+Cj4gWzBdOiBbSVNPL0lFQyA5ODk5OjIwMTFdIFBy
b2dyYW1taW5nIExhbmd1YWdlc+KAlEMsIDNyZCBlZCwgcGFyYWdyYXBoIDcuMTYuMS4xCj4gWzFd
OiBodHRwczovL3d3dy5jbC5jYW0uYWMudWsvcmVzZWFyY2gvc2VjdXJpdHkvY3RzcmQvY2hlcmkv
Cj4gWzJdOiBodHRwczovL3d3dy5tb3JlbGxvLXByb2plY3Qub3JnLwo+Cj4gdjIuLnYxOgo+ICAg
LSBQQVRDSCAxOiBSZW1vdmUgdGhlIE5VTEwgYXJndW1lbnQgZm9yIG1vZGUgZnJvbSBTQUZFX09Q
RU4gaW5zdGFuY2VzCj4gICAgIHRvIGF2b2lkIHRoZSBwb2ludGVyIHRvIGludCBjb252ZXJzaW9u
Lgo+Cj4gVHVkb3IgQ3JldHUgKDMpOgo+ICAgc2FmZV9vcGVuOiBGaXggdW5kZWZpbmVkIGJlaGF2
aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPiAgIHNhZmVfb3BlbmF0OiBGaXggdW5kZWZpbmVkIGJl
aGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPiAgIHNhZmVfc2VtY3RsOiBGaXggdW5kZWZpbmVk
IGJlaGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPgo+ICBpbmNsdWRlL29sZC9zYWZlX21hY3Jv
cy5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKy0tCj4gIGluY2x1ZGUvc2FmZV9t
YWNyb3NfZm4uaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArKy0KPiAgaW5jbHVkZS90
c3Rfc2FmZV9maWxlX2F0LmggICAgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKysrKy0tLS0K
PiAgaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2
ICsrKystLQo+ICBpbmNsdWRlL3RzdF9zYWZlX3N5c3ZfaXBjLmggICAgICAgICAgICAgICAgICAg
ICAgIHwgMTQgKysrKysrKysrLS0tLS0KPiAgbGliL3NhZmVfbWFjcm9zLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDEzICstLS0tLS0tLS0tLS0KPiAgbGliL3RzdF9jZ3JvdXAu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGxpYi90c3Rfc2Fm
ZV9maWxlX2F0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMSArKystLS0tLS0tLQo+
ICBsaWIvdHN0X3NhZmVfc3lzdl9pcGMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTAg
Ky0tLS0tLS0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0
dHIwMS5jIHwgIDIgKy0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mZ2V0eGF0dHIvZmdl
dHhhdHRyMDIuYyB8ICAyICstCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRy
L2ZnZXR4YXR0cjAzLmMgfCAgMiArLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzZXR4
YXR0ci9mc2V0eGF0dHIwMS5jIHwgIDIgKy0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
c2V0eGF0dHIvZnNldHhhdHRyMDIuYyB8ICAyICstCj4gIDE0IGZpbGVzIGNoYW5nZWQsIDM2IGlu
c2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQo+Cj4gLS0gCj4gMi4yNS4xCgoKLS0gClRoYW5r
IHlvdSwKUmljaGFyZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
