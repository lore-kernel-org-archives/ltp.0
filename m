Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A377CAC5B0
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 11:30:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B45B33CE511
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 13:30:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B33C3CD1C1
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 13:30:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C1F81000A5E
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 13:30:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 902A4338EC;
 Fri,  3 Oct 2025 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759491014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58dHgzn3qB2NRBmEhr/5FyeEW3PWMFXy1VT6EZcQXMQ=;
 b=bZ1XO7o+VV7DwuBqtjjLDUVj1h5h8zj5YkqeDjheNh4ffOW3/hK4020VhQu3SxeC4IcDNC
 ymRUhlR2SRyTCiyhE9kbenHwP19HDk0VhOVJ9eoNH8+sY+XT06iRPaTEtgGM4MS+X+8JJu
 aSdQot+/QEog4jz+uEe/QzvvUa3UdSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759491014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58dHgzn3qB2NRBmEhr/5FyeEW3PWMFXy1VT6EZcQXMQ=;
 b=kXLYk6UzAZZQD44gYfX9LxJfwLeWkmcmwZIs/zc0RdIafVnxLjw9Evhxt95sHiEcPWBn31
 NWqIYuilAaH98FAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759491014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58dHgzn3qB2NRBmEhr/5FyeEW3PWMFXy1VT6EZcQXMQ=;
 b=bZ1XO7o+VV7DwuBqtjjLDUVj1h5h8zj5YkqeDjheNh4ffOW3/hK4020VhQu3SxeC4IcDNC
 ymRUhlR2SRyTCiyhE9kbenHwP19HDk0VhOVJ9eoNH8+sY+XT06iRPaTEtgGM4MS+X+8JJu
 aSdQot+/QEog4jz+uEe/QzvvUa3UdSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759491014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58dHgzn3qB2NRBmEhr/5FyeEW3PWMFXy1VT6EZcQXMQ=;
 b=kXLYk6UzAZZQD44gYfX9LxJfwLeWkmcmwZIs/zc0RdIafVnxLjw9Evhxt95sHiEcPWBn31
 NWqIYuilAaH98FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A77A13990;
 Fri,  3 Oct 2025 11:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qNtOHcaz32gtJAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 03 Oct 2025 11:30:14 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 03 Oct 2025 13:30:14 +0200
Message-ID: <12766432.O9o76ZdvQC@thinkpad>
In-Reply-To: <20251003102516.GA27492@pevik>
References: <20251003101310.13359-1-akumar@suse.de>
 <20251003102516.GA27492@pevik>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; CTE_CASE(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: update invalid clock id to accomodate
 new auxiliary clock ids
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

Hi,

On Friday, October 3, 2025 12:25:16 PM CEST Petr Vorel wrote:
> Hi Avinesh,
> 
> > There can be 8 more clock ids reserved on systems with
> > CONFIG_POSIX_AUX_CLOCK=y [1]
> > consequently clock 17 no longer remains an invalid id.
> 
> Thanks for fixing this! Because we don't have infrastructure to check kconfig in
> open POSIX tests I agree to just bump the value.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> > [1] https://lkml.org/lkml/2025/5/19/341
> 
> nit: FYI I've noticed several times people suggesting to use for links
> lore.kernel.org, see kernel commit 05a5f51ca5666 ("Documentation: Replace
> lkml.org links with lore"):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=05a5f51ca566
> 
> 	Replace the lkml.org links with lore to better use a single source
> 	that's more likely to stay available long-term.
> 
> Therefore link would be:
> 
> [1] https://lore.kernel.org/lkml/20250519083025.905800695@linutronix.de/
> 

Thanks Petr, I will keep this in mind from now on.
And I hope this can be fixed during the merge if patch is good as is.


Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
