Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O9eN1-00022f-Fc
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 13:10:35 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9eN0-00068Q-KH
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 13:10:35 +0000
Date: Wed, 5 May 2010 08:10:15 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100505131015.GA18681@us.ibm.com>
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

Quoting Henry xu (feng.xu@windriver.com):
> Hi,all
> I test sysctl03 in x86 and ppc platform and product the same fails as
> below.
> 
> 
> root@z530:/opt/ltp-full/testcases/bin> ./sysctl03 
> sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
> sysctl03    2  TFAIL  :  Expected EPERM, got 13
> 
> The case expects to return EPERM,however return EACCES.
> My kernel version is 2.6.34 .I think it could be caused  by high version
> kernel .Since in the past kernel of 2.6.27,there is not the fail.And I

Git history shows kernel/sysctl.c:test_perm() has returned -EACCES
since 2.6.12 at least.  

> find the same issue of the case on the internet.It gives a patch,but I
> find  the patch is not merged in the newest ltp version .

If you could either send the url, or just re-send the patch yourself,
it sounds like it's one that should be applied.

> I want to know whether the isuue is known or not.
> 
> thanks!
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
