Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OO9Ai-0005me-Pd
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:53:48 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OO9Ag-0008L5-FE
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:53:48 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5ECS40K022905
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:28:04 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5ECYUmv181044
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:34:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o5ECYSWq004415
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:34:30 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1276009582.4844.1.camel@munipradeep-laptop>
References: <1275993506.5822.37.camel@munipradeep-laptop>
	<AANLkTikReF6tpyTcBysNGSu5hOirEtitIZlJ7UfMfe6M@mail.gmail.com>
	<1276009582.4844.1.camel@munipradeep-laptop>
Date: Mon, 14 Jun 2010 18:04:21 +0530
Message-Id: <1276518862.4885.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for echo testcase
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2010-06-08 at 20:36 +0530, Munipradeep Beerakam wrote: 
> Hi Subrata,
> 
> This is on x86 and 2.6.32 kernel.

Thanks.

Regards--
Subrata

> 
> Thanks
> Muni
> 
> On Tue, 2010-06-08 at 16:16 +0530, Subrata Modak wrote:
> > Thanks Muni. Please also post the machine details(arch, kernel
> > version,etc) so that i can verify the same.
> > 
> > Regards--
> > Subrata
> > 
> > On Tue, Jun 8, 2010 at 4:08 PM, Munipradeep Beerakam
> > <mpradeep@linux.vnet.ibm.com> wrote:
> >         Hi,
> >         
> >         echo test is failing with the below errors as we didn't
> >         initialized the
> >         'addrlen' parameter of getsockname.
> >         
> >         ####################################
> >         ...
> >         ...
> >         Creating socket .....
> >         echoes      1  TBROK  :  getsockname call failed (pid=7086):
> >         Invalid
> >         argument
> >         echo: Invalid argument
> >         ...
> >         ...
> >         ####################################
> >         
> >         So, attached the patch which initializes the 'addrlen'
> >         parameter.
> >         
> >         Please correct if anything is wrong.
> >         
> >         Thanks
> >         Muni
> >         
> >         ------------------------------------------------------------------------------
> >         ThinkGeek and WIRED's GeekDad team up for the Ultimate
> >         GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> >         lucky parental unit.  See the prize list and enter to win:
> >         http://p.sf.net/sfu/thinkgeek-promo
> >         _______________________________________________
> >         Ltp-list mailing list
> >         Ltp-list@lists.sourceforge.net
> >         https://lists.sourceforge.net/lists/listinfo/ltp-list
> >         
> > 
> > 
> > 
> > -- 
> > Regards & Thanks--
> > Subrata
> 
> 
> 
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
> lucky parental unit.  See the prize list and enter to win: 
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
