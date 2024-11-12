Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A3D32D9E
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 12:17:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0C8E3D5E84
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 13:17:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA5E93D5E7D
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 13:17:20 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D633A63396B
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 13:17:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 219311F451;
 Tue, 12 Nov 2024 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731413838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4HnS6BNknyX8VceKpnc5jjPoQOtw2/NG1swTzg6lr8=;
 b=IvbVy8LvjYyJbiZ+m1xSze3355/qo239LOwrmLBrK/FERgPqSREl2CXAqv8TyyKWEmVVI+
 4G8MW4LibDTOSHdcOiBWC4JiiW9wCjkBMHyrrby7ny7AIYIfHBhxXTlC5vKmErGKyGz0QA
 lGdf1zo5X0y1YEeseUMCTq71s/6QT3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731413838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4HnS6BNknyX8VceKpnc5jjPoQOtw2/NG1swTzg6lr8=;
 b=RoaTTrEYTa91oKIVfw40F1cQzkxsKQqYv8tK9jBYbFapQNPzvESwuLDnxMs+VFOy53bTNi
 b08lu94hcJ83NkDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IvbVy8Lv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RoaTTrEY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731413838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4HnS6BNknyX8VceKpnc5jjPoQOtw2/NG1swTzg6lr8=;
 b=IvbVy8LvjYyJbiZ+m1xSze3355/qo239LOwrmLBrK/FERgPqSREl2CXAqv8TyyKWEmVVI+
 4G8MW4LibDTOSHdcOiBWC4JiiW9wCjkBMHyrrby7ny7AIYIfHBhxXTlC5vKmErGKyGz0QA
 lGdf1zo5X0y1YEeseUMCTq71s/6QT3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731413838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4HnS6BNknyX8VceKpnc5jjPoQOtw2/NG1swTzg6lr8=;
 b=RoaTTrEYTa91oKIVfw40F1cQzkxsKQqYv8tK9jBYbFapQNPzvESwuLDnxMs+VFOy53bTNi
 b08lu94hcJ83NkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1174C13721;
 Tue, 12 Nov 2024 12:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h1gxA05HM2f1VAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 Nov 2024 12:17:18 +0000
Date: Tue, 12 Nov 2024 13:17:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzNHVcaeZU1ZKdYV@yuki.lan>
References: <20241111143609.185692-1-pvorel@suse.cz>
 <ZzIr9bBKPmnN_3YY@yuki.lan> <20241112110052.GA208695@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112110052.GA208695@pevik>
X-Rspamd-Queue-Id: 219311F451
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] syscalls: Add missing WEXITSTATUS() check
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
> > > -	if (WIFEXITED(status))
> > > +	if (WIFEXITED(status) && !WEXITSTATUS(status))
> > >  		return 0;
> 
> > >  	tst_res(TCONF, "No coredump produced after signal (%d)",
> 
> > This one is not complete. We do exit(1) if madvise fails that would be
> > previously caught here so we have to add:
> 
> > diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
> > index 96bcaf159..f8f74ef4f 100644
> > --- a/testcases/kernel/syscalls/madvise/madvise08.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> > @@ -165,7 +165,7 @@ static pid_t run_child(int advice)
> >                                 fmem,
> >                                 FMEMSIZE,
> >                                 advstr);
> > -                       exit(1);
> > +                       exit(0);
> >                 }
> >                 abort();
> >         }
> 
> Good catch, thanks!
> 
> Maybe it'd be more logical to keep exit(1) (it's error) and check against
> WEXITSTATUS(status) == 1, but it's a minor detail, let's keep exit(0).

I wouldn't do so, as it may confuse people into thinking that the return
value actually carries any information, which it does not since the
failure has been already reported. I would just stick to exit(0) which
makes it more clear that we just need to exit the process, nothing more.

> Can I merge with your RBT?

Yes, with the fix above.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
