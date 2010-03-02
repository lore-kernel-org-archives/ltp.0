Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NmTjF-0000UX-8s
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 15:09:45 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmTjD-0000xB-1x
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 15:09:45 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o22Ecqs3009611
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 07:38:52 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o22EkKg2055742
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 07:46:23 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o22EkJOX015224
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 07:46:19 -0700
Date: Tue, 2 Mar 2010 20:16:13 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100302144613.GA8623@linux.vnet.ibm.com>
References: <4B7BA433.3030206@linux.vnet.ibm.com>
	<364299f41002170908p302cc665g874c89a109ddfd1f@mail.gmail.com>
	<20100218035756.GA13013@rishikesh.in.ibm.com>
	<4B824029.7070609@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B824029.7070609@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mail_tests.sh: fix a version problem of Heirloom
 Mail
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Mon, Feb 22, 2010 at 04:28:25PM +0800, Shi Weihua wrote:
> >> There's a lot of noise in the patch because of if-else behavior in
> >> trying to determine the mail app. That's why I didn't commit this (it
> >> requires verification of previous mail applications as well).
> > 
> > Thanks Garret, Still i have not committed this to CVS repo.
> > 
> > Shi, can you please verify if this patch does not break with any other
> > mail application.
> 
>   In fact, i don't know any other mail application.
>   When i tested RHEL's alpha version, this ltp bug catched. so tried to fix it.
>   
>   Maybe, you should knock FOSS community(?).
Hi Shi,

With Feb release still i am seeing some failure with mail file.

cmdline="export TCdat=$LTPROOT/testcases/bin; mail_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
mail_tests::setup    0  TINFO  :  INIT: Removing all mails for mail_test
and root
mail_tests::mail01    0  TINFO  :  Test #1: mail root@localhost will
send mail to root
mail_tests::mail01    0  TINFO  :  Test #1: user on local machine.
mail_tests::mail01    1  TPASS  :  Test #1: Mail was sent to root & was
received
mail_tests::mail02    0  TINFO  :  Test #2: mail user@bad-domain will
result in failure
mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
daemon should
mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root.
Reason:
No mail for root
mail_tests::mail03    0  TINFO  :  Test #3: mail
non_existent_user@localhost will fail
mail_tests::mail03    0  TINFO  :  Test #3: to deliver the mail. Mailer
daemon should
mail_tests::mail03    0  TINFO  :  Test #3: report this failure.
mail_tests::mail03    3  TFAIL  :  Test #3: No new mail for root.
Reason:
No mail for root
mail_tests::mail04    0  TINFO  :  Test #4: Test that mail -c
user@domain will
mail_tests::mail04    0  TINFO  :  Test #4: carbon copy user@domain
mail_tests::mail04    4  TPASS  :  Test #4: Mail was carbon copied to
user mail_test
mail_tests::mail05    0  TINFO  :  Test #5: Test that mail -b
user@domain will
mail_tests::mail05    0  TINFO  :  Test #5: blind carbon copy
user@domain
mail_tests::mail05    5  TPASS  :  Test #5: Mail was carbon copied to
user mail_test
mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary files
from /tmp
mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary user
mail_test
<<<execution_status>>>

Can you please look into it if possible? I have run this testcase on
SLES10.SP3GA & RHEL5.4 GA on x86_64 , ppc64 & s390x and everywhere same
result.

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
