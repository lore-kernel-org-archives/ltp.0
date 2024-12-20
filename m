Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5902E7718A
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 08:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 661363E5E0D
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 09:02:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F0123E288E
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 09:02:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 914D11BC09AA
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 09:02:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C90E521119;
 Fri, 20 Dec 2024 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734681723;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmn+y+sx7DW0LFsZhl/sbw/7RiVZ7ct1CezC+RAzaFc=;
 b=O6Ui8TCACBqyY1QU7KP+Y0BlCgW+rj9bpJRV41nGoDD8INFa4/Y1z2u3qqSlCnzos4jLJi
 siTKaVpNKG07So0TM2y/gvL5MKR0faGJMLAdnUT9UKKJfdX8RRBUSL3xRca6o2OrYZelSJ
 GxMfHaYi+kGYwDP7NLg+5Xhg+/LHr1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734681723;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmn+y+sx7DW0LFsZhl/sbw/7RiVZ7ct1CezC+RAzaFc=;
 b=roFuhylj5cIVWP6MCRtno3wmpVX+ZrPyiL//qeKn8LVLFGys4F9WmRYye5EKJD40wlMM37
 c7pqr9Tnopl9tUDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BueLpLW+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=txQLyxhV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734681722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmn+y+sx7DW0LFsZhl/sbw/7RiVZ7ct1CezC+RAzaFc=;
 b=BueLpLW+ThK3EVHoyzU05w/rwRojdWYc5W9V5quUre8tWZbPOtK6Icr38/kjh9qtvj/FMc
 VRKaIXleVR+RGbdwmzjzF4E6LKX9l6y5gIm7UhVCGn3m8sBaels21gYUoMfdRfbFFr0sK4
 YvtmlKU0lastR12t2PfpqkzVzvMbi3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734681722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmn+y+sx7DW0LFsZhl/sbw/7RiVZ7ct1CezC+RAzaFc=;
 b=txQLyxhVys0iQsHwUQOuNU6ZGJzAPH1p2MI5sWxdjmYPN7Q6CUu3l1fxd636SOF6AQOUFM
 b4431crG3LjOd7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABCAC13A63;
 Fri, 20 Dec 2024 08:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qsiKKHokZWfmXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 20 Dec 2024 08:02:02 +0000
Date: Fri, 20 Dec 2024 09:02:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241220080200.GA126983@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-3-chrubis@suse.cz>
 <20241219143146.GE115746@pevik> <Z2Q2B07ID-SQGx-s@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z2Q2B07ID-SQGx-s@yuki.lan>
X-Rspamd-Queue-Id: C90E521119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/13] lib: Replace path_exist() with
 tst_path_exists()
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

> Hi!
> > > diff --git a/include/tst_fs.h b/include/tst_fs.h
> > > index 835f3511c..f6ac6a40d 100644
> > > --- a/include/tst_fs.h
> > > +++ b/include/tst_fs.h
> > > @@ -145,6 +145,16 @@ int tst_dir_is_empty_(void (*cleanup)(void), const char *name, int verbose);
> > >   */
> > >  int tst_get_path(const char *prog_name, char *buf, size_t buf_len);

> > > +/**
> > > + * tst_path_exists()
> > nit: any short desc?

> I kind of do not like repeating the same sentence we have in the return description here.

Sure. It triggers warning:

[kernel-doc WARN] : missing initial short description of 'tst_path_exists'

I'll just ignore them (some warning mean wrong docs, this one is innocent,
also we have 145x warnings about duplicate label, thus it's not easy to see if
newly added source has proper syntax or not).

> > > + *
> > > + * @param fmt A printf-like format used to construct the path.
> > > + * @param ... A printf-like parameter list.
> > > + * @return Non-zero if path exists, zero otherwise.
> > > + */

> > Thanks for taking care of the docs. I guess this is doxygen syntax right?
> > Could you please before merge fix doc syntax - use kernel doc formatting? (no
> > param, return: and add short desc for the function).

> Sigh, yes. Will fix.

Thanks (this mean missing docs).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
