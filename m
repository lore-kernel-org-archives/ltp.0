Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PLmRQ-0000iK-Ta
	for ltp-list@lists.sourceforge.net; Fri, 26 Nov 2010 00:45:32 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLmRP-0001XE-Ib
	for ltp-list@lists.sourceforge.net; Fri, 26 Nov 2010 00:45:32 +0000
Date: Thu, 25 Nov 2010 19:45:24 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1778429352.495721290732324614.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1456973476.495611290731859465.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mbind_range() vma merge
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>


> Please do an inline and patch submit next time. Patch reviewing that
> isn't inline in the email body is a bit annoying...
OK.

> +LDLIBS 			+= -lnuma
> 
> gcooper> Do $(NUMA_LIBS) instead.
OK.

> +#include <numaif.h>
> +#include <numa.h>
> +#include <sys/mman.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "test.h"
> +#include "usctest.h"
> 
> gcooper> This will cause breakage on systems without proper numa lib
> support *cues some RHEL users from Ryobi on the list :)...*
Right, I'll add a autoconf check for this.

> +static void usage(void);
> 
> gcooper> Get rid of this function please (unused).
I saw this has been discussed, so presumable you are fine with it.

> +	if (opt_node) {
> +		node = strtol(optarg, NULL, 0);
> 
> gcooper> This is wrong. The value that gets passed into node is an
> unsigned integer, not a long. Also, what if the value passed in was
> invalid (say -1)?
OK.

> +		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
> +			MAP_ANON|MAP_PRIVATE, 0, 0);
> +		if (addr == MAP_FAILED)
> +			tst_brkm(TBROK|TERRNO, NULL, "mmap"), exit(1);
> 
> gcooper> Remove exit(1) please...
I saw this has been discussed as well. Looks like the best option right now would be tst_brkm(TBROK|TERRNO, tst_exit, "mmap");

> 
> +		tst_resm(TINFO, "pid = %d", getpid());
> +		tst_resm(TINFO, "addr = %p", addr);
> 
> gcooper> Consolidate to one call please (also, do you _really_ need
> to
> print out the pid info?).
OK. pid is something there to be able to debug when the test goes wrong.


> 
> +		/* make page populate */
> +		memset(addr, 0, pagesize*3);
> +
> +		/* first mbind */
> +		err = mbind(addr+pagesize, pagesize, MPOL_BIND,
> +			nmask->maskp, nmask->size, MPOL_MF_MOVE_ALL);
> +		if (err)
> 
> gcooper> For the sake of correctness this should be -1.
Yes.

> 
> +			tst_brkm(TBROK|TERRNO, NULL, "mbind1");
> +
> +		/* second mbind */
> +		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
> +		if (err)
> 
> gcooper> Same as above.
OK.

> 
> +			tst_brkm(TBROK|TERRNO, NULL, "mbind2 ");
> +
> +		/* /proc/%d/maps in the form of
> +		   "00400000-00406000 r-xp 00000000". */
> +		sprintf(buf, "/proc/%d/maps", getpid());
> +		sprintf(string, "%lx", (long)addr);
> 
> gcooper> I know it may seem a bit obtuse, but couldn't do you %p
> instead, and increment the pointer to the buffer by 2 to achieve the
> same result? The point I'm driving at is that this casting is
> probably
> going to be incorrect in some cases.
Fine for me.

> 
> +		fp = fopen(buf, "r");
> +		if (fp == NULL)
> +			tst_brkm(TBROK|TERRNO, NULL, "fopen");
> 
> gcooper> Please describe what file you were trying to open that
> failed.
That is doable.

> +			/* Get the end range of the 2nd VMA. */
> +			p = strtok(NULL, " ");
> 
> gcooper> What if this token isn't found?
I will rewrite here to use sscanf which might be more straightforward.


> +		if (fclose(fp) == EOF)
> +			tst_brkm(TWARN|TERRNO, NULL, "fclose");
> 
> gcooper> I wouldn't worry about the fclose failing, because this
> could
> invariably turn into noise.
OK.

> +		if (munmap(addr, pagesize*3) == -1)
> +			tst_brkm(TWARN|TERRNO, NULL, "munmap");
> 
> gcooper> This is correct though.
This one needs tst_exit too.

> +void usage(void)
> +{
> +	printf("  -n      Number of NUMA nodes\n");
> +}
> 
> gcooper> Get rid of this function please (unused).
Discussed before. Thanks.

CAI Qian

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
