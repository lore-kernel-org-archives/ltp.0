Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA105C54ED0
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 06:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7270E3CC8D2
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 08:29:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 285753C0E44
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:29:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 11FE0140007E
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:29:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D12A31F385;
 Fri, 23 May 2025 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747981749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bwJBwRW2Ylowox9aEo0wHqETsopNhztIeIfYb8XwHg=;
 b=S1ZHPvhBp6QhfpuGxK4nl9cTsnQu2+0pFAa2me/7hPsDcPVD7FGs3X97EIeP9kW9m3uCaR
 yBMlYo7kDCjwCncqyqTOoR8o1p+333g+RMhnU14UTOOrz9JTt1fTUOXyrrMMjCNRf4UME7
 /is/jUGZYnj/xox1E4iz82iAZ/5+sUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747981749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bwJBwRW2Ylowox9aEo0wHqETsopNhztIeIfYb8XwHg=;
 b=rZU4/m+AVr86WhZXeXIYjF/JesCk4XOYSIzU7etHVSV0+IJo+S8jSLjoD/1kuvBK66bEZO
 A2PElwLAeJRlPxCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O4AoBDZM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Eshj1ImD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747981748;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bwJBwRW2Ylowox9aEo0wHqETsopNhztIeIfYb8XwHg=;
 b=O4AoBDZMInTqRy8G5qs2WFgFLj+6gJoWVpLxEP8Tv6lSFnO72vPRj5akDM2zIrJNfYOiYR
 uiagcxZp6VMMzU+YUzLyahWTyJPzaAeDWDYJnMSlR8lqy5JQEZ56livIcnY1hrkptX5pBp
 6xfrDOf8uTlkh/jTgX4FPA6jRPDPbWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747981748;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bwJBwRW2Ylowox9aEo0wHqETsopNhztIeIfYb8XwHg=;
 b=Eshj1ImDjKsWC/RoYPdUYvnRQWd1tuxN7pWB6p+H5SJaV7v6EVJQK1+AIFU30Psk+PswSr
 rZ+QuYEBG9aS6nAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB50A137B8;
 Fri, 23 May 2025 06:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IVd5KLQVMGjDCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 May 2025 06:29:08 +0000
Date: Fri, 23 May 2025 08:29:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250523062903.GA36946@pevik>
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250522193910.GA28496@pevik>
 <CAASaF6z7r=NTD0ymx=pZhsKfDQ43aSpufb7EkpsCCC3mA2cNSA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6z7r=NTD0ymx=pZhsKfDQ43aSpufb7EkpsCCC3mA2cNSA@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email,suse.cz:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D12A31F385
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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

SGkgSmFuLCBhbGwsCgo+IE9uIFRodSwgTWF5IDIyLCAyMDI1IGF0IDk6MznigK9QTSBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgV2VpLCBhbGwsCgo+ID4gQGFsbDog
aXMgdGhpcyBhIGNhbmRpZGF0ZSBmb3IgYSByZWxlYXNlPyBJdCdkIGJlIG5pY2UgdG8gZ2V0IGl0
IGZpeGVkLgoKPiBJJ2Qgd2FpdCBhZnRlciByZWxlYXNlLCBpdCdzIG5vdCBhIHRyaXZpYWwgY2hh
bmdlIGFuZCBvdGhlciB0aGFuIHN0YXRpYyBhbmFseXNpcwo+IHRoZXJlIGFyZSBubyByZXBvcnRz
IG9mIGl0IGFjdHVhbGx5IGhhcHBlbmluZy4gIEFuZCBpdCBhbHNvIGFsbG93cyBtb3JlIHRpbWUK
PiBmb3IgcmV2aWV3LgoKTWFrZXMgc2Vuc2UuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
