Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72C3C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:54:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59CEA3CAFB0
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 14:54:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73D03CAE53
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 14:54:11 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5C0E6007B6
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 14:54:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D7DB421187;
 Tue,  1 Apr 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B011013691;
 Tue,  1 Apr 2025 12:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AAD6KfHh62eCRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 12:54:09 +0000
Date: Tue, 1 Apr 2025 14:54:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250401125404.GB348979@pevik>
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <Z-u7yYJpTBG8Hi6A@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-u7yYJpTBG8Hi6A@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: D7DB421187
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare03: using soft limit of NOFILE
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
Cc: lufei <lufei@uniontech.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I think it's safer to set NOFILE increasing from soft limit than from
> > hard limit.

> > Hard limit may lead to dup2 ENOMEM error which bring the result to
> > TBROK on little memory machine. (e.g. 2GB memory in my situation, hard
> > limit in /proc/sys/fs/nr_open come out to be 1073741816)

> > Signed-off-by: lufei <lufei@uniontech.com>
> > ---
> >  testcases/kernel/syscalls/unshare/unshare03.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)

> > diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> > index 7c5e71c4e..bb568264c 100644
> > --- a/testcases/kernel/syscalls/unshare/unshare03.c
> > +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> > @@ -24,7 +24,7 @@

> >  static void run(void)
> >  {
> > -	int nr_open;
> > +	int rlim_max;
> >  	int nr_limit;
> >  	struct rlimit rlimit;
> >  	struct tst_clone_args args = {
> > @@ -32,14 +32,12 @@ static void run(void)
> >  		.exit_signal = SIGCHLD,
> >  	};

> > -	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> > -	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
> > +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> > +	rlim_max = rlimit.rlim_max;

> > -	nr_limit = nr_open + NR_OPEN_LIMIT;
> > +	nr_limit = rlim_max + NR_OPEN_LIMIT;
> >  	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);

> > -	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> > -
> >  	rlimit.rlim_cur = nr_limit;
> >  	rlimit.rlim_max = nr_limit;

> > @@ -47,10 +45,10 @@ static void run(void)
> >  	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
> >  		nr_limit);

> > -	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
> > +	SAFE_DUP2(2, rlim_max + NR_OPEN_DUP);

> >  	if (!SAFE_CLONE(&args)) {
> > -		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> > +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", rlim_max);
> >  		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> >  		exit(0);
> >  	}

> Why do we bother with reading the /rpoc/sys/fs/nr_open file? All that we
> need to to do is to dup() a file descriptor and tnen set the nr_open
> limit to fd - 2. And if we do so we can drop the rlimit that increases
> the limit so that it's greater than nr_open as well.

IMHO file descriptor will be 3, fd - 2 == 1. And trying to set 1 to
/rpoc/sys/fs/nr_open leads to EINVAL. You probably mean something different.

The test is based on unshare_test.c [1] from Al Viro (611fbeb44a777 [2]). Both
tests IMHO use nr_open + 1024 nr_open + 1024 and then call dup2() on nr_open + 64
to avoid later EINVAL when writing /rpoc/sys/fs/nr_open.

Kind regards,
Petr

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/core/unshare_test.c
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=611fbeb44a777e5ab54ab3127ec85f72147911d8

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
