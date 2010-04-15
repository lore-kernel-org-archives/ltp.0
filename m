Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O2KZW-00071K-3I
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:37:14 +0000
Received: from mail-yw0-f190.google.com ([209.85.211.190])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2KZV-0001l8-6w
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:37:14 +0000
Received: by ywh28 with SMTP id 28so655398ywh.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 01:37:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100415065213.GC4557@linux.vnet.ibm.com>
References: <000301cad6f8$1b9b0c60$52d12520$@co.jp>
	<D30EE9FA-D2B3-4292-9571-BEF87442BD30@gmail.com>
	<003601cadc47$f8724eb0$e956ec10$@co.jp>
	<20100415065213.GC4557@linux.vnet.ibm.com>
Date: Thu, 15 Apr 2010 01:37:04 -0700
Message-ID: <k2r364299f41004150137ue2c76b2cmc49351e6f1f5d417@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "eventfd01" test
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
To: Mitani <mitani@ryobi.co.jp>, Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Wed, Apr 14, 2010 at 11:52 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Apr 15, 2010 at 12:01:40PM +0900, Mitani wrote:
>>
>> Sorry.
>> My patch was destroyed by e-mail.
>> I attach patch for "eventfd01.c" file.
>
> Applied to next branch. Will wait for someone to Acked/test it before mer=
ging to
> master.
>
> Thanks
> -Rishi
>
>>
>>
>> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>>
>>
>> Regards--
>>
>> -Tomonori Mitani
>>
>> > -----Original Message-----
>> > From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> > Sent: Friday, April 09, 2010 2:35 AM
>> > To: Mitani
>> > Cc: <ltp-list@lists.sourceforge.net>
>> > Subject: Re: [LTP] [PATCH] fix "eventfd01" test
>> >
>> > On Apr 8, 2010, at 1:47 AM, "Mitani" <mitani@ryobi.co.jp> wrote:
>> >
>> > > Hi,
>> > >
>> > >
>> > > I tried "eventfd01" test in my system.
>> > > This test failed with TWARN (return code:4) :
>> > >
>> > > ------------
>> > > =A0eventfd01 =A0 =A01 =A0TCONF =A0: =A02.6.22 or greater kernel requ=
ired
>> > > =A0eventfd01 =A0 =A02 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A03 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A04 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A05 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A06 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A07 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A08 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 =A09 =A0TCONF =A0: =A0Remaining cases not appropria=
te for
>> > > configuration
>> > > =A0eventfd01 =A0 10 =A0TCONF =A0: =A0Remaining cases not appropriate=
 for
>> > > configuration
>> > > =A0eventfd01 =A0 11 =A0TCONF =A0: =A0Remaining cases not appropriate=
 for
>> > > configuration
>> > > =A0eventfd01 =A0 12 =A0TCONF =A0: =A0Remaining cases not appropriate=
 for
>> > > configuration
>> > > =A0eventfd01 =A0 13 =A0TCONF =A0: =A0Remaining cases not appropriate=
 for
>> > > configuration
>> > > =A0eventfd01 =A0 14 =A0TCONF =A0: =A0Remaining cases not appropriate=
 for
>> > > configuration
>> > > =A0eventfd01 =A0 15 =A0TCONF =A0: =A0Remaining cases not appropriate=
 for
>> > > configuration
>> > > =A0eventfd01 =A0 =A00 =A0TWARN =A0: =A0tst_rmdir(): TESTDIR was NULL=
; no
>> > removal
>> > > attempted
>> > > ------------
>> > >
>> > > My system's kernel level is 2.6.18-164.el5
>> > > Therefore this test rejected:
>> > >
>> > > ------< eventfd01.c - main() >------
>> > > =A0 =A0 =A0 =A0if (tst_kvercmp(2, 6, 22) < 0)
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TCONF, cleanup, "2.6.22 or g=
reater kernel
>> > > required");
>> > > ------------
>> > >
>> > > But, this "tst_brkm()" called "cleanup()".
>> > > "tst_rmdir()" is called in "cleanup()", and this checked "TESTDIR":
>> > >
>> > > ------< tst_tmpdir.c - tst_rmdir() >------
>> > > =A0 /*
>> > > =A0 =A0* Check that TESTDIR is not NULL.
>> > > =A0 =A0*/
>> > > =A0 if ( TESTDIR =3D=3D NULL ) {
>> > > =A0 =A0 =A0tst_resm(TWARN, "%s: TESTDIR was NULL; no removal attempt=
ed",
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 FN_NAME);
>> > > =A0 =A0 =A0return;
>> > > =A0 }
>> > > ------------
>> > >
>> > > This TWARN caused FAIL.
>> > > "TESTDIR" is NULL because the test didn't start.
>> > >
>> > > I think that "cleanup()" doesn't have to be called in this case.
>> > >
>> > >
>> > > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>> > >
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
>> > 2010-04-01
>> > > 15:23:10.000000000 +0900
>> > > +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
>> > 2010-04-08
>> > > 17:16:35.000000000 +0900
>> > > @@ -728,8 +728,10 @@
>> > > =A0 =A0 =A0 =A0/* capture signals */
>> > > =A0 =A0 =A0 =A0tst_sig(FORK, DEF_HANDLER, cleanup);
>> > >
>> > > - =A0 =A0 =A0 if (tst_kvercmp(2, 6, 22) < 0)
>> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "2.6.22 or gr=
eater kernel
>> > > required");
>> > > + =A0 =A0 =A0 if (tst_kvercmp(2, 6, 22) < 0) {
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, NULL, "2.6.22 or great=
er kernel
>> > > required");
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> > > + =A0 =A0 =A0 }
>> > >
>> > > =A0 =A0 =A0 =A0/* Create a temporary directory & chdir there */
>> > > =A0 =A0 =A0 =A0tst_tmpdir();
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > Try tst_exit instead of NULL.
>> > Cheers,
>> > -Garrett

Acked-by: Garrett Cooper <yanegomi@gmail.com>

-Garrett

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
