Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58674C27C40
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 09:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 796683CC53C
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 11:11:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D4E63CC48F
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 11:10:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D0BBD14004FD
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 11:10:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E13D522D22;
 Thu, 24 Aug 2023 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692868257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+Ilj0NbKwqbXAAMQ7O+4+ibvM4zQ5Ka+zFzclM41FU=;
 b=y/5wC71LH0sM8H7brD6ZZZUtzou+/1JIdAdTmoS3uyW8baB8+c837YrPtNKUemunOduhOp
 hmAtftJZtY2K1iV997tyFkuSvKSLQUP8p0NHbURTiCi7HCP2XW59OEvhMxJP/3Yo+goXkL
 gGMhuQwNmb7DXjqz9bA8v3Vpj0Wsew8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692868257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+Ilj0NbKwqbXAAMQ7O+4+ibvM4zQ5Ka+zFzclM41FU=;
 b=//tFg15dLkfexI6DXfh8MLk7hNRcS8/YZrOGnjog1q0jzM62iR3yJ2V6DzaRQSlZJG3bXR
 R9JhII8+DPL/SwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5A50132F2;
 Thu, 24 Aug 2023 09:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oJugL6Ee52Q7DAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 24 Aug 2023 09:10:57 +0000
Date: Thu, 24 Aug 2023 11:11:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZOcew11vXKk4IKMb@yuki>
References: <1692617910-32684-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1692617910-32684-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/readlinkat01: Convert to new API
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
> +static struct tcase {
> +	int *fd;
> +	const char **path;
>  	const char *exp_buf;
>  	int exp_ret;
>  	int exp_errno;

The last three fields are not unused anymore.

> -} test_cases[] = {
> -	{&dir_fd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> -	{&dir_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> -	{&fd, TEST_SYMLINK, NULL, -1, ENOTDIR},
> -	{&fd_invalid, TEST_SYMLINK, NULL, -1, EBADF},
> -	{&fd_atcwd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> +} tcases[] = {
> +	{&dir_fd, &testsymlink, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> +	{&dir_fd, &abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> +	{&file_fd, &abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> +	{&fd_atcwd, &testsymlink, TEST_FILE, sizeof(TEST_FILE)-1, 0},
> +	{&fd_atcwd, &abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>  };

Looking at readlinkat() manual page thre is a special case where the
pathname is empty string and the call operates on the dirfd, i.e.
attempts to resolve a directory symlink. Can we please add that case
as well? Can be done in follow up patch...

> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void verify_readlinkat(struct test_case *test)
> +static void verify_readlinkat(unsigned int i)
>  {
>  	char buf[1024];
> +	struct tcase *tc = &tcases[i];
>  
>  	memset(buf, 0, sizeof(buf));
>  
> -	TEST(readlinkat(*test->dir_fd, test->path, buf, sizeof(buf)));
> -
> -	if (TEST_RETURN != test->exp_ret) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "readlinkat() returned %ld, expected %d",
> -		         TEST_RETURN, test->exp_ret);
> -		return;
> -	}
> -
> -	if (TEST_ERRNO != test->exp_errno) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "readlinkat() returned %ld, expected %d",
> -		         TEST_RETURN, test->exp_ret);
> -		return;
> -	}
> -
> -	if (test->exp_ret > 0 && strcmp(test->exp_buf, buf)) {
> -		tst_resm(TFAIL, "Unexpected buffer have '%s', expected '%s'",
> -		         buf, test->exp_buf);
> -		return;
> -	}
> -
> -	tst_resm(TPASS | TTERRNO, "readlinkat() returned %ld", TEST_RETURN);
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		for (i = 0; i < TST_TOTAL; i++)
> -			verify_readlinkat(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_POSITIVE(readlinkat(*tc->fd, *tc->path, buf, sizeof(buf)),
> +		     "readlinkat(%d, %s, %s, %ld)",
> +		     *tc->fd, *tc->path, buf, sizeof(buf));

Can we check that the buf was filled in with the right file name here as
well? We did that in the original test. I guess that we can just do:

	if (strcmp(buf, TEST_FILE))
		tst_res(TPASS, "The filename in buffer is correct");
	else
		tst_res(TFAIL, "Wrong filename in buffer '%s'", buf);

>  }
>  
>  static void setup(void)
>  {
> -	tst_tmpdir();
>  	char *tmpdir = tst_get_tmpdir();
>  
> -	snprintf(abspath, sizeof(abspath), "%s/" TEST_SYMLINK, tmpdir);
> +	abspath = tst_aprintf("%s/" TEST_SYMLINK, tmpdir);
>  	free(tmpdir);
>  
> -	fd = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT, 0600);
> -	SAFE_SYMLINK(cleanup, TEST_FILE, TEST_SYMLINK);
> -	dir_fd = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
> -
> -	TEST_PAUSE;
> +	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
> +	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
> +	dir_fd = SAFE_OPEN(".", O_DIRECTORY);
>  }
>  
>  static void cleanup(void)
>  {
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close fd");
> -
> -	if (dir_fd > 0 && close(dir_fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close dir_fd");
> +	if (file_fd > -1)
> +		SAFE_CLOSE(file_fd);
>  
> -	tst_rmdir();
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
>  }
> +
> +static struct tst_test test = {
> +	.test = verify_readlinkat,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&abspath, .size = sizeof(char)},

Again, the abspath is initialized dynamically in setup() no need to
allocate it here.

> +		{&testsymlink, .str = TEST_SYMLINK},
> +		{},
> +	},
> +	.tcnt = ARRAY_SIZE(tcases),
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
