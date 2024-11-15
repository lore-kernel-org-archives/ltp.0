Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F2ED6DDEA
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 08:25:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2103D74E3
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 09:25:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 769A53D74DC
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 09:25:22 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C33DE10394CC
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 09:25:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04B8E211F9;
 Fri, 15 Nov 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E030313485;
 Fri, 15 Nov 2024 08:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dPjLNXAFN2d5LgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Nov 2024 08:25:20 +0000
Date: Fri, 15 Nov 2024 09:25:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241115082519.GA1711911@pevik>
References: <20241115033916.1707627-1-petr.vorel@gmail.com>
 <20241115033916.1707627-2-petr.vorel@gmail.com>
 <fca99dc0-24cb-4248-bb9a-2d4de448a3aa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fca99dc0-24cb-4248-bb9a-2d4de448a3aa@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 04B8E211F9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

Other thing would be move around folders, but IMHO some syscalls are really
related, that's why it's good they are in "ipc" subfolder. OTOH bind(), send(),
recvmsg(), ... aren't in "net or "network" subfolder.

Whole this was inspired by Metan's suggestion to deriver info about syscalls
from the folder.

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
