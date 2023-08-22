Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CA9EE4996
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 14:59:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8879D3CC728
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 16:59:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 148433CC6CA
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 16:58:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C41F46005C9
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 16:58:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CD8B1F37F;
 Tue, 22 Aug 2023 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692716329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=leOd8QhP8yERj3V/PrxfwB18ZbvH/paHUz+y7X2XhRo=;
 b=NEfV2cmfHaAec8kkP/IsVM3vg+MtqnzOOAbv4LeEoEVXUv0ZbFPg/q6LI3wKhzx+VGRSAg
 C1FhKBYU28sTAPduwIE4guP5bivO8QUn2uDZ6v+oXbwpSG84MWqLRPVet2LosWij21Lb3B
 XW6cJlK75J4/tk7gOtQs95HG6l36yjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692716329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=leOd8QhP8yERj3V/PrxfwB18ZbvH/paHUz+y7X2XhRo=;
 b=EKKtZDzFXS/1F3odesTeNqbuWAJkhb3BF2fVjpE9Ztc7toq8O5u++ExqG0QxpkTRGrWqI1
 IKw4rz7bua0vVEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A31113919;
 Tue, 22 Aug 2023 14:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fweNBSnN5GQzMQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Aug 2023 14:58:49 +0000
Date: Tue, 22 Aug 2023 16:59:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZOTNSlPaoSaxU493@yuki>
References: <1692700900-13521-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692700900-13521-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1692700900-13521-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/faccessat202: Add new testcase
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
> +static struct passwd *ltpuser;
> +
> +static struct tcase {
> +	int *fd;
> +	char **filename;
> +	int mode;
> +	int flags;
> +	int exp_errno;
> +} tcases[] = {
> +	{&atcwd_fd, &bad_path, R_OK, 0, EFAULT},
> +	{&atcwd_fd, &rel_path, R_OK, -1, EINVAL},
> +	{&atcwd_fd, &rel_path, -1, 0, EINVAL},
> +	{&bad_fd, &rel_path, R_OK, 0, EBADF},
> +	{&fd, &rel_path, R_OK, 0, ENOTDIR},
> +	{&atcwd_fd, &rel_path, R_OK, AT_EACCESS, EACCES},
> +};
> +
> +static void verify_faccessat2(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	if (tc->exp_errno == EACCES) {
> +		if (SAFE_FORK() == 0) {
> +			SAFE_SETUID(ltpuser->pw_uid);
                            ^
			    Should be SAFE_SETEUID() right?

Because the AT_EACESS causes the call to use EUID instead of UID so we
have to change only the EUID and keep the UID to root UID.

And with that we can drop the SAFE_FORK() since we can change EUID back
as long as UID is priviledged, so the code should be:


	if (tc->exp_errno == EACESS)
		SAFE_SETEUID(ltpuser->pw_uid);

	TST_EXP_FAIL(...);

	if (tc->exp_errno == EACESS)
		SAFE_SETEUID(ltpuser->pw_uid);

> +			TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename,
> +				     tc->mode, tc->flags), tc->exp_errno);
> +		}
> +
> +		tst_reap_children();
> +	} else {
> +		TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename,
> +			     tc->mode, tc->flags), tc->exp_errno);

Can we get a better message here? As it is it prints
"faccessat2(*tc->fd, *tc->filename, tc->mode, tc->flags) ..."

Which is a bit ugly.

> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(TESTDIR, 0666);
> +	SAFE_TOUCH(RELPATH, 0444, NULL);
> +
> +	fd = SAFE_OPEN(RELPATH, O_RDONLY);
> +	bad_path = tst_get_bad_addr(NULL);
> +
> +	ltpuser = SAFE_GETPWNAM(TESTUSER);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_faccessat2,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&rel_path, .str = RELPATH},
> +		{},
> +	},
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.39.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
