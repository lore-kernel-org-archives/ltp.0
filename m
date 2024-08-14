Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80185C52D7F
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 09:28:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCD843D212F
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 11:28:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB8B93D2026
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:28:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BAEBC600FB6
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:28:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F0951FE7E;
 Wed, 14 Aug 2024 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723627704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqHS75GGHGMfw0YwYQ0o/qqQ+1lhRtx/e4v0+2/dwTs=;
 b=ATZEMInqIGgv/slKRQo0p1mX798Pa0MSTxP+yOathG98sBQMqnQA6OYKuf3+f/1P135DcZ
 i6MYkJPfZWXxsF1BT42DkiCzKSMtKV9ja977+uteaWH/yPuHx7+aFBBrgtUBrh+aNOocaN
 Dry2QH4NqWm5aFv5IJKPlPQ+ayHil34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723627704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqHS75GGHGMfw0YwYQ0o/qqQ+1lhRtx/e4v0+2/dwTs=;
 b=+jNSJzQU+YabSGBgVV9ZtcZkWfpZLy+lVEV7/bEYYekd8Ms3r17VJGCnNGXenv+8BwTFFl
 avqttDqEmmP+LgCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723627703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqHS75GGHGMfw0YwYQ0o/qqQ+1lhRtx/e4v0+2/dwTs=;
 b=BI1hpM3lhJojAFz9uHJoriq6aVlPrZCI422IicH7wo0fxN4QTfqO9zBxzQaL9K8tm4AX2h
 Oarn7Y11/fOPXA5yEdQNjH9P0crtscvUjozO+VXUO883GkQwgq9nDAMFsJj2T2y2ewKueR
 Ec+9cqcHw7Hz/x9Ti2t7jeviFZikRXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723627703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqHS75GGHGMfw0YwYQ0o/qqQ+1lhRtx/e4v0+2/dwTs=;
 b=MZVQSZOwTCBMWKwSnVfTiqzQ8cNlf7q1ivZGJ5G1Bm2X5ItHmciLqDeyPV50c8gmoeDGZI
 +KJdvXd5UiVjraAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22FCC139B9;
 Wed, 14 Aug 2024 09:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id po2XAbd4vGacdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 09:28:23 +0000
Date: Wed, 14 Aug 2024 11:28:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240814092806.GA521753@pevik>
References: <20240814-landlock_remove_doc_stats-v1-1-b5821d0bb3de@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240814-landlock_remove_doc_stats-v1-1-b5821d0bb3de@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH RESEND] Remove landlock from coverage stats
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

> Following syscalls can be removed from the documentation coverage
> statistics since we they are tested inside landlock testing suite:

> - landlock_create_ruleset
> - landlock_add_rule
> - landlock_restrict_self

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

BTW for these stats, how about generating them on fly?

Take list from glibc sysdeps/unix/sysv/linux/syscall-names.list [1]
and git grep source code? Or do we want to add them manually to make sure we add
only syscalls which are really tested?

BTW this list could be also used for include/lapi/syscall/ generation
(Cyril asked for some automatic approach).

Kind regards,
Petr

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/syscall-names.list;h=7871f93b94d731d26928a3e12e4ca8b88606aad5;hb=2be0572f3a41d5d5a8bb3b2b04244b7c01ac0f58

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/conf.py | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/doc/conf.py b/doc/conf.py
> index ac1220450..425f72257 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -88,6 +88,9 @@ def generate_syscalls_stats(_):
>          'getpmsg',
>          'putmsg',
>          'putpmsg',
> +        'landlock_create_ruleset',
> +        'landlock_add_rule',
> +        'landlock_restrict_self',
>      ]

>      # populate with not implemented, reserved, unmaintained syscalls defined

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
