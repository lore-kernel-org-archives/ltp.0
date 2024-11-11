Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6225D2E9DE
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 11:43:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 718693D53FF
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 12:43:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F8173D51EE
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 12:43:35 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 713B8630040
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 12:43:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6312A2199F;
 Mon, 11 Nov 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731325413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSCw8nDdEAY2sR9DjBe5TGhAJWXIDKO4Zj5ckY5eQnI=;
 b=dN0NR261BU/JomCu7YbWDiHY0+dwaGgEV1qhSgnZGtEYe9EOwFncSUWOiL92aoQVfzs6vS
 pWeYtwMWHqzcrSgp2duXv+6w8bO8MrsvwZ4QNpOObQK3zQXq8iNGkiBYrcFYJGV4706LrH
 gEjaL8MEPckycbtCfDQ183xEpG7MQ/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731325413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSCw8nDdEAY2sR9DjBe5TGhAJWXIDKO4Zj5ckY5eQnI=;
 b=fypGlAAgEkbia4DTYXjc9wr4a/Z3osDBrmDTKHVy/GwBvdb7naAvgPSfrUTdIJDlyJ1b5H
 sMsyxxbiEP0p8pAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731325412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSCw8nDdEAY2sR9DjBe5TGhAJWXIDKO4Zj5ckY5eQnI=;
 b=j90nhb10pwfBctlY5yPDt344HKa3RYdoVuqOVairQgVtBR8+/8xigB5bVuApjOJruZnu8H
 5jfjq7QiUTw5+YdI1Pepqa/ZnypxhiLVbBQ1cxfNB5OCAM9N4DvLcP5MPPLwntE2Ip/isx
 1gMbxZzImUWYygUbArdu//qHz/EFtrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731325412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSCw8nDdEAY2sR9DjBe5TGhAJWXIDKO4Zj5ckY5eQnI=;
 b=qxZKfrVCGJ+PvNl/JEln7SiK4zG9ZPPm55HUMRR7PpxP73THFYDVpzr6MKgK64NR+HDV0M
 68cWyyme2i+MGiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 502F8137FB;
 Mon, 11 Nov 2024 11:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J74/E+TtMWf/MAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 11 Nov 2024 11:43:32 +0000
Date: Mon, 11 Nov 2024 12:43:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZzHt55N90DAc7CVv@yuki.lan>
References: <Zy4z-VvTyGScU5tQ@yuki.lan>
 <52C460ED-16D1-44BA-8273-2DB44C2F5C60@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52C460ED-16D1-44BA-8273-2DB44C2F5C60@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Fallback landlock network support
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

SGkhCj4geW91IGNhbuKAmXQgYmVjYXVzZSB0aGV5IGFyZSBhbHdheXMgZGVmaW5lZC4gVGhleSBj
YW4gYmUgMCBvciAxLiBDaGVjayBjb25maWcuaAoKVWZmLCBpdCBzZWVtcyB0aGF0IGluZGVlZCB0
aGUgQUNfQ0hFQ0tfREVDTFMoKSBiZWhhdmVzIGRpZmZlcmVudGx5IHRoYW4KcmVzdCBvZiB0aGUg
Y2hlY2tzIHRoYXQgZWl0aGVyIGRlZmluZXMgdGhlIG1hY3JvIG9yIG5vdC4gSSBkaWRuJ3QKZXhw
ZWN0ZWQgdGhhdC4KCkFueXdheXMgdGhlIHBhdGNoc2V0IGlzIGZpbmUgdGhlbi4KCi0tIApDeXJp
bCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
