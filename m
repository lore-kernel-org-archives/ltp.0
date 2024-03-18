Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F15C54E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 16:08:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4A13D09E5
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 17:08:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BB423CFC46
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:07:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E79B1000F21
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:07:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DC7B34C0A;
 Mon, 18 Mar 2024 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710778073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ziis2pLnKwj1wahekse9pnAf6Z/fsUHGwlxXdMvYF8=;
 b=dhcUF+nxzD/2RC8ap/zqawIbEXJRqqKmjRGLzXt7xsqJVtMLqNVYfziZDKceR0uM7onYAZ
 dHnVA6qjsdxysg3fZuFq+23z3vk1IGXaOHOXElpp2JJWwupP75mwisw9bs3Kiif77JwFdz
 gMFzZ5r5VZca7VttMlrWgCofwnsxJZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710778073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ziis2pLnKwj1wahekse9pnAf6Z/fsUHGwlxXdMvYF8=;
 b=uezC6eyj7aTHYJJXiz3p02bWFSB/WvNEGC0ODlA171nW/y2jQ1gkiUko8haZJIketLf7ys
 KZyYu5qzbMtNkqCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710778073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ziis2pLnKwj1wahekse9pnAf6Z/fsUHGwlxXdMvYF8=;
 b=dhcUF+nxzD/2RC8ap/zqawIbEXJRqqKmjRGLzXt7xsqJVtMLqNVYfziZDKceR0uM7onYAZ
 dHnVA6qjsdxysg3fZuFq+23z3vk1IGXaOHOXElpp2JJWwupP75mwisw9bs3Kiif77JwFdz
 gMFzZ5r5VZca7VttMlrWgCofwnsxJZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710778073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ziis2pLnKwj1wahekse9pnAf6Z/fsUHGwlxXdMvYF8=;
 b=uezC6eyj7aTHYJJXiz3p02bWFSB/WvNEGC0ODlA171nW/y2jQ1gkiUko8haZJIketLf7ys
 KZyYu5qzbMtNkqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DF3B136A8;
 Mon, 18 Mar 2024 16:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UD11Hdlm+GWIXgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 18 Mar 2024 16:07:53 +0000
Date: Mon, 18 Mar 2024 17:06:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <petr.vorel@gmail.com>
Message-ID: <ZfhmntA-tpbieR4J@yuki>
References: <20240104211935.1438103-1-petr.vorel@gmail.com>
 <20240104211935.1438103-4-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104211935.1438103-4-petr.vorel@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Makefile: Improve 'make help'
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
> index 49d91f4d5..7c9d1217a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -216,8 +216,36 @@ test-metadata: metadata-all
>  ## Help
>  .PHONY: help
>  help:
> -	@echo "Please read the Configuration section in $(top_srcdir)/INSTALL"
> -	@exit 1
> +	@echo 'Cleaning:'
> +	@echo '  clean              - delete all files created by build'
> +	@echo '  distclean          - delete all non-source files'
> +	@echo '  lib-clean          - delete all files created by build in lib directory (C API library and tests)'
> +	@echo '  libs-clean         - delete all files created by build in libs directory (other libraries)'
> +	@echo '  testcases-clean    - delete all files created by build in testcases directory (tests)'
> +	@echo
> +	@echo 'Build:'
> +	@echo '  all                - build everything'
> +	@echo '  autotools          - preparation for configure'
> +	@echo '  lib-all            - build lib directory (C API library and tests)'
> +	@echo '  libs-all           - build libs directory (other libraries)'
> +	@echo '  testcases-all      - build testcases and their dependencies'
> +	@echo
> +	@echo 'Install:'
> +	@echo '  install            - install all files created by build'
> +	@echo '  install-lib        - install files in lib directory (C API library and tests)'
> +	@echo '  install-libs       - install files in libs directory (other libraries)'
> +	@echo '  install-testcases  - install testcases'

I'm not sure if the sub-targets should be described in make help. I
would say to stick to a simple set of clean, distclean, autotools, all,
install, doc, check and be done with it.

> +	@echo 'Documentation:'
> +	@echo '  doc                - create test documentation (HTML and/or PDF, based on configuration)'
> +	@echo
> +	@echo 'Testing:'
> +	@echo '  test               - run all tests'
> +	@echo '  test-c             - run C API tests'
> +	@echo '  test-metadata      - run documentation tests'
> +	@echo '  test-shell         - run shell API tests'

This is way to confusing, we shouldn't mention the internal testsuite
here users will confuse that with actually running LTP tests.

We should instead probably mention the make check.

> +	@echo 'For more info please read the Configuration section in $(top_srcdir)/INSTALL'

That file should be probably updated too.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
