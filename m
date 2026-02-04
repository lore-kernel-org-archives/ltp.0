Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE70AE9538F
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:23:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7309D3CE0C5
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:23:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E66693C259D
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:23:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE2D4600784
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:23:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C8285BD5D;
 Wed,  4 Feb 2026 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770207818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv01/SFlJtm5dQwOI/Nb2pDmKv1i8gWBSsYgFlapxPg=;
 b=b0SRj/n/V1BXTwln+fc9JDddoyTRhNoJ5kJ0vjVIdfXdyQLVr3OFhtYXklCBwwoxH6M1O6
 p7WFN55JbY1dthrapJLypSjntxfVhZbkpS0HGdBbj+6aNpI8zjY/B7JLQPwICWKpdkoKQy
 9npQAIOeRzepkioviRbUHHryETvMihA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770207818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv01/SFlJtm5dQwOI/Nb2pDmKv1i8gWBSsYgFlapxPg=;
 b=wxPi/ylqmr/6eyhBNp13O2azUXyGXNf5EEWJu4T17uZxChY9VhgDab2TbpAJ0fMi6U4ye/
 pzQTzgX0iIadnGAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="b0SRj/n/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="wxPi/ylq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770207818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv01/SFlJtm5dQwOI/Nb2pDmKv1i8gWBSsYgFlapxPg=;
 b=b0SRj/n/V1BXTwln+fc9JDddoyTRhNoJ5kJ0vjVIdfXdyQLVr3OFhtYXklCBwwoxH6M1O6
 p7WFN55JbY1dthrapJLypSjntxfVhZbkpS0HGdBbj+6aNpI8zjY/B7JLQPwICWKpdkoKQy
 9npQAIOeRzepkioviRbUHHryETvMihA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770207818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv01/SFlJtm5dQwOI/Nb2pDmKv1i8gWBSsYgFlapxPg=;
 b=wxPi/ylqmr/6eyhBNp13O2azUXyGXNf5EEWJu4T17uZxChY9VhgDab2TbpAJ0fMi6U4ye/
 pzQTzgX0iIadnGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBCEB3EA63;
 Wed,  4 Feb 2026 12:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tk0xM0k6g2mwYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 12:23:37 +0000
Date: Wed, 4 Feb 2026 13:23:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260204122332.GC224465@pevik>
References: <20260203024320.227453-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260203024320.227453-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C8285BD5D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] openat2: define _GNU_SOURCE and include
 <fcntl.h>
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

aGkgTGksCgo+IE9uIEZlZG9yYSBSYXdoaWRlIChnbGliYyAyLjQzKyksIGxpYmMgZXhwb3NlcyBv
cGVuYXQyKCkgYW5kIHN0cnVjdCBvcGVuX2hvdywKPiBzbyBvdXIgY29uZmlndXJlIHNjcmlwdCBk
ZWZpbmVzIEhBVkVfT1BFTkFUMiBhbmQgdGhlIGZhbGxiYWNrIGRlZmluaXRpb24gaW4KPiBsYXBp
L29wZW5hdDIuaCBnZXRzIHNraXBwZWQuIEJ1dCBvcGVuYXQyMCouYyBuZXZlciBpbmNsdWRlZCA8
ZmNudGwuaD4gKGFuZAo+IGxhY2tlZCBfR05VX1NPVVJDRSksIHNvIHRoZSBsaWJjLXByb3ZpZGVk
IHByb3RvdHlwZSBhbmQgc3RydWN0IHN0YXllZCBoaWRkZW4sCj4gc28gY29tcGlsYXRpb24gZmFp
bGVkOgoKPiAgICMgdW5hbWUgLXIKPiAgIDYuMTguMC02NS5mYzQ0Lng4Nl82NAoKPiAgICMgcnBt
IC1xZiAvdXNyL2luY2x1ZGUvZmNudGwuaAo+ICAgZ2xpYmMtZGV2ZWwtMi40My0xLmZjNDQueDg2
XzY0Cgo+ICAgIyBubSAtRCAvdXNyL2xpYjY0L2xpYmMuc28uNiB8IGdyZXAgLXcgb3BlbmF0Mgo+
ICAgMDAwMDAwMDAwMDBlYjg5MCBXIG9wZW5hdDJAQEdMSUJDXzIuNDMKCj4gICAjIG1ha2UgLUMg
dGVzdGNhc2Uva2VybmVsL3N5c2NhbGxzL29wZW5hdDIKPiAgIG9wZW5hdDIwMS5jOjI3OjYyOiBl
cnJvcjogaW52YWxpZCBhcHBsaWNhdGlvbiBvZiDigJhzaXplb2bigJkgdG8gaW5jb21wbGV0ZSB0
eXBlIOKAmHN0cnVjdCBvcGVuX2hvd+KAmQo+ICAgICAyNyB8ICAgICAgICAgeyZkaXJfZmQsIFRF
U1RfRklMRSwgT19SRFdSLCBTX0lSV1hVLCAwLCAmaG93LCBzaXplb2YoKmhvdyl9LAoKPiBEZWZp
bmUgX0dOVV9TT1VSQ0UgYW5kIGluY2x1ZGUgPGZjbnRsLmg+IGluIG9wZW5hdDIgdGVzdHMgdG8g
bWFrZSB0aGUKPiBwcm90b3R5cGUgYXZhaWxhYmxlIGFuZCBmaXggdGhlIGJ1aWxkLgoKPiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMS5jIHwgMyArKysKPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMi5jIHwgMyArKysKPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMy5jIHwgMyArKysKPiAgMyBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
b3BlbmF0Mi9vcGVuYXQyMDEuYwo+IGluZGV4IGVjZDYzYjE1MC4uNDBhYzJmNmQ5IDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDEuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDEuYwo+IEBAIC00
LDYgKzQsOSBAQAo+ICAgKgo+ICAgKiBCYXNpYyBvcGVuYXQyKCkgdGVzdC4KPiAgICovCj4gKyNk
ZWZpbmUgX0dOVV9TT1VSQ0UKCldoeSBfR05VX1NPVVJDRT8gZ2xpYmMgdGVzdCB0c3Qtb3BlbmF0
Mi5jIFsxXSB3aGljaCBpbmNsdWRlcyA8ZmNudGwuaD4sIHVzZXMKc3RydWN0IG9wZW5faG93IGFu
ZCB0ZXN0IG9wZW5hdDIoKSBkb2VzIG5vdCBkZWZpbmUgaXQuIE5laXRoZXIgb3BlbmF0MigpIG5v
cgpzdHJ1Y3Qgb3Blbl9ob3cgYXJlIGd1YXJkZWQgYnkgI2lmZGVmIF9fVVNFX0dOVS4KCk9fRElS
RUNUT1JZIGlzIGd1YXJkZWQgYnkgI2lmZGVmIF9fVVNFX1hPUEVOMks4IGJ1dCB0aGlzIHNob3Vs
ZCBiZSBzYWZlIGFzIHdlCmNvbXBpbGUgd2l0aCAtc3RkPWdudTk5LgoKSSBtZWFuIGl0J3Mgbm90
IGEgYmlnIGRlYWwsIGJ1dCBpZiBpdCB3b3JrcyB3aXRob3V0IGl0IHBsZWFzZSByZW1vdmUgaXQu
CgpbMV0gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9naXQvP3A9Z2xpYmMuZ2l0O2E9YmxvYjtmPXN5
c2RlcHMvdW5peC9zeXN2L2xpbnV4L3RzdC1vcGVuYXQyLmMKWzJdIGh0dHBzOi8vc291cmNld2Fy
ZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWJsb2I7Zj1zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9i
aXRzL29wZW5hdDIuaAoKPiArI2luY2x1ZGUgPGZjbnRsLmg+CgpTaG91bGQgbm90IHdlIHVzZSBp
bmNsdWRlIGxhcGkvZmNudGwuaD8KCj4gKwo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAgI2lu
Y2x1ZGUgImxhcGkvb3BlbmF0Mi5oIgoKbGFwaS9vcGVuYXQyLmggdXNlcyBzdHJ1Y3Qgb3Blbl9o
b3cgZGlyZWN0bHksIHNob3VsZG4ndCBiZSBpbmNsdWRlZCBsYXBpL2ZjbnRsLmgKdGhlcmU/CgpL
aW5kIHJlZ2FyZHMsClBldHIKCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvb3BlbmF0Mi9vcGVuYXQyMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0
Mi9vcGVuYXQyMDIuYwo+IGluZGV4IDZkMWI1YTY3Yy4uMzI5YzZhNGE1IDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDIuYwo+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDIuYwo+IEBAIC00LDYgKzQs
OSBAQAo+ICAgKgo+ICAgKiBvcGVuYXQyKCkgdGVzdHMgd2l0aCB2YXJpb3VzIHJlc29sdmUgZmxh
Z3MuCj4gICAqLwo+ICsjZGVmaW5lIF9HTlVfU09VUkNFCj4gKyNpbmNsdWRlIDxmY250bC5oPgo+
ICsKPiAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gICNpbmNsdWRlICJsYXBpL29wZW5hdDIuaCIK
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQy
MDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYwo+IGlu
ZGV4IDZhYzQ5ZWY0Yy4uY2QwYzAwZDc1IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYwo+IEBAIC00LDYgKzQsOSBAQAo+ICAgKgo+ICAgKiBC
YXNpYyBvcGVuYXQyKCkgdGVzdCB0byBjaGVjayB2YXJpb3VzIGZhaWx1cmVzLgo+ICAgKi8KPiAr
I2RlZmluZSBfR05VX1NPVVJDRQo+ICsjaW5jbHVkZSA8ZmNudGwuaD4KPiArCj4gICNpbmNsdWRl
ICJ0c3RfdGVzdC5oIgo+ICAjaW5jbHVkZSAibGFwaS9vcGVuYXQyLmgiCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
