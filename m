Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C2FC6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 828613D0EC8
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:26:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053763CFEBC
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:26:20 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D93D600F40
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:26:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9429D37463;
 Tue, 26 Mar 2024 14:26:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8017813688;
 Tue, 26 Mar 2024 14:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bOdKHgvbAmakPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Mar 2024 14:26:19 +0000
Date: Tue, 26 Mar 2024 15:23:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kogure =?utf-8?B?QWtpaGlzYeOAgCgg5bCP5pqu44CA5piO5LmFICk=?=
 <akihisa.kogure.ke@kyocera.jp>
Message-ID: <ZgLaddvHSGVBhnU1@rei>
References: <TYAPR01MB6044D2E0749663D84DE1F395D9352@TYAPR01MB6044.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TYAPR01MB6044D2E0749663D84DE1F395D9352@TYAPR01MB6044.jpnprd01.prod.outlook.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 9429D37463
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] input_helper: Modify the check range of the input
 event number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gSWYgdGhlIGlucHV0IGV2ZW50IG51bWJlciBpcyBncmVhdGVyIHRoYW4gMzIsIHRoZSBu
ZXdseSBhZGRlZCBldmVudCBJRAo+IHdpbGwgYmUgMjU2IG9yIGxhdGVyLgoKSSd2ZSB0cmllZCBp
dCBhbmQgaXQgc2VlbXMgdG8gd29yayB0aGF0IHdheSwgYnV0IGl0IHN0cmFuZ2Ugd2h5IHRoZXNl
CmFyZSBudW1iZXJlZCBkaXNjb250aW5vdXNseS4gTWF5IGJlIGV2ZW4gYSBidWcuCgo+IFdoZW4g
dGhlcmUgd2VyZSBhbHJlYWR5IDMyIGlucHV0IGV2ZW50cyBpbiB0aGUgZGV2aWNlLCB0aGlzIHRl
c3QgcHJvZ3JhbQo+IG9ubHkgY2hlY2tlZCAwfjk5LCBzbyBpdCBmYWlsZWQgYmVjYXVzZSBpdCBj
b3VsZCBub3QgZmluZCBhIG5ldyBpbnB1dAo+IGV2ZW50IElELgo+IEluIG9yZGVyIHRvIGVsaW1p
bmF0ZSB0aGlzIGZhaWx1cmUsIHdlIGNoYW5nZWQgdGhlIGV2ZW50IElEIHJhbmdlIHRvIGJlCj4g
Y2hlY2tlZCBieSB0aGlzIHRlc3QgcHJvZ3JhbSB0byAwfjM1NiAoMjU2KzEwMCkuCgpJIGd1ZXNz
IHRoYXQgc2luY2Ugd2UgYXJlIGNoYW5naW5nIHRoZSBjb2RlIHdlIGNhbiBhcyB3ZWxsIGFkZCBh
IGJpZ2dlcgp2YWx1ZSB0aGVyZS4gTGV0J3MgYnVtcCBpdCBhdCBsZWFzdCB0ZW4gdGltZXMgc28g
dGhhdCB3ZSBkb24ndCBoYXZlIHRvCmNoYW5nZSBpdCBhZ2FpbiBsYXRlciBvbi4KCj4gQnVnOiAz
MzAyNjk5ODQKPiBUZXN0OiBsdHAKPiBDaGFuZ2UtSWQ6IEkxYjUzMDA4YjE1NjQxZmNkY2NmMjE0
YWY5MTgzZGUxYzI5YTMzMDljCj4gLS0tCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvaW5wdXQvaW5wdXRfaGVscGVyLmMgYi90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2hl
bHBlci5jCj4gaW5kZXggYzkyOWRlNi4uZjA4NmFlNSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL2lucHV0L2lucHV0X2hlbHBlci5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pbnB1
dC9pbnB1dF9oZWxwZXIuYwo+IEBAIC00MSw3ICs0MSw3IEBACj4gIOKAguKAguKAguKAguKAgmlu
dCByZXQsIGZkID0gLTE7Cj4gIOKAguKAguKAguKAguKAgnVuc2lnbmVkIGludCBpOwo+IAo+IC3i
gILigILigILigILigIJmb3IgKGkgPSAwOyBpIDwgMTAwOyBpKyspIHsKPiAr4oCC4oCC4oCC4oCC
4oCCZm9yIChpID0gMDsgaSA8IDM1NjsgaSsrKSB7Cj4gIOKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAgnNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIi9kZXYvaW5wdXQvZXZlbnQl
aSIsIGkpOwo+IAo+ICDigILigILigILigILigILigILigILigILigILigILigIJmZCA9IG9wZW4o
cGF0aCwgT19SRE9OTFkpOwo+IAo+IAo+IC0tIAo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1
c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
