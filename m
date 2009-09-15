Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnRDX-0006aL-Jy
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 06:08:43 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnRDP-00075H-CF
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 06:08:43 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AADF6FD.3020802@cn.fujitsu.com>
References: <4AADF6FD.3020802@cn.fujitsu.com>
Date: Tue, 15 Sep 2009 11:38:25 +0530
Message-Id: <1252994905.5874.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH]:fix the bug of macro in getdelays.c
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
To: liubo <liubo-fnst@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, 2009-09-14 at 15:55 +0800, liubo wrote: 
> When running cgroup test, I found a bug of macro in 
> getdelays.c, which refers to the spelling mistake. 
> And this leads to testcase_eight's abnormal delay. 
> 
> Relative macro:
> 	HAVE_LINUX_CGROUPSTATS_H
> 
> Change macro HAVE_LINUX_CGROUPSTAT_H to HAVE_LINUX_CGROUPSTATS_H
> to fix the bug.
> 
> 
> signed-off-by:Liu Bo <liubo-fnst@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
> diff --git a/testcases/kernel/controllers/cgroup/getdelays.c b/testcases/kernel/controllers/cgroup/getdelays.c
> index 478b325..c9f532d 100644
> --- a/testcases/kernel/controllers/cgroup/getdelays.c
> +++ b/testcases/kernel/controllers/cgroup/getdelays.c
> @@ -397,7 +397,7 @@ int main(int argc, char *argv[])
>  	}
> 
>  	if (containerset) {
> -		#ifdef HAVE_LINUX_CGROUPSTAT_H
> +		#ifdef HAVE_LINUX_CGROUPSTATS_H
>  		cfd = open(containerpath, O_RDONLY);
>  		if (cfd < 0) {
>  			perror("error opening container file");
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
