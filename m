Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R1uCJ-00035Y-TN
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 06:04:19 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R1uCI-0001PB-UG
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 06:04:19 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p895vafq014130
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 15:57:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8964CWS1687638
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 16:04:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8964BRH019926
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 16:04:11 +1000
Received: from [127.0.0.1] ([9.124.46.47])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p89648Ao019849
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Sep 2011 16:04:10 +1000
Message-ID: <4E69AC58.3080300@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 11:34:08 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [Patch] readlink03 test case fix
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

>  In readlink03 testcase,
>  When 'Symlink Pathname is empty' the return value was 'ENOENT' but with
>  newer kernels the return value is 'EINVAL'. The following patch will fix
>  this.
>
>  readlink03:
>  Before patch:
>  ...
>  readlink03    9  TFAIL  :  readlink() failed, Symlink Pathname is empty,
>  errno=22, expected errno=2
>  ...
>
>  After patch:
>  ...
>  readlink03    9  TPASS  :  readlink(), Symlink Pathname is empty,
>  returned errno 22
>  readlink03   10  TPASS  :  readlink(), Symlink Pathname is empty,
>  returned errno 22
>  ...
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
