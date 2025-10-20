Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B847DCCD199
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 13:22:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7E6D3CEF64
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 15:22:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E43E23CECFE
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 15:21:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 263F260047F
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 15:21:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 163AA211C8;
 Mon, 20 Oct 2025 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760966510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXpRZ62yC+L5XDnHuWl7GSI4xdKLtHUqvIuEf8Fi6NY=;
 b=b+89GyExJENpIPxGbKWkTBKR92KaZy/MjJm0RvSWcfzJPXAECrH4XvU7RBadtZuyyjlWHp
 8aSBWJ/NHtXMHPG3t2WdQfGcKGABwoqUNp4E3o/xX1PmkK6gWu3+ui2umc4y3t4kqIUmlI
 DOz1ULEylIXXnjkv0fqQwm5OKJzT2qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760966510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXpRZ62yC+L5XDnHuWl7GSI4xdKLtHUqvIuEf8Fi6NY=;
 b=a2irHFuOxHfhIx3FfOrMQuEWF3kJvv4BciIg+wliA4Y96F+Uz41xtfby1sWJR+V8M6tMZu
 uWu8e+jVdDgoSaAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760966506;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXpRZ62yC+L5XDnHuWl7GSI4xdKLtHUqvIuEf8Fi6NY=;
 b=ddpqRNgqZIt0cSj0UqnVePV1Fyglm0vf9pRtySyC1oEEIQNYP3a8YHgiy5DypvTZP0IOKS
 x6uiljDpJ7xoSz1h2UKv6h6ayDGdCNhwsxQ+SbEdUBwYdylZlRT3vpJC26NU7pYrgFDR2S
 Z5yh8sIwczLPEYyQSZVmzPJbmVnNccc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760966506;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXpRZ62yC+L5XDnHuWl7GSI4xdKLtHUqvIuEf8Fi6NY=;
 b=6eXwMa96WqxviyT4lC6vcTxXsWKre6HFnmqSWV0bNrXzWSX8s/iJVrX1wagl5BuPVoXQpX
 5RzD7C3cn3iDCKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E487313AAC;
 Mon, 20 Oct 2025 13:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OaGnNmk39mhxYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Oct 2025 13:21:45 +0000
Date: Mon, 20 Oct 2025 15:21:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251020132140.GA398576@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
 <20251017143524.GA339521@pevik> <aPWO0j120Kr0z6Pn@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aPWO0j120Kr0z6Pn@localhost>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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

SGkgV2VpLAoKPiA+ID4gLQljb25zdCBjaGFyICpjb25zdCAqbmVlZHNfY21kczsKPiA+ID4gKwlz
dHJ1Y3QgdHN0X2NtZCAqbmVlZHNfY21kczsKCj4gPiBBcyBJIHdyb3RlIGluIGFsbCBwcmV2aW91
cyB2ZXJzaW9ucywgY2hhbmdpbmcgc3RydWN0IHVzZWQgaW4gc3RydWN0IHRzdF90ZXN0Cj4gPiBh
bG9uZSB3aXRob3V0IGNoYW5naW5nIHdpbGwgYnJlYWsgdGhpcyBwYXJ0aWN1bGFyIGNvbW1pdC4K
Cj4gPiBTZWUgd2hlbiBJIGFwcGx5IGp1c3QgdGhpcyBjb21taXQuOgo+ID4gaHR0cHM6Ly9naXRo
dWIuY29tL3BldmlrL2x0cC9hY3Rpb25zL3J1bnMvMTg1OTU4OTE1ODYKPiA+IGh0dHBzOi8vZ2l0
aHViLmNvbS9wZXZpay9sdHAvY29tbWl0cy9yZWZzL2hlYWRzL3dlaS9uZWVkc19jbWRzLnY0LmZp
cnN0LWNvbW1pdC1icm9rZW4vCgo+ID4gQ0MgbGliL25ld2xpYl90ZXN0cy90c3RfZXhwaXJhdGlv
bl90aW1lcgo+ID4gdHN0X25lZWRzX2NtZHMwMS5jOjE1OjIzOiBlcnJvcjogaW5pdGlhbGl6YXRp
b24gb2Yg4oCYc3RydWN0IHRzdF9jbWQgKuKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5
cGUg4oCYY29uc3QgY2hhciAqKuKAmSBbLVdpbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KPiA+
ICAgIDE1IHwgICAgICAgICAubmVlZHNfY21kcyA9IChjb25zdCBjaGFyICpbXSkgewo+ID4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgXgo+ID4gdHN0X25lZWRzX2NtZHMwMS5jOjE1OjIz
OiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3Ig4oCYdGVzdC5uZWVkc19jbWRz4oCZKQoK
PiA+IC4uLgoKPiA+IHF1b3RhY3RsMDEuYzoyMjY6MjM6IGVycm9yOiBpbml0aWFsaXphdGlvbiBv
ZiDigJhzdHJ1Y3QgdHN0X2NtZCAq4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDi
gJhjb25zdCBjaGFyICogY29uc3Qq4oCZIFstV2luY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQo+
ID4gICAyMjYgfCAgICAgICAgIC5uZWVkc19jbWRzID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKSB7
Cj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICBeCgo+ID4gUGxlYXNlIHlvdSBuZWVk
IHRvIGhhdmUgdGhpcyBjb21taXQgdG9nZXRoZXIgd2l0aCAiVXBkYXRlIHRlc3QgY2FzZXMgdXNl
IG5ldwo+ID4gbmVlZHNfY21kcyIgY29tbWl0IGludG8gc2luZ2xlIGNvbW1pdCAoc3F1YXNoIHRo
ZXNlIHR3byBpbnRvIGEgc2luZ2xlIGNvbW1pdCkuCgo+ID4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0
aGluZz8KPiBUaGFua3MgZm9yIHlvdXIgdGltZSBkbyB2ZXJpZnkgdGVzdCBjYW4gcmV2aWV3Lgp5
dyA6KS4KCj4gVGhlIHJlYXNvbiBpIHNwbGl0IHRoaXMgcGF0Y2ggdG8gc21hbGwgY29tbWl0cyBp
cyBlYXN5IGZvciByZXZpZXcsIGlmIHlvdQoKWWVzLCBpdCdzIGRlc2lyZWQgdGhhdCBjaGFuZ2Vz
IGFyZSBzcGxpdCBpbnRvIHNtYWxsZXIgbG9naWNhbCBwYXJ0cyBpZiAqcG9zc2libGUqLgpZZXMs
IHRoaXMgcmVhbGx5IGhlbHBzIHJlYWRhYmlsaXR5LiBCdXQgaWYgcG9zc2libGUgbWVhbnMgYXQg
bGVzdCAxKSBub3QKYnJlYWtpbmcgY29tcGlsYXRpb24gKHRoZSB3b3JzdCBjYXNlKSAyKSBub3Qg
YnJlYWtpbmcgdGVzdCBmdW5jdGlvbmFsaXR5LgoKVGhlcmVmb3JlIGl0J3MgbXVjaCBlYXNpZXIg
dG8gc3BsaXQgaW50byBtb3JlIGNvbW1pdHMgc29tZSBuZXcgbGlicmFyeQpmdW5jdGlvbmFsaXR5
IChpLmUuIGFkZCBzb21lIGxpYnJhcnkgZnVuY3Rpb25hbGl0eSBhbmQgZW5hYmxlIGl0IGluIHNl
cGFyYXRlCmNvbW1pdHMsIGVuYWJsZSB0ZXN0cyBpbiBhIHNlcGFyYXRlIGNvbW1pdCkKCkJ1dCBt
b2RpZnlpbmcgdGhlIGZ1bmN0aW9uYWxpdHkgbGlrZSB0aGlzICh3aGVuIGl0IGJyZWFrcyBjb21w
aWxhdGlvbikgaXMgd29yc2UKdGhhbiBhIGJpdCBtb3JlIGNvbXBsZXggY29tbWl0LiBUaGlzIGlz
IHRoZSBydWxlIGluIG1hbnkgb3BlbiBzb3VyY2UgcHJvamVjdHMuCgo+IG5lZWQgZXZlcnkgY29t
bWl0cyBjYW4gcGFzcyBjb21waWxlIHBoYXNlIHRoZW4gaSBoYXZlIHRvIGNvbWJpbmUgYWxsCj4g
Y29tbWl0cyBpbnRvIGEgc2luZ2xlIGJpZyBvbmUsIGlzIHRoYXQgeW91ciByZXF1ZXN0PwoKTm8s
IHRoYXQncyBvdGhlciBleHRyZW1lIDopLiBUaGVyZSBpcyBzb21ldGhpbmcgaW4gYmV0d2Vlbiwg
cmlnaHQ/CllvdSBkaWQgbm90IGdldCBtZSBjb3JyZWN0LCB0aGVyZWZvcmUgaW4gdjQgeW91IG5v
dCBvbmx5IGtlcHQgYnJva2VuCmZ1bmN0aW9uYWxpdHksIGJ1dCB5b3UgYWxzbyBqb2luZWQgdGhl
IHBhcnQgd2hpY2ggY291bGQgYmUgc2VwYXJhdGVkLiAgQXQgbGVhc3QKImlvY3RsX2xvb3AwMS5j
OiBVcGRhdGUgdG8gbmV3IC5uZWVkc19jbWRzIHN0cnVjdCIgZnJvbSB2MyBjb3VsZCBoYXZlIGJl
ZW4gYWRkZWQKYXMgYSBzZXBhcmF0ZSBjb21taXQgKGFmdGVyIHRoZSBtYWluIGNoYW5nZSwgbm90
IGJlZm9yZSkuIE9yIGFtIEkgbWlzc2luZwpzb21ldGhpbmc/CgpVbmZvcnR1bmF0ZWx5ICJsaWI6
IEFkZCBzdXBwb3J0IG9wdGlvbiBmb3IgLm5lZWRzX2NtZHMiIGFuZCAiVXBkYXRlIHRlc3QgY2Fz
ZXMgdXNlCm5ldyBuZWVkc19jbWRzIiBhbmQgInRzdF9ydW5fc2hlbGwuYzogQWRkIG5ldyBmdW5j
dGlvbiBoYW5kbGUgbmV3Cm5lZWRzX2NtZHMiIG5lZWRzIHRvIGJlIGluIGEgc2luZ2xlIGNvbW1p
dCwgYnV0IG1heWJlIHlvdSBjb3VsZCBhZGQgZnVuY3Rpb25zCndoaWNoIGltcGxlbWVudCBpdCBp
biBhIHNlcGFyYXRlIGNvbW1pdHMgKGUuZy4gcHJlcGFyYXRpb24gZm9yIGEgbmV3IGNoYW5nZSkg
YW5kCmRvIHRoZSBjaGFuZ2UgKHdoZW4gaXQncyBhY3R1YWxseSB1c2VkKSBpbiB0aGUgbGFzdCBj
b21taXQpLiAgSSdtIG5vdCBzdXJlIGlmCml0J3Mgd29ydGggb2YgYSBzZXBhcmF0aW9uLCBtYXli
ZSBub3QgKGhvcGVmdWxseSB3ZSBnZXQgYSBmZWVkYmFjayBmcm9tIG90aGVycykuCklmIHllczoK
CjEpIGNvbW1pdCAobGliIHByZXBhcmF0aW9uKSB3b3VsZCBoYXZlOiBzdHJ1Y3QgdHN0X2NtZCwg
Ym9vbAp0c3RfY21kX3ByZXNlbnQoY29uc3QgY2hhciAqY21kKQoKMikgY29tbWl0IChzaGVsbCBs
b2FkZXIgcHJlcGFyYXRpb24pIHdvdWxkIGhhdmU6IGVudW0gY21kX2lkcywgc3RhdGljCnVqc29u
X29ial9hdHRyIGNtZF9hdHRyc1tdLCBzdGF0aWMgdWpzb25fb2JqIGNtZF9vYmosIHN0YXRpYyBz
dHJ1Y3QgdHN0X2NtZAoqcGFyc2VfY21kcyh1anNvbl9yZWFkZXIgKnJlYWRlciwgdWpzb25fdmFs
ICp2YWwpLgoKMykgY29tbWl0ICh1c2UgbmV3IGZ1bmN0aW9uYWxpdHkpIHdvdWxkIGhhdmU6IGZy
b20gImxpYjogQWRkIHN1cHBvcnQgb3B0aW9uIGZvcgoubmVlZHNfY21kcyI6CgotCWNvbnN0IGNo
YXIgKmNvbnN0ICpuZWVkc19jbWRzOworCXN0cnVjdCB0c3RfY21kICpuZWVkc19jbWRzOwoKYW5k
IHVzZSBvZiB0c3RfY2hlY2tfY21kKCkKCmZyb20gInRzdF9ydW5fc2hlbGwuYzogQWRkIG5ldyBm
dW5jdGlvbiBoYW5kbGUgbmV3IG5lZWRzX2NtZHMiCi0JCQl0ZXN0Lm5lZWRzX2NtZHMgPSBwYXJz
ZV9zdHJhcnIoJnJlYWRlciwgJnZhbCk7CisJCQl0ZXN0Lm5lZWRzX2NtZHMgPSBwYXJzZV9jbWRz
KCZyZWFkZXIsICZ2YWwpOwoKYWxsIGNvZGUgY2hhbmdlcyBpbiAiVXBkYXRlIHRlc3QgY2FzZXMg
dXNlIG5ldyBuZWVkc19jbWRzIgoKNCkgImlvY3RsX2xvb3AwMS5jOiBVcGRhdGUgdG8gbmV3IC5u
ZWVkc19jbWRzIHN0cnVjdCIgZnJvbSB2MyBjYW4gYmUgc2VwYXJhdGUsCml0IGp1c3QgaGF2ZSB0
byBiZSBhZnRlciBsaWJyYXJ5IGZ1bmN0aW9uIGNoYW5nZWQuCgo1KSBjb21taXQ6IG1vZGlmeSBz
b21lIHRlc3QgdG8gYWN0dWFsbHkgdXNlIHNvbWUgb2YgbmV3IGZ1bmN0aW9uYWxpdHkuCgpJZiB3
ZSBhcmUgb2sgdG8gZG8gdG9vIG1hbnkgc2VwYXJhdGUgY29tbWl0cywgdGhlbjoKCjEpIGNvbW1p
dDogZXZlcnl0aGluZyBmcm9tIHRoaXMgdjQgaW4gYSBzaW5nbGUgY29tbWl0LCBidXQgc2VwYXJh
dGUgYXQgbGVhc3QKImlvY3RsX2xvb3AwMS5jOiBVcGRhdGUgdG8gbmV3IC5uZWVkc19jbWRzIHN0
cnVjdCIgZnJvbSB2My4KCjIpICJpb2N0bF9sb29wMDEuYzogVXBkYXRlIHRvIG5ldyAubmVlZHNf
Y21kcyBzdHJ1Y3QiIGZyb20gdjMuCgozKSBjb21taXQ6IG1vZGlmeSBzb21lIHRlc3QgdG8gYWN0
dWFsbHkgdXNlIHNvbWUgb2YgbmV3IGZ1bmN0aW9uYWxpdHkuCgpLaW5kIHJlZ2FyZHMsClBldHIK
Cj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
