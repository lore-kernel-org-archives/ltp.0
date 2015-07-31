Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1ZLAxt-00061N-Uk
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 14:07:13 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZLAxr-0006v0-1D
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 14:07:13 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t6VE75EY019992
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 10:07:05 -0400
Date: Fri, 31 Jul 2015 10:07:04 -0400 (EDT)
From: Li Wang <liwang@redhat.com>
Message-ID: <481838215.1118179.1438351624934.JavaMail.zimbra@redhat.com>
In-Reply-To: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
References: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] How to compie a ltp-case into 32-bit on the 64bit system
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
To: ltp-list@lists.sourceforge.net

The program is here.

msgrcv08.c
----------- 
/*
 * Copyright (c) 2015   Author: Gabriellla Schmidt <gsc@bruker.de>
 *                      Modify: Li Wang <liwang@redhat.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it would be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * you should have received a copy of the GNU General Public License along
 * with this program; if not, write the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

/*
 * Description:
 *
 * A regression test for:
 * 	commit e7ca2552369c1dfe0216c626baf82c3d83ec36bb
 * 	Author: Mateusz Guzik <mguzik@redhat.com>
 *	Date:   Mon Jan 27 17:07:11 2014 -0800
 *
 *     		ipc: fix compat msgrcv with negative msgtyp
 *
 * Reproduce:
 *
 *	32-bit application using the msgrcv() system call
 *	gives the error message:
 *
 *		msgrcv: No message of desired type
 *
 *	If this progarm is compiled as 64-bit application it doesn't works.
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include "test.h"

const char *TCID = "msgrcv08";
const int TST_TOTAL = 1;

struct msgbuf
{
	long mtype;     /* message type, must be > 0 */
	char mtext[16]; /* message data */
};

static void setup(void)
{
	tst_require_root(NULL);

	TEST_PAUSE;
}

static void cleanup(void)
{
}

static int msr(int msqid)
{
	struct msgbuf msbs;
	struct msgbuf msbr;
	ssize_t sret;
	long   mtype = 121;

	memset(&msbs, 0, sizeof(msbs));
	msbs.mtype = mtype;

	if (msgsnd(msqid, &msbs, sizeof(msbs.mtext), IPC_NOWAIT))
		tst_brkm(TBROK, NULL, "msgsnd error");

	sret = msgrcv(msqid, &msbr, sizeof(msbr.mtext), -mtype, IPC_NOWAIT | MSG_NOERROR);

	if (sret < 0) {
		tst_resm(TFAIL, "Bug: No message of desired type.");
		return -1;
	}

	if (msbr.mtype != mtype)
		tst_brkm(TBROK, NULL, "found mtype %ld, expected %ld\n", msbr.mtype, mtype);

	if ((size_t)sret != sizeof(msbs.mtext))
		tst_brkm(TBROK, NULL, "received %lu, expected %lu\n",
				(unsigned long)sret, (unsigned long)sizeof(msbs.mtext));

	return 0;
}

static void msgrcv_test(void)
{
	int ret;
	int msqid = msgget(IPC_PRIVATE, IPC_CREAT | IPC_EXCL | 0666);

	if (msqid < 0)
		tst_brkm(TBROK, NULL, "msgget error");

	ret = msr(msqid);

	if (msgctl(msqid, IPC_RMID, 0))
		tst_brkm(TBROK, NULL, "msgctl error");

	if (!ret)
		tst_resm(TPASS, "Hi, no regression found!");
}

int main(int argc, char *argv[])
{
	int lc;

	tst_parse_opts(argc, argv, NULL, NULL);

	setup();

	for (lc = 0; TEST_LOOPING(lc); lc++)
		msgrcv_test();

	cleanup();
	tst_exit();
}

-- 
Regards, 
Li Wang 
Email: liwang@redhat.com 


----- Original Message -----
> Hi all,
> 
> I am going to add a new testcase:
> ltp/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> for regression test.
> 
> But the key point is that this program 'msgrcv08.c' should be compiled into
> 32-bit,
> if it is compiled as 64-bit application it doesn't work.
> 
> 
> So, I try to add one line in the .../ipc/msgrcv/Makefile:
> 
>   msgrcv08: CFLAGS+=-m32
> 
> and I get some compile errors like:
> -----
> # make
> make -C ../lib -f
> "/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib/Makefile"
> all
> make[1]: Entering directory
> `/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/lib'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory
> `/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/lib'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2
> -Wold-style-definition -m32 -D_FORTIFY_SOURCE=2
> -I/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/include
> -I/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib
> -I../../../../../include -I../../../../../include
> -L/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib
> -L../../../../../lib  msgrcv08.c   -lltp -lipc -o msgrcv08
> /usr/bin/ld: skipping incompatible ../../../../../lib/libltp.a when searching
> for -lltp
> /usr/bin/ld: cannot find -lltp
> /usr/bin/ld: skipping incompatible
> /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib/libipc.a
> when searching for -lipc
> /usr/bin/ld: cannot find -lipc
> collect2: error: ld returned 1 exit status
> make: *** [msgrcv08] Error 1
> -----
> 
> these because the libltp.a is 64-bit.
> 
> 
> Then, I came up with a idea that I don't include the ltp-lib file in
> 'msgrcv08.c',
> and just add two lines in the .../ipc/msgrcv/Makefile:
> 
>   msgrcv08:
> 	gcc -g -O2 -Wall -m32 msgrcv08.c -o msgrcv08
> 
> It works for me, but I know it's not appropriate for LTP management.
> 
> What should I do? or, Is there any good way to solve this problem?
> 
> Thanks~
> 
> --
> Regards,
> Li Wang
> Email: liwang@redhat.com
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
