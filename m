Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZRfgK-0003fS-6o
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 12:07:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRfgI-0000oA-28
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 12:07:56 +0000
Date: Tue, 18 Aug 2015 14:07:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150818120722.GA21949@rei.suse.de>
References: <1437391371-6331-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1437391371-6331-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] Add capset_check_simple in runtest.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) International Business Machines  Corp., 2008                 */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program.                                                   */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <stdio.h>
> +#include "config.h"
> +#include "test.h"
> +#if HAVE_SYS_CAPABILITY_H
> +#include <linux/types.h>
> +#include <sys/capability.h>
> +#endif
> +
> +char *TCID = "filecaps01";

                    ^
		    Since TCID is set to filecaps01 it would make more
		    sense to rename the file to filecaps01.c so that the
		    filename and TCID match.

> +int TST_TOTAL = 1;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +}

Looking at this test in particular it doesn't need temporary directory,
so we can omit this.

> +int main(int argc, char *argv[])
> +{
> +#ifdef HAVE_LIBCAP
> +	int lc;
> +	cap_t caps, caps2;
> +	int ret;
> +#endif
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +	setup();
> +
> +#ifdef HAVE_LIBCAP
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		caps = cap_from_text("cap_setpcap+ep");
> +		caps2 = cap_from_text("cap_setpcap+ep");
> +		ret = cap_set_proc(caps);
> +		if (ret != 0)
> +			tst_resm(TFAIL, "cap_set_proc failure");
                            ^
			    This should be tst_brkm(TBROK, ...); so that
			    we exit the test if the preparation failed.

> +		ret = cap_compare(caps, caps2);

This seems really strange, we compile two identical capabilities from
string and then compare them for equality. Shouldn't the code rather:

* prepare capability from string
* set the capability
* get the capability back
* compare the compiled value with the one we get back

Otherwise this test does not make much sense to me.

> +		if (ret != 0)
> +			tst_resm(TFAIL, "Caps were not the same.");
> +
> +		cap_free(caps);
> +		cap_free(caps2);
> +		tst_resm(TPASS, "Caps were the same.");
                 ^
		 You must not print TPASS if the test

> +	}
> +#else
> +	tst_resm(TFAIL, "System doesn't support full POSIX capabilities.");
                  ^
		  This should be tst_brkm(TCONF, ...);

		  Usually testcases tend to have separate main()
		  function for the case that some functionality was
		  missing upon compilation rather than spreading
		  #ifdefs around the code. I.e.

		  #ifdef HAVE_FOO
                  int main(int argc, char *argv[])
		  {
                        /* do the test here */
			...
		  }
		  #else
		  int main(void)
		  {
			tst_brkm(TCONF, "...");
		  }
		  #endif /* HAVE_FOO */
> +#endif
> +	cleanup();
> +	tst_exit();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
