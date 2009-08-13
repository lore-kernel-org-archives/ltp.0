Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mbdwm-0006Pp-NC
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 17:18:40 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mbdwi-0005Zp-Ff
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 17:18:40 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7DHGjQ9007861
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 11:16:46 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7DHIIL1212032
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 11:18:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7DHIEvZ029080
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 11:18:15 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A833919.9040603@canonical.com>
References: <4A833919.9040603@canonical.com>
Date: Thu, 13 Aug 2009 22:47:58 +0530
Message-Id: <1250183880.6656.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Add option to skip tests
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
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Hi Paul,

On Wed, 2009-08-12 at 16:50 -0500, Paul Larson wrote: 
> One problem that LTP has long suffered is that certain tests are known
> to be broken, sometimes for long periods of time.  In an ideal world, I
> think it best that these should be skipped, or at least removed from the
> default list of tests to run, but this isn't always practical due to a
> number of reasons.  Of course, another option is that a 'whitelist' of
> tests to run can be created and passed to runltp, but this becomes hard
> to maintain as there are often new tests that you may want to keep up
> with, and with each release of LTP, the list would have to be reexamined.
> 
> So I wanted to see what people thought about a simple option, -S, to
> specify a list of tests that you want to blacklist from the current run.
>  This is handy if you have an automated testing environment with an
> architecture that doesn't always get great attention and a list of tests
> that you know to be broken on that arch.

This indeed is a good approach. Each test engineer can maintain a list
of tests in afile which he is not interested to run or does not suit
his/her test environment. Then doing

./runltp -S <filename>

he can just skip to run these subset of test.

However, i am not able to achieve the same results post application of
this patch. I created my own version of runtest/math and runtest/math.x.
I want runltp to skip all tests mentioned mentioned in math.x and run
the remaining mentioned in math. However when i run the following i see
runltp still runs all the tests inside runtest/math:

$ cat runtest/math.x 
abs01 abs01
atof01 atof01
fptest01 fptest01
fptest02 fptest02

$ cat runtest/math
abs01 abs01
atof01 atof01
fptest01 fptest01
fptest02 fptest02
nextafter01 nextafter01

$./runltp -S math.x -f math

<<<test_start>>>
tag=abs01 stime=1250180349
cmdline="abs01"
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01 stime=1250180349
cmdline="atof01"
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01 stime=1250180349
cmdline="fptest01"
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02 stime=1250180349
cmdline="fptest02"
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01 stime=1250180349
cmdline="nextafter01"
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>

I thought that math.x should just have the name of the test not to be
run. So, i just retained only the tag_names, and removed anything else,
but still i get the following output:

$ cat runtest/math.x.2 
abs01 
atof01
fptest01
fptest02

$ ./runltp -S math.x.2 -f math

<<<test_start>>>
tag=abs01 stime=1250180546
cmdline="abs01"
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01 stime=1250180546
cmdline="atof01"
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01 stime=1250180546
cmdline="fptest01"
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02 stime=1250180546
cmdline="fptest02"
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01 stime=1250180546
cmdline="nextafter01"
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Is there something which i am missing out ?

Regards--
Subrata

> 
> The skipfile is simply a list of test names, one per line.
> 
> Thanks,
> Paul Larson
> ---
> 
> Add a -S option to runltp that allows the user to specify a SKIPFILE of
> tests to skip.
> 
> Signed-off-by: Paul Larson <paul.larson@canonical.com>
> ---
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
