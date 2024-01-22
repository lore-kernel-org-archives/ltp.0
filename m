Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9DBC47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 11:04:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B40D53CEF20
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 12:04:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C77A3CC799
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:03:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71C2E100112D
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:03:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8174622022;
 Mon, 22 Jan 2024 11:03:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5628513995;
 Mon, 22 Jan 2024 11:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7ofUE5FLrmVwEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 11:03:45 +0000
Date: Mon, 22 Jan 2024 12:03:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122110344.GB95077@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8174622022
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

PiBIaSBQZXRyLAoKPiBPbiBNb24sIEphbiAyMiwgMjAyNCBhdCA1OjE04oCvUE0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gVGhpcyBpbnRyb2R1
Y2UgYW4gZW5oYW5jZW1lbnQgdG8gdGhlIGxpYnJhcnkncyBpc19zd2FwX3N1cHBvcnRlZAo+ID4g
PiBmdW5jdGlvbiB0byBjaGVjayBmb3IgZmlsZXN5c3RlbSBjb21wYXRpYmlsaXR5IGJlZm9yZSBh
dHRlbXB0aW5nCj4gPiA+IHRvIGNyZWF0ZSBhbmQgZW5hYmxlIGEgc3dhcCBmaWxlLiAgQSBsaXN0
IG9mIHN1cHBvcnRlZCBmaWxlc3lzdGVtcwo+ID4gPiBpcyBhZGRlZCAoZXh0MiwgZXh0MywgZXh0
NCwgeGZzLCB2ZmF0LCBleGZhdCwgbnRmcyksIGFuZCBhIGNoZWNrCj4gPiA+IGFnYWluc3QgdGhp
cyBsaXN0IGlzIHBlcmZvcm1lZCB0byBlbnN1cmUgdGhhdCB0aGUgc3dhcCBvcGVyYXRpb25zCj4g
PiA+IGFyZSBvbmx5IGF0dGVtcHRlZCBvbiBrbm93biBjb21wYXRpYmxlIGZpbGVzeXN0ZW1zLgoK
PiA+ID4gSWYgdGhlIG1ha2Vfc3dhcGZpbGUgZnVuY3Rpb24gZmFpbHMsIHRoZSBlcnJvciBoYW5k
bGluZyBpcyBub3cKPiA+ID4gbW9yZSBkZXNjcmlwdGl2ZTogaXQgZGlzdGluZ3Vpc2hlcyBiZXR3
ZWVuIGZhaWx1cmVzIGR1ZSB0byB0aGUKPiA+ID4gZmlsZXN5c3RlbSBub3Qgc3VwcG9ydGluZyBz
d2FwIGZpbGVzIGFuZCBvdGhlciB0eXBlcyBvZiBmYWlsdXJlcy4KPiA+ID4gU2ltaWxhcmx5LCB3
aGVuIGF0dGVtcHRpbmcgdG8gZW5hYmxlIHRoZSBzd2FwIGZpbGUgd2l0aCBzd2Fwb24sCj4gPiA+
IHRoZSBwYXRjaCBlbnN1cmVzIHRoYXQgY2xlYXJlciBlcnJvciBtZXNzYWdlcyBhcmUgcHJvdmlk
ZWQgaW4KPiA+ID4gY2FzZXMgd2hlcmUgdGhlIG9wZXJhdGlvbiBpcyBub3Qgc3VwcG9ydGVkIGJ5
IHRoZSBmaWxlc3lzdGVtLgoKPiA+ICsxCgo+ID4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PgoKPiA+IGZvcm1hdHRpbmcgaXNzdWVzICh0YWJzKSBhcmUgYWN0dWFsbHkg
bW9zdGx5IGZyb20gdGhpcyBjb21taXQsIHBsZWFzZSBmaXgKPiA+IHRoZW0KPiA+IGJlZm9yZSBt
ZXJnZS4KCgo+IFRoYW5rcyB2ZXJ5IG11Y2gsIFBldHIuCgo+IFRoZSBwYXRjaHNldCBWMiAoYmFz
ZWQgb24geW91ciBzdWdnZXN0aW9ucykgaXMgcHVibGlzaGVkIGluIG15IGdpdCBicmFuY2guCj4g
SW4gY2FzZSB5b3Ugd2FudCB0byBkbyBtb3JlIHRlc3RzIHRvZGF5LgoKVGhhbmtzLCBJIGFscmVh
ZHkgc2NoZWR1bGVkIHRlc3RzLCBsZXQgeW91IGtub3cgbGF0ZXIgdG9kYXkuCgo+IGh0dHBzOi8v
Z2l0aHViLmNvbS93YW5nbGk1NjY1L2x0cC90cmVlL2xpYnN3YXAKCj4gQW5kLCBJIHByZWZlciB0
byB3YWl0IGZvciBDcnlpbCdzIGZlZWRiYWNrIGJlZm9yZSBwb3N0aW5nIHRoZW0gaW4gTUw6KQoK
KzEKCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
