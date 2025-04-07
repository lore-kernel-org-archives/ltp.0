Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D224CC3601E
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:15:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40FB03CAFB2
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:15:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C604B3C00CC
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:15:40 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEA19600828
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:15:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F136B1F388;
 Mon,  7 Apr 2025 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744028138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grDcqFdtT9ZEflW+3FBO4SHN+ml16sHtGS6CM7G2q8Q=;
 b=mw8qUQk/PYQzItFdJe9159Oxs/ziJDdIeFoUWp3QXcGudRABguRlIIlBwI+qztBqVEl/Pl
 f/XeJPchGIpiercbsMI5hIB4Db0+EfzuJmhweXdQFbonMIjR3vA8vwJWNFfMOtcSHiG7lX
 EknanYV3VM0q7S0jyYZEqDQYH8Ye9lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744028138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grDcqFdtT9ZEflW+3FBO4SHN+ml16sHtGS6CM7G2q8Q=;
 b=ailrhyn9FqqPlBPv+SlXL4+GB537BMXQan0r+f4DYh6iJDbQPayEX+jecA8z7sg8CdcQmG
 73cmBgBzRDMM6GDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744028137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grDcqFdtT9ZEflW+3FBO4SHN+ml16sHtGS6CM7G2q8Q=;
 b=X+NF6IBu230QcUB0uF3GNpNoslocWCqb9ZVbEWUuIsBHssd7W8yfJiUTyzkoO+VGdJWNqf
 BWy1EDGofl7sXCFLQC128ifBq0TzrGndBJTov4/Ypx8k/mFSTVkiYeK9l2AgOzhjNNKzoN
 bfYw3AYx6ezKPGHS0UeZYlx2yuigzB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744028137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grDcqFdtT9ZEflW+3FBO4SHN+ml16sHtGS6CM7G2q8Q=;
 b=u1rqNT+70qIGGS1bn1Tc2/7VOreFQDKKX2W7eTuWnLLQhCIi7hPqnsggl2akUTJD9HCNzC
 Hep6z7uhSqqfgsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76CDF13691;
 Mon,  7 Apr 2025 12:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ldY7GunB82dSewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 12:15:37 +0000
Date: Mon, 7 Apr 2025 14:15:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250407121532.GA87982@pevik>
References: <20250403101912.459507-1-pvorel@suse.cz>
 <20250403101912.459507-3-pvorel@suse.cz>
 <CAEemH2dsdhgKNHTJY8apYEoe1a2RWrZFvMefd8rML1GwP8Lxkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dsdhgKNHTJY8apYEoe1a2RWrZFvMefd8rML1GwP8Lxkw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 2/2] runtest: Move ipc into syscalls
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

SGksCgo+IE9uIFRodSwgQXByIDMsIDIwMjUgYXQgNjoxOeKAr1BNIFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PiB3cm90ZToKCj4gPiBJdCdzIG5vdCB3b3J0aCB0byBrZWVwIHNlcGFyYXRlIHJ1
bnRlc3QgZmlsZSBmb3IgOCB2ZXJ5IHF1aWNrIHRlc3RzLgo+ID4gc3lzY2FsbHMtaXBjIHdvdWxk
IGJlIG9idmlvdXMgcnVudGVzdCB0byBtb3ZlLCBidXQgaXQgY29udGFpbnMgdGVzdHMgZm9yCj4g
PiBtZXNzYWdlIHF1ZXVlcywgc2VtYXBob3JlcyBldGMuIE90aGVyIElQQyB0ZXN0cyBhcmUgaW4g
c3lzY2FsbHMgcnVudGVzdCwKPiA+IHRoZXJlZm9yZSBtb3ZlIHRlc3RzIHRoZXJlLgoKPiA+IFJl
bW92ZSB0ZXN0IGRlc2NyaXB0aW9uIChjYW4gYmUgdmlzaWJsZSBmcm9tIGhlbHAgYW5kIHRoZSB0
ZXN0IG91dHB1dCwKPiA+IGl0IHdhcyBhbHNvIGJlbG93IHRoZSB0ZXN0IG5vdCBhYm92ZSkuCgo+
ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cgo+IC0tLQo+ID4g
IHJ1bnRlc3QvaXBjICAgICAgfCAyOCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiAg
cnVudGVzdC9zeXNjYWxscyB8ICA5ICsrKysrKysrKwo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgcnVu
dGVzdC9pcGMKCj4gPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9pcGMgYi9ydW50ZXN0L2lwYwo+ID4g
ZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCBmNWNkZWExOTc0Li4wMDAwMDAwMDAw
Cj4gPiAtLS0gYS9ydW50ZXN0L2lwYwo+ID4gKysrIC9kZXYvbnVsbAo+ID4gQEAgLTEsMjggKzAs
MCBAQAoKCgo+ID4gLSNERVNDUklQVElPTjpJbnRlcnByb2Nlc3MgY29tbXVuaWNhdGlvbiBzdHJl
c3MKPiA+IC0jIFRoZXNlIHRlc3RzIHVzZSB0ZXN0cy9waXBlaW8gdG8gcHV0IHBpcGVzIChuYW1l
ZCBvciB1bm5hbWVkKSB0aHJvdWdoIGEKPiA+IHdvcmtvdXQKCgoKPiA+IC0jCj4gPiAtcGlwZWlv
XzEgcGlwZWlvIC1UIHBpcGVpb18xIC1jIDUgLXMgNDA5MCAtaSAxMDAgLWIgLWYgeDgwCj4gPiAt
IyBzcGF3bnMgNSBjaGlsZHJlbiB0byB3cml0ZSAxMDAgY2h1bmtzIG9mIDQwOTAgYnl0ZXMgdG8g
YSBuYW1lZCBwaXBlCj4gPiAtIyB1c2luZyBibG9ja2luZyBJL08KPiA+IC1waXBlaW9fMiBwaXBl
aW8gLVQgcGlwZWlvXzIgLWMgNSAtcyA0MDkwIC1pIDEwMCAtZiB4ODAKPiA+IC0jIHNwYXducyA1
IGNoaWxkcmVuIHRvIHdyaXRlIDEwMCBjaHVua3Mgb2YgNDA5MCBieXRlcyB0byBhIG5hbWVkIHBp
cGUKPiA+IC0jIHVzaW5nIG5vbi1ibG9ja2luZyBJL08KPiA+IC1waXBlaW9fMyBwaXBlaW8gLVQg
cGlwZWlvXzMgLWMgNSAtcyA0MDkwIC1pIDEwMCAtdSAtYiAtZiB4ODAKPiA+IC0jIHNwYXducyA1
IGNoaWxkcmVuIHRvIHdyaXRlIDEwMCBjaHVua3Mgb2YgNDA5MCBieXRlcyB0byBhbiB1bm5hbWVk
IHBpcGUKPiA+IC0jIHVzaW5nIGJsb2NraW5nIEkvTwo+ID4gLXBpcGVpb180IHBpcGVpbyAtVCBw
aXBlaW9fNCAtYyA1IC1zIDQwOTAgLWkgMTAwIC11IC1mIHg4MAo+ID4gLSMgc3Bhd25zIDUgY2hp
bGRyZW4gdG8gd3JpdGUgMTAwIGNodW5rcyBvZiA0MDkwIGJ5dGVzIHRvIGFuIHVubmFtZWQgcGlw
ZQo+ID4gLSMgdXNpbmcgbm9uLWJsb2NraW5nIEkvTwo+ID4gLXBpcGVpb181IHBpcGVpbyAtVCBw
aXBlaW9fNSAtYyA1IC1zIDUwMDAgLWkgMTAgLWIgLWYgeDgwCj4gPiAtIyBzcGF3bnMgNSBjaGls
ZHJlbiB0byB3cml0ZSAxMCBjaHVua3Mgb2YgNTAwMCBieXRlcyB0byBhIG5hbWVkIHBpcGUKPiA+
IC0jIHVzaW5nIGJsb2NraW5nIEkvTwo+ID4gLXBpcGVpb182IHBpcGVpbyAtVCBwaXBlaW9fNiAt
YyA1IC1zIDUwMDAgLWkgMTAgLWIgLXUgLWYgeDgwCj4gPiAtIyBzcGF3bnMgNSBjaGlsZHJlbiB0
byB3cml0ZSAxMCBjaHVua3Mgb2YgNTAwMCBieXRlcyB0byBhbiB1bm5hbWVkIHBpcGUKPiA+IC0j
IHVzaW5nIGJsb2NraW5nIEkvTwo+ID4gLXBpcGVpb183IHBpcGVpbyAtVCBwaXBlaW9fNyAtYyA1
IC1zIDUwMDAgLWkgMTAgLWYgeDgwCj4gPiAtIyBzcGF3bnMgNSBjaGlsZHJlbiB0byB3cml0ZSAx
MCBjaHVua3Mgb2YgNTAwMCBieXRlcyB0byBhIG5hbWVkIHBpcGUKPiA+IC0jIHVzaW5nIG5vbi1i
bG9ja2luZyBJL08KPiA+IC1waXBlaW9fOCBwaXBlaW8gLVQgcGlwZWlvXzggLWMgNSAtcyA1MDAw
IC1pIDEwIC11IC1mIHg4MAo+ID4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1
bmtzIG9mIDUwMDAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBlCj4gPiAtIyB1c2luZyBub24tYmxv
Y2tpbmcgSS9PCj4gPiAtCj4gPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRl
c3Qvc3lzY2FsbHMKPiA+IGluZGV4IDA1YjNlMGQzNzYuLmI5MTFhYmE3YjYgMTAwNjQ0Cj4gPiAt
LS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gPiArKysgYi9ydW50ZXN0L3N5c2NhbGxzCj4gPiBAQCAt
MTA0Nyw2ICsxMDQ3LDE1IEBAIHBpcGUyXzAxIHBpcGUyXzAxCj4gPiAgcGlwZTJfMDIgcGlwZTJf
MDIKPiA+ICBwaXBlMl8wNCBwaXBlMl8wNAoKCj4gTWF5YmUgd2UgY2FuIGFkZCBvbmUtbGluZSBj
b21tZW50cyBoZXJlIHRvIGV4cGxhaW4gdGhhdCB0aGVzZSBhcmUKPiBJbnRlcnByb2Nlc3MgY29t
bXVuaWNhdGlvbiBzdHJlc3MgdGVzdD8KCj4gU2luY2Ugc3lzY2FsbHMgaXMgYSBsYXJnZSBmaWxl
IChjb250YWluaW5nIHNvIG1hbnkgdGVzdHMpLCBpdCBtYWtlcyBzZW5zZQo+IHRvIGNvbW1lbnQg
b24gc29tZXRoaW5nIHRoZXJlIHRvIGV4cGxhaW4gdGhlIHN1YnRlc3QgYmxvY2tzLgoKSGkgTGks
CgpzdXJlLCBJIGNhbiBhZGQgIiMgSW50ZXJwcm9jZXNzIGNvbW11bmljYXRpb24gc3RyZXNzIHRl
c3RzIiBiZWZvcmUgbWVyZ2UuCkJlY2F1c2UgY2hhbmdlIGlzIHRyaXZpYWwsIGluc3RlYWQgb2Yg
cmVzZW5kaW5nIHYyIEkganVzdCBwb3N0IGEgZGlmZiBiZWxvdy4KCktpbmQgcmVnYXJkcywKUGV0
cgoKPiA+ICtwaXBlaW9fMSBwaXBlaW8gLVQgcGlwZWlvXzEgLWMgNSAtcyA0MDkwIC1pIDEwMCAt
YiAtZiB4ODAKPiA+ICtwaXBlaW9fMiBwaXBlaW8gLVQgcGlwZWlvXzIgLWMgNSAtcyA0MDkwIC1p
IDEwMCAtZiB4ODAKPiA+ICtwaXBlaW9fMyBwaXBlaW8gLVQgcGlwZWlvXzMgLWMgNSAtcyA0MDkw
IC1pIDEwMCAtdSAtYiAtZiB4ODAKPiA+ICtwaXBlaW9fNCBwaXBlaW8gLVQgcGlwZWlvXzQgLWMg
NSAtcyA0MDkwIC1pIDEwMCAtdSAtZiB4ODAKPiA+ICtwaXBlaW9fNSBwaXBlaW8gLVQgcGlwZWlv
XzUgLWMgNSAtcyA1MDAwIC1pIDEwIC1iIC1mIHg4MAo+ID4gK3BpcGVpb182IHBpcGVpbyAtVCBw
aXBlaW9fNiAtYyA1IC1zIDUwMDAgLWkgMTAgLWIgLXUgLWYgeDgwCj4gPiArcGlwZWlvXzcgcGlw
ZWlvIC1UIHBpcGVpb183IC1jIDUgLXMgNTAwMCAtaSAxMCAtZiB4ODAKPiA+ICtwaXBlaW9fOCBw
aXBlaW8gLVQgcGlwZWlvXzggLWMgNSAtcyA1MDAwIC1pIDEwIC11IC1mIHg4MAoKCgo+IFJldmll
d2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCmRpZmYgLS1naXQgcnVudGVzdC9z
eXNjYWxscyBydW50ZXN0L3N5c2NhbGxzCmluZGV4IGE1ZWUxYWEwNmMuLjc3MTljYjIwNzUgMTAw
NjQ0Ci0tLSBydW50ZXN0L3N5c2NhbGxzCisrKyBydW50ZXN0L3N5c2NhbGxzCkBAIC0xMDQ5LDYg
KzEwNDksNyBAQCBwaXBlMl8wMSBwaXBlMl8wMQogcGlwZTJfMDIgcGlwZTJfMDIKIHBpcGUyXzA0
IHBpcGUyXzA0CiAKKyMgSW50ZXJwcm9jZXNzIGNvbW11bmljYXRpb24gc3RyZXNzIHRlc3RzCiBw
aXBlaW9fMSBwaXBlaW8gLVQgcGlwZWlvXzEgLWMgNSAtcyA0MDkwIC1pIDEwMCAtYiAtZiB4ODAK
IHBpcGVpb18yIHBpcGVpbyAtVCBwaXBlaW9fMiAtYyA1IC1zIDQwOTAgLWkgMTAwIC1mIHg4MAog
cGlwZWlvXzMgcGlwZWlvIC1UIHBpcGVpb18zIC1jIDUgLXMgNDA5MCAtaSAxMDAgLXUgLWIgLWYg
eDgwCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
