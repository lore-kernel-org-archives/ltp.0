Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F64C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 14:25:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33AAB3CE4B9
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:25:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F96F3C0962
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:24:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC8F2200974
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:24:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C019B3EB9;
 Thu, 20 Aug 2026 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787235886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkPp4IlBDuvYPFxSp+DhTZK3GKd3Pa/+g6e5RL1pybU=;
 b=KCS7XMjG+dsjEBf4luNAoPxz+9UMq2a+HuhdYrY/xHpgZ3unL7yCklKJR1DyQyZ5TWmjBI
 z5ACJG5cZsyV/owROl8XGthPmQOw1mzZtaVnleekt7OV4lueYoxAQ2AUcmHC8U70MD8scS
 y58hMmpwCd7wSRBuw/X8jaXlu539/QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787235886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkPp4IlBDuvYPFxSp+DhTZK3GKd3Pa/+g6e5RL1pybU=;
 b=eSm1LMvFXw4oSZN/Zs+bvyb1vP6ld06gAu+BtTvsFMkdSTYi92spWCRjNxQZRulbWGoWtX
 9hFT86iuMkLO08BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787235882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkPp4IlBDuvYPFxSp+DhTZK3GKd3Pa/+g6e5RL1pybU=;
 b=O2/H1MKiYodY4Kj/fyK3qR/SMdz6LSaF5T9wZtbNIP7V4PL03yR6YJOPSAD2q8Ee+Y28Ju
 1Vm4W71I58O7g4dFY7RzSgZbg126+qxxK/fe+6uhfyWidludyUloDUPMB1yP5xnlUlj4O7
 M7hQEnk0Bed7W4F77PWDsyhjPwjLiHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787235882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkPp4IlBDuvYPFxSp+DhTZK3GKd3Pa/+g6e5RL1pybU=;
 b=QJf+KwV1p8qhXkWuscKdHnTrdGT++Yfzc8G9PrSTCLi+Ip7hP991xJuPke9AFMBQ6C4ezO
 ds/KuOMU3jl1q2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA90A27A8;
 Thu, 20 Aug 2026 14:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hGMNKSoOh2o2aQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Aug 2026 14:24:42 +0000
Date: Thu, 20 Aug 2026 16:24:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aocOKwkHbly4UstS@yuki.lan>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
 <20260820-fchroot-v2-7-062ed20957a0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260820-fchroot-v2-7-062ed20957a0@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 07/16] fchroot04: test fchroot() into
 failfs as root
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * Test :manpage:`fchroot(2)` with the ``FD_FAILFS_ROOT`` sentinel as a
> + * privileged process.
> + *
> + * :manpage:`fchroot(2)` was introduced in Linux v7.3 together with failfs,
> + * a kernel internal filesystem where every operation fails with
> + * ``EOPNOTSUPP``. The ``FD_FAILFS_ROOT`` sentinel moves the process root
> + * there without needing a file descriptor: it is the ``fs_struct`` equivalent
> + * of ``RESOLVE_BENEATH``.
> + *
> + * The test verifies that entering failfs succeeds with ``CAP_SYS_CHROOT`` and
> + * that every absolute path lookup then fails with ``EOPNOTSUPP``. The working
> + * directory, left behind in the real filesystem, is consequently reported
> + * as unreachable by :manpage:`getcwd(2)`.
> + *
> + * The syscall runs in a forked child because leaving failfs requires a
> + * mount namespace file descriptor and the parent needs its root for the
> + * test framework cleanup.

Here as well no need for the fork().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
