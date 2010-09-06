Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseO7-0001X8-7D
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:43 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseO0-0001ct-0W
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:41 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o86Fx1Jt024062
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 11:59:01 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o86GHUPB101142
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 12:17:30 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o86GHTTm023617
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 10:17:29 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C7CD550.60508@windriver.com>
References: <4C7CD031.6060906@windriver.com>  <4C7CD550.60508@windriver.com>
Date: Mon, 06 Sep 2010 21:46:56 +0530
Message-Id: <1283789818.4947.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] [PATCH] Probe an bigger linear available
	address	to attachment.
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
To: yangzi <wyang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2010-08-31 at 18:11 +0800, yangzi wrote: 
> Hi
> Update the old patch,and the new patch is in the attachment,and please 
> review this one.

Garret, i believe he is asking to consider this one and disregard the
earlier one.

Regards--
Subrata

> 
> yangzi wrote:
> > Hi
> > 
> > When running shmat01 on some platforms, it fails on
> > "addr = shmat(*(tc.shmid), base_addr + tc.offset,tc.flags);"
> > with a INVAL error. Look at codes in "setup()", it probes
> > an available address and align the address to SHMLBA. After
> > alignment, the new address is no guarantee to be available
> > any more. Here a bigger size is used to probe so that it's
> > still valid address after alignment.Pertaining to the function 
> > setup_tc(lc, &tc) ,when it outside of "for (i = 0; i < TST_TOTAL; 
> > i++)",and printf the tc.offset value is always 0,and correct a mistake
> > of original codes to move "setup_tc()" to right place.
> > 
> > Signed-off-by: Yang Wei <wei.yang@windriver.com>
> > 
> > wei yang
> > BR
> > 
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
