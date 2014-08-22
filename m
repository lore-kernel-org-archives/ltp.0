Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XKfPK-0000XH-An
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 03:20:54 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XKfPI-0006My-VC
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 03:20:54 +0000
Date: Thu, 21 Aug 2014 23:20:46 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <969059169.23021866.1408677646556.JavaMail.zimbra@redhat.com>
In-Reply-To: <53F5FEB8.7080203@oracle.com>
References: <389062153.22364213.1408594355921.JavaMail.zimbra@redhat.com>
	<53F5FEB8.7080203@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3 1/3] fcntl16: Skip fcntl16 tests on NFS
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Xiong Zhou" <xzhou@redhat.com>, ltp-list@lists.sourceforge.net
> Sent: Thursday, August 21, 2014 10:14:16 PM
> Subject: Re: [LTP][PATCH v3 1/3] fcntl16: Skip fcntl16 tests on NFS
> 
> Hi!
> 
> On 08/21/2014 08:12 AM, Xiong Zhou wrote:
> >
> > According to nfs(5), NLM supports advisory file locks only. So skip
> > fcntl16 test if NFS.
> >
> 
> I've just took a fresh look at fcntl16.c and found that block1  of this
> test case may be executed on NFS. And, IMHO, this block1 test case is
> not 100% implemented by other fcntl*.c tests.
> 
> So I think that it will be more correct to have only block2, block3 skipped.
> 

Yes, You are right. I should take more care of this earlier. And I am the person who should be Sorry. :)

> Sorry. I had to figure it out at the first time. :(
> 
> Thank you.
> 
> PS: And you pointed me one interesting issue.
> 
> The patch:
> 
> commit 5387ba03ce8eaddc7ec330ed03e579eed92596cc
> Author: subrata_modak <subrata_modak>
> Date:   Mon May 5 08:49:34 2008 +0000
> 
>      These test cases fail on the NFS environment due to NFS relates
> issue(s). Hence abondon these tests when NFS is detected. By, Sridhar
> Vinay <vinaysridhar@in.ibm.com>.
> 
> disabled entire tests and not particular test cases. And I think it's
> not quite correct, because some of the test cases may be executed on NFS.
> 
> For example, fcntl14.c has 4 test blocks, and only one of them doesn't
> work with NFS - block2 (mandatory locking).
> 
> Reviewing/fixing other fcntl*.c test cases looks like a useful activity.
> But for a later time :)

Thanks for pointing this out, I will take a look at this later.

Regards,
xzhou

> 
> 
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >   testcases/kernel/syscalls/fcntl/fcntl16.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > index 44b6a80..7dba6ea 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > @@ -51,6 +51,8 @@
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> >
> > +#include "tst_fs_type.h"
> > +
> >   #define SKIPVAL 0x0f00
> >   //#define       SKIP    SKIPVAL, 0, 0L, 0L, IGNORED
> >   #define SKIP 0,0,0L,0L,0
> > @@ -412,6 +414,12 @@ void setup(void)
> >
> >   	tst_tmpdir();
> >
> > +	/* On NFS or not */
> > +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> > +		tst_brkm(TCONF, cleanup, "Cannot test madatory locking "
> > +			"on a file located on an NFS filesystem");
> > +	}
> > +
> >   	/* set up temp filename */
> >   	sprintf(tmpname, "fcntl4.%d", parent);
> >
> >
> 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
