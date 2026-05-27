Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6F9CD5BD0
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 19:46:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 815253CC87E
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 21:45:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 339E53C58E7
 for <ltp@lists.linux.it>; Wed, 27 May 2026 21:45:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8505600A02
 for <ltp@lists.linux.it>; Wed, 27 May 2026 21:45:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10D556A92A;
 Wed, 27 May 2026 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779911138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/mn0AZGFi4UhAeaj9YexARSBSQIP+z0keSbBgqHxS4=;
 b=XYnxXEWqD9sdhtucYoruhKnxFz4aKbP0+vJ8gFNDOcIJg1Y9iV06fN2cnRUysgNEFIXPlN
 IMYQ6ytwi0sYjWDzMr9VE1xXkrD6RaOrs/+lt3xwE8hISWg9BK57H2C0jRJJO4U5I/ym96
 9nWGeNVogPklBRrrkjiLid/TErd+a1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779911138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/mn0AZGFi4UhAeaj9YexARSBSQIP+z0keSbBgqHxS4=;
 b=mkLx+1R7IUEKebaYt23zlluqIPk21ekbuOY013c4iwkPGIkMq7ynVprxiEfQ3vJxYScE5/
 59vkfkdhdx/9IoBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XYnxXEWq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mkLx+1R7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779911138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/mn0AZGFi4UhAeaj9YexARSBSQIP+z0keSbBgqHxS4=;
 b=XYnxXEWqD9sdhtucYoruhKnxFz4aKbP0+vJ8gFNDOcIJg1Y9iV06fN2cnRUysgNEFIXPlN
 IMYQ6ytwi0sYjWDzMr9VE1xXkrD6RaOrs/+lt3xwE8hISWg9BK57H2C0jRJJO4U5I/ym96
 9nWGeNVogPklBRrrkjiLid/TErd+a1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779911138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/mn0AZGFi4UhAeaj9YexARSBSQIP+z0keSbBgqHxS4=;
 b=mkLx+1R7IUEKebaYt23zlluqIPk21ekbuOY013c4iwkPGIkMq7ynVprxiEfQ3vJxYScE5/
 59vkfkdhdx/9IoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D76145A9BF;
 Wed, 27 May 2026 19:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g1SyMuFJF2oWIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 May 2026 19:45:37 +0000
Date: Wed, 27 May 2026 21:45:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260527194536.GA253879@pevik>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
 <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
 <20260515144242.GB40164@pevik>
 <d1e90d8d94fd4cb58f34cbff4a07b49257195129.camel@intel.com>
 <21a5a4cec4cbb9a7084b8b5374fa06865a0d74d8.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21a5a4cec4cbb9a7084b8b5374fa06865a0d74d8.camel@intel.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 10D556A92A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGlvdHIsCgo+IFNpbmNlIHRoZXJlJ3Mgbm8gb3RoZXIgcmV2aWV3LCBpcyB2MjAgcmVhZHkg
dG8gbWVyZ2U/CgpJJ20gc29ycnkgaXQgd2lsbCBoYXZlIHRvIHdhaXQgYWZ0ZXIgdXBjb21pbmcg
TFRQIHJlbGVhc2UgKHdoaWNoIGlzIGdvaW5nIHRvIGJlCnRoaXMgRnJpZGF5KS4gSXQncyBzdGls
bCB3YWl0cyBmb3IgQ3lyaWwncyBmaW5hbCBsb29rLiBXZSd2ZSBiZWVuIGJ1c3kgd2l0aApmaXhp
bmcgZXhpc3RpbmcgdGVzdHMsIHRoYXQncyB3aHkgaGUgaGF2ZW4ndCBkb25lIGl0IHlldC4gVGhh
bmtzIGZvcgp1bmRlcnN0YW5kaW5nLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IDIwMjYtMDUtMTgg
KOaciCkg44GuIDA4OjExICswMDAwIOOBqyBLdWJhaiwgUGlvdHIg44GV44KT44Gv5pu444GN44G+
44GX44GfOgo+ID4gSSBzZXQgaXQgdG8gMzAwcywgYXMgcmVxdWVzdGVkLCBiZWNhdXNlIGF0dGVt
cHRzIHRvIHNldCBpdCB0byA2MHMgYW5kCj4gPiAxMjBzIGdhdmUgc29tZSBmYWlsdXJlcyB3aGVu
IHJ1bm5pbmcgd2l0aCAtaSAxMC4KCj4gPiAyMDI2LTA1LTE1ICjph5EpIOOBriAxNjo0MiArMDIw
MCDjgasgUGV0ciBWb3JlbCDjgZXjgpPjga/mm7jjgY3jgb7jgZfjgZ86Cj4gPiA+IEhpIGFsbCwK
Cj4gPiA+IGFjdHVhbGx5IHYyMCBpcyBiZXR0ZXIgdGhhbiB0aGlzIHYyMSA9PiBzZXR0aW5nIGl0
IGNoYW5nZXMKPiA+ID4gcmVxdWVzdGVkLgo+ID4gPiBJJ2QgcHJlZmVyIHRvIG1lcmdlIHYyMC4K
Li4uCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
