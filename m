Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8769EC44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 08:31:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89283E55EC
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:31:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A452E3C73A9
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:31:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A48C1000761
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:30:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 905AC7887E;
 Thu, 16 Jul 2026 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784190658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lt55TKR1uvtA2iesUPvumbmTkvQbM6AtMH/BD2xGzS4=;
 b=tKH76hv/OgQ9KXPVTAazMMMcW/rxzRsOf5i3PC+QNNsmA6olXOGmLFtQ7flJ6GanPDF3+P
 2RRmSae5hvBZicuNvO0ERzVAnSUXXtsSvpjV5qgNXGf9NDKKs9cXl1EkgczMCUXpGhnGT9
 FJAoMesRN8Gf7TTmbhMNLkNmss2JqBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784190658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lt55TKR1uvtA2iesUPvumbmTkvQbM6AtMH/BD2xGzS4=;
 b=20Ca4PPp1ywMQjuTeG7xpg6napy+NAJfnvX25LDugRrjGqleEVGrh550q+x1DoY3Pcf++9
 yrp0+UGKwPvFtYAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784190657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lt55TKR1uvtA2iesUPvumbmTkvQbM6AtMH/BD2xGzS4=;
 b=mAKi8JbYwLL0RXvmbEWwiOkFTpY76wrXGkVKn6eMU/jQ+ek8Jj4pHfX3RkzWiQ7vAHtKT8
 AULiIWwJYxdGDGLZwOMwfn2r2rCn7PXCflCiRKhBjU4oPeEDNcxfa2P6HIc3GlUmqJELlr
 erVfiWmpolZRmDsOpJYg42wggO+fPsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784190657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lt55TKR1uvtA2iesUPvumbmTkvQbM6AtMH/BD2xGzS4=;
 b=28FII6P3JCKNga3CEt21kzpNyt9Kz4Zy3cnzBMYXuewIdi7NpUUepEBNGkmKrjJv0laDGu
 tMzB6gmTxl8kkhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D783779AD;
 Thu, 16 Jul 2026 08:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m786HMGWWGqrWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jul 2026 08:30:57 +0000
Date: Thu, 16 Jul 2026 10:30:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aliWtSpjgAR_OY51@yuki.lan>
References: <20260714-cve-2026-46331-v5-1-bab4ac23c1f7@suse.com>
 <20260714105346.3883-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260714105346.3883-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_cls.h fallback
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
> > +/*
> > + * Same as NETDEV_REMOVE_QDISC() but does not fail when the qdisc is
> > + * missing (strict=0), so it can be used to clear a possibly absent qdisc.
> > + */
> > +#define NETDEV_MAY_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
> 
> New public macros in include/ require kernel-doc (/** */), not a plain
> block comment. The content is fine; it just needs the right opener:
> 
>   /**
>    * NETDEV_MAY_REMOVE_QDISC - remove qdisc without failing if absent.
>    * @ifname: network interface name
>    * @family: address family
>    * @parent: parent handle
>    * @handle: qdisc handle
>    * @qd_kind: qdisc kind string
>    *
>    * Same as NETDEV_REMOVE_QDISC() but passes strict=0, so it does not
>    * fail when the qdisc is missing.
>    */

Looks reasonable. It may be a good idea to copy&paste this to the header
before applying the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
