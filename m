Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MXzFx-0005M0-41
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 15:15:21 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXzFr-0003Fv-46
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 15:15:21 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73F7XSr008181
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 11:07:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73FF6dB1802436
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 11:15:06 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73FEu1P009375
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 09:14:56 -0600
Date: Mon, 3 Aug 2009 10:14:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090803151449.GA29794@us.ibm.com>
References: <4A76D6DD.4020401@petalogix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A76D6DD.4020401@petalogix.com>
Subject: Re: [LTP] clone01 -c 10 on x86
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
To: Michal Simek <michal.simek@petalogix.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Quoting Michal Simek (michal.simek@petalogix.com):
> Hi All,
> 
> can you please to run clone01 syscall test on any x86 machine? I am
> getting fault there when I run it 10 times for example.
> The same problem I have on Microblaze.
> 
>  ./clone01  -c 10
> clone01     1  TPASS  :  clone() returned 22738
> clone01     1  TPASS  :  clone() returned 22740
> clone01     1  TPASS  :  clone() returned 22742
> clone01     1  TPASS  :  clone() returned 22748
> clone01     1  TPASS  :  clone() returned 22750
> clone01     1  TPASS  :  clone() returned 22752
> clone01     1  TPASS  :  clone() returned 22754
> clone01     1  TFAIL  :  clone() returned 134919589, errno = 22755
> [monstr@monstr clone]$ clone01     1  TPASS  :  clone() returned 22744
> clone01     1  TPASS  :  clone() returned 22746
> 
> Thanks,
> Michal

All right I don't have the patiente to wade through the parse_opts
and usc_lib crap, but this is not a clone failure.  What appears to
be happening is setup() at the top of clone01.c is calling
lib/parse_opts.c:usc_global_setup_hook(), with STD_COPIES set to the
count option you passed in.  That forks of 10 copies of the test.
I don't know what happens with the actual loop then, but the reason
you get the error for the last clone test is that one of those
forked copies of clone01 (*not* one of the cloned children) exits,
and wait() catches that one.  That is why wait() returned 22744,
which isn't any of the cloned children.

So one stupid way of fixing this without dealing with the convoluted
setup junk would be to change the waitpid chunk of the code like so:


--- /usr/src/ltp-intermediate-20090721/testcases/kernel/syscalls/clone/clone01.c	2009-03-23 09:35:39.000000000 -0400
+++ /usr/src/ltp-intermediate-20090721.patched/testcases/kernel/syscalls/clone/clone01.c	2009-08-03 11:11:25.000000000 -0400
@@ -130,6 +132,7 @@ int main(int ac, char **av)
 		     (do_child, child_stack + CHILD_STACK_SIZE, SIGCHLD, NULL));
 #endif
 
+again:
 		if ((child_pid = wait(&status)) == -1) {
 			tst_brkm(TBROK, cleanup, "wait() failed; error no ="
 				 " %d, %s", errno, strerror(errno));
@@ -138,11 +141,11 @@ int main(int ac, char **av)
 		/* check return code */
 		if (TEST_RETURN == child_pid) {
 			tst_resm(TPASS, "clone() returned %d", TEST_RETURN);
-		} else {
-			tst_resm(TFAIL, "clone() returned %d, errno = %d ",
-				 "wait() returned %d", TEST_RETURN, TEST_ERRNO,
+		} else if (TEST_RETURN == -1) {
+			tst_resm(TFAIL, "clone() returned %d, errno = %d wait() returned %d\n", TEST_RETURN, TEST_ERRNO,
 				 child_pid);
-		}
+		} else
+			goto again;
 
 	}			/* End for TEST_LOOPING */
 

-serge

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
