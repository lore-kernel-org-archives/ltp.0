Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472FD32D91
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 11:01:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DEB33D5D18
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 12:01:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0F13D5B54
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 12:01:00 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6BFC100FB20
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 12:00:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1CD061F45A;
 Tue, 12 Nov 2024 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731409258;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48GI/PbiXrBIhI1BLi287DsvF22LUxJHDD4AendnpdQ=;
 b=iC8PiUZbbCLlghTDMXDXwd/zaquEt88mNQnZ7dbM8gsS91Vt8qimJuoWyfKOTBKk53wj1L
 2SaGgo6ttODq12K1rbiEWK2er6puwA8cMkTjfBMIayP1im7GAhN4uHWJqwkbnv23GIGHnT
 xz8SSNmcJXDly93BnuivWwaIiUrOslY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731409258;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48GI/PbiXrBIhI1BLi287DsvF22LUxJHDD4AendnpdQ=;
 b=lxkowCxOux+iouOkcFK1jjRzjy4g0QXa55ICUlF4j3llWcTst81vfPlwBvOjTtt1P9AQlp
 6+LsRFV5VVCsv8CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iC8PiUZb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lxkowCxO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731409258;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48GI/PbiXrBIhI1BLi287DsvF22LUxJHDD4AendnpdQ=;
 b=iC8PiUZbbCLlghTDMXDXwd/zaquEt88mNQnZ7dbM8gsS91Vt8qimJuoWyfKOTBKk53wj1L
 2SaGgo6ttODq12K1rbiEWK2er6puwA8cMkTjfBMIayP1im7GAhN4uHWJqwkbnv23GIGHnT
 xz8SSNmcJXDly93BnuivWwaIiUrOslY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731409258;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48GI/PbiXrBIhI1BLi287DsvF22LUxJHDD4AendnpdQ=;
 b=lxkowCxOux+iouOkcFK1jjRzjy4g0QXa55ICUlF4j3llWcTst81vfPlwBvOjTtt1P9AQlp
 6+LsRFV5VVCsv8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0903813301;
 Tue, 12 Nov 2024 11:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XrsyAWo1M2f7OwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 11:00:58 +0000
Date: Tue, 12 Nov 2024 12:00:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241112110052.GA208695@pevik>
References: <20241111143609.185692-1-pvorel@suse.cz>
 <ZzIr9bBKPmnN_3YY@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzIr9bBKPmnN_3YY@yuki.lan>
X-Rspamd-Queue-Id: 1CD061F45A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> > @@ -173,7 +173,7 @@ static pid_t run_child(int advice)
> >  	SAFE_WAITPID(pid, &status, 0);
> >  	if (WIFSIGNALED(status) && WCOREDUMP(status))
> >  		return pid;
> > -	if (WIFEXITED(status))
> > +	if (WIFEXITED(status) && !WEXITSTATUS(status))
> >  		return 0;

> >  	tst_res(TCONF, "No coredump produced after signal (%d)",

> This one is not complete. We do exit(1) if madvise fails that would be
> previously caught here so we have to add:

> diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
> index 96bcaf159..f8f74ef4f 100644
> --- a/testcases/kernel/syscalls/madvise/madvise08.c
> +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> @@ -165,7 +165,7 @@ static pid_t run_child(int advice)
>                                 fmem,
>                                 FMEMSIZE,
>                                 advstr);
> -                       exit(1);
> +                       exit(0);
>                 }
>                 abort();
>         }

Good catch, thanks!

Maybe it'd be more logical to keep exit(1) (it's error) and check against
WEXITSTATUS(status) == 1, but it's a minor detail, let's keep exit(0).

Can I merge with your RBT?

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
