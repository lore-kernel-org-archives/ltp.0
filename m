Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S5A35-0008UC-Fm
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 06:08:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S5A31-0006Cp-Dy
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 06:08:31 +0000
Message-ID: <4F56FB1A.8090601@cn.fujitsu.com>
Date: Wed, 07 Mar 2012 14:07:22 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAB_zjmVhfAKzJLE7q0eogRtaV6UoZvkgjH20EepDtykmg+e7kw@mail.gmail.com>
In-Reply-To: <CAB_zjmVhfAKzJLE7q0eogRtaV6UoZvkgjH20EepDtykmg+e7kw@mail.gmail.com>
Subject: Re: [LTP] mail test failure on kernel 3.2.6
Reply-To: gaowanlong@cn.fujitsu.com
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
To: pavani pavani <a2zpavani@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 03/06/2012 11:59 PM, pavani pavani wrote:

> Hi All, 
>       Executed  the the Jan release of LTP ( 20120104 )  on kernel 3.2.6 kernel , getting the  error below .  
> .
> mail_tests::mail01    0  TINFO  :  Test #1: user on local machine. 
> mail_tests::mail01    1  TPASS  :  Test #1: Mail was sent to root & was received 
> mail_tests::mail02    0  TINFO  :  Test #2: mail user@bad-domain will result in failure 
> mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer daemon should 
> mail_tests::mail02    0  TINFO  :  Test #2: report this failure. 
> mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root. Reason: 
> No mail for root 
> mail_tests::mail03    0  TINFO  :  Test #3: mail non_existent_user@localhost will fail 
> mail_tests::mail03    0  TINFO  :  Test #3: to deliver the mail. Mailer daemon should 
> mail_tests::mail03    0  TINFO  :  Test #3: report this failure. 
> Heirloom mailx version 12.2 01/07/07.  Type ? for help. 
> mail_tests::mail03    3  TFAIL  :  Test #3: Mailer-Daemon failed to report delivery failure. Reason: 
> Heirloom mailx version 12.2 01/07/07.  Type ? for help. 
> "/var/mail/root": 1 message 1 new 
>>N  1 MAILER-DAEMON@linu Wed Mar  7 01:17   72/2352  Undelivered Mail Returned 


The "MAILER-DAEMON@linu" here seems odd.

Thanks,
Wanlong Gao

> mail_tests::mail04    0  TINFO  :  Test #4: Test that mail -c user@domain will 
> mail_tests::mail04    0  TINFO  :  Test #4: carbon copy user@domain 
> mail_tests::mail04    4  TPASS  :  Test #4: Mail was carbon copied to user mail_test 
> mail_tests::mail05    0  TINFO  :  Test #5: Test that mail -b user@domain will 
> mail_tests::mail05    0  TINFO  :  Test #5: blind carbon copy user@domain 
> mail_tests::mail05    5  TPASS  :  Test #5: Mail was blind copied to user mail_test 
> mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary files from /tmp 
> mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary user mail_test 
> <<<execution_status>>> 
> initiation_status="ok" 
> duration=30 termination_type=exited termination_id=2 corefile=no 
> cutime=0 cstime=2 
> <<<test_end>>> 
> INFO: ltp-pan reported some tests FAIL 
> LTP Version: LTP-20120104
> 
> Wondering did anyone has come across this problem ?
> 
> Regards,
> Pavani
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
