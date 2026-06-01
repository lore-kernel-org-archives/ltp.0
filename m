Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1704CD6E4C
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 08:51:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28F263E4AD0
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 10:51:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BC373E1C39
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 10:50:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 728A01400760
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 10:50:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 786116858E;
 Mon,  1 Jun 2026 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780303844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vj8N7mxOcPMcK3JnZCoTN8duhxjxAkQBCWyB3d5uOZ0=;
 b=M1mh8aDEc07CC0kejOKFejiyBhSxeyvqpRGmGOy4KrMmx3jYB3LaC4lOmAnoomY0gwP4uM
 JApJY15UBvJoK1wx8hVtaBZyUFVXg8Eed+pU4XkNt4JRUUUB8DG2LLhcltFA9sInHwygI5
 wyTWEw8LTvakAkfS39jRg+AYdNCE6es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780303844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vj8N7mxOcPMcK3JnZCoTN8duhxjxAkQBCWyB3d5uOZ0=;
 b=9NgbqTe5lJsXbyfSvLylpKRowo90LQLXZW37tmdtNzrFCXxmYj3Gwvyg4cl7ca19ifKBM8
 JSCUTlMz01TvsHCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780303844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vj8N7mxOcPMcK3JnZCoTN8duhxjxAkQBCWyB3d5uOZ0=;
 b=M1mh8aDEc07CC0kejOKFejiyBhSxeyvqpRGmGOy4KrMmx3jYB3LaC4lOmAnoomY0gwP4uM
 JApJY15UBvJoK1wx8hVtaBZyUFVXg8Eed+pU4XkNt4JRUUUB8DG2LLhcltFA9sInHwygI5
 wyTWEw8LTvakAkfS39jRg+AYdNCE6es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780303844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vj8N7mxOcPMcK3JnZCoTN8duhxjxAkQBCWyB3d5uOZ0=;
 b=9NgbqTe5lJsXbyfSvLylpKRowo90LQLXZW37tmdtNzrFCXxmYj3Gwvyg4cl7ca19ifKBM8
 JSCUTlMz01TvsHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E10779A7;
 Mon,  1 Jun 2026 08:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 46UMGORHHWq2KAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 01 Jun 2026 08:50:44 +0000
Date: Mon, 1 Jun 2026 10:50:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260601085034.GA488366@pevik>
References: <20260601-gitignore_ltp_agent-v3-1-b39af1578972@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260601-gitignore_ltp_agent-v3-1-b39af1578972@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] gitignore: ignore ltp-agent setup files
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

Hi Andrea,

Generally LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> The ltp-agent tool injects a number of files and symlinks into the LTP
> working directory at runtime (AGENTS.md, GEMINI.md, .agents, .claude,
> and the agents/, linter/ and skills/ symlinks pointing at the agent
> data). These are local helpers used by the agent and must never be
> tracked or committed.

> Directory entries for the injected symlinks are anchored to the
> repository root (leading '/') and have no trailing slash, so they match
> the ltp-agent symlinks without shadowing any unrelated subdirectory of
> the same name.

Out of curiosity, here you talk about /agents /linters and /skills, right?

> Also ignore a few local agent working files: the /.pi/ session
> directory and review-inline.txt scratch files.

> diff --git a/.gitignore b/.gitignore
> index f10cd0c80e3655ad720e465f47c12ad0d51e7cd1..891ffb7b77325a83daa99e6f04bdc51f95490655 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -63,3 +63,16 @@ compile_commands.json

>  # added by scripts/checkpatch.pl
>  .checkpatch-camelcase.*
> +
> +# ltp-agent setup
Maybe link the agent project to make it obviou
# https://github.com/linux-test-project/ltp-agent

> +AGENTS.md
> +GEMINI.md
> +.agents
> +.claude
I wonder shouldn't all the above have leading '/' (slash)?
OK to change before merge.

> +/agents
> +/linter
> +/skills
> +
> +# agents files
What is the difference between "files" and "setup"?

> +/.pi/
> +review-inline.txt
And here as well leading slash?


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
