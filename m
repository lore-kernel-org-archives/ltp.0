Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE251E7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 13:35:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EFF13E98B5
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 14:35:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71F8C3E13B3
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 14:35:02 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 47600228F32
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 14:35:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5273E2115F;
 Thu, 12 Dec 2024 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734010500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zCdTyk2WnQGBwHn1ITGFXJwOw9QwbPuoF6cc95U/gyM=;
 b=cGMaAL2iytutSQI9lb6sEa/QgLDx650dZYvWxamdoDQvvpE1XwuBCHz8hppykOdKYR10Md
 s8Qjkk3fBlkZpGGAk62OwTOGtMfwxaPp2QKW3refFlB0pLa30BKHj9N4iPK0V4vQtR4dFx
 onp6sskVUGGp6o3eUu4PiorV/9jfd1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734010500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zCdTyk2WnQGBwHn1ITGFXJwOw9QwbPuoF6cc95U/gyM=;
 b=5DMDWDYrk495mwSxI6bY+HVwkX8yaAb3TcwYJbago6DyBj2+ky/klwnAw3c9Fwwk2Xx/pn
 6p6BXPNkUkI2dDBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734010500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zCdTyk2WnQGBwHn1ITGFXJwOw9QwbPuoF6cc95U/gyM=;
 b=cGMaAL2iytutSQI9lb6sEa/QgLDx650dZYvWxamdoDQvvpE1XwuBCHz8hppykOdKYR10Md
 s8Qjkk3fBlkZpGGAk62OwTOGtMfwxaPp2QKW3refFlB0pLa30BKHj9N4iPK0V4vQtR4dFx
 onp6sskVUGGp6o3eUu4PiorV/9jfd1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734010500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zCdTyk2WnQGBwHn1ITGFXJwOw9QwbPuoF6cc95U/gyM=;
 b=5DMDWDYrk495mwSxI6bY+HVwkX8yaAb3TcwYJbago6DyBj2+ky/klwnAw3c9Fwwk2Xx/pn
 6p6BXPNkUkI2dDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EF3113508;
 Thu, 12 Dec 2024 13:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dyp5DYTmWmd1XgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Dec 2024 13:35:00 +0000
Date: Thu, 12 Dec 2024 14:34:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241212133455.GB1476154@pevik>
References: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
 <20241212-doc_syscalls_link-v1-2-69a916958ba9@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212-doc_syscalls_link-v1-2-69a916958ba9@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: support for clickable syscalls under
 stats
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

TL;DR

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'm glad that my original idea to have links did not get lost :).

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Under statistics tab, add possibility to click on a syscalls and
> being redirected to the source code which is testing them.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/conf.py | 120 ++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 69 insertions(+), 51 deletions(-)

> diff --git a/doc/conf.py b/doc/conf.py
> index 1c6a7f74c9401842c01f33dd34a5171d5328248c..258a1b9e285581e40c03caaf643e295fb90cb0c5 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -61,39 +61,38 @@ def generate_syscalls_stats(_):
>      # because in some cases (i.e. io_ring) syscalls are tested, but they are
>      # part of a more complex scenario. In the following list, we define syscalls
>      # which we know they are 100% tested already.
> -    white_list = [
> -        'epoll_pwait2',
> -        'fadvise64',
> -        'fanotify_init',
> -        'fanotify_mark',
> -        'getdents64',
> -        'getmsg',
> -        'getpmsg',

You removed getmsg, getpmsg, putmsg and seccomp.

I originally put them in my patch to black_list (or I wanted)
https://patchwork.ozlabs.org/project/ltp/patch/20241115033916.1707627-1-petr.vorel@gmail.com/

You haven't noticed you removed them (ok, not everything must be documented),
but still it would be nice to remove them from "Untested syscalls" table,
therefore I sent v2.
https://patchwork.ozlabs.org/project/ltp/patch/20241212133024.1480177-1-pvorel@suse.cz/

> -        'inotify_add_watch',
> -        'inotify_rm_watch',
> -        'io_uring_enter',
> -        'io_uring_register',
> -        'io_uring_setup',
> -        'landlock_add_rule',
> -        'landlock_create_ruleset',
> -        'landlock_restrict_self',
> -        'lsetxattr',
> -        'newfstatat',
> -        'putmsg',
> -        'putpmsg',
> -        'pkey_alloc',
> -        'pkey_free',
> -        'pkey_mprotect',
> -        'prlimit64',
> -        'pread64',
> -        'pselect6',
> -        'pwrite64',
> -        'quotactl_fd',
> -        'rt_sigpending',
> -        'seccomp',
> -        'semtimedop',
> -        'sethostname',
> -    ]
> +    ltp_syscalls_path = "testcases/kernel/syscalls"
> +    white_list = {
> +        'bpf': f'{ltp_syscalls_path}/bpf',
> +        'epoll_pwait2': f'{ltp_syscalls_path}/epoll_pwait',
> +        'fadvise64': f'{ltp_syscalls_path}/fadvise',
> +        'fanotify_init': f'{ltp_syscalls_path}/fanotify',
> +        'fanotify_mark': f'{ltp_syscalls_path}/fanotify',
> +        'futex': f'{ltp_syscalls_path}/futex',
> +        'getdents64': f'{ltp_syscalls_path}/gettdents',
> +        'inotify_add_watch': f'{ltp_syscalls_path}/inotify',
> +        'inotify_init': f'{ltp_syscalls_path}/inotify',
> +        'inotify_rm_watch': f'{ltp_syscalls_path}/inotify',
> +        'io_uring_enter': f'{ltp_syscalls_path}/io_uring',
> +        'io_uring_register': f'{ltp_syscalls_path}/io_uring',
> +        'io_uring_setup': f'{ltp_syscalls_path}/io_uring',
> +        'landlock_add_rule': f'{ltp_syscalls_path}/landlock',
> +        'landlock_create_ruleset': f'{ltp_syscalls_path}/landlock',
> +        'landlock_restrict_self': f'{ltp_syscalls_path}/landlock',
> +        'lsetxattr': f'{ltp_syscalls_path}/lgetxattr',
> +        'newfstatat': f'{ltp_syscalls_path}/fstatat',
> +        'pkey_alloc': f'{ltp_syscalls_path}/pkeys',
> +        'pkey_free': f'{ltp_syscalls_path}/pkeys',
> +        'pkey_mprotect': f'{ltp_syscalls_path}/pkeys',
> +        'prlimit64': f'{ltp_syscalls_path}/getrlimit',
> +        'pread64': f'{ltp_syscalls_path}/pread',
> +        'pselect6': f'{ltp_syscalls_path}/pselect',
> +        'pwrite64': f'{ltp_syscalls_path}/pwrite',
> +        'quotactl_fd': f'{ltp_syscalls_path}/quotactl',
> +        'rt_sigpending': f'{ltp_syscalls_path}/sigpending',
> +        'semtimedop': f'{ltp_syscalls_path}/ipc/semop',
> +        'sethostname': f'{ltp_syscalls_path}/sethostname'
> +    }

>      # populate with not implemented, reserved, unmaintained syscalls defined
>      # inside the syscalls file
> @@ -134,6 +133,7 @@ def generate_syscalls_stats(_):
>      if error:
>          return

> +    syscalls_base_dir = "https://github.com/linux-test-project/ltp/tree/master"
nit: we already have some variables for various https://github.com/linux-test-project/ltp
paths. I would personally define at the top variable holding
"https://github.com/linux-test-project/ltp" and deriver others from it
(as a separate commit or a part of previous commit).


>      text = [
>          'Syscalls\n',
>          '--------\n\n',
> @@ -145,15 +145,33 @@ def generate_syscalls_stats(_):
>      with open("syscalls.tbl", 'r', encoding='utf-8') as data:
>          for line in data:
>              match = regexp.search(line)
> -            if match:
> -                ker_syscalls.append(match.group('syscall'))
> +            if not match:
> +                continue
> +
> +            ker_syscalls.append(match.group('syscall'))

>      # collect all LTP tested syscalls
> -    ltp_syscalls = []
> -    for _, _, files in os.walk('../testcases/kernel/syscalls'):
> +    name_patterns = [
> +        re.compile(r'(?P<name>[a-zA-Z_]+[^_])\d{2}\.c'),
> +        re.compile(r'(?P<name>[a-zA-Z_]+[1-9])_\d{2}\.c'),

Using regexp is probably better than my way to set paths (fewer things to
maintain).

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
