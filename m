Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Xu@windriver.com>) id 1O9cZN-00076S-Mg
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 11:15:13 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9cZM-0005U0-B1
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 11:15:13 +0000
From: Henry xu <feng.xu@windriver.com>
Date: Wed, 05 May 2010 17:08:16 +0800
Message-Id: <1273050496.26977.19.camel@lishuang-desktop>
Mime-Version: 1.0
Subject: [LTP] ltp sysctl03 testcase failed in version of 20100228
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
To: ltp-list <ltp-list@lists.sf.net>

Hi,all
I test sysctl03 in x86 and ppc platform and product the same fails as
below.


root@z530:/opt/ltp-full/testcases/bin> ./sysctl03 
sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
sysctl03    2  TFAIL  :  Expected EPERM, got 13

The case expects to return EPERM,however return EACCES.

My kernel version is 2.6.34 .I think it could be caused  by high version
kernel .Since in the past kernel of 2.6.27,there is not the fail.And I
find the same issue of the case on the internet.It gives a patch,but I
find  the patch is not merged in the newest ltp version .

I want to know whether the isuue is known or not.

thanks!

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
