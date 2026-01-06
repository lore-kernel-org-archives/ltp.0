Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED14CC47BC8
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 08:40:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EB073C06B8
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 09:40:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E3C73C06B8
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 09:39:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 423BF1000237
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 09:39:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A79A55BCC4;
 Tue,  6 Jan 2026 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767688792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8nb/jjOBv80zpDXrNJRfHGUWfNMu9ZVhe5YtYePJ4A=;
 b=PWsHsJbl2sOpbfM48XI5R1644vPxHnvQLuu0l07LPAzpovobPAfKDAET8eksp2lGUYvvRq
 wNYnoQYHn87FBgiTrTedvc2dMNZu6CnEIWHKVOhmr1/OZfcFQgzVEfaEh0kxFQm1wzqMtX
 jLKOyBTLzJi1FNwPEo99Y28OD1tKuVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767688792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8nb/jjOBv80zpDXrNJRfHGUWfNMu9ZVhe5YtYePJ4A=;
 b=sD/jtWnypToIkKDniiGX18wjutd21NT8GKQ7IesTSSkInVW7jJPWpyc9QM54yeHiFA6R0M
 HZseP4jYl8sGWgBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767688792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8nb/jjOBv80zpDXrNJRfHGUWfNMu9ZVhe5YtYePJ4A=;
 b=PWsHsJbl2sOpbfM48XI5R1644vPxHnvQLuu0l07LPAzpovobPAfKDAET8eksp2lGUYvvRq
 wNYnoQYHn87FBgiTrTedvc2dMNZu6CnEIWHKVOhmr1/OZfcFQgzVEfaEh0kxFQm1wzqMtX
 jLKOyBTLzJi1FNwPEo99Y28OD1tKuVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767688792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8nb/jjOBv80zpDXrNJRfHGUWfNMu9ZVhe5YtYePJ4A=;
 b=sD/jtWnypToIkKDniiGX18wjutd21NT8GKQ7IesTSSkInVW7jJPWpyc9QM54yeHiFA6R0M
 HZseP4jYl8sGWgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 764773EA63;
 Tue,  6 Jan 2026 08:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJANGljKXGlBPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Jan 2026 08:39:52 +0000
Date: Tue, 6 Jan 2026 09:39:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260106083947.GA687576@pevik>
References: <20251022020509.6945-1-wegao@suse.com>
 <20251224085004.10267-1-wegao@suse.com>
 <DFGO5L1W0DED.2G5VJDLYAJM7L@suse.com>
 <aVyrMIHYwxncN6J_@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aVyrMIHYwxncN6J_@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] io_submit04: Add test case for RWF_NOWAIT flag
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

SGkgYWxsLAoKLi4uCj4gPiA+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPiA+ID4gK3sKPiA+ID4g
KwlzdHJ1Y3QgaW9fZXZlbnQgZXZidWY7Cj4gPiA+ICsJc3RydWN0IHRpbWVzcGVjIHRpbWVvdXQg
PSB7IC50dl9zZWMgPSAxIH07Cj4gPiA+ICsJbG9uZyBuciA9IDE7Cj4gPiA+ICsKPiA+ID4gKwlU
RVNUKHRzdF9zeXNjYWxsKF9fTlJfaW9fc3VibWl0LCBjdHgsIG5yLCBpb2NicykpOwo+ID4gPiAr
Cj4gPiA+ICsJaWYgKFRTVF9SRVQgPT0gbnIpCj4gPiA+ICsJCXRzdF9yZXMoVFBBU1MsICJpb19z
dWJtaXQoKSBwYXNzIik7Cj4gPiA+ICsJZWxzZQo+ID4gPiArCQl0c3RfcmVzKFRGQUlMIHwgVFRF
UlJOTywgImlvX3N1Ym1pdCgpIHJldHVybnMgJWxkLCBleHBlY3RlZCAlbGQiLCBUU1RfUkVULCBu
cik7Cgo+ID4gT3VyIGdvYWwgaXMgdG8gdmVyaWZ5IHRoYXQgaW9fZ2V0ZXZlbnRzKCkgcmV0dXJu
cyBFQUdBSU4sIHNvIHdlIGNhbiBqdXN0OgoKPiA+IGlmIChUU1RfUkVUICE9IG5yKSB7Cj4gPiAJ
dHN0X3JlcyhUQlJPSyB8IFRURVJSTk8sICJpb19zdWJtaXQoKSByZXR1cm5zICVsZCwgZXhwZWN0
ZWQgJWxkIiwgVFNUX1JFVCwgbnIpOwo+ID4gCXJldHVybjsKPiA+IH0KCj4gPiBXZSByZXR1cm4g
YmVjYXVzZSBpZiBpb19zdWJtaXQoKSBmYWlscyB0aGVyZSdzIG5vdGhpbmcgdG8gZG8gbW9yZS4K
PiB0c3RfcmVzKFRCUk9LIHdpbGwgdHJpZ2dlciBlcnJvciBzdWNoIGFzIDoKPiBtYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvd2VnYW8vbHRwL2xpYicKPiBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfdGVzdC5oOjIwLAo+ICAgICAgICAgICAgICAg
ICAgZnJvbSBpb19zdWJtaXQwNC5jOjE0Ogo+IGlvX3N1Ym1pdDA0LmM6IEluIGZ1bmN0aW9uIOKA
mHJ1buKAmToKPiAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF9jb21tb24uaDo4MDozMjogZXJyb3I6
IHNpemUgb2YgdW5uYW1lZCBhcnJheSBpcyBuZWdhdGl2ZQo+ICAgIDgwIHwgICAgICAgICBkbyB7
ICgodm9pZClzaXplb2YoY2hhclsxIC0gMiAqICEhKGNvbmRpdGlvbildKSk7IH0gd2hpbGUgKDAp
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+IC4uLy4uLy4uLy4u
L2luY2x1ZGUvdHN0X2NvbW1vbi5oOjgzOjk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDi
gJhUU1RfQlVJTERfQlVHX09O4oCZCj4gICAgODMgfCAgICAgICAgIFRTVF9CVUlMRF9CVUdfT04o
Y29uZGl0aW9uKQo+ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+Cj4gLi4vLi4vLi4v
Li4vaW5jbHVkZS90c3RfdGVzdC5oOjcxOjE3OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g
4oCYVFNUX1JFU19TVVBQT1JUU19UQ09ORl9UREVCVUdfVEZBSUxfVElORk9fVFBBU1NfVFdBUk7i
gJkKPiAgICA3MSB8ICAgICAgICAgICAgICAgICBUU1RfUkVTX1NVUFBPUlRTX1RDT05GX1RERUJV
R19URkFJTF9USU5GT19UUEFTU19UV0FSTihcCj4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiBpb19z
dWJtaXQwNC5jOjYzOjE3OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYdHN0X3Jlc+KA
mQo+ICAgIDYzIHwgICAgICAgICAgICAgICAgIHRzdF9yZXMoVEJST0sgfCBUVEVSUk5PLCAiaW9f
c3VibWl0KCkgcmV0dXJucyAlbGQsIGV4cGVjdGVkICVsZCIsCj4gICAgICAgfCAgICAgICAgICAg
ICAgICAgXn5+fn5+fgo+IG1ha2U6ICoqKiBbLi4vLi4vLi4vLi4vaW5jbHVkZS9tay9ydWxlcy5t
azo0ODogaW9fc3VibWl0MDRdIEVycm9yIDEKPiAtYmFzaDogLi9pb19zdWJtaXQwNDogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeQoKPiBTbyBpIHN1cHBvc2Ugd2UgbmVlZCB1c2UgInRzdF9icmso
VEJST0siIHdpdGhvdXQgcmV0dXJuLCBjb3JyZWN0PwoKWWVzLCB0aGF0J3MgYSBtYWNybyB3aGlj
aCBlbmZvcmNlcyB1c2luZyBUQlJPSyBvbmx5IHdpdGggdHN0X2JyaygpLgoKQEN5cmlsIEBMaSBA
SmFuIEkgd29uZGVyIGlmIHdlIHN0aWxsIG5lZWQgdGhpcyBlbmZvcmNlbWVudCBhZnRlciBDeXJp
bCdzIGNoYW5nZQphMWY4MjcwNGMyICgibGliL3RzdF90ZXN0LmM6IEZpeCB0c3RfYnJrKCkgaGFu
ZGxpbmciKQoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
