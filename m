Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4551C3601E
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:19:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFD703CAF77
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:19:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D25A3CA0EF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:19:09 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F6501A00A33
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:19:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC21C21174;
 Mon,  7 Apr 2025 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744028347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViBPNfFjcPJPWvCbzLYx51mN4OEEdhAC7pi4Ou5SwHU=;
 b=02g1NMro/hf4S68S+ou0T3mG3XzKllwq5fCpMnAVV/hqtTmQqdF4mUg9jt9O0rsdmIW+ZC
 nXLD3IxhOe3UHoO4Yh9IXLkr1vbhJls3AaA5Gt9jURLn61nTfUoZ7Iv6JoHrlpyy8FXDce
 344kiUeYhrUGpnp2tyEDZbfu0yzLl7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744028347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViBPNfFjcPJPWvCbzLYx51mN4OEEdhAC7pi4Ou5SwHU=;
 b=7l/Vv2SxHv6dsIVhVrUQHR81GoqjH+eY631cj1fbw3S3hRN/Cg2h289NQdotMpQj/R3Mkk
 Fj5i5MEwqRx0fBBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=02g1NMro;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7l/Vv2Sx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744028347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViBPNfFjcPJPWvCbzLYx51mN4OEEdhAC7pi4Ou5SwHU=;
 b=02g1NMro/hf4S68S+ou0T3mG3XzKllwq5fCpMnAVV/hqtTmQqdF4mUg9jt9O0rsdmIW+ZC
 nXLD3IxhOe3UHoO4Yh9IXLkr1vbhJls3AaA5Gt9jURLn61nTfUoZ7Iv6JoHrlpyy8FXDce
 344kiUeYhrUGpnp2tyEDZbfu0yzLl7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744028347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViBPNfFjcPJPWvCbzLYx51mN4OEEdhAC7pi4Ou5SwHU=;
 b=7l/Vv2SxHv6dsIVhVrUQHR81GoqjH+eY631cj1fbw3S3hRN/Cg2h289NQdotMpQj/R3Mkk
 Fj5i5MEwqRx0fBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 042FB13691;
 Mon,  7 Apr 2025 12:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p6rgObrC82edfAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 12:19:06 +0000
Date: Mon, 7 Apr 2025 14:19:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250407121905.GB87982@pevik>
References: <20250403101912.459507-1-pvorel@suse.cz>
 <20250403101912.459507-3-pvorel@suse.cz>
 <CAEemH2dsdhgKNHTJY8apYEoe1a2RWrZFvMefd8rML1GwP8Lxkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dsdhgKNHTJY8apYEoe1a2RWrZFvMefd8rML1GwP8Lxkw@mail.gmail.com>
X-Rspamd-Queue-Id: BC21C21174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkKClsgQ2MgYXV0b21hdGVkLXRlc3RpbmcsIFRpbSBhbmQgQW5kZXJzOiBGWUkgZGlzcnVwdGl2
ZSBjaGFuZ2UsCmNvbnRlbnQgb2YgcnVudGVzdC9pcGMgaXMgbW92ZWQgaW50byBydW50ZXN0L3N5
c2NhbGxzIF0KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBPbiBUaHUsIEFwciAzLCAyMDI1IGF0IDY6
MTnigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSXQncyBub3Qg
d29ydGggdG8ga2VlcCBzZXBhcmF0ZSBydW50ZXN0IGZpbGUgZm9yIDggdmVyeSBxdWljayB0ZXN0
cy4KPiA+IHN5c2NhbGxzLWlwYyB3b3VsZCBiZSBvYnZpb3VzIHJ1bnRlc3QgdG8gbW92ZSwgYnV0
IGl0IGNvbnRhaW5zIHRlc3RzIGZvcgo+ID4gbWVzc2FnZSBxdWV1ZXMsIHNlbWFwaG9yZXMgZXRj
LiBPdGhlciBJUEMgdGVzdHMgYXJlIGluIHN5c2NhbGxzIHJ1bnRlc3QsCj4gPiB0aGVyZWZvcmUg
bW92ZSB0ZXN0cyB0aGVyZS4KCj4gPiBSZW1vdmUgdGVzdCBkZXNjcmlwdGlvbiAoY2FuIGJlIHZp
c2libGUgZnJvbSBoZWxwIGFuZCB0aGUgdGVzdCBvdXRwdXQsCj4gPiBpdCB3YXMgYWxzbyBiZWxv
dyB0aGUgdGVzdCBub3QgYWJvdmUpLgoKPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PgoKPiAtLS0KPiA+ICBydW50ZXN0L2lwYyAgICAgIHwgMjggLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gIHJ1bnRlc3Qvc3lzY2FsbHMgfCAgOSArKysrKysrKysK
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCj4g
PiAgZGVsZXRlIG1vZGUgMTAwNjQ0IHJ1bnRlc3QvaXBjCgo+ID4gZGlmZiAtLWdpdCBhL3J1bnRl
c3QvaXBjIGIvcnVudGVzdC9pcGMKPiA+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5k
ZXggZjVjZGVhMTk3NC4uMDAwMDAwMDAwMAo+ID4gLS0tIGEvcnVudGVzdC9pcGMKPiA+ICsrKyAv
ZGV2L251bGwKPiA+IEBAIC0xLDI4ICswLDAgQEAKCgoKPiA+IC0jREVTQ1JJUFRJT046SW50ZXJw
cm9jZXNzIGNvbW11bmljYXRpb24gc3RyZXNzCj4gPiAtIyBUaGVzZSB0ZXN0cyB1c2UgdGVzdHMv
cGlwZWlvIHRvIHB1dCBwaXBlcyAobmFtZWQgb3IgdW5uYW1lZCkgdGhyb3VnaCBhCj4gPiB3b3Jr
b3V0CgoKCj4gPiAtIwo+ID4gLXBpcGVpb18xIHBpcGVpbyAtVCBwaXBlaW9fMSAtYyA1IC1zIDQw
OTAgLWkgMTAwIC1iIC1mIHg4MAo+ID4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAw
IGNodW5rcyBvZiA0MDkwIGJ5dGVzIHRvIGEgbmFtZWQgcGlwZQo+ID4gLSMgdXNpbmcgYmxvY2tp
bmcgSS9PCj4gPiAtcGlwZWlvXzIgcGlwZWlvIC1UIHBpcGVpb18yIC1jIDUgLXMgNDA5MCAtaSAx
MDAgLWYgeDgwCj4gPiAtIyBzcGF3bnMgNSBjaGlsZHJlbiB0byB3cml0ZSAxMDAgY2h1bmtzIG9m
IDQwOTAgYnl0ZXMgdG8gYSBuYW1lZCBwaXBlCj4gPiAtIyB1c2luZyBub24tYmxvY2tpbmcgSS9P
Cj4gPiAtcGlwZWlvXzMgcGlwZWlvIC1UIHBpcGVpb18zIC1jIDUgLXMgNDA5MCAtaSAxMDAgLXUg
LWIgLWYgeDgwCj4gPiAtIyBzcGF3bnMgNSBjaGlsZHJlbiB0byB3cml0ZSAxMDAgY2h1bmtzIG9m
IDQwOTAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBlCj4gPiAtIyB1c2luZyBibG9ja2luZyBJL08K
PiA+IC1waXBlaW9fNCBwaXBlaW8gLVQgcGlwZWlvXzQgLWMgNSAtcyA0MDkwIC1pIDEwMCAtdSAt
ZiB4ODAKPiA+IC0jIHNwYXducyA1IGNoaWxkcmVuIHRvIHdyaXRlIDEwMCBjaHVua3Mgb2YgNDA5
MCBieXRlcyB0byBhbiB1bm5hbWVkIHBpcGUKPiA+IC0jIHVzaW5nIG5vbi1ibG9ja2luZyBJL08K
PiA+IC1waXBlaW9fNSBwaXBlaW8gLVQgcGlwZWlvXzUgLWMgNSAtcyA1MDAwIC1pIDEwIC1iIC1m
IHg4MAo+ID4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1bmtzIG9mIDUwMDAg
Ynl0ZXMgdG8gYSBuYW1lZCBwaXBlCj4gPiAtIyB1c2luZyBibG9ja2luZyBJL08KPiA+IC1waXBl
aW9fNiBwaXBlaW8gLVQgcGlwZWlvXzYgLWMgNSAtcyA1MDAwIC1pIDEwIC1iIC11IC1mIHg4MAo+
ID4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1bmtzIG9mIDUwMDAgYnl0ZXMg
dG8gYW4gdW5uYW1lZCBwaXBlCj4gPiAtIyB1c2luZyBibG9ja2luZyBJL08KPiA+IC1waXBlaW9f
NyBwaXBlaW8gLVQgcGlwZWlvXzcgLWMgNSAtcyA1MDAwIC1pIDEwIC1mIHg4MAo+ID4gLSMgc3Bh
d25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1bmtzIG9mIDUwMDAgYnl0ZXMgdG8gYSBuYW1l
ZCBwaXBlCj4gPiAtIyB1c2luZyBub24tYmxvY2tpbmcgSS9PCj4gPiAtcGlwZWlvXzggcGlwZWlv
IC1UIHBpcGVpb184IC1jIDUgLXMgNTAwMCAtaSAxMCAtdSAtZiB4ODAKPiA+IC0jIHNwYXducyA1
IGNoaWxkcmVuIHRvIHdyaXRlIDEwIGNodW5rcyBvZiA1MDAwIGJ5dGVzIHRvIGFuIHVubmFtZWQg
cGlwZQo+ID4gLSMgdXNpbmcgbm9uLWJsb2NraW5nIEkvTwo+ID4gLQo+ID4gZGlmZiAtLWdpdCBh
L3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4gPiBpbmRleCAwNWIzZTBkMzc2
Li5iOTExYWJhN2I2IDEwMDY0NAo+ID4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+ID4gKysrIGIv
cnVudGVzdC9zeXNjYWxscwo+ID4gQEAgLTEwNDcsNiArMTA0NywxNSBAQCBwaXBlMl8wMSBwaXBl
Ml8wMQo+ID4gIHBpcGUyXzAyIHBpcGUyXzAyCj4gPiAgcGlwZTJfMDQgcGlwZTJfMDQKCgo+IE1h
eWJlIHdlIGNhbiBhZGQgb25lLWxpbmUgY29tbWVudHMgaGVyZSB0byBleHBsYWluIHRoYXQgdGhl
c2UgYXJlCj4gSW50ZXJwcm9jZXNzIGNvbW11bmljYXRpb24gc3RyZXNzIHRlc3Q/Cgo+IFNpbmNl
IHN5c2NhbGxzIGlzIGEgbGFyZ2UgZmlsZSAoY29udGFpbmluZyBzbyBtYW55IHRlc3RzKSwgaXQg
bWFrZXMgc2Vuc2UKPiB0byBjb21tZW50IG9uIHNvbWV0aGluZyB0aGVyZSB0byBleHBsYWluIHRo
ZSBzdWJ0ZXN0IGJsb2Nrcy4KCgo+ICtwaXBlaW9fMSBwaXBlaW8gLVQgcGlwZWlvXzEgLWMgNSAt
cyA0MDkwIC1pIDEwMCAtYiAtZiB4ODAKPiA+ICtwaXBlaW9fMiBwaXBlaW8gLVQgcGlwZWlvXzIg
LWMgNSAtcyA0MDkwIC1pIDEwMCAtZiB4ODAKPiA+ICtwaXBlaW9fMyBwaXBlaW8gLVQgcGlwZWlv
XzMgLWMgNSAtcyA0MDkwIC1pIDEwMCAtdSAtYiAtZiB4ODAKPiA+ICtwaXBlaW9fNCBwaXBlaW8g
LVQgcGlwZWlvXzQgLWMgNSAtcyA0MDkwIC1pIDEwMCAtdSAtZiB4ODAKPiA+ICtwaXBlaW9fNSBw
aXBlaW8gLVQgcGlwZWlvXzUgLWMgNSAtcyA1MDAwIC1pIDEwIC1iIC1mIHg4MAo+ID4gK3BpcGVp
b182IHBpcGVpbyAtVCBwaXBlaW9fNiAtYyA1IC1zIDUwMDAgLWkgMTAgLWIgLXUgLWYgeDgwCj4g
PiArcGlwZWlvXzcgcGlwZWlvIC1UIHBpcGVpb183IC1jIDUgLXMgNTAwMCAtaSAxMCAtZiB4ODAK
PiA+ICtwaXBlaW9fOCBwaXBlaW8gLVQgcGlwZWlvXzggLWMgNSAtcyA1MDAwIC1pIDEwIC11IC1m
IHg4MAoKCgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
