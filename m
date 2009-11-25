Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1ND86K-0000Es-0u
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 02:59:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ND86C-000443-VT
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 02:59:27 +0000
Message-ID: <4B0C8C98.9050007@cn.fujitsu.com>
Date: Wed, 25 Nov 2009 09:47:04 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <000001ca6d65$076cb650$164622f0$@co.jp>
In-Reply-To: <000001ca6d65$076cb650$164622f0$@co.jp>
Subject: Re: [LTP] build failure with 2009-11-24 cvs
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Hi,
On 11/25/2009 08:19 AM, Mitani wrote:
> Hi,
>
> I ran "make" in RHEL5.4 (Kernel release : 2.6.18-164.el5) with
> ltp-2009-11-24.tar.gz.
> But it failed with following error message.
> ./configure has been done before make.
> I use "make 3.81", "autoconf 2.61", "automake 1.10.2", and "m4 1.4.7".
>
> ------------
> make[3]: Entering directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
> make[3]: *** No rule to make target
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/li
> bevent/test/Makefile', needed by `libevent-all'.  Stop.
> make[3]: Leaving directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases'
> make: *** [testcases-all] Error 2
> ------------
>
> Similar failure occurred in RHEL5.4 and ltp-2009-11-20.tar.gz too.
>
>
> I confirmed in "${LTPROOT}/testcases/kernel/syscalls/libevent/test"
> directory.
> As a result, there wasn't "Makefile" in this directory.
> I think that the following command in
> "${LTPROOT}/testcases/kernel/syscalls/Makefile"
> failed by this reason.
>
> ------------
> libevent-all: $(abs_srcdir)/libevent/test/Makefile libevent/test
>         $(MAKE) -C libevent/test -f "$(firstword $^)" $(LIBEVENT_APPS)
> ------------
>
> I judged that "${LTPROOT}/testcases/kernel/syscalls/libevent/configure"
> made "${LTPROOT}/testcases/kernel/syscalls/libevent/test/Makefile".
> After execute this configure,
> "${LTPROOT}/testcases/kernel/syscalls/libevent/test/Makefile"
> was made.
>
>
> I executed "make" command in "${LTPROOT}" directory again.
> Then, this time, it failed in the following error message.
>
> ------------
> make[3]: Entering directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
> make -C libevent/test -f
> "/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test/Makefile"
> regress test-eof test-init test-time test-weof
> make[4]: Entering directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -I../compat -Wall -g -O2 -c regress.c
> make[4]: *** No rule to make target `../libevent.a', needed by `regress'.
> Stop.
> make[4]: Leaving directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
> make[3]: *** [libevent-all] Error 2
> make[3]: Leaving directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases'
> make: *** [testcases-all] Error 2
> ------------
>
>
> This time's failure seems to be caused by the fact that there is not
> "${LTPROOT}/testcases/kernel/syscalls/libevent/libevent.a", I think.
>
>
> "libevent.a" file was made after I executed "make" command in 
> "${LTPROOT}/testcases/kernel/syscalls/libevent" directory.
> But, following failure occurred when I executed this "make" command.
>
> ------------
> Making all in test
> make[2]: Entering directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -I../compat -Wall -g -O2 -c test-init.c
> gcc  -I../compat -Wall -g -O2  -o test-init  test-init.o -L.. -levent
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -I../compat -Wall -g -O2 -c test-eof.c
> gcc  -I../compat -Wall -g -O2  -o test-eof  test-eof.o -L.. -levent
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -I../compat -Wall -g -O2 -c test-weof.c
> gcc  -I../compat -Wall -g -O2  -o test-weof  test-weof.o -L.. -levent
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -I../compat -Wall -g -O2 -c test-time.c
> gcc  -I../compat -Wall -g -O2  -o test-time  test-time.o -L.. -levent
> gcc  -I../compat -Wall -g -O2  -o regress  regress.o -L.. -levent
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -I../compat -Wall -g -O2 -c bench.c
> gcc  -I../compat -Wall -g -O2  -o bench  bench.o -L.. -levent
> make[2]: ./test.sh: Command not found
> make[2]: *** [test] Error 127
> make[2]: Leaving directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory
> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent'
> make: *** [all-recursive-am] Error 2
> ------------
>
>
> This failure depends on there not being "$ LTPROOT
> /testcases/kernel/syscalls/libevent/test.sh".
> I cannot make "test.sh", because I don't know what this "test.sh" do.
> But, "${LTPROOT}/testcases/kernel/syscalls/libevent/libevent.a", was made, 
> then, first of all, I executed "make" command in "${LTPROOT}" directory 
> once again.
> Then "make" succeeded.
> After that, "make install" succeeded too.
>
>
> >From the above, I think that there may be three following problems.
>
> (1) "${LTPROOT}/testcases/kernel/syscalls/libevent/test/Makefile" does not
> exist.
>     For this measure, this "Makefile" should be made when
> "${LTPROOT}/configure"
>     executed or this is offered as standard equipment, I think.
>
> (2) "${LTPROOT}/testcases/kernel/syscalls/libevent/libevent.a" does not
> exist.
>     For this measure, this "libevent.a" may be necessary to be made when
>     "make" executed in "${LTPROOT}" directory.
>
> (3) "${LTPROOT}/testcases/kernel/syscalls/libevent/test/test.sh" does not
> exist.
>     For this measure, this "test.sh" may be necessary to be offered as
> standard
>     equipment.
>
>
> Can I get some advice whether my thought above is right?
>
>   
    By using ltp-intermediate-20091122,
    Same problems occured in my machine and same solutions to pass
"make" step.
   
    About test.sh, I think the author might forget to add test.sh to
    "${LTPROOT}/testcases/kernel/syscalls/libevent/test/",
    for in "${LTPROOT}/testcases/kernel/syscalls/libevent/Makefile",
there does exist
    "EXTRA_DIST = test/test.sh".

    Regards,
    Liu Bo
> Regards--
>
> -Tomonori Mitani
>
>
>
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
>
>
>   


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
