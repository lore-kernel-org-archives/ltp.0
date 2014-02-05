Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WB42j-0005fi-Qm
	for ltp-list@lists.sourceforge.net; Wed, 05 Feb 2014 15:05:37 +0000
Date: Wed, 5 Feb 2014 16:05:01 +0100
From: chrubis@suse.cz
Message-ID: <20140205150500.GB28615@rei.suse.cz>
References: <1387364436.1634.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387364436.1634.2.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 2/2] msgctl/msgctl13.c: add EIDRM test
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
> new file mode 100644
> index 0000000..f5a0c38
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
> @@ -0,0 +1,107 @@
> +/*
> + * Copyright (c) 2013 Fujitsu Ltd.
> + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program.
> + */
> +
> +#define _GNU_SOURCE

This shouldn't be needed, IPC_RMDIR is not Linux specific, or do I miss
something?

> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "ipcmsg.h"
> +
> +static int msg_q;
> +
> +static void setup1(void);
> +
> +static struct test_case_t {
> +	int *queue_id;
> +	int ipc_cmd;
> +	char *name;
> +	void (*setup)(void);
> +} test_cases[] = {
> +	{&msg_q, IPC_RMID, "IPC_RMID", setup1},
> +};
> +
> +char *TCID = "acct13";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);

It does not make much sense to create test case structure for single
testcase. Do you plan to add more testcases here?

> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +	int i;
> +	struct msqid_ds qs_buf;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +
> +			if (test_cases[i].setup != NULL)
> +				test_cases[i].setup();
> +
> +			TEST(msgctl(*test_cases[i].queue_id,
> +				    test_cases[i].ipc_cmd, &qs_buf));
> +
> +			if (TEST_RETURN != 0 || TEST_ERRNO != IPC_RMID) {

                         TEST_ERRNO != IPC_RMID looks like a typo to me.
			 (it does not make any sense)

> +				tst_resm(TFAIL,
> +					 "msgctl() test %s failed with errno: "
> +					 "%d", test_cases[i].name, TEST_ERRNO);
> +			} else {
> +				tst_resm(TPASS, "msgctl() test %s succeeded",
> +					 test_cases[i].name);
> +			}

                        Also what about checking that the queue was
			really removed (msgget() without CREAT fails
			with ENOENT)?

> +		}
> +	}
> +
> +	cleanup();
> +
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();

Again, no need to create temporary directory.

> +	msgkey = getipckey();
> +}
> +
> +static void setup1(void)
> +{
> +	msg_q = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
> +	if (msg_q == -1)
> +		tst_brkm(TBROK, cleanup, "Can't create message queue");
> +}
> +
> +void cleanup(void)
> +{
> +	tst_rmdir();
> +
> +	TEST_CLEANUP;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
