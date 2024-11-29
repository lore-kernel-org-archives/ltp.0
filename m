Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D27D6EC04
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 12:10:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DAC93DC075
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 13:10:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FBD43D2D8B
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:10:01 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11E8420F5D3
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:10:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA90D21197;
 Fri, 29 Nov 2024 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732882200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2TcvSEg06Y3Lc1sCvverdqVSEkPyLwMMdgcOzSy0ck=;
 b=JYNZ/RFV8zt08TPnoKGm2BPNlKnFZDTH2Cc6ETk6CKXT0O2dxZ2wP6QtNhcYyg/pTrzWJP
 QQMD4TFJhz5ww21kqXvyRntvPE5lp5me4HzL68CNHoMTXluOM3rPu7C6PfHh38VS6TldzK
 X/s4pL3L4V/XQp1RTrVZ7hR+ov12PJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732882200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2TcvSEg06Y3Lc1sCvverdqVSEkPyLwMMdgcOzSy0ck=;
 b=loTVcNZ2t50jUL4Q3J0ZR4VivF1x7SF7AXq+lnwNNfpmS+ys2NqCJiQ291XsChFYYKVtso
 yEd8olinbwty/MAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zhsxutzh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZE2QsrR6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732882199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2TcvSEg06Y3Lc1sCvverdqVSEkPyLwMMdgcOzSy0ck=;
 b=Zhsxutzhv8tjWosYkPeLriu3fa6empl8RI28n5I5l8dK65tiDnxfFNVoWAUrdqaxSdenae
 zttHWTE6wBDe34UDTaCcldzzx2g47ugFUFHbTINRmj8ol2NvDHErAADX6bKar/Ygs96YFZ
 159k9zNaa8S+ivuTfKvu5eiA2R3CZNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732882199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2TcvSEg06Y3Lc1sCvverdqVSEkPyLwMMdgcOzSy0ck=;
 b=ZE2QsrR6pW+JuTPjiNDrUhCfufXiWo7fMU7jUCyPMIbguxOpDNqu4nQhDven/M2aa1PUuR
 DVhuk3m4eVujW7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B72BF133F3;
 Fri, 29 Nov 2024 12:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TkZ+KxevSWfKBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Nov 2024 12:09:59 +0000
Date: Fri, 29 Nov 2024 13:10:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Chunyu Hu <chuhu@redhat.com>
Message-ID: <Z0mvIOV2IZOXPTZQ@yuki.lan>
References: <20241119072817.415810-1-chuhu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241119072817.415810-1-chuhu@redhat.com>
X-Rspamd-Queue-Id: CA90D21197
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: build with O0
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

SGkhCj4gSGl0IGEgY29tcGlsZSBicm9rZW4gZm9yIHRoaXMgdGVzdCBpbiByaGVsMTAgZ2NjLTE0
LjIuMS02LmVsMTAueDg2XzY0Cj4gYW5kIGZpbmQgb25seSB3aXRoIE8wIGl0IGNvdWxkIGJlIGNv
bXBpbGVkIHBhc3MuCj4gCj4gQ0MgdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNC0wMTk2Cj4gY3ZlLTIw
MTUtMzI5MC5jOiBJbiBmdW5jdGlvbiDigJhjaGlsZF90aHJlYWTigJk6Cj4gY3ZlLTIwMTUtMzI5
MC5jOjQzNzoxOiBlcnJvcjogYnAgY2Fubm90IGJlIHVzZWQgaW4g4oCYYXNt4oCZIGhlcmUKPiAg
IDQzNyB8IH0KPiAgICAgICB8IF4KPiBtYWtlOiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvcnVsZXMu
bWs6NDU6IGN2ZS0yMDE1LTMyOTBdIEVycm9yIDEKCkV4YWN0bHkgdGhpcyBzaG91bGQgYmUgc29s
dmVkIGJ5IC1mb21pdC1mcmFtZS1wb2ludGVyLCBhdCBsZWFzdCB0aGF0IGhvdwp0aGUgcHJvYmxl
bSBpcyBmaXhlZCBmb3IgbW9zdCBvZiB0aGUgZ2NjIHJlbGVhc2VzLiBBbHNvIHRoZSBvcmlnaW5h
bApleHBsb2l0IGlzIHN1cHBvc2VkIHRvIGJlIGJ1aWxkIHdpdGggLU8yIHNvIEkgZG8gbm90IHRo
aW5rIHRoYXQgdGhpcyBpcwp0aGUgcmlnaHQgZml4LgoKPiBTaWduZWQtb2ZmLWJ5OiBDaHVueXUg
SHUgPGNodWh1QHJlZGhhdC5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9jdmUvTWFrZWZpbGUgfCAy
ICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvY3ZlL01ha2VmaWxlIGIvdGVzdGNhc2VzL2N2ZS9NYWtl
ZmlsZQo+IGluZGV4IDAxYjliOWNjYi4uMmE3NjlkZWE4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNl
cy9jdmUvTWFrZWZpbGUKPiArKysgYi90ZXN0Y2FzZXMvY3ZlL01ha2VmaWxlCj4gQEAgLTIyLDYg
KzIyLDYgQEAgaWZuZXEgKCwkKGZpbHRlciAkKEhPU1RfQ1BVKSx4ODYgeDg2XzY0KSkKPiAgbWVs
dGRvd246IENGTEFHUyArPSAtbXNzZTIKPiAgZW5kaWYKPiAgCj4gLWN2ZS0yMDE1LTMyOTA6CUNG
TEFHUyArPSAtcHRocmVhZCAtZm9taXQtZnJhbWUtcG9pbnRlcgo+ICtjdmUtMjAxNS0zMjkwOglD
RkxBR1MgKz0gLXB0aHJlYWQgLWZvbWl0LWZyYW1lLXBvaW50ZXIgLU8wCj4gIAo+ICBpbmNsdWRl
ICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFyZ2V0Lm1rCj4gLS0gCj4g
Mi40Ny4wCj4gCj4gCj4gLS0gCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCgotLSAKQ3lyaWwgSHJ1YmlzCmNocnViaXNAc3VzZS5jegoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
