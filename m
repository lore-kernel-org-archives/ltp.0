Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81B6C4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 18:26:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272BA3D03D7
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 20:26:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19F233D037F
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 20:26:04 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31B691401110
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 20:26:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60F6435136;
 Fri, 26 Apr 2024 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714155963;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bsWqMK0PEkKU+FJKEVEvunhIXqesc1y8D69LXvqC7s=;
 b=l9Fz8gfybs2nhi71iR+lvzf4Zf/dz8dh3feT5ZQonmT9yPNZ+0xubm3qo+vH2PfoJlEHeT
 BpUzLDfjNcTKCRHbcKCnsL886249w3GjiS7R7m+cfzNPIHkZcdJXwB7OT88Bu2g2Po29yN
 yIyQuAqCmMapfLxmTonbktayfHCb3t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714155963;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bsWqMK0PEkKU+FJKEVEvunhIXqesc1y8D69LXvqC7s=;
 b=nib5IErQa2ZOQpzE3r4i/3oKMLfXTnTIH54eNCqZw5XqeEmJJgb7DtTqb/HjYOSPeUg9fr
 4kNukKeFnAD69EDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714155963;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bsWqMK0PEkKU+FJKEVEvunhIXqesc1y8D69LXvqC7s=;
 b=l9Fz8gfybs2nhi71iR+lvzf4Zf/dz8dh3feT5ZQonmT9yPNZ+0xubm3qo+vH2PfoJlEHeT
 BpUzLDfjNcTKCRHbcKCnsL886249w3GjiS7R7m+cfzNPIHkZcdJXwB7OT88Bu2g2Po29yN
 yIyQuAqCmMapfLxmTonbktayfHCb3t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714155963;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bsWqMK0PEkKU+FJKEVEvunhIXqesc1y8D69LXvqC7s=;
 b=nib5IErQa2ZOQpzE3r4i/3oKMLfXTnTIH54eNCqZw5XqeEmJJgb7DtTqb/HjYOSPeUg9fr
 4kNukKeFnAD69EDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26DBE136DB;
 Fri, 26 Apr 2024 18:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8d+qBrvxK2YnLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Apr 2024 18:26:03 +0000
Date: Fri, 26 Apr 2024 20:25:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240426182557.GD6871@pevik>
References: <20240426042851.333269-1-pvorel@suse.cz>
 <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
 <CAEemH2dzzZp5kMF5cQPQQ=Z-Eb55JkEtqvh2E8UOt6UOE7gr7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dzzZp5kMF5cQPQQ=Z-Eb55JkEtqvh2E8UOt6UOE7gr7w@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
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

Hi Li,

> > >   /**
> > > - * Macro to create minimal swapfile.
> > > + * MAKE_SMALL_SWAPFILE - create small swap file.
> > > + *
> > > + * Macro to create small small swap file. Size defined with
> > MINIMAL_SWAP_SIZE_MB.
> > "small small" sounds weird. Maybe "really small"


> +1 I guess that might be one typo.

> Otherwise looks good to me, thanks!

Thanks a lot for catching these (on 2 places, diff below). I'm travelling for a
few days, thus I'll leave it for others to see before merge.

Kind regards,
Petr

+++ include/libswap.h
@@ -30,7 +30,7 @@ int make_swapfile(const char *file, const int lineno,
 /**
  * MAKE_SMALL_SWAPFILE - create small swap file.
  *
- * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
+ * Macro to create small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
  *
  * @swapfile: swap filename.
  */
@@ -41,7 +41,7 @@ int make_swapfile(const char *file, const int lineno,
 /**
  * SAFE_MAKE_SMALL_SWAPFILE - create small swap file (safe version).
  *
- * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
+ * Macro to create small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
  * Includes safety checks to handle potential errors.
  *
  * @swapfile: swap filename.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
