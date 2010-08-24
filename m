Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OnrHB-0006FG-Qd
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:02:45 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OnrHA-0006K6-E0
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:02:45 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7OAiliQ009200
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 06:44:47 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7OB2cSY441958
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 07:02:38 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7OB697M005729
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 05:06:10 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <52CF90264091A14888078A031D780F43064456F9@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F43064456F9@ism-mail03.corp.ad.wrs.com>
Date: Tue, 24 Aug 2010 16:32:37 +0530
Message-Id: <1282647757.4833.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Rt_sigprocmask01 test case caused "segment fault" on x86
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
To: "Fu, Yingang" <Yingang.Fu@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2010-08-18 at 13:22 +0200, Fu, Yingang wrote: 
> hi, Garrett
>  
> This is a similar problem as rt_sigsuspend01 which has been fix
> before.
>  
> Failed log:
> 
> root@Congatec:/opt/ltp-full> ./testcases/bin/rt_sigprocmask01
> Segmentation fault
> 
> After apply the patch:
> root@Congatec:/opt/ltp-full> ./testcases/bin/rt_sigprocmask01
> rt_sigprocmask01    1  TPASS  :  rt_sigprocmask functionality passed
> 
> Signed-off-by: Yingang Fu <yingang.fu@windriver.com>

Thanks. Applied.

Regards--
Subrata

>  
> Thanks
> Yingang
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by 
> 
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev 
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
