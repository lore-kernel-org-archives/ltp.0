Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E63FCF6BF2
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 07:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3343C2E00
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 08:54:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B81A13C2CC4
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 08:54:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34F3C600745
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 08:54:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0B2F33AE6;
 Wed,  7 Jan 2026 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767772440;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok+OzrHB8ozQGokcpk0OLCYbHCAxJw40niUAY6OATG4=;
 b=xXqeQw0IsORoO1WBOr1JtYZShuXHgxvm3aWyL9TIQAWFpx17Pq2D/APMoyJTbGY6h5GjN8
 Oqa/QYoRAsOxUvTWr3TKbbIQuYALpPvNGQBZQgimiAEe7AxoZHYz1TdYipgj5LIhmd3JDY
 5xCBGJsUcfF/E0CKJ34Hrd4rzKUOG90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767772440;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok+OzrHB8ozQGokcpk0OLCYbHCAxJw40niUAY6OATG4=;
 b=qd7PSWF95OVwrtRK2G/wKgufmf0nyDI64JO+bkTbuS0W9gF6/VADZ96tjfgfbjfj+/KNYu
 dKH4MZPbOAPevHBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767772439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok+OzrHB8ozQGokcpk0OLCYbHCAxJw40niUAY6OATG4=;
 b=j/wO9jBMHTKRgBI4597TvxOx4Clmfvv8xLNYSVojJ/QMUNMZ2/lBF4CNeNNSBCtENTlPES
 I+8FYjdzjz+x2dDRW20E+fhv/X6SYnFjI/SJq3ZyImW5wV9MV7hkDEgz+umWsGFcLKVkPu
 EMm8Uk52gCmugcAmDUAxhc6wCpUEX1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767772439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok+OzrHB8ozQGokcpk0OLCYbHCAxJw40niUAY6OATG4=;
 b=Fov6U+JSc8LB//K21Yfaied78s2GJf0dhwlZLkLfob4mhJE70U1r6SWCmOl0U88CuO5g/6
 CaT+RZtwjXfSiGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D20A43EA63;
 Wed,  7 Jan 2026 07:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9pO9MRcRXmn2PQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 07:53:59 +0000
Date: Wed, 7 Jan 2026 08:53:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260107075354.GB727950@pevik>
References: <20251222094428.87910-1-pvorel@suse.cz>
 <DFGGXHDQ8OSM.36FM2U880AQKZ@suse.com>
 <20260105074908.GA589722@pevik>
 <DFHHL0ST0J9B.VIZCKRYAK2TN@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFHHL0ST0J9B.VIZCKRYAK2TN@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] swapon03: Try to swapon() as many files until
 it fails
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

SGkgYWxsLAoKPiA+ID4gPiAtCWNoYXIgY21kX2J1ZmZlclsyNTZdOwo+ID4gPiA+ICsJY2hhciBj
bWRfYnVmZmVyW0ZJTEVOQU1FX01BWCsyOF07Cgo+ID4gPiBJJ20gbm90IHN1cmUgaWYgKzI4IGlz
IG5lZWRlZC4KCj4gPiBJIGRlc2NyaWJlZCB0aGUgcmVhc29uIGluIHRoZSBjb21taXQgbWVzc2Fn
ZToKCj4gPiAJSXQgd2FzIHJlcXVpcmVkIHRvIGluY3JlYXNlIGNtZF9idWZmZXIgc2l6ZSB0byBh
dm9pZCBkaXJlY3RpdmUgb3V0cHV0Cj4gPiAgICAgbWF5IGJlIHRydW5jYXRlZCB3YXJuaW5nLgoK
PiA+IEkgZ2V0IHdhcm5pbmcgb24gc21hbGxlciBzaXplOgoKPiA+IHN3YXBvbjAzLmM6NzQ6NjA6
IHdhcm5pbmc6IOKAmCVz4oCZIGRpcmVjdGl2ZSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCB3cml0
aW5nIHVwIHRvIDQwOTUgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDQwODcgWy1XZm9ybWF0
LXRydW5jYXRpb249XQo+ID4gICAgNzQgfCAgICAgICAgIHNucHJpbnRmKGNtZF9idWZmZXIsIHNp
emVvZihjbWRfYnVmZmVyKSwgImdyZXAgLXEgJyVzLipmaWxlJyAvcHJvYy9zd2FwcyIsIGZpbGVu
YW1lKTsKPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefgo+ID4gLi4uLi4uCj4gPiAgICA5NCB8ICAgICAgICAgICAg
ICAgICBjaGVja19hbmRfc3dhcG9mZihmaWxlbmFtZSk7Cj4gPiAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fgo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IC91c3IvaW5jbHVkZS9zdGRpby5oOjk3MCwKPiA+ICAgICAgICAgICAgICAgICAgZnJvbSBzd2Fw
b24wMy5jOjE3Ogo+ID4gSW4gZnVuY3Rpb24g4oCYc25wcmludGbigJksCj4gPiAgICAgaW5saW5l
ZCBmcm9tIOKAmGNoZWNrX2FuZF9zd2Fwb2Zm4oCZIGF0IHN3YXBvbjAzLmM6NzQ6MiwKPiA+ICAg
ICBpbmxpbmVkIGZyb20g4oCYY2xlYW5fc3dhcOKAmSBhdCBzd2Fwb24wMy5jOjk0OjM6Cj4gPiAv
dXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9iaXRzL3N0ZGlvMi5oOjY4OjEwOiBub3RlOiDi
gJhfX2J1aWx0aW5fX19zbnByaW50Zl9jaGvigJkgb3V0cHV0IGJldHdlZW4gMjkgYW5kIDQxMjQg
Ynl0ZXMgaW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgNDA5Ngo+ID4gICAgNjggfCAgIHJldHVy
biBfX2J1aWx0aW5fX19zbnByaW50Zl9jaGsgKF9fcywgX19uLCBfX1VTRV9GT1JUSUZZX0xFVkVM
IC0gMSwKPiA+ICAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgICA2OSB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgX19nbGliY19vYmpzaXplIChfX3MpLCBfX2ZtdCwKPiA+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgo+ID4gICAgNzAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fdmFfYXJnX3BhY2sgKCkpOwoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gU29y
cnksIEkgbWlzc2VkIHRoZSBnaXQgY29tbWVudC4gQ2FuIHlvdSBhbHNvIGNvbW1lbnQgdGhlIHNv
dXJjZSBjb2RlCj4gcGxlYXNlPyBTbyB3ZSBkb24ndCBndWVzcyB3aGF0J3MgZ29pbmcgb24gaW4g
dGhlIGJ1ZmZlciwgYmFzZWQgb24KPiBnaXQgbWVzc2FnZS4KCkZZSSBtZXJnZWQgd2l0aCBqdXN0
IGFkZGVkIEZJTEVOQU1FX01BWCsyOCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gYmUgbW9yZQpv
YnZpb3VzLiAgV2l0aCByZWNlbnQgZ2NjIHdlIGNhbiBoYXZlIG1hbnkgZml4ZXMgbGlrZSB0aGlz
LCBJJ20gbm90IHN1cmUgaWYgd2UKd2FudCB0byBjb21tZW50IGV2ZXJ5IC1XZm9ybWF0LXRydW5j
YXRpb24gaW4gdGhlIHNvdXJjZSBjb2RlLgoKVGhhbmtzIHRvIGFsbCBmb3IgYSByZXZpZXcuCkkn
bGwgcGxhbiB0byBkbyB0aGUgcmVzdCBvZiB0aGUgdGVzdCBjbGVhbnVwIGFzIHdlIGFncmVlZC4K
CktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
