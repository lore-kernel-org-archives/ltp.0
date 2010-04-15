Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O2KWY-0006Lx-5h
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:34:10 +0000
Received: from mail-yx0-f181.google.com ([209.85.210.181])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2KWV-0007PJ-RN
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:34:09 +0000
Received: by yxe11 with SMTP id 11so635047yxe.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 01:34:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100415065147.GA4557@linux.vnet.ibm.com>
References: <000301cacfac$6663edf0$332bc9d0$@co.jp>
	<20100401065639.GA13796@linux.vnet.ibm.com>
	<001e01cadc43$a6d11400$f4733c00$@co.jp>
	<20100415065147.GA4557@linux.vnet.ibm.com>
Date: Thu, 15 Apr 2010 01:34:02 -0700
Message-ID: <t2h364299f41004150134x2cdf1f2exaf1cf582a7430f7f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About mail test
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
To: Mitani <mitani@ryobi.co.jp>, ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Wed, Apr 14, 2010 at 11:51 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Apr 15, 2010 at 11:30:45AM +0900, Mitani wrote:
>> Sorry.
>> My patch was destroyed by e-mail.
>> I attach patch for "mail_tests.sh" file.
>
> Applied to next branch. Will wait for someone to Acked/test it before mer=
ging to
> master.
>
> Thanks
> -Rishi
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
>> > From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]
>> > Sent: Thursday, April 01, 2010 3:57 PM
>> > To: Mitani
>> > Cc: ltp-list@lists.sourceforge.net
>> > Subject: Re: [LTP] About mail test
>> >
>> >
>> > Hi Mitani,
>> >
>> > can you please sign off ? And also send me a patch against today's git.
>> >
>> > -Rishi
>> >
>> > On Tue, Mar 30, 2010 at 10:57:49AM +0900, Mitani wrote:
>> > > Hi,
>> > >
>> > > I found two problems in mail test.
>> > > (${LTPROOT}/testcases/commands/mail/mail_tests.sh)
>> > > They are simple mistakes, I think.
>> > >
>> > > 1) About judgment for making a user name
>> > > In line 80 of "mail_tests.sh", there is following sentence.
>> > > ------------
>> > > if id -u mail_test >/dev/null 2>&1; then
>> > > ------------
>> > > This control sentence is going to judge whether the result of
>> > > "id -u mail_test" command is normal or not, I think.
>> > > But this sentence is not effective.
>> > > Therefore the user name "make_test" cannot be made when this user
>> > name
>> > > isn't exist.
>> > >
>> > >
>> > > 2) About "blind carbon copy" option
>> > > In "mail_tests.sh", there are 5 tests about mail.
>> > > 5th is "blind carbon copy" test.
>> > > However, this test doesn't use "-b" option but uses "-c" option.
>> > >
>> > >
>> > > Please consider the following revision.
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > --- ./testcases/commands/mail/mail_tests.sh =A0 =A0 2010-03-23
>> > > 17:56:21.000000000 +0900
>> > > +++ ./testcases/commands/mail/mail_tests.sh.new 2010-03-30
>> > > 10:39:40.000000000 +0900
>> > > @@ -77,7 +77,8 @@
>> > >
>> > > =A0# check if the user mail_test exists on this system.
>> > > =A0# if not add that user mail_test, will removed before exiting tes=
t.
>> > > -if id -u mail_test >/dev/null 2>&1; then
>> > > +id -u mail_test >/dev/null 2>&1
>> > > +if [ $? -ne 0 ] ; then
>> > > =A0 =A0 =A0 =A0 tst_resm TINFO "INIT: Adding temporary user mail_tes=
t"
>> > > =A0 =A0 =A0 =A0 useradd -m -s /sbin/nologin mail_test >
>> > $LTPTMP/tst_mail.out 2>&1
>> > > =A0 =A0 =A0 =A0 if [ $? -ne 0 ]; then
>> > > @@ -327,7 +328,7 @@
>> > > =A0tst_resm TINFO "Test #5: blind carbon copy user@domain"
>> > >
>> > > =A0# send mail to root and carbon copy mail_test
>> > > -mail -s "Test" root@localhost -c mail_test@localhost < \
>> > > +mail -s "Test" root@localhost -b mail_test@localhost < \
>> > > =A0 =A0 =A0 =A0 $LTPTMP/tst_mail.in > $LTPTMP/tst_mail.out 2>&1
>> > > =A0if [ $? -ne 0 ]; then
>> > > =A0 =A0 =A0 =A0 tst_res TFAIL $LTPTMP/tst_mail.out \
>> > > @@ -344,10 +345,10 @@
>> > >
>> > > =A0 =A0 =A0 =A0 if [ "x$RC1" !=3D x0 -a "x$RC2" !=3D x0 ]; then
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS \
>> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #5: Mail was carbon copi=
ed to user
>> > mail_test"
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #5: Mail was blind carbo=
n copied to user
>> > > mail_test"
>> > > =A0 =A0 =A0 =A0 else
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res TFAIL $LTPTMP/tst_mail.res \
>> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #5: mail failed to carbo=
n copy user
>> > mail_test.
>> > > Reason:"
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #5: mail failed to blind=
 carbon copy user
>> > > mail_test. Reason:"
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : $(( TFAILCNT +=3D 1 ))
>> > > =A0 =A0 =A0 =A0 fi
>> > >
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Apart from the comment above the BCC test being incorrect, everything
looks fine.

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
