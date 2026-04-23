Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FFF9937C
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:48:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BEA43E28E1
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 13:48:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F2673E1D62
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 13:47:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0B3B31000994
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 13:47:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FB676A86B;
 Thu, 23 Apr 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776944861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWfM3YusiDsE79CYxvFaXx96JM9PAc4sOqjM973uYhg=;
 b=j5e74vI1MZV79SsN7Rs8TwkIvTyqvgwX0c0mzhYv+8y31SgJj17Qme70ZexMdTI5sbPu5N
 fF7RJwwtGohN8Eb/HnDc45vmi8Q+o8ev4DXwh/emXNezseDgobSWnfGm8Pi02tVPb8vlvr
 C5r9ciDP5x8YpbhaEcGhU9ffH0t3ewg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776944861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWfM3YusiDsE79CYxvFaXx96JM9PAc4sOqjM973uYhg=;
 b=ULnKwJ/8dovDkocwd0ve7iTZn7kx9pEyDoG5vrs0+gVVZncvPFcJA1nk91ZMpy4nwd5yIS
 +Wnmr0txxup8YVAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j5e74vI1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ULnKwJ/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776944861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWfM3YusiDsE79CYxvFaXx96JM9PAc4sOqjM973uYhg=;
 b=j5e74vI1MZV79SsN7Rs8TwkIvTyqvgwX0c0mzhYv+8y31SgJj17Qme70ZexMdTI5sbPu5N
 fF7RJwwtGohN8Eb/HnDc45vmi8Q+o8ev4DXwh/emXNezseDgobSWnfGm8Pi02tVPb8vlvr
 C5r9ciDP5x8YpbhaEcGhU9ffH0t3ewg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776944861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWfM3YusiDsE79CYxvFaXx96JM9PAc4sOqjM973uYhg=;
 b=ULnKwJ/8dovDkocwd0ve7iTZn7kx9pEyDoG5vrs0+gVVZncvPFcJA1nk91ZMpy4nwd5yIS
 +Wnmr0txxup8YVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 383A5593A3;
 Thu, 23 Apr 2026 11:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wpbPDN0G6mkwQgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 23 Apr 2026 11:47:41 +0000
Date: Thu, 23 Apr 2026 13:47:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aeoG7byDpoWGmoYB@yuki.lan>
References: <20260423095834.11932-2-chrubis@suse.cz>
 <20260423111755.4154-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260423111755.4154-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4FB676A86B
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_create03
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
> > +	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
> > +	SAFE_CLOSE(fds[1]);
> > +	SAFE_CLOSE(fds[0]);
> > +	SAFE_CLOSE(efd);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fds[1] > 0)
> > +		SAFE_CLOSE(fds[1]);
> 
> fds[] and efd are closed in run() but not reset to -1;

We already have "No manual reset after SAFE_CLOSE" in the c-agent.md but
I guess that the LLM didn't infer from that rule that the fd is set to
-1 by SAFE_CLOSE().

I've send a pull with more explicit description for how cleanup()
handler should be written:

https://github.com/linux-test-project/ltp-agent/pull/6

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
