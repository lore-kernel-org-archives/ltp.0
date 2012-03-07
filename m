Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S5A15-00036A-RZ
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 06:06:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S5A13-0004iz-US
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 06:06:27 +0000
Message-ID: <4F56FAA2.30302@cn.fujitsu.com>
Date: Wed, 07 Mar 2012 14:05:22 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAB_zjmWr7tSNwfMrEd_FX6BOtjLhqKCJm7F1vf6kNW5DTfWCLw@mail.gmail.com>
In-Reply-To: <CAB_zjmWr7tSNwfMrEd_FX6BOtjLhqKCJm7F1vf6kNW5DTfWCLw@mail.gmail.com>
Subject: Re: [LTP] cron_allow01 failure on 3.2.6 kernel
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

On 03/07/2012 12:14 AM, pavani pavani wrote:

> Hi All ,
> 
>         On 3.2.6 kernel ,found the "cron_allo01" was failing .


The log below seems not for cron_allow01?

Thanks,
Wanlong Gao

> 
> 
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
> suggest if anyone is facing the similar error.
> 
> Thanks
> Pavani
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
