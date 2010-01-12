Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUdss-000404-Dl
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 10:21:58 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUdsp-0001ZQ-Rb
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 10:21:58 +0000
Received: by pxi38 with SMTP id 38so10387831pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 02:21:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263235304.18451.3.camel@lucio-t400>
References: <000001ca79f4$7869a110$693ce330$@co.jp>
	<135282C4-83A6-43D5-9D26-D711482A88A1@gmail.com>
	<1263235304.18451.3.camel@lucio-t400>
Date: Tue, 12 Jan 2010 02:21:50 -0800
Message-ID: <364299f41001120221g65e8a98dy9360c1d35238b469@mail.gmail.com>
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

On Mon, Jan 11, 2010 at 10:41 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
> Hi Garrett,
>
> I'm still running into this issue with LTP-20091231

Hi Lucio,
What's the error message and how are you trying to run the test?
Thanks,
-Garrett

> On Fri, 2009-12-11 at 01:56 -0800, Garrett Cooper wrote:
>> On Dec 10, 2009, at 3:57 PM, Mitani wrote:
>>
>> > Hi,
>> >
>> > I got following message when I ran test of "libevent01" with
>> > ltp-2009-12-10 cvs.
>> >
>> > ------------
>> > sh: run_libevent.sh: command not found
>> > ------------
>> >
>> > This occured because "run_libevent.sh" was not installed under the
>> > "/opt/ltp" directory, I think.
>> >
>> > Certainly, this test successed when I copied
>> > "${LTPROOT}/testcases/kernel/syscalls/libevent/run_libevent.sh" file
>> > to the "/opt/ltp/testcases/bin" directory.
>> >
>> > So, I want to suggest the following revision:
>> >
>> > 1. Install "run_libevent.sh" to under the "/opt/ltp/testcases/bin"
>> > =A0 directory by default.
>> > =A0(I don't know how to revise Makefile etc.)
>> >
>> > 2. Apply the following patch to "run_libevent.sh".
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- run_libevent.sh 2009-11-20 04:08:36.000000000 +0900
>> > +++ run_libevent.sh.new =A0 =A0 2009-12-10 16:44:02.000000000 +0900
>> > @@ -31,7 +31,7 @@
>> > =A0 =A0 tst_resm TCONF "You need to be root to run these tests"
>> > =A0 =A0 TST_EXIT=3D0
>> > else
>> > - =A0 "$LTPROOT/testcases/bin/tests/test-libevent.sh"
>> > + =A0 "$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
>> > =A0 =A0 TST_EXIT=3D$?
>> > fi
>> > tst_cleanup
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Done -- thanks!

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
