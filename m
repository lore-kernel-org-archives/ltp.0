Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E70C7619A
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 23:06:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420D93CC8DD
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 01:06:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8109A3CC4AE
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 01:05:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E2D3E10005C6
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 01:05:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D22AA1F460;
 Tue, 11 Apr 2023 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681254349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGdiHiSImT/w9cqe5DfCSgvo2RwckYF+It6Vr24LcMw=;
 b=SQ8rhXzWyrs8ft6birgLmF83c+XhpOgEuUi/6QVAWr3FOm/ajyS22UJ0nJPiVxu4GntiD9
 AhkahrLOA3QqivKez4N2qghl5csiF05IHOxP43fDkgsGE4XQekBvYXRJD+ktp0SfTXq9FR
 Sk8j2vmDwSoHsb2OYaHiwXyQ5fMMcjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681254349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGdiHiSImT/w9cqe5DfCSgvo2RwckYF+It6Vr24LcMw=;
 b=WYZMqYpr5Az6DRrmo3crTpN1BweWs4MUidGnCArm9FAPL4PNPya1LD0cVDzZ+e9PADF0He
 wJi91M+n0qdi23Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B24EA13519;
 Tue, 11 Apr 2023 23:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P+NRKc3nNWSiTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Apr 2023 23:05:49 +0000
Date: Wed, 12 Apr 2023 01:05:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <20230411230548.GB1798729@pevik>
References: <20230331000747.2294390-1-edliaw@google.com>
 <c766ddbe-f991-9304-0dec-ecf795a788db@arm.com>
 <CAG4es9VrznF_X=3msWZQfcKOjn-tu8s_rV4Kq_tVWde=JUWxtg@mail.gmail.com>
 <bef924f6-9b29-cf36-a15a-7edfe5a92e4d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bef924f6-9b29-cf36-a15a-7edfe5a92e4d@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setpgid02: use 1 instead of getpgid(1)
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

SGkgYWxsLAoKWyBDYyBBdmluZXNoLCB3aG8gYWxzbyBwb3N0ZWQgcmV2aWV3IF0KCj4gT24gMTEv
MDQvMjAyMyAwMDo1MSwgRWR3YXJkIExpYXcgd3JvdGU6Cgo+ID4gT24gRnJpLCBBcHIgNywgMjAy
MyBhdCAzOjE44oCvQU0gVGVvIENvdXByaWUgRGlheiA8dGVvLmNvdXByaWVkaWF6QGFybS5jb20+
IHdyb3RlOgo+ID4gPiBIb3dldmVyLCBJIGhhdmUgZW5jb3VudGVyZWQgYW4gaXNzdWUgb24gdGhl
IHNhbWUgY2hlY2sgb2YgdGhpcyB0ZXN0LAo+ID4gPiB1bnJlbGF0ZWQgdG8gRWR3YXJkJ3MgaXNz
dWUuCgo+ID4gPiBJbmRlZWQsIG9uIHN5c3RlbXMgdGhhdCBydW4gdGhlIHNoZWxsIGFzIFBJRCAx
IChmb3IgZXhhbXBsZSBhIGJhc2ljCj4gPiA+IGJ1c3lib3ggcm9vdGZzKSB0aGUgRVBFUk0gY2hl
Y2sgd291bGRuJ3Qgd29yay4KPiA+ID4gVGhpcyBpcyBiZWNhdXNlIExUUCB3b3VsZCBydW4gd2l0
aGluIHRoZSBzYW1lIHNlc3Npb24gSUQgYXMgaW5pdCwgd2hpY2gKPiA+ID4gd291bGQgYWxsb3cg
dGhlIHRlc3QgdG8gY2hhbmdlIHRoZSBQR0lEIGFuZCBub3QgdHJpZ2dlciB0aGUgRVBFUk0uCgo+
ID4gPiBJIGFtIHdvcmtpbmcgb24gYSBwYXRjaCBhbmQgd2FudGVkIHRvIGdldCBzb21lIGlucHV0
LiBNeSBjdXJyZW50IGlkZWEKPiA+ID4gd291bGQgYmUgdG8gZm9yayBhIGNoaWxkIHRoYXQgd291
bGQgY3JlYXRlIGEgbmV3IHNlc3Npb24gYW5kIHRyeSB0bwo+ID4gPiBzZXRwZ2lkKCkgdGhlIGNo
aWxkLgo+ID4gPiBUaGlzIHdvdWxkIGFsc28gYWxsb3cgdG8gdXNlIHRoZSBtYWluIHByb2Nlc3Mn
IFBHSUQsIGFzIGl0IHdvdWxkIGJlIGluCj4gPiA+IGFub3RoZXIgc2Vzc2lvbiBmcm9tIHRoZSBj
aGlsZCBhbnl3YXkuIFRoaXMgd291bGQgcmVtb3ZlIHRoZSBuZWVkIHRvCj4gPiA+IGdldHBnaWQo
KSBpbml0LCB3aGljaCBob3BlZnVsbHkgc2hvdWxkIGZpeCB5b3VyIGlzc3VlIG9uIEFuZHJvaWQg
YXMgd2VsbC4KCj4gPiBUaGF0IG1ha2VzIHNlbnNlIHRvIG1lLCBidXQgaXQgc2VlbXMgdG8gbWUg
dGhhdCBzZXRwZ2lkMDMgaXMgYWxyZWFkeQo+ID4gdGVzdGluZyBpdCB0aGF0IHdheS4KPiBBaCwg
eWVzIGluZGVlZCBpdCBpcyB0ZXN0aW5nIGl0IGV4YWN0bHkgbGlrZSB0aGF0LgoKR29vZCBjYXRj
aCEKCj4gPiA+IEhvd2V2ZXIsIHRoaXMgYWRkcyBhIGxvdCBtb3JlIGNvbXBsZXhpdHkgaW4gdGhl
IHRlc3Q6IG5lZWRpbmcgdG8gZm9yawo+ID4gPiBhbmQgc3luY2hyb25pemUgd2l0aCB0aGUgY2hp
bGQgYXMgdGhlIG1haW4gcHJvY2VzcyBuZWVkcyB0byB3YWl0IGZvciB0aGUKPiA+ID4gY2hpbGQg
dG8gY2hhbmdlIGl0cyBzZXNzaW9uIElELCBvdGhlcndpc2UgdGhlIHRlc3Qgd291bGQgZmFpbC4K
Cj4gPiA+IERvIHlvdSB0aGluayB0aGlzIGlkZWEgbWFrZXMgc2Vuc2UgPyBJIHdvdWxkIHNlbmQg
aXQgZm9yIHJldmlldyBvbmNlIEkKPiA+ID4gaXJvbmVkIG91dCB0aGUgcGF0Y2guCj4gPiA+IEFu
b3RoZXIgc29sdXRpb24gd291bGQgYmUgZm9yIExUUCB0byBjaGFuZ2UgaXRzIHNlc3Npb24gSUQg
YnkgZGVmYXVsdCwKPiA+ID4gd2hpY2ggd291bGQgcHJldmVudCB0aGUgbmVlZCBmb3IgYSBjaGFu
Z2UgdG8gc2V0cGdpZDAyIG9uIHRvcCBvZiBFZHdhcmQncy4KPiA+ID4gSG93ZXZlciwgSSBkb24n
dCBmdWxseSB1bmRlcnN0YW5kIHRoZSBwb3NzaWJsZSBjb25zZXF1ZW5jZXMgb2YgaGF2aW5nCj4g
PiA+IExUUCBjaGFuZ2UgaXRzIFNJRCBmb3IgYWxsIHRlc3RzLgoKPiA+IEFsdGVybmF0aXZlbHks
IG1heWJlIGl0IGNvdWxkIGJlIHJldmVydGVkIHRvIHVzaW5nIHRoZSBoYXJkY29kZWQgOTk5OTkK
PiA+IGFzIGFuIGludmFsaWQgUEdJRCBhcyBpdCB3YXMgYmVmb3JlIEF2aW5lc2gncyBwYXRjaCBv
ciB0aGUgdGVzdCBjYXNlCj4gPiByZW1vdmVkIGJlY2F1c2UgaXQgaXMgaGFuZGxlZCBpbiBzZXRw
Z2lkMDM/Cj4gSSBmZWVsIHRoYXQgaXQgd291bGQgbWFrZSBzZW5zZSB0byByZW1vdmUgdGhlIHRl
c3QgY2FzZSBhcyBpdCdzIHRlc3RlZCBhcyBpcwo+IGluIHNldHBnaWQwMy4gRXZlbiB0aGUgY29t
bWVudHMgZm9yIHRoZSBFUEVSTSBjYXNlcyBhcmUgaWRlbnRpY2FsIGluCj4gbWVhbmluZy4KCkkg
ZG9uJ3Qgd2FudCB0byBhZGQgYW4gdWx0aW1hdGUgYW5zd2VyIChub3Qgc3VyZSBteXNlbGYpLCBi
dXQgSU1ITyB0aGVzZQpzZXRwZ2lkMDMuYyBhbmQgc2V0cGdpZDAyLmMgYXJlbid0IHRoZSBzYW1l
LCBiZWNhdXNlIHNldHBnaWQwMy5jIGNhbGxzOgoxKSB0aGUgZm9yaygpIHlvdSBtZW50aW9uZWQK
Mikgc2V0c2lkKCkgKHZpYSBTQUZFX1NFVFNJRCgpKQoKVGhlcmVmb3JlIHRoZSBFUEVSTSBtZWFu
aW5nIGlzIHRoZSBzYW1lLCBJTUhPIHRoZSBjb2RlIHBhdGggaW4ga2VybmVsIGFuZCBsaWJjCmlz
IG5vdCB0aGUgc2FtZS4KCj4gSWYgaXQgaXMgdG8gYmUga2VwdCwgSSB0aGluayBpdCBjb3VsZCBi
ZSBiZXR0ZXIgdG8gdXNlIHRoZSBrZXJuZWwgcGlkX21heAo+IHJhdGhlciB0aGFuCj4gYW4gaGFy
ZGNvZGVkIHZhbHVlIChmb3IgZXhhbXBsZSA5OTk5OSB3b3VsZCBiZSBwb3NzaWJsZSBvbiBteSBt
YWNoaW5lKSwgYnV0Cj4gSSBhZ3JlZSBpdCB3b3VsZCBiZSBmaW5lLgoKQmFzZWQgdG8gZjI3OTdm
YTQ0IGNvbW1pdCBtZXNzYWdlIGFuZCBteSBtZW1vcnkgSSBndWVzcyBBdmluZXNoIHVzZWQgUElE
IDEgYXMKdGhhdCdzIDEwMCUgc3VyZSBpdCdzIGRpZmZlcmVudCBmcm9tIHdoYXRldmVyIHByb2Nl
c3MgZ3JvdXAgY291bGQgTFRQIHRlc3QgaGF2ZS4KQnV0IElNSE8gdGhhdCdzIG5vdCBuZWNlc3Nh
cnksIGJlY2F1c2UgUEdJRCBvZiBib3RoIHNldHBnaWQwMiBwcm9jZXNzZXMgaXMKYWx3YXlzIHRo
ZSBzYW1lIGFzIFBJRDoKCiQgcHMgeGFvIHVzZXIscGlkLHBwaWQscGdpZCxzaWQsY29tbSB8IGdy
ZXAgLWUgXlVTRVIgLWUgc2V0cGdpZDAyClVTRVIgICAgICAgICBQSUQgICAgUFBJRCAgICBQR0lE
ICAgICBTSUQgQ09NTUFORApwZXZpayAgICAxODIyMDYzIDE4MjA5MDAgMTgyMjA2MyAxODIwOTAw
IHNldHBnaWQwMgpwZXZpayAgICAxODIyMDY0IDE4MjIwNjMgMTgyMjA2NCAxODIwOTAwIHNldHBn
aWQwMgoKVGhlcmVmb3JlIGFueSBQSUQgd291bGQgd29yayA9PiBzdXJlLCBzY2FubmluZyAvcHJv
Yy9zeXMva2VybmVsL3BpZF9tYXggTEdUTToKU0FGRV9GSUxFX1NDQU5GKCIvcHJvYy9zeXMva2Vy
bmVsL3BpZF9tYXgiLCAiJWx1IiwgJnBpZF9tYXgpOwoKPiBBZGRpbmcgUGV0ciBWb3JlbCB0byBD
Q3MgYXMgaGUgcmV2aWV3ZWQgQXZpbmVzaCdzIHBhdGNoLgoKVGhhbmtzISBJIGFscmVhZHkgcG9z
dGVkIG15IHJldmlldywgYnV0IG1pc3NlZCBmb2xsb3dpbmcgZGlzY3Vzc2lvbi4KCktpbmQgcmVn
YXJkcywKUGV0cgoKPiA+IFRoYW5rcywKPiA+IEVkd2FyZAo+IFRoYW5rcyBmb3IgY29taW5nIGJh
Y2sgdG8gbWUsCj4gQmVzdCByZWdhcmRzCj4gVMOpbwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
