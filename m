Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD46FE51F7
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:02:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20993E2D71
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:02:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BEEF3CBC10
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:01:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CDFCA200AEE
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:01:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 156936A8A2;
 Fri, 24 Apr 2026 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777024903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFgWOcgfxyp1QN/MuxN5nKs2blboHivg08JwPmui+xI=;
 b=SO898kIDEAEuIF7hg5n+axaK6HpShlRLttmOZfJ/0ay8K+kSn+MXXKchIfiNH9jJO96RB4
 eD7tHj5FJHUkE8eflMe46+BYb66ho/V2UdyWfr5fvxCJHBLJS+ckUI8j0M2fsZNiofvw2y
 lJ+Z2232bTtos4JkJZmpOx35Gowj3pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777024903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFgWOcgfxyp1QN/MuxN5nKs2blboHivg08JwPmui+xI=;
 b=+6Ba4V9y7g3ciPx1x/Yrhm/BrFxJ78eKEoqS4kh7OKUVjvQ+TJsYZaxaOw0oHT3SEHcyjF
 IwpHcC8NM1X/NJBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777024903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFgWOcgfxyp1QN/MuxN5nKs2blboHivg08JwPmui+xI=;
 b=SO898kIDEAEuIF7hg5n+axaK6HpShlRLttmOZfJ/0ay8K+kSn+MXXKchIfiNH9jJO96RB4
 eD7tHj5FJHUkE8eflMe46+BYb66ho/V2UdyWfr5fvxCJHBLJS+ckUI8j0M2fsZNiofvw2y
 lJ+Z2232bTtos4JkJZmpOx35Gowj3pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777024903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFgWOcgfxyp1QN/MuxN5nKs2blboHivg08JwPmui+xI=;
 b=+6Ba4V9y7g3ciPx1x/Yrhm/BrFxJ78eKEoqS4kh7OKUVjvQ+TJsYZaxaOw0oHT3SEHcyjF
 IwpHcC8NM1X/NJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD9CA593A4;
 Fri, 24 Apr 2026 10:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fqw4MIY/62kXZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 10:01:42 +0000
Date: Fri, 24 Apr 2026 12:01:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260424100133.GB500158@pevik>
References: <20260424060543.462475-1-pvorel@suse.cz>
 <20260424080912.4039-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424080912.4039-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ioctl_pidfd06: Update kernel version
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

> Hi Petr,

> On 2026-04-24, Petr Vorel wrote:
> > ioctl_pidfd06: Update kernel version

> > -	if (tst_kvercmp(7, 0, 0) >= 0)
> > +	if (tst_kvercmp(6, 18, 14) >= 0)
> >  		err_nr = EREMOTE;

> tst_kvercmp(6, 18, 14) >= 0 is too broad: because tst_kvercmp compares
> (major, minor, patch) as ordered integers, it evaluates true for all
> v6.19.x, including v6.19.0-v6.19.9 which do not carry the backport
> (which landed in v6.19.10). Those kernels would see a false EREMOTE
> expectation and TFAIL.

> The check needs to handle both stable branches independently, e.g.:

> 	if (tst_kvercmp(7, 0, 0) >= 0 ||
> 	    (tst_kvercmp(6, 18, 14) >= 0 && tst_kvercmp(6, 19, 0) < 0) ||
> 	    tst_kvercmp(6, 19, 10) >= 0)
> 		err_nr = EREMOTE;

Obviously tst_kvercmp(6, 19, 10) >= 0 will match also tst_kvercmp(7, 0, 0) >= 0,
therefore "tst_kvercmp(7, 0, 0) >= 0" is not needed.

Kind regards,
Petr

> Also, since this corrects a bug (TFAIL on kernels with the backport),
> please add a Fixes: tag referencing the commit that introduced the
> original tst_kvercmp(7, 0, 0) check.

Do we want to add Fixes when original commit was correct?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
