Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF6AC02187
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:35:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F04E63C7BA3
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:35:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22CA03C7A70
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:35:40 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2CF161021173
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:35:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53FD7211D7;
 Thu, 16 Jan 2025 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737016537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8iIBk1W9jL8r7pyqmysGYy0mR/6hKGCqdFc6bFLdt8=;
 b=qCH88Cfve0g64XiDyqiuR+uY9yl/fDqAVp08jEaLwRpih8Enoj8NUwafvWroggQ98IdITI
 Dv/bIzmAK+2sHMW0ihgH+h8ctTqT4u+Kt0NV5okeOhaIIev7D7K0rzjHwzuRQrw/+nAThz
 ZWW2VubQ3/iXaBhmU8KHeiE8Y0NNAsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737016537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8iIBk1W9jL8r7pyqmysGYy0mR/6hKGCqdFc6bFLdt8=;
 b=Paok41vKMi6VYJ05fWAsg1qndi5UpWMwC0xpNlkiu57eBL09ii5kqAgVjxprvs4PjWyN8F
 +sfYPKNoLmwA1RAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737016536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8iIBk1W9jL8r7pyqmysGYy0mR/6hKGCqdFc6bFLdt8=;
 b=y262jjCSOMC8oyiXumhKUrtmMSyEIbEYD7EEygRgGiJj3Qb8Kqk2wBQNDTar/TNjF91tkb
 IGjJMdXw7ysmH/fOzrmzzhx2PO41+v2We1uB8RVDIiU6+2IMbCutZ1tDL4PSyx1qHI4w9P
 kuNJ3WMd/hBt7IPV6SSlW90UUSgSdmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737016536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8iIBk1W9jL8r7pyqmysGYy0mR/6hKGCqdFc6bFLdt8=;
 b=MTObFG7yA+v8WByS7mZkHFx1AqksrCok4/uJZTR3a95oKOD3Dpwn5E+UpPsMdAd/aGaViv
 Fv1RmUERgNM+DTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E7D213A57;
 Thu, 16 Jan 2025 08:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id styVAdjEiGe3bwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 08:35:36 +0000
Date: Thu, 16 Jan 2025 09:35:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250116083534.GA670376@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,tst_net.sh:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
IGFuZCB1c2UgaXQgZm9yIHRzdF9uc197Y3JlYXRlLGV4ZWN9LiBCdXQgbWF5YmUgdGhlcmUKPiA+
IGlzCj4gPiBhbm90aGVyIHNvbHV0aW9uIChvciBhbm90aGVyIHByb2JsZW0pLgoKCj4gT3IsIGFu
b3RoZXIgd2F5IGlzIGp1c3QgdG8gc2V0ICd0c3RfdGVzdC0+dGltZW91dCA9PSBUU1RfVU5MSU1J
VEVEX1RJTUVPVVQnCj4gaW4gdGhvc2UgdGVzdGNhc2UvbGliIHRvb2xzLgoKVGhpcyB3b3VsZCBi
ZSBhbiBlYXNpZXN0IGZpeCwgYnV0IE9UT0ggaXQncyBhbm90aGVyIGhhY2sgd2hpY2ggZGVwZW5k
cyBvbiB0aGUKaW1wbGVtZW50YXRpb24gKEkgd291bGQgcHJlZmVyIHRvIGdldCByaWQgb2YgdGhl
IG5lZWQgdG8gdXNlIHN0cnVjdCB0c3RfdGVzdApmb3IgdGhlc2UgdG9vbHMgaW5zdGVhZCkuCgpB
bnl3YXksIEknbGwgc2VuZCBhIHBhdGNoIHRvIGZpeCB0c3RfbmV0LnNoLCBidXQgaWRlYXMgaG93
IHRvIGltcHJvdmUgYW5kIHVuaWZ5CnRlc3RjYXNlcy9saWIgYXJlIHdlbGNvbWUuCgpLaW5kIHJl
Z2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
