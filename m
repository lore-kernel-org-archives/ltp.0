Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4261C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 21:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95A283CFE7A
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 23:03:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1C553CF918
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:03:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4E10200905
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:03:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E83D4343D2;
 Thu, 25 Apr 2024 21:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714078998;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFOyNkIo/ewCrCdzZVcQy5OVs4WEu0C1v+r6b8REXXg=;
 b=bbahC3/jKJnuKFR4LLcJAFGQ7QfPPE5svQyJkyJuAsJA0oVbgwFxmXXEt0aiYfCkDN18Q1
 AhneKJc1e3SVe33zhdxdLlhCR18UJKjIIzKAsPHWii4uzrGVGmYSuvbDLHH7lItgO8APkt
 5st3+Ix9jKVipLx7AK64pV7UXlMu0YI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714078998;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFOyNkIo/ewCrCdzZVcQy5OVs4WEu0C1v+r6b8REXXg=;
 b=gAXc80aNH/fG3fPJwwz5w5EcLyHOJpGw/JzACEEU/G3xl17/mX6bucgLbfqiRrNFFixR8R
 2/CsGdIkz7PAFxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714078997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFOyNkIo/ewCrCdzZVcQy5OVs4WEu0C1v+r6b8REXXg=;
 b=QmYKynvnEBgw/bfPK5c7JLJxMMA9q6AySCg+uc2RenqLpcTzm02k5oySNeE/2rcg97zDHT
 orT5jkf+v1iPWqKaPvS/35GuD283K/I8riOKdKik4/qd9HGNwI9onpvnUnII1dq+7LXO0B
 Y4wtuYhVTm+tOCdGpkcQwZyEfSq++f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714078997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFOyNkIo/ewCrCdzZVcQy5OVs4WEu0C1v+r6b8REXXg=;
 b=1MTbuosgLHiyoLhueMJ6rPl5W1Jz9oQvk3/7XgdfL9rbpi7Cc48l8MR+G/QI94GOLc/OqC
 etGPHMNg8MZABIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9474913991;
 Thu, 25 Apr 2024 21:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nLBQIxXFKmYEZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 21:03:17 +0000
Date: Thu, 25 Apr 2024 23:03:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240425210315.GA295964@pevik>
References: <20240425155533.295195-1-pvorel@suse.cz>
 <CAASaF6xqK+D=_3mmCYUfSGaZUO-AmDAKNity7mG-wOhAJsw-rA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xqK+D=_3mmCYUfSGaZUO-AmDAKNity7mG-wOhAJsw-rA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] Build fixes
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

SGkgSmFuLAoKPiBPbiBUaHUsIEFwciAyNSwgMjAyNCBhdCA1OjU14oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IGNoYW5nZXMgdjItPnYzCj4gPiAqIFVzZSBqdXN0
IGxvbmcgbG9uZyBpbnN0ZWFkIG9mIGRlZmluZSBfR05VX1NPVVJDRSAoSmFuKQoKPiA+IFRlc3Rl
ZDoKPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzg4MzU1NTc1
OTQKCj4gVGhhbmtzIGZvciB0cnlpbmcgdGhpcyBvdGhlciBhcHByb2FjaCwgZXZlbiBhcyBzaG9y
dC10ZXJtIGZpeCwgaXQgd2lsbCBob3BlZnVsbHkKPiBhdCBsZWFzdCBnaXZlIHVzIG1vcmUgdGlt
ZSB0byB0aGluayBhYm91dCBhZGRyZXNzaW5nIG90aGVyCj4gaW5zdGFuY2VzIG9mIF9HTlVfU09V
UkNFIHJlbGF0ZWQgaXNzdWVzLgoKCj4gPiBJZGVhbGx5IEknZCBsaWtlIHRvIG1lcmdlIHRvbW9y
cm93LgoKPiBBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+CgpUaGFu
a3MgYSBsb3QgZm9yIHlvdXIgc3VnZ2VzdGlvbnMsIG1lcmdlZCEKCktpbmQgcmVnYXJkcywKUGV0
cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
