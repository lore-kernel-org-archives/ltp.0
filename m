Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F5C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:57:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C5D3CA1CC
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:57:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114273CA198
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:56:47 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 510392001CC
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:56:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC39C211AB;
 Fri, 28 Mar 2025 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743152205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/RynajQEIuLYWvz6EljNpUkr37JzBqarpqzf5xJh0Q=;
 b=f/7DhO/EPeuZoQ5fvf7U+tK0Y1GtuWHJna4pW1cuXdWlncwbxQ6IdpvW7rVM+kIGacIcIC
 85FRCr3HQGq2kstGH0wwqIZhbhpEBrd0QfU5zTRNKz1wPdh6VRuLWDHmS3gLdoKhGfAR85
 vKUOM+UXzwCvasrlyxBqLy0HjqY3Vg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743152205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/RynajQEIuLYWvz6EljNpUkr37JzBqarpqzf5xJh0Q=;
 b=z0gYswVtvYx2MbVhHxM3W5e9epIZC+sg/mmlgm4FivtsHTaBDMEmNh1F3Nz0nT/ZLWy1Cf
 MT1ctGHQvCclbLBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743152205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/RynajQEIuLYWvz6EljNpUkr37JzBqarpqzf5xJh0Q=;
 b=f/7DhO/EPeuZoQ5fvf7U+tK0Y1GtuWHJna4pW1cuXdWlncwbxQ6IdpvW7rVM+kIGacIcIC
 85FRCr3HQGq2kstGH0wwqIZhbhpEBrd0QfU5zTRNKz1wPdh6VRuLWDHmS3gLdoKhGfAR85
 vKUOM+UXzwCvasrlyxBqLy0HjqY3Vg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743152205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/RynajQEIuLYWvz6EljNpUkr37JzBqarpqzf5xJh0Q=;
 b=z0gYswVtvYx2MbVhHxM3W5e9epIZC+sg/mmlgm4FivtsHTaBDMEmNh1F3Nz0nT/ZLWy1Cf
 MT1ctGHQvCclbLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9733213927;
 Fri, 28 Mar 2025 08:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V/LZI01k5mcjCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 08:56:45 +0000
Date: Fri, 28 Mar 2025 09:56:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250328085640.GB130961@pevik>
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-4-pvorel@suse.cz>
 <D8R0YF9GVL4S.276WLTALPPSQ5@suse.com>
 <63364871-aec9-4ebe-9123-0c1b4a3cea9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63364871-aec9-4ebe-9123-0c1b4a3cea9f@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[ricardo=marliere.net];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] Makefile: Update 'doc' target,
 add 'doc-clean'
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>, ltp@lists.linux.it,
 Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBSaWNhcmRvLAoKPiBPbiAzLzI3LzI1IDEyOjUwLCBSaWNhcmRvIEIuIE1hcmxp77+977+9
cmUgdmlhIGx0cCB3cm90ZToKPiA+IE9uIE1vbiBNYXIgMjQsIDIwMjUgYXQgODo0MCBQTSAtMDMs
IFBldHIgVm9yZWwgd3JvdGU6Cj4gPiA+ICdkb2MnIHRhcmdldCBwcmV2aW91c2x5IHJ1biBkb2Nw
YXJzZSBkb2N1bWVudGF0aW9uLiBQb2ludCBpdCB0byBkb2MvCj4gPiA+IGRpcmVjdG9yeSBzbyB0
aGF0IGl0IGJ1aWxkIHNwaGlueCBkb2NzLiBkb2MvIGRpciBoYXMgbWV0YWRhdGEvIGRpciBhcwo+
ID4gPiBkZXBlbmRlbmN5LCBubyBuZWVkIHRvIHNwZWNpZnkgaXQuIENhbGwgYWxzbyAnLnZlbnYn
IHRhcmdldC4KCj4gPiA+IE5PVEU6IGl0J3Mgc3RpbGwgcG9zc2libGUgdG8gYXZvaWQgdmlydHVh
bGVudiBieSBjYWxsaW5nICdtYWtlIC1DIGRvYycKPiA+ICBGcm9tIHRoZSByb290IGRpciA/Cgo+
ID4gJCBtYWtlIC1DIGRvYwo+ID4gbWFrZTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvbW50L2V4dC9z
cmMvbGludXgvbHRwL21haWwvZG9jJwo+ID4gbWFrZSAtQyAvbW50L2V4dC9zcmMvbGludXgvbHRw
L21haWwvbWV0YWRhdGEKPiA+IG1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL21udC9leHQv
c3JjL2xpbnV4L2x0cC9tYWlsL21ldGFkYXRhJwo+ID4gL21udC9leHQvc3JjL2xpbnV4L2x0cC9t
YWlsL21ldGFkYXRhL3BhcnNlLnNoID4gbHRwLmpzb24KPiA+IG1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5ICcvbW50L2V4dC9zcmMvbGludXgvbHRwL21haWwvbWV0YWRhdGEnCj4gPiBpZiBbIC1k
IC52ZW52IF07IHRoZW4gLiAudmVudi9iaW4vYWN0aXZhdGU7IGZpOyBzcGhpbngtYnVpbGQgLWIg
aHRtbCAuIGh0bWwKPiA+IC9iaW4vc2g6IGxpbmUgMTogc3BoaW54LWJ1aWxkOiBjb21tYW5kIG5v
dCBmb3VuZAo+ID4gbWFrZTogKioqIFtNYWtlZmlsZToyNDogYWxsXSBFcnJvciAxMjcKPiA+IG1h
a2U6IExlYXZpbmcgZGlyZWN0b3J5ICcvbW50L2V4dC9zcmMvbGludXgvbHRwL21haWwvZG9jJwo+
IFllYWgsIHNwaGlueCBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhlIHJlcXVpcmVtZW50cy50eHQs
IG90aGVyd2lzZSBpdCdzIG5vdAo+IHBvc3NpYmxlIHRvIGFjY2VzcyB0byBpdCB2aWEgdmlydHVh
bGVudi4KCk9LLCBJJ2xsIGFkZCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKS2luZCByZWdhcmRz
LApQZXRyCgo+IEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
