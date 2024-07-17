Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B663C3DA42
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 11:40:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FAE73D1ADE
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 13:40:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80D643D0C40
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 13:40:42 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CD451400F8E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 13:40:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B008621AA5;
 Wed, 17 Jul 2024 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721216439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErU0vtydkJSC8C3uybyW/d4mFYyZLh/xC1lsKVJzZY8=;
 b=gWgp9hCD2TTmJ2rkgIH5JJF/fIkSB9LbG9Rn6A+Orf8zYF5QmcsAJKn+bMhM8KFyWL+ZOz
 iRukrwF8wfw8T/ZFeKtAbSGmkVyy3sjxblz4HEzWOLBnVq6ZLqteDY9zdijnYNm0hzDnCQ
 P8uaJ+vB/yJl12dB2oNE78b77zqBSjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721216439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErU0vtydkJSC8C3uybyW/d4mFYyZLh/xC1lsKVJzZY8=;
 b=ufezAZrUiJeOOc6P3Ia9xRjFWOWhZZNQi74agPeZaU/HlcThg/ZqVoB6//FaP+rcVH6vjZ
 hY9PA4E7ECpZAzDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gWgp9hCD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ufezAZrU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721216439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErU0vtydkJSC8C3uybyW/d4mFYyZLh/xC1lsKVJzZY8=;
 b=gWgp9hCD2TTmJ2rkgIH5JJF/fIkSB9LbG9Rn6A+Orf8zYF5QmcsAJKn+bMhM8KFyWL+ZOz
 iRukrwF8wfw8T/ZFeKtAbSGmkVyy3sjxblz4HEzWOLBnVq6ZLqteDY9zdijnYNm0hzDnCQ
 P8uaJ+vB/yJl12dB2oNE78b77zqBSjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721216439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErU0vtydkJSC8C3uybyW/d4mFYyZLh/xC1lsKVJzZY8=;
 b=ufezAZrUiJeOOc6P3Ia9xRjFWOWhZZNQi74agPeZaU/HlcThg/ZqVoB6//FaP+rcVH6vjZ
 hY9PA4E7ECpZAzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83617136E5;
 Wed, 17 Jul 2024 11:40:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K8P7Hretl2bOTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 11:40:39 +0000
Date: Wed, 17 Jul 2024 13:43:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZpeuUNVQd9DXJELe@rei>
References: <20240325060110.2278-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240325060110.2278-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B008621AA5
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] linkat01: Split into 2 cases and convert to new
 API
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
>  #define TEST_DIR1 "olddir"
>  #define TEST_DIR2 "newdir"
>  #define TEST_DIR3 "deldir"
>  #define TEST_FILE1 "oldfile"
> -#define TEST_FILE2 "newfile"
> -#define TEST_FIFO "fifo"
>  
> -#define DPATHNAME_FMT	"%s/" TEST_DIR2 "/" TEST_FILE1
> -#define SPATHNAME_FMT	"%s/" TEST_DIR1 "/" TEST_FILE1
> +#define DPATHNAME_FMT "%s/" TEST_DIR2 "/" TEST_FILE1
> +#define SPATHNAME_FMT "%s/" TEST_DIR1 "/" TEST_FILE1
>  
>  static char dpathname[PATH_MAX];
>  static char spathname[PATH_MAX];
> -static int olddirfd, newdirfd = -1, cwd_fd = AT_FDCWD, stdinfd = 0, badfd =
> -    -1, deldirfd;
> -
> -struct test_struct {
> +static int olddirfd;
> +static int newdirfd = -1;
> +static int cwd_fd = AT_FDCWD;
> +static int stdinfd;
> +static int badfd = -1;
> +static int deldirfd;
> +
> +static struct tcase {
>  	int *oldfd;
>  	const char *oldfn;
>  	int *newfd;
> @@ -95,222 +46,122 @@ struct test_struct {
>  	int flags;
>  	const char *referencefn1;
>  	const char *referencefn2;

These two should better be named:

	const char *filename;
	const char *linkname;

So that it's clear where they point to.


Moreover the actual paths seems to be the same for all testcases, so I
suppose that we can just define two macros instead as:

#define FILENAME TEST_DIR1 "/" TEST_FILE1
#define LINKNAME TEST_DIR2 "/" TEST_FILE1

And remove these two members from the structure.

> -	int expected_errno;
> -} test_desc[] = {
> +} tcases[] = {
>  	/* 1. relative paths */
> -	{
> -	&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 2. abs path at source */
> -	{
> -	&olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> -	    /* 3. abs path at dst */
> -	{
> -	&olddirfd, TEST_FILE1, &newdirfd, dpathname, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 4. relative paths to cwd */
> -	{
> -	&cwd_fd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 5. relative paths to cwd */
> -	{
> -	&olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2 "/" TEST_FILE1, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 6. abs path at source */
> -	{
> -	&cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> -	    /* 7. abs path at dst */
> -	{
> -	&olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 8. relative paths to invalid */
> -	{
> -	&stdinfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> -		    0, 0, ENOTDIR},
> -	    /* 9. relative paths to invalid */
> -	{
> -	&olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2 "/" TEST_FILE1, 0,
> -		    0, 0, ENOTDIR},
> -	    /* 10. abs path at source */
> -	{
> -	&stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> -	    /* 11. abs path at dst */
> -	{
> -	&olddirfd, TEST_FILE1, &stdinfd, dpathname, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 12. relative paths to bad */
> -	{
> -	&badfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> -		    0, 0, EBADF},
> -	    /* 13. relative paths to bad */
> -	{
> -	&olddirfd, TEST_FILE1, &badfd, TEST_DIR2 "/" TEST_FILE1, 0,
> -		    0, 0, EBADF},
> -	    /* 14. abs path at source */
> -	{
> -	&badfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> -	    /* 15. abs path at dst */
> -	{
> -	&olddirfd, TEST_FILE1, &badfd, dpathname, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 16. relative paths to deleted */
> -	{
> -	&deldirfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> -		    0, 0, ENOENT},
> -	    /* 17. relative paths to deleted */
> -	{
> -	&olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2 "/" TEST_FILE1, 0,
> -		    0, 0, ENOENT},
> -	    /* 18. abs path at source */
> -	{
> -	&deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> -	    /* 19. abs path at dst */
> -	{
> -	&olddirfd, TEST_FILE1, &deldirfd, dpathname, 0,
> -		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> -	    /* 20. x-device link */
> -	{
> -	&cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0, 0, 0, EXDEV},
> -	    /* 21. directory link */
> -	{
> -	&olddirfd, ".", &newdirfd, TEST_FILE1, 0, 0, 0, EPERM},
> -	    /* 22. invalid flag */
> -	{
> -	&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1, 0, 0, EINVAL},
> -	    /* 23. fifo link */
> -	    /* XXX (garrcoop): Removed because it hangs the overall test. Need to
> -	     * find a legitimate means to exercise this functionality, if in fact
> -	     * it's a valid testcase -- which it should be.
> -	     */
> -	    /* { &olddirfd, TEST_FIFO, &newdirfd, TEST_FILE1, 0,
> -	       TEST_DIR1"/"TEST_FIFO, TEST_DIR2"/"TEST_FILE1, 0 } */
> +	{&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 2. absolution path at source */
> +	{&olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
> +	/* 3. absolution path at destination */
> +	{&olddirfd, TEST_FILE1, &newdirfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 4. relative paths to cwd */
> +	{&cwd_fd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 5. cwd to relative paths */
> +	{&olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 6. cwd to absolution paths */
> +	{&cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
> +	/* 7. absolution paths to cwd */
> +	{&olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 8. invalid directory to absolution paths */
> +	{&stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
> +	/* 9. absolution paths to invalid directory */
> +	{&olddirfd, TEST_FILE1, &stdinfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 10. bad fd to absolution paths */
> +	{&badfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
> +	/* 11. absolution paths to bad fd */
> +	{&olddirfd, TEST_FILE1, &badfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
> +	/* 12. deleted to absolution paths */
> +	{&deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
> +	/* 13. absolution paths to deleted */
> +	{&olddirfd, TEST_FILE1, &deldirfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
>  };
>  
> -char *TCID = "linkat01";
> -int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
> -
> -static int mylinkat(int olddirfd, const char *oldfilename, int newdirfd,
> -		    const char *newfilename, int flags)
> +static void setup(void)
>  {
> -	return tst_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
> -		       newfilename, flags);
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
> +	char *cwd;
> +	int fd;
>  
> -		tst_count = 0;
> +	cwd = get_current_dir_name();
> +	if (cwd == NULL) {
> +		tst_brk(TFAIL | TERRNO,
> +			"Failed to get current working directory.");
> +	}
>  
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			setup_every_copy();
> -			mylinkat_test(&test_desc[i]);
> -		}
> +	SAFE_MKDIR(TEST_DIR1, 0700);
> +	SAFE_MKDIR(TEST_DIR3, 0700);
> +	olddirfd = SAFE_OPEN(TEST_DIR1, O_DIRECTORY);
> +	deldirfd = SAFE_OPEN(TEST_DIR3, O_DIRECTORY);
> +	fd = SAFE_OPEN(TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
> +	SAFE_CLOSE(fd);
>  
> -	}
> +	snprintf(dpathname, sizeof(dpathname), DPATHNAME_FMT, cwd);
> +	snprintf(spathname, sizeof(spathname), SPATHNAME_FMT, cwd);
>  
> -	cleanup();
> -	tst_exit();
> +	free(cwd);
>  }
>  
> -static void setup_every_copy(void)
> +static void setup_every_case(void)
>  {
>  	close(newdirfd);
>  	unlink(dpathname);
>  	rmdir(TEST_DIR2);
>  
> -	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
> -	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
> +	SAFE_MKDIR(TEST_DIR2, 0700);
> +	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);

As far as I can tell the only thing that needs to be done on each
iteration is the unlink of dpathname. The rest could be moved into the
test setup.

>  }
>  
> -static void mylinkat_test(struct test_struct *desc)
> +static void verify_linkat(unsigned int i)
>  {
> -	int fd;
> -
> -	TEST(mylinkat
> -	     (*desc->oldfd, desc->oldfn, *desc->newfd, desc->newfn,
> -	      desc->flags));
> -
> -	if (TEST_ERRNO == desc->expected_errno) {
> -		if (TEST_RETURN == 0 && desc->referencefn1 != NULL) {
> -			int tnum = rand(), vnum = ~tnum;
> -			fd = SAFE_OPEN(cleanup, desc->referencefn1,
> -				       O_RDWR);
> -			SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, &tnum,
> -				sizeof(tnum));
> -			SAFE_CLOSE(cleanup, fd);
> +	struct tcase *tc = &tcases[i];
>  
> -			fd = SAFE_OPEN(cleanup, desc->referencefn2,
> -				       O_RDONLY);
> -			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
> -			SAFE_CLOSE(cleanup, fd);
> +	int fd;
>  
> -			if (tnum == vnum)
> -				tst_resm(TPASS,
> -					 "linkat is functionality correct");
> -			else {
> -				tst_resm(TFAIL,
> -					 "The link file's content isn't "
> -					 "as same as the original file's "
> -					 "although linkat returned 0");
> +	setup_every_case();
> +
> +	if (tc->referencefn1 != NULL) {
> +		TST_EXP_PASS_SILENT(linkat(*tc->oldfd, tc->oldfn,
> +			*tc->newfd, tc->newfn, tc->flags));
> +		if (TST_PASS) {
> +			int tnum = rand();
> +			int vnum = ~tnum;
> +
> +			fd = SAFE_OPEN(tc->referencefn1, O_RDWR);
> +			SAFE_WRITE(SAFE_WRITE_ALL, fd, &tnum, sizeof(tnum));
> +			SAFE_CLOSE(fd);
> +
> +			fd = SAFE_OPEN(tc->referencefn2, O_RDONLY);
> +			SAFE_READ(1, fd, &vnum, sizeof(vnum));
> +			SAFE_CLOSE(fd);
> +
> +			if (tnum == vnum) {
> +				tst_res(TPASS,
> +					"linkat is functionality correct");
> +			} else {
> +				tst_res(TFAIL,
> +					"The link file's content isn't "
> +					"as same as the original file's "
> +					"although linkat returned 0");

Can we be shorter here and more to the point?

Something as:

	tst_res(TFAIL, "Read wrong file content from the hard link.");

>  			}

Can we put this check that the file content is reacheable from the link
as well to a separat function?

>  		} else {
> -			if (TEST_RETURN == 0)
> -				tst_resm(TPASS,
> -					 "linkat succeeded as expected");
> -			else
> -				tst_resm(TPASS | TTERRNO,
> -					 "linkat failed as expected");
> +			tst_res(TFAIL, "linkat failed");

If we are priting PASS/FAIL manually it would make more sense to use
TST_EXP_PASS() instead of the silent variant.

>  		}
>  	} else {
> -		if (TEST_RETURN == 0)
> -			tst_resm(TFAIL, "linkat succeeded unexpectedly");
> -		else
> -			tst_resm(TFAIL | TTERRNO,
> -				 "linkat failed unexpectedly; expected %d - %s",
> -				 desc->expected_errno,
> -				 strerror(desc->expected_errno));
> -	}
> -}
> -
> -void setup(void)
> -{
> -	char *cwd;
> -	int fd;
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	cwd = get_current_dir_name();
> -	if (cwd == NULL) {
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "Failed to get current working directory");
> +		TST_EXP_PASS(linkat(*tc->oldfd, tc->oldfn,
> +			*tc->newfd, tc->newfn, tc->flags),
> +			"linkat");
>  	}
> -
> -	SAFE_MKDIR(cleanup, TEST_DIR1, 0700);
> -	SAFE_MKDIR(cleanup, TEST_DIR3, 0700);
> -	olddirfd = SAFE_OPEN(cleanup, TEST_DIR1, O_DIRECTORY);
> -	deldirfd = SAFE_OPEN(cleanup, TEST_DIR3, O_DIRECTORY);
> -	SAFE_RMDIR(cleanup, TEST_DIR3);
> -	fd = SAFE_OPEN(cleanup, TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
> -	SAFE_CLOSE(cleanup, fd);
> -	SAFE_MKFIFO(cleanup, TEST_DIR1 "/" TEST_FIFO, 0600);
> -
> -	snprintf(dpathname, sizeof(dpathname), DPATHNAME_FMT, cwd);
> -	snprintf(spathname, sizeof(spathname), SPATHNAME_FMT, cwd);
> -
> -	free(cwd);
>  }
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = verify_linkat,
> +	.needs_tmpdir = 1,
> +};
> diff --git a/testcases/kernel/syscalls/linkat/linkat03.c b/testcases/kernel/syscalls/linkat/linkat03.c
> new file mode 100644
> index 000000000..4ee25106e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/linkat/linkat03.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2006-2024
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check the basic function of linkat that returns error.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/fcntl.h"
> +
> +#define TEST_DIR1 "olddir"
> +#define TEST_DIR2 "newdir"
> +#define TEST_DIR3 "deldir"
> +#define TEST_FILE1 "oldfile"
> +
> +static int olddirfd;
> +static int newdirfd = -1;
> +static int cwd_fd = AT_FDCWD;
> +static int stdinfd;
> +static int badfd = -1;
> +static int deldirfd;
> +
> +static struct tcase {
> +	int *oldfd;
> +	const char *oldfn;
> +	int *newfd;
> +	const char *newfn;
> +	int flags;
> +	const char *referencefn1;
> +	const char *referencefn2;

These two pointers are not used for anything.

> +	int expected_errno;
> +} tcases[] = {
> +	/* 1. invalid directory to relative paths */
> +	{&stdinfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		0, 0, ENOTDIR},
> +	/* 2. relative paths to invalid directory */
> +	{&olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		0, 0, ENOTDIR},
> +	/* 3. bad fd to relative paths */
> +	{&badfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		0, 0, EBADF},
> +	/* 4. relative paths to bad fd */
> +	{&olddirfd, TEST_FILE1, &badfd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		0, 0, EBADF},
> +	/* 5. deleted to relative paths */
> +	{&deldirfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		0, 0, ENOENT},
> +	/* 6. relative paths to deleted */
> +	{&olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		0, 0, ENOENT},
> +	/* 7. x-device link */
> +	{&cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0, 0, 0, EXDEV},
> +	/* 8. directory link */
> +	{&olddirfd, ".", &newdirfd, TEST_FILE1, 0, 0, 0, EPERM},
> +	/* 9. invalid flag */
> +	{&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1, 0, 0, EINVAL},
> +};
> +
> +static void setup(void)
> +{
> +	char *cwd;
> +	int fd;
> +
> +	cwd = get_current_dir_name();
> +	if (cwd == NULL) {
> +		tst_brk(TFAIL | TERRNO,
> +			"Failed to get current working directory.");
> +	}
> +
> +	SAFE_MKDIR(TEST_DIR1, 0700);
> +	SAFE_MKDIR(TEST_DIR3, 0700);
> +	olddirfd = SAFE_OPEN(TEST_DIR1, O_DIRECTORY);
> +	deldirfd = SAFE_OPEN(TEST_DIR3, O_DIRECTORY);
> +	SAFE_RMDIR(TEST_DIR3);
> +	fd = SAFE_OPEN(TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
> +	SAFE_CLOSE(fd);
> +
> +	free(cwd);

The cwd does not seem to be used at all.

> +}
> +
> +static void setup_every_case(void)
> +{
> +	close(newdirfd);
> +	rmdir(TEST_DIR2);
> +
> +	SAFE_MKDIR(TEST_DIR2, 0700);
> +	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);

As far as I can tell this can be done once in the test setup()

> +}
> +
> +static void verify_linkat(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	setup_every_case();
> +
> +	TST_EXP_FAIL(linkat(*tc->oldfd, tc->oldfn, *tc->newfd,
> +		tc->newfn, tc->flags),
> +		tc->expected_errno,
> +		"linkat failed as expected");
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = verify_linkat,
> +	.needs_tmpdir = 1,
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
