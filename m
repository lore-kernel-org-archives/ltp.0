Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseOB-0000JV-IT
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:47 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseO7-0006ue-86
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:47 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o86G1vbp023567
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 12:01:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o86GHbeg354490
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 12:17:37 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o86GHbvN027123
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 13:17:37 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTik8Vy691CGvtyK-MEwdFxLeNotdkpXkgOVP51W6@mail.gmail.com>
References: <AANLkTimbmgK15xY-3d-S4GHpKVMEjXpzbkUdMS-aTGZn@mail.gmail.com>
	<AANLkTik8Vy691CGvtyK-MEwdFxLeNotdkpXkgOVP51W6@mail.gmail.com>
Date: Mon, 06 Sep 2010 21:47:00 +0530
Message-Id: <1283789822.4947.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] {kernel/syscalls] fix signalfd4 tests to
	use	SIGSETSIZE instead of 8
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2010-08-27 at 19:49 -0700, Henry Yei wrote: 
> Please ignore the last patch. I attached an earlier incomplete version).
> Here is an updated patch which has the necessary  ltp_signal.h include
> file for the SIGSETSIZE definition.

Garret,

Can you please review and apply this as well ?

Regards--
Subrata

> 
> Henry Yei <hyei@mvista.com>
> 
> 
> 
> 
> 
> On Fri, Aug 27, 2010 at 7:31 PM, Henry Yei <hyei@mvista.com> wrote:
> > The signalfd4 tests have a hardcoded value of 8 instead of using SIGSETSIZE.
> >
> > Signed-off-by: Henry Yei <hyei@mvista.com>
> >
> > Henry Yei <hyei@mvista.com>
> >
> ------------------------------------------------------------------------------
> Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
> Be part of this innovative community and reach millions of netbook users 
> worldwide. Take advantage of special opportunities to increase revenue and 
> speed time-to-market. Join now, and jumpstart your future.
> http://p.sf.net/sfu/intel-atom-d2d
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
