Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cxie@redhat.com>) id 1WfP0s-0005NC-VZ
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 07:33:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WfP0r-0007QY-Jt
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 07:33:06 +0000
From: Madper Xie <cxie@redhat.com>
Date: Wed, 30 Apr 2014 15:32:55 +0800
Message-ID: <8761lrclw8.fsf@redhat.com>
MIME-Version: 1.0
Subject: [LTP] kms0* failed randomly?
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
To: ltp-list <ltp-list@lists.sf.net>

Hey folks,
  I always meet kms0* cases failed during my testing.

> # ./runltp -p -l ksm02.log -o ksm02.run.log -s ksm02
> # cat /opt/ltp/results/ksm02.log
> Test Start Time: Tue Apr 29 13:55:12 2014
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> ksm02                          FAIL       1
> ksm02_1                        FAIL       1
> 
> -----------------------------------------------
> Total Tests: 2
> Total Failures: 2
> Kernel Version: 3.10.0-121.el7.x86_64
> Machine Architecture: x86_64
> 
> # cat /opt/ltp/output/LTP_RUN_ON-ksm02.run.log.failed
> ksm02 ksm02
> ksm02_1 ksm02 -u 128
> 
> /opt/ltp/output/ksm02.run.log needs to be pulled off the machine
> 
> # ./runltp -p -l ksm04.log -o ksm04.run.log -s ksm04
> # cat /opt/ltp/results/ksm04.log
> Test Start Time: Tue Apr 29 14:05:36 2014
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> ksm04                          FAIL       1
> ksm04_1                        FAIL       1
> 
> -----------------------------------------------
> Total Tests: 2
> Total Failures: 2
> Kernel Version: 3.10.0-121.el7.x86_64
> Machine Architecture: x86_64

  I guess it's a case issue due to I dig a thread from grave:
  http://marc.info/?l=ltp-list&m=130224093113466&w=2
  Seems the patch has not been merged so far?
  
-- 
Sent with my mu4e


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
