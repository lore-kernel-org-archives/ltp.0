Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22E810A88D4
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:45:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 723673CCD94
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 16:45:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E80F83CCB72
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 16:44:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55D256008A9
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 16:44:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E5114D2D3;
 Thu, 26 Mar 2026 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774539878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9L4gVzbpcZJt0ezYTj2kk2FvCxkLLcYjggEnmxqMp/I=;
 b=tll4Nq9ne4cogR4K6kayf6WWjyFLPA37WBF3vW+BRBVX3Ex1XiEnG/EFONbBpSNU3hCFef
 YqJkuX/gJBFhO7JRg9PB8YuFAeVVqn5kZN+A5TRQGpAyNhUd88WBiiiiZLTRLeY0MeWAbo
 JurBeELsi4+ML1VsW290s0GbHW0yZW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774539878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9L4gVzbpcZJt0ezYTj2kk2FvCxkLLcYjggEnmxqMp/I=;
 b=kDC0wrorRovpav87/Xychg0l+V/kVLo9rFYVZuQexzfiVr6haikGdo4UXr1tDBsRXvvDFb
 dSitbtIZrTre94Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774539878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9L4gVzbpcZJt0ezYTj2kk2FvCxkLLcYjggEnmxqMp/I=;
 b=tll4Nq9ne4cogR4K6kayf6WWjyFLPA37WBF3vW+BRBVX3Ex1XiEnG/EFONbBpSNU3hCFef
 YqJkuX/gJBFhO7JRg9PB8YuFAeVVqn5kZN+A5TRQGpAyNhUd88WBiiiiZLTRLeY0MeWAbo
 JurBeELsi4+ML1VsW290s0GbHW0yZW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774539878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9L4gVzbpcZJt0ezYTj2kk2FvCxkLLcYjggEnmxqMp/I=;
 b=kDC0wrorRovpav87/Xychg0l+V/kVLo9rFYVZuQexzfiVr6haikGdo4UXr1tDBsRXvvDFb
 dSitbtIZrTre94Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA7634A0A3;
 Thu, 26 Mar 2026 15:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qGcgN2VUxWkFcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 15:44:37 +0000
Date: Thu, 26 Mar 2026 16:44:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260326154421.GA7157@pevik>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <acVE76yDEM8pymPW@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acVE76yDEM8pymPW@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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

PiBIaSEKPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
Cj4gPiBuaXQ6IHBsZWFzZSB1c2UgLyogKi8gb3RoZXJ3aXNlIGNoZWNrcGF0Y2ggY29tcGxhaW5z
LgoKPiBIbW0sIHNvIGFwcGFyZW50bHkga2VybmVsIGhhcyBhIGJpdCBjcmF6eSBydWxlIHRoYXQg
dGhlIFNQRFggaGFzIHRvIGJlCj4gYmV0d2VlbiAvKiAqLyBpbiBoZWFkZXJzIGFuZCBzdGFydCB3
aXRoIC8vIGluIEMgc291cmNlcy4gQmVjYXVzZSBvZiBzb21lCj4gdG9vbGluZyB0aGF0IHBhcnNl
cyBrZXJuZWwgaGVhZGVycyBjb3VsZG4ndCBoYW5kbGUgLy8uCgpZZXM6CgpodHRwczovL2RvY3Mu
a2VybmVsLm9yZy9wcm9jZXNzL2xpY2Vuc2UtcnVsZXMuaHRtbCNsaWNlbnNlLWlkZW50aWZpZXIt
c3ludGF4CgoJSWYgYSBzcGVjaWZpYyB0b29sIGNhbm5vdCBoYW5kbGUgdGhlIHN0YW5kYXJkIGNv
bW1lbnQgc3R5bGUsIHRoZW4gdGhlCglhcHByb3ByaWF0ZSBjb21tZW50IG1lY2hhbmlzbSB3aGlj
aCB0aGUgdG9vbCBhY2NlcHRzIHNoYWxsIGJlIHVzZWQuIFRoaXMgaXMKCXRoZSByZWFzb24gZm9y
IGhhdmluZyB0aGUg4oCcLyogKi/igJ0gc3R5bGUgY29tbWVudCBpbiBDIGhlYWRlciBmaWxlcy4g
VGhlcmUgd2FzCglidWlsZCBicmVha2FnZSBvYnNlcnZlZCB3aXRoIGdlbmVyYXRlZCAubGRzIGZp
bGVzIHdoZXJlIOKAmGxk4oCZIGZhaWxlZCB0byBwYXJzZQoJdGhlIEMrKyBjb21tZW50LiBUaGlz
IGhhcyBiZWVuIGZpeGVkIGJ5IG5vdywgYnV0IHRoZXJlIGFyZSBzdGlsbCBvbGRlcgoJYXNzZW1i
bGVyIHRvb2xzIHdoaWNoIGNhbm5vdCBoYW5kbGUgQysrIHN0eWxlIGNvbW1lbnRzLgoKPT4gb2xk
ZXIgYXNzZW1ibGVyIHRvb2xzLgoKPiBJIGRvIG5vdCB0aGluayB0aGF0IHRoZXJlIHdpbGwgYmUg
YW55IHRvb2xpbmcgcGFyc2luZyBMVFAgaW50ZXJuYWwKPiBoZWFkZXJzLiBNYXliZSB3ZSBjYW4g
c2lsZW5jZSB0aGF0IHJ1bGUgaW4gY2hlY2twYXRjaD8KCkknZCBwcmVmZXIgdG8ga2VlcCBjaGFu
Z2VzIGluIG91ciB2ZW5kb3JlZCBjaGVja3BhdGNoIHBsIHRvIGJhcmUgbWluaW11bQp0byBub3Qg
Y29tcGxpY2F0ZSB1cGRhdGluZy4gIFVuZm9ydHVuYXRlbHkgdGhlcmUgaXMgYSBzaW5nbGUgdGFn
ClNQRFhfTElDRU5TRV9UQUcgZm9yIG1hbnkgY2hlY2twYXRjaCBlcnJvcnMuIEl0J2QgYmUgZ3Jl
YXQgaWYgdGhpcyBjb3VsZCBiZQpjb25maWd1cmFibGUuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
