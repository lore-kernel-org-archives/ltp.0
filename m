Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseNl-0001T3-97
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:21 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseNk-00051L-Ag
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:21 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o86G1YBD023241
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 12:01:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o86GHE4U091346
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 12:17:14 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o86GHD8t003729
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 10:17:13 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <52CF90264091A14888078A031D780F430D093D@ism-mail03.corp.ad.wrs.com>
References: <4C7CDA7E.2020505@windriver.com>
	<52CF90264091A14888078A031D780F430D093D@ism-mail03.corp.ad.wrs.com>
Date: Mon, 06 Sep 2010 21:46:49 +0530
Message-Id: <1283789810.4947.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Probe an bigger linear available
	address	to	attachment.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, "Yang, Wei" <Wei.Yang@windriver.com>

Garret, this patch ?

Regards--
Subrata

On Tue, 2010-08-31 at 12:36 +0200, Yang, Wei wrote:
> Hi
> 
> When running shmat01 on some platforms, it fails on
> "addr = shmat(*(tc.shmid), base_addr + tc.offset,tc.flags);"
> with a INVAL error. Look at codes in "setup()", it probes
> an available address and align the address to SHMLBA. After
> alignment, the new address is no guarantee to be available
> any more. Here a bigger size is used to probe so that it's
> still valid address after alignment.Pertaining to the function
> setup_tc(lc, &tc) ,when it outside of "for (i = 0; i < TST_TOTAL;
> i++)",and printf the tc.offset value is always 0,add correct a mistake
> of original codes to move "setup_tc()" to right place.
> 
> Signed-off-by: Yang Wei <wei.yang@windriver.com>
> 
> wei yang
> BR
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.net Dev2Dev email is sponsored by:
> 
> Show off your parallel programming skills.
> Enter the Intel(R) Threading Challenge 2010.
> http://p.sf.net/sfu/intel-thread-sfd
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
