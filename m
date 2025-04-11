Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E33FC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 12:07:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF6233CB5B5
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 14:07:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99B23CA5F3
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 14:07:18 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C47B81400E18
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 14:07:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 318C22118D;
 Fri, 11 Apr 2025 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744373236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zt9JVKvEthMu5I+Yj36TAY+dFahYJXvzlpAQFD//yro=;
 b=xpmq6w5bwhFG4TJhbdyUDkkaByEIK4QKgrL7TItlDCDpYImTLaSFDhnYuQXTG6SZ9xWdRd
 yon8lIRBUuGEa1aMMlXBcwZl9DczgK8Fx2meJdNAWa0kDGB+nH0iSAHZxCpgBn/QhSIOEW
 xYJpZ7D6QsKDce6FMcPgQe6dNztLKaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744373236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zt9JVKvEthMu5I+Yj36TAY+dFahYJXvzlpAQFD//yro=;
 b=CLF2NbXWk4K3cuB/Tt6PifNn5xMEkWF5LTb3JqROUoU8+Eud/g267PaRrg3y3jAHcYH6c4
 JqptSeQ5GhVZlkCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744373236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zt9JVKvEthMu5I+Yj36TAY+dFahYJXvzlpAQFD//yro=;
 b=xpmq6w5bwhFG4TJhbdyUDkkaByEIK4QKgrL7TItlDCDpYImTLaSFDhnYuQXTG6SZ9xWdRd
 yon8lIRBUuGEa1aMMlXBcwZl9DczgK8Fx2meJdNAWa0kDGB+nH0iSAHZxCpgBn/QhSIOEW
 xYJpZ7D6QsKDce6FMcPgQe6dNztLKaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744373236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zt9JVKvEthMu5I+Yj36TAY+dFahYJXvzlpAQFD//yro=;
 b=CLF2NbXWk4K3cuB/Tt6PifNn5xMEkWF5LTb3JqROUoU8+Eud/g267PaRrg3y3jAHcYH6c4
 JqptSeQ5GhVZlkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D338136A4;
 Fri, 11 Apr 2025 12:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WAAfAvQF+WefXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Apr 2025 12:07:16 +0000
Date: Fri, 11 Apr 2025 14:07:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250411120714.GA319294@pevik>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250411114326.526-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email,patchwork-ci.sh:url,linux.it:url];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/4] Support for Patchwork CI
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

> Add support for patch-series validation in the patchwork ML.
> We use Github to schedule a trigger every 30 minutes, checking for new
> patche-series in parchwork which has not been tested yet.

> The way we decide if a patch-series has been tested in patchwork, is
> by looking at its status (in particular, if it's "Needs Review / ACK"),
> as well as checking if test report has been uploaded to any of the
> series patches.

> All communication to Patchwrok is done via REST API, using curl and js
> tools.

> First, we create a script called patchwork-ci.sh that provides all the
> commands to read new untested patch-series, set their status and testing
> report. Then, we create a scheduled workflow in Gitlab, checking every
> 30 minutes if there are new untested patch-series. At the end, we
> trigger the main build workflow, used to validate LTP commits in our
> Github mainline. All the times we trigger the build workflow, we also
> provide the patch-series ID, that will be fetched and applied on the
> current branch before running the tests.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v4:
> - patchwork script is now a tool that can be used independently to ci

> Andrea Cervesato (4):
>   ci: install dependences for patchwork-ci script
>   ci: add patchwork communication script
>   ci: add ci-patchwork-trigger workflow

Andrea did a great effort. Unfortunately we deal with problem probably caused by
our mailing list because 3rd commit "ci: add ci-patchwork-trigger workflow" did
not arrive to mailing list.

I suppose the branch is visible on Andrea's fork:

https://github.com/acerv/ltp/tree/refs/heads/b4/patchwork_ci

Mail is not in "ending moderator requests" on https://lists.linux.it/,
I guess we need to contact ML administrators, I'll do it and Cc you.

Kind regards,
Petr

>   ci: apply patchwork series in ci-docker-build workflow

>  .github/workflows/ci-docker-build.yml      |  39 +++-
>  .github/workflows/ci-patchwork-trigger.yml |  63 +++++++
>  ci/alpine-runtime.sh                       |   2 +
>  ci/alpine.sh                               |   2 +
>  ci/debian.i386.sh                          |   2 +
>  ci/debian.sh                               |  28 +--
>  ci/fedora.sh                               |   2 +
>  ci/tools/patchwork.sh                      | 197 +++++++++++++++++++++
>  ci/tumbleweed.sh                           |   2 +
>  9 files changed, 323 insertions(+), 14 deletions(-)
>  create mode 100644 .github/workflows/ci-patchwork-trigger.yml
>  create mode 100755 ci/tools/patchwork.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
