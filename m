Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v1I-0005l1-MV
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:16 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v1H-000154-OO
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:16 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466t471022128
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:55:04 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466v9no1384458
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:57:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o466v8Tq031324
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 03:57:09 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:26:59 +0530
Message-Id: <20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [04/12 FAILURE] LTPX sysctl03 test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4596973607495286714=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============4596973607495286714==

Subject: LTP�� sysctl03 test fails

Issues Description Below:
=====================================
# ./runltp -s sysctl03
<<<test_output>>>
sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
sysctl03    2  TFAIL  :  Expected EPERM, got 13
sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Regards--
Subrata



--===============4596973607495286714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4596973607495286714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4596973607495286714==--
