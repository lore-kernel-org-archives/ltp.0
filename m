Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559E8C5B567
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 17:39:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B99473D0474
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 19:39:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2889D3CBF46
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:39:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 948BB1A006B9
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:39:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5608980F8A;
 Mon, 10 Aug 2026 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786383570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzzYXj0PcGE/VnonOE7M21V/1agll7kzTNFAaYJ9X3M=;
 b=AqaTTzFAlPuGh62T4dKX9tZk/VF9UYEanCigDcAJej8HmPRpb5xIE+tX3r9QkTAJD5D8kP
 eY1OD9xyri6YYHk57IzZSRo68KtCvAQ6pXJyVSTVDouxNL7kEBI8eMDEaU11mw9DFnbokf
 cjCl4gRr7k/JvLJEw5PwypRu2576AWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786383570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzzYXj0PcGE/VnonOE7M21V/1agll7kzTNFAaYJ9X3M=;
 b=WEZpzcVeALk8vs81jiNMZ35En39p8FnPF+0NTTNrDMLUmrxGZ0mj+BOnAgUjy8U76WnzVL
 kQiaEp62co7od6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786383566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzzYXj0PcGE/VnonOE7M21V/1agll7kzTNFAaYJ9X3M=;
 b=fo0ULzcvNM3tQ19RRabtNhw8MbOmV9NKRFYecVoCH0uhgoXt2G7HbIJuy8F2h0Iqdm+dq5
 dGD/2Yd1nxJZZvnyaCtKiKHIZxF3NMlOEjXG4ra/AAb+zMeeIV0H+++SolK7U2tG08fqur
 dF7rj4ZMOFTUDrGW1Q/PjUa6bNIN3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786383566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzzYXj0PcGE/VnonOE7M21V/1agll7kzTNFAaYJ9X3M=;
 b=EO93LFjRCevFWOcXDyT1K9qDYNui3ttU8+CDk1hvJry7jkMEzxtmP/taQOzifDziVv6VIh
 ecj2MHfPGEYQ3rBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AB3B779B2;
 Mon, 10 Aug 2026 17:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1ZJiB84MemqvCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 17:39:26 +0000
Date: Mon, 10 Aug 2026 19:39:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260810173920.GE1049677@pevik>
References: <20260810-sctphantom-v1-0-f8e9ee72a648@suse.com>
 <20260810-sctphantom-v1-1-f8e9ee72a648@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810-sctphantom-v1-1-f8e9ee72a648@suse.com>
X-Spamd-Result: default: False [-3.49 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.19)[-0.972]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] sctp: add lapi fallback definitions
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi: Andrea,

> +/* SCTP wire format values, see include/linux/sctp.h in the kernel */
+1 for that comment.

> +#ifndef SCTP_CID_INIT
> +# define SCTP_CID_INIT		1
> +#endif
> +
> +#ifndef SCTP_CID_INIT_ACK
> +# define SCTP_CID_INIT_ACK	2
> +#endif
> +
> +#ifndef SCTP_CID_ASCONF_ACK
> +# define SCTP_CID_ASCONF_ACK	0x80
> +#endif
> +
> +#ifndef SCTP_CID_ASCONF
> +# define SCTP_CID_ASCONF		0xc1
> +#endif
> +
> +#ifndef SCTP_PARAM_IPV4_ADDRESS
> +# define SCTP_PARAM_IPV4_ADDRESS	5
> +#endif
> +
> +#ifndef SCTP_PARAM_DEL_IP
> +# define SCTP_PARAM_DEL_IP	0xc002
> +#endif
> +
> +#ifndef SCTP_PARAM_ERR_CAUSE
> +# define SCTP_PARAM_ERR_CAUSE	0xc003
I hope cpu_to_be16(0xc003) is really on all supported archs 0xc003 :).

Anyway, the rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
