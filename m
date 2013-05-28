Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <R65777@freescale.com>) id 1UhAdj-0003pP-Fc
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 03:31:59 +0000
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
	helo=tx2outboundpool.messaging.microsoft.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1UhAdg-0008N7-Pu
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 03:31:59 +0000
From: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Tue, 28 May 2013 03:16:22 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07043E91@039-SN2MPN1-013.039d.mgd.msft.net>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
	<1184534312.8345309.1369679597424.JavaMail.root@redhat.com>
In-Reply-To: <1184534312.8345309.1369679597424.JavaMail.root@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] LTP: Compilation error for powerpc
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
To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>



> -----Original Message-----
> From: Jan Stancek [mailto:jstancek@redhat.com]
> Sent: Tuesday, May 28, 2013 12:03 AM
> To: Bhushan Bharat-R65777
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] LTP: Compilation error for powerpc
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Bhushan Bharat-R65777" <R65777@freescale.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Monday, 27 May, 2013 1:32:32 PM
> > Subject: [LTP] LTP: Compilation error for powerpc
> >
> > Hi All,
> >
> > There are a number of good test cases which we run to test various
> > features ( like ptrace/memory etc). I tried below steps and failed to
> > compile
> > successfully:
> 
> I (or rather automated testing) compile it directly on powerpc as:
> # make autotools

I get bellow error with "make autotools"

r65777@perfidc-01:~/LTP/try$ make autotools 
sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$:]):;p;q}' ChangeLog > m4/ltp-version.m4
aclocal -I m4
/usr/share/aclocal/snacc.m4:24: warning: underquoted definition of AM_PATH_SNACC
/usr/share/aclocal/snacc.m4:24:   run info '(automake)Extending aclocal'
/usr/share/aclocal/snacc.m4:24:   or see http://sources.redhat.com/automake/automake.html#Extending-aclocal
autoconf
autoheader
make: *** No rule to make target `m4/Makefile.am', needed by `m4/Makefile.in'.  Stop.
r65777@perfidc-01:~/LTP/try$ cd m4/

Thanks
-Bharat  

> # ./configure
> # make
> 
> Base on that gcc path, I'm guessing you are cross-compiling it on x86_64.
> I tried that just now and built OK:
> # make autotools
> # env CC=/opt/crosstool/gcc-4.4.7-20120601-glibc-2.12-2-gc4ccff1/powerpc64-
> unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-gcc \
>       LD=/opt/crosstool/gcc-4.4.7-20120601-glibc-2.12-2-gc4ccff1/powerpc64-
> unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld \
>       STRIP=/opt/crosstool/gcc-4.4.7-20120601-glibc-2.12-2-gc4ccff1/powerpc64-
> unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-strip \
>       ./configure --host=ppc64
> ...
> # file testcases/kernel/syscalls/open/open01
> testcases/kernel/syscalls/open/open01: ELF 64-bit MSB executable, 64-bit PowerPC
> or cisco 7500, version 1 (SYSV), dynamically linked (uses shared libs), for
> GNU/Linux 2.6.4, not stripped
> 
> Regards,
> Jan
> 
> >
> > 1)
> > cp include/mk/config.mk.default include/mk/config.mk
> >
> > 2)
> > vi include/mk/config.mk
> > -AR                      := ar
> > -CC                      := gcc
> > +AR                      :=
> > /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/b
> > in/powerpc-linux-gnu-ar
> > +CC                      :=
> > /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/b
> > in/powerpc-linux-gnu-gcc
> >
> > 3)
> > cp include/config.h.default include/config.h
> >
> > 4)
> > cd include/mk
> > cp generic_leaf_target.inc generic_leaf_target.mk cp
> > generic_trunk_target.inc generic_trunk_target.mk cd ../../
> >
> > 5)
> > Make
> >
> > Getting error :
> >
> > make[4]: Entering directory
> > `/home/r65777/LTP/try/testcases/kernel/containers/libclone'
> > /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/b
> > in/powerpc-linux-gnu-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
> > -Wall -I/home/r65777/LTP/try/testcases/kernel/include  -c -o
> > libclone.o libclone.c In file included from libclone.h:31:0,
> >                  from libclone.c:17:
> > /home/r65777/LTP/try/testcases/kernel/include/linux_syscall_numbers.h:18:21:
> > fatal error: cleanup.c: No such file or directory compilation terminated.
> > make[4]: *** [libclone.o] Error 1
> > make[4]: Leaving directory
> > `/home/r65777/LTP/try/testcases/kernel/containers/libclone'
> > make[3]: *** [libclone/libclone.a] Error 2
> > make[3]: Leaving directory `/home/r65777/LTP/try/testcases/kernel/containers'
> > make[2]: *** [all] Error 2
> > make[2]: Leaving directory `/home/r65777/LTP/try/testcases/kernel'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/home/r65777/LTP/try/testcases'
> > make: *** [testcases-all] Error 2
> >
> > -------------------------
> >
> > Thanks
> > -Bharat
> >
> >
> > ----------------------------------------------------------------------
> > -------- Try New Relic Now & We'll Send You this Cool Shirt New Relic
> > is the only SaaS-based application performance monitoring service that
> > delivers powerful full stack analytics. Optimize and monitor your
> > browser, app, & servers with just a few lines of code. Try New Relic
> > and get this awesome Nerd Life shirt!
> > http://p.sf.net/sfu/newrelic_d2d_may
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
