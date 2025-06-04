Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F74C5B552
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 07:34:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4DF3CA0D7
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 09:34:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613603C9DB9
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:34:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28C161A00928
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:34:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B526E21C53;
 Wed,  4 Jun 2025 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749022474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIU3ifsN/wOt+JCSgsIIsN4hMhPPYVfg2Hh6kV+6Zfo=;
 b=uD/nNK5criSOb7Y6ud4P0kPw+QlQR3tGiGuWlG9HZXOcnTzs426rj3F/uqHYCAb4CrLcxx
 /3aD/cYiC1rcTBOjdEkytilkcsQBy/XjQ+sX75jZEvhA2eKMeyyV6a4xZqIiorvGg2J5AJ
 DbizaDslKLIQo9izY++EZBClH5hpIe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749022474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIU3ifsN/wOt+JCSgsIIsN4hMhPPYVfg2Hh6kV+6Zfo=;
 b=lunVm/m/huAuYofB2F8+4rTVYx7xgfwBvPGQaONzAAA9XkG8eO7l1y6eOvz0BYVi7nZ0/p
 ikh2I1YpCq+y1MBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749022474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIU3ifsN/wOt+JCSgsIIsN4hMhPPYVfg2Hh6kV+6Zfo=;
 b=uD/nNK5criSOb7Y6ud4P0kPw+QlQR3tGiGuWlG9HZXOcnTzs426rj3F/uqHYCAb4CrLcxx
 /3aD/cYiC1rcTBOjdEkytilkcsQBy/XjQ+sX75jZEvhA2eKMeyyV6a4xZqIiorvGg2J5AJ
 DbizaDslKLIQo9izY++EZBClH5hpIe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749022474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIU3ifsN/wOt+JCSgsIIsN4hMhPPYVfg2Hh6kV+6Zfo=;
 b=lunVm/m/huAuYofB2F8+4rTVYx7xgfwBvPGQaONzAAA9XkG8eO7l1y6eOvz0BYVi7nZ0/p
 ikh2I1YpCq+y1MBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65AFF1369A;
 Wed,  4 Jun 2025 07:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5ZOZFAr3P2hmaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Jun 2025 07:34:34 +0000
Date: Wed, 4 Jun 2025 09:34:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250604073429.GC1094733@pevik>
References: <20250603152253.214656-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250603152253.214656-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] epoll_pwait2() timeout regression test
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

Hi Martin,

> There seems to be a regression in kernel v6.14 where epoll_pwait2()
> interprets very small timeout values (~1000ns) as infinity and waits
> for events forever. This patchset adds regression test for this bug
> and a necessary refactor for do_epoll_pwait() to allow high precision
> timeouts.

Good catch! BTW it looks to me 0a65bc27bd64 is from v6.15-rc3 (e.g. 6.15
development cycle), but it was backported to 6.14 stable as 99a0ad16dfd11
to v6.14.4. Obviously fixing commit d9ec73301099 has also been backported
(to v6.14.8).

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
