Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M4rgI-0002PX-2O
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:18:10 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4rg8-0006Rf-DN
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:18:10 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4F7EH1X019532
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:14:17 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4F7He9M214630
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:17:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4F7Heq0013650
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:17:40 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090513.224735.226784134.caiqian@cclom.cn>
References: <4A09F967.8030402@web.de>
	<20090513.224735.226784134.caiqian@cclom.cn>
Date: Fri, 15 May 2009 12:47:36 +0530
Message-Id: <1242371857.7224.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix the splice02 test
Reply-To: subrata@linux.vnet.ibm.com
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
To: jpalecek@web.de
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-05-13 at 22:47 +0800, CAI Qian wrote: 
> From: Jiri Palecek <jpalecek@web.de>
> Subject: [LTP] [PATCH] Fix the splice02 test
> Date: Wed, 13 May 2009 00:34:15 +0200
> 
> >   Particularly:
> > 
> >    - TEST_ERRNO is only set when the syscall is executed using the
> >      TEST() macro. The tests gave bad error messages because of that.
> > 
> >    - The end of the test was dead code; moved the TPASS code to pass at
> >      the end of file.
> > 
> >    - The test assumes std. input is a pipe; reflect this in the runtest
> >      file
> > 
> > Regards
> >      Jiri Palecek
> > 
> > Signed-off-by: Jiri Palecek <jpalecek@web.de>
> > ---
> >   runtest/syscalls                            |    2 +-
> >   testcases/kernel/syscalls/splice/splice02.c |   16 ++++++----------
> >   2 files changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 9b7b2ca..33beff0 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -1033,7 +1033,7 @@ sockioctl01 sockioctl01
> >    #splice test
> >   splice01 splice01
> > -splice02 echo "Test splice02()" > splice02-temp; splice02 splice02-temp
> > +splice02 seq 1 10000000 | splice02 splice02-temp
> >    tee01 tee01
> >   diff --git a/testcases/kernel/syscalls/splice/splice02.c 
> > b/testcases/kernel/syscalls/splice/splice02.c
> > index 321d002..16bff86 100644
> > --- a/testcases/kernel/syscalls/splice/splice02.c
> > +++ b/testcases/kernel/syscalls/splice/splice02.c
> > @@ -108,7 +108,6 @@ void setup() {
> >    int main(int ac, char **av) {
> >   	int fd = 0;
> > -	int ret = 0;
> >   	
> >           setup();
> >   @@ -118,26 +117,23 @@ int main(int ac, char **av) {
> >   	}
> >   	fd=open(av[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
> >   	if(fd < 0 ) {
> > -           tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, 
> > strerror(TEST_ERRNO));
> > +		tst_resm(TFAIL, "open(%s) failed - errno = %d : %s", av[1], errno, 
> > strerror(errno));
> >   	   cleanup();
> >   	   tst_exit();
> >   	}
> >   			
> >           do {
> > -	    ret = splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0);
> > -	    if (ret < 0) {
> > -            	tst_resm(TFAIL, "%s failed - errno = %d : %s",TCID, TEST_ERRNO, 
> > strerror(TEST_ERRNO));
> > +					TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
> > +	    if (TEST_RETURN < 0) {
> > +            	tst_resm(TFAIL, "splice failed - errno = %d : %s", TEST_ERRNO, 
> > strerror(TEST_ERRNO));
> >   	        cleanup();
> >   		tst_exit();
> >   	    } else
> > -            if (ret < SPLICE_SIZE){
> > +            if (TEST_RETURN == 0){
> > +							tst_resm(TPASS, "splice() system call Passed");
> >   	        cleanup();
> >   	        tst_exit();
> >   	    }
> >   	} while(1);
> > -
> > -	close(fd);
> > -        tst_resm(TPASS, "splice() system call Passed");
> > -        tst_exit();
> >   }
> >   -- 1.6.2
> 
> Can't apply this patch -- long lines are wrapped. Please re-send it.

True. Here i get:

ERROR: patch seems to be corrupt (line wrapped?)
#131: FILE: runtest/syscalls:1037:
b/testcases/kernel/syscalls/splice/splice02.c
total: 1 errors, 0 warnings, 16 lines checked

and

patching file runtest/syscalls
patch: **** malformed patch at line 131:
b/testcases/kernel/syscalls/splice/splice02.c

Regards--
Subrata

> CAI Qian
> 
> ------------------------------------------------------------------------------
> The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
> production scanning environment may not be a perfect world - but thanks to
> Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
> Series Scanner you'll get full speed at 300 dpi even with all image 
> processing features enabled. http://p.sf.net/sfu/kodak-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
