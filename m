Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0920606EE8D
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 09:59:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93F5B3C730C
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 10:59:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973CE3C701B
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 10:59:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F0A6310009B6
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 10:59:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DE572215A;
 Tue,  3 Nov 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E614F134B8;
 Tue,  3 Nov 2026 09:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jeJwLYaw6WrQZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Nov 2026 09:59:34 +0000
Date: Tue, 3 Nov 2026 10:59:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20261103095929.GA48588@pevik>
References: <P5Iny41--F-9@tuta.io>
 <CAOQ4uxgqZANVT8wi_hCJX6Ym5Ea9XMCo3eSRwp-aujf767NbeA@mail.gmail.com>
 <20261103072455.GA35831@pevik>
 <CAOQ4uxiL2ZKcr-V=NsJX5A2zse0YFX+gSyi7Y5Yb51NPJ5s1+A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiL2ZKcr-V=NsJX5A2zse0YFX+gSyi7Y5Yb51NPJ5s1+A@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 2DE572215A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Add directory cases for the
 nested event
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIE5vdiAzLCAyMDI2IGF0IDg6MjTigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gSGkgQW1pciwgRWR2YXJkLAoKPiA+ID4gT24gU2F0LCBPY3QgMzEs
IDIwMjYgYXQgMTA6MTPigK9QTSBFZHZhcmQgQ29ucmFkIDxlZHZhcmRAdHV0YS5pbz4gd3JvdGU6
Cgo+ID4gPiA+IEEgZGlyZWN0b3J5IG9uIG92ZXJsYXlmcyByZWFjaGVzIGl0cyByZWFsIGRpcmVj
dG9yeSB0aHJvdWdoCj4gPiA+ID4gb3ZsX2Rpcl9vcGVuX3JlYWxmaWxlKCkgcmF0aGVyIHRoYW4g
YmFja2luZ19maWxlX29wZW4oKSwgc28gdGhlIGZpeAo+ID4gPiA+IGZvciByZWd1bGFyIGZpbGVz
LCBjb21taXQgYzNkMzU1ZjQyN2NlICgiZnM6IGxldCBiYWNraW5nIGZpbGVzCj4gPiA+ID4gaW5o
ZXJpdCBGTU9ERV9OT05PVElGWSBmcm9tIHRoZSB1c2VyIGZpbGUiKSwgZG9lcyBub3QgY292ZXIg
aXQ6IGEKPiA+ID4gPiBsaXN0ZW5lciB0aGF0IG1hcmtzIHRoZSBiYWNraW5nIGZpbGVzeXN0ZW0g
d2l0aCBGQU5fT1BFTl9QRVJNIHwKPiA+ID4gPiBGQU5fT05ESVIgaXMgc3RpbGwgc2VudCBhIG5l
c3RlZCBwZXJtaXNzaW9uIGV2ZW50IGZyb20gaXRzIG93bgo+ID4gPiA+IHJlYWQoMikgd2hlbiB0
aGUgcmVwb3J0ZWQgcGF0aCBpcyBhbiBvdmVybGF5IGRpcmVjdG9yeS4KCj4gPiA+ID4gQWRkIHRo
ZSBkaXJlY3RvcnkgY291bnRlcnBhcnRzIG9mIHRoZSB0d28gZXhpc3RpbmcgY2FzZXMuIFRoZQo+
ID4gPiA+IGxpc3RlbmVyJ3MgZXhwZWN0ZWQgZXZlbnQgbWFzayBzdGF5cyBGQU5fT1BFTl9QRVJN
OiBGQU5fT05ESVIgaXMgbm90Cj4gPiA+ID4gcmVwb3J0ZWQgdG8gYSBncm91cCB3aXRob3V0IEZB
Tl9SRVBPUlRfRklELgoKPiA+ID4gPiBUaGUgZm91cnRoIGNhc2UgZmFpbHMgb24gYSBrZXJuZWwg
d2l0aG91dCB0aGUgcGVuZGluZyBmaXggIm92bDoKPiA+ID4gPiBpbmhlcml0IEZNT0RFX05PTk9U
SUZZIHdoZW4gb3BlbmluZyBkaXJlY3RvcnkgcmVhbGZpbGVzIi4KCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRWR2YXJkIENvbnJhZCA8ZWR2YXJkQHR1dGEuaW8+Cgo+ID4gPiBSZXZpZXdlZC1ieTog
QW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCj4gPiA+ID4gLS0tCj4gPiA+ID4g
RGVwZW5kcyBvbiB0aGUgcGVuZGluZyBvdmVybGF5ZnMgZml4LCBwb3N0ZWQgYnkgQW1pciBvbiB0
aGUga2VybmVsCj4gPiA+ID4gdGhyZWFkOgo+ID4gPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL0NBT1E0dXhqbT1jR1BudWcxOFZ1aEtxaU12a1d3TFBOTE9fVEUzS3hPOGlMWkcrdmVZ
UUBtYWlsLmdtYWlsLmNvbS8KPiA+ID4gPiBXaXRob3V0IGl0IHRoZSBmb3VydGggY2FzZSBmYWls
cyBvbiBjdXJyZW50IG1haW5saW5lLCBzbyB0aGlzIHNob3VsZAo+ID4gPiA+IHdhaXQgaW4gdGhl
IHF1ZXVlIHVudGlsIHRoYXQgZml4IGlzIGluIExpbnVzJyB0cmVlOyBhIGxpbnV4LWdpdCB0YWcg
Zm9yCj4gPiA+ID4gaXQgY2FuIHRoZW4gYmUgYWRkZWQuIFRoZSBmaXJzdCB0aHJlZSBjYXNlcyBw
YXNzIG9uIHY3LjQtcmMxIG1hdGVyaWFsCj4gPiA+ID4gdG9kYXkuCgo+ID4gPiA+IFRlc3RlZCBp
biBhIFZNLCBlYWNoIGtlcm5lbCBydW4gb25jZSBhbmQgd2l0aCAtaSAyOgoKPiA+ID4gPiAgIGtl
cm5lbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbGUrYmFja2luZyAgZGlyK2JhY2tp
bmcKPiA+ID4gPiAgIHY2LjEzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICAgICAgRkFJTAo+ID4gPiA+ICAgNmI0YjU0M2ZhMTggKG5vIGZpeCkgICAgICAgICAgICAgICAg
RkFJTCAgICAgICAgICBGQUlMCj4gPiA+ID4gICArIGMzZDM1NWY0MjdjZSAoZmlsZXMsIGluIExp
bnVzJykgICBQQVNTICAgICAgICAgIEZBSUwKPiA+ID4gPiAgICsgdGhlIHBlbmRpbmcgb3ZsIGZp
eCAgICAgICAgICAgICAgIFBBU1MgICAgICAgICAgUEFTUwoKPiA+ID4gPiBUaGUgIm92ZXJsYXkg
bWFyayBvbmx5IiBjYXNlcyBwYXNzIGV2ZXJ5d2hlcmUuIFRoZSBkaXJlY3RvcnkgY2FzZQo+ID4g
PiA+IGZhaWxzIG9uIHY2LjEzIHRvbzogb3ZlcmxheWZzIG5ldmVyIHBhc3NlZCB0aGUgbm9ub3Rp
Znkgc3RhdGUgb24gdG8KPiA+ID4gPiB0aGUgcmVhbCBkaXJlY3RvcnksIHNvIGl0IHByZWRhdGVz
IHRoZSA2LjE0IGNoYW5nZSB0aGF0IGJyb2tlIGZpbGVzLgoKPiA+ID4gQXMgZmFyIGFzIEkgY2Fu
IHRlbGwgaXRzIGEgcmVncmVzc2lvbiBmcm9tCj4gPiA+IDEzMGZkYmMzZDFmOTkgKCJvdmw6IHBh
c3MgY29ycmVjdCBmbGFncyBmb3Igb3BlbmluZyByZWFsIGRpcmVjdG9yeSIpCgo+ID4gPiBUaGFu
a3MgZm9yIGFkZGluZyB0aGlzIHRlc3QuCj4gPiA+IEkgYWRkZWQgeW91ciBUZXN0ZWQtYnkgdG8g
dGhlIGZpeCBwYXRjaC4KCj4gPiBJJ20gZ29pbmcgdG8gbWVyZ2UgdG9kYXkuIFNvIHRoZXJlIHdp
bGwgYmUgaGFzaCBmb3IgZml4aW5nIGtlcm5lbCBjb21taXQsCj4gPiB0aGFua3MgZm9yIGluZm8u
CgoKPiBGWUksIEVkdmFyZCBmb3VuZCBhbm90aGVyIGJ1ZyBhbmQgaGFzIHdyaXR0ZW4gYW4gZXh0
cmEgdGVzdCBjYXNlIHRvIGNvdmVyIGl0Cj4gdGhlIGV4cGVjdGVkIGtlcm5lbCBmaXggaXMgZ29p
bmcgdG8gY292ZXIgdGhlIGRpcmVjdG9yeSB0ZXN0IGNhc2VzIGluIHRoaXMgcGF0Y2gKPiBhcyB3
ZWxsIGFzIHRoZSBleHRyYSB0ZXN0IGNhc2U6Cgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXVuaW9uZnMvUDVRdTNjby0tTi05QHR1dGEuaW8vCgpUaGFua3MgYSBsb3QgZm9yIGluZm8h
Cgo+IFVwIHRvIHlvdSBpZiB5b3Ugd2FudCB0byBtZXJnZSBub3cgb3Igd2FpdCBmb3IgdGhlIGV4
dHJhIHRlc3QgY2FzZS4KCkkgbWVyZ2VkIHRoYXQgb25lLCBJIHN1cHBvc2UgdGhlcmUgd2lsbCBi
ZSBtb3JlIHBhdGNoZXMgKG1vcmUgdGVzdGNhc2VzLApnaXQgaGFzaCBvZiB0aGUgZml4KS4KCktp
bmQgcmVnYXJkcywKUGV0cgoKPiBUaGFua3MsCj4gQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
