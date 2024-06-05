Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1BFC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 07:38:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B7A73D0987
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 09:38:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84A703D0968
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 09:38:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90D486008B7
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 09:38:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 050D0219C7;
 Wed,  5 Jun 2024 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717573090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQ1ddy17HF4NJZjn5YAK9LEF4FQwhCjZpRbd+OHMSOc=;
 b=bo0UfQ4avGtLoGW1PQuckZ0Wk3JoX33kAEE99jB5jHY7ac3m6EeeYZ7tpF03P9rWUX20Sz
 BmqegOJnFSFgESSCiEZFIsj6apV7HpQBD7TA8YTH+D9RNHZmxfp5F9uNxfOYRzBZAtudPb
 CN2lsVkj49CkPDf7JWPZ4RHy4c5HY6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717573090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQ1ddy17HF4NJZjn5YAK9LEF4FQwhCjZpRbd+OHMSOc=;
 b=el5CF5mhbZ16HSXMA/PisAlHGRgK0waskl7TlVi0IceOJBs5YHCUEt5bfVidYmUA2NgHLS
 QCVk5Zxflap7gyCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717573090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQ1ddy17HF4NJZjn5YAK9LEF4FQwhCjZpRbd+OHMSOc=;
 b=bo0UfQ4avGtLoGW1PQuckZ0Wk3JoX33kAEE99jB5jHY7ac3m6EeeYZ7tpF03P9rWUX20Sz
 BmqegOJnFSFgESSCiEZFIsj6apV7HpQBD7TA8YTH+D9RNHZmxfp5F9uNxfOYRzBZAtudPb
 CN2lsVkj49CkPDf7JWPZ4RHy4c5HY6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717573090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQ1ddy17HF4NJZjn5YAK9LEF4FQwhCjZpRbd+OHMSOc=;
 b=el5CF5mhbZ16HSXMA/PisAlHGRgK0waskl7TlVi0IceOJBs5YHCUEt5bfVidYmUA2NgHLS
 QCVk5Zxflap7gyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14E9113A24;
 Wed,  5 Jun 2024 07:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJIwOOAVYGb2JQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 07:38:08 +0000
Date: Wed, 5 Jun 2024 09:38:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Avinesh Kumar <akumar@suse.de>
Message-ID: <20240605073806.GA355314@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605065755.GB348321@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,ozlabs.org:url,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Cc the test author more experienced maintainers ]

> Hi Andrea,

> > From: Andrea Cervesato <andrea.cervesato@suse.com>

> > This patch will fix unlink09 test by checking for filesystems which
> > are not supporting inode attributes.

> > Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> > This will fix the 2cf78f47a6 and resolve issues on filesystems
> > which are not supporting inode attributes.
> > ---
> >  testcases/kernel/syscalls/unlink/unlink09.c | 38 +++++++++++++++++++----------
> >  1 file changed, 25 insertions(+), 13 deletions(-)

> > diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
> > index cc4b4a07e..ed6f0adc3 100644
> > --- a/testcases/kernel/syscalls/unlink/unlink09.c
> > +++ b/testcases/kernel/syscalls/unlink/unlink09.c
> > @@ -11,6 +11,8 @@
> >   *
> >   * - EPERM when target file is marked as immutable or append-only
> >   * - EROFS when target file is on a read-only filesystem.
> > + *
> > + * Test won't be executed if inode attributes are not supported.
> While this is good, wouldn't be better to use approach from Avinesh to add
> O_RDWR (or whatever flag) to get test supported everywhere instead of skip?

> https://patchwork.ozlabs.org/project/ltp/patch/20240603124653.31967-1-akumar@suse.de/

OK, I got hint from Andrea, that this is inspired by statx04.c:86, which is
filtering vfat and exfat. Here the problem was on system which has tmpfs, but
just more strict default setup (likely umask). Therefore I still think that
approach from Avinesh is correct.

BTW shouldn't this test use .all_filesystems = 1 ? Or is it unlink() really VFS
only code? I see some specific functions in fs/*/, e.g. btrfs_unlink() or
ext4_unlink(), which are used for struct inode_operations unlink member.
Then, obviously also Andrea's check would be needed (otherwise is unlikely that
somebody would have TMPDIR on vfat or exfat).

Kind regards,
Petr

> >   */

> >  #include <sys/ioctl.h>
> > @@ -22,8 +24,8 @@
> >  #define DIR_EROFS "erofs"
> >  #define TEST_EROFS "erofs/test_erofs"

> > -static int fd_immutable;
> > -static int fd_append_only;
> > +static int fd_immutable = -1;
> > +static int fd_append_only = -1;

> >  static struct test_case_t {
> >  	char *filename;
> > @@ -43,12 +45,18 @@ static void setup(void)
> >  {
> >  	int attr;

> > -	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
> > -	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> > +	fd_immutable = SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
> > +	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
> > +
> > +	if (TST_RET == -1 && TST_ERR == ENOTTY) {
> > +		SAFE_CLOSE(fd_immutable);
> > +		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
> > +	}
> > +
> >  	attr |= FS_IMMUTABLE_FL;
> >  	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);

> > -	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
> > +	fd_append_only = SAFE_CREAT(TEST_EPERM_APPEND_ONLY, 0600);
> >  	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> >  	attr |= FS_APPEND_FL;
> >  	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> > @@ -58,15 +66,19 @@ static void cleanup(void)
> >  {
> >  	int attr;

> > -	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> > -	attr &= ~FS_IMMUTABLE_FL;
> > -	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> > -	SAFE_CLOSE(fd_immutable);
> > +	if (fd_immutable != -1) {
> I thought we could return when fd_immutable == -1:

> 	if (fd_immutable != -1)
> 		return;

> But obviously this is can be also result of the first test (not only by the
> setup), thus you're correct.

> BTW verify_unlink() could be made simpler to return on if (TST_RET).

> > +		SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> > +		attr &= ~FS_IMMUTABLE_FL;
> > +		SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> > +		SAFE_CLOSE(fd_immutable);
> > +	}

> > -	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> > -	attr &= ~FS_APPEND_FL;
> > -	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> > -	SAFE_CLOSE(fd_append_only);
> > +	if (fd_append_only != -1) {
> > +		SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> > +		attr &= ~FS_APPEND_FL;
> > +		SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> > +		SAFE_CLOSE(fd_append_only);
> > +	}
> Am I mistaken that this check should have been added before?

> >  }

> >  static void verify_unlink(unsigned int i)

> > ---
> > base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
> I see useful b4 feature :).

> > change-id: 20240604-unlink09-dc4802f872f9
> But I wonder what is this for (what tool use change-id).

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
