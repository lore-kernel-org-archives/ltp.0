Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC9C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 17:30:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40AD53CB1B8
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 19:30:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29B803C1769
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 19:30:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 838E114004E8
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 19:30:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEFBD22BA8;
 Thu, 20 Oct 2022 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666287039;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXM/YFKBMUTUJEdWT8lGFAGYYQEiLZeJIRPP7vJXy3Q=;
 b=SWlnzIsdZh548NRp8KOBeeruk/a+Ri7vF2zTcgS1U+NVq3yXknr/P119SdS6DJAava2RcN
 eNAqbiDLXWUsbF3dqXFv4EkDWgY8M9gdoh18CFLn+CI0UnxFeePTR0eVturYN8fGeUD5VE
 lrJNfKZdPNfcc9BjR770+UTnisPQrek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666287039;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXM/YFKBMUTUJEdWT8lGFAGYYQEiLZeJIRPP7vJXy3Q=;
 b=TFiSMSwzrYDp6rLC8tPNOF+C62SEyowWN3Pn0T2zCu6BKydBvxOY30/T5pvqaB3sMavYL+
 x5SViq/2anA+ytAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DC6613AF5;
 Thu, 20 Oct 2022 17:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aKAlGL+FUWMLQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Oct 2022 17:30:39 +0000
Date: Thu, 20 Oct 2022 19:30:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <Y1GFvU/ixieqDSq6@pevik>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221020133715.256521-1-akihiko.odaki@daynix.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKCj4gbmV0d29yay90Y3BfY21kcy90cmFjZXBhdGgvdHJhY2VwYXRoMDEuc2ggZmFp
bHMgd2l0aCBMQU5HPWphX0pQLlVURi04Cj4gYmVjYXVzZSBpdCBwYXJzZXMgbG9jYWxpemVkIG91
dHB1dC4gVGhlIGJlbG93IGlzIGFuIGV4YW1wbGUgb2Ygc3VjaAo+IG91dHB1dDoKPiAkIHRyYWNl
cGF0aCBsb2NhbGhvc3QKPiAgMT86IFtMT0NBTEhPU1RdICAgICAgICAgICAgICAgICAgICAgICAg
MC4wNDDjg5/jg6rnp5IgcG10dSA2NTUzNgo+ICAxOiAgbG9jYWxob3N0ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4yNzTjg5/jg6rnp5Ig5Yiw6YGU44GX44G+
44GX44GfCj4gIDE6ICBsb2NhbGhvc3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAwLjI2MeODn+ODquenkiDliLDpgZTjgZfjgb7jgZfjgZ8KPiAgICAgIOimgee0
hDogcG10dSA2NTUzNiDjg5vjg4Pjg5fmlbAgMSDmiLvjgorjg5vjg4Pjg5fmlbAgMQoKPiBJdCBp
cyBuZWNlc3NhcnkgdG8gbm9ybWFsaXplIHRoZSBsb2NhbGUgdG8gYXZvaWQgc3VjaCBhIHByb2Js
ZW0uCj4gVGhlcmUgYXJlIHNvbWUgdGVzdHMgZG8gdGhlIG5vcm1hbGl6YXRpb24sIGJ1dCB0aGF0
IGlzIG5vdAo+IGNvbXByZWhlbnNpdmUuIEFkZCBjb2RlIHRvIG5vcm1hbGl6ZSB0aGUgbG9jYWxl
IHRvIHRzdF90ZXN0LnNoIHNvCj4gdGhhdCBpdCBjYW4gY292ZXIgbW9yZSB0ZXN0cy4KCj4gVGhl
IGFkZGVkIGNvZGUgZG9lcyB0aGUgbm9ybWFsaXphdGlvbiBieSBzZXR0aW5nIExDX0FMTCwgd2hp
Y2gKPiB0YWtlcyBwcmVjZWRlbmNlIHRvIHRoZSBvdGhlciBsb2NhbGUtcmVsYXRlZCBlbnZpcm9u
bWVudCB2YXJpYWJsZXMKPiBhbmQgZG9lcyBub3QgcmVxdWlyZSB0aGF0ICJsb2NhbGUiIGNvbW1h
bmQgZXhpc3RzLgoKPiBTaWduZWQtb2ZmLWJ5OiBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtp
QGRheW5peC5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2ggfCAyICsrCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9saWIvdHN0X3Rlc3Quc2ggYi90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCj4gaW5kZXggMjhi
N2QxMmJhLi41ZWJiZTFkMjUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5z
aAo+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gKPiBAQCAtODMxLDMgKzgzMSw1IEBA
IGlmIFsgLXogIiRUU1RfTk9fREVGQVVMVF9SVU4iIF07IHRoZW4KPiAgCQlmaQo+ICAJZmkKPiAg
ZmkKPiArCj4gK2V4cG9ydCBMQ19BTEw9QwoKVGhpbmtpbmcgYWJvdXQgaXQgdHdpY2UgdGhpcyBt
aWdodCBoYXZlIGltcGFjdCBvbiBvdGhlciB0ZXN0cy4KTGksIEN5cmlsLCBhbnkgaWRlYSBhYm91
dCBpdD8KCk90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBwdXQgdGhpcyBjaGFuZ2UganVzdCB0byB0
cmFjZXBhdGgwMS5zaC4KQW5kIGlmIHdlIHdhbnQgdG8gdGVzdCBqdXN0IEMgbG9jYWxlIChJJ20g
cmVhbGx5IG5vdCBzdXJlLCBzaG91bGRuJ3QKaXQgYmUgYWxzbyBpbiBDIEFQST8KCktpbmQgcmVn
YXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
