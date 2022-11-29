Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73313C4167B
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60A2C3CC5EF
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:59:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 442573C85AE
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:59:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6B5A140097D
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:59:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1728B1FDEC;
 Tue, 29 Nov 2022 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669730354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLEYSECuh1NGczs+9KotjXuz7FItTtsTpmBjvEtYpwg=;
 b=jyzg9D7gZF8RhKctY9bHnj4N2AdB9RFVtdQyvLH1XOf4wraoJmdZeVSdbInNNj7frQTXdO
 T5UyuGSHvYS0UyZugqvpP4fQCafp0cYFZQyfcLObSBZDqgUrI3uPy46AwNQLVoAZ/pg8/G
 7Rz5NeLZtzci13ihETlAP9CC2dyp1t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669730354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLEYSECuh1NGczs+9KotjXuz7FItTtsTpmBjvEtYpwg=;
 b=zfzWZXDlPYrNBJQ/yDsDoppCshmMQPB2iaIRmoUkPHNrD5rQMvbxskqpErDrfrJegUoCSk
 OGIl1zu4f0bnZwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEF9313428;
 Tue, 29 Nov 2022 13:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Hnx4MDEQhmNZQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 13:59:13 +0000
Date: Tue, 29 Nov 2022 14:59:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y4YQL2TezOp2dcnD@pevik>
References: <20221129130350.219082-1-tudor.cretu@arm.com>
 <87a649ubuq.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a649ubuq.fsf@suse.de>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBIZWxsbywKCj4gU28gSSdtIGhhcHB5IHdpdGggdGhpcywgYnV0IEkgdGhpbmsg
Q3lyaWwncyBjb21tZW50IGRlc2VydmVzIGEgcmVzcG9uc2U6CisxCgo+ID4gTG9va2luZyBhdCBo
b3cgZ2xpYmMgaGFuZGxlcyB0aGlzLCB0aGUgY29kZSBsb29rcyBsaWtlOgoKPiA+IAlpbnQgbW9k
ZSA9IDA7Cgo+ID4gCWlmIChfX09QRU5fTkVFRFNfTU9ERShvZmxhZykpIHsKPiA+IAkJLi4KPiA+
IAkJbW9kZSA9IHZhX2FyZyhhcmcsIGludCk7Cj4gPiAJCS4uCj4gPiAJfQoKPiA+IFRoYXQgc291
bmRzIG11Y2ggZWFzaWVyIHRoYW4gbWVzc2luZyB3aXRoIHRoZSBtYWNyb3MgYW5kIHNob3VsZCBh
dm9pZAo+ID4gdW5kZWZpbmVkIGJlaGF2aW9yLgorMQoKPiBJIGRvbid0IHNlZSB3aHksIF9fT1BF
Tl9ORUVEU19NT0RFIGlzIGdvaW5nIHRvIGJlIGRpZmZlcmVudCBiZXR3ZWVuCgo+IGZ1bmN0aW9u
cyBhbmQgbGliYy9rZXJuZWwgdmVyc2lvbnMuCgpMb29raW5nIGF0IGdsaWJjJ3MgX19PUEVOX05F
RURTX01PREUgZGVmaW5pdGlvbiwgdGhlIGxvZ2ljIGlzIG9idmlvdXNseSB0aGUgc2FtZQphcyBt
dXNsIGNvZGUgZm9yIG9wZW4gKGl0IGp1c3QgdXNlIE9fVE1QRklMRSBpbnN0ZWFkIG9mIF9fT19U
TVBGSUxFIHRoZXJlZm9yZSBubwpuZWVkIHRvIGNoZWNrIGZvciAjaWZkZWYgX19PX1RNUEZJTEUp
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFJldmlld2VkLWJ5OiBSaWNoYXJkIFBhbGV0aG9ycGUg
PHJwYWxldGhvcnBlQHN1c2UuY29tPgoKPiBUdWRvciBDcmV0dSA8dHVkb3IuY3JldHVAYXJtLmNv
bT4gd3JpdGVzOgoKPiA+IEFjY2Vzc2luZyBlbGVtZW50cyBpbiBhbiBlbXB0eSB2YV9saXN0IHJl
c3VsdHMgaW4gdW5kZWZpbmVkIGJlaGF2aW91clswXQo+ID4gdGhhdCBjYW4gaW5jbHVkZSBhY2Nl
c3NpbmcgYXJiaXRyYXJ5IHN0YWNrIG1lbW9yeS4gV2hpbGUgdHlwaWNhbGx5IHRoaXMKPiA+IGRv
ZXNuJ3QgcmFpc2UgYSBmYXVsdCwgc29tZSBuZXcgbW9yZSBzZWN1cml0eS1vcmllbnRlZCBhcmNo
aXRlY3R1cmVzCj4gPiAoZS5nLiBDSEVSSVsxXSBvciBNb3JlbGxvWzJdKSBkb24ndCBhbGxvdyBp
dC4KCj4gPiBUaGVyZWZvcmUsIHJlbW92ZSB0aGUgdmFyaWFkaWNuZXNzIGZyb20gc2FmZV8qIHdy
YXBwZXJzIHRoYXQgYWx3YXlzIGNhbGwKPiA+IHRoZSBmdW5jdGlvbnMgd2l0aCB0aGUgb3B0aW9u
YWwgYXJndW1lbnQgaW5jbHVkZWQuCgo+ID4gQWRhcHQgdGhlIHJlc3BlY3RpdmUgU0FGRV8qIG1h
Y3JvcyB0byBoYW5kbGUgdGhlIGNoYW5nZSBieSBwYXNzaW5nIGEKPiA+IGRlZmF1bHQgYXJndW1l
bnQgaWYgdGhleSdyZSBvbWl0dGVkLgoKPiA+IFswXTogW0lTTy9JRUMgOTg5OToyMDExXSBQcm9n
cmFtbWluZyBMYW5ndWFnZXPigJRDLCAzcmQgZWQsIHBhcmFncmFwaCA3LjE2LjEuMQo+ID4gWzFd
OiBodHRwczovL3d3dy5jbC5jYW0uYWMudWsvcmVzZWFyY2gvc2VjdXJpdHkvY3RzcmQvY2hlcmkv
Cj4gPiBbMl06IGh0dHBzOi8vd3d3Lm1vcmVsbG8tcHJvamVjdC5vcmcvCgo+ID4gdjIuLnYxOgo+
ID4gICAtIFBBVENIIDE6IFJlbW92ZSB0aGUgTlVMTCBhcmd1bWVudCBmb3IgbW9kZSBmcm9tIFNB
RkVfT1BFTiBpbnN0YW5jZXMKPiA+ICAgICB0byBhdm9pZCB0aGUgcG9pbnRlciB0byBpbnQgY29u
dmVyc2lvbi4KCj4gPiBUdWRvciBDcmV0dSAoMyk6Cj4gPiAgIHNhZmVfb3BlbjogRml4IHVuZGVm
aW5lZCBiZWhhdmlvdXIgaW4gdmFyYXJnIGhhbmRsaW5nCj4gPiAgIHNhZmVfb3BlbmF0OiBGaXgg
dW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPiA+ICAgc2FmZV9zZW1jdGw6
IEZpeCB1bmRlZmluZWQgYmVoYXZpb3VyIGluIHZhcmFyZyBoYW5kbGluZwoKPiA+ICBpbmNsdWRl
L29sZC9zYWZlX21hY3Jvcy5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKy0tCj4g
PiAgaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
ICsrLQo+ID4gIGluY2x1ZGUvdHN0X3NhZmVfZmlsZV9hdC5oICAgICAgICAgICAgICAgICAgICAg
ICAgfCAxMCArKysrKystLS0tCj4gPiAgaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICA2ICsrKystLQo+ID4gIGluY2x1ZGUvdHN0X3NhZmVfc3lzdl9p
cGMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAxNCArKysrKysrKystLS0tLQo+ID4gIGxpYi9z
YWZlX21hY3Jvcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMyArLS0tLS0t
LS0tLS0tCj4gPiAgbGliL3RzdF9jZ3JvdXAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyICstCj4gPiAgbGliL3RzdF9zYWZlX2ZpbGVfYXQuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDExICsrKy0tLS0tLS0tCj4gPiAgbGliL3RzdF9zYWZlX3N5c3ZfaXBjLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEwICstLS0tLS0tLS0KPiA+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMS5jIHwgIDIgKy0KPiA+ICB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMi5jIHwgIDIgKy0KPiA+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMy5jIHwgIDIg
Ky0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0eGF0dHIwMS5j
IHwgIDIgKy0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0eGF0
dHIwMi5jIHwgIDIgKy0KPiA+ICAxNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA0
OSBkZWxldGlvbnMoLSkKCj4gPiAtLSAKPiA+IDIuMjUuMQoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
