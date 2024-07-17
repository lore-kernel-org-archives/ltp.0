Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA54C3DA62
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:52:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318AE3D1AE5
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:52:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B99B83D1AD2
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:51:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7CA06602291
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:51:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ED3E1FB96;
 Wed, 17 Jul 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62724136E5;
 Wed, 17 Jul 2024 17:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g4fhFrsEmGZWQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:51:55 +0000
Date: Wed, 17 Jul 2024 19:51:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240717175150.GA690776@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <CAEemH2cAfjhGLv3GWPA_5xgsFNYiRf-oQwyLPhbWWSPKn=yAhw@mail.gmail.com>
 <ZpeGRluc-U1NHjNY@rei>
 <CAEemH2f4sO40tJxT2wokw=SDaeAvNhR-z8NOqW0=xWSKSv3Wsg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f4sO40tJxT2wokw=SDaeAvNhR-z8NOqW0=xWSKSv3Wsg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8ED3E1FB96
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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

SGkgYWxsLAoKPiBPbiBXZWQsIEp1bCAxNywgMjAyNCBhdCA0OjQ54oCvUE0gQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiBTaW5jZSBleGVjdnBlKCkg
aXMgYSBHTlUgZXh0ZW5zaW9uLCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0Cj4gPiA+IHdlIGFyZSBj
b21waWxpbmcgd2l0aCBHTlUgZXh0ZW5zaW9ucyBlbmFibGVkLgoKPiA+ID4gYWRkIHRoaXMgbGlu
ZSBpbnRvIHRoZSBoZWFkIG9mIHRzdF90ZXN0LmM6Cj4gPiA+ICNkZWZpbmUgX0dOVV9TT1VSQ0UK
Ckdvb2QsIHlvdSBhbHJlYWR5IG5vdGljZWQuCgo+ID4gQXMgZm9yIHRoZSBleGVjdnBlKCkgSSd2
ZSB1c2VkIHRoYXQgZm9yIHRoZSBwcm90b3R5cGUgYnV0IEknbSB1bnN1cmUgaWYKPiA+IGl0IGNv
dWxkIGJlIHVzZWQgaW4gdGhlIGZpbmFsIHByb2R1Y3QsIHNpbmNlIHRoaXMgaXMgdGhlIHRlc3Qg
bGlicmFyeSBpdAo+ID4gaGFzIHRvIGNvbXBpbGUgb24gYWxsIGtpbmRzIG9mIGxpYmMgb3V0IHRo
ZXJlLiBJdCBsb29rcyBsaWtlIG11c2wgZG9lcwo+ID4gc3VwcG9ydCBpdCBidXQgSSBoYXZlbid0
IGNoZWNrZWQgQW5kcm9pZCBiaW9uaWMuCgoKPiA+IFNvIHdlIG1heSBuZWVkIHRvIHdyaXRlIG91
ciBvd24gaW1wbGVtdGFudGlvbiBvbiB0aGUgdG9wIG9mIHRoZSBleGVjdmUoKQo+ID4gc3lzY2Fs
bC4gQnV0IHRoYXQgc2hvdWxkIGJlIGFzIGVhc3kgYXMgZ2V0dGluZyB0aGUgcGF0aCB0byB0aGUg
c2NyaXB0Cj4gPiBiZWZvcmUgd2UgcGFzcyBpdCB0byBleGVjdmUoKS4KCkl0IHN1cHBvcnRzIGl0
LiBJdCBsb29rcyBsaWtlIGV2ZW4gd2l0aG91dCBfR05VX1NPVVJDRToKaHR0cHM6Ly9hbmRyb2lk
Lmdvb2dsZXNvdXJjZS5jb20vcGxhdGZvcm0vYmlvbmljLmdpdC8rL3JlZnMvaGVhZHMvbWFpbi9s
aWJjL2luY2x1ZGUvdW5pc3RkLmgjMTQyCgpCdXQgYmV0dGVyIHRvIGtlZXAgRWR3YXJkIGluIGxv
b3AuCgo+IEluZGVlZC4gIFdlIG5lZWQgdG8gY3JlYXRlIGEgbHRwX2V4ZWN2cGUoKSBiYXNlZCBv
biBleGVjdmUoKS4KClNvIHRoZXJlIHdpbGwgYmUgdjIsIHJpZ2h0PwoKS2luZCByZWdhcmRzLApQ
ZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
