Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C9CC27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 13:25:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7FD93D0E32
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 15:25:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91CA13CB74E
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 15:25:15 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 780B3206C25
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 15:25:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 435A921923;
 Thu, 20 Jun 2024 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718889913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxyrtF/UVy5asl/hYes5gia2+dPYW2HdRkxcxdBHNQo=;
 b=D74xxNktFhog8zMeHt8yqszvqoV4iB+lcFSu0wS7r/mJV0qsC33VlBPU2RvXcOTii7O5AF
 MDAJxFvoXxqdMLJPL8uC5n2UN7dvqMPspuVvO8dn8OC9u6oblQpJVjpyE/jmKZV7xzJkRZ
 pk3EjsPF1645vtZCCjhrmdKHcow0OPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718889913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxyrtF/UVy5asl/hYes5gia2+dPYW2HdRkxcxdBHNQo=;
 b=nY6qjvVJwMj0MV4W7gmqAVbLvIuHhzU79wWhzz20EzHeIGkIEooTXtKh3BcMEKL0FKquVM
 nubUC3qpycKjdGDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718889913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxyrtF/UVy5asl/hYes5gia2+dPYW2HdRkxcxdBHNQo=;
 b=D74xxNktFhog8zMeHt8yqszvqoV4iB+lcFSu0wS7r/mJV0qsC33VlBPU2RvXcOTii7O5AF
 MDAJxFvoXxqdMLJPL8uC5n2UN7dvqMPspuVvO8dn8OC9u6oblQpJVjpyE/jmKZV7xzJkRZ
 pk3EjsPF1645vtZCCjhrmdKHcow0OPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718889913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxyrtF/UVy5asl/hYes5gia2+dPYW2HdRkxcxdBHNQo=;
 b=nY6qjvVJwMj0MV4W7gmqAVbLvIuHhzU79wWhzz20EzHeIGkIEooTXtKh3BcMEKL0FKquVM
 nubUC3qpycKjdGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F54213AC1;
 Thu, 20 Jun 2024 13:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id egMUAbktdGaESQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 13:25:13 +0000
Date: Thu, 20 Jun 2024 15:25:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Message-ID: <20240620132511.GA599458@pevik>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ZnFeWJJldj_ggKnq@yuki>
 <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
 <20240619173324.GA504021@pevik>
 <OS0PR01MB6388E3415F131E666FFC337892C82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388E3415F131E666FFC337892C82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:replyto,toshiba.co.jp:email];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
Cc: linux-arm-kernel@lists.infradead.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!

> Thanks for your comment.

> > > > > $ ./testcases/kernel/syscalls/accept/accept03
> > > > > tst_test.c:1733: TINFO: LTP version: 20240524
> > > > > tst_test.c:1617: TINFO: Timeout per run is 0h 00m 30s
> > > > > accept03.c:58: TPASS: accept() on file : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on O_PATH file : EBADF (9)
> > > > > accept03.c:58: TPASS: accept() on directory : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on /dev/zero : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on /proc/self/maps : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on pipe read end : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on pipe write end : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on epoll : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on eventfd : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on signalfd : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on timerfd : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on pidfd : ENOTSOCK (88)
> > > > > tst_fd.c:151: TCONF: Skipping fanotify: ENOSYS (38)
> > > > > accept03.c:58: TPASS: accept() on inotify : ENOTSOCK (88)
> > > > > tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (38)
> > > > > accept03.c:58: TPASS: accept() on perf event : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on io uring : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on bpf map : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on fsopen : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on fspick : ENOTSOCK (88)
> > > > > accept03.c:58: TPASS: accept() on open_tree : EBADF (9)
> > > > > accept03.c:58: TPASS: accept() on memfd : ENOTSOCK (88)
> > > > > tst_test.c:1677: TBROK: Test killed by SIGILL!

> > > > This looks like a bug either in kernel or libc.

> > > This is caused by __NR_memfd_secure being defined as -1 (0xffffffff)and
> > "Illegal instruction"
> > > occurs when syscall() is executed. And this problem does not occur on
> > x86_64.
> > > I cannot decide if this is a bug or not. I can't decide if this is a
> > > bug or not, because this behavior has existed for a long time.

> > Interesting. But it'd be good to discuss it, right? In case there is something to
> > improve. Cc linux-arm-kernel ML.

> Indeed, Thank you.


> > > > > Summary:
> > > > > passed   20
> > > > > failed   0
> > > > > broken   1
> > > > > skipped  2
> > > > > warnings 0
> > > > > ```

> > > > > Closed: #1145
> > > > > Signed-off-by: Nobuhiro Iwamatsu
> > > > > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > > > ---
> > > > >  lib/tst_fd.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)

> > > > > diff --git a/lib/tst_fd.c b/lib/tst_fd.c index
> > > > > 6538a098c..53f583fa0
> > > > > 100644
> > > > > --- a/lib/tst_fd.c
> > > > > +++ b/lib/tst_fd.c
> > > > > @@ -255,8 +255,16 @@ static void open_memfd(struct tst_fd *fd)

> > > > >  static void open_memfd_secret(struct tst_fd *fd)  {
> > > > > +	if ((tst_kvercmp(5, 14, 0)) < 0) {
> > > > > +		tst_res(TINFO, "accept() on %s: Linux kernel version
> > is before
> > > > than v5.14", tst_fd_desc(fd));


> > > > > +		errno = ENOSYS;
> > > > > +		goto skip;
> > > > > +	}
> > > > > +
> > > > >  	fd->fd = syscall(__NR_memfd_secret, 0);
> > > > > +
> > > > >  	if (fd->fd < 0) {
> > > > > +skip:
> > > > >  		tst_res(TCONF | TERRNO,
> > > > >  			"Skipping %s", tst_fd_desc(fd));
> > > > >  	}

> > > > And this looks like you are working around the bug.

> > > Your point is correct...
> > > I would suggest using tst_syscall() to check for syscall undefined
> > > instead

> > Well, I guess we don't want to use tst_syscall() otherwise it would call tst_brk().
> > I proposed similar patch some time ago [1], I suppose you told me privately
> > exactly this.

> > [1]
> > https://patchwork.ozlabs.org/project/ltp/patch/20240124142108.303782-1-p
> > vorel@suse.cz/]

> I see, I understand.


> > > of this modification. How about this modification?

> > > ```
> > > --- a/lib/tst_fd.c
> > > +++ b/lib/tst_fd.c
> > > @@ -255,7 +255,8 @@ static void open_memfd(struct tst_fd *fd)

> > >  static void open_memfd_secret(struct tst_fd *fd)  {
> > > -       fd->fd = syscall(__NR_memfd_secret, 0);
> > > +       fd->fd = tst_syscall(__NR_memfd_secret, 0);
> > >         if (fd->fd < 0) {
> > >                 tst_res(TCONF | TERRNO,
> > >                         "Skipping %s", tst_fd_desc(fd));


> > Therefore how about this?

> > 	if ((tst_kvercmp(5, 14, 0)) < 0) {
> > 		tst_res(TCONF, "accept() on %s: skipping due old kernel",
> > tst_fd_desc(fd));
> > 		return;
> > 	}


> I did not explain well enough.
> The memfd_secret syscall itself is supported in 5.14, but is implemented on i386, x86_64, s390, and s390x with latest kernel.
> Other architectures are not supported. The above patch causes the same problem with the latest kernel.
> So, I create with the following patch based on your comments. How about this?

> --- a/lib/tst_fd.c
> +++ b/lib/tst_fd.c
> @@ -255,11 +255,20 @@ static void open_memfd(struct tst_fd *fd)

>  static void open_memfd_secret(struct tst_fd *fd)
>  {
> +#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) || defined(__s390x__)

Well, I would prefer to detect syscall support via ENOSYS (or whichever errno it
uses on the archs which does not implement it), otherwise it will always TCONF
regardless some arch may get support in the future. E.g. use the same approach
as tst_syscall(), but just use tst_res() instead of tst_brk() (first run the
syscall and then do the check - expect that errno != ENOSYS on these 4 archs on
kernel >= 5.14.

FYI We have usually this approach: we try to explicitly check whether certain
functionality works if arch or filesystem dependent (e.g. some arch supports
something), but sure still keep in mind that particular support can be extended
(to other archs or filesystems).

Also according to 1507f51255c9f ("mm: introduce memfd_secret system call to
create "secret" memory areas") [1] it's a configurable option (hidden via
CONFIG_EXPERT, but it can be disabled). Therefore the functionality can be
detected via check for CONFIG_SECRETMEM:

tst_kconfig_get("CONFIG_SECRETMEM") == 'y';

Therefore something like this?

static void open_memfd_secret(struct tst_fd *fd)
{
	fd->fd = syscall(__NR_memfd_secret, 0);

	if (errno == ENOSYS) {
		if (tst_kconfig_get("CONFIG_SECRETMEM") == 'y') {
			tst_brk(TBROK | TERRNO, "Broken memfd_secret() functionality");
		} else {
			tst_res(TCONF | TERRNO, "Skipping %s due missing memfd_secret()",
				tst_fd_desc(fd));
			return;
		}
	}

	if (fd->fd < 0)
		tst_res(TCONF | TERRNO, "Skipping %s", tst_fd_desc(fd));
}

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1507f51255c9ff07d75909a84e7c0d7f3c4b2f49

Therefore the original approach looked better to me.

Kind regards,
Petr

> +       if ((tst_kvercmp(5, 14, 0)) < 0) {
> +               tst_res(TCONF, "%s: skipping due old kernel", tst_fd_desc(fd));
> +               return;
> +       }
> +
>         fd->fd = syscall(__NR_memfd_secret, 0);
>         if (fd->fd < 0) {
>                 tst_res(TCONF | TERRNO,
>                         "Skipping %s", tst_fd_desc(fd));
>         }
> +#else
> +       tst_res(TCONF, "%s not supported on this architecture", tst_fd_desc(fd));
> +#endif
>  }

>  static struct tst_fd_desc fd_desc[] = {
> @@ -287,7 +296,7 @@ static struct tst_fd_desc fd_desc[] = {
>         [TST_FD_FSPICK] = {.open_fd = open_fspick, .desc = "fspick"},
>         [TST_FD_OPEN_TREE] = {.open_fd = open_open_tree, .desc = "open_tree"},
>         [TST_FD_MEMFD] = {.open_fd = open_memfd, .desc = "memfd"},
> -       [TST_FD_MEMFD_SECRET] = {.open_fd = open_memfd_secret, .desc = "memfd secret"},
> +       [TST_FD_MEMFD_SECRET] = {.open_fd = open_memfd_secret, .desc = "memfd_secret"},

> Best regards,
>   Nobuhiro

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
