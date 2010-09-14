Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OvOH3-00030a-0H
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 05:41:45 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvOH0-0005CS-ON
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 05:41:44 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8E5Qqc0026294
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 01:26:52 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8E5fajc105612
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 01:41:37 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8E5jGY1028601
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 23:45:16 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OF2051634D.461B535C-ON8525779D.0061808E-8525779D.00626E02@us.ibm.com>
References: <OF2051634D.461B535C-ON8525779D.0061808E-8525779D.00626E02@us.ibm.com>
Date: Tue, 14 Sep 2010 11:11:33 +0530
Message-Id: <1284442893.5001.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] hugeshmat
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
To: Scott Romanowski <romansc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Scott,

Are you contemplating in submitting some patches for the HUGETLB tests
in LTP ?

Regards--
Subrata

On Mon, 2010-09-13 at 13:55 -0400, Scott Romanowski wrote:
> >hi,
> > I am getting error in hugetlb testcase, most of the tests are
> failing
> >because of the following error:-
> >
> >"could not read hugepages from /proc/meminfo"
> >hugeshmat tests are having this error.
> >please help me as how to resolve this error.
> >
> >-- 
> >Regards,
> >Arjit Sharma.
> 
> I could not find that specific error in either the 20100228 or
> 20100831 releases. There are similar ones in
> lib/system_specific_hugepages_info.c though, in get_no_of_hugepages()
> and hugepages_size(). If you cat /proc/meminfo, do you see any lines
> for hugepages? For example:
> 
> HugePages_Total: 10
> HugePages_Free: 10
> HugePages_Rsvd: 0
> Hugepagesize: 2048 kB
> 
> If the first and last lines are not there, you would get an error
> message like what you see.
> 
> --
> Scott Romanowski
> 978-899-5384
> BG125C
> 
> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
