Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1QMycW-0004aB-6N
	for ltp-list@lists.sourceforge.net; Thu, 19 May 2011 08:30:12 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QMycU-0000dx-TY
	for ltp-list@lists.sourceforge.net; Thu, 19 May 2011 08:30:12 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4J8U2cO016217
	for <ltp-list@lists.sourceforge.net>; Thu, 19 May 2011 14:00:02 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4J8U2Qp4227132
	for <ltp-list@lists.sourceforge.net>; Thu, 19 May 2011 14:00:02 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4J8U1t4002945
	for <ltp-list@lists.sourceforge.net>; Thu, 19 May 2011 18:30:02 +1000
Message-ID: <4DD4D509.6090407@linux.vnet.ibm.com>
Date: Thu, 19 May 2011 14:00:01 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <loom.20110518T201407-12@post.gmane.org>
In-Reply-To: <loom.20110518T201407-12@post.gmane.org>
Subject: Re: [LTP] LTP version in ChangeLog not updated?
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
To: Sandip Bhattacharya <sandipb@foss-community.com>
Cc: ltp-list@lists.sourceforge.net

On Wednesday 18 May 2011 11:46 PM, Sandip Bhattacharya wrote:
> I just cloned the LTP git repo from SF and ran the suite. Strangely, the report
> showed the LTP version to be an old one. Is something amiss?

The LTP present in SF is the latest stable one and  nothing is missing. 
The reason for getting older version in HTML report is probably the 
'Version' file present in the LTP tree is having older version entry. I 
will make sure that this file is updated in the next release.

Thanks, Shubham

------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
