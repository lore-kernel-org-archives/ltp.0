Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A49C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 13:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01CE03CF934
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 15:59:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 408173CF8B2
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 15:58:57 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5703E200CF9
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 15:58:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8245FD82;
 Fri, 12 Apr 2024 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712930335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsSr7BvEML9RWnbYshUYvKdhACOxKB5IWqP07dXFGMI=;
 b=M84xfDSlniK38qBGwXK49EuiFF1/cKopXG9W+BV7x8spx287sdZ3u+m11+woJ+6MLspAJr
 gFoVFMECJ/6kPG3LMQnloHXFn9PEW/lS9QC86U/7r58NzBc2aVcXOC1Sn4G4+smIChf3Ne
 ZR203Oa+vcjCscguSdQqlQHBFWGSfMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712930335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsSr7BvEML9RWnbYshUYvKdhACOxKB5IWqP07dXFGMI=;
 b=zJyRkDLIIaDjPb+MyipOfEgwNu+knnEPDjI62eGpqi4oW3eqFaX6UbCzjX/NNce3udJE79
 5me0c06FnRDumFCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M84xfDSl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zJyRkDLI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712930335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsSr7BvEML9RWnbYshUYvKdhACOxKB5IWqP07dXFGMI=;
 b=M84xfDSlniK38qBGwXK49EuiFF1/cKopXG9W+BV7x8spx287sdZ3u+m11+woJ+6MLspAJr
 gFoVFMECJ/6kPG3LMQnloHXFn9PEW/lS9QC86U/7r58NzBc2aVcXOC1Sn4G4+smIChf3Ne
 ZR203Oa+vcjCscguSdQqlQHBFWGSfMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712930335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsSr7BvEML9RWnbYshUYvKdhACOxKB5IWqP07dXFGMI=;
 b=zJyRkDLIIaDjPb+MyipOfEgwNu+knnEPDjI62eGpqi4oW3eqFaX6UbCzjX/NNce3udJE79
 5me0c06FnRDumFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DDF713942;
 Fri, 12 Apr 2024 13:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m0OXHR8+GWa0aAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Apr 2024 13:58:55 +0000
Date: Fri, 12 Apr 2024 15:58:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Kogure =?utf-8?B?QWtpaGlzYeOAgCgg5bCP5pqu44CA5piO5LmFICk=?=
 <akihisa.kogure.ke@kyocera.jp>
Message-ID: <Zhk96SJ1ON44lo9H@yuki>
References: <TYAPR01MB6044F6C94C3BEFC65801A849D93B2@TYAPR01MB6044.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TYAPR01MB6044F6C94C3BEFC65801A849D93B2@TYAPR01MB6044.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8E8245FD82
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] input_helper: Modify the check range of the
 input event number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhClRoZSBwYXRjaCBsb29rcyBnb29kLCBob3dldmVyIHRpIGRvZXMgbm90IGFwcGx5IGZvciBh
IHNldmVyYWwgcmVhc29ucy4KCj4gVGhlIGZvbGxvd2luZyBjb21taXQgd2FzIHNldCB0byAxMDIz
IGZvciB0aGUgdXBwZXIgbGltaXQgb2YgZXZlbnQgSURzLCBzbyB3ZSBjaGFuZ2VkIGl0IHRvIGNo
ZWNrIHVwIHRvIDAtMTAyMy4KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29t
bWl0LzdmOGQ0Y2FkMWU0ZTExYTQ1ZDAyYmQ2ZTAyNGNjMjgxMjk2M2MzOGEKPiAKPiAtLS0KPiBD
aGFuZ2VzIGluIHYyOgo+IC0gQ2hhbmdlZCBpdCB0byBjaGVjayB1cCB0byAwLTEwMjMuCj4gLS0t
Cj4gLS0tCgpUaGVzZSBzZXF1ZW5jaWVzIG9mIC0tLSBhY3R1YWxseSBjb3JydXB0IHRoZSBwYXRj
aCwgc2luY2UgLS0tIGhhcyBhCnNwZWNpYWwgbWVhbmluZywgaXQgZGl2aWRlcyB0aGUgZGVzY3Jp
cHRpb24gZnJvbSB0aGUgYWN0dWFsIGNoYW5nZXMgaW4KY29kZS4KCkJ1dCBldmVuIHdoZW4gSSBy
ZW1vdmUgdGhpcyBwYXJ0IG9mIHRoZSBwYXRjaCBpdCBkb2VzIG5vdCBhcHBseSBiZWNhdXNlCnRo
ZSBwYXRjaCBpdHNlbGYgd2FzIGNvcnJ1cHRlZCBieSB5b3VyIGVtYWlsIGNsaWVudCwgdGhlIHRh
YnMgXHQgd2VyZQpyZXBsYWNlZCB3aXRoIHNwYWNlcy4KClNlZTogaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC9uZXh0L3Byb2Nlc3MvZW1haWwtY2xpZW50cy5odG1sCgo+IElmIHRoZSBp
bnB1dCBldmVudCBudW1iZXIgaXMgZ3JlYXRlciB0aGFuIDMyLCB0aGUgbmV3bHkgYWRkZWQgZXZl
bnQgSUQKPiB3aWxsIGJlIDI1NiBvciBsYXRlci4KPiBXaGVuIHRoZXJlIHdlcmUgYWxyZWFkeSAz
MiBpbnB1dCBldmVudHMgaW4gdGhlIGRldmljZSwgdGhpcyB0ZXN0IHByb2dyYW0KPiBvbmx5IGNo
ZWNrZWQgMH45OSwgc28gaXQgZmFpbGVkIGJlY2F1c2UgaXQgY291bGQgbm90IGZpbmQgYSBuZXcg
aW5wdXQKPiBldmVudCBJRC4KPiAKPiBJbiBvcmRlciB0byBlbGltaW5hdGUgdGhpcyBmYWlsdXJl
LCB3ZSBjaGFuZ2VkIHRoZSBldmVudCBJRCByYW5nZSB0byBiZQo+IGNoZWNrZWQgYnkgdGhpcyB0
ZXN0IHByb2dyYW0gdG8gMH4xMDIzLgoKWW91IGFyZSBtaXNzaW5nIHNpZ25lZC1vZmYtYnkgbGlu
ZSBoZXJlLCBzZWU6Cmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nl
c3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWw/aGlnaGxpZ2h0PXNpZ25lZCUyMG9mZiNkZXZlbG9w
ZXItcy1jZXJ0aWZpY2F0ZS1vZi1vcmlnaW4tMS0xCgoKPiAtLS0KPiAKPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
aW5wdXQvaW5wdXRfaGVscGVyLmMKPiBpbmRleCAwOTUzMGZiLi42YjYwZDE3IDEwMDY0NAo+IC0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfaGVscGVyLmMKPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL2lucHV0L2lucHV0X2hlbHBlci5jCj4gQEAgLTQwLDcgKzQwLDcgQEAKPiAg4oCC
4oCC4oCC4oCC4oCCaW50IHJldCwgZmQgPSAtMTsKPiAg4oCC4oCC4oCC4oCC4oCCdW5zaWduZWQg
aW50IGk7Cj4gCj4gLeKAguKAguKAguKAguKAgmZvciAoaSA9IDA7IGkgPCAxMDA7IGkrKykgewo+
ICvigILigILigILigILigIJmb3IgKGkgPSAwOyBpIDwgMTAyNDsgaSsrKSB7Cj4gIOKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAgnNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIi9k
ZXYvaW5wdXQvZXZlbnQlaSIsIGkpOwo+IAo+ICDigILigILigILigILigILigILigILigILigILi
gILigIJmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkpOwo+IAo+IAo+IAo+IC0tLQo+IEFraWhpc2Eg
S29ndXJlCj4gYWtpaGlzYS5rb2d1cmUua2VAa3lvY2VyYS5qcAo+IAo+IC0tIAo+IE1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKLS0gCkN5cmls
IEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
