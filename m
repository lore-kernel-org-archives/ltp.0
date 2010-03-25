Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Nugj6-00086n-2u
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 06:39:32 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nugj5-0002YR-52
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 06:39:31 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2P6UnOu019285
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Mar 2010 02:30:49 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2P6dPox1617964
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Mar 2010 02:39:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2P6dPtm024828
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Mar 2010 02:39:25 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119D5A01E@EUSAACMS0714.eamcs.ericsson.se>
References: <E0B6230F32558E43951AF1B0DEBF98102119D5A01E@EUSAACMS0714.eamcs.ericsson.se>
Date: Thu, 25 Mar 2010 12:18:25 +0530
Message-Id: <1269499707.6264.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Running LTP test suite against modified kernel
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
To: Anthony Ton <anthony.ton@ericsson.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, 2010-03-24 at 18:46 -0400, Anthony Ton wrote:
> Hello LTP team,
> Will the compilation of LTP test suites be independent of the OS
> kernel libraries?  Basically if I compiled the LTP on standard Linux
> OS and then run against the modified Linux OS kernel, would LTP test
> suites be able to run?  Or do I need to compile LTP and link with the
> modified OS kernel libraries? 

It should run perfectly well without recompilation even if you had
rebooted in a new (and much lateest) kernel version. Since LTP talks to
kernel only through the GLIBC, AIO and other user space libraries, so,
until they are intact in the system, LTP will just run fine. Now, how
the user space libraries will interact with the new kernel is a
different ballgame altogether.

Regards--
Subrata

> Thanks,
> Anthony
>  
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
