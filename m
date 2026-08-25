Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76656C5B572
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 05:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4D23D0F4D
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 07:04:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F7C73C900A
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:03:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9133B600902
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:03:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB24486A04;
 Tue, 25 Aug 2026 05:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787634223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxB160mdQIPis3kLbNRpvlRsDx9pUd6om7bDakSc8n8=;
 b=UXW0ilr0CIwVnEqoWu3clkB4LsNWYO4GYR98M5I4hmjlD41C17W46sQYc5JjjgyzLYkkfN
 bsDNsTlV9dWnFmV0wqshwB5Hx1NeqBwsAXZB8oo9B9gOJaE7tjSfYbtIxfAl73Ku9dfnjF
 n3C4vyE4a2YHMPuoSajkpuxY6STKIeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787634223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxB160mdQIPis3kLbNRpvlRsDx9pUd6om7bDakSc8n8=;
 b=IcJD9G7+RpF3wVZCuwFaW8O73whT9TeIx7qf7iFonJclBF6uaYc7NAx7mASEg+Id0X8pWx
 abkWR263G/FtunCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787634219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxB160mdQIPis3kLbNRpvlRsDx9pUd6om7bDakSc8n8=;
 b=G2o9ptHZ41GQOz4CNuhMGP/DdivQm4si4zytZk8cRYrUHbV8UwnUjP6SyAwZOC76jJqIG3
 DEOw/aBtmwLUV37iU3ThwhwsGt3YCuwx/oziTOykBYtivSBeHYsK+5kS2yd3xg9rfDSQUG
 54zLhJ0mZQeCWWB9BmdJUoPiP5hJuHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787634219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxB160mdQIPis3kLbNRpvlRsDx9pUd6om7bDakSc8n8=;
 b=e1+g8Eiu6WEC/73lbhVoWJDtVIFG4u0oxUrHJsQdbd0wlV8vKjT+PuM0MlV9S9ZyffPswb
 OmOzwRbf+rgYBUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F76013331;
 Tue, 25 Aug 2026 05:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 74OcJSsijWr9RwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 05:03:39 +0000
Date: Tue, 25 Aug 2026 07:03:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Message-ID: <20260825050334.GC22725@pevik>
References: <20260820072133.2036117-1-cyyang772@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260820072133.2036117-1-cyyang772@andestech.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.978]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: test: check systemd in tst_virt_hyperv() as
 tst_test.sh
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Victor,

> Guard tst_virt_hyperv() in the old shell API with a command lookup, as
> the tst_test.sh version already does. Without systemd installed every
> test calling it printed "systemd-detect-virt: not found" to stderr.

Thanks for your fix, merged.

FYI I send a follow up

https://patchwork.kernel.org/project/ltp/patch/20260825045515.24503-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260825045515.24503-1-pvorel@suse.cz/T/#u

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
