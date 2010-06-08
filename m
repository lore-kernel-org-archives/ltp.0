Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1OM0Nu-0002jq-CP
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 15:06:34 +0000
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OM0Ns-0006Dj-Oi
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 15:06:34 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id o58F6Ot3012882
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 20:36:24 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o58F6Ors3211274
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 20:36:24 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o58F6OL5018910
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Jun 2010 01:06:24 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
In-Reply-To: <AANLkTikReF6tpyTcBysNGSu5hOirEtitIZlJ7UfMfe6M@mail.gmail.com>
References: <1275993506.5822.37.camel@munipradeep-laptop>
	<AANLkTikReF6tpyTcBysNGSu5hOirEtitIZlJ7UfMfe6M@mail.gmail.com>
Date: Tue, 08 Jun 2010 20:36:22 +0530
Message-ID: <1276009582.4844.1.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for echo testcase
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
To: Subrata Modak <tosubrata@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Subrata,

This is on x86 and 2.6.32 kernel.

Thanks
Muni

On Tue, 2010-06-08 at 16:16 +0530, Subrata Modak wrote:
> Thanks Muni. Please also post the machine details(arch, kernel
> version,etc) so that i can verify the same.
> 
> Regards--
> Subrata
> 
> On Tue, Jun 8, 2010 at 4:08 PM, Munipradeep Beerakam
> <mpradeep@linux.vnet.ibm.com> wrote:
>         Hi,
>         
>         echo test is failing with the below errors as we didn't
>         initialized the
>         'addrlen' parameter of getsockname.
>         
>         ####################################
>         ...
>         ...
>         Creating socket .....
>         echoes      1  TBROK  :  getsockname call failed (pid=7086):
>         Invalid
>         argument
>         echo: Invalid argument
>         ...
>         ...
>         ####################################
>         
>         So, attached the patch which initializes the 'addrlen'
>         parameter.
>         
>         Please correct if anything is wrong.
>         
>         Thanks
>         Muni
>         
>         ------------------------------------------------------------------------------
>         ThinkGeek and WIRED's GeekDad team up for the Ultimate
>         GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>         lucky parental unit.  See the prize list and enter to win:
>         http://p.sf.net/sfu/thinkgeek-promo
>         _______________________________________________
>         Ltp-list mailing list
>         Ltp-list@lists.sourceforge.net
>         https://lists.sourceforge.net/lists/listinfo/ltp-list
>         
> 
> 
> 
> -- 
> Regards & Thanks--
> Subrata



------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
