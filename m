Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2EsB-0000G0-S7
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 02:32:07 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2Es8-0007Fq-Ke
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 02:32:07 +0000
Message-ID: <001e01cadc43$a6d11400$f4733c00$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 15 Apr 2010 11:30:45 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_11_30_46_Thursday_April_15_2010_18669"
References: <000301cacfac$6663edf0$332bc9d0$@co.jp>
	<20100401065639.GA13796@linux.vnet.ibm.com>
In-Reply-To: <20100401065639.GA13796@linux.vnet.ibm.com>
Content-Language: ja
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Rishikesh K Rajak' <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

----=_NextPart_ST_11_30_46_Thursday_April_15_2010_18669
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Sorry.
My patch was destroyed by e-mail.
I attach patch for "mail_tests.sh" file.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>


Regards--

-Tomonori Mitani

> -----Original Message-----
> From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]
> Sent: Thursday, April 01, 2010 3:57 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About mail test
> 
> 
> Hi Mitani,
> 
> can you please sign off ? And also send me a patch against today's git.
> 
> -Rishi
> 
> On Tue, Mar 30, 2010 at 10:57:49AM +0900, Mitani wrote:
> > Hi,
> >
> > I found two problems in mail test.
> > (${LTPROOT}/testcases/commands/mail/mail_tests.sh)
> > They are simple mistakes, I think.
> >
> > 1) About judgment for making a user name
> > In line 80 of "mail_tests.sh", there is following sentence.
> > ------------
> > if id -u mail_test >/dev/null 2>&1; then
> > ------------
> > This control sentence is going to judge whether the result of
> > "id -u mail_test" command is normal or not, I think.
> > But this sentence is not effective.
> > Therefore the user name "make_test" cannot be made when this user
> name
> > isn't exist.
> >
> >
> > 2) About "blind carbon copy" option
> > In "mail_tests.sh", there are 5 tests about mail.
> > 5th is "blind carbon copy" test.
> > However, this test doesn't use "-b" option but uses "-c" option.
> >
> >
> > Please consider the following revision.
> > ============
> > --- ./testcases/commands/mail/mail_tests.sh     2010-03-23
> > 17:56:21.000000000 +0900
> > +++ ./testcases/commands/mail/mail_tests.sh.new 2010-03-30
> > 10:39:40.000000000 +0900
> > @@ -77,7 +77,8 @@
> >
> >  # check if the user mail_test exists on this system.
> >  # if not add that user mail_test, will removed before exiting test.
> > -if id -u mail_test >/dev/null 2>&1; then
> > +id -u mail_test >/dev/null 2>&1
> > +if [ $? -ne 0 ] ; then
> >         tst_resm TINFO "INIT: Adding temporary user mail_test"
> >         useradd -m -s /sbin/nologin mail_test >
> $LTPTMP/tst_mail.out 2>&1
> >         if [ $? -ne 0 ]; then
> > @@ -327,7 +328,7 @@
> >  tst_resm TINFO "Test #5: blind carbon copy user@domain"
> >
> >  # send mail to root and carbon copy mail_test
> > -mail -s "Test" root@localhost -c mail_test@localhost < \
> > +mail -s "Test" root@localhost -b mail_test@localhost < \
> >         $LTPTMP/tst_mail.in > $LTPTMP/tst_mail.out 2>&1
> >  if [ $? -ne 0 ]; then
> >         tst_res TFAIL $LTPTMP/tst_mail.out \
> > @@ -344,10 +345,10 @@
> >
> >         if [ "x$RC1" != x0 -a "x$RC2" != x0 ]; then
> >                 tst_resm TPASS \
> > -                   "Test #5: Mail was carbon copied to user
> mail_test"
> > +                   "Test #5: Mail was blind carbon copied to user
> > mail_test"
> >         else
> >                 tst_res TFAIL $LTPTMP/tst_mail.res \
> > -                   "Test #5: mail failed to carbon copy user
> mail_test.
> > Reason:"
> > +                   "Test #5: mail failed to blind carbon copy user
> > mail_test. Reason:"
> >                 : $(( TFAILCNT += 1 ))
> >         fi
> >
> > ============
> >
> >
> > Thank you--
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

----=_NextPart_ST_11_30_46_Thursday_April_15_2010_18669
Content-Type: application/octet-stream;
	name="mail_tests.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mail_tests.patch"

--- a/testcases/commands/mail/mail_tests.sh=092010-04-01 16:15:00.000000000=
 +0900=0A+++ b/testcases/commands/mail/mail_tests.sh=092010-04-01 20:54:40.=
000000000 +0900=0A@@ -77,7 +77,8 @@=0A =0A # check if the user mail_test ex=
ists on this system.=0A # if not add that user mail_test, will removed befo=
re exiting test.=0A-if id -u mail_test >/dev/null 2>&1; then=0A+id -u mail_=
test >/dev/null 2>&1=0A+if [ $=3F -ne 0 ] ; then=0A =09tst_resm TINFO "INIT=
: Adding temporary user mail_test"=0A =09useradd -m -s /sbin/nologin mail_t=
est > $LTPTMP/tst_mail.out 2>&1=0A =09if [ $=3F -ne 0 ]; then=0A@@ -327,7 +=
328,7 @@=0A tst_resm TINFO "Test #5: blind carbon copy user@domain"=0A =0A =
# send mail to root and carbon copy mail_test =0A-mail -s "Test" root@local=
host -c mail_test@localhost < \=0A+mail -s "Test" root@localhost -b mail_te=
st@localhost < \=0A =09$LTPTMP/tst_mail.in > $LTPTMP/tst_mail.out 2>&1=0A i=
f [ $=3F -ne 0 ]; then=0A =09tst_res TFAIL $LTPTMP/tst_mail.out \=0A@@ -344=
,10 +345,10 @@=0A =0A =09if [ "x$RC1" !=3D x0 -a "x$RC2" !=3D x0 ]; then=0A=
 =09=09tst_resm TPASS \=0A-=09=09    "Test #5: Mail was carbon copied to us=
er mail_test"=0A+=09=09    "Test #5: Mail was blind carbon copied to user m=
ail_test"=0A =09else=0A =09=09tst_res TFAIL $LTPTMP/tst_mail.res \=0A-=09=09=
    "Test #5: mail failed to carbon copy user mail_test. Reason:"=0A+=09=09=
    "Test #5: mail failed to blind carbon copy user mail_test. Reason:"=0A =
=09=09: $(( TFAILCNT +=3D 1 ))=0A =09fi=0A =0A
----=_NextPart_ST_11_30_46_Thursday_April_15_2010_18669
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
----=_NextPart_ST_11_30_46_Thursday_April_15_2010_18669
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_11_30_46_Thursday_April_15_2010_18669--

