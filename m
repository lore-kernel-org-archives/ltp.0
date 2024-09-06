Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A1ECD5BDD
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 11:24:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05ED13C265D
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 13:24:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1D1E3C1D48
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 13:23:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 67467103AAFC
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 13:23:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6A7B21A03;
 Fri,  6 Sep 2024 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725621838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAqGJaTCyqIlexttS65TPmCI+TvqkVfC3iAhoNWZ0yk=;
 b=3Ig9Zn4zygIwuB84ho69LyJ3sI36dbirdTLKdeBBInYjxHEj+8pmJqWOaV35j5B3FdKvZI
 1Y6qQp5d72zEhqGfYtPl+LWEzmZDzerghNBVIKfnpMu4M5w6Gj+XZfrDyeQsUWrz5zDoTW
 gZgzvXXk2jqw0xTiJYKx1dOUNKCzSUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725621838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAqGJaTCyqIlexttS65TPmCI+TvqkVfC3iAhoNWZ0yk=;
 b=UseCogFK23oGqHs7b6oG/a4P7538cESNmAPTAaI9c3Rl+BrsqalGwnjIedSgZjmwTBmJQq
 SuDBl5oRsdNBdLAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725621837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAqGJaTCyqIlexttS65TPmCI+TvqkVfC3iAhoNWZ0yk=;
 b=Te9bnqe2QUaI1ZkAhdtbTlvEIyAXyp1/H9Hi2yda/70LYGKakG8LSGaq3uXzDH5Q3TerQK
 kQHodJQc+mvbMUhdkJ1ElFv4pzsP9LMJRETWrjL/Lfcu3bsLXsXtL5ZdOh5FxvbtOm7hH8
 KZAl5dQVXqX8gPfWbVVYbFQKbSGwLoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725621837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAqGJaTCyqIlexttS65TPmCI+TvqkVfC3iAhoNWZ0yk=;
 b=7Hvu/qZt28HbbhzIF1LbMJaDo0B+wpwH/D6NAqwUwIv287aKntCjVpP8T2TfavCwmV6UGH
 ATwrQClbjPR2JGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9E361395F;
 Fri,  6 Sep 2024 11:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 74SZLE3m2maLfAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Sep 2024 11:23:57 +0000
Date: Fri, 6 Sep 2024 13:22:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZtrmCfp5dPTx6vk_@yuki.lan>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
 <ZtrRCVxNKuu5ZdHN@yuki.lan>
 <CAEemH2eHa10SCrdVrPPTWZfQFpyDZ1poFEC=BL1raQECgpjf7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eHa10SCrdVrPPTWZfQFpyDZ1poFEC=BL1raQECgpjf7g@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, raspi4:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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
> > > Here I got test failures on my RPi4 (bash-5.2.21) that the $LINEON can't
> > > be parsed correctly.
> >
> > Are you sure that this is due to bash? My guess is that on RPi the
> > default shell is dash because it's debian based.
> >
> 
> Double checked that is indeed bash.
> 
> liwang@raspi4:~/ltp/testcases/lib$ echo $0
> -bash
> 
> liwang@raspi4:~/ltp/testcases/lib$ echo $SHELL
> /bin/bash
> 
> liwang@raspi4:~/ltp/testcases/lib$ ps -p $$
>     PID TTY          TIME CMD
>  174997 pts/0    00:00:04 bash
> 
> I even manually coded the !#/bin/bash in every test file, the test still
> failed.

The difference is that /bin/sh links to dash in debian. But as you
pointed out even if all /bin/sh is changed to /bin/bash in the scripts
the tests stil fails.

It looks like on RPi alias with variables does not work at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
