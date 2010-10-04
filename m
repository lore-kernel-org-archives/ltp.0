Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1P2juS-0005uw-WA
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 12:12:49 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P2juR-0000dD-Em
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 12:12:48 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTinjEdCxD5E0BfniymiHHLmF4S_ocsawTdHpfr_2@mail.gmail.com>
References: <20100924100303.5709.80714.sendpatchset@sravan-laptop>
	<20100927142304.GA23119@hallyn.com>	<4CA0AEB7.7080701@linux.vnet.ibm.com>
	<20100927180239.GA15486@hallyn.com>	<4CA1ADB0.7070908@linux.vnet.ibm.com>
	<20100928213611.GA1046@hallyn.com>	<4CA31140.4000805@linux.vnet.ibm.com>
	<20100929141051.GB4620@hallyn.com>
	<OFA3C42AE5.7F12F4DF-ON652577AD.004DA114-652577AD.004DCA76@in.ibm.com>
	<AANLkTi=woCpWexWHWTcojN7U_UQZEszEvVXEaPDiDpLQ@mail.gmail.com>
	<AANLkTinjEdCxD5E0BfniymiHHLmF4S_ocsawTdHpfr_2@mail.gmail.com>
Date: Mon, 04 Oct 2010 17:42:40 +0530
Message-Id: <1286194360.4882.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Compilation Error Fixed in filecaps.
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
To: sravan <sravan@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net, "Serge E. Hallyn" <serge@hallyn.com>

Hi Sravan,

1) File c.c is present in both git and the last August LTP release as
well
2) File c.c is building well on my Fedora 13 PPC64 Box:
# uname -a
Linux 2.6.35.4 #2 SMP Tue Sep 28 16:07:27 IST 2010 ppc64 ppc64 ppc64
GNU/Linux
# cat /etc/issue
Fedora release 13 (Goddard)
Kernel \r on an \m (\l)

# which automake
/usr/bin/automake
# /usr/bin/automake --version
automake (GNU automake) 1.11.1

# ls
-l /root/LTP_AUGUST_2010_RELEASE/ltp-full-20100831/testcases/kernel/security/filecaps/c*
-rwxrwxr-x. 1 root root 8171 Sep 29
20:09 /root/LTP_AUGUST_2010_RELEASE/ltp-full-20100831/testcases/kernel/security/filecaps/c
-rw-r--r--. 1 root root 1987 Sep 14
16:34 /root/LTP_AUGUST_2010_RELEASE/ltp-full-20100831/testcases/kernel/security/filecaps/c.c
-rwxrwxr-x. 1 root root 9235 Sep 29 

# ls -l /opt/ltp/testcases/bin/c
-rwxrwxr-x. 1 root root 8171 Sep 29 20:24 /opt/ltp/testcases/bin/c

# ./runltp -f filecaps
Running tests.......
<<<test_start>>>
tag=Filecaps stime=1286194213
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Running in:
cap_sys_admin tests
filecaps    1  TPASS  :  could not set capabilities as non-root

testing for correct caps
filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  0

filecaps    0  TINFO  :  1

filecaps    0  TINFO  :  2

filecaps    0  TINFO  :  3

filecaps    0  TINFO  :  4

filecaps    0  TINFO  :  5

filecaps    0  TINFO  :  6

filecaps    0  TINFO  :  7

filecaps    0  TINFO  :  8

filecaps    0  TINFO  :  9

filecaps    0  TINFO  :  10

filecaps    0  TINFO  :  11

filecaps    0  TINFO  :  12

filecaps    0  TINFO  :  13

filecaps    0  TINFO  :  14

filecaps    0  TINFO  :  15

filecaps    0  TINFO  :  16

filecaps    0  TINFO  :  17

filecaps    0  TINFO  :  18

filecaps    0  TINFO  :  19

filecaps    0  TINFO  :  20

filecaps    0  TINFO  :  21

filecaps    0  TINFO  :  22

filecaps    0  TINFO  :  23

filecaps    0  TINFO  :  24

filecaps    0  TINFO  :  25

filecaps    0  TINFO  :  26

filecaps    0  TINFO  :  27

filecaps    0  TINFO  :  28

filecaps    0  TINFO  :  29

filecaps    0  TINFO  :  30

filecaps    0  TINFO  :  31

filecaps    0  TINFO  :  32

filecaps    0  TINFO  :  33

filecaps    1  TPASS  :  All tests passed

testing for correct pI checks
filecaps    0  TINFO  :  start
filecaps    0  TINFO  :  =ep
filecaps    0  TINFO  :  after raising all caps
filecaps    0  TINFO  :  =eip
filecaps    0  TINFO  :  after first drop cap_sys_admin
filecaps    0  TINFO  :  =eip cap_sys_admin-eip
filecaps    0  TINFO  :  after first raise cap_sys_admin
filecaps    0  TINFO  :  =eip cap_sys_admin-ep
filecaps    0  TINFO  :  after drop cappset
filecaps    0  TINFO  :  =ip cap_sys_admin-p
filecaps    0  TINFO  :  after second drop cap_sys_admin
filecaps    0  TINFO  :  =eip cap_setpcap-e cap_sys_admin-eip
filecaps    0  TINFO  :  final
filecaps    0  TINFO  :  =eip cap_setpcap-e cap_sys_admin-eip
filecaps    1  TPASS  :  pI is properly capped

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100831
        
       ###############################################################"
        
            Done executing testcases."
            LTP Version:  LTP-20100831
       ###############################################################"

Regards--
Subrata

On Sun, 2010-10-03 at 21:33 -0700, Garrett Cooper wrote:
> On Sun, Oct 3, 2010 at 8:50 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > On Wed, Sep 29, 2010 at 7:09 AM, Subrata Modak1
> > <subrata.modak@in.ibm.com> wrote:
> >> Serge Hallyn <serge.hallyn@canonical.com> wrote on 09/29/2010 07:40:51 PM:
> >>>
> >>> Quoting sravan (sravan@linux.vnet.ibm.com):
> >>> >  Sorry for the confusion Serge.
> >>> > I have taken the "c.c" file from the latest ltp release and found
> >>> > that it is not compiling.
> >>> >
> >>> > The same file is not compiling in the earlier release of ltp also.
> >>> > To resolve the compilation issue I have added the following
> >>> > flag(HAVE_SYS_CAPABILITY_H).
> >>> > The same flag is also used in
> >> ltp-full-20100831/testcases/kernel/security/
> >>> filecaps/verify_caps_exec.c
> >>> > file.
> >>> >
> >>> > #if HAVE_SYS_CAPABILITY_H            //Added by Sravan
> >>> > #include <sys/capability.h>
> >>> > #endif                                              // Added by Sravan
> >>> >
> >>> > Please let me know if this is the correct approach.
> >>>
> >>> Well, the better approach would be to install the libcap-dev
> >>> package (or whatever it is called on your distro)  :)  But so
> >>> long as you're just getting your own compile working, whatever
> >>> gets you a working build is fine.
> >>>
> >>> What worries me, though, is the thought that the official
> >>> 20100831 release has the wrong files in it!  Can you follow
> >>> up on that with Subrata?  In particular, the c.c file is
> >>> different from the one in ltp.git.  Something is going very
> >>> wrong!
> >>
> >> Garret,
> >>
> >> Did we miss/drop something during our migration from ltp-dev.git to
> >> ltp.git ?
> >
> >    No... I pushed all of the content from ltp-dev.git up to ltp.git.
> 
>     BTW...
> 
> $ git status c.c
> # On branch master
> nothing to commit (working directory clean)
> $ diff ~/Downloads/ltp-full-20100831/testcases/kernel/security/filecaps/c.c
>   c.c
> $ echo $?
> 0
> 
>     So I'm not sure what Serge was looking at...
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Virtualization is moving to the mainstream and overtaking non-virtualized
> environment for deploying applications. Does it make network security 
> easier or more difficult to achieve? Read this whitepaper to separate the 
> two and get a better understanding.
> http://p.sf.net/sfu/hp-phase2-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
