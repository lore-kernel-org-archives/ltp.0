Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D173C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:55:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13A93CF095
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 09:55:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCC313C06B8
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 09:55:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4340A1008610
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 09:55:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2B1E20B2C;
 Wed, 20 Mar 2024 08:55:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AAEA136CD;
 Wed, 20 Mar 2024 08:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d3ZqFGqk+mV3SQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 08:55:06 +0000
Date: Wed, 20 Mar 2024 09:54:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240320085451.GA463807@pevik>
References: <20240320063218.449072-1-pvorel@suse.cz>
 <CAEemH2eRspxMmD4LEQ-ospJES2BWAHLqhviX_1uSM=-eefnQug@mail.gmail.com>
 <20240320075605.GA457754@pevik>
 <CAEemH2dRnQUe-j1wwh2ymYRjVRjK2k9F5XvKjgAzVc28_nYExA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dRnQUe-j1wwh2ymYRjVRjK2k9F5XvKjgAzVc28_nYExA@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: B2B1E20B2C
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add tst_selinux_enforcing()
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIE1hciAyMCwgMjAyNCBhdCAzOjU24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCBhbGwsCgo+ID4gPiBIaSBQZXRyLAoKPiA+ID4gT24g
V2VkLCBNYXIgMjAsIDIwMjQgYXQgMjozMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PiB3cm90ZToKCj4gPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBNZXRlIER1cmx1IDxtZXRlZEBsaW51
eC5pYm0uY29tPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PgoKCj4gPiA+IFRoaXMgcGF0Y2ggaXMgZG9pbmcgdGhlIHNhbWUgd29yayBhcyBzZWN1cml0
eV9nZXRlbmZvcmNlKCkgd2hpY2ggcHJvdmlkZXMKPiA+ID4gYnkgJ3NlbGludXgvc2VsaW51eC5o
JywgYnV0IGl0IGlzIHN0aWxsIHdvcnRoIGhhdmluZyBpdCBiZWNhdXNlIHdlIGRvIG5vdAo+ID4g
PiB3YW50IGx0cAo+ID4gPiBoYXMgbWFueSBleHRyYSBkZXBlbmRlbmNpZXMgKGUuZy4gbGlic2Vs
aW51eC1kZXZlbCkuCgo+ID4gKzEKCj4gPiA+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdA
cmVkaGF0LmNvbT4KCj4gPiBUaGFua3MhCgo+ID4gPiA+IC0tLQo+ID4gPiA+IEhpLAoKPiA+ID4g
PiBATGksIEN5cmlsOgo+ID4gPiA+IDEpIEkgZ3Vlc3Mgd2Ugd2FudCB0byBkaXN0aW5ndWlzaCBF
QUNDRVMgZm9yIFNFTGludXggZW5mb3JjaW5nLCByaWdodD8KPiA+ID4gPiBJZiBub3QsIHRoaXMg
Y29tbWl0IHdvdWxkIGJlIGRyb3BwZWQgYW5kIHNlY29uZCBjb21taXQgd291bGQganVzdCB1c2UK
Cj4gPiA+ID4gICAgICAgICBjb25zdCBpbnQgZXhwX2VycnNbXSA9IHt0Yy0+ZXhwZWN0ZWRfZXJy
bm8sIEVBQ0NFU307Cgo+ID4gPiA+ICAgICAgICAgVFNUX0VYUF9GQUlMX0FSUihmYW5vdGlmeV9t
YXJrKGZhbm90aWZ5X2ZkLCBGQU5fTUFSS19BREQgfAo+ID4gPiA+IHRjLT5tYXJrLmZsYWdzLAo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICB0Yy0+bWFzay5mbGFncywgZGlyZmQsIHBh
dGgpLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBleHBfZXJycyk7Cgo+ID4gPiA+
IDIpIFNvbWUgdGltZSBhZ28gSSBwcm9wb3NlZCB0byBtZXJnZSBzb21lIGxpYi8qLmMgZmlsZXMs
IG5vdAo+ID4gPiA+IGp1c3QgaGF2ZSBzbyBtYW55IGZpbGVzIHdpdGggc2luZ2xlIGZ1bmN0aW9u
cyBpbiB0aGUgbGlicmFyeS4gRS5nLgo+ID4gPiA+IGxpYi90c3RfZmlwcy5jLCBsaWIvdHN0X3Nl
bGludXguYywgbGliL3RzdF9sb2NrZG93bi5jIGNvdWxkIGJlIG1lcmdlZAo+ID4gPiA+IGludG8g
bGliL3RzdF9zZWN1cml0eS5jLiBPciBkbyB3ZSB3YW50IHRvIGhhdmUgdGhlc2Ugc2VwYXJhdGU/
CgoKPiA+ID4gSSB0aGluayB0aGUgYW5zd2VyIGlzIFllcy4gVGhlcmUgYXJlIG1vcmUgYW5kIG1v
cmUgbGliLyouYyBmaWxlcyB3aXRoCgo+ID4gSSByZWFkICJZZXMiIGFzIHRvIGtlZXAgbGliL3Rz
dF9zZWxpbnV4LmMsIGxpYi90c3RfbG9ja2Rvd24uYyBhcyBzZXBhcmF0ZS4KCgo+IE9oaCwgc29y
cnksIEkgZG9uJ3QgbWVhbiB0aGF0LiBNb3JlIHNlcGFyYXRlIChib3JpbmchISEpIGZpbGVzIHNo
b3VsZCBiZQo+IGF2b2lkZWQuCgpUaGFuayBmb3IgaW5mby4gSSdsbCBzZW5kIHRoaXMgYW5vdGhl
ciB2ZXJzaW9uLCB3aGljaCBtZXJnZSB0aGVzZSB0d28gZmlsZXMuCkkgZ3Vlc3Mgd2UgY291bGQg
bWVyZ2UgaXQgc29vbi4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBJIHRoaW5rIEkgc2hvdWxkIHN0
ZXAgYXdheSBmcm9tIHRoZSBrZXlib2FyZCBub3csIHdhdGNoaW5nIHRvbyBtdWNoIHNjcmVlbgo+
IHRpbWUgbWFrZXMgbWUgZm9vbGlzaCA6KS4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
