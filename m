Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MLE83-00011j-Ph
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 10:30:27 +0000
Received: from e28smtp02.in.ibm.com ([59.145.155.2])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MLE81-0005bA-Vy
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 10:30:27 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5TAU9Di005123
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2009 16:00:09 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5TAU9CG1659100
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2009 16:00:09 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5TAU83W006392
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2009 16:00:09 +0530
Message-ID: <4A4897B7.9030109@in.ibm.com>
Date: Mon, 29 Jun 2009 16:00:15 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
In-Reply-To: <4A486E66.5050102@cn.fujitsu.com>
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com


Wei Yongjun
>>
>> Should we treat this as Test case issue or kernel bug?
> 
> The different of 'nobody' and 'bin' is bin->GID has the CAP_FSETID 
> capability, but nobody->GID has not, I think.
> 
I am facing some issues with getcap, how else can I verify the USER capabilities
If there is a simpler way to check user capabilities please let me know

My efforts to use getcap fails

getcap /tmp/test1
Failed to get capabilities for file `/tmp/test1'
  (Function not implemented)

Thank you

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
