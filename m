Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1NV6TG-0007mx-K0
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 16:53:26 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NV6TD-0007aW-Uo
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 16:53:26 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0DGm4IH002912
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:48:04 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0DGqvvi181238
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:52:59 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0DGquDd007665
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:52:57 -0700
From: Lucio Correia <ljhc@br.ibm.com>
In-Reply-To: <364299f41001120221g65e8a98dy9360c1d35238b469@mail.gmail.com>
References: <000001ca79f4$7869a110$693ce330$@co.jp>
	<135282C4-83A6-43D5-9D26-D711482A88A1@gmail.com>
	<1263235304.18451.3.camel@lucio-t400>
	<364299f41001120221g65e8a98dy9360c1d35238b469@mail.gmail.com>
Date: Wed, 13 Jan 2010 14:52:54 -0200
Message-Id: <1263401574.7900.12.camel@lucio-t400>
Mime-Version: 1.0
Subject: Re: [LTP] "libevent01" test failure with ltp-2009-12-10 cvs
Reply-To: ljhc@br.ibm.com
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
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

I'm running on a ppc64 machine.

From ltp all tests run .log file:

lchown02    7  TPASS  :  lchown() fails, Path contains regular file,
errno:20
sh: run_libevent.sh: command not found
link01      1  TPASS  :  link(2) to a symbolic link, which is pointing
to an existing object file worked - file created and link count adjusted

I searched for run_libevent.sh and found it
at /opt/ltp/testcases/bin/libevent dir.

I'm running it manually by (same commands .failcmdfile gives):

# export LTPROOT; run_libevent.sh
bash: run_libevent.sh: command not found
# export LTPROOT; ./testcases/bin/libevent/run_libevent.sh
Running tests:
KQUEUE
Skipping test
POLL
Skipping test
SELECT
Skipping test
RTSIG
Skipping test
EPOLL
Skipping test
libevent01    0  TINFO  :  Cleaning up.

Thanks,

-  
Lucio Correia
Software Engineer
IBM LTC Brazil


On Tue, 2010-01-12 at 02:21 -0800, Garrett Cooper wrote:
> On Mon, Jan 11, 2010 at 10:41 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
> > Hi Garrett,
> >
> > I'm still running into this issue with LTP-20091231
> 
> Hi Lucio,
> What's the error message and how are you trying to run the test?
> Thanks,
> -Garrett
> 
> > On Fri, 2009-12-11 at 01:56 -0800, Garrett Cooper wrote:
> >> On Dec 10, 2009, at 3:57 PM, Mitani wrote:
> >>
> >> > Hi,
> >> >
> >> > I got following message when I ran test of "libevent01" with
> >> > ltp-2009-12-10 cvs.
> >> >
> >> > ------------
> >> > sh: run_libevent.sh: command not found
> >> > ------------
> >> >
> >> > This occured because "run_libevent.sh" was not installed under the
> >> > "/opt/ltp" directory, I think.
> >> >
> >> > Certainly, this test successed when I copied
> >> > "${LTPROOT}/testcases/kernel/syscalls/libevent/run_libevent.sh" file
> >> > to the "/opt/ltp/testcases/bin" directory.
> >> >
> >> > So, I want to suggest the following revision:
> >> >
> >> > 1. Install "run_libevent.sh" to under the "/opt/ltp/testcases/bin"
> >> >   directory by default.
> >> >  (I don't know how to revise Makefile etc.)
> >> >
> >> > 2. Apply the following patch to "run_libevent.sh".
> >> >
> >> > ============
> >> > --- run_libevent.sh 2009-11-20 04:08:36.000000000 +0900
> >> > +++ run_libevent.sh.new     2009-12-10 16:44:02.000000000 +0900
> >> > @@ -31,7 +31,7 @@
> >> >     tst_resm TCONF "You need to be root to run these tests"
> >> >     TST_EXIT=0
> >> > else
> >> > -   "$LTPROOT/testcases/bin/tests/test-libevent.sh"
> >> > +   "$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
> >> >     TST_EXIT=$?
> >> > fi
> >> > tst_cleanup
> >> > ============
> >>
> >> Done -- thanks!


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
