Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC21C25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:10:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94DBB3CEC03
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 13:10:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 473A73CCB40
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:10:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D26214088C6
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:10:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 271FB1F86B;
 Thu, 26 Oct 2023 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698318640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1yaOUGwU5V7UMPeo7kI5siUwYcOscbWQA3BKWvZQIw=;
 b=qtzaGQQSM3/jb/6sY8k/9U581ZolBA4qTPChgGp8WnHB4m/OnHgoSD+MjNeCI/CrIIs7zX
 IgOtONOsQo3ex3wJ0YVhW/z5Yhw/pWk+aNm+UthRbt5wPhfk47Palvg8OwAdXkJrEjWv1Z
 XTGkelI9B2q3elcFxWf0iuGOGS9O/BA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698318640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1yaOUGwU5V7UMPeo7kI5siUwYcOscbWQA3BKWvZQIw=;
 b=EJfGsjgDi1XVF3EnpQ9U0gXBNXW8MElIR/o7n1no+sYovWqmFWYTlz/eG1hHAmcni7cFUe
 ipDzpg8x0OcH/LCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13B7E133F5;
 Thu, 26 Oct 2023 11:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jycpAzBJOmXsaAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 26 Oct 2023 11:10:40 +0000
Date: Thu, 26 Oct 2023 13:11:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZTpJUetaZJyPyDu5@yuki>
References: <20230930000516.4063681-1-edliaw@google.com>
 <20230930065443.GC414289@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230930065443.GC414289@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.41)[97.30%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getpgid01: On Android, pgid(1) is 0 instead of 1
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
> > index 479fe5dcb..8640f2c93 100644
> > --- a/testcases/kernel/syscalls/getpgid/getpgid01.c
> > +++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
> > @@ -37,7 +37,7 @@ static void run(void)
> >  		TST_EXP_EQ_LI(TST_RET, pgid);
> 
> >  		TST_EXP_PID(getpgid(1));
> > -		TST_EXP_EQ_LI(TST_RET, 1);
> > +		TST_EXP_EXPR(TST_RET == 1 || TST_RET == 0, "getpgid(1) == 1 or 0");
> Although I don't prefer using often libc specific code, here I'd use it:
> 
> #ifndef __ANDROID__ 
> 		TST_EXP_EQ_LI(TST_RET, 0);
> #else
> 		TST_EXP_EQ_LI(TST_RET, 1);
> #endif
> 
> Because your code would loosen testing for other libc.
> Cyril, Li, WDYT?

@Peter what about the case where we bypass all init and boot with
init=/bin/sh or init=ltx? I suppose that we will have pgrp set to 0
as well.

What about parsing /proc/1/stat and checking that the value there is the
same as reported here, that should work regardless of what pid is the
init.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
