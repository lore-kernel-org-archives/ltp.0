Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shashi859@gmail.com>) id 1UDqTS-0000TT-Mz
	for ltp-list@lists.sourceforge.net; Fri, 08 Mar 2013 06:08:10 +0000
Received: from mail-pa0-f53.google.com ([209.85.220.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDqTO-0004Gi-H8
	for ltp-list@lists.sourceforge.net; Fri, 08 Mar 2013 06:08:10 +0000
Received: by mail-pa0-f53.google.com with SMTP id bg4so1058715pad.12
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 22:08:00 -0800 (PST)
Date: Thu, 07 Mar 2013 22:07:59 -0800 (PST)
From: shashi859@gmail.com
Message-ID: <22395343.19.1362722874047.JavaMail.root@182-18-153-204.4shost.com>
MIME-Version: 1.0
Subject: Re: [LTP] Building LTP in a 64-bit machine for 32-bit target
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8359499058985705303=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8359499058985705303==
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sedat Dilek <sedat.dilek@...> writes:

> 
> On Thu, Mar 7, 2013 at 9:51 AM, Shashi <shashi859@...> wrote:
> > Pedro Fonseca <pfonseca@...> writes:
> >
> >>
> >> Hi,
> >>
> >> I've been trying to cross compile LTP on a 64-bit x86 machine to produce
> >> tests for a 32-bit x86 machines. Unfortunately, so far I haven't found a
> >> clean way of achieving this.
> >>
> >> I've tried configuring with "./configure --host=i386" but this still
> >> produces x86-64 binaries.
> >>
> >> I've also tried configuring with "CFLAGS=-m32 ./configure CFLAGS=-m32"
> >> but it gives compilation errors on some tests (e.g.
> >> testcases/kernel/syscalls/chown01_16). I can get past some of the errors
> >> by disabling the "/../utils/compat_16.mk" lines in the individual test
> >> Makefiles. But is there a better way to compile LTP for 32-bit on a 64-bit?
> >>
> >> Thanks,
> >> Pedro
> >>
> >> ------------------------------------------------------------------------------
> >> Everyone hates slow websites. So do we.
> >> Make your web apps faster with AppDynamics
> >> Download AppDynamics Lite for free today:
> >> http://p.sf.net/sfu/appdyn_d2d_feb
> >>
> >
> > Hello Pedra Fonseca,
> >
> > ./configure --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu "CFLAGS=-m32"
> > "CPPFLAGS=-m32" "LDFLAGS=-m32"
> >
> > I use the above command to build ltp for 32-bit architecture on 64-bit machine.
> > Once you do run this, you can check the CFLAGS, CPPFLAGS, LDFALGS being set in
> > config.status file. --target flag is to set target environment if it is
> > different from build environment.
> >
http://stackoverflow.com/questions/5139403/whats-the-difference-of-configure-option-build-host-and-target
> >
> > In fedora-64 bit, to build a 32-bit binary you need following packages
> > sudo yum install glibc-devel.i686 libgcc.i686
> >
> > May be in Ubuntu, you may need these packages or similar kind. If not installed
> > gcc will throw some error. Let me know if you still find problem.
> >
> > Regards,
> > ShashiKiran
> >
> 
> [ CC Pedro ]
> 
> AFAICS "-m32" is available on gcc, dunno if for example clang supports
> that, too.
> 
> Can't say if "-m32" as LDFLAGS makes any sense or to say IOW "-m32"
> for CC is sufficient.
> Maybe you can explain that, Shashi?
> 
> To support "-m32" CFLAGS for gcc on Debian/Ubuntu you need to install
> 'gcc-multilib' (gcc with biarch-support) package.
> This installs 'libc6-i386' and 'libc6-i386-dev' packages automatically.
> 
>      $ sudo apt-get update
>      $ sudo apt-get install gcc-multilib
> 
> Another way could be to install multiarch-support if not available
> (binutils-mutiarch and multiarch-support packages).
> But I should check Debian's/Ubuntu's wiki pages, again... how to build
> on amd64 for i386...
> 
> Hope this helps people reading this ML.
> 
> Regards,
> - Sedat -
> 
> >
> >
> >
> > ------------------------------------------------------------------------------
> > Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester
> > Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the
> > endpoint security space. For insight on selecting the right partner to
> > tackle endpoint security challenges, access the full report.
> > http://p.sf.net/sfu/symantec-dev2dev
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@...
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> ------------------------------------------------------------------------------
> Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
> Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
> endpoint security space. For insight on selecting the right partner to 
> tackle endpoint security challenges, access the full report. 
> http://p.sf.net/sfu/symantec-dev2dev
> 

Hi Sedat Dilek,

If LDFLAGS=-m32 is not set, then following error is observed while building ltp-pan,

      gcc -m32 -g -O2 -fno-strict-aliasing -pipe -Wall -m32 -Wno-error -I/home/user/ltp/ltp-full-20120903/pan -I../include -I../include -c -o ltp-bump.o ltp-bump.c
      gcc -m32 -g -O2 -fno-strict-aliasing -pipe -Wall -m32 -Wno-error -I/home/user/ltp/ltp-full-20120903/pan -I../include -I../include  -c -o zoolib.o zoolib.c
      gcc -L../lib  ltp-bump.o zoolib.o   -lm  -o ltp-bump 
 
     /usr/bin/ld: i386 architecture of input file `ltp-bump.o' is incompatible with i386:x86-64 output
      /usr/bin/ld: i386 architecture of input file `zoolib.o' is incompatible with i386:x86-64 output
      collect2: ld returned 1 exit status
      make: *** [ltp-bump] Error 1

I feel that, as per rules set by makefile, gcc trying to build 64bit binary using 32bit objects. So When LDFLAGS is set to "-m32", gcc will create create 32bit binary by linking to 32bit object files.

      gcc -m32  -L../lib  ltp-bump.o zoolib.o   -lm  -o ltp-bump 
      gcc -m32 -g -O2 -fno-strict-aliasing -pipe -Wall -m32 -Wno-error -I/home/user/ltp/ltp-full-20120903/pan -I../include -I../include -c -o ltp-pan.o ltp-pan.c
      gcc -m32 -g -O2 -fno-strict-aliasing -pipe -Wall -m32 -Wno-error -I/home<br/><br/><div style='width:300px;border-top:1px solid #d2d2d2;'></div><br/><a href='http://www.way2sms.com' style='color:#7b7b7b;text-decoration: none;'>Mail sent via way2sms.</a>


--===============8359499058985705303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
--===============8359499058985705303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8359499058985705303==--
