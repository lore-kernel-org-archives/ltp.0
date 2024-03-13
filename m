Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76964C54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 16:05:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D72A3CFD27
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 17:05:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C94B83C01AF
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 17:05:36 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2634C613BD1
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 17:05:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EED21F7D2;
 Wed, 13 Mar 2024 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710345934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIib69HcD6f4vwUK5I9184NQv1skTGA1NUwsHM2CaTU=;
 b=23j5bP1TfMB6x/ZnGRx1ECTaMupcrl2p4hZr8JEQADadcGOk6omXjTVs5C9zRp0c+j6zpi
 AoCdPPZypfTF5voGQctEJ4peqiJkpiE4z5jC3VXBY3tVXgkDLzzOfanhGbChoTGc3NJi5P
 aaT/SSSKzf91P+eXcXP7Fmz7da7VH0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710345934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIib69HcD6f4vwUK5I9184NQv1skTGA1NUwsHM2CaTU=;
 b=X9m1YKTzHJXdIUAPxlbVLJ8dOxdLfsssR808kgz9lKmQbfiX+oKyGIgtf79u284fILytAf
 +qTTLk1RdrWjtWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710345934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIib69HcD6f4vwUK5I9184NQv1skTGA1NUwsHM2CaTU=;
 b=23j5bP1TfMB6x/ZnGRx1ECTaMupcrl2p4hZr8JEQADadcGOk6omXjTVs5C9zRp0c+j6zpi
 AoCdPPZypfTF5voGQctEJ4peqiJkpiE4z5jC3VXBY3tVXgkDLzzOfanhGbChoTGc3NJi5P
 aaT/SSSKzf91P+eXcXP7Fmz7da7VH0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710345934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIib69HcD6f4vwUK5I9184NQv1skTGA1NUwsHM2CaTU=;
 b=X9m1YKTzHJXdIUAPxlbVLJ8dOxdLfsssR808kgz9lKmQbfiX+oKyGIgtf79u284fILytAf
 +qTTLk1RdrWjtWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFA1F1397F;
 Wed, 13 Mar 2024 16:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ltlnOc3O8WUTBAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 16:05:33 +0000
Date: Wed, 13 Mar 2024 17:04:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <ZfHOlB34r1PgmhPz@yuki>
References: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=23j5bP1T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X9m1YKTz
X-Spamd-Result: default: False [-2.81 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,linux.it:url,wipro.com:email]; 
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 0EED21F7D2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fdatasync01: Convert to new API
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

This is GPL-2.0 not GPL-2.0-or-later and we can't change license for the
old tests unless it's a complete rewrite.

> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + * Copyright (c) Linux Test Project, 2003-2024
>   */
> -/**********************************************************
> - *
> - *    TEST IDENTIFIER   : fdatasync01
> - *
> - *    EXECUTED BY       : Any user
> - *
> - *    TEST TITLE        : Basic test for fdatasync(2)
> - *
> - *    TEST CASE TOTAL   : 1
> - *
> - *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
> - *
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	This is a Phase I test for the fdatasync(2) system call.
> - *	It is intended to provide a limited exposure of the system call.
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *	  Create a temp directory and cd to it
> - *	  Initialize filename and open it in write mode for each child process.
> - *
> - *	Test:
> - *	 Loop if the proper options are given.
> - *	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Issue FAIL message with errno.
> - *	  Otherwise, Issue PASS message.
> - *
> - *	Cleanup:
> - *	  Print errno log and/or timing stats if options given
> - *	  Remove temporary directory and all files in it.
> - *
> - * USAGE:  <for command-line>
> - *  fdatasync01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
> - *		where,  -c n : Run n copies concurrently.
> - *			-e   : Turn on errno logging.
> - *			-f   : Turn off functional testing
> - *			-h   : Show help screen
> - *			-i n : Execute test n times.
> - *			-I x : Execute test for x seconds.
> - *			-p   : Pause for SIGUSR1 before starting
> - *			-P x : Pause for x seconds between iterations.
> - *			-t   : Turn on syscall timing.
> +
> +/*\
> + * [Description]
>   *
> - ****************************************************************/
> -#include <errno.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include "test.h"
> + * Basic test for fdatasync(). Call fdatasync() on a fd and expect it to pass.
> + */
>  
> -static int fd;
> -static char filename[30];
> -static void setup(void);
> -static void cleanup(void);
> +#include "tst_test.h"
>  
> -char *TCID = "fdatasync01";
> -int TST_TOTAL = 1;
> +static int fd;
> +static char pfilename[30];
>  
> -int main(int argc, char **argv)
> +static void run(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/* Test the system call */
> -		TEST(fdatasync(fd));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "fdatasync() failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			/* No Functional verification yet */
> -			tst_resm(TPASS, "fdatasync() successful");
> -		}
> -	}
> -
> -	/* perform global cleanup and exit */
> -	cleanup();
> -
> -	tst_exit();
> -
> +	TST_EXP_PASS(fdatasync(fd), "fdatasync(%d)", fd);
>  }
>  
> -/* setup() - performs all ONE TIME setup for this test */
> -void setup(void)
> +static void setup(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	/* Pause if that option was specified
> -	 * TEST_PAUSE contains the code to fork the test with the -c option.
> -	 */
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>  	/* Initialize unique filename for each child process */

Such comments are useless and should be just removed.

> -	if (sprintf(filename, "fdatasync_%d", getpid()) <= 0) {
> -		tst_brkm(TBROK, cleanup, "Failed to initialize filename");
> -	}
> -	if ((fd = open(filename, O_CREAT | O_WRONLY, 0777)) == -1) {	//mode must be specified when O_CREATE is in the flag
> -		tst_brkm(TBROK, cleanup, "open() failed");
> -	}
> -	if ((write(fd, filename, strlen(filename) + 1)) == -1) {
> -		tst_brkm(TBROK, cleanup, "write() failed");
> -	}
> +	sprintf(pfilename, "fdatasync_%d", getpid());
> +
> +	/* mode must be specified when O_CREATE is in the flag */

Here as well.

> +	fd = SAFE_OPEN(pfilename, O_CREAT | O_WRONLY, 0777);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, pfilename, strlen(pfilename) + 1);
>  }
>  
> -/*
> - * cleanup()
> - *	performs all ONE TIME cleanup for this test at
> - *	completion or premature exit
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>  	close(fd);

It would be slightly better to close the fd only if it was opened and
with SAFE_CLOSE() i.e.

	if (fd > 0)
		SAFE_CLOSE(fd);

> -
> -	tst_rmdir();
> -
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,

I suppose that it would make sense to run this test for .all_filesystems
as well.

> +};
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
