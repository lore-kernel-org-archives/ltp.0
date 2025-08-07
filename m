Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A24C87FD2
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 05:11:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF24D3C8FDD
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:11:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 429613C04FF
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 07:11:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 84A331A00368
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 07:11:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B33833C77;
 Thu,  7 Aug 2025 05:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754543496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mnl2KHhn8RxiTBiW7JjPfVTFm+Xw8ZZtNrvS7elUsQA=;
 b=SgQ3JQPfKUp7PFFcVVAT7QNDdcKSN3kB+896ClujdXdAHAm+FzXHgNVwiwOKUkc4e7kIC8
 0AHXfMjraA+1aSzmyAf5SanSylCdGh43t9ylSgMPQnYScNPSks1WOBK0CN5JFMLae1DoKi
 nazolSgyolbjoZxzXTHM/gTbLh1r/2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754543496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mnl2KHhn8RxiTBiW7JjPfVTFm+Xw8ZZtNrvS7elUsQA=;
 b=lZ4Po92cuhiyCb9pdLHulZQvgvk1leNrU+VDPN1kNQZnj5ra1zzT028Gz8jcq7AO9P2L9T
 nvLxRX6Q2rDOMNBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754543495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mnl2KHhn8RxiTBiW7JjPfVTFm+Xw8ZZtNrvS7elUsQA=;
 b=Vh+ApdiN7GzdCQCjFvzDj5dORxpDfSfIasqTby4W1E3D+gqWcAkJx7JM9Yr4F26+jV2Byz
 VaGE4aJF89x0ppTOiBmnlO2oIhdLlZ/olIDKdzX+EYXedACxMylCfKTYaaudkrdXpefFcO
 0LQZVYrSFa7bNmX6cOoFgQsAodVAuk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754543495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mnl2KHhn8RxiTBiW7JjPfVTFm+Xw8ZZtNrvS7elUsQA=;
 b=749pr4z1906dP7JiWfC1+cHBCBw8jxeRKFJwLA3QHLEa7RqUpPyEeLIrH3PvcxeOk0NZcy
 ybC0pl+sZ1Sj8fAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5652B133D1;
 Thu,  7 Aug 2025 05:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mrl5E4c1lGhNbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 07 Aug 2025 05:11:35 +0000
Date: Thu, 7 Aug 2025 07:11:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250807051133.GA331644@pevik>
References: <20250806211420.445452-1-pvorel@suse.cz>
 <CAEemH2cgv6vwZvK4J5cquG4=sXt2076CdNtB-fuMzx0+OOFcDw@mail.gmail.com>
 <CAEemH2ddKZwocZbpf9vUVjNssbonifJG5o7hu-PoBggZocXVSA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ddKZwocZbpf9vUVjNssbonifJG5o7hu-PoBggZocXVSA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Makefile: Add kernel modules related make
 targets
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
Cc: Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksIGFsbCwKCj4gT24gVGh1LCBBdWcgNywgMjAyNSBhdCA3OjIy4oCvQU0gTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiA+IEhpIFBldHIsCgo+ID4gT24gVGh1LCBBdWcg
NywgMjAyNSBhdCA1OjE04oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoK
PiA+PiBMVFAgY29udGFpbnMgZmV3IGtlcm5lbCBtb2R1bGVzIGFuZCB0ZXN0cyB3aGljaCBhcmUg
dXNpbmcgdGhlbS4gIFRoZXNlCj4gPj4gcmVxdWlyZSB0byBiZSBidWlsdCB3aXRoIHRoZSBzYW1l
IGtlcm5lbCBoZWFkZXJzIGFzIHRoZSBydW5uaW5nIGtlcm5lbAo+ID4+IChTVVQpLiBTb21ldGlt
ZXMgdGhlIGJlc3Qgd2F5IHRvIGFjaGlldmUgdGhpcyBpcyB0byBjb21waWxlIHRoZW0gb24gdGhl
Cj4gPj4gU1VULgoKPiA+PiBBZGQgJ21vZHVsZXMnLCAnbW9kdWxlcy1jbGVhbicgYW5kICdtb2R1
bGVzLWluc3RhbGwnIG1ha2UgdGFyZ2V0cyB0bwo+ID4+IG1ha2UgaXQgZWFzaWVyIHRvIGJ1aWxk
IHRoZW0uCgoKPiA+IE1heWJlIGJldHRlciB0byBrZWVwIHRoZSBtYWtlIHRhcmdldCBjb25zaXN0
ZW50IHdpdGggdGhlIGtlcm5lbCBidWlsZAo+ID4gY29tbWFuZDoKPiA+ICAgbWFrZSBtb2R1bGVz
X2luc3RhbGwKPiA+ICAgbWFrZSBtb2R1bGVzX2NsZWFuCgo+IEFsc28sIGl0IGxvb2tzIGxpa2Ug
TFRQIG1peGVzIHVzaW5nICItIiBhbmQgIl8iIGluIGl0cyBtYWtlIHRhcmdldHM6Cgo+ICAgbGli
LWFsbCwgbWV0YWRhdGEtYWxsLCBjbGVhbl9pbnN0YWxsX2RpciwgdmVyX2xpbnV4CgpJIGNob3Nl
ICctJyBiZWNhdXNlIHRoYXQncyB3aGF0IHVzZXMgTFRQIGZvciBtYWtlIHRhcmdldHMuCnZlcl9s
aW51eCB1c2VzIHVuZGVyc2NvcmUgYmVjYXVzZSB0YXJnZXQgaW5oZXJpdHMgaXQgZnJvbSB0aGUg
bmFtZSBvZiB0aGUgZmlsZS4KCmNsZWFuX2luc3RhbGxfZGlyIGlzIHRoZSBvbmx5IHRhcmdldCB3
aGljaCB1c2VzICdfJywgSSdtIG5vdCBzdXJlIHdoeSB0aGlzCmluY29uc2lzdGVuY3kuCgo+IFNv
IHdlIG1heSBuZWVkIHRvIHVzZSBqdXN0IG9uZSBzZWxlY3Rpb24sIHdoaWNoIGNhbiBiZSBkb25l
IGluIGEgc2VwYXJhdGUKPiBwYXRjaCBhbnl3YXkuCgpJIGdvdCB0aGUgcG9pbnQgdGhhdCBrZXJu
ZWwgdXNlcyAnXycuIERvIHdlIHdhbnQgdG8gdW5pZnkgYWZ0ZXIgeWVhcnMgdXNpbmcgJy0nPwpJ
J20gb2sgdG8gZG8gdGhlIHdvcmsgaWYgd2UgY29uc2lkZXIgaXQncyB1c2VmdWwuCgpJIHBlcnNv
bmFsbHkgY29uc2lkZXIgbW9yZSBpbXBvcnRhbnQgZnJvbSB0aGUgbG9uZyB0ZXJtIHRvIGNoYW5n
ZSBidWlsZCBzeXN0ZW0KdG8gbWVzb24gKGRlIGZhY3RvIHN0YW5kYXJkIGZvciB0aGUgdXNlcnNw
YWNlIHByb2plY3RzLCBpbmNsdWRpbmcgdGhlc2UgcmVsYXRlZAp0byBrZXJuZWwpLgoKS2luZCBy
ZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
