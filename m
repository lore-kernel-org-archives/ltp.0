Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C615DC36008
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 07:20:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 152BC3C54E7
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:20:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47C793C29A4
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:20:15 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 010142001B3
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:20:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C08C2119E;
 Tue,  1 Apr 2025 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743492012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+BtI+K68p9jgpgL96gKw2j+31R1G5C80ZnLx148WwY=;
 b=hT79k2SAhS+v3woStdBe0Ep4dZMoxIWIiIjOyPSyqn86rRc16ukSQaaFms4ehzPwVIl1dv
 yRLIFFE40hKERDecgMwEYH633fzxZ5lwsdgDdxlGn5R3TxXXeVGhteWmzac1prJPJvG6KW
 ohiooG09FzJ8AdqJMSyMtuCyj+BxmsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743492012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+BtI+K68p9jgpgL96gKw2j+31R1G5C80ZnLx148WwY=;
 b=PD0OgUtHxIkHyG1B2/E6M4k2jNq3pinQ1qIlRP4dHkZtVUkuehXV+d+uMjEaVxPhlF/rMf
 /ScplRTUGkFK2XBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743492012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+BtI+K68p9jgpgL96gKw2j+31R1G5C80ZnLx148WwY=;
 b=hT79k2SAhS+v3woStdBe0Ep4dZMoxIWIiIjOyPSyqn86rRc16ukSQaaFms4ehzPwVIl1dv
 yRLIFFE40hKERDecgMwEYH633fzxZ5lwsdgDdxlGn5R3TxXXeVGhteWmzac1prJPJvG6KW
 ohiooG09FzJ8AdqJMSyMtuCyj+BxmsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743492012;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+BtI+K68p9jgpgL96gKw2j+31R1G5C80ZnLx148WwY=;
 b=PD0OgUtHxIkHyG1B2/E6M4k2jNq3pinQ1qIlRP4dHkZtVUkuehXV+d+uMjEaVxPhlF/rMf
 /ScplRTUGkFK2XBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA7013691;
 Tue,  1 Apr 2025 07:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id luxeBayT62eHUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 07:20:12 +0000
Date: Tue, 1 Apr 2025 09:20:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250401072006.GB299271@pevik>
References: <20250307225804.380166-1-jacob.martin@canonical.com>
 <Z9lTTX4BrkpFhmQV@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9lTTX4BrkpFhmQV@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory_testset.sh: Give SIGUSR1 handler
 time to run before changing target mapping node in tests 12 and 13
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

Hi all,

> Hi!
> > Fixes: 70259d6e7
> > Signed-off-by: Jacob Martin <jacob.martin@canonical.com>
> > ---
> >  .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> > index c1e7cea8f..04d7cc877 100755
> > --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> > +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> > @@ -383,7 +383,7 @@ talk2memory_test_for_case_12_13()
> >  	sleep 1
> >  	echo $1 > "$2/tasks"
> >  	/bin/kill -s SIGUSR1 $1
> > -
> > +	sleep 1

> This is just another workaround that does not fix the real issue and
> that is that the C child does not communicate properly with the shell
> code. The best solution here would be to rewrite these tests into C.
> There is not that much work the shell does and we would avoid parsing
> files written by the C helper in the shell as well.

@Jacob FYI how looks the patchset which rewrites test6 to C:
https://patchwork.ozlabs.org/project/ltp/list/?series=450626&state=*

Feel free to pick another test.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
