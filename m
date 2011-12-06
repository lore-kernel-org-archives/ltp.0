Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1RXsXx-000787-KU
	for ltp-list@lists.sourceforge.net; Tue, 06 Dec 2011 10:46:49 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RXsXp-0007gw-Gu
	for ltp-list@lists.sourceforge.net; Tue, 06 Dec 2011 10:46:49 +0000
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Tue, 6 Dec 2011 16:16:31 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	pB6AkSZB2101454
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Dec 2011 16:16:29 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	pB6AkSRs012925
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Dec 2011 21:46:28 +1100
Message-ID: <4EDDF283.2040901@linux.vnet.ibm.com>
Date: Tue, 06 Dec 2011 16:16:27 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <20111127201232.GB2268@nik-comp.lan>
	<4ED480A4.2000003@linux.vnet.ibm.com>
	<20111129220308.GA3953@nik-comp.lan>
	<4ED90B1C.8000204@linux.vnet.ibm.com>
	<20111205120118.GK988@pcnci.linuxbox.cz>
In-Reply-To: <20111205120118.GK988@pcnci.linuxbox.cz>
Subject: Re: [LTP] LTP: memcg_stress_test hanging whole box
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
To: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: ltp-list@lists.sourceforge.net


Hi Nikola,

> yup, it's possible to reproduce just with this one test..
> so do You want me to collect OOM traces and report here? or directly to
> LKML?

I suggest you report it here as well as to LKML. I will try to have a 
look from test case perspective. Please clearly mention the test which 
is causing the issue, architecture/hardware and kernel details on which 
you are getting this issue.

Thanks,
Shubham


------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
