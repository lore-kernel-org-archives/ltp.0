Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C91CD11C2
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 15:32:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 486EF3CFC19
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 16:32:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A55AF3CE674
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 16:32:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D2001405146
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 16:32:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1638B37A10;
 Tue, 19 Mar 2024 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710862324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwCyAzPsKfWKscFEVXvzNV7k7wFYN5NAlQi1y0w5xyI=;
 b=mdfKoDbdTk4gdzz/lNNGW0LJVTR+eLh4e+JlqwKpb/ozgx1ZWcCdhns+zPkTzxSigSeb8I
 MeBKInG4c1tSYZV3olcddrHUgHjbV3xJrTMb8NiBVEQdSTgsqK3MC8weub/Pr2U9UNCP9y
 7L0aQBOY9zgD6v/3hU+odUt3nvsaC1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710862324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwCyAzPsKfWKscFEVXvzNV7k7wFYN5NAlQi1y0w5xyI=;
 b=KeQfXhxnoAxNkJw3k8uN6UNRqV949ezF4OPr8lnY4aTu48YwliiYkhEXaDHzQAoOyWy8Jf
 hnU1ppqDa+D/TsBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710862323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwCyAzPsKfWKscFEVXvzNV7k7wFYN5NAlQi1y0w5xyI=;
 b=ltfuCwpY8vKGhfpMqs6wBk/pJPuD/nUZM3tRMRHWFk/DqTpzM/+bRblqrd0jCj2hr3++6A
 pmSUuEyfic5EpaKcsc01wKoDD8mWPXgDzFC2jqam3I2JhoELihvNVUkxZi+sSsq96SveLJ
 ImKrgf+bTuA3xlIwjvz+wNP8Z2ZDD88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710862323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwCyAzPsKfWKscFEVXvzNV7k7wFYN5NAlQi1y0w5xyI=;
 b=/7JR9T9qK+nAzenKsh+Lrpp+k8YmEA5eJgiO5TlQJSQe/Wkrf/0C7ZE51SErMe6D1bQyQW
 2LdOQ0sWQBhXHMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07C5C136A5;
 Tue, 19 Mar 2024 15:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rO/TAPOv+WV7EgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 19 Mar 2024 15:32:03 +0000
Date: Tue, 19 Mar 2024 16:31:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZfmvvAQXol3rYCg_@yuki>
References: <20240203043813.2798-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240203043813.2798-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] linkat01: Convert to new API
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
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 2. absolution path at source */
> +	{&olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> +	/* 3. absolution path at destination */
> +	{&olddirfd, TEST_FILE1, &newdirfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 4. relative paths to cwd */
> +	{&cwd_fd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 5. cwd to relative paths */
> +	{&olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 6. cwd to absolution paths */
> +	{&cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> +	/* 7. absolution paths to cwd */
> +	{&olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 8. invalid directory to relative paths */
> +	{&stdinfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		0, 0, ENOTDIR},
> +	/* 9. relative paths to invalid directory */
> +	{&olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		0, 0, ENOTDIR},
> +	/* 10. invalid directory to absolution paths */
> +	{&stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> +	/* 11. absolution paths to invalid directory */
> +	{&olddirfd, TEST_FILE1, &stdinfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 12. bad fd to relative paths */
> +	{&badfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		0, 0, EBADF},
> +	/* 13. relative paths to bad fd */
> +	{&olddirfd, TEST_FILE1, &badfd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		0, 0, EBADF},
> +	/* 14. bad fd to absolution paths */
> +	{&badfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> +	/* 15. absolution paths to bad fd */
> +	{&olddirfd, TEST_FILE1, &badfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 16. deleted to relative paths */
> +	{&deldirfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
> +		0, 0, ENOENT},
> +	/* 17. relative paths to deleted */
> +	{&olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2 "/" TEST_FILE1, 0,
> +		0, 0, ENOENT},
> +	/* 18. deleted to absolution paths */
> +	{&deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
> +	/* 19. absolution paths to deleted */
> +	{&olddirfd, TEST_FILE1, &deldirfd, dpathname, 0,
> +		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
> +	/* 20. x-device link */
> +	{&cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0, 0, 0, EXDEV},
> +	/* 21. directory link */
> +	{&olddirfd, ".", &newdirfd, TEST_FILE1, 0, 0, 0, EPERM},
> +	/* 22. invalid flag */
> +	{&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1, 0, 0, EINVAL},
>  };

Can we please split the test into two, one for positive test and one for
failures? The we can simplify the test function to simple TST_EXP_PASS()
and TST_EXP_FAIL() instead of the ugly if else maze.

> +	TEST(tst_syscall(__NR_linkat, *tc->oldfd, tc->oldfn, *tc->newfd,
> +		tc->newfn, tc->flags));

The linkat() function was added to glibc 2.4 there is no point in
calling it by tst_syscall() now, we can use the glibc prototype.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
