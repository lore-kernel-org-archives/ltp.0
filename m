Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Rs7fp-00072x-UY
	for ltp-list@lists.sourceforge.net; Tue, 31 Jan 2012 06:58:37 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rs7fo-0007Gz-S5
	for ltp-list@lists.sourceforge.net; Tue, 31 Jan 2012 06:58:37 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0V6wUqR022752
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jan 2012 22:58:30 -0800 (PST)
Message-ID: <4F279115.3010106@windriver.com>
Date: Tue, 31 Jan 2012 14:58:29 +0800
From: Jin Li <Jin.Li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Some fix advice about test case
	kernel/syscalls/ipc/msgctl/msgctl11.c
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
To: ltp-list@lists.sourceforge.net

Hi all

I met the same issue mentioned in the post ltp-list mails as follows.

And I notice that the test will still fail with

"Not enough free pids" once the memory is lager than 4G.

Does any one has plan to fix it or give it a walk around ?

If not, I want to fix it with the update of maximum pid number

once the memory is over 4G.

Willing to get your advice.

Jin

On 2011/9/27 18:16, Caspar Zhang wrote:
 > On 09/26/2011 10:21 PM, Romu Hu wrote:
 >> Hi,
 >>
 >> msgctl11 in ltp-20110915 failed on 2.6.39 kernel:
 >>
 >> msgctl11    1  TBROK  :  Not enough free pids
 >>
 >> I found that before error out,
 >>
 >> MSGMNI is 32768
 >> MAXNKIDS is 10
 >> free_pids is 32611
 >> maxnkids = ((free_pids / 4) / MSGMNI);
 >> so maxnkids is zero, which is why msgctl11 failed.
 >>
 >> Is this problem of testcase or problem of the tested system?
 >>
 >> Thanks
 >>
 >
 > I think it's a configuration issue.
 >
 > Cyril, do you think is it better to change TBROK to TCONF here?
 >
 > -                       tst_resm(TBROK, "Not enough free pids");
 > +                       tst_resm(TCONF, "Not enough free pids");
 >
 > Thanks,
 > Caspar

I changed MSGMNI in /proc to below 3000 and test passed.

Thanks

-- 
Regards,
Romu


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
