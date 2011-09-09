Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R1uAi-0003DE-MS
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 06:02:40 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R1uAh-0001JB-BN
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 06:02:40 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p895tqnB013566
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 15:55:52 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8960n9K1519688
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 16:00:50 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8962QXj017799
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 16:02:26 +1000
Received: from [127.0.0.1] ([9.124.46.47])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p8962Otd017726
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 16:02:25 +1000
Message-ID: <4E69ABEF.9050905@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 11:32:23 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [Patch] sockioctl01 test case fix
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

Hello,

Any comments on this patch. Thanks!!

>  In sockioctl01 testcase,
>  Current 'inappropriate ioctl operation returning EINVAL'
>
>  With the git commit '41c31f318a5209922d051e293c61e4724daad11c' more
>  details athttp://permalink.gmane.org/gmane.linux.kernel.commits.head/296060
>
>  'inappropriate ioctl operation returning ENOTTY'
>
>  The following patch will fix this.
>
>
>  sockioctl01:
>  Before patch:
>  ...
>  sockioctl01    4  TFAIL  :  ATMARK on UDP ; returned -1 (expected -1),
>  errno 25 (expected 22)
>  ...
>
>  After patch:
>  ...
>  sockioctl01    4  TPASS  :  ATMARK on UDP successful
>  ...
>
>
>  Signed-off-by: Nageswara R Sastry<rnsastry@...>

-- 
Regards
R.Nageswara Sastry



------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
