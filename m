Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMcXW-0006ur-VX
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 13:45:58 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMcXU-0003Uc-TQ
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 13:45:58 +0000
Date: Tue, 4 Aug 2015 15:45:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150804134533.GA16645@rei.suse.de>
References: <1438665536-24945-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438665536-24945-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH] ipc/msgrcv: add new testcase msgrcv08
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> @@ -0,0 +1,135 @@
> +/*
> + * Copyright (c) 2015   Author: Gabriellla Schmidt <gsc@bruker.de>
> + *                      Modify: Li Wang <liwang@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * you should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/*
> + * Description:
> + *
> + * A regression test for:
> + *      commit e7ca2552369c1dfe0216c626baf82c3d83ec36bb
> + *      Author: Mateusz Guzik <mguzik@redhat.com>
> + *      Date:   Mon Jan 27 17:07:11 2014 -0800
> + *
> + *           ipc: fix compat msgrcv with negative msgtyp
> + *
> + * Reproduce:
> + *
> + *      32-bit application using the msgrcv() system call
> + *      gives the error message:
> + *
> + *           msgrcv: No message of desired type
> + *
> + *      If this progarm is compiled as 64-bit application it works.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include "test.h"
> +
> +const char *TCID = "msgrcv08";
> +const int TST_TOTAL = 1;
> +
> +#if __WORDSIZE == 32
> +
> +struct msgbuf {
> +	long mtype;     /* message type, must be > 0 */
> +	char mtext[16]; /* message data */
> +};
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);

Do we really need to be root to run the testcase?

> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +}

No empty cleanups please. If there is nothing to be cleaned up simply do
not implement the function at all.

> +static int msr(int msqid)
> +{
> +	struct msgbuf msbs;
> +	struct msgbuf msbr;
> +	ssize_t sret;
> +	long   mtype = 121;
            ^
	    Only single space here please.

> +	memset(&msbs, 0, sizeof(msbs));
> +	msbs.mtype = mtype;
> +
> +	if (msgsnd(msqid, &msbs, sizeof(msbs.mtext), IPC_NOWAIT))
> +		tst_brkm(TBROK, NULL, "msgsnd error");
                            ^
			    Should be TBROK | TERRNO so that we know
			    the reason of the failure.

> +
> +	sret = msgrcv(msqid, &msbr, sizeof(msbr.mtext), -mtype, IPC_NOWAIT | MSG_NOERROR);
> +
> +	if (sret < 0) {
> +		tst_resm(TFAIL, "Bug: No message of desired type.");
> +		return -1;
> +	}
> +
> +	if (msbr.mtype != mtype)
> +		tst_brkm(TBROK, NULL,
> +			"found mtype %ld, expected %ld\n", msbr.mtype, mtype);
> +
> +	if ((size_t)sret != sizeof(msbs.mtext))
> +		tst_brkm(TBROK, NULL, "received %lu, expected %lu\n",
> +			(unsigned long)sret, (unsigned long)sizeof(msbs.mtext));

Use %zi and %zu instead of the %lu and drop the casts to unsigned long.

> +
> +	return 0;
> +}
> +
> +static void msgrcv_test(void)
> +{
> +	int ret;
> +	int msqid = msgget(IPC_PRIVATE, IPC_CREAT | IPC_EXCL | 0666);
> +
> +	if (msqid < 0)
> +		tst_brkm(TBROK, NULL, "msgget error");
                         ^
			 Add the TERRNO here as well

> +	ret = msr(msqid);
> +
> +	if (msgctl(msqid, IPC_RMID, 0))
> +		tst_brkm(TBROK, NULL, "msgctl error");
                         ^
			 And here as well.

> +	if (!ret)
> +		tst_resm(TPASS, "Hi, no regression found!");

What about nstead of passing the value here to print the TPASS message
we call it at the end of the msr() function instead of doing return 0; ?

Also please drop the "Hi, " from the message ;).

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		msgrcv_test();
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +#else /* no 64-bit */
> +int main(void)
> +{
> +		tst_brkm(TCONF, NULL, "not works when compiled as 64-bit application.");
       ^
       Please use tabs for indentation only.

> +}
> +#endif
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
