Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6774C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 14:30:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F56A3CA14E
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 16:30:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9F103CA100
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:30:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 17385600CD5
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 711EE2199F;
 Wed,  4 Jun 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C58513A63;
 Wed,  4 Jun 2025 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vDV4EYdYQGjGeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Jun 2025 14:30:31 +0000
Date: Wed, 4 Jun 2025 16:30:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250604143025.GA1128251@pevik>
References: <20250602170831.404641-1-pvorel@suse.cz>
 <aD7P6mPoJbe_CAgP@yuki.lan> <20250603161148.GA1080027@pevik>
 <CAASaF6yU+s4ZHgSU5mvb+R4cZiamqqM0eN6sHQVTHH0TEP6uug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yU+s4ZHgSU5mvb+R4cZiamqqM0eN6sHQVTHH0TEP6uug@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 711EE2199F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] configure: Fix build on kernel 6.14 headers
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

SGkgYWxsLAoKPiBPbiBUdWUsIEp1biAzLCAyMDI1IGF0IDY6MTLigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgYWxsLAoKPiA+ID4gSGkhCj4gPiA+IExldCdz
IHB1c2ggdGhpcyBub3csIGl0J3Mgc2ltcGxlIGVub3VnaCBhbmQgZml4ZXMgdGhlIENJLgoKPiA+
IEknbSBzb3JyeSwgaXQgZGlkIG5vdCBmaXggdGhlIHByb2JsZW0gZHVlIHRoZSBvbGQgcHJvYmxl
bSBvZiBpbmRpcmVjdCBpbmNsdWRlCj4gPiA8bGludXgvbW91bnQuaD4gYnkgPGxpbnV4L2ZzLmg+
IG9uIEFscGluZSB2My4yMiAodGhlIGRlZmF1bHQgQWxwaW5lIHZlcnNpb24gaW4KPiA+IEdpdEh1
YiBhY3Rpb24pLCB3aGljaCB1c2VzIDYuMTQuMiBrZXJuZWwgaGVhZGVyczoKCj4gPiAgICAgSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9saW51eC9mcy5oOjE5LAo+ID4gICAgICAg
ICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvbGludXgvYnRyZnMuaDoyOSwKPiA+ICAg
ICAgICAgICAgICAgICAgICAgIGZyb20gc3RhdG1vdW50MDIuYzoyMzoKCj4gZnJvbSBzdGF0bW91
bnQwMi5jOgoKPiBUaGUgYnRyZnMgdmFsaWRhdGlvbiBpcyBjdXJyZW50bHkgc2tpcHBlZCBkdWUg
dG8gdGhlIGxhY2sgb2Ygc3VwcG9ydCBmb3IgVkZTCj4gLi4uCj4gI2luY2x1ZGUgPGxpbnV4L2J0
cmZzLmg+Cgo+IERvZXMgdGhlIHRlc3QgYWN0dWFsbHkgbmVlZCBsaW51eC9idHJmcy5oID8KCkph
biwgdmVyeSBnb29kIHBvaW50LCBpdCByZWFsbHkgd2FzIG5vdCBuZWVkZWQuIFJlbW92YWwgbWVy
Z2VkIGFzIGZlOGMwZGFjNWEsCnRoYW5rIHlvdSEKCj4gPiBJIHN1cHBvc2Ugd2Ugc2hvdWxkIGhh
dmUgMiBvciAzIGxhcGkgZmlsZXM6Cgo+ID4gMSkgbGFwaS9tb3VudC5oCj4gPiBtb3VudCBkZWZp
bml0aW9ucyAoZ3VhcmRlZCBieSAjaWZuZGVmKSAtIHRoZSBvbGQgb25lcyBmcm9tIDxzeXMvbW91
bnQuaD4gZS5nLgo+ID4gTVNfUkVDLCBNU19QUklWQVRFIGFuZCBwcm9iYWJseSB0aGUgbmV3IG9u
ZXMgZnJvbSA8bGludXgvbW91bnQuaD4sIGUuZy4KPiA+IE1OVF9JRF9SRVFfU0laRV9WRVIwLiBO
b25lIG9mIDxzeXMvbW91bnQuaD4gPGxpbnV4L21vdW50Lmg+IHNob3VsZCBiZSBpbmNsdWRlZAo+
ID4gaW4gaXQuCgo+ID4gMikgbGFwaS9saW51eF9tb3VudC5oCj4gPiBtb3VudCBzdHJ1Y3RzIChu
b3dhZGF5cyB2YXN0IG1ham9yaXR5IGlmIG5vdCBhbGwgZnJvbSA8bGludXgvbW91bnQuaD4gb25s
eSkuCj4gPiBUaGlzIGhlYWRlciBjYW4gaW5jbHVkZSA8bGludXgvbW91bnQuaD4gYW5kIGxhcGkv
bW91bnQuaC4KPiA+IFRoYXQgYWxsb3dzIHRvIGhhdmUgY29uZmlndXJlLmFjIHRvIHNhZmVseSB1
c2UgPGxpbnV4L21vdW50Lmg+IGZvciBkZXRlY3Rpb24uCgo+ID4gMykgbGFwaS9zeXNfbW91bnQu
aAo+ID4gT3B0aW9uYWwgaGVscGVyIGhlYWRlciB3aGljaCB3b3VsZCBpbmNsdWRlIGxhcGkvbW91
bnQuaCBhbmQgPHN5cy9tb3VudC5oPgo+ID4gKHRvIGtlZXAgdGhlIGN1cnJlbnQgYXBwcm9hY2gg
dGhhdCBsYXBpIGhlYWRlcnMgaW5jbHVkZSBzeXN0ZW0gaGVhZGVycyBzbyB0aGF0Cj4gPiB0ZXN0
cyBkb2VzIG5vdCBuZWVkIHRvIGRvIGl0LgoKSSdsbCBiZSBwcmFnbWF0aWMgYW5kIGFsdGhvdWdo
IHRoZSBhYm92ZSB3b3VsZCBiZSBhbiBpbXByb3ZlbWVudCwgSSdsbCBwb3N0cG9uZQpkb2luZyBp
dCB1bnRpbCBpdCdzIHJlYWxseSBuZWVkZWQuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiBXRFlU
PwoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
