Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA183CEBF9B
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:39:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60C9F3C527B
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 13:39:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 178033C25C6
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 13:39:21 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 659971400C62
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 13:39:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0059021A0F;
 Fri, 27 Sep 2024 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727437160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siyLh4Z3gpfALYBHUJzH88CfEP3QWIkiKvRsA4Wc3Vw=;
 b=E56o6oKGfDyYkW6iBzQNaxOPYGJgh/AbNTCnRh08sOU8IgYp7XDKoekCROorVKdAMh04qA
 KXbTYkH7i9aDqDVRS0A0w0m23ni4RIuEy4DYzbc0kOzTXYv01nyzIMWDXjkbXZWYmqGgpZ
 l0LIwVU3kHM05yE1/OE82/o4/rJvJp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727437160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siyLh4Z3gpfALYBHUJzH88CfEP3QWIkiKvRsA4Wc3Vw=;
 b=khmksDXyyYp7Bxgkn5qd0IKpzz/ixRe59St7jXkFg0HpW3g+Yq8S4W9o0YtjVFk895CTQr
 T7Cumsocj9XQUVAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727437159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siyLh4Z3gpfALYBHUJzH88CfEP3QWIkiKvRsA4Wc3Vw=;
 b=lbIgjspULzDx7fBndH47gg2SS/zAe3QW403TiLXF8nSdGMM9BFhGZN5CXzxEIrc9BsQjDC
 AFb9xHvHNj0wXZyeOX5ddbaxZMA6QD6rv/34tQJ8EqwczIicMU4pPznyhTc8opm+FR+D0k
 KmqcpM+b66sJ7NVSqOL5o2zMomfQo/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727437159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siyLh4Z3gpfALYBHUJzH88CfEP3QWIkiKvRsA4Wc3Vw=;
 b=opW8/8bctIjeRMUDjnbUnAWXExg5r4+eCNL/Wk9Ca+OfMdSRHaAcx73c9xuxffwD5WshLt
 0zWESEzzgAXRfbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E930913A73;
 Fri, 27 Sep 2024 11:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f40+OGaZ9mYNcAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 27 Sep 2024 11:39:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Sep 2024 13:39:18 +0200
Message-ID: <2748318.lGaqSPkdTl@localhost>
In-Reply-To: <20240927101813.12643-1-chrubis@suse.cz>
References: <20240927101813.12643-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include: Better documentation for TFAIL and TBROK\
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpPbiBGcmlkYXksIFNlcHRlbWJlciAyNywgMjAyNCAxMjoxODoxM+KAr1BNIEdN
VCsyIEN5cmlsIEhydWJpcyB3cm90ZToKPiBGaXhlczogIzExNjIKPiAKPiBTaWduZWQtb2ZmLWJ5
OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KClJldmlld2VkLWJ5OiBBdmluZXNoIEt1
bWFyIDxha3VtYXJAc3VzZS5kZT4KClRoYW5rIHlvdSwKQXZpbmVzaAoKPiAtLS0KPiAgaW5jbHVk
ZS90c3RfcmVzX2ZsYWdzLmggfCAyMyArKysrKysrKysrKysrKysrKysrLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS90c3RfcmVzX2ZsYWdzLmggYi9pbmNsdWRlL3RzdF9yZXNfZmxhZ3MuaAo+IGlu
ZGV4IDgwNjk0MGUwZC4uYTc5NDI4ZmEyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X3Jlc19m
bGFncy5oCj4gKysrIGIvaW5jbHVkZS90c3RfcmVzX2ZsYWdzLmgKPiBAQCAtOSwxMSArOSwyNiBA
QAo+ICAvKioKPiAgICogZW51bSB0c3RfcmVzX2ZsYWdzIC0gVGVzdCByZXN1bHQgcmVwb3J0aW5n
IGZsYWdzLgo+ICAgKgo+IC0gKiBAVFBBU1M6IFJlcG9ydHMgYSBzaW5nbGUgc3VjY2Vzcy4KPiAt
ICogQFRGQUlMOiBSZXBvcnRzIGEgc2luZ2xlIGZhaWx1cmUuCj4gLSAqIEBUQlJPSzogUmVwb3J0
cyBhIHNpbmdsZSBicmVha2FnZS4KPiArICogQFRQQVNTOiBSZXBvcnRzIGEgc2luZ2xlIHN1Y2Nl
c3MuIFN1Y2Nlc3NlcyBpbmNyZW1lbnQgcGFzc2VkIGNvdW50ZXIgYW5kCj4gKyAqICAgICAgICAg
c2hvdyB1cCBpbiB0aGUgdGVzdCByZXN1bHRzLgo+ICsgKgo+ICsgKiBAVEZBSUw6IFJlcG9ydHMg
YSBzaW5nbGUgZmFpbHVyZS4gRmFpbHVyZXMgaW5jcmVtZW50IGZhaWx1cmUgY291bnRlciBhbmQK
PiArICogICAgICAgICBzaG93IHVwIGluIHRoZSB0ZXN0IHJlc3VsdHMuIEEgZmFpbHVyZSBvY2N1
cnMgd2hlbiB0ZXN0IGFzc2VydGlvbgo+ICsgKiAgICAgICAgIGlzIGJyb2tlbi4KPiArICoKPiAr
ICogQFRCUk9LOiBSZXBvcnRzIGEgc2luZ2xlIGJyZWFrYWdlLiBCcmVha2FnZXMgaW5jcmVtZW50
IGJyZWFrYWdlIGNvdW50ZXIgYW5kCj4gKyAqICAgICAgICAgc2hvdyB1cCBpbiB0aGUgdGVzdCBy
ZXN1bHRzLiBCcmVha2FnZXMgYXJlIHJlcG9ydGVkIGluIGNhc2VzIHdoZXJlIGEKPiArICogICAg
ICAgICB0ZXN0IGNvdWxkbid0IGJlIGV4ZWN1dGVkIGR1ZSB0byBhbiB1bmV4cGVjdGVkIGZhaWx1
cmUgd2hlbiB3ZSB3ZXJlCj4gKyAqICAgICAgICAgc2V0dGluZyB0aGUgdGVzdCBlbnZpcm9ubWVu
dC4gVGhlIFRCUk9LIHN0YXR1cyBpcyBtb3N0bHkgdXNlZAo+ICsgKiAgICAgICAgIHdpdGggdHN0
X2JyaygpIHdoaWNoIGV4aXQgdGhlIHRlc3QgaW1tZWRpYXRlbGx5LiBUaGUgZGlmZmVyZW5jZQpz
L2ltbWVkaWF0ZWxseS9pbW1lZGlhdGVseSAKCj4gKyAqICAgICAgICAgYmV0d2VlbiBUQlJPSyBh
bmQgVENPTkYgaXMgdGhhdCBUQ09ORiBpcyB1c2VkIGluIGNhc2VzIHdoZXJlCj4gKyAqICAgICAg
ICAgb3B0aW9uYWwgZnVuY3Rpb25hbGl0eSBpcyBtaXNzaW5nIHdoaWxlIFRCUk9LIGlzIHVzZWQg
aW4gY2FzZXMgd2hlcmUKPiArICogICAgICAgICBzb21ldGhpbmcgdGhhdCBpcyBzdXBwb3NlZCB0
byB3b3JrIGlzIGJyb2tlbiB1bmV4cGVjdGVkbHkuCj4gKyAqCj4gICAqIEBUV0FSTjogUmVwb3J0
cyBhIHNpbmdsZSB3YXJuaW5nLiBXYXJuaW5ncyBpbmNyZW1lbnQgYSB3YXJuaW5nIGNvdW50ZXIg
YW5kCj4gLSAqICAgICAgICAgc2hvdyB1cCBpbiB0ZXN0IHJlc3VsdHMuCj4gKyAqICAgICAgICAg
c2hvdyB1cCBpbiB0ZXN0IHJlc3VsdHMuIFdhcm5pbmdzIGFyZSBzb21ld2hlcmUgaW4gdGhlIG1p
ZGRsZSBiZXR3ZWVuCj4gKyAqICAgICAgICAgVEJST0sgYW5kIFRDT05GLiBXYXJuaW5ncyB1c3Vh
bGx5IGFwcGVhciB3aGVuIHNvbWV0aGluZyB0aGF0IGlzCj4gKyAqICAgICAgICAgc3VwcG9zZWQg
dG8gYmUgd29ya2luZyBpcyBicm9rZW4gYnV0IHRoZSB0ZXN0IGNhbiBzb21laG93IGNvbnRpbnVl
Lgo+ICAgKgo+ICAgKiBAVERFQlVHOiBQcmludHMgYWRkaXRpb25hbCBkZWJ1Z2dpbmcgbWVzc2Fn
ZXMsIGl0IGRvZXMgbm90IGNoYW5nZSB0aGUgdGVzdCByZXN1bHQgY291bnRlcnMgYW5kCj4gICAq
ICAgICAgICAgIHRoZSBtZXNzYWdlIGlzIG5vdCBkaXNwbGF5ZWQgdW5sZXNzIGRlYnVnZ2luZyBp
cyBlbmFibGVkIHdpdGggLUQKPiAKCgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
