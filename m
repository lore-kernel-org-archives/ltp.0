Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NxEKk-0008Kp-IP
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 06:56:54 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxEKe-0007CA-TL
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 06:56:54 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o316ivUD022395
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 02:44:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o316ugM01880228
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 02:56:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o316ug2Q004696
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 03:56:42 -0300
Date: Thu, 1 Apr 2010 12:26:39 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100401065639.GA13796@linux.vnet.ibm.com>
References: <000301cacfac$6663edf0$332bc9d0$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000301cacfac$6663edf0$332bc9d0$@co.jp>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net


Hi Mitani,

can you please sign off ? And also send me a patch against today's git.

-Rishi

On Tue, Mar 30, 2010 at 10:57:49AM +0900, Mitani wrote:
> Hi,
> 
> I found two problems in mail test.
> (${LTPROOT}/testcases/commands/mail/mail_tests.sh)
> They are simple mistakes, I think.
> 
> 1) About judgment for making a user name
> In line 80 of "mail_tests.sh", there is following sentence.
> ------------
> if id -u mail_test >/dev/null 2>&1; then
> ------------
> This control sentence is going to judge whether the result of 
> "id -u mail_test" command is normal or not, I think.
> But this sentence is not effective.
> Therefore the user name "make_test" cannot be made when this user name
> isn't exist.
> 
> 
> 2) About "blind carbon copy" option
> In "mail_tests.sh", there are 5 tests about mail.
> 5th is "blind carbon copy" test.
> However, this test doesn't use "-b" option but uses "-c" option.
> 
> 
> Please consider the following revision.
> ============
> --- ./testcases/commands/mail/mail_tests.sh     2010-03-23
> 17:56:21.000000000 +0900
> +++ ./testcases/commands/mail/mail_tests.sh.new 2010-03-30
> 10:39:40.000000000 +0900
> @@ -77,7 +77,8 @@
> 
>  # check if the user mail_test exists on this system.
>  # if not add that user mail_test, will removed before exiting test.
> -if id -u mail_test >/dev/null 2>&1; then
> +id -u mail_test >/dev/null 2>&1
> +if [ $? -ne 0 ] ; then
>         tst_resm TINFO "INIT: Adding temporary user mail_test"
>         useradd -m -s /sbin/nologin mail_test > $LTPTMP/tst_mail.out 2>&1
>         if [ $? -ne 0 ]; then
> @@ -327,7 +328,7 @@
>  tst_resm TINFO "Test #5: blind carbon copy user@domain"
> 
>  # send mail to root and carbon copy mail_test
> -mail -s "Test" root@localhost -c mail_test@localhost < \
> +mail -s "Test" root@localhost -b mail_test@localhost < \
>         $LTPTMP/tst_mail.in > $LTPTMP/tst_mail.out 2>&1
>  if [ $? -ne 0 ]; then
>         tst_res TFAIL $LTPTMP/tst_mail.out \
> @@ -344,10 +345,10 @@
> 
>         if [ "x$RC1" != x0 -a "x$RC2" != x0 ]; then
>                 tst_resm TPASS \
> -                   "Test #5: Mail was carbon copied to user mail_test"
> +                   "Test #5: Mail was blind carbon copied to user
> mail_test"
>         else
>                 tst_res TFAIL $LTPTMP/tst_mail.res \
> -                   "Test #5: mail failed to carbon copy user mail_test.
> Reason:"
> +                   "Test #5: mail failed to blind carbon copy user
> mail_test. Reason:"
>                 : $(( TFAILCNT += 1 ))
>         fi
> 
> ============
> 
> 
> Thank you--
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
