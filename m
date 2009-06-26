Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MK9lK-0004ke-N6
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:38:34 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MK9lH-00088V-Ab
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:38:34 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5QBZNjw012842
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:35:23 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5QBcU8U242636
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:38:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5QBcTQn014707
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:38:30 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A4490B2.4070803@bull.net>
References: <4A4490B2.4070803@bull.net>
Date: Fri, 26 Jun 2009 17:03:18 +0530
Message-Id: <1246015998.6196.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] clock_nanosleep01 TestCase FAIL --> is it known?
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net, maknayak@in.ibm.com

On Fri, 2009-06-26 at 11:11 +0200, Jacky Malcles wrote: 
> is it a testcase issue? (because case05 ends with OK).

Not sure. A new entrant and that too blind port. Needs analysis.

Regards--
Subrata

> report:
> [root@xena3 clock_nanosleep]# ./clock_nanosleep01
> clock_nanosleep01    0  INFO  :  (case00) START
> clock_nanosleep01    0  INFO  :  check sleep time: (min:480) < 507 < 
> (max:520) (msec)
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=0 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=0 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case00) END => NG
> clock_nanosleep01    0  INFO  :  (case01) START
> clock_nanosleep01    0  INFO  :  check sleep time: (min:480) < 509 < 
> (max:520) (msec)
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=0 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=0 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case01) END => NG
> clock_nanosleep01    0  INFO  :  (case02) START
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=22 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case02) END => NG
> clock_nanosleep01    0  INFO  :  (case03) START
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=22 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case03) END => NG
> clock_nanosleep01    0  INFO  :  (case04) START
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=95 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case04) END => NG
> clock_nanosleep01    0  INFO  :  (case05) START
> clock_nanosleep01    0  INFO  :  remain time: 9 490280000
> EXPECT: return value(ret)=4 errno=0 (Success)
> RESULT: return value(ret)=4 errno=0 (Success)
> clock_nanosleep01    0  INFO  :  (case05) END => OK
> clock_nanosleep01    1  FAIL  :  clock_nanosleep01 failed - errno = 0 : 
> Success
> clock_nanosleep01    0  INFO  :  NG
> [root@xena3 clock_nanosleep]#
> thanks,
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
