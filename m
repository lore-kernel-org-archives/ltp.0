Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE9E7BDB4
	for <ltp@archiver.kernel.org>; Mon, 16 Feb 2026 12:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68FAB3D0524
	for <ltp@archiver.kernel.org>; Mon, 16 Feb 2026 13:43:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D9623D0413
 for <ltp@lists.linux.it>; Mon, 16 Feb 2026 13:42:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09CB5200931
 for <ltp@lists.linux.it>; Mon, 16 Feb 2026 13:42:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47B1A5BDB1;
 Mon, 16 Feb 2026 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771245774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8FQ8H3k+NxJQfoZIt4TJz8swOtFpvbhmvFt7ydtlhk=;
 b=DaodfzLzZzgwTdPyragthNbeht9CFQ5F942KVbUmYt+HhqJGLhPc8XV7vruLbnJJQleMN8
 pqy0+9dFT47jnrLQk3dxUl52i6BjGXWd8VrnORFaPM6LRBX+AsUGR27Q1yTzcxn4n+rbAC
 b/l3aPXJ1MvioYZNeWaU6DyGNtgR6/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771245774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8FQ8H3k+NxJQfoZIt4TJz8swOtFpvbhmvFt7ydtlhk=;
 b=tGhIz6cZF6/a+jD6efxb+U+VyQvRKXf19Y2MJ5IuDlqFZhT34OFDjv6kzJKs2OqwQIKF6t
 HySFFP/vTmURb7Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DaodfzLz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tGhIz6cZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771245774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8FQ8H3k+NxJQfoZIt4TJz8swOtFpvbhmvFt7ydtlhk=;
 b=DaodfzLzZzgwTdPyragthNbeht9CFQ5F942KVbUmYt+HhqJGLhPc8XV7vruLbnJJQleMN8
 pqy0+9dFT47jnrLQk3dxUl52i6BjGXWd8VrnORFaPM6LRBX+AsUGR27Q1yTzcxn4n+rbAC
 b/l3aPXJ1MvioYZNeWaU6DyGNtgR6/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771245774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8FQ8H3k+NxJQfoZIt4TJz8swOtFpvbhmvFt7ydtlhk=;
 b=tGhIz6cZF6/a+jD6efxb+U+VyQvRKXf19Y2MJ5IuDlqFZhT34OFDjv6kzJKs2OqwQIKF6t
 HySFFP/vTmURb7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECF383EA62;
 Mon, 16 Feb 2026 12:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yNzYOc0Qk2liPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Feb 2026 12:42:53 +0000
Date: Mon, 16 Feb 2026 13:42:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aZMQ0N_VyyOqGhrS@yuki.lan>
References: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
 <20260127-fork_refactoring-v1-1-e3e21ff1a4f7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260127-fork_refactoring-v1-1-e3e21ff1a4f7@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 47B1A5BDB1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] syscalls: refactor fork09 using new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *   Copyright (c) International Business Machines  Corp., 2001

Unless it's a rewritten from scratch this copyright should stay.

> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - * NAME
> - *	fork09.c
> - *
> - * DESCRIPTION
> - *	Check that child has access to a full set of files.
> - *
> - * ALGORITHM
> - *	Parent opens a maximum number of files
> - *	Child closes one and attempts to open another, it should be
> - *	available
> - *
> - * USAGE
> - *	fork09
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - *	10/2008 Suzuki K P <suzuki@in.ibm.com>
> - *		Fix maximum number of files open logic.
> - *
> - * RESTRICTIONS
> - *	None
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include <unistd.h>		/* for _SC_OPEN_MAX */
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "fork09";
> -int TST_TOTAL = 1;
> +/*\
> + * Verify that a forked child can close all the files which have been open by
> + * the parent process.
> + */
>  
> -static void setup(void);
> -static void cleanup(void);
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
>  
> -static char filname[40], childfile[40];
> -static int first;
> -static FILE **fildeses;		/* file streams */
> -static int mypid, nfiles;
> +#define FILE_PREFIX "ltp_file"
>  
> -#define OPEN_MAX (sysconf(_SC_OPEN_MAX))
> +static FILE **open_files;
> +static long file_open_max;
>  
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int pid, status, nf;
> -
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	fildeses = malloc((OPEN_MAX + 10) * sizeof(FILE *));
> -	if (fildeses == NULL)
> -		tst_brkm(TBROK, cleanup, "malloc failed");
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		mypid = getpid();
> -
> -		tst_resm(TINFO, "OPEN_MAX is %ld", OPEN_MAX);
> -
> -		/* establish first free file */
> -		sprintf(filname, "fork09.%d", mypid);
> -		first = SAFE_CREAT(cleanup, filname, 0660);
> -		close(first);
> -
> -		tst_resm(TINFO, "first file descriptor is %d ", first);
> -
> -		SAFE_UNLINK(cleanup, filname);
> -
> -		/*
> -		 * now open all the files for the test
> -		 */
> -		for (nfiles = first; nfiles < OPEN_MAX; nfiles++) {
> -			sprintf(filname, "file%d.%d", nfiles, mypid);
> -			fildeses[nfiles] = fopen(filname, "a");
> -			if (fildeses[nfiles] == NULL) {
> -				/* Did we already reach OPEN_MAX ? */
> -				if (errno == EMFILE)
> -					break;
> -				tst_brkm(TBROK, cleanup, "Parent: cannot open "
> -					 "file %d %s errno = %d", nfiles,
> -					 filname, errno);
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "filname: %s", filname);
> -#endif
> -		}
> +	FILE *f;
> +	long nfiles;
> +	long totfiles;
> +	char name[PATH_MAX];
>  
> -		tst_resm(TINFO, "Parent reporting %d files open", nfiles - 1);
> -
> -		pid = fork();
> -		if (pid == -1)
> -			tst_brkm(TBROK, cleanup, "Fork failed");
> -
> -		if (pid == 0) {	/* child */
> -			nfiles--;
> -			if (fclose(fildeses[nfiles]) == -1) {
> -				tst_resm(TINFO, "Child could not close file "
> -					 "#%d, errno = %d", nfiles, errno);
> -				exit(1);
> -			} else {
> -				sprintf(childfile, "cfile.%d", getpid());
> -				fildeses[nfiles] = fopen(childfile, "a");
> -				if (fildeses[nfiles] == NULL) {
> -					tst_resm(TINFO, "Child could not open "
> -						 "file %s, errno = %d",
> -						 childfile, errno);
> -					exit(1);
> -				} else {
> -					tst_resm(TINFO, "Child opened new "
> -						 "file #%d", nfiles);
> -					unlink(childfile);
> -					exit(0);
> -				}
> -			}
> -		} else {	/* parent */
> -			wait(&status);
> -			if (status >> 8 != 0)
> -				tst_resm(TFAIL, "test 1 FAILED");
> -			else
> -				tst_resm(TPASS, "test 1 PASSED");
> -		}
> +	tst_res(TINFO, "Opening files from parent");
> +
> +	for (nfiles = 0; nfiles < file_open_max; nfiles++) {
> +		memset(name, 0, PATH_MAX);
> +		snprintf(name, PATH_MAX, "%s%lu", FILE_PREFIX, nfiles);
>  
> -		/* clean up things in case we are looping */
> -		for (nf = first; nf < nfiles; nf++) {
> -			fclose(fildeses[nf]);
> -			sprintf(filname, "file%d.%d", nf, mypid);
> -			unlink(filname);
> +		f = fopen(name, "a");
> +		if (!f) {
> +			if (errno == EMFILE)
> +				break;
> +
> +			tst_brk(TBROK | TERRNO, "fopen() error");
>  		}
> +
> +		open_files[nfiles] = f;
> +	}
> +
> +	totfiles = nfiles;
> +
> +	if (!totfiles)
> +		tst_brk(TBROK, "Parent couldn't open any file");
> +
> +	tst_res(TINFO, "Closing %lu files from child", totfiles);
> +
> +	if (!SAFE_FORK()) {
> +		for (nfiles = nfiles - 1; nfiles >= 0; nfiles--)
> +			SAFE_FCLOSE(open_files[nfiles]);
> +
> +		exit(0);
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	tst_reap_children();
> +
> +	tst_res(TPASS, "Child closed all parent's files");
> +
> +	for (nfiles = 0; nfiles < totfiles; nfiles++) {
> +		memset(name, 0, PATH_MAX);
> +		snprintf(name, PATH_MAX, "%s%lu", FILE_PREFIX, nfiles);
> +
> +		SAFE_FCLOSE(open_files[nfiles]);
> +		SAFE_UNLINK(name);
> +	}
>  }
>  
>  static void setup(void)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	umask(0);
> +	file_open_max = sysconf(_SC_OPEN_MAX);
>  
> -	TEST_PAUSE;
> -	tst_tmpdir();
> +	open_files = SAFE_MMAP(NULL, sizeof(FILE *) * file_open_max,
> +			PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_SHARED,
> +			-1, 0);

Do we need to put this into a shared memory? We do not modify that in
the child process so there is no reason for changes to be propagated to
the parent...


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
