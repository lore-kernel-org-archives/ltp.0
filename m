Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chandru@in.ibm.com>) id 1MtGqA-0002ZY-TP
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 08:16:42 +0000
Received: from e28smtp04.in.ibm.com ([59.145.155.4])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MtGpz-0003TA-Vr
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 08:16:42 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id n918GLso007125
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 13:46:21 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n918GLxr2412558
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 13:46:21 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n918GLWU006190
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 18:16:21 +1000
Message-ID: <4AC46552.7090806@in.ibm.com>
Date: Thu, 01 Oct 2009 13:46:18 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
References: <200909241229.32866.chandru@in.ibm.com>
	<200909260725.29279.vapier@gentoo.org>
	<200910011257.47226.chandru@in.ibm.com>
In-Reply-To: <200910011257.47226.chandru@in.ibm.com>
Subject: Re: [LTP] [PATCH] ppoll01: add signal() syscall to register the
 signal handler
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Chandru wrote:
> I will retain the current existing tst_resm lines and add TFAIL|TTERRNO to it as per your suggestion. The reason being that 
> there is not much gain in making the above changes to the test case.
Sorry, did not change that line at all.

Thanks
Chandru

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
