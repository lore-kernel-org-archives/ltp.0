Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AA3C982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 09:50:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D08A3E747C
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 11:50:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D92BA3E7354
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 11:50:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 646891400E1F
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 11:50:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6740B21BBA;
 Fri, 18 Sep 2026 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789725005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WaLPj14ggNGJRRDCOKSrO5DFGo2pzxo/D3EMBW3XD0=;
 b=iMW6cSEMzqmsvIVQ1C1hwSD2Kq4PVZG+49GV9LYHaUSFYwd3+uxewcP1KQHYp54l9Q8z84
 3pPQWc4kQ3g2c7kLUAOIzN/zIH84kdJ/WgI2IxSuvUMyJApQZQYSiGAea65QtL1/TqHSst
 u+cAB/QOGwEXiJOiaGSl/FZHuhhwst8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789725005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WaLPj14ggNGJRRDCOKSrO5DFGo2pzxo/D3EMBW3XD0=;
 b=Vf8NHK/tsfdrlLU11lYBlhEpUXQ2IwPJ31UR7zWkoEewxQB3b622jwHXgHm0crP2/EWlo+
 +eZQMMPFej1h7oDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NFX12MOd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WYMaJG2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789725001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WaLPj14ggNGJRRDCOKSrO5DFGo2pzxo/D3EMBW3XD0=;
 b=NFX12MOdGSeYTfoiJkwKLbiMwE1ersQjJ1b1fcdcoZpQbzxDeNHL20N8q7B0A+wLN/RfVZ
 FrofSqO148rYrQg3Xqt+Zu1QUlsl99D5wCE/E4JUbPbIqBw8nvXo0QMSfTlm5s5IouwcNM
 quC7qTkSnIrDFxZA/xOQ0a7WDMeYsyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789725001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WaLPj14ggNGJRRDCOKSrO5DFGo2pzxo/D3EMBW3XD0=;
 b=WYMaJG2oZZobZ8U3uJQJ/k/MpYu5j11zviE9vaPRsESLF5Xko0GllLZq5dz7nKt9IfsOQ3
 KqQrX45QGOdt8aAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3893C133CF;
 Fri, 18 Sep 2026 09:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YcHYA0kJrWphTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 09:50:01 +0000
Date: Fri, 18 Sep 2026 11:50:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aq0JVHj3Y0k2_aJ9@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-10-pvorel@suse.cz>
 <aququIx31-BBNlnq@linux.dev> <aqvUDzAjzoEibVXu@yuki.lan>
 <aqzFnANKxWCFLRe5@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqzFnANKxWCFLRe5@linux.dev>
X-Rspamd-Queue-Id: 6740B21BBA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/36] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > 	if (rc == 0) {
> > 		tst_res(TFAIL, "empty security label not NUL terminated");
> > 		return;
> > 	}
> > 
> > 	if (rc > sizeof(buf)) {
> > 		tst_res(TFAIL, "buffer too small");
> > 		return;
> > 	}
> 
> My only concern is whether the TFAIL is correct when truncation
> occurs. Shouldn't the test allocate a larger buffer instead?

Well we can always allocate large enough buffer in the test setup.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
