Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A71ECCA471
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 16:27:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D27643CE53A
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 18:26:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 571A93C91CC
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 18:26:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C435F100044C
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 18:26:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C172E337B4;
 Fri,  3 Oct 2025 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759508800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBMjuTSeM8kDy+fu6mle2OgMGozXvUDq1edOfSYfzH0=;
 b=Ae/G/fbNrOSbZszumKJWyBFmBphloPIkIUL1iHINA2M/jDSxWAFrIlSiOG2f3Wyal/y/aL
 uINzSt0XVl2TVKivYhyHkEDxioBan2CN2ypM2DD3DXoKpVe6/2rHpH8y7kW1HIQa2vWU89
 D/TO4vD/DjkER0djmeHT5IFnOckoPRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759508800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBMjuTSeM8kDy+fu6mle2OgMGozXvUDq1edOfSYfzH0=;
 b=0+qS+dUY9uBQMqWbQqTEFnMSbk1wrZ4WBPiS1SV/FzSflIiMN+qT3rliser77UAcgV96cQ
 3EUiBXaxPjcCPTCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pOwDcNCs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6uY4dcYv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759508799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBMjuTSeM8kDy+fu6mle2OgMGozXvUDq1edOfSYfzH0=;
 b=pOwDcNCsHoeS1bl3QbA3PCzqGa2qNC1eKnSqslTyOCAlssJAvADDVYd1Jvv27WGzHbnAde
 +FcsFuUb062ze6QDsCD9ZppF6Zk4BAfrPacEv2MGBl/PuIfnoe/KFmWsjGkLNllpsc9MTC
 6QVJc9ASy5sesYau0YGTgYQkV6Pl8ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759508799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBMjuTSeM8kDy+fu6mle2OgMGozXvUDq1edOfSYfzH0=;
 b=6uY4dcYvIOE6TUxbveUk4pK72dMVp1itsPSt65pGGm2rpkI7mdW0j4T3cS7CaH1jQhsNeW
 dPg1tgrJILgFnLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD79013AAD;
 Fri,  3 Oct 2025 16:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0hkWKj/532iVdQAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 03 Oct 2025 16:26:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 16FEBA0A30; Fri,  3 Oct 2025 18:26:35 +0200 (CEST)
Date: Fri, 3 Oct 2025 18:26:35 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <5sppree3gcipofoh7d2ixjrbipf6owu2rwbp4p3777jk4ir245@fuly2zhefobr>
References: <20251001145600.24767-1-jack@suse.cz>
 <CAOQ4uxj8LEckipTS6jzLf6qXd+g7mGCYyDf-xNx18cZEo2wMqg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj8LEckipTS6jzLf6qXd+g7mGCYyDf-xNx18cZEo2wMqg@mail.gmail.com>
X-Rspamd-Queue-Id: C172E337B4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_LAST(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:email, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] name_to_handle_at: Add test cases for
 AT_HANDLE_FID
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IDAyLTEwLTI1IDExOjQ5OjI4LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBXZWQs
IE9jdCAxLCAyMDI1IGF0IDQ6NTbigK9QTSBKYW4gS2FyYSA8amFja0BzdXNlLmN6PiB3cm90ZToK
PiA+Cj4gPiBBZGQgYSBmZXcgdGVzdGNhc2VzIHZlcmlmeWluZyBBVF9IQU5ETEVfRklEIGZsYWcu
Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiA+IC0tLQo+
ID4gIGluY2x1ZGUvbGFwaS9mY250bC5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsK
PiA+ICAuLi4vbmFtZV90b19oYW5kbGVfYXQvbmFtZV90b19oYW5kbGVfYXQwMy5jICAgfCA4OCAr
KysrKysrKysrKysrKysrKysrCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCsp
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmFtZV90
b19oYW5kbGVfYXQvbmFtZV90b19oYW5kbGVfYXQwMy5jCj4gPgo+ID4gVGhpcyBpcyBhY3R1YWxs
eSBhIHRlc3RjYXNlIGZvciBhIGtlcm5lbCByZWdyZXNzaW9uLCB0aGUga2VybmVsIGZpeCBpcyBv
biB0aGUKPiA+IHdheS4KPiAKPiBCZXN0IHRoYXQgd2Ugd2FpdCBmb3IgZml4IHRvIGxhbmQgYmVm
b3JlIG1lcmdpbmcgdGhlIHRlc3Qgc28gdGhhdCB3ZSBjYW4KPiBhZGQgbGludXgtZ2l0IHRhZyB0
byB0aGUgdGVzdCAob3IgY2FuIGFkZCBpdCBsYXRlcikKClllcywgSSB3YXMgaW50ZW5kaW5nIHRv
IGRvIHRoYXQgYnV0IHdhbnRlZCB0byBzZW5kIG91dCB0aGUgdGVzdCBmb3IgcmV2aWV3CmJlZm9y
ZSB0aGF0Li4uCgo+IFdpdGggbWlub3Igbml0cyBiZWxvdyBmaXhlZCwgZmVlbCBmcmVlIHRvIGFk
ZDoKPiBSZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KClRo
YW5rcywgbml0cyBmaXhlZCB1cC4gSSdsbCBzZW5kIHYyIG9uY2UgdGhlIGtlcm5lbCBmaXggaXMg
bWVyZ2VkLgoKCQkJCQkJCQlIb256YQoKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNF
IExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
