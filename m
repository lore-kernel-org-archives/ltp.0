Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761E0CAC5B0
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 12:27:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC4B03C0131
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 14:27:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47F9D3CD426
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 14:27:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A90906006D5
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 14:27:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1C391F45E;
 Fri,  3 Oct 2025 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759494422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXFtehKls0zAuRaQGp30idpSa85Fc1WPg//36CgCOoY=;
 b=oRu5P8WuXlt0AA7rKLB9k8gxzTHCYa5N+R7rciux+MuiXk92hiVFzADCZRp7Duj4Oe7FDH
 sc/ZqYXZe7O/3tm0BGJReeQ/C/spZLe7szocpN9CMONbMW3ZoGxRl+IAWw4udUsgNzQ/0e
 R1TchZxJtL05BKqTA5ysZLq9ndUO3EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759494422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXFtehKls0zAuRaQGp30idpSa85Fc1WPg//36CgCOoY=;
 b=i/gB6Iov5WUAYJk9RACHSZGiAwV58Z7zzcaVksuLXq9bnHSQoyI5d17KQ8wE3m0n48FhM/
 H9uhuwqvbm04NSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759494422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXFtehKls0zAuRaQGp30idpSa85Fc1WPg//36CgCOoY=;
 b=oRu5P8WuXlt0AA7rKLB9k8gxzTHCYa5N+R7rciux+MuiXk92hiVFzADCZRp7Duj4Oe7FDH
 sc/ZqYXZe7O/3tm0BGJReeQ/C/spZLe7szocpN9CMONbMW3ZoGxRl+IAWw4udUsgNzQ/0e
 R1TchZxJtL05BKqTA5ysZLq9ndUO3EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759494422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXFtehKls0zAuRaQGp30idpSa85Fc1WPg//36CgCOoY=;
 b=i/gB6Iov5WUAYJk9RACHSZGiAwV58Z7zzcaVksuLXq9bnHSQoyI5d17KQ8wE3m0n48FhM/
 H9uhuwqvbm04NSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84C3413AAD;
 Fri,  3 Oct 2025 12:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ngzcHRbB32jcMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Oct 2025 12:27:02 +0000
Date: Fri, 3 Oct 2025 14:26:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20251003122657.GA35007@pevik>
References: <20251003101310.13359-1-akumar@suse.de>
 <20251003102516.GA27492@pevik> <12766432.O9o76ZdvQC@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12766432.O9o76ZdvQC@thinkpad>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,lkml.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,
...
> > > [1] https://lkml.org/lkml/2025/5/19/341

> > nit: FYI I've noticed several times people suggesting to use for links
> > lore.kernel.org, see kernel commit 05a5f51ca5666 ("Documentation: Replace
> > lkml.org links with lore"):

> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=05a5f51ca566

> > 	Replace the lkml.org links with lore to better use a single source
> > 	that's more likely to stay available long-term.

> > Therefore link would be:

> > [1] https://lore.kernel.org/lkml/20250519083025.905800695@linutronix.de/


> Thanks Petr, I will keep this in mind from now on.
> And I hope this can be fixed during the merge if patch is good as is.

Sure, of course. The code is what matters :).

Kind regards,
Petr

> Regards,
> Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
