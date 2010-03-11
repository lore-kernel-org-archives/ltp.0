Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NpWRs-0000Zu-Ez
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 00:40:24 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpWRq-00041V-Tp
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 00:40:24 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000a01cac032$c4126c80$4c374580$@co.jp>
	<20100310104919.GA11404@linux.vnet.ibm.com>
In-Reply-To: <20100310104919.GA11404@linux.vnet.ibm.com>
Date: Thu, 11 Mar 2010 09:40:13 +0900
Message-ID: <001101cac0b3$69919cf0$3cb4d6d0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] "check_for_unshare.c" build failed
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
To: 'Rishikesh K Rajak' <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi, Rishikesh


I tried to build again with recent git today and I could build.

I neglected attention and did not notice new git.

I'm sorry and thank you for your information!


-Tomonori Mitani


> -----Original Message-----
> From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]
> Sent: Wednesday, March 10, 2010 7:49 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] "check_for_unshare.c" build failed
> 
> Hi Mitani,
> 
> I am able to compile with changing LDLIBS as done by commit
> : 1a5506c97dcfda0bd16f83ca855bb633c47eea4c
> 
> on RHEL5.4 .
> 
> Can you try configuring once again ?
> 
> Let me know when you face again some prob.
> 
> -Rishi
> 
> On Wed, Mar 10, 2010 at 06:19:20PM +0900, Mitani wrote:
> > Hi,
> >
> >
> > I tried to build LTP modules from following git:
> >
> >    "Fix make filed,, reported by Shi Weihua <shiwh@cn.fujitsu.com>"
> >    (ltp-dev-c962f51674b971496e14ac4be0cc75da98b75fca.tar.gz)
> >
> > But I failed to build "check_for_unshare.c" in RHEL5.4 system
> > (2.6.18-164.el5).
> >
> > ------------
> > <...>
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I../../../include
> > -I../../../include   -L../../../lib  check_for_unshare.c   -o
> > check_for_unshare
> > /tmp/ccWzyOQO.o: In function `main':
> >
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/chec
> k_for_unsh
> > are.c:40: undefined reference to `dlopen'
> >
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/chec
> k_for_unsh
> > are.c:46: undefined reference to `dlerror'
> >
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/chec
> k_for_unsh
> > are.c:47: undefined reference to `dlsym'
> >
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/chec
> k_for_unsh
> > are.c:48: undefined reference to `dlerror'
> >
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/chec
> k_for_unsh
> > are.c:53: undefined reference to `dlclose'
> >
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/chec
> k_for_unsh
> > are.c:42: undefined reference to `dlerror'
> > collect2: ld returned 1 exit status
> > make[3]: *** [check_for_unshare] Error 1
> > <...>
> > ------------
> >
> >
> > I think that "-ldl" is needed in options.
> > I tried to build using "-ldl" option and succeeded.
> >
> > ------------
> > [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# gcc -g -O2 -g -O2
> -ldl
> > -fno-strict-aliasi
> > ng -pipe -Wall  -I../../../include -I../../../include
> -L../../../lib
> > check_for_unshare.
> > c   -o check_for_unshare
> > [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# echo $?
> > 0
> > [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# ll
> > total 60
> > -rw-rw-r-- 1 root root  1396 Mar 10 01:23 Makefile
> > -rw-rw-r-- 1 root root  1386 Mar 10 01:23 Makefile.inc
> > -rw-rw-r-- 1 root root  3286 Mar 10 01:23 README
> > -rw-rw-r-- 1 root root  1451 Mar 10 01:23 TEST_PLAN.txt
> > -rwxr-xr-x 1 root root 10805 Mar 10 15:18 check_for_unshare
> > -rw-rw-r-- 1 root root  1634 Mar 10 01:23 check_for_unshare.c
> > -rwxrwxr-x 1 root root  1712 Mar 10 01:23 container_test.sh
> > drwxrwxr-x 2 root root  4096 Mar 10 10:42 libclone
> > drwxrwxr-x 2 root root  4096 Mar 10 01:23 mqns
> > drwxrwxr-x 2 root root  4096 Mar 10 01:23 netns
> > drwxrwxr-x 2 root root  4096 Mar 10 01:23 pidns
> > drwxrwxr-x 2 root root  4096 Mar 10 01:23 sysvipc
> > drwxrwxr-x 2 root root  4096 Mar 10 01:23 utsname
> > [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]#
> > ------------
> >
> >
> > How about changing Makefile as follows?
> >
> > ============
> > --- ./testcases/kernel/containers/Makefile      2010-03-10
> > 01:23:25.000000000 +0900
> > +++ ./testcases/kernel/containers/Makefile.new  2010-03-10
> > 15:27:20.000000000 +0900
> > @@ -28,6 +28,8 @@
> >
> >  LIB                    := -ld
> >
> > +CFLAGS                  += -ldl
> > +
> >  INSTALL_TARGETS                := *.sh
> >
> >  $(LIBDIR):
> > ============
> >
> >
> > Regards--
> >
> >
> > -Tomonori Mitani
> >
> >
> >
> >
> ------------------------------------------------------------------
> ------------
> > Download Intel&#174; Parallel Studio Eval
> > Try the new software tools for yourself. Speed compiling, find bugs
> > proactively, and fine-tune applications for parallel performance.
> > See why Intel Parallel Studio got high marks during beta.
> > http://p.sf.net/sfu/intel-sw-dev
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
