Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NV7Y6-0007LJ-KQ
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:02:30 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NV7Y5-0004Pc-KI
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:02:30 +0000
Received: by pxi1 with SMTP id 1so7073620pxi.25
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 10:02:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263401574.7900.12.camel@lucio-t400>
References: <000001ca79f4$7869a110$693ce330$@co.jp>
	<135282C4-83A6-43D5-9D26-D711482A88A1@gmail.com>
	<1263235304.18451.3.camel@lucio-t400>
	<364299f41001120221g65e8a98dy9360c1d35238b469@mail.gmail.com>
	<1263401574.7900.12.camel@lucio-t400>
Date: Wed, 13 Jan 2010 10:02:23 -0800
Message-ID: <364299f41001131002w26512687m373fbe63aadcb0fa@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "libevent01" test failure with ltp-2009-12-10 cvs
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
To: ljhc@br.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 13, 2010 at 8:52 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
> Hi Garrett,
>
> I'm running on a ppc64 machine.
>
> >From ltp all tests run .log file:
>
> lchown02 =A0 =A07 =A0TPASS =A0: =A0lchown() fails, Path contains regular =
file,
> errno:20
> sh: run_libevent.sh: command not found
> link01 =A0 =A0 =A01 =A0TPASS =A0: =A0link(2) to a symbolic link, which is=
 pointing
> to an existing object file worked - file created and link count adjusted
>
> I searched for run_libevent.sh and found it
> at /opt/ltp/testcases/bin/libevent dir.
>
> I'm running it manually by (same commands .failcmdfile gives):
>
> # export LTPROOT; run_libevent.sh
> bash: run_libevent.sh: command not found
> # export LTPROOT; ./testcases/bin/libevent/run_libevent.sh
> Running tests:
> KQUEUE
> Skipping test
> POLL
> Skipping test
> SELECT
> Skipping test
> RTSIG
> Skipping test
> EPOLL
> Skipping test
> libevent01 =A0 =A00 =A0TINFO =A0: =A0Cleaning up.
>
> Thanks,

What's your $PATH, and where do you expect it to be? I ask because the
runtest file is doing the right thing today:

optimus ltp # grep -r run_libevent.sh runtest/
runtest/syscalls:libevent01 export LTPROOT;
$LTPROOT/testcases/bin/libevent/run_libevent.sh

Thanks,
-Garrett

> On Tue, 2010-01-12 at 02:21 -0800, Garrett Cooper wrote:
>> On Mon, Jan 11, 2010 at 10:41 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
>> > Hi Garrett,
>> >
>> > I'm still running into this issue with LTP-20091231
>>
>> Hi Lucio,
>> What's the error message and how are you trying to run the test?
>> Thanks,
>> -Garrett
>>
>> > On Fri, 2009-12-11 at 01:56 -0800, Garrett Cooper wrote:
>> >> On Dec 10, 2009, at 3:57 PM, Mitani wrote:
>> >>
>> >> > Hi,
>> >> >
>> >> > I got following message when I ran test of "libevent01" with
>> >> > ltp-2009-12-10 cvs.
>> >> >
>> >> > ------------
>> >> > sh: run_libevent.sh: command not found
>> >> > ------------
>> >> >
>> >> > This occured because "run_libevent.sh" was not installed under the
>> >> > "/opt/ltp" directory, I think.
>> >> >
>> >> > Certainly, this test successed when I copied
>> >> > "${LTPROOT}/testcases/kernel/syscalls/libevent/run_libevent.sh" file
>> >> > to the "/opt/ltp/testcases/bin" directory.
>> >> >
>> >> > So, I want to suggest the following revision:
>> >> >
>> >> > 1. Install "run_libevent.sh" to under the "/opt/ltp/testcases/bin"
>> >> > =A0 directory by default.
>> >> > =A0(I don't know how to revise Makefile etc.)
>> >> >
>> >> > 2. Apply the following patch to "run_libevent.sh".
>> >> >
>> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > --- run_libevent.sh 2009-11-20 04:08:36.000000000 +0900
>> >> > +++ run_libevent.sh.new =A0 =A0 2009-12-10 16:44:02.000000000 +0900
>> >> > @@ -31,7 +31,7 @@
>> >> > =A0 =A0 tst_resm TCONF "You need to be root to run these tests"
>> >> > =A0 =A0 TST_EXIT=3D0
>> >> > else
>> >> > - =A0 "$LTPROOT/testcases/bin/tests/test-libevent.sh"
>> >> > + =A0 "$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
>> >> > =A0 =A0 TST_EXIT=3D$?
>> >> > fi
>> >> > tst_cleanup
>> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>
>> >> Done -- thanks!
>
>

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
