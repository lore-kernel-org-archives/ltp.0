Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQuJd-0000aj-U4
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 09:01:05 +0000
Date: Thu, 26 Feb 2015 10:00:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226090012.GA12353@rei.suse.de>
References: <1424764001.2546.15.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424764001.2546.15.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] gethostbyname_r01: check whether a system is
 vulnerable or not.
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

> +/*
> + *   Copyright (c) 2015 Fujitsu Ltd.
> + *   Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + */
> +
> +/*
> + * This is a test for glibc bug:
> + * https://www.qualys.com/research/security-advisories/GHOST-CVE-2015-0235.txt
> + */
> +
> +#include <netdb.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include "test.h"
> +
> +#define CANARY "in_the_coal_mine"
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void check_vulnerable(void);
> +
> +static struct {
> +	char buffer[1024];
> +	char canary[sizeof(CANARY)];
> +} temp = {
> +	"buffer",
> +	CANARY,
> +};
> +
> +char *TCID = "gethostbyname_r01";
> +int TST_TOTAL = 1;
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	const char *msg;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		check_vulnerable();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, NULL);
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +}

What is the point of empty cleanup()? If cleanup is not needed we do not
have to define an empty function and call it at the end of the test.

> +static void check_vulnerable(void)
> +{
> +	struct hostent resbuf;
> +	struct hostent *result;
> +	int herrno;
> +	int retval;
> +	char name[sizeof(temp.buffer)];
> +	size_t len;
> +
> +	len = sizeof(temp.buffer) - 16 - 2 * sizeof(char *) - 1;

What is the point of this complicated arithemtic?

> +	memset(name, '0', len);
> +	name[len] = '\0';
> +
> +	retval = gethostbyname_r(name, &resbuf, temp.buffer,
> +				 sizeof(temp.buffer), &result, &herrno);
> +
> +	if (strcmp(temp.canary, CANARY) != 0) {
> +		tst_resm(TFAIL, "vulnerable");
> +		return;
> +	}
> +
> +	if (retval == ERANGE) {
> +		tst_resm(TPASS, "not vulnerable");
> +		return;
> +	}
> +
> +	tst_resm(TFAIL, "should not happen");

Better failure message here please. I guess from the code that
gethostbyname_r returns errno then something like:

tst_resm(TFAIL,
         "gethostbyname_r() returned %s, expected ERANGE",
         tst_strerrno(retval));

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
