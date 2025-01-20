Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D2DC02185
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 09:08:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE8593C1818
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:08:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1D883C036A
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 10:07:53 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 87A06142FCE5
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 10:07:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7343321203;
 Mon, 20 Jan 2025 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737364070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GA5UnrJdRpFiSEmuKaCqPrWxP1y6imXvFgCnrmjn51w=;
 b=ySoi6SVB6+xuFb0EYy/iRDXuZIcfNrkry1hsU4GyQhkC2ptV3Fy63SnEjKARAOY5lIKgId
 ACTaKkR8SuF+OUv1R73PK1kE3+00w3hZkUovL6pEGOFUHgdkT0/hfaPR3gZ9QVoFCwA8Kg
 iXahnzLKyYm9u8z6vwrL1pN48Q86U8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737364070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GA5UnrJdRpFiSEmuKaCqPrWxP1y6imXvFgCnrmjn51w=;
 b=dBewFfw1ujtS6PhEpsbq1nu0Q7fGz2Q6x6EbBY3vKS8dUMoEtg+I/eCs66BCzPfu3GD9eD
 AbDYG/eS3J4SpHDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ySoi6SVB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dBewFfw1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737364070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GA5UnrJdRpFiSEmuKaCqPrWxP1y6imXvFgCnrmjn51w=;
 b=ySoi6SVB6+xuFb0EYy/iRDXuZIcfNrkry1hsU4GyQhkC2ptV3Fy63SnEjKARAOY5lIKgId
 ACTaKkR8SuF+OUv1R73PK1kE3+00w3hZkUovL6pEGOFUHgdkT0/hfaPR3gZ9QVoFCwA8Kg
 iXahnzLKyYm9u8z6vwrL1pN48Q86U8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737364070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GA5UnrJdRpFiSEmuKaCqPrWxP1y6imXvFgCnrmjn51w=;
 b=dBewFfw1ujtS6PhEpsbq1nu0Q7fGz2Q6x6EbBY3vKS8dUMoEtg+I/eCs66BCzPfu3GD9eD
 AbDYG/eS3J4SpHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33DCC1393E;
 Mon, 20 Jan 2025 09:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QaFOC2YSjmfQLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 09:07:50 +0000
Date: Mon, 20 Jan 2025 10:07:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250120090740.GB794282@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
X-Rspamd-Queue-Id: 7343321203
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] pidns05 timeout (was: [PATCH 1/2] lib:
 multiply the timeout if detect slow kconfigs)
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
IHJlZ3Jlc3Npb24gb24gKmFsbCogdGVzdHMgd2hpY2ggdXNlIHRzdF9uZXQuc2guCi4uLgoKRllJ
IGFsc28gYXQgbGVhc3QgcGlkbnMwNS5jIHNvbWV0aW1lcyBmYWlscyBkdWUgdGltZW91dCB3aXRo
IHRoaXMgY2hhbmdlLgpPbiBzb21lIG9mIFNMRVMgcHJvZHVjdCBwcmV2aW91c2x5IHBpZG5zMDUu
YyBydW4gZm9yIDMgc2VjLiBXaXRoIHRoaXMgY2hhbmdlIGl0CnJ1bnMgMTJzIGFuZCB0aGVyZWZv
cmUgdGltZW91dHMuCgpJbiBwaWRuczA1LmMgY2FzZSBjaGlsZCBpcyBydW4gNXguIEZvciBlYWNo
IG9mIHRoaXMgY2hpbGQgd2UgYWdhaW4gZGV0ZWN0IGlmIHdlCnJ1biBvbiBzbG93IGNvbmZpZy4g
TWF5YmUgd2Ugc2hvdWxkIGhhdmUgdXNlZCBzdHJ1Y3QgdHN0X3Rlc3QgbWVtYmVyIHRvIGNhY2hl
CnRoZSB2YWx1ZS4KCldoYXQgYm90aGVycyBtZSBtb3JlIHRoYXQgaG93IG11Y2ggdGltZSB3ZSB3
YXN0ZSBmb3Igd2hvbGUgTFRQIHRlc3Rpbmcgd2l0aApyZXBlYXRlZGx5IGRldGVjdGluZyBzbG93
IGNvbmZpZyBmb3IgYWxsIHRlc3RzIChydW50ZXN0L3N5c2NhbGxzIGhhcyAxNDU3IGl0ZW1zLAp3
ZSBydW4gaXQgbW9yZSB0aW1lcyBmb3IgZWFjaCBwcm9kdWN0IHdpdGggZGlmZmVyZW50IGtlcm5l
bCBjbWRsaW5lIHBhcmFtZXRlcnMpLgpJIGRvbid0IGtub3cgd2hhdCB3YXMgc3VwcG9zZWQgdG8g
YmUgZml4ZWQgYnkgdGhpcyBmZWF0dXJlLCBpcyBpdCByZWFsbHkgd29ydGgKb2Ygc2xvd2Rvd24/
IFdoeSBub3QganVzdCBzZXQgTFRQX1JVTlRJTUVfTVVMPTIgb24gc2xvdyBrZXJuZWxzPyBXZSBj
b3VsZCBoYXZlCnRvb2wgd2hpY2ggd291bGQgJ2V4aXQgMScgb24gInNsb3ciIGtlcm5lbCBhbmQg
J2V4aXQgMCcgb24gbm9ybWFsIGtlcm5lbCB0byBkbwphdXRvbWF0aWMgZGV0ZWN0aW9uLCB3aGlj
aCBjb3VsZCBiZSBydW4gYnkgZnJhbWV3b3JrcyBqdXN0IG9uY2UuCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
