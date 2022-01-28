Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B2AC433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 15:48:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 416D73C976F
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 16:48:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F12A3C0214
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 16:48:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A9B321401109
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 16:48:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA3162114E;
 Fri, 28 Jan 2022 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643384888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y57C1renKCoDnWslOyCOs+WhS9x90+ld6Udv4gq+Oog=;
 b=wtrOi1G7fVA6OUNVK8Uulz4m/SSM0ZE5cErKM1zaYkRZ8Vll/pUxJaAjqSlIAFJDIxUfrJ
 gbOccyddYOITgSMBeP6brDSygOt+bfA+aoNStCy+z6lR9POnjuR8M4OeVBdWbJKAJ+DlNv
 j1bZ7RAhSHGhJPkVeXi+9Ea1J3fNHKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643384888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y57C1renKCoDnWslOyCOs+WhS9x90+ld6Udv4gq+Oog=;
 b=elw7zhISh4PCjurQVtcEV0vZuhVb9M9tZHvSQR0ldtFP25wZpDmbVvQ79BETHG9cUx1Iff
 wwUwJWfJb0NEMEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D155134CD;
 Fri, 28 Jan 2022 15:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ud+FIjgQ9GGzUQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jan 2022 15:48:08 +0000
Date: Fri, 28 Jan 2022 16:50:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: tangmeng <tangmeng@uniontech.com>
Message-ID: <YfQQqOyJ6zW3fo+F@yuki>
References: <20211119071723.19836-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211119071723.19836-1-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fchmodat_01: Convert to new API
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
>  char pathname[256];
>  char testfile[256];
>  char testfile2[256];
>  char testfile3[256];
> -int fds[TEST_CASES];
> -char *filenames[TEST_CASES];
> -int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
> +int expected_errno[6] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
> +int fds[ARRAY_SIZE(expected_errno)];
> +char *filenames[ARRAY_SIZE(expected_errno)];

We usually pack the syscall parameters into a tcase structure, which is
much easier to read and modify:

...
static int dir_at_fdcwd = AT_FDCWD;
static int file_fd;
static char testfile1[PATH_MAX];

static struct tcase {
	int *dir_fd;
	char filename;
	mode_t mode;
	int exp_err;
} tcases[] = {
	...
	{&file_fd, testfile1, 0600, ENOTDIR},
	...
};

>  int myfchmodat(int dirfd, const char *filename, mode_t mode)
>  {
> -	return ltp_syscall(__NR_fchmodat, dirfd, filename, mode);
> +	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
>  }

This function is now unused.

> -int main(int ac, char **av)
> +static void verify_fchmodat(unsigned int i)
>  {
> -	int lc;
> -	int i;
> -
> -	/* Disable test if the version of the kernel is less than 2.6.16 */
> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
> -		tst_resm(TWARN, "This test can only run on kernels that are ");
> -		tst_resm(TWARN, "2.6.16 and higher");
> -		exit(0);
> -	}
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(myfchmodat(fds[i], filenames[i], 0600));
> -
> -			if (TEST_ERRNO == expected_errno[i]) {
> -				tst_resm(TPASS,
> -					 "fchmodat() returned the expected  errno %d: %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL,
> -					 "fchmodat() Failed, errno=%d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			}
> -		}
> +	TEST(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600));
> +
> +	if (TST_ERR == expected_errno[i]) {
> +		tst_res(TPASS,
> +			 "fchmodat() returned the expected  errno %d: %s",
> +			 TST_ERR, strerror(TST_ERR));
> +	} else {
> +		tst_res(TFAIL,
> +			 "fchmodat() Failed, errno=%d : %s",
> +			 TST_ERR, strerror(TST_ERR));
>  	}

Ideally the test should be split into two testcases. One for the error
tests and one for the functionality test so that we can use
TST_EXP_PASS() and TST_EXP_FAIL().

> -	cleanup();
> -	tst_exit();
>  }
> 
> -void setup(void)
> +static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
>  	/* Initialize test dir and file names */
>  	char *abs_path = tst_get_tmpdir();
>  	int p = getpid();
> @@ -122,31 +65,36 @@ void setup(void)
> 
>  	free(abs_path);
> 
> -	SAFE_MKDIR(cleanup, pathname, 0700);
> +	SAFE_MKDIR(pathname, 0700);
> 
> -	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
> +	fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
>  	fds[1] = fds[4] = fds[0];
> 
> -	SAFE_FILE_PRINTF(cleanup, testfile, "%s", testfile);
> -	SAFE_FILE_PRINTF(cleanup, testfile2, "%s", testfile2);
> +	SAFE_FILE_PRINTF(testfile, "%s", testfile);
> +	SAFE_FILE_PRINTF(testfile2, "%s", testfile2);
> 
> -	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
> +	fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
>  	fds[3] = 100;
>  	fds[5] = AT_FDCWD;
> 
>  	filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
>  	filenames[1] = testfile2;
>  	filenames[5] = testfile3;
> -
> -	TEST_PAUSE;
>  }
> 
> -void cleanup(void)
> +static void cleanup(void)
>  {
>  	if (fds[0] > 0)
>  		close(fds[0]);
>  	if (fds[2] > 0)
>  		close(fds[2]);
> -
> -	tst_rmdir();
>  }
> +
> +static struct tst_test test = {
> +	.min_kver = "2.6.16",
> +	.tcnt = ARRAY_SIZE(expected_errno),
> +	.test = verify_fchmodat,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
