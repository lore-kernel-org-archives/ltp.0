Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C9AC02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:57:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 203C73C7BE3
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:57:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B46843C7BDE
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:56:53 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34D9D1BDB76D
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:56:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 334B8211ED;
 Thu, 16 Jan 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9E9613A57;
 Thu, 16 Jan 2025 12:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6kPvNxMCiWetMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 12:56:51 +0000
Date: Thu, 16 Jan 2025 13:56:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250116125650.GA692568@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 334B8211ED
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] Broken tests using tst_net.sh by 893ca0abe7
 (was: [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIEphbiAxNiwgMjAyNSBhdCA2OjQy4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCBDeXJpbCwgYWxsLAoKPiA+IC4uLgo+ID4gPiArKysg
Yi9saWIvdHN0X3Rlc3QuYwo+ID4gPiBAQCAtNTU1LDkgKzU1NSw2IEBAIHN0YXRpYyBpbnQgbXVs
dGlwbHlfcnVudGltZShpbnQgbWF4X3J1bnRpbWUpCgo+ID4gPiAgICAgICBwYXJzZV9tdWwoJnJ1
bnRpbWVfbXVsLCAiTFRQX1JVTlRJTUVfTVVMIiwgMC4wMDk5LCAxMDApOwoKPiA+ID4gLSAgICAg
aWYgKHRzdF9oYXNfc2xvd19rY29uZmlnKCkpCj4gPiA+IC0gICAgICAgICAgICAgbWF4X3J1bnRp
bWUgKj0gNDsKPiA+ID4gLQo+ID4gPiAgICAgICByZXR1cm4gbWF4X3J1bnRpbWUgKiBydW50aW1l
X211bDsKPiA+ID4gIH0KCj4gPiA+IEBAIC0xNzA2LDYgKzE3MDMsOSBAQCB1bnNpZ25lZCBpbnQg
dHN0X211bHRpcGx5X3RpbWVvdXQodW5zaWduZWQgaW50Cj4gPiB0aW1lb3V0KQo+ID4gPiAgICAg
ICBpZiAodGltZW91dCA8IDEpCj4gPiA+ICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgInRp
bWVvdXQgbXVzdCB0byBiZSA+PSAxISAoJWQpIiwgdGltZW91dCk7Cgo+ID4gPiArICAgICBpZiAo
dHN0X2hhc19zbG93X2tjb25maWcoKSkKPiA+ID4gKyAgICAgICAgICAgICB0aW1lb3V0ICo9IDQ7
Cgo+ID4gRllJIHRoaXMgY2hhbmdlLCBtZXJnZWQgYXMgODkzY2EwYWJlNyAoImxpYjogbXVsdGlw
bHkgdGhlIHRpbWVvdXQgaWYKPiA+IGRldGVjdCBzbG93Cj4gPiBrY29uZmlncyIpIGNhdXNlZCBh
IHJlZ3Jlc3Npb24gb24gKmFsbCogdGVzdHMgd2hpY2ggdXNlIHRzdF9uZXQuc2guCgo+ID4gRmly
c3QsIGl0IGRldGVjdHMgc2xvdyBjb25maWcgb24gZXZlcnl0aGluZyB3aGljaCB1c2VzIHN0cnVj
dCB0c3RfdGVzdCwKPiA+IHdoaWNoIGFyZSB1bmZvcnR1bmF0ZWx5IHNvbWUgdG9vbHMgYXQgdGVz
dGNhc2VzL2xpYi86Cgo+ID4gJCBnaXQgZ3JlcCAtbCAic3RydWN0IHRzdF90ZXN0IiB0ZXN0Y2Fz
ZXMvbGliLyouYwo+ID4gdGVzdGNhc2VzL2xpYi90c3RfZGV2aWNlLmMgLy8gbm90IG9idmlvdXMg
cmVhc29uLCBtaWdodCBiZSByZW1vdmVkCj4gPiB0ZXN0Y2FzZXMvbGliL3RzdF9nZXRfZnJlZV9w
aWRzLmMgLy8gZm9yY2UgbWVzc2FnZXMgdG8gYmUgcHJpbnRlZCBmcm9tIG5ldwo+ID4gbGlicmFy
eQo+ID4gdGVzdGNhc2VzL2xpYi90c3RfbnNfY3JlYXRlLmMgLy8gLmZvcmtzX2NoaWxkID0gMSwg
TmVlZGVkIGJ5IFNBRkVfQ0xPTkUKPiA+IHRlc3RjYXNlcy9saWIvdHN0X25zX2V4ZWMuYyAgLy8g
LmZvcmtzX2NoaWxkID0gMSwgTmVlZGVkIGJ5IFNBRkVfQ0xPTkUKPiA+IHRlc3RjYXNlcy9saWIv
dHN0X3J1bl9zaGVsbC5jIC8vIG5vdCBvYnZpb3VzIHJlYXNvbiwgbWlnaHQgYmUgcmVtb3ZlZAoK
PiA+IEJlc2lkZXMgdW5pbXBvcnRhbnQgZmFjdCB0aGF0IHNsb3cgY29uZmlnIGRldGVjdGlvbiBp
cyBhbiB1bm5lY2Vzc2FyeQo+ID4gc2xvd2Rvd24KPiA+IG9uIHRoZXNlIHRvb2xzLCB0aGUgcHJv
YmxlbSBpcyB0aGF0IGl0IHByaW50cyBtZXNzYWdlcyB0byBzdGRlcnIsIHdoaWNoCj4gPiBjYXVz
ZXMKPiA+IGJyZWFrYWdlLgoKPiA+IFByZXZpb3VzbHkgdHN0X25zX2V4ZWMuYyBydW4ganVzdCBj
b21tYW5kIHBhc3NlZCBieSAtYyBwYXJhbWV0ZXI6Cgo+ID4gJCAuL3RzdF9uc19leGVjIDE0NTM2
IG5ldCxtbnQgc2ggLWMgIiBjYXQKPiA+IC9wcm9jL3N5cy9uZXQvaXB2Ni9jb25mL2x0cF9uc192
ZXRoMS9kaXNhYmxlX2lwdjYiCj4gPiAwCgo+ID4gTm93IGl0IHByaW50cyBUSU5GTzoKPiA+ICQg
Li90c3RfbnNfZXhlYyAxNDUzNiBuZXQsbW50IHNoIC1jICIgY2F0Cj4gPiAvcHJvYy9zeXMvbmV0
L2lwdjYvY29uZi9sdHBfbnNfdmV0aDEvZGlzYWJsZV9pcHY2Igo+ID4gdHN0X2tjb25maWcuYzo4
ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+ID4gdHN0
X2tjb25maWcuYzo2Njc6IFRJTkZPOiBDT05GSUdfTEFURU5DWVRPUCBrZXJuZWwgb3B0aW9uIGRl
dGVjdGVkIHdoaWNoCj4gPiBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiA+IDAKCj4gPiB0c3Rf
cmhvc3RfcnVuKCkgaW4gdHN0X25ldC5zaCBydW5zIGJpbmFyeSBvbiByZW1vdGUgaG9zdDoKCj4g
PiAgICAgICAgIG91dHB1dD0kKCRyY21kICIkc2hfY21kIiAkb3V0IDI+JjEgfHwgZWNobyAnUlRF
UlInKQoKPiA+IFJlZGlyZWN0IHN0ZGVyciB0byBzdGRvdXQgKDI+JjEpIGlzIGxpa2VseSBuZWVk
ZWQgZm9yIHNvbWUgdGVzdHMuIEJ1dAo+ID4gdHN0X3Job3N0X3J1bigpIG91dHB1dCBpcyBvZnRl
biBwYXJzZWQgaW5jbHVkaW5nIHRoZXJlZm9yZSBjZXJ0YWluIHRvb2xzIGluCj4gPiB0ZXN0Y2Fz
ZXMvbGliLyBoYXZlIHRvIHByaW50IG9ubHkgZXhwZWN0ZWQgb3V0cHV0OgoKPiA+IGluaXRfbHRw
X25ldHNwYWNlKCkKPiA+IHsKPiA+ICAgICAgICAgLi4uCj4gPiAgICAgICAgICAgICAgICAgcGlk
PSIkKFJPRCB0c3RfbnNfY3JlYXRlIG5ldCxtbnQpIgo+ID4gICAgICAgICAuLi4KPiA+ICAgICAg
ICAgZXhwb3J0IExUUF9ORVROUz0iJHtMVFBfTkVUTlM6LXRzdF9uc19leGVjICRwaWQgbmV0LG1u
dH0iCgo+ID4gSSB3aWxsIHByb2JhYmx5IHNvbHZlIGl0IGJ5IGFkZGluZyB5ZXQgYW5vdGhlciBw
YXJhbWV0ZXIgdG8KPiA+IHRzdF9yaG9zdF9ydW4oKSwKPiA+IHdoaWNoIGlnbm9yZXMgc3RkZXJy
IGFuZCB1c2UgaXQgZm9yIHRzdF9uc197Y3JlYXRlLGV4ZWN9LiBCdXQgbWF5YmUgdGhlcmUKCkFj
dHVhbGx5IHRzdF9uc19leGVjLmMgbmVlZHMgdG8gYmUgcXVpZXQgdG8gbm90IGNsdXR0ZXIgdGhl
IG91dHB1dCBvZiB0aGUKY29tbWFuZCBpdCBydW5zIHZpYSB0c3Rfcmhvc3RfcnVuKCkgZm9yIG5l
dG5zICh2aWEgJExUUF9ORVROUykuIFRoZXJlZm9yZSBhZGRpbmcKYW4gcXVpZXQgb3B0aW9uIHRv
IHRzdF9yaG9zdF9ydW4oKSBpcyBub3QgYSBzb2x1dGlvbi4KCj4gPiBpcwo+ID4gYW5vdGhlciBz
b2x1dGlvbiAob3IgYW5vdGhlciBwcm9ibGVtKS4KCgo+IE9yLCBhbm90aGVyIHdheSBpcyBqdXN0
IHRvIHNldCAndHN0X3Rlc3QtPnRpbWVvdXQgPT0gVFNUX1VOTElNSVRFRF9USU1FT1VUJwo+IGlu
IHRob3NlIHRlc3RjYXNlL2xpYiB0b29scy4KClVuZm9ydHVuYXRlbHkgdGhpcyBkb2VzIG5vdCB3
b3JrLiBJbiB0aGUgZW5kIEkgcHJvYmFibHkgZmlsdGVyIG91dCAnVElORk86JwptZXNzYWdlcyBp
biB0c3Rfcmhvc3RfcnVuKCkuCgpJdCdkIGJlIHNhZmVyIHRvIGF2b2lkIHVzaW5nIGxpYnJhcnkg
Zm9yIHRzdF9uc19leGVjLmMsIGJ1dCBpdCdzIGFsc28gdXNlZCBpbgpjb250YWluZXJzIHNoZWxs
IHRlc3RzIChuZXRuc19saWIuc2gsIG5ldG5zX3N5c2ZzLnNoKSBhbmQgZnNfYmluZCB0ZXN0cwoo
ZnNfYmluZF9jbG9uZU5TKi5zaCkuCgpBbHNvLCB0c3RfbnNfZXhlYy5jIChhbmQgdHN0X25zX2Ny
ZWF0ZS5jKSBjb3VsZCBiZSBmb3IgbmV0bnMgcmVwbGFjZWQgYnkKJ2lwIG5ldG5zJyAocmV2ZXJ0
IGJhY2sgY2hhbmdlIGluIDIwMTcgM2ZiNTAxZTA0YyAoIm5ldDogdXNlIExUUCBuc19jcmVhdGUv
bnNfZXhlYyIpCgpNYXliZSBvdGhlciB0b29scyB3aGljaCB1c2UgdHN0X25zX3tjcmVhdGUsZXhl
YyxpZm1vdmV9LmMgY291bGQgYmUgcmVwbGFjZWQgYnkKc29tZSB0b29scyBmcm9tIHV0aWwtbGlu
dXggKHVuc2hhcmUgPykuIFdlIGNvbnNpZGVyIGhhdmluZyBvd24gYmluYXJ5IGFzIGJldHRlcgp0
aGFuIGV4dGVybmFsIGRlcGVuZGVuY3ksIGJ1dCBiaW5hcnkgbmVlZHMgdG8gYmUgc2ltcGxlIHRv
IGF2b2lkIHByb2JsZW1zIHdoZW4KTFRQIGxpYnJhcnkgY2hhbmdlcy4KCktpbmQgcmVnYXJkcywK
UGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
