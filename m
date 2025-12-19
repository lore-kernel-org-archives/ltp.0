Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E26ED78777
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:04:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 332A63D0533
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:04:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DDA93C5624
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:04:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4FFB0200D00
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:04:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A068C5BD33;
 Fri, 19 Dec 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 033653EA63;
 Fri, 19 Dec 2025 14:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5UPkOVFbRWmrNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 14:04:01 +0000
Date: Fri, 19 Dec 2025 15:03:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251219140356.GA187465@pevik>
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
 <CAEemH2dwp0KUHpo+gVzBUNdDPJMo2xiZ59apHBWx=M_mmC7Y6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dwp0KUHpo+gVzBUNdDPJMo2xiZ59apHBWx=M_mmC7Y6g@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A068C5BD33
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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

PiBPbiBGcmksIERlYyAxOSwgMjAyNSBhdCA2OjQ34oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1Ymlz
QHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiAgICAgICB0c3RfcmVzKFRJTkZPLCAiU3Vj
Y2Vzc2Z1bGx5IGNyZWF0ZWQgJWQgc3dhcCBmaWxlcyIsIHN3YXBmaWxlcyk7Cj4gPiA+IC0gICAg
IE1BS0VfU01BTExfU1dBUEZJTEUoVEVTVF9GSUxFKTsKCj4gPiBUaGlzIHNob3VsZCBzdGF5IGhl
cmUsIHJpZ2h0PyBJIHN1cHBvc2UgdGhhdCB0aGUgdGVzdCB3b3JrcyBldmVuIHdoZW4gd2UKPiA+
IHBhc3Mgbm9uLWV4aXN0aW5nIGZpbGUgaW4gdGhlIHZlcmlmeV9zd2Fwb24oKSBidXQgd2Ugc2hv
dWxkbid0IGJldCBvbgo+ID4gdGhhdC4KCgo+IE5vdCBleGFjdGx5LCAgSSBndWVzcyBoZXJlIGRl
bGV0ZWQgaXQgYmVjYXVzZSBpc19zd2FwX3N1cHBvcnRlZChURVNUX0ZJTEUpCj4gaGFkIGFscmVh
ZHkgY3JlYXRlZCB0aGUgZmlsZSBidXQgZGlkbid0IGNsZWFuIGl0IHVwIGluIHNldHVwLCBzbyBp
dCBzdGlsbAo+IGV4aXN0cy4KClllcy4KCj4gT3IsIHdlIG5lZWQgdG8gZG8gaXMgaW1wcm92ZSBp
c19zd2FwX3N1cHBvcnRlZCgpLCByZW1vdmUgdGhlIGFueSB0ZXN0IGZpbGUsCj4gYW5kIHRoZW4g
YWRkIGl0IGJhY2sgc2VwYXJhdGVseS4KCk15IHByZXZpb3VzIHJlcGx5OgpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sdHAvMjAyNTEyMTkxNDAyMTYuR0EyNDczNjhAcGV2aWsvCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
