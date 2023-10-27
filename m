Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AFFC25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BA3C3CEB99
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:09:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99FA03CCA83
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:09:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DAED52348DA
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:09:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39E6821C4A;
 Fri, 27 Oct 2023 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698401345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkOb1OCVGwxS+Tduatk5YJsC79Lqzy5Mnt4IWXA00yE=;
 b=H+Cq9d1LZQCywQKVGshFtJDlj7Q/nLAZM2UP8PDZpnVfa6o4R03PdWp4lPbE6Bm4GmMq3i
 nF8V80HHMiR0pc2Cn9ut6LFgft2uZz9PR1HwLRKbv2rzfyJjQ3bwVMb3YN9a8uiaZAcrCy
 r8h/teImKy1RCnX9uEQXGdL6fc4qe5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698401345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkOb1OCVGwxS+Tduatk5YJsC79Lqzy5Mnt4IWXA00yE=;
 b=ysy2rCTV86JD9JItLZ5h7O0zH9ZNSDLYFKUMkvxhoKyEl2QWdm8JOKrzntfnzpjOkT8O+r
 zRy6OsZQ9C2aJDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0109F1358C;
 Fri, 27 Oct 2023 10:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D7JhOUCMO2UccQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 10:09:04 +0000
Date: Fri, 27 Oct 2023 12:09:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231027100903.GA638866@pevik>
References: <20231026094957.15371-1-rpalethorpe@suse.com>
 <20231026110659.GA593730@pevik> <87cyx0tqli.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cyx0tqli.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[36.66%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cgroup: Handle trailing new line in
 cgroup.controllers
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

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> >> V2:
> >> * Add underscore
> >> * Add length check
> >> * Expand commit message
> >> * Use shorter syntax
> > +1

> >>  lib/tst_cgroup.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)

> >> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> >> index 5240aadaa..c5cb20505 100644
> >> --- a/lib/tst_cgroup.c
> >> +++ b/lib/tst_cgroup.c
> >> @@ -433,9 +433,20 @@ __attribute__ ((nonnull, warn_unused_result))
> >>  static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
> >>  {
> >>  	struct cgroup_ctrl *ctrl;
> >> +	int l = 0;
> >> +	char c = ctrl_name[l];
> >> +
> >> +	while (c == '_' || (c >= 'a' && c <= 'z'))
> >> +		c = ctrl_name[++l];
> >> +
> >> +	if (l > 32)
> > +1 for this check.
> > I would slightly prefer to add MAX_CGROUP_TYPE_NAMELEN definition into our
> > include/tst_cgroup.h, but it can stay as is.

> > BTW include/linux/cgroup-defs.h contains also MAX_CGROUP_ROOT_NAMELEN, there are
> > also other checks in C files (CGROUP_FILE_NAME_MAX) in case it makes sense to
> > have some checks for these (I have no idea).

> I'm not sure about this. On the one hand it may detect a bug in the
> library or kernel. On the other it's not exposed to userland or defined
> anywhere.

Yep, it's just an idea, I'm not sure myself.

> For me the main thing is to avoid janitorial work like creating and
> merging patches just to increase some internal kernel value that was
> increased or is ignored in some corner case.

+1

> I'll post another patch if there is some obvious way to check the root
> name length that would help the library.

+1

> Thanks for the review, I'll merge this now.

Great.

Kind regards,
Petr

> > Kind regards,
> > Petr

> >> +		tst_res(TWARN, "Subsys name len greater than max known value of MAX_CGROUP_TYPE_NAMELEN: %d > 32", l);

> >> +
> >> +	if (!(c == '\n' || c == '\0'))
> >> +		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, c);

> >>  	for_each_ctrl(ctrl) {
> >> -		if (!strcmp(ctrl_name, ctrl->ctrl_name))
> >> +		if (!strncmp(ctrl_name, ctrl->ctrl_name, l))
> >>  			return ctrl;
> >>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
