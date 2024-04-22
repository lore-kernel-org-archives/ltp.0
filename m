Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C1C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 17:32:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47FDB3CFF4E
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 19:32:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72E143CF0BF
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 19:31:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 919DC10007B8
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 19:31:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0B45D388;
 Mon, 22 Apr 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D7F8136ED;
 Mon, 22 Apr 2024 17:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PerdEQyfJmaLIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Apr 2024 17:31:56 +0000
Date: Mon, 22 Apr 2024 19:31:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240422173147.GA87877@pevik>
References: <20240422134214.30986-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240422134214.30986-1-andrea.cervesato@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6B0B45D388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: update syscalls statistics
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This patch black-list a few syscalls which are not implemented in the
> kernel, untestable or either really old (=< 2.6 kernel version), as well
> as defining already tested syscalls.
> Also fixed an index issue with table generation.

Nice generated list, but unfortunately testing is not boolean tested x not
tested. Therefore I'm not sure how much is list like this is useful. Links to
the actual tests would be more helpful so that one could make some estimation
how *much* is particular syscall actually tested.

But never mind, this is not a first commit. I overlooked syscall generation
doc/conf.py.

Therefore:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

But I would vote for deleting this list.

As Cyril somewhere noted, we might want to add some more doc into tst_test test
struct, to describe what is being tested.

Also I wonder if using old mips as syscall source does not mean that we miss
some syscalls. I suppose it should contain all (looking last update is in 2024).

"https://raw.githubusercontent.com/torvalds/linux/master/arch/mips/kernel/syscalls/syscall_n64.tbl",
Interesting that we use old arch for syscalls generation (I suppose that one was
the easiest to read). It should contain all syscalls, but this arch might get
deleted in few years.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/_static/logo-100x100.png | Bin 0 -> 29108 bytes
>  doc/_static/logo.png         | Bin 0 -> 54423 bytes
>  doc/_static/old_api.rst      |   7 +++++++
>  doc/conf.py                  |  27 ++++++++++++++++++++++-----
>  4 files changed, 29 insertions(+), 5 deletions(-)
>  create mode 100644 doc/_static/logo-100x100.png
>  create mode 100644 doc/_static/logo.png
>  create mode 100644 doc/_static/old_api.rst

> diff --git a/doc/_static/logo-100x100.png b/doc/_static/logo-100x100.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..945737e84d7a85ba488eb754fed12d5ccd1385a0
> GIT binary patch
> literal 29108
> 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

> literal 0
> HcmV?d00001

> diff --git a/doc/_static/logo.png b/doc/_static/logo.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..b4703c9f97542f7deea3132e8614112866fd78e8
> GIT binary patch
> literal 54423
> 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%0AK_n)9>xq*?M!Fb89p+9yPg2A#nu(^sp1p
> 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
> Sykn670000<MNUMnLSTZ=s%X>z

> literal 0
> HcmV?d00001

> diff --git a/doc/_static/old_api.rst b/doc/_static/old_api.rst
> new file mode 100644
> index 000000000..393e5dcd0
> --- /dev/null
> +++ b/doc/_static/old_api.rst
> @@ -0,0 +1,7 @@
> +New API conversion status
> +-------------------------
> +
> +The current LTP refactoring plan aims to convert all LTP test
> +cases using the new LTP API. There are currently **314** tests
> +which need to be converted and **1159** have been converted
> +already.
> diff --git a/doc/conf.py b/doc/conf.py
> index 9408ee46e..d0f185b28 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -76,14 +76,31 @@ def generate_syscalls_stats(_):
>          'io_uring_register',
>          'epoll_pwait2',
>          'quotactl_fd',
> +        'pread64',
> +        'pwrite64',
> +        'fadvise64',
> +        'getmsg',
> +        'getpmsg',
> +        'putmsg',
> +        'putpmsg',
>      ]

> -    # populate with non-syscalls which are present in the kernel sources
> -    # syscalls file
> +    # populate with not implemented, reserved, unmaintained syscalls defined
> +    # inside the syscalls file
>      black_list = [
>          'reserved177',
>          'reserved193',
> -        'rseq'
> +        'rseq',
> +        '_newselect',
yes (libc)

> +        '_sysctl',

I was just curious what are these strange "syscalls", thus also searched.

> +        'create_module',
yes (removed in Linux 2.6.)

> +        'get_kernel_syms',
yes (removed in Linux 2.6.)

> +        'query_module',
yes (removed in Linux 2.6.)

> +        'nfsservctl',
nfsservctl - syscall interface to kernel nfs daemon
yes, we probably don't want this.

> +        'afs_syscall',
yes (unimplemented)

> +        'sysmips',
> +        'mq_getsetattr',

mq_getsetattr - get/set message queue attributes
=> this is a syscall, right? Although there is "Never call it unless you are
writing a C library!" => yes, it's at least in musl and glibc.
I wonder if we want to keep this one.

> +        'vserver',
yes (unimplemented)

Kind regards,
Petr
>      ]

>      # fetch syscalls file
> @@ -184,12 +201,12 @@ def generate_syscalls_stats(_):

>      left = index_tested % 3
>      if left > 0:
> -        for index in range(0, left + 1):
> +        for index in range(0, 3 - left):
>              table_tested.append(f'      -\n')

>      left = index_untest % 3
>      if left > 0:
> -        for index in range(0, left + 1):
> +        for index in range(0, 3 - left):
>              table_untest.append(f'      -\n')

>      text.extend(table_tested)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
