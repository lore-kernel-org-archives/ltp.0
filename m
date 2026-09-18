Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6340C982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:37:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07C593E76A8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:37:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0AE63C2E57
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:37:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88061600294
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:37:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 361FF21A65;
 Fri, 18 Sep 2026 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789745850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EizjkGa7MG5R9YUt/dV2YVNFkQGj/UNaVGuO2tjjHDs=;
 b=wWrYm3b9fqiJ2S1d2EFzHEyophpMVx6zy431cYBe9NNaT+IaWCuETBdRge+Oeinn5qgppu
 5vb0uhEIJ5L8esc2ExGx+np6a5s0ZaVNf6RUqtq83IyoDhGgScteW4V9MgRZQl8siwH5JV
 PNO325gWytuHEkGlonP5wzRwQfmY+lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789745850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EizjkGa7MG5R9YUt/dV2YVNFkQGj/UNaVGuO2tjjHDs=;
 b=pWkJPdxxfhGR2PkCsUe2G1pnrg4N8kNeK6CzkI/8j9B3mLIl4k2bMLDrViHc/wWOJExpwz
 Z0peTC2xp0YzRlCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ouyXVmU7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RrL94fHC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789745846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EizjkGa7MG5R9YUt/dV2YVNFkQGj/UNaVGuO2tjjHDs=;
 b=ouyXVmU7kydaL0MzHIoGNDyh+c23FcgnkugaJTBWCTmBwXW8DkrGytckTri34taxwnL7qJ
 IOApvOkB1GAiXAjMcbFJQFcOYVrFt5ch/96NzX92vdNdLTtu6ZwC1/TYme089xYi00SQdj
 sRnurLzwDtig2fYuxF2DTIJ4IDkzalw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789745846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EizjkGa7MG5R9YUt/dV2YVNFkQGj/UNaVGuO2tjjHDs=;
 b=RrL94fHC14cfeDdj0pYD6vX+Y9qB4IbAvlL5uNqvjeu51gDSMdHWSqnC6+h78YYbgltYh8
 Id2e7OmdDKrxinDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01E2F133CF;
 Fri, 18 Sep 2026 15:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YkM1NLVarWrNRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 15:37:26 +0000
Date: Fri, 18 Sep 2026 17:37:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq1awcmI_il0dXAL@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-33-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-33-pvorel@suse.cz>
X-Rspamd-Queue-Id: 361FF21A65
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 32/36] keyctl35: Test KEYCTL_CAPABILITIES size
 query
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void run(void)
> +{
> +	int size;
> +
> +	size = SAFE_KEYCTL(KEYCTL_CAPABILITIES, (unsigned long)NULL, 0, 0, 0);
> +
> +	if (size < 2) {
> +		tst_res(TFAIL, "KEYCTL_CAPABILITIES size query returned %d, expected >= 2",
> +			size);
> +		return;
> +	}

Other tests have this initial size init in setup().

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
