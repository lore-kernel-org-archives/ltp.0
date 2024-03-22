Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1273BC47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 09:37:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 748F63CE61A
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 10:37:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88C963CB170
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 10:36:58 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E763D201192
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 10:36:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 217DA5FC1B;
 Fri, 22 Mar 2024 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711100217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HNciW9ts+pWb0pu9oUd3sPmHe/bmxYQ+VBUlW6+luM=;
 b=APJrvCVr3dNyDBxD1+3+DRbNmDbAycPtmyuTG/WAfUFVDQ0SH+0AM8f6emgI5pYT7487Mb
 W4n++wIN1vCkqAcSMJ1f5uHyc7ko59EyNqwZAdUL6p+4Ld0m6f1Pox6QKALs9t1SRzZxvA
 omhxm1QT/jgk7pDvK/gqqQkWzoOqCoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711100217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HNciW9ts+pWb0pu9oUd3sPmHe/bmxYQ+VBUlW6+luM=;
 b=b9m85qQR2h3wVV/N+aTiQhjy4q0vCJR1nlFsmSY3mHAQB+cJhKz++evcM9fY1xKYUPvaEg
 4uhEZCLtTsucRrAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711100217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HNciW9ts+pWb0pu9oUd3sPmHe/bmxYQ+VBUlW6+luM=;
 b=APJrvCVr3dNyDBxD1+3+DRbNmDbAycPtmyuTG/WAfUFVDQ0SH+0AM8f6emgI5pYT7487Mb
 W4n++wIN1vCkqAcSMJ1f5uHyc7ko59EyNqwZAdUL6p+4Ld0m6f1Pox6QKALs9t1SRzZxvA
 omhxm1QT/jgk7pDvK/gqqQkWzoOqCoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711100217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HNciW9ts+pWb0pu9oUd3sPmHe/bmxYQ+VBUlW6+luM=;
 b=b9m85qQR2h3wVV/N+aTiQhjy4q0vCJR1nlFsmSY3mHAQB+cJhKz++evcM9fY1xKYUPvaEg
 4uhEZCLtTsucRrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F3AD136AD;
 Fri, 22 Mar 2024 09:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tpMXAzlR/WU4SQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 09:36:57 +0000
Date: Fri, 22 Mar 2024 10:36:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240322093655.GB604328@pevik>
References: <20240313124542.13636-1-andrea.cervesato@suse.de>
 <20240322064221.GA594557@pevik>
 <fa3e5a8a-eb2b-462f-a58e-a56284725e17@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa3e5a8a-eb2b-462f-a58e-a56284725e17@suse.com>
X-Spamd-Result: default: False [-4.81 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.31)[75.40%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor fork14 using new LTP API
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

Hi Andrea,

> > generally LGTM.
> > With using .skip_in_compat and SPDX GPL-2.0-only:
> Totally forgot the license..

Thanks for sending v5.

...
> > > -		default:
> > > -			SAFE_WAITPID(cleanup, -1, NULL, 0);
> > > -			if (prev_failed > 0 && i >= LARGE) {
> > > -				tst_resm(TFAIL, "Fork succeeds incorrectly");
> > > -				reproduced = 1;
> > > -				goto clear_memory_map;
> > > -			}
> > > +		ret = waitpid(pid, NULL, 0);
> > Why not SAFE_WAITPID() as it was originally?
> Was discussed with Cyril in the previous review. It's because we don't want
> it to fail only once.

Ah, I'm sorry, I overlooked it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
