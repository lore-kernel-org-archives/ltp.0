Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O9j1r-0001qO-KW
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:09:03 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9j1q-0004eJ-Li
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:09:03 +0000
Date: Wed, 5 May 2010 18:13:36 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100505124335.GA11888@linux.vnet.ibm.com>
References: <1273050496.26977.19.camel@lishuang-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1273050496.26977.19.camel@lishuang-desktop>
Subject: Re: [LTP] ltp sysctl03 testcase failed in version of 20100228
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
To: Henry xu <feng.xu@windriver.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, May 05, 2010 at 05:08:16PM +0800, Henry xu wrote:
> Hi,all
> I test sysctl03 in x86 and ppc platform and product the same fails as
> below.
> 
> 
> root@z530:/opt/ltp-full/testcases/bin> ./sysctl03 
> sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
> sysctl03    2  TFAIL  :  Expected EPERM, got 13
> 

Can you try with latest April month LTP ?

> The case expects to return EPERM,however return EACCES.
> 
> My kernel version is 2.6.34 .I think it could be caused  by high version
> kernel .Since in the past kernel of 2.6.27,there is not the fail.And I
> find the same issue of the case on the internet.It gives a patch,but I
> find  the patch is not merged in the newest ltp version .
> 
> I want to know whether the isuue is known or not.
> 
> thanks!
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
