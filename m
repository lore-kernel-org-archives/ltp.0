Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4187DC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:15:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD15F3C7C27
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:15:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F28143C2EE4
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:15:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6479162225F
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:15:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C1272117B;
 Fri, 17 Jan 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFD33139CB;
 Fri, 17 Jan 2025 08:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7rWWOZcRimdxbAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 08:15:19 +0000
Date: Fri, 17 Jan 2025 09:15:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250117081518.GA733756@pevik>
References: <20250117071758.120366-1-liwang@redhat.com>
 <20250117073607.GA731427@pevik> <20250117080454.GD729073@pevik>
 <CAEemH2e4VnKVHUEKPKsa0LUkx1gGdii_tZxtiqA9TBfd6SBRNA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e4VnKVHUEKPKsa0LUkx1gGdii_tZxtiqA9TBfd6SBRNA@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1C1272117B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

PiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA0OjA14oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gSGkgTGksCgo+ID4gPiA+IFRoZSBtYWNy
byBUU1RfTk9fU0xPV19LQ09ORklHX0NIRUNLIGlzIGFkZGVkIHRvIGNvbnRyb2wgd2hldGhlcgo+
ID4gPiA+IHRoZSB0c3RfaGFzX3Nsb3dfa2NvbmZpZygpIGZ1bmN0aW9uICh3aGljaCBwcmVzdW1h
Ymx5IGNoZWNrcyBmb3IKPiA+ID4gPiBzbG93IGtlcm5lbCBjb25maWd1cmF0aW9ucykgc2hvdWxk
IGJlIGV4ZWN1dGVkLgoKPiA+ID4gVGhhdCB3YXMgcXVpY2ssIHRoYW5rcyBhIGxvdCEKCj4gPiA+
IEJ1dCB1bmZvcnR1bmF0ZWx5IHRoZSBwYXRjaCBkb2VzIG5vdCBoZWxwIHRvIGF2b2lkIHByaW50
aW5nIFRJTkZPCj4gPiA+ICh0ZXN0ZWQgb24gYSBmcmVzaCBjbG9uZSk6Cgo+ID4gPiAjIG1ha2Ug
JiYgLi90c3RfbnNfZXhlYyAxNDUzNiBuZXQsbW50IHNoIC1jICIgY2F0Cj4gPiAvcHJvYy9zeXMv
bmV0L2lwdjYvY29uZi9sdHBfbnNfdmV0aDEvZGlzYWJsZV9pcHY2Igo+ID4gPiBDQyB0ZXN0Y2Fz
ZXMvbGliL3RzdF9uc19leGVjCj4gPiA+IG1ha2VbMV06IE5vdGhpbmcgdG8gYmUgZG9uZSBmb3Ig
J2FsbCcuCj4gPiA+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25m
aWcgJy9wcm9jL2NvbmZpZy5neicKPiA+ID4gdHN0X2tjb25maWcuYzo2Njc6IFRJTkZPOiBDT05G
SUdfTEFURU5DWVRPUCBrZXJuZWwgb3B0aW9uIGRldGVjdGVkIHdoaWNoCj4gPiBtaWdodCBzbG93
IHRoZSBleGVjdXRpb24KPiA+ID4gMAoKPiA+ID4gTWF5YmUgaXQncyBiZWNhdXNlIHNhZmVfY2xv
bmUoKSB0cmlnZ2VycyBpdD8gT3Igd2hhdCBhbSBJIG1pc3Npbmc/Cgo+ID4gVGhlIHByb2JsZW0g
d2h5IGl0IGRvZXMgbm90IHdvcmsgaXMgdGhhdCBpdCB1c2VzIGxpYi90c3RfdGVzdC5vIHZpYQo+
ID4gbGliL2xpYmx0cC5hLCB3aGljaCB3YXMgY29tcGlsZWQgd2l0aG91dCBUU1RfTk9fU0xPV19L
Q09ORklHX0NIRUNLLgoKCj4gUmVhbGx5PyBIb3cgZG9lcyB0aGF0IFRTVF9OT19ERUZBVUxUX01B
SU4gd29yaz8KPiBSZWFkaW5nIHRoZSBjb2RlLi4uCgpJIGd1ZXNzIHRoZSBjb2RlIHdoaWNoIGV2
YWx1YXRlcyBUU1RfTk9fREVGQVVMVF9NQUlOIG11c3QgYmUgaW4gc3RhdGljIGlubGluZQpmdW5j
dGlvbiBpbiB0c3RfdGVzdC5oIGhlYWRlci4gVGhlbiBpdCB3aWxsIHdvcmsuCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCj4gPiBJTUhPIFdlIGNhbm5vdCBlYXNpbHkgc29sdmUgdGhpcyB3aXRoIHByZXBy
b2Nlc3NvciBkZWZpbml0aW9uLgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiA+IEtp
bmQgcmVnYXJkcywKPiA+ID4gUGV0cgoKPiA+ID4gPiBUaGlzIGFsbG93cyB0ZXN0IGNhc2VzIGFu
ZCB0b29scyB0byBvcHQgb3V0IG9mIHRoaXMgYWRkaXRpb25hbAo+ID4gPiA+IGNoZWNrLCBlbmFi
bGluZyBtb3JlIGZsZXhpYmxlIGFuZCBmYXN0ZXIgdGVzdCBleGVjdXRpb24gaW4KPiA+ID4gPiBj
ZXJ0YWluIHNjZW5hcmlvcy4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
