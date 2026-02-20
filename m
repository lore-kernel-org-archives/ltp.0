Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05371C5518F
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 11:34:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 623383D0855
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 12:34:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEAD33D0735
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 12:33:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8058A600294
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 12:33:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 370EA5BCD3;
 Fri, 20 Feb 2026 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771587225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNmJnAAeDGGxnO2WZ7BiLjMujrgrQOpQGT+chXHeiCI=;
 b=jHbsAED8sv8N6yD/tQGHSSs7mURlAuL11+ifra8O5IOI5z5zYYbrLZYkc29dlIbw0HJpux
 /SfwfOTDYX+redU5gbpr9bJNGHbluqj+WiDEMssx0E+YnZKx1VozQAcLWLwueECtbxDHXw
 9pWeiB8y/tF0stH+FtvEBE+9n1vFjHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771587225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNmJnAAeDGGxnO2WZ7BiLjMujrgrQOpQGT+chXHeiCI=;
 b=VRvI3nqg88syP9sy33mqjvEs8n4ztk2x4BqBUO4FS3S6ulfZQUhQYikbgc5xn8oTwkR3vj
 umlclQn63metT1CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771587225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNmJnAAeDGGxnO2WZ7BiLjMujrgrQOpQGT+chXHeiCI=;
 b=jHbsAED8sv8N6yD/tQGHSSs7mURlAuL11+ifra8O5IOI5z5zYYbrLZYkc29dlIbw0HJpux
 /SfwfOTDYX+redU5gbpr9bJNGHbluqj+WiDEMssx0E+YnZKx1VozQAcLWLwueECtbxDHXw
 9pWeiB8y/tF0stH+FtvEBE+9n1vFjHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771587225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNmJnAAeDGGxnO2WZ7BiLjMujrgrQOpQGT+chXHeiCI=;
 b=VRvI3nqg88syP9sy33mqjvEs8n4ztk2x4BqBUO4FS3S6ulfZQUhQYikbgc5xn8oTwkR3vj
 umlclQn63metT1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C363EA65;
 Fri, 20 Feb 2026 11:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RbFfNphGmGmKYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 20 Feb 2026 11:33:44 +0000
Date: Fri, 20 Feb 2026 12:33:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260220113342.GA382770@pevik>
References: <20260219163030.69022-1-japo@linux.ibm.com>
 <aZg8FeATSABAhBfw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZg8FeATSABAhBfw@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] [STAGING] ioctl_pidfd06: accept
 EREMOTE/ESRCH for PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > +static const int exp_errnos[] = {EREMOTE, ESRCH};

> >  static void run(void)
> >  {
> > @@ -41,7 +42,8 @@ static void run(void)
> >  	args->exit_signal = SIGCHLD;


> I would be stricter for new kernels, we do not want the new value
> reverted back by an accident. So what about:

So we might want to add this to ground rules.

> static int err_nr = ARRAY_SIZE(exp_errnos);

> static void setup(void)
> {
> 	...
> 	if (tst_kvercmp(9, 19, 0) >= 0)
> 		err_nr = 1;
> 	...
> }

+1

> >  	if (!SAFE_CLONE(args)) {
> > -		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
> > +		TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO, info), exp_errnos,
> > +				ARRAY_SIZE(exp_errnos));
> 				^
> 				err_nr

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
