Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C145C54E67
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 10:42:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C945B3C1B5E
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 11:42:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 750F03C1924
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 11:42:40 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0639D1B61063
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 11:42:39 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C702219A8;
 Thu, 28 Mar 2024 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711622553;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8Q9gzAoj/dcMaUgnr2y9w+Ff+u2bswQhY3LRmJuUAQ=;
 b=MeVEn4shlXzZoDqWYO+wopLSc3pSDEP4/xz+NMGmWL28IWodwTHTQWPjTN46TZzUV83pIh
 +3KYiwmmpJGD4ydXCjTqIopBdnXYes76gJjDWcIluA3ordNiTSwoGPSDhdSopggf222Qa6
 0QwCj8dPDtBqyZwW6W6hWqYnK+eJ4zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711622553;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8Q9gzAoj/dcMaUgnr2y9w+Ff+u2bswQhY3LRmJuUAQ=;
 b=fY0P4HUclsYlgUVUtam2WgSfzzOZpTIA49r63c53uORNKo2geuFrXb47sa/Pb83YqT6vFn
 fkbS1oqpVo/6r1Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711622552;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8Q9gzAoj/dcMaUgnr2y9w+Ff+u2bswQhY3LRmJuUAQ=;
 b=sqzLaeNkuNso0/ljZXCjwnxMC1JBt6u6vo8ui19wqoM+NmZLbEh+kOiOCUh85qKMcg8XrM
 ZSQWR0XVykmH8661SRxDrYgwsGcDOZZJ2N1lRLHzPPfNzC/egcOR0uelfbnpKBuZNt3tSr
 nAetNoEM9sJylHxVQzN4bCQZ8KLuTE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711622552;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8Q9gzAoj/dcMaUgnr2y9w+Ff+u2bswQhY3LRmJuUAQ=;
 b=JS4BfW9ryr00YGLRX9OwD4+djVCAjY3RRk3ldYmfVoOY6l49J9JFrbaCrMqGPnbBD+A42r
 h5wZmUQDJT1lmhCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 549AA13AB3;
 Thu, 28 Mar 2024 10:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 8bUJEphJBWaaCQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 10:42:32 +0000
Date: Thu, 28 Mar 2024 11:42:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kogure =?utf-8?B?QWtpaGlzYeOAgCgg5bCP5pqu44CA5piO5LmFICk=?=
 <akihisa.kogure.ke@kyocera.jp>
Message-ID: <20240328104226.GA51940@pevik>
References: <TYAPR01MB6044D2E0749663D84DE1F395D9352@TYAPR01MB6044.jpnprd01.prod.outlook.com>
 <ZgLaddvHSGVBhnU1@rei> <ZgLdmj2fx0PQzHgO@rei>
 <OS0PR01MB6033D024FBB112A98DC3104AD9342@OS0PR01MB6033.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6033D024FBB112A98DC3104AD9342@OS0PR01MB6033.jpnprd01.prod.outlook.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sqzLaeNk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JS4BfW9r
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[25.42%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8C702219A8
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] input_helper: Modify the check range of the input
 event number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgo+IElmIHRoZSBpbnB1dCBldmVudCBudW1iZXIgaXMgZ3JlYXRlciB0aGFuIDMyLCB0aGUg
bmV3bHkgYWRkZWQgZXZlbnQgSUQKPiB3aWxsIGJlIDI1NiBvciBsYXRlci4KPiBXaGVuIHRoZXJl
IHdlcmUgYWxyZWFkeSAzMiBpbnB1dCBldmVudHMgaW4gdGhlIGRldmljZSwgdGhpcyB0ZXN0IHBy
b2dyYW0KPiBvbmx5IGNoZWNrZWQgMH45OSwgc28gaXQgZmFpbGVkIGJlY2F1c2UgaXQgY291bGQg
bm90IGZpbmQgYSBuZXcgaW5wdXQKPiBldmVudCBJRC4KCj4gSW4gb3JkZXIgdG8gZWxpbWluYXRl
IHRoaXMgZmFpbHVyZSwgd2UgY2hhbmdlZCB0aGUgZXZlbnQgSUQgcmFuZ2UgdG8gYmUKPiBjaGVj
a2VkIGJ5IHRoaXMgdGVzdCBwcm9ncmFtIHRvIDB+MTAyMy4KPiAoaHR0cHM6Ly9naXRodWIuY29t
L3RvcnZhbGRzL2xpbnV4L2NvbW1pdC83ZjhkNGNhZDFlNGUxMWE0NWQwMmJkNmUwMjRjYzI4MTI5
NjNjMzhhLCBpdCBsb29rcyBsaWtlIHRoZSB1cHBlciBsaW1pdCBzaG91bGQgYmUgMTAyMy4pCgpG
b3IgMTAyNDoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgpJZGVhbGx5
IHlvdSB3b3VsZCBzZW5kIHYyLCBidXQgd2UgY2FuIGFsc28gdXBkYXRlIHRoZSBjb21taXQgbWVz
c2FnZSBhbmQgY29kZQpiZWZvcmUgbWVyZ2UuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gLS0tCgo+
IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2hlbHBlci5jIGIvdGVz
dGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYwo+IGluZGV4IDA5NTMwZmIuLjZiNjBk
MTcgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9oZWxwZXIuYwo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfaGVscGVyLmMKPiBAQCAtNDAsNyAr
NDAsNyBAQAo+ICDigILigILigILigILigIJpbnQgcmV0LCBmZCA9IC0xOwo+ICDigILigILigILi
gILigIJ1bnNpZ25lZCBpbnQgaTsKCj4gLeKAguKAguKAguKAguKAgmZvciAoaSA9IDA7IGkgPCAx
MDA7IGkrKykgewo+ICvigILigILigILigILigIJmb3IgKGkgPSAwOyBpIDwgMTAyNDsgaSsrKSB7
Cj4gIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnNucHJpbnRmKHBhdGgsIHNpemVv
ZihwYXRoKSwgIi9kZXYvaW5wdXQvZXZlbnQlaSIsIGkpOwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
