Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF019D6DDF1
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 11:04:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D8463D762E
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 12:04:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AFC33D0D71
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 12:04:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E992121B836
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 12:04:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E8D31F808;
 Fri, 15 Nov 2024 11:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731668656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66TpctvV1uaXi3Gi6cVSg0iIGRtMxMAcje2F1/pKkWA=;
 b=hdLMiP4jS9gMwNvTqryFhlJDP/X6fGZ7GC8Hc6Wqpopb08V2NR6sNBMLu2tnWeAtsZRiOP
 qPDO7S/Rx3U130TnsRGFYV6Ss3FPadeMRCwCTHvv1SzZcQYIQIMHNK87pRpy6g4ssxRjnQ
 RZw+wIZQ+O/i80aRXAKq/BWtldeDYMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731668656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66TpctvV1uaXi3Gi6cVSg0iIGRtMxMAcje2F1/pKkWA=;
 b=bCtJ8cY0Xg0c7Zv8TGcclC4HTZjsKe8iAwg2JI3LGEZS9fPlzxRnfBMsbiYYqRXwBG8toi
 KfTaTkuZGhJNtTDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731668656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66TpctvV1uaXi3Gi6cVSg0iIGRtMxMAcje2F1/pKkWA=;
 b=hdLMiP4jS9gMwNvTqryFhlJDP/X6fGZ7GC8Hc6Wqpopb08V2NR6sNBMLu2tnWeAtsZRiOP
 qPDO7S/Rx3U130TnsRGFYV6Ss3FPadeMRCwCTHvv1SzZcQYIQIMHNK87pRpy6g4ssxRjnQ
 RZw+wIZQ+O/i80aRXAKq/BWtldeDYMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731668656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66TpctvV1uaXi3Gi6cVSg0iIGRtMxMAcje2F1/pKkWA=;
 b=bCtJ8cY0Xg0c7Zv8TGcclC4HTZjsKe8iAwg2JI3LGEZS9fPlzxRnfBMsbiYYqRXwBG8toi
 KfTaTkuZGhJNtTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 220DC13485;
 Fri, 15 Nov 2024 11:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yixKB7AqN2enYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Nov 2024 11:04:16 +0000
Date: Fri, 15 Nov 2024 12:04:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241115110410.GB1718754@pevik>
References: <20241115033916.1707627-1-petr.vorel@gmail.com>
 <20241115033916.1707627-2-petr.vorel@gmail.com>
 <fca99dc0-24cb-4248-bb9a-2d4de448a3aa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fca99dc0-24cb-4248-bb9a-2d4de448a3aa@suse.com>
X-Spamd-Result: default: False [-6.00 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Add URL to the sources in syscalls list
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

> Hi Petr,

> On 11/15/24 04:39, Petr Vorel wrote:
> > +    # Or syscalls are here to get their folder.
> > +    white_list = {
> > +        'epoll_pwait2': 'epoll_pwait',
> > +        'fadvise64': 'fadvise',
> > +        'fanotify_init': 'fanotify',
> > +        'fanotify_mark': 'fanotify',
> > +        'futex_wait': 'futex',
> > +        'futex_waitv': 'futex',
> > +        'futex_wake': 'futex',
> > +        'getdents64': 'getdents',
> > +        'inotify_add_watch': 'inotify',
> > +        'inotify_rm_watch': 'inotify',
> > +        'inotify_init1': 'inotify',
> > +        'io_uring_enter': 'io_uring',
> > +        'io_uring_register': 'io_uring',
> > +        'io_uring_setup': 'io_uring',
> > +        'ioprio_get': 'ioprio',
> > +        'ioprio_set': 'ioprio',
> > +        'landlock_add_rule': 'landlock',
> > +        'landlock_create_ruleset': 'landlock',
> > +        'landlock_restrict_self': 'landlock',
> > +        'lsetxattr': 'lgetxattr', # llistxattr, lremovexattr
> > +        'newfstatat': 'fstatat',
> > +        'pkey_alloc': 'pkeys',
> > +        'pkey_free': 'pkeys',
> > +        'pkey_mprotect': 'pkeys',
> > +        'pread64': 'preadv',
> > +        'prlimit64': 'getrlimit',
> > +        'process_vm_readv': 'cma',
> > +        'process_vm_writev': 'cma',
> > +        'pselect6': 'select',
> > +        'pwrite64': 'pwrite',
> > +        'quotactl_fd': 'quotactl',
> > +        'rt_sigpending': 'sigpending',
> > +        'semtimedop': 'ipc/semop',
> > +        'sethostname': 'setdomainname',
> > +        'timerfd_gettime': 'timerfd',
> > +        'timerfd_settime': 'timerfd',
> > +        'timerfd_create': 'timerfd',
> > +    }

> The problem with this approach and the reason why I didn't use it, is that
> if you change the testing folder, you need to update the docs generator
> script. But I also see the goal, so probably this is the only approach we
> should follow.

Also, my first version was to match only syscalls, which are the folder with the
same name as the syscall. If we prefer this is better, I can post this version.

@Andrea @Cyril: Other think I would like to have our metadata doc somehow
generated for the master. But that would require to have installed asciidoctor
on container, that will not work for sphinx. Also our metadata syntax is somehow
LTP specific (at least /*\ starter) and having doc on 2 places
(readthedocs https://linux-test-project.readthedocs.io/ and static metadata doc
file uploaded to releases (e.g.
https://github.com/linux-test-project/ltp/releases/download/20240930/metadata.20240930.html)
is not optimal. I also like python scripting more than perl (used for metadata).

Other option would be to drop metadata syntax and transform docs to sphinx
format. But that would require a lot of scripting, we would not want to do it manually.

Also, doc added to releases vs. online doc:
* Should we add generated readthedocs to releases? One could have docs forever.
* Should we have also the latest release doc in online readthedocs? Or even for
* all releases? ATM we have just master.

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
