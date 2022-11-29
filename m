Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB9C4167B
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 15:16:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 666CA3CC5F5
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 16:16:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D93213C714A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 16:16:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 17B8D20092C
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 16:16:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03FC621B97;
 Tue, 29 Nov 2022 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669734962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xA0euxUp9onxS9siiCWP5gLJPzPKqY14U80ZLyedTBM=;
 b=rFI/z45FWpUBEAOFrJWS5TzEZkmSS4EHdN2cGow3FY3QaAO3fnoiIav4jxRofiKfQGNbIw
 uH1wLzhDdkbWqV4bfw7127EwS69lOmsEu070ZV/lRlMTWHdNAsj4xxSyL8eDxMquX7o+DF
 g2Mf19iq9f/V4SwdpQrrBnAEyuYCPiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669734962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xA0euxUp9onxS9siiCWP5gLJPzPKqY14U80ZLyedTBM=;
 b=Zrb0UcU0xAvMN5ktT3pL0wNAeL8MCKnlx07+ACo4onVQCCLWy1fZ7LX9/RyxpwnGnVn6H/
 vq7bsFsD7xsusBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFE3913AF6;
 Tue, 29 Nov 2022 15:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 542vLTEihmMabQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 15:16:01 +0000
Date: Tue, 29 Nov 2022 16:15:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <Y4YiL/Os2G+cZMFp@pevik>
References: <20221129130350.219082-1-tudor.cretu@arm.com>
 <87a649ubuq.fsf@suse.de> <Y4YQL2TezOp2dcnD@pevik>
 <eff8f05f-fd4b-4cad-86bc-d039aab0a56a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eff8f05f-fd4b-4cad-86bc-d039aab0a56a@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cgo+IE9uIDI5LTExLTIwMjIgMTM6NTksIFBldHIgVm9yZWwgd3JvdGU6Cj4gPiBIaSBhbGwsCgo+
ID4gPiBIZWxsbywKCj4gPiA+IFNvIEknbSBoYXBweSB3aXRoIHRoaXMsIGJ1dCBJIHRoaW5rIEN5
cmlsJ3MgY29tbWVudCBkZXNlcnZlcyBhIHJlc3BvbnNlOgoKPiBJbmRlZWQsIEkgbm90aWNlZCBp
dCB0b28gbGF0ZSBhZnRlciBzZW5kaW5nIHRoZSB2Mi4KCj4gPiArMQoKPiA+ID4gPiBMb29raW5n
IGF0IGhvdyBnbGliYyBoYW5kbGVzIHRoaXMsIHRoZSBjb2RlIGxvb2tzIGxpa2U6Cgo+ID4gPiA+
IAlpbnQgbW9kZSA9IDA7Cgo+ID4gPiA+IAlpZiAoX19PUEVOX05FRURTX01PREUob2ZsYWcpKSB7
Cj4gPiA+ID4gCQkuLgo+ID4gPiA+IAkJbW9kZSA9IHZhX2FyZyhhcmcsIGludCk7Cj4gPiA+ID4g
CQkuLgo+ID4gPiA+IAl9Cgo+ID4gPiA+IFRoYXQgc291bmRzIG11Y2ggZWFzaWVyIHRoYW4gbWVz
c2luZyB3aXRoIHRoZSBtYWNyb3MgYW5kIHNob3VsZCBhdm9pZAo+ID4gPiA+IHVuZGVmaW5lZCBi
ZWhhdmlvci4KCj4gSSBjb25zaWRlcmVkIHRoaXMgYW5kIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8g
Zm9jdXMgc3RyaWN0bHkgb24gdGhlIGhhbmRsaW5nCj4gdGhlIHZhcmlhZGljbmVzcyBpc3N1ZSwg
YW5kIHdhbnRlZCB0byBhdm9pZCBkdXBsaWNhdGluZyBsb2dpYyBmcm9tIGxpYmNzLgoKPiA+ICsx
Cgo+ID4gPiBJIGRvbid0IHNlZSB3aHksIF9fT1BFTl9ORUVEU19NT0RFIGlzIGdvaW5nIHRvIGJl
IGRpZmZlcmVudCBiZXR3ZWVuCgo+ID4gPiBmdW5jdGlvbnMgYW5kIGxpYmMva2VybmVsIHZlcnNp
b25zLgoKPiBIYXZlbid0IHRob3VnaHQgYWJvdXQgdGhhdCwgdGhhdCdzIGEgZ29vZCBwb2ludCBp
biBteSBvcGluaW9uLgoKCj4gPiBMb29raW5nIGF0IGdsaWJjJ3MgX19PUEVOX05FRURTX01PREUg
ZGVmaW5pdGlvbiwgdGhlIGxvZ2ljIGlzIG9idmlvdXNseSB0aGUgc2FtZQo+ID4gYXMgbXVzbCBj
b2RlIGZvciBvcGVuIChpdCBqdXN0IHVzZSBPX1RNUEZJTEUgaW5zdGVhZCBvZiBfX09fVE1QRklM
RSB0aGVyZWZvcmUgbm8KPiA+IG5lZWQgdG8gY2hlY2sgZm9yICNpZmRlZiBfX09fVE1QRklMRSku
Cgo+IEkgYWdyZWUsIGZvciBvcGVuL29wZW5hdCB0aGlzIGFwcHJvYWNoIHdvdWxkIGJlIGZhaXJs
eSBzaW1wbGUsIHRoZXJlIGlzCj4gc2VtY3RsIHRvbyB0aG91Z2gsIEknbGwgbmVlZCB0byBoYXZl
IGEgbG9vayBob3cgZ2xpYmMgYW5kIG11c2wgaGFuZGxlIGl0LgoKVGhhbmtzIGEgbG90IGZvciB5
b3VyIHRpbWUgVHVkb3IhCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gS2luZCByZWdhcmRzLAo+IFR1
ZG9yCgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiA+IFJldmlld2VkLWJ5OiBSaWNo
YXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPgoKPiA+ID4gVHVkb3IgQ3JldHUg
PHR1ZG9yLmNyZXR1QGFybS5jb20+IHdyaXRlczoKCj4gPiA+ID4gQWNjZXNzaW5nIGVsZW1lbnRz
IGluIGFuIGVtcHR5IHZhX2xpc3QgcmVzdWx0cyBpbiB1bmRlZmluZWQgYmVoYXZpb3VyWzBdCj4g
PiA+ID4gdGhhdCBjYW4gaW5jbHVkZSBhY2Nlc3NpbmcgYXJiaXRyYXJ5IHN0YWNrIG1lbW9yeS4g
V2hpbGUgdHlwaWNhbGx5IHRoaXMKPiA+ID4gPiBkb2Vzbid0IHJhaXNlIGEgZmF1bHQsIHNvbWUg
bmV3IG1vcmUgc2VjdXJpdHktb3JpZW50ZWQgYXJjaGl0ZWN0dXJlcwo+ID4gPiA+IChlLmcuIENI
RVJJWzFdIG9yIE1vcmVsbG9bMl0pIGRvbid0IGFsbG93IGl0LgoKPiA+ID4gPiBUaGVyZWZvcmUs
IHJlbW92ZSB0aGUgdmFyaWFkaWNuZXNzIGZyb20gc2FmZV8qIHdyYXBwZXJzIHRoYXQgYWx3YXlz
IGNhbGwKPiA+ID4gPiB0aGUgZnVuY3Rpb25zIHdpdGggdGhlIG9wdGlvbmFsIGFyZ3VtZW50IGlu
Y2x1ZGVkLgoKPiA+ID4gPiBBZGFwdCB0aGUgcmVzcGVjdGl2ZSBTQUZFXyogbWFjcm9zIHRvIGhh
bmRsZSB0aGUgY2hhbmdlIGJ5IHBhc3NpbmcgYQo+ID4gPiA+IGRlZmF1bHQgYXJndW1lbnQgaWYg
dGhleSdyZSBvbWl0dGVkLgoKPiA+ID4gPiBbMF06IFtJU08vSUVDIDk4OTk6MjAxMV0gUHJvZ3Jh
bW1pbmcgTGFuZ3VhZ2Vz4oCUQywgM3JkIGVkLCBwYXJhZ3JhcGggNy4xNi4xLjEKPiA+ID4gPiBb
MV06IGh0dHBzOi8vd3d3LmNsLmNhbS5hYy51ay9yZXNlYXJjaC9zZWN1cml0eS9jdHNyZC9jaGVy
aS8KPiA+ID4gPiBbMl06IGh0dHBzOi8vd3d3Lm1vcmVsbG8tcHJvamVjdC5vcmcvCgo+ID4gPiA+
IHYyLi52MToKPiA+ID4gPiAgICAtIFBBVENIIDE6IFJlbW92ZSB0aGUgTlVMTCBhcmd1bWVudCBm
b3IgbW9kZSBmcm9tIFNBRkVfT1BFTiBpbnN0YW5jZXMKPiA+ID4gPiAgICAgIHRvIGF2b2lkIHRo
ZSBwb2ludGVyIHRvIGludCBjb252ZXJzaW9uLgoKPiA+ID4gPiBUdWRvciBDcmV0dSAoMyk6Cj4g
PiA+ID4gICAgc2FmZV9vcGVuOiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFu
ZGxpbmcKPiA+ID4gPiAgICBzYWZlX29wZW5hdDogRml4IHVuZGVmaW5lZCBiZWhhdmlvdXIgaW4g
dmFyYXJnIGhhbmRsaW5nCj4gPiA+ID4gICAgc2FmZV9zZW1jdGw6IEZpeCB1bmRlZmluZWQgYmVo
YXZpb3VyIGluIHZhcmFyZyBoYW5kbGluZwoKPiA+ID4gPiAgIGluY2x1ZGUvb2xkL3NhZmVfbWFj
cm9zLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysrLS0KPiA+ID4gPiAgIGluY2x1
ZGUvc2FmZV9tYWNyb3NfZm4uaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArKy0KPiA+
ID4gPiAgIGluY2x1ZGUvdHN0X3NhZmVfZmlsZV9hdC5oICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMCArKysrKystLS0tCj4gPiA+ID4gICBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKy0tCj4gPiA+ID4gICBpbmNsdWRlL3RzdF9zYWZl
X3N5c3ZfaXBjLmggICAgICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKysrLS0tLS0KPiA+
ID4gPiAgIGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMyArLS0tLS0tLS0tLS0tCj4gPiA+ID4gICBsaWIvdHN0X2Nncm91cC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiA+ID4gPiAgIGxpYi90c3Rfc2FmZV9maWxl
X2F0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMSArKystLS0tLS0tLQo+ID4gPiA+
ICAgbGliL3RzdF9zYWZlX3N5c3ZfaXBjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEw
ICstLS0tLS0tLS0KPiA+ID4gPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRy
L2ZnZXR4YXR0cjAxLmMgfCAgMiArLQo+ID4gPiA+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mZ2V0eGF0dHIvZmdldHhhdHRyMDIuYyB8ICAyICstCj4gPiA+ID4gICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMy5jIHwgIDIgKy0KPiA+ID4gPiAgIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNldHhhdHRyL2ZzZXR4YXR0cjAxLmMgfCAgMiArLQo+
ID4gPiA+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mc2V0eGF0dHIvZnNldHhhdHRyMDIu
YyB8ICAyICstCj4gPiA+ID4gICAxNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA0
OSBkZWxldGlvbnMoLSkKCj4gPiA+ID4gLS0gCj4gPiA+ID4gMi4yNS4xCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
