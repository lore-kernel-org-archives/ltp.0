Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C0D6DDEF
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 10:37:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D59B23D7607
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 11:37:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C1793D75A7
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 11:37:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85BD963D164
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 11:37:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3FAD2128C;
 Fri, 15 Nov 2024 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731667058;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nz/3aRwNpYgHnBEPYSHRNwK/0dZ6Nq8IdNJtIc+tq4=;
 b=fJrQIt8dYKZ1mUPwkP+AajJnO30us06D7GA+Z9YiZ8l4kavnUq+59E6vjMXhHVoQF2oeqf
 0oWDqEsqCeaoqM1XmN5Itjmc8d7Om999Bdwn/dgDWM+93mb/d4sILyBdpAUMIwjehnnuii
 ntBlCmPEZXBwF++YYoyI5LS2fDEQasc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731667058;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nz/3aRwNpYgHnBEPYSHRNwK/0dZ6Nq8IdNJtIc+tq4=;
 b=Ln7OoRHAF5X4Fr3uM7E5BMHt8/x52al51Cu50sXli5Dryzkm5mMbHQ/OWnEZC3l7i0f1/K
 0wHE2qImimbuI9Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731667057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nz/3aRwNpYgHnBEPYSHRNwK/0dZ6Nq8IdNJtIc+tq4=;
 b=JTJPJxRbMJU5WWobUKMWXPjziBjR7+qELwczo9tKt1Nqbysel1blLWZlGD3l42hEiV3bbR
 0X6u72VA2vKefRAvDKf59AYu5F8DjuNcCDxGgHbZFL6P9+1eDKmADByTM6fKXc+GWgBKSd
 WefAjrgKqXJcaUdrTLC6nwgfrKEAkz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731667057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nz/3aRwNpYgHnBEPYSHRNwK/0dZ6Nq8IdNJtIc+tq4=;
 b=mpAadHvtwjZ3gKq8HGDR6ArQVpAr6M8dZM361RuNEcDD5vD80uOg8z4H5o2C70Z7MetVft
 gwAOtUzj2zoNxDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9123813485;
 Fri, 15 Nov 2024 10:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nstsInEkN2cYWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Nov 2024 10:37:37 +0000
Date: Fri, 15 Nov 2024 11:37:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241115103736.GA1718754@pevik>
References: <20241114172911.362197-1-pvorel@suse.cz> <Zzb9XKvIe9D6Mcn3@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zzb9XKvIe9D6Mcn3@wegao>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl01: Workaround segfault on ppc64le
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

> On Thu, Nov 14, 2024 at 06:29:11PM +0100, Petr Vorel wrote:
> > Testing termio/termios invalid/NULL address for EFAULT fails on ppc64le.
> > Use typical LTP workaround to test by forked child + checking the
> > terminating signal (on all archs).
> Very nit:
> The title is "[PATCH 1/1] ioctl01: Workaround segfault on ppc64le" but 
> your code is create workaround for all archs, so maybe update some words?

Thanks! I guess I should change it before merge to:

"ioctl01: Workaround segfault on EFAULT tests"

And note later in the message that the problem is only on ppc64le.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
