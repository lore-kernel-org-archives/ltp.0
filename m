Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIp1-0001Ga-Ml
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:08:51 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIou-0000U9-3F
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:08:51 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74C3MR1014102
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:03:22 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74C8UGg198792
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:08:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74C8U4b008317
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:08:30 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090803151449.GA29794@us.ibm.com>
References: <4A76D6DD.4020401@petalogix.com>
	<20090803151449.GA29794@us.ibm.com>
Date: Tue, 04 Aug 2009 17:38:09 +0530
Message-Id: <1249387690.15587.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] clone01 -c 10 on x86
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Mon, 2009-08-03 at 10:14 -0500, Serge E. Hallyn wrote: 
> Quoting Michal Simek (michal.simek@petalogix.com):
> > Hi All,
> > 
> > can you please to run clone01 syscall test on any x86 machine? I am
> > getting fault there when I run it 10 times for example.
> > The same problem I have on Microblaze.
> > 
> >  ./clone01  -c 10
> > clone01     1  TPASS  :  clone() returned 22738
> > clone01     1  TPASS  :  clone() returned 22740
> > clone01     1  TPASS  :  clone() returned 22742
> > clone01     1  TPASS  :  clone() returned 22748
> > clone01     1  TPASS  :  clone() returned 22750
> > clone01     1  TPASS  :  clone() returned 22752
> > clone01     1  TPASS  :  clone() returned 22754
> > clone01     1  TFAIL  :  clone() returned 134919589, errno = 22755
> > [monstr@monstr clone]$ clone01     1  TPASS  :  clone() returned 22744
> > clone01     1  TPASS  :  clone() returned 22746
> > 
> > Thanks,
> > Michal
> 
> All right I don't have the patiente to wade through the parse_opts
> and usc_lib crap, but this is not a clone failure.  What appears to
> be happening is setup() at the top of clone01.c is calling
> lib/parse_opts.c:usc_global_setup_hook(), with STD_COPIES set to the
> count option you passed in.  That forks of 10 copies of the test.
> I don't know what happens with the actual loop then, but the reason
> you get the error for the last clone test is that one of those
> forked copies of clone01 (*not* one of the cloned children) exits,
> and wait() catches that one.  That is why wait() returned 22744,
> which isn't any of the cloned children.
> 
> So one stupid way of fixing this without dealing with the convoluted
> setup junk would be to change the waitpid chunk of the code like so:

Yes, it fixes the issue.

Regards--
Subrata

> 
> 
> --- /usr/src/ltp-intermediate-20090721/testcases/kernel/syscalls/clone/clone01.c	2009-03-23 09:35:39.000000000 -0400
> +++ /usr/src/ltp-intermediate-20090721.patched/testcases/kernel/syscalls/clone/clone01.c	2009-08-03 11:11:25.000000000 -0400
> @@ -130,6 +132,7 @@ int main(int ac, char **av)
>  		     (do_child, child_stack + CHILD_STACK_SIZE, SIGCHLD, NULL));
>  #endif
> 
> +again:
>  		if ((child_pid = wait(&status)) == -1) {
>  			tst_brkm(TBROK, cleanup, "wait() failed; error no ="
>  				 " %d, %s", errno, strerror(errno));
> @@ -138,11 +141,11 @@ int main(int ac, char **av)
>  		/* check return code */
>  		if (TEST_RETURN == child_pid) {
>  			tst_resm(TPASS, "clone() returned %d", TEST_RETURN);
> -		} else {
> -			tst_resm(TFAIL, "clone() returned %d, errno = %d ",
> -				 "wait() returned %d", TEST_RETURN, TEST_ERRNO,
> +		} else if (TEST_RETURN == -1) {
> +			tst_resm(TFAIL, "clone() returned %d, errno = %d wait() returned %d\n", TEST_RETURN, TEST_ERRNO,
>  				 child_pid);
> -		}
> +		} else
> +			goto again;
> 
>  	}			/* End for TEST_LOOPING */
> 
> 
> -serge
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
