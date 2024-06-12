Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D8AC27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 08:44:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A3AC3D0BC4
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 10:44:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1BBA3D0B7A
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 10:44:02 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8183C2081B7
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 10:44:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70EAB5BE3F;
 Wed, 12 Jun 2024 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718181840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6DDw35NcnL2bbBzMhHW5zOO+qYnkNpvZ/zABKhk0Ww=;
 b=UPBtodCKGvtNatnFJqquhTCWWcE8eNYNDE+lOaVwDCD0p6oiYv8fKcdxrZvLnGH/L90upB
 ujfX8fFRHlW0v/grBIz6H8DntvSdwJROB3Mo2ddT5n4/hoM9NHk/RNs9OT87EhGt/y56VQ
 +y79NSVLtn6WT/Vdyl55ic6mHKnYCaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718181840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6DDw35NcnL2bbBzMhHW5zOO+qYnkNpvZ/zABKhk0Ww=;
 b=j0MinhMpIkpIbAqAIXgNTNfdVOSVkj/xjT8ebUKXBnkNfbzGJJSnbp7Dn2a22iYhlpfV5z
 hzoSXBhp1IwN9ACw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UPBtodCK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j0MinhMp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718181840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6DDw35NcnL2bbBzMhHW5zOO+qYnkNpvZ/zABKhk0Ww=;
 b=UPBtodCKGvtNatnFJqquhTCWWcE8eNYNDE+lOaVwDCD0p6oiYv8fKcdxrZvLnGH/L90upB
 ujfX8fFRHlW0v/grBIz6H8DntvSdwJROB3Mo2ddT5n4/hoM9NHk/RNs9OT87EhGt/y56VQ
 +y79NSVLtn6WT/Vdyl55ic6mHKnYCaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718181840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6DDw35NcnL2bbBzMhHW5zOO+qYnkNpvZ/zABKhk0Ww=;
 b=j0MinhMpIkpIbAqAIXgNTNfdVOSVkj/xjT8ebUKXBnkNfbzGJJSnbp7Dn2a22iYhlpfV5z
 hzoSXBhp1IwN9ACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C4C2137DF;
 Wed, 12 Jun 2024 08:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H95dFdBfaWYnYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Jun 2024 08:44:00 +0000
Date: Wed, 12 Jun 2024 10:43:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: =?utf-8?B?5b6Q6aOe6aOeKFN0ZXZlKQ==?= <xufeifei1@oppo.com>
Message-ID: <ZmlfwIKXQsuBvfjq@yuki>
References: <20240611034058.12611-1-xufeifei1@oppo.com>
 <20240611034058.12611-2-xufeifei1@oppo.com> <Zmg3veXx0s0b5B4H@yuki>
 <SEZPR02MB70372C81C17D62159C21742D89C02@SEZPR02MB7037.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SEZPR02MB70372C81C17D62159C21742D89C02@SEZPR02MB7037.apcprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 70EAB5BE3F
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?562U5aSNOiAgW1BBVENIXSBSZWR1Y2UgbG9vcCBjb3VudCB0?=
 =?utf-8?q?o_meet_need_of_low_performance_terminals?=
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

SGkhCj4gQXJlIHlvdSBzdXJlIHRoYXQgeW91ciBrZXJuZWwgaXNuJ3QgYWZmZWN0ZWQgYnkgdGhl
IGJ1ZyB0aGUgdGVzdCBjaGVja3MgZm9yPyBUaGUgdGVzdCB0aW1lb3V0cyBvbiBhIGJ1Z2d5IGtl
cm5lbC4KPiAtLSBJcyB0aGVyZSBhbnkgcGxhY2Ugd2hlcmUgSSBjYW4gc2VlIG1vcmUgcmVsZXZh
bnQgaW5mb3JtYXRpb24/IHdoaWNoIGtpbmQgb2YgYnVnIHlvdSBoYXZlIGZvdW5kPwoKSXQncyBy
aWdodCBpbiB0aGUgdG9wIGxldmVsIGNvbW1lbnQgaW4gdGhlIHRlc3RjYXNlIHNvdXJjZSB3aGVy
ZSB0aGUKdGVzdCBkZXNjcmlwdGlvbiBpcy4KCj4gdGhlIHRlc3QgdGltZW91dCBvbiBteXNpZGUg
d2hlcmUgdGhlcmUgc3RpbGwgNjQwMDAwIGxvb3AsCj4gWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMg
d2hpbGUgNjQ2NTMzIHRpbWVzIGxvb3AgPSA2NDY1MzMgLS0tLS0tLQo+IFpaTCBwaWQgPSAyOTQ2
NiB0aGlzIGlzIHdoaWxlIDY0NjUzMiB0aW1lcyBsb29wID0gNjQ2NTMyIC0tLS0tLS0KPiBaWkwg
cGlkID0gMjk0NjYgdGhpcyBpcyB3aGlsZSA2NDY1MzEgdGltZXMgbG9vcCA9IDY0NjUzMSAtLS0t
LS0tCj4gWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTMwIHRpbWVzIGxvb3AgPSA2
NDY1MzAgLS0tLS0tLQo+IFpaTCBwaWQgPSAyOTQ2NiB0aGlzIGlzIHdoaWxlIDY0NjUyOSB0aW1l
cyBsb29wID0gNjQ2NTI5IC0tLS0tLS0KPiBaWkwgcGlkID0gMjk0NjYgdGhpcyBpcyB3aGlsZSA2
NDY1MjggdGltZXMgbG9vcCA9IDY0NjUyOCAtLS0tLS0tCj4gWlpMIHBpZCA9IDI5NDY2IHRoaXMg
aXMgd2hpbGUgNjQ2NTI3IHRpbWVzIGxvb3AgPSA2NDY1MjcgLS0tLS0tLQo+IFpaTCBwaWQgPSAy
OTQ2NiB0aGlzIGlzIHdoaWxlIDY0NjUyNiB0aW1lcyBsb29wID0gNjQ2NTI2IC0tLS0tLS0KPiBa
WkwgcGlkID0gMjk0NjYgdGhpcyBpcyB3aGlsZSA2NDY1MjUgdGltZXMgbG9vcCA9IDY0NjUyNSAt
LS0tLS0tCj4gWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTI0IHRpbWVzIGxvb3Ag
PSA2NDY1MjQgLS0tLS0tLQo+IFpaTCBwaWQgPSAyOTQ2NiB0aGlzIGlzIHdoaWxlIDY0NjUyMyB0
aW1lcyBsb29wID0gNjQ2NTIzIC0tLS0tLS0KPiBaWkwgcGlkID0gMjk0NjYgdGhpcyBpcyB3aGls
ZSA2NDY1MjIgdGltZXMgbG9vcCA9IDY0NjUyMiAtLS0tLS0tCj4gWlpMIHBpZCA9IDI5NDY2IHRo
aXMgaXMgd2hpbGUgNjQ2NTIxIHRpbWVzIGxvb3AgPSA2NDY1MjEgLS0tLS0tLQo+IFRlc3QgdGlt
ZW91dGVkLCBzZW5kaW5nIFNJR0tJTEwhCj4gZXh0ZXJuYWwvbHRwL2xpYi90c3RfdGVzdC5jOjE2
NDE6IFRJTkZPOiBLaWxsZWQgdGhlIGxlZnRvdmVyIGRlc2NlbmRhbnQgcHJvY2Vzc2VzCj4gZXh0
ZXJuYWwvbHRwL2xpYi90c3RfdGVzdC5jOjE2NDg6IFRJTkZPOiBJZiB5b3UgYXJlIHJ1bm5pbmcg
b24gc2xvdyBtYWNoaW5lLCB0cnkgZXhwb3J0aW5nIExUUF9USU1FT1VUX01VTCA+IDEKPiBleHRl
cm5hbC9sdHAvbGliL3RzdF90ZXN0LmM6MTY0OTogVEJST0s6IFRlc3Qga2lsbGVkISAodGltZW91
dD8pCj4gCj4gU3VtbWFyeToKPiBwYXNzZWQgICAxCj4gZmFpbGVkICAgMAo+IGJyb2tlbiAgIDEK
PiBza2lwcGVkICAwCj4gd2FybmluZ3MgMAo+IAo+IAo+IEhvdyBsb25nIGRvZXMgdGhlIHRlc3Qg
cnVuIGlmIHlvdSBkaXNhYmxlIHRpbWVvdXRzIChieSBzZXR0aW5nIHN0YXRpYyBpbnQgdGltZW91
dCA9IC0xIGluIHRoZSBzb3VyY2UpPwo+IC0tIGFib3V0IDM3MCBzZWNvbmRzCgpMb29raW5nIGF0
IHRoaXMgaXQgc2VlbXMgdGhhdCB5b3VyIENQVSBpcyBqdXN0IGEgYml0IHNsb3dlciwgaWYgdGhl
IHRlc3QKZmFpbHMgaXQncyBzdXBwb3NlZCB0byBiZSBhdCBsZWFzdCBvbmUgb3JkZXIgb2YgbWFn
bml0dWRlIHNsb3dlci4KCj4gQWxzbyB3aGF0IGtpbmQgb2Ygc3lzdGVtIGl0IGlzPyBIb3cgZmFz
dCBpcyB0aGUgQ1BVPwo+IC0tYW5kcm9pZCAxNCAsICBrZW5yZWwgNi4xLjQzLWFuZHJvaWQxNC0x
MS1vLWc5YmJmZTkwMDliODYgLAo+IAo+IGNhdCAvcHJvYy9jcHVpbmZvCj4gcHJvY2Vzc29yICAg
ICAgIDogMAo+IEJvZ29NSVBTICAgICAgICA6IDM4LjQwCj4gRmVhdHVyZXMgICAgICAgIDogZnAg
YXNpbWQgZXZ0c3RybSBhZXMgcG11bGwgc2hhMSBzaGEyIGNyYzMyIGF0b21pY3MgZnBocCBhc2lt
ZGhwIGNwdWlkIGFzaW1kcmRtIGxyY3BjIGRjcG9wIGFzaW1kZHAKPiBDUFUgaW1wbGVtZW50ZXIg
OiAweDQxCj4gQ1BVIGFyY2hpdGVjdHVyZTogOAo+IENQVSB2YXJpYW50ICAgICA6IDB4Mgo+IENQ
VSBwYXJ0ICAgICAgICA6IDB4ZDA1ICDvvIhBUk1fQ1BVX1BBUlRfQ09SVEVYX0E1NSkKPiBDUFUg
cmV2aXNpb24gICAgOiAwCgpTbyB0aGlzIGlzIHNpbmdsZSBjb3JlIEFSTSBjb3J0ZXggQTU1LCBp
dCByZWFsbHkgc2VlbXMgdG8gYmUganVzdCBhIGNhc2UKb2Ygc2xvd2VyIHByb2Nlc29yLCBzbyBp
dCBkb2VzIG1ha2Ugc2Vuc2UgdG8gbG93ZXIgdGhlIG51bWJlciBvZgppdGVyYXRpb25zIG9yIGlu
Y3JlYXNlIHRoZSB0ZXN0IHRpbWVvdXQuCgpIb3dldmVyIHRoZSBwcm9ibGVtIGlzIHRoYXQgaWYg
d2UgZGl2aWRlIHRoZSBkZWZhdWx0IG51bWJlciBvZgppdGVyYXRpb25zIGJ5IHR3byBhbmQga2Vl
cCB0aGUgdGltZW91dCB0aGUgdGVzdCB3b3VsZCBzdGlsIHBhc3MgZXZlbiBvbgpicm9rZW4ga2Vy
bmVsIG9uIGFuIHg4Nl82NCBkZXNrdG9wLiBTbyB3ZSBwcm9iYWJseSBuZWVkIGEgY2FsbGlicmF0
aW9uCmxvb3AgdGhhdCB3b3VsZCBiZSBhYmxlIHRvIGVzdGltYXRlIHRoZSBDUFUgc3BlZWQgdG8g
c2V0IHRoZQpleHBlY3RhdGlvbnMgcmlnaHQuCgotLSAKQ3lyaWwgSHJ1YmlzCmNocnViaXNAc3Vz
ZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
