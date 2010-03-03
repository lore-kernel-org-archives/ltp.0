Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Nmr08-000396-CA
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 16:00:44 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nmr07-0004B3-BN
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 16:00:44 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o23FsxBr002878
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 08:54:59 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o23G0RHa059462
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 09:00:27 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o23G2oqT032494
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 09:02:50 -0700
Date: Wed, 3 Mar 2010 10:00:25 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100303160025.GC937@us.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
	<B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
	<20100302173535.GA14556@us.ibm.com>
	<5EEDD2C4-6C6C-4008-81AA-65B78FA3E7C8@gmail.com>
	<20100303055619.GA19084@linux.vnet.ibm.com>
	<364299f41003030114x30e251d6x7cd7993f8f75792f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41003030114x30e251d6x7cd7993f8f75792f@mail.gmail.com>
Subject: Re: [LTP] LTP's filecaps test gives false positive results
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, Iranna D Ankad <iranna.ankad@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Tue, Mar 2, 2010 at 9:56 PM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> > On Tue, Mar 02, 2010 at 10:25:23AM -0800, Garrett Cooper wrote:
> >> On Mar 2, 2010, at 9:35 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> >>
> >> > Quoting Garrett Cooper (yanegomi@gmail.com):
> >> >>
> >> >> That would be from me; I do that via autoconf and they probably
> >> >> fubared the headers on Redhat or something... Do you have
> >> >
> >> > Oh, ok. =A0Well I suspect we can ditch the check_simple_capset.c
> >> > altogether if autoconf is (eventually :) doing the detection for
> >> > us. =A0The only point of check_simple_capset.c was to check whether
> >> > libcap is there and whether we should run the real tests.
> >> >
> >> >> libcap-devel installed?
> >> >
> >> > yup:
> >> >
> >> > [root@oracer4b ltp-dev]# rpm -qa|grep libcap
> >> > libcap-2.10-2.fc10.x86_64
> >> > libcap-devel-2.10-2.fc10.x86_64
> >> >
> >> > [root@oracer4b ltp-dev]# grep CAP_LIB *
> >> > config.log:CAP_LIBS=3D''
> >> > config.status:S["CAP_LIBS"]=3D""
> >> > configure:CAP_LIBS'
> >> > configure: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CAP_LIBS=3D"-lcap"
> >> >
> >> > so somehow -lcap was not detected by configure?
> >>
> >> Well some of the definitions are there but maybe not all of them.
> >> config.log would help...
> >>
> >
> > Here is the config.log snapshot, it seems it has some error:
> >
> > ...
> > configure:5543: checking whether CAP_BSET_DROP is declared
> > configure:5574: gcc -c -g -O2 =A0conftest.c >&5
> > conftest.c: In function 'main':
> > conftest.c:38: error: 'CAP_BSET_DROP' undeclared (first use in this
> > function)
> > conftest.c:38: error: (Each undeclared identifier is reported only once
> > conftest.c:38: error: for each function it appears in.)
> =

>     Yes -- and I think this is because the constants no longer have
> the same name:
> =

> http://fxr.watson.org/fxr/source/include/linux/prctl.h?v=3Dlinux-2.6#L68
> =

>     Note -- CAP_BSET_DROP should be: PR_CAPBSET_DROP, etc.
> =

>     Which is why I stress _not_ putting these hardcoded constants in
> test files (POLLHDRDUP -- or whatever it was in ppoll01 -- is the only

1. this was (almost certainly) a typo on my part

2. not using these constants, like PR_CAPBSET_READ, when testing
   prctl(PR_CAPBSET_READ)?  I think I must be misunderstanding what
   you are suggesting

3. this type of thing almost inevitably results from the desire to
   enable ltp to test features early.  When features hit -mm for instance,
   it is possible for names and such to still change before hitting
   upstream.  For an extreme example look at
   	git whatchanged -p include/linux/securebits.h
   in the kernel - those features had been there for years, but didn't
   get their publically exported names until late last year.  I have
   been wanting to send ltp testcases for those for years (and have
   some sitting around for as long), but the naming problem is exactly
   what caused my latest delay.
   One day I need to finish those up, bc it's a subtle, rarely-used
   and never-tested spot in the kernel code right now.  Guess I was
   waiting to see when /usr/include/sys/securebits.h magically shows up
   in a fedora or ubuntu system.

> real violation I can remember OTOH that I need to clean up
> eventually). We need to be consistent with any and all documentation
> provided to end-developers or we [LTP] are going to shoot ourselves in
> the foot if and when the underlying functionality changes.
>     I'll update the tests this weekend, but I would like it if someone
> test the tests on an outdated distro (RHEL 4.x?) once I provide a

I can find/build a RHEL5 box to test on

> patch to ensure that nothing's being regressed. Based on some really
> simple inspection it appears that these tests are compatible only with
> libcapability 2.x+, but I could be wrong...

jinkeys - yes, libcap 1 had its last update in august 2007, and I don't
think it supports 64-bit capabilities.

Note that cap_bound also has a dud 'check_for_libcap.sh' file which
your autoconf magic <waves hands around mysteriously> should be able
to better replace.  There is something that could stand to be in ltp
git tree - a little 1-page tutorial for properly adding (1) kernel
feature and (2) library tests to control compilation and running of
ltp tests to autoconf.

> Thanks,
> -Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
