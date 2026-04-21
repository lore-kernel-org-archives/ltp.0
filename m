Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAC0F8924D
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 10:26:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD67C3E2927
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4AAE3C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 12:26:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85FFD1000954
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 12:26:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC52E5BCDE;
 Tue, 21 Apr 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C74C8593AF;
 Tue, 21 Apr 2026 10:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TwhKB9pQ52nEWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Apr 2026 10:26:34 +0000
Date: Tue, 21 Apr 2026 12:26:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260421102628.GA505866@pevik>
References: <20260416144213.27221-1-mdoucha@suse.cz>
 <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
 <20260417130920.GA420978@pevik>
 <d5b21bfa-5fd7-4e2d-b1c0-c89c6b509dbb@suse.cz>
 <20260417144445.GA426937@pevik>
 <4b48d98e-9e2d-4ee9-8d1f-b92020357b47@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4b48d98e-9e2d-4ee9-8d1f-b92020357b47@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DC52E5BCDE
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Add common entry point function for all tests
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

PiBPbiA0LzE3LzI2IDE2OjQ0LCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gPiA+ID4gVGhpcyBjaGFu
Z2VzIHZlcmJhdGltIFBPU0lYIHNwZWNpZmljYXRpb24gdGV4dC4gVGhlIGFzc2VydGlvbnMueG1s
IGZpbGVzCj4gPiA+ID4gPiBxdW90ZSB0aGUgUE9TSVggc3RhbmRhcmQsIHdoaWNoIGRlZmluZXMg
YmVoYXZpb3VyIHJlbGF0aXZlIHRvIG1haW4oKSDigJQgdGhlIEMKPiA+ID4gPiA+IGVudHJ5IHBv
aW50LCBub3QgYW4gTFRQLWludGVybmFsIGZ1bmN0aW9uIG5hbWUuIFJldmVydCB0aGVzZSBodW5r
cyBpbiBib3RoCj4gPiA+ID4gPiBwdGhyZWFkX2NyZWF0ZS9hc3NlcnRpb25zLnhtbCBhbmQgcHRo
cmVhZF9leGl0L2Fzc2VydGlvbnMueG1sLgoKPiA+ID4gPiArMQoKPiA+ID4gVGhpcyAiaXNzdWUi
IGlzIG5vbnNlbnNlLiBJJ3ZlIGNoZWNrZWQgdGhlIFhNTCBmaWxlcyBhbmQgdGhlIGFzc2VydGlv
bnMgYXJlCj4gPiA+IHN0aWxsIGNvcnJlY3QgYXMgaXMgcmVnYXJkbGVzcyBvZiByZW5hbWluZyBh
IGZldyBmdW5jdGlvbnMuIFRoZQo+ID4gPiBwdGhyZWFkX2NyZWF0ZSgpIGFuZCBwdGhyZWFkX2V4
aXQoKSBzcGVjaWZpY2F0aW9uIGFwcGxpZXMgc3BlY2lhbCB0cmVhdG1lbnQKPiA+ID4gdG8gdGhl
IG1haW4gdGhyZWFkIGFuZCBhZGRpbmcgb25lIG1vcmUgZnVuY3Rpb24gY2FsbCBiZXR3ZWVuIHRo
ZSBtYWluKCkKPiA+ID4gZnVuY3Rpb24gYW5kIHRoZSB0ZXN0IGNvZGUgZG9lcyBub3QgY2hhbmdl
IHRoYXQuCgo+ID4gSSB1bmRlcnN0b29kIHRoYXQgc3BlYyB0YWxrcyBhYm91dCBtYWluKCkgYXMg
YSBzcGVjaWZpYyBDIHN0YXJ0dXAgZnVuY3Rpb24uCj4gPiBCdXQgb2ssIEkgd2FzIHByb2JhYmx5
IHdyb25nLgoKPiBUaGUgc3BlYyBET0VTIHRhbGsgYWJvdXQgbWFpbigpIGFzIHRoZSBDIHByb2Nl
c3Mgc3RhcnR1cCBmdW5jdGlvbi4gQnV0IHRoZQo+IEFJIGZvciBzb21lIHJlYXNvbiBiZWxpZXZl
cyB0aGF0IG15IHBhdGNoIGNhbiBzb21laG93IHJld3JpdGUgdGhlIFBPU0lYCj4gc3RhbmRhcmQg
aXRzZWxmLgoKSSB1bmRlcnN0YW5kIGl0IGRpZmZlcmVudGx5OiBrZWVwIG1haW4oKSBiZWNhdXNl
IHRoYXQncyB0aGUgQyBlbnRyeSBmdW5jdGlvbgphbmQgYW55IHJlYWRlciBvZiBhc3NlcnRpb25z
LnhtbCBkb2VzIG5vdCByZWFsbHkgY2FyZSBhYm91dCBvdXIgaW1wbGVtZW50YXRpb24KdGhhdCB3
ZSB3cmFwIG1haW4oKSB3aXRoIG90aGVyIGZ1bmN0aW9uIGZvciBvdXIgaW50ZXJuYWwgcHVycG9z
ZXMgb2Ygb3RoZXIgdGVzdApzY2VuYXJpby4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
