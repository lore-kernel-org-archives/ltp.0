Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B632AC2BD05
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 11:13:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEDF53D0F85
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 13:13:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01A7A3CFCF8
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 13:13:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 351AD10004A0
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 13:13:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BAD421A56;
 Mon, 24 Jun 2024 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719227588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4sVhctIRSWbbdE+2LseMRsEiM22sTWpyISJ61J5vOQ=;
 b=WM5A5gkGq0FdPb989dm257KTvFRE2cbwvw0TU6J2RkYLtEWoFJV5qYAaH7kaElLsOK8k/T
 pNwIzxf22ur5c978Si+TJSPcwu+jIAs7Ru3k25/impwM2UQj7cNKuMw/suFWfmaSulRSw5
 K1HwZiX9C0RCPo4IDT7bjBmc+I/LOGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719227588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4sVhctIRSWbbdE+2LseMRsEiM22sTWpyISJ61J5vOQ=;
 b=uk/1ph5X+s3XNfiqEfT+zHP4zlT7A8SoDDbLDrezvvXP7Xnlr+5bkh/vnK0PhYax7vfwCp
 5bP6j7dNvW0qybDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WM5A5gkG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="uk/1ph5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719227588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4sVhctIRSWbbdE+2LseMRsEiM22sTWpyISJ61J5vOQ=;
 b=WM5A5gkGq0FdPb989dm257KTvFRE2cbwvw0TU6J2RkYLtEWoFJV5qYAaH7kaElLsOK8k/T
 pNwIzxf22ur5c978Si+TJSPcwu+jIAs7Ru3k25/impwM2UQj7cNKuMw/suFWfmaSulRSw5
 K1HwZiX9C0RCPo4IDT7bjBmc+I/LOGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719227588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4sVhctIRSWbbdE+2LseMRsEiM22sTWpyISJ61J5vOQ=;
 b=uk/1ph5X+s3XNfiqEfT+zHP4zlT7A8SoDDbLDrezvvXP7Xnlr+5bkh/vnK0PhYax7vfwCp
 5bP6j7dNvW0qybDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D5413AA4;
 Mon, 24 Jun 2024 11:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i6eTGcRUeWbkSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jun 2024 11:13:08 +0000
Date: Mon, 24 Jun 2024 13:12:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZnlUusezUjDQKIGN@yuki>
References: <20240417092605.23645-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240417092605.23645-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7BAD421A56
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] unlinkat: Add negative tests for unlinkat
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Can we move the three negative tests from the unlikat01.c here as well,
so that we have all the negative tests in a single place?

> +static void setup(void)
> +{
> +	int attr;
> +
> +	pw = SAFE_GETPWNAM("nobody");
> +
> +	SAFE_MKDIR(DIR_EACCES_NOWRITE, 0777);
> +	SAFE_TOUCH(DIR_EACCES_NOWRITE "/" TEST_EACCES, 0777, NULL);
> +	SAFE_CHMOD(DIR_EACCES_NOWRITE, 0555);

Can't we pass the 0555 directly to the SAFE_TOUCH()?

> +	SAFE_MKDIR(DIR_EACCES_NOSEARCH, 0777);
> +	SAFE_TOUCH(DIR_EACCES_NOSEARCH "/" TEST_EACCES, 0777, NULL);
> +	SAFE_CHMOD(DIR_EACCES_NOSEARCH, 0666);

Here as well?

> +	SAFE_MKDIR(DIR_NORMAL, 0777);
> +	SAFE_TOUCH(DIR_NORMAL "/" TEST_NORMAL, 0777, NULL);
> +	SAFE_TOUCH(DIR_NORMAL "/" TEST_EFAULT, 0777, NULL);
> +
> +	SAFE_MKDIR(DIR_NORMAL "/" DIR_EISDIR, 0777);
> +
> +	memset(longfilename, '1', PATH_MAX + 1);
> +
> +	SAFE_TOUCH(DIR_NORMAL "/" DIR_ENOTDIR, 0777, NULL);
> +
> +	fd_immutable = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_IMMUTABLE,
> +			O_CREAT, 0777);
> +	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> +	attr |= FS_IMMUTABLE_FL;
> +	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> +	SAFE_CLOSE(fd_immutable);

This should be put into a function

static void set_fs_flags(int fd, int flags); and possibly put into the
test library, because this pattern is repeated in several tests.

> +	fd_append_only = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_APPEND_ONLY,
> +			O_CREAT, 0777);
> +	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> +	attr |= FS_APPEND_FL;
> +	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> +	SAFE_CLOSE(fd_append_only);
> +
> +	SAFE_TOUCH(DIR_ENOTDIR2, 0777, NULL);
> +}
> +
> +static void cleanup(void)
> +{
> +	int attr;
> +
> +	fd_immutable = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_IMMUTABLE,
> +			O_RDONLY, 0777);
> +	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> +	attr &= ~FS_IMMUTABLE_FL;
> +	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> +	SAFE_CLOSE(fd_immutable);

Same here, this should be put into clear_fs_flags(int fd, int flags)
function.

Or maybe just one function for both:

tst_change_fs_flags(int fd, int flags, bool set);

Where the set will switch between set and clear operations.

> +	fd_append_only = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_APPEND_ONLY,
> +			O_RDONLY, 0777);
> +	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> +	attr &= ~FS_APPEND_FL;
> +	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> +	SAFE_CLOSE(fd_append_only);
> +}
> +
> +static void do_unlinkat(struct test_case_t *tc)
> +{
> +	int attr;
> +	char fullpath[PATH_MAX];
> +	int dirfd = open(tc->dirname, O_DIRECTORY);
> +
> +	if (dirfd < 0) {
> +		if (tc->expected_errno != EBADF) {
> +			/* Special situation: dirfd refers to a file */
> +			if (errno == ENOTDIR)
> +				dirfd = SAFE_OPEN(tc->dirname, O_APPEND);
> +			else {
> +				tst_res(TFAIL | TERRNO, "Cannot open dirfd");
> +				return;
> +			}
> +		}
> +	}

Can't we pass the flags in the testcase structure as well? That way we
would do just:

	dirfd = open(tc->dirname, tc->open_flags);

> +	TST_EXP_FAIL(unlinkat(dirfd, tc->filename, tc->flags),
> +		tc->expected_errno,
> +		"%s", tc->desc);
> +
> +	/* If unlinkat() succeeded unexpectedly, test file should be restored */
> +	if (!TST_RET) {
> +		snprintf(fullpath, sizeof(fullpath), "%s/%s", tc->dirname,
> +			tc->filename);
> +		if (tc->fd) {
> +			*(tc->fd) = SAFE_OPEN(fullpath, O_CREAT, 0600);
> +			if (tc->ioctl_flag) {
> +				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
> +				attr |= tc->ioctl_flag;
> +				SAFE_IOCTL(*(tc->fd), FS_IOC_SETFLAGS, &attr);
> +			}
> +			SAFE_CLOSE(*(tc->fd));
> +		} else {
> +			SAFE_TOUCH(fullpath, 0777, 0);
> +		}
> +	}

Hmm, I'm not sure if this recovery is worth the extra code.

> +	if (dirfd > 0)
> +		SAFE_CLOSE(dirfd);
> +}
> +
> +static void verify_unlinkat(unsigned int i)
> +{
> +	struct test_case_t *tc = &tcases[i];
> +	pid_t pid;
> +
> +	if (tc->user) {
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			SAFE_SETUID(pw->pw_uid);
> +			do_unlinkat(tc);
> +			exit(0);
> +		}
> +		SAFE_WAITPID(pid, NULL, 0);
> +	} else {
> +		do_unlinkat(tc);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = cleanup,
> +	.test = verify_unlinkat,
> +	.needs_rofs = 1,
> +	.mntpoint = DIR_EROFS,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
