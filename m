Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7BFC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 16:44:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1243D3EB0A8
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 18:44:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 846263EADA7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 18:44:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0FF7D600A5A
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 18:44:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1A9F21EC6;
 Thu,  3 Sep 2026 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788453847;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emkW8ePqGEn93lkIWgCNJqVto98AjlVDKai+iNNPmJk=;
 b=cmoXEzPCcHquVpl+OmLwLHPgfFU+OgqdYQyCt36ncC+uJNGOyt3yyTypzVGfnXKZFXprNx
 o/NJoXAVRGqOpCsZNV9Xfffch0ZKe5dzKQUMG8Y4jGx+UHyKZWyt6gJE9dJwiURYlRlk2a
 Qzl6k4CgrzcgxTJwPxf0aLWKefDYpXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788453847;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emkW8ePqGEn93lkIWgCNJqVto98AjlVDKai+iNNPmJk=;
 b=bzBpInlYryCPnnzRwuapV50LdrYj7dlmY3lg03xy1NkblNd2sbfHt/XHPATrBWrJtq+F5n
 kzdwHFB8qs6wsqAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788453842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emkW8ePqGEn93lkIWgCNJqVto98AjlVDKai+iNNPmJk=;
 b=GRUCoH+YDvRLhKTiX5X0RaPGhZmNkymFBkdskb5lz1nG7SlP7V6quYv+AFaS1PKunx5+dK
 uP8TlZbUpJHW1qShE6F1wMEYdyHFle6fOxMptDTVxWnVUrCW6AmOqKPluwmnATD2h63v2p
 8UysJ5oz1RsEfCwL/e4TmbMoulKAp1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788453842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emkW8ePqGEn93lkIWgCNJqVto98AjlVDKai+iNNPmJk=;
 b=sZK5aFtAFjKNx0k1quNAU1nnFlU85JP3T7x3DjErsXhQW3T5O0S1DlKQUWk7Z+1YKtE1qL
 i7CHFCYZ4bG+ShCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76D6D136D9;
 Thu,  3 Sep 2026 16:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2zWSGtKjmWqBHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 16:44:02 +0000
Date: Thu, 3 Sep 2026 18:43:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903164357.GH1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-20-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-20-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
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
Subject: Re: [LTP] [PATCH v4 19/31] tst_netdevice: Add two more helper macros
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

Hi Cyril,

> +++ b/include/tst_netdevice.h
> @@ -61,6 +61,26 @@ int tst_netdev_remove_address_inet(const char *file, const int lineno,
>  #define NETDEV_REMOVE_ADDRESS_INET(ifname, address) \
>  	tst_netdev_remove_address_inet(__FILE__, __LINE__, 1, (ifname), \
>  		(address))
> +/*
> + * Change the link-layer (MAC) address of an existing network device. Most
> + * drivers require the device to be administratively down for this to
> + * succeed.
> + */
> +int tst_netdev_set_hwaddr(const char *file, const int lineno, int strict,
> +	const char *ifname, const void *addr, size_t addrlen);
> +#define NETDEV_SET_HWADDR(ifname, addr, addrlen) \
> +	tst_netdev_set_hwaddr(__FILE__, __LINE__, 1, (ifname), (addr), \
> +		(addrlen))
> +
> +/*
> + * Enslave ifname to the master_ifname device, e.g. add it as a bridge or bond
> + * port. Pass NULL as master_ifname to release the device from its current
> + * master.
> + */
nit: It'd be nice to have this as kerneldoc, but that can be done after patchset
is merged.

Anyway, I know that most of other functions does not even have a documentation.
Martin did doc/old/C-Test-Network-API.asciidoc which was deleted without a
replacement during transition to the new docs in 4a72aada87 ("New LTP
documentation")

The code itself LGTM. Both functions are similar, but due different parameter
types (void vs char) there is no point trying to unify them.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
