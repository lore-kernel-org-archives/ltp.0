Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1068CC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 18:29:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C7503D038C
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 20:29:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27BB93D038B
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 20:28:57 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 852F61402E23
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 20:28:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 950725BE7B;
 Fri, 26 Apr 2024 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714156135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ZtVOlS4QZpa8uWVyfe5prZXsyxiu8HXfqtTWqMiS18=;
 b=YmsZseVRWJsVGEhxKjx8bfTbxlJUGDdUvjZL/Tc8xk1RMw8PoiAJrTZ7jBn5BU6UxharJL
 S9o5EBPEde7l5Yaj5cUF4lZy8/lDVEOzSv9djptXxquhcoa4uFjXfSotIigC+9E+l7UyBS
 lqaaRvx1g1wDrmNnDjQ8+pZJTePj0fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714156135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ZtVOlS4QZpa8uWVyfe5prZXsyxiu8HXfqtTWqMiS18=;
 b=O/wHfyKyNSBZ8GO/nkSbXR0AdTb5NrfcBklAJRVkvXvrbx1tc/c3YgOxGSo9mHbckjbu67
 NxsgQ0HUpuXqjTBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714156135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ZtVOlS4QZpa8uWVyfe5prZXsyxiu8HXfqtTWqMiS18=;
 b=YmsZseVRWJsVGEhxKjx8bfTbxlJUGDdUvjZL/Tc8xk1RMw8PoiAJrTZ7jBn5BU6UxharJL
 S9o5EBPEde7l5Yaj5cUF4lZy8/lDVEOzSv9djptXxquhcoa4uFjXfSotIigC+9E+l7UyBS
 lqaaRvx1g1wDrmNnDjQ8+pZJTePj0fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714156135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ZtVOlS4QZpa8uWVyfe5prZXsyxiu8HXfqtTWqMiS18=;
 b=O/wHfyKyNSBZ8GO/nkSbXR0AdTb5NrfcBklAJRVkvXvrbx1tc/c3YgOxGSo9mHbckjbu67
 NxsgQ0HUpuXqjTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57807136DB;
 Fri, 26 Apr 2024 18:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PmyQEmfyK2bYLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Apr 2024 18:28:55 +0000
Date: Fri, 26 Apr 2024 20:28:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240426182853.GE6871@pevik>
References: <20240426042851.333269-1-pvorel@suse.cz>
 <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: libltpswap: Add kerneldoc
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

Hi Andrea,

> > - * Macro to create minimal swapfile.
> > + * MAKE_SMALL_SWAPFILE - create small swap file.
> > + *
> > + * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
> "small small" sounds weird. Maybe "really small"

+1, my typo, thanks!

> > + *
> > + * @swapfile: swap filename.
> >    */
> >   #define MAKE_SMALL_SWAPFILE(swapfile) \
> >       make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 0, \
> >   		  SWAPFILE_BY_SIZE)
> >   /**
> > - * Macro to create minimal swapfile.
> > + * SAFE_MAKE_SMALL_SWAPFILE - create small swap file (safe version).
> > + *
> > + * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
> >    * Includes safety checks to handle potential errors.
> Same here
Yeah.

BTW we need to have CI job which tries to generate our docs with sphinx.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
