Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC20C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:44:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A14B3C7C2F
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC0083C0503
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:44:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBCE31400BC2
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:44:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D47E1F38E;
 Fri, 17 Jan 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B415D13332;
 Fri, 17 Jan 2025 12:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 38WDKplQimdAMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 12:44:09 +0000
Date: Fri, 17 Jan 2025 13:44:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250117124407.GA765313@pevik>
References: <20250117122455.7989-1-chrubis@suse.cz>
 <CAEemH2d0YTx3AN+p_r1yf9ZYSbuHJ82jPMhOiKQhaVzHGkddgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d0YTx3AN+p_r1yf9ZYSbuHJ82jPMhOiKQhaVzHGkddgw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0D47E1F38E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] testcases/lib: Fix tst_ns_* helpers
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

SGkgQ3lyaWwsIExpLAoKPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA4OjI14oCvUE0gQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiA+IFJlcGxhY2VzIFNBRkVfQ0xPTkUo
KSB3aXRoIHRzdF9jbG9uZSgpIGluIHRoZSB0c3RfbnNfKiBoZWxwZXJzLgoKPiA+IFRoZSByZWFz
b24gZm9yIHRoZSByZXBsYWNlbWVudCBpcyB0aGF0IFNBRkVfQ0xPTkUoKSB1c2VzCj4gPiBUU1Rf
UkVUUllfRlVOQygpIHdoaWNoIGNhbGxzIHRzdF9tdWx0aXBseV90aW1lb3V0KCkuIFRoZSBwcm9i
bGVtIHdpdGgKPiA+IHRoYXQgaXMgdGhhdCB0aGUgdHN0X211bHRpcGx5X3RpbWVvdXQoKSBpcyBh
IHRlc3QgbGlicmFyeSBmdW5jdGlvbiB0aGF0Cj4gPiBzdGFydGVkIHRvIHByaW50IFRJTkZPIG1l
c3NhZ2VzIHJlY2VudGx5IGFuZCB0aGF0IHdlIHJlbHkgb24gcGFyc2luZyB0aGUKPiA+IG91dHB1
dCBmcm9tIHRoZSB0c3RfbnNfKiBoZWxwZXJzLgoKPiA+IFRoZSByZWFzb24gU0FGRV9DTE9ORSgp
IHN0YXJ0ZWQgdG8gY2FsbCBUU1RfUkVUUllfRlVOQygpIGlzIHRoYXQgaW4gdGhlCj4gPiBjYXNl
IHRoYXQgd2UgY3JlYXRlIG5ldyBuYW1lc3BhY2VzIHdpdGggdGhlIGNsb25lIGNhbGwsIHdlIG1h
eSBlbmQgdXAKPiA+IGNyZWF0aW5nIHRoZW0gZmFzdGVyIHRoYW4ga2VybmVsIGNhbiBjbGVhbiB0
aGVtIHVwIHdoaWNoIGlzIGRlc2NyaWJlZCBpbjoKCj4gPiBjb21taXQgN2Q4ODIwODFhNTYxM2Y0
NGExMmZjNmIxYzQ0MjY3ZDRkZjA4NTdhNAo+ID4gQXV0aG9yOiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KPiA+IERhdGU6ICAgTW9uIE1hciAyOCAyMjo0Njo0MyAyMDIyICswMjAwCgo+ID4g
ICAgIGxpYjogUmV0cnkgc2FmZV9jbG9uZSgpIG9uIEVOT1NQQwoKPiA+IFRoaXMgY29tYmluZWQg
d2l0aCB0aGUgbmV3bHkgaW50cm9kdWNlZCBjaGFuZ2VzIGluIHRoZSB0ZXN0IGxpYnJhcnkgdGhh
dAo+ID4gY2hlY2sgZm9yIGtlcm5lbCBkZWJ1Z2dpbmcgb3B0aW9ucyB0aGF0IG1heSBuZWVkIHRv
IGFkanVzdCBkZWZhdWx0Cj4gPiB0aW1lb3V0czoKCj4gPiBjb21taXQgODkzY2EwYWJlN2U4Mjg1
MWZmMGU1ZDkzYzA5YjEwOThmMmVmZjEyMQo+ID4gQXV0aG9yOiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KPiA+IERhdGU6ICAgU3VuIERlYyAyMiAxNToyMjo0OSAyMDI0ICswODAwCgo+ID4g
ICAgIGxpYjogbXVsdGlwbHkgdGhlIHRpbWVvdXQgaWYgZGV0ZWN0IHNsb3cga2NvbmZpZ3MKCj4g
PiB3aGljaCBhZGRzIHRzdF9oYXNfc2xvd19rY29uZmlnKCkgaW50byB0aGUgdHN0X211bHRpcGx5
X3RpbWVvdXQoKSBjYXVzZXMKPiA+IHRoZSBUSU5GTyBtZXNzYWdlcyB0byBiZSBwcmludGVkLgoK
PiA+IFRoZSByZWFzb24gd2h5IHdlIGNhbiBzYWZlbHkgcmVwbGFjZSB0aGUgU0FGRV9DTE9ORSgp
IHdpdGggdHN0X2Nsb25lKCkKPiA+IGhlcmUgaXMgdGhhdCB3ZSBhcmUgbm90IGNyZWF0aW5nIG5l
dyBuYW1zcGFjZXMgaW4gdGhlIHRzdF9uc18qIGhlbHBlcnMsCj4gPiBidXQgcmF0aGVyIHRoYW4g
dGhhdCBjbG9uaW5nIGEgbmV3IHByb2Nlc3MgdG8gYmUgZXhlY3V0ZWQgaW5zaWRlIG9mIHRoZQo+
ID4gbmFtZXNwYWNlLCBoZW5jZSB3ZSBkbyBub3QgbmVlZCB0byByZXRyeSBvbiBFTk9TUEMuCgo+
ID4gU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+CgoKPiBSZXZp
ZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cgo+IE5pY2Ugd29yayEKClRoYW5r
cyBmb3IgZml4IGFuZCByZXZpZXcuIFRoaXMgb25lIGZpeGVzIHRoZSBwcm9ibGVtLCB0aHVzIEkg
bWVyZ2VkIGl0LgpJJ2xsIGxldCB5b3Uga25vdyBhYm91dCB0aGUgb3RoZXIgcGF0Y2ggc29vbiAo
SSBzdXNwZWN0IHRoYXQgaXQgZG9lcyBub3QgY2F0Y2gKb3RoZXIgdXNhZ2UsIHNvbWUgdG9vbHMg
bmVlZHMgdG8gcGFyc2Ugc3RkZXJyIC4uLikuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
