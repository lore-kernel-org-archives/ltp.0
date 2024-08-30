Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA6CCA0FF3
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 14:00:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95CBF3D2869
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 16:00:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 769C83D283F
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 16:00:07 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4548100023C
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 16:00:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DB7021B27;
 Fri, 30 Aug 2024 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725026405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtvOQfa0IpMjzpcy5XRphhC3cFD8olG/BHeXUUdS+cM=;
 b=IZOG5YaAAqU4bzaHv9ii/FPd6OcFyfekvbxPwPnMX0u369tPTH95wrpRqUu3Enr/Xb7jta
 laZfFKSnOVAliQSTUdSP8e0YMeNQEqziR6CzaWDy/VqOkl0Q9RzjgyJ2FT0zk98huv8jpk
 grOlvczS4HWb0fjRaXCHH6MTrOIOt5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725026405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtvOQfa0IpMjzpcy5XRphhC3cFD8olG/BHeXUUdS+cM=;
 b=DazJHzyXgxW6ht/vEEYF7r/qA9JHmGur12RdXvvC3kOwbjWzdRWDQIb2ogP0zgb7AGz6vT
 dO0RIxU7WFAYwvAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725026405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtvOQfa0IpMjzpcy5XRphhC3cFD8olG/BHeXUUdS+cM=;
 b=IZOG5YaAAqU4bzaHv9ii/FPd6OcFyfekvbxPwPnMX0u369tPTH95wrpRqUu3Enr/Xb7jta
 laZfFKSnOVAliQSTUdSP8e0YMeNQEqziR6CzaWDy/VqOkl0Q9RzjgyJ2FT0zk98huv8jpk
 grOlvczS4HWb0fjRaXCHH6MTrOIOt5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725026405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtvOQfa0IpMjzpcy5XRphhC3cFD8olG/BHeXUUdS+cM=;
 b=DazJHzyXgxW6ht/vEEYF7r/qA9JHmGur12RdXvvC3kOwbjWzdRWDQIb2ogP0zgb7AGz6vT
 dO0RIxU7WFAYwvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B25A13A44;
 Fri, 30 Aug 2024 14:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G5mpIWXQ0Wa7YAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 30 Aug 2024 14:00:05 +0000
Date: Fri, 30 Aug 2024 15:58:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZtHQIQE--xS0MAve@yuki.lan>
References: <20240515114339.19708-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515114339.19708-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite fcnt14 test
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
> +fcntl14_01 fcntl14
> +fcntl14_01_64 fcntl14_64
> +fcntl14_02 fcntl14 -l
> +fcntl14_02_64 fcntl14_64 -l

I would slightly prefer having a .test_variants than adding a command
line options.

> +#define CHECK_EQ_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS, FAILED) do {\
> +	TYPE tst_tmp_a__ = VAL_A; \
> +	TYPE tst_tmp_b__ = VAL_B; \
> +	if (tst_tmp_a__ != tst_tmp_b__) { \
> +		tst_res(TFAIL, \
> +			SVAL_A " == " SVAL_B " (" PFS ")", tst_tmp_a__); \
> +			*FAILED = 1; \
> +	} \
> +} while (0)
> +
> +#define CHECK_EQ_SILENT(VAL_A, VAL_B, FAILED) \
> +		CHECK_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli", FAILED)

Maybe this should go to the tst_test_macros.h?

> +struct file_conf {
> +	short type;
> +	short whence;
> +	long start;
> +	long len;
>  };
>  
> -static testcase *thiscase;
> +struct testcase {
> +	struct file_conf parent;           /* parent parameters for fcntl() */
> +	struct file_conf child;            /* child parameters for fcntl() */
> +	short blocking;                    /* blocking/non-blocking flag */
> +	long pos;                          /* starting file position */
> +};
> +
> +struct tc_results {
> +	int num_pass;
> +	int last_failed;
> +};
> +
> +static const char filepath[] = "unlocked.txt";
> +static const char filedata[] = "Here some bytes!";
>  static struct flock flock;
> -static int parent, child, status, fail = 0;
> -static int got1 = 0;
> -static int fd;
> -static int test;
> -static char tmpname[40];
> +static char *str_op_nums;
> +static char *locking_file;
> +static int op_nums = 5000;
> +static int file_mode = 0777;
> +static struct tc_results *results;
>  
> -#define FILEDATA	"ten bytes!"
> +static void dochild(struct testcase *tc, const int fd, const pid_t parent_pid)
> +{
> +	results->last_failed = 0;
>  
> -void catch1(int sig);
> -void catch_alarm(int sig);
> +	flock.l_type = tc->child.type;
> +	flock.l_whence = tc->child.whence;
> +	flock.l_start = tc->child.start;
> +	flock.l_len = tc->child.len;
> +	flock.l_pid = 0;
>  
> -char *TCID = "fcntl14";
> -int TST_TOTAL = 1;
> -int NO_NFS = 1;
> +	SAFE_FCNTL(fd, F_GETLK, &flock);
>  
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +	if (tc->blocking) {
> +		tst_res(TDEBUG, "Child: expecting blocked file by parent");
>  
> -void setup(void)
> -{
> -	struct sigaction act;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	signal(SIGHUP, SIG_IGN);
> -	umask(0);
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -	parent = getpid();
> -
> -	sprintf(tmpname, "fcntl2.%d", parent);
> -
> -	/* setup signal handler for signal from child */
> -	memset(&act, 0, sizeof(act));
> -	act.sa_handler = catch1;
> -	sigemptyset(&act.sa_mask);
> -	sigaddset(&act.sa_mask, SIGUSR1);
> -	if ((sigaction(SIGUSR1, &act, NULL)) < 0) {
> -		tst_resm(TFAIL, "SIGUSR1 signal setup failed, errno = %d",
> -			 errno);
> -		cleanup();
> -	}
> +		CHECK_EQ_SILENT(flock.l_pid, parent_pid, &results->last_failed);
> +		if (results->last_failed)
> +			return;
>  
> -	memset(&act, 0, sizeof(act));
> -	act.sa_handler = catch_alarm;
> -	sigemptyset(&act.sa_mask);
> -	sigaddset(&act.sa_mask, SIGALRM);
> -	if ((sigaction(SIGALRM, &act, NULL)) < 0) {
> -		tst_resm(TFAIL, "SIGALRM signal setup failed");
> -		cleanup();
> -	}
> -}
> +		CHECK_EQ_SILENT(flock.l_type, tc->parent.type, &results->last_failed);
> +		if (results->last_failed)
> +			return;
>  
> -void wake_parent(void)
> -{
> -	if ((kill(parent, SIGUSR1)) < 0) {
> -		tst_resm(TFAIL, "Attempt to send signal to parent " "failed");
> -		tst_resm(TFAIL, "Test case %d, errno = %d", test + 1, errno);
> -		fail = 1;
> +		flock.l_type = tc->child.type;
> +		flock.l_whence = tc->child.whence;
> +		flock.l_start = tc->child.start;
> +		flock.l_len = tc->child.len;
> +		flock.l_pid = 0;
> +
> +		TST_EXP_FAIL_SILENT(fcntl(fd, F_SETLK, &flock), EWOULDBLOCK);
> +		if (TST_RET != -1)
> +			results->last_failed = 1;
> +	} else {
> +		tst_res(TDEBUG, "Child: expecting no blocking errors");
> +
> +		CHECK_EQ_SILENT(flock.l_type, F_UNLCK, &results->last_failed);
> +		if (results->last_failed)
> +			return;
> +
> +		CHECK_EQ_SILENT(flock.l_whence, tc->child.whence, &results->last_failed);
> +		if (results->last_failed)
> +			return;
> +
> +		CHECK_EQ_SILENT(flock.l_start, tc->child.start, &results->last_failed);
> +		if (results->last_failed)
> +			return;
> +
> +		CHECK_EQ_SILENT(flock.l_len, tc->child.len, &results->last_failed);
> +		if (results->last_failed)
> +			return;
> +
> +		CHECK_EQ_SILENT(flock.l_pid, 0, &results->last_failed);
> +		if (results->last_failed)
> +			return;

Why do we have to exit after each failed check here? I would just a
bunch of the checks here without the returns. All that we need is to
make sure the last_failed is set if child fails so that parent can
detect it.


> +	/* set the initial parent lock on the file */
> +	flock.l_type = tc->parent.type;
> +	flock.l_whence = tc->parent.whence;
> +	flock.l_start = tc->parent.start;
> +	flock.l_len = tc->parent.len;
>  	flock.l_pid = 0;

I wonder if it would be better to use struct flock in the tc directory
so that we could just assign the structure here. I.e. we would do here
just:

	struct flock flock = tc->flock;

	flock.l_pid = 0;


> +	flock.l_type = F_UNLCK;
> +	flock.l_whence = 0;
> +	flock.l_start = 0;
> +	flock.l_len = 0;
>  	flock.l_pid = 0;
>  
> +	SAFE_FCNTL(fd, F_SETLK, &flock);
> +	SAFE_CLOSE(fd);

Why bother with unlocking? Aren't the locks dropped when we close the fd
here anyways?

> +}
> +
> +static void genconf(struct file_conf *conf, const int size, const long pos)
> +{
> +	conf->type = rand() % 2 ? F_RDLCK : F_WRLCK;
> +	conf->whence = SEEK_CUR;
> +
> +	if (pos > 0 && (rand() % 2)) {
> +		conf->start = -(rand() % pos);
> +		conf->len = rand() % (size + conf->start - 1) + 1;
>  	} else {
> -		exit(0);
> +		conf->start = rand() % (size - 1);
> +		conf->len = rand() % (size - conf->start - 1) + 1;
>  	}
>  }

We have a file in which we seek at pos offset and then need a start
relative to that and lenght so that it fits into the file.

The start should be just the whole available range, which is random
offset moved back by pos. Then we need a size which is limited to
whatever is left in the file and is not relative. So if I'm not mistaken
we need what is in the else branch but we have to move the start by pos
at the end, i.e. the whole start and len generation should look like:

	conf->start = rand() % (size - 1);
	conf->len = rand() % (size - conf->start - 1) + 1;
	conf->start -= pos;

That way we generate a valid part of the file and make it realtive to
the pos at the end.

> -void run_test(int file_flag, int file_mode, int seek, int start, int end)
> +static short fcntl_overlap(
> +	struct file_conf *parent,
> +	struct file_conf *child,
> +	const long pos)
>  {
> +	long start[2];
> +	long length[2];
> +	short overlap = 0;
> +
> +	if (parent->start > child->start) {
> +		start[0] = pos + child->start;
> +		start[1] = pos + parent->start;
> +		length[0] = child->len;
> +		length[1] = parent->len;
> +	} else {
> +		start[0] = pos + parent->start;
> +		start[1] = pos + child->start;
> +		length[0] = parent->len;
> +		length[1] = child->len;
>  	}

If you add pos to both of the starts you just move the two ranges by the
same amount. So the end result is the same regardless of if you add it
or not.

> +
> +	overlap = start[0] <= start[1] && start[1] < (start[0] + length[0]);

Isn't the start[0] <= start[1] because we made it so? We set the
start[0] to the smaller of the two. So all we need to do is to check
that that start[0] + lenght[0] does not end before the start[1] which is
the second part of the equation.

And we do not use lenght[1] either. So maybe we just need:

	if (child->start < parent->start)
		overlap = parent->start < (child->start + child->len);
	else
		overlap = child->start < (parent->start + parent->len);

> +	if (overlap)
> +		tst_res(TDEBUG, "child/parent fcntl() configurations overlap");
> +
> +	return overlap;
>  }
>  

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
