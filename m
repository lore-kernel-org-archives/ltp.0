Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354C2C27C75
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 07:13:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF89D3D0BF7
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 09:13:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31F513D0B7A
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 09:13:00 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 36E2C2081BA
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 09:12:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C43A433FC7;
 Wed, 12 Jun 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85308137DF;
 Wed, 12 Jun 2024 07:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U3GPH3pKaWboRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Jun 2024 07:12:58 +0000
Date: Wed, 12 Jun 2024 09:12:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Message-ID: <20240612071252.GA98398@pevik>
References: <>
 <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
 <171815759406.14261.8092450471234028375@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <171815759406.14261.8092450471234028375@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C43A433FC7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
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
Cc: Aishwarya.TCV@arm.com, Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org,
 broonie@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIDExIEp1biAyMDI0LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiA+IE9uIFR1ZSwg
SnVuIDExLCAyMDI0IGF0IDU6MzDigK9BTSBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+IHdyb3Rl
OgoKPiA+ID4gT24gRnJpLCAwNyBKdW4gMjAyNCwgSmFtZXMgQ2xhcmsgd3JvdGU6Cgo+ID4gPiA+
IEhpIE5laWwsCgo+ID4gPiA+IE5vdyB0aGF0IHlvdXIgZml4IGlzIGluIGxpbnV4LW5leHQgdGhl
IHN0YXR2ZnMwMSB0ZXN0IGlzIHBhc3NpbmcgYWdhaW4uCj4gPiA+ID4gSG93ZXZlciBpbm90aWZ5
MDIgaXMgc3RpbGwgZmFpbGluZy4KCj4gPiA+ID4gVGhpcyBpcyBiZWNhdXNlIHRoZSB0ZXN0IGV4
cGVjdHMgdGhlIElOX0NSRUFURSBhbmQgSU5fT1BFTiBldmVudHMgdG8KPiA+ID4gPiBjb21lIGlu
IHRoYXQgb3JkZXIgYWZ0ZXIgY2FsbGluZyBjcmVhdCgpLCBidXQgbm93IHRoZXkgYXJlIHJldmVy
c2VkLiBUbwo+ID4gPiA+IG1lIGl0IHNlZW1zIGxpa2UgaXQgY291bGQgYmUgYSB0ZXN0IGlzc3Vl
IGFuZCB0aGUgdGVzdCBzaG91bGQgaGFuZGxlCj4gPiA+ID4gdGhlbSBpbiBlaXRoZXIgb3JkZXI/
IE9yIG1heWJlIHRoZXJlIHNob3VsZCBiZSBhIHNpbmdsZSBpbm90aWZ5IGV2ZW50Cj4gPiA+ID4g
d2l0aCBib3RoIGZsYWdzIHNldCBmb3IgdGhlIGF0b21pYyBvcGVuPwoKPiA+ID4gSW50ZXJlc3Rp
bmcuLi4uICBJIGRvbid0IHNlZSBob3cgYW55IGZpbGVzeXN0ZW0gdGhhdCB1c2VzIC0+YXRvbWlj
X29wZW4KPiA+ID4gd291bGQgZ2V0IHRoZXNlIGluIHRoZSAicmlnaHQiIG9yZGVyIC0gYW5kIEkg
ZG8gdGhpbmsgSU5fQ1JFQVRFIHNob3VsZAo+ID4gPiBjb21lIGJlZm9yZSBJTl9PUEVOLgoKPiA+
IENvcnJlY3QuCgoKPiA+ID4gRG9lcyBORlN2NCBwYXNzIHRoaXMgdGVzdD8KCj4gPiBQcm9iYWJs
eSBub3QuCgoKPiA+ID4gSU5fT1BFTiBpcyBnZW5lcmF0ZWQgKGJ5IGZzbm90aWZ5X29wZW4oKSkg
d2hlbiBmaW5pc2hfb3BlbigpIGlzIGNhbGxlZCwKPiA+ID4gd2hpY2ggbXVzdCBiZSAoYW5kIGlz
KSBjYWxsZWQgYnkgYWxsIGF0b21pY19vcGVuIGZ1bmN0aW9ucy4KPiA+ID4gSU5fQ1JFQVRFIGlz
IGdlbmVyYXRlZCAoYnkgZnNub3RpZnlfY3JlYXRlKCkpIHdoZW4gb3Blbl9sYXN0X2xvb2t1cHMo
KQo+ID4gPiBkZXRlY3RzIHRoYXQgRk1PREVfQ1JFQVRFIHdhcyBzZXQgYW5kIHRoYXQgaGFwcGVu
cyAqYWZ0ZXIqIGxvb2t1cF9vcGVuKCkKPiA+ID4gaXMgY2FsbGVkLCB3aGljaCBjYWxscyBhdG9t
aWNfb3BlbigpLgoKPiA+ID4gRm9yIGZpbGVzeXN0ZW1zIHRoYXQgZG9uJ3QgdXNlIGF0b21pY19v
cGVuLCB0aGUgSU5fT1BFTiBpcyBnZW5lcmF0ZWQgYnkKPiA+ID4gdGhlIGNhbGwgdG8gZG9fb3Bl
bigpIHdoaWNoIGhhcHBlbnMgKmFmdGVyKiBvcGVuX2xhc3RfbG9va3VwcygpLCBub3QKPiA+ID4g
aW5zaWRlIGl0LgoKPiA+IENvcnJlY3QuCgoKPiA+ID4gU28gdGhlIGx0cCB0ZXN0IG11c3QgYWxy
ZWFkeSBmYWlsIGZvciBORlN2NCwgOXAgY2VwaCBmdXNlIGdmczIgbnRmczMKPiA+ID4gb3Zlcmxh
eWZzIHNtYi4KCgo+ID4gaW5vdGlmeTAyIGRvZXMgbm90IHJ1biBvbiBhbGxfZmlsZXN5c3RlbXMs
IG9ubHkgb24gdGhlIG1haW4gdGVzdCBmcywKPiA+IHdoaWNoIGlzIG5vdCB2ZXJ5IG9mdGVuIG9u
ZSBvZiB0aGUgYWJvdmUuCgo+ID4gVGhpcyBpcyBob3cgSSBhdmVydGVkIHRoZSBwcm9ibGVtIGlu
IGZhbm90aWZ5MTYgKHdoaWNoIGRvZXMgcnVuIG9uCj4gPiBhbGxfZmlsZXN5c3RlbXMpOgoKPiA+
IGNvbW1pdCA5MDYyODI0YTcwYjhkYTc0YWE1YjFkYjA4NzEwZDAwMThiNDgwNzJlCj4gPiBBdXRo
b3I6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiBEYXRlOiAgIFR1ZSBO
b3YgMjEgMTI6NTI6NDcgMjAyMyArMDIwMAoKPiA+ICAgICBmYW5vdGlmeTE2OiBGaXggdGVzdCBm
YWlsdXJlIG9uIEZVU0UKCj4gPiAgICAgU3BsaXQgU0FGRV9DUkVBVCgpIGludG8gZXhwbGljaXQg
U0FGRV9NS05PRCgpIGFuZCBTQUZFX09QRU4oKSwKPiA+ICAgICBiZWNhdXNlIHdpdGggYXRvbWlj
IG9wZW4gKGUuZy4gZnVzZSksIFNBRkVfQ1JFQVQoKSBnZW5lcmF0ZXMgRkFOX09QRU4KPiA+ICAg
ICBiZWZvcmUgRkFOX0NSRUFURSAodGVzdGVkIHdpdGggbnRmcy0zZyksIHdoaWNoIGlzIGluY29u
c2lzdGVudCB3aXRoCj4gPiAgICAgdGhlIG9yZGVyIG9mIGV2ZW50cyBleHBlY3RlZCBmcm9tIG90
aGVyIGZpbGVzeXN0ZW1zLgoKPiA+IGlub3RpZnkwMiBzaG91bGQgYmUgZml4ZWQgc2ltaWxhcmx5
LgoKPiBBbHRlcm5hdGVseSAtIG1heWJlIHRoZSBrZXJuZWwgc2hvdWxkIGJlIGZpeGVkIHRvIGFs
d2F5cyBnZXQgdGhlIG9yZGVyCj4gcmlnaHQuCj4gSSBoYXZlIGEgcGF0Y2guICBJJ2xsIHBvc3Qg
aXQgc2VwYXJhdGVseS4KCkBBbWlyLCBpZiBsYXRlciBOZWlsJ3MgYnJhbmNoIGdldCBtZXJnZWQs
IG1heWJlIHdlIHNob3VsZCB1c2Ugb24gZmFub3RpZnkxNgpjcmVhdCgpIG9uIHRoZSBvbGQga2Vy
bmVscyAoYXMgaXQgd2FzIGluIGJlZm9yZSB5b3VyIGZpeCA5MDYyODI0YTcgKCJmYW5vdGlmeTE2
OgpGaXggdGVzdCBmYWlsdXJlIG9uIEZVU0UiKSksIGJhc2VkIG9uIGtlcm5lbCBjaGVjay4KCktp
bmQgcmVnYXJkcywKUGV0cgoKPiBUaGFua3MgZm9yIHlvdXIgY29uZmlybWF0aW9uIHRoYXQgbXkg
dW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0IQoKPiBOZWlsQnJvd24KCgoKPiA+IEkgZGlkIG5vdCBm
aW5kIGFueSBvdGhlciBpbm90aWZ5IHRlc3QgdGhhdCB3YXRjaGVzIElOX0NSRUFURS4KPiA+IEkg
ZGlkIG5vdCBmaW5kIGFueSBvdGhlciBmYW5vdGlmeSB0ZXN0IHRoYXQgd2F0Y2hlcyBib3RoIEZB
Tl9DUkVBVEUKPiA+IGFuZCBGQU5fT1BFTi4KCj4gPiBUaGFua3MsCj4gPiBBbWlyLgoKCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
