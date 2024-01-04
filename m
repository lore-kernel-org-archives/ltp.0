Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBA8C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 15:29:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A0BF3CE718
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 16:29:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D32923CC002
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 16:29:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F7806007A0
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 16:29:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5179A21FBD;
 Thu,  4 Jan 2024 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704382162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZV9vYZJc7A9RsAi0fRQ0u7QoAQRtiQYENIL7se3bOQc=;
 b=0twulk3SPoDvsI/xJrk/dMA7h3P8NXjZxCVwNzkWlRMuxuE4i7OBKiVqMMiCmXFDfdqzGV
 faFuV9mvLJtPL3c8c0gXqWjjMwDuw6WfQmK7/uny/zsELiBY0mEN2D9HEhIgwNODhDmHjc
 2xPESEeQFAH0TF3KEchHb/Ln2ExpDcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704382162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZV9vYZJc7A9RsAi0fRQ0u7QoAQRtiQYENIL7se3bOQc=;
 b=xaRbIkgs5kdIhgieThkC2AdbygPSvJOFI9UpX2CTpej3pfnbRyNc+gqMHz4ZgaCDOEU5py
 2FNbwbaM9Ow94iBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704382162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZV9vYZJc7A9RsAi0fRQ0u7QoAQRtiQYENIL7se3bOQc=;
 b=0twulk3SPoDvsI/xJrk/dMA7h3P8NXjZxCVwNzkWlRMuxuE4i7OBKiVqMMiCmXFDfdqzGV
 faFuV9mvLJtPL3c8c0gXqWjjMwDuw6WfQmK7/uny/zsELiBY0mEN2D9HEhIgwNODhDmHjc
 2xPESEeQFAH0TF3KEchHb/Ln2ExpDcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704382162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZV9vYZJc7A9RsAi0fRQ0u7QoAQRtiQYENIL7se3bOQc=;
 b=xaRbIkgs5kdIhgieThkC2AdbygPSvJOFI9UpX2CTpej3pfnbRyNc+gqMHz4ZgaCDOEU5py
 2FNbwbaM9Ow94iBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F62313722;
 Thu,  4 Jan 2024 15:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r0gkANLOlmVjTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 15:29:22 +0000
Date: Thu, 4 Jan 2024 16:29:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20240104152920.GA1176214@pevik>
References: <20231031132756.12799-1-chrubis@suse.cz>
 <20231215190725.GA67360@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231215190725.GA67360@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.62 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.cz:email]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.08)[63.31%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_rr_get_interval: Convert to
 docparse
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi Cyril,
...
> I was going to merge, but this is really ugly formatting in html.

> If the dates and authors are important, could this comment be inside normal
> comments (e.g. info is in the sources, but not in docparse doc)? Because we have
> that info in docs as linux-git tags.

> Or, if this is not important, could we use just:

> /*\
>  * [Description]
> ....
>  * It is also a regression test for:
I'm sorry, also I miss blank line before list. I need to write check for that.
>  * * 975e155ed8732 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")
>  * * c7fcb99877f9f ("sched/rt: Fix sysctl_sched_rr_timeslice intial value")

But feel free to merge either in list in docparse or original version, but with
commits in plain /* */ (will not be in docparse.

Kind regards,
Petr

>  */

> Also, for me would be instead of year enough just to add also kernel release to the hash.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
