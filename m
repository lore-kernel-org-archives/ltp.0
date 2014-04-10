Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1WYCqX-00028u-Uu
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 11:08:41 +0000
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WYCqW-0006Gt-UX
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 11:08:41 +0000
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Thu, 10 Apr 2014 12:08:34 +0100
Message-ID: <53467BAF.8030605@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 13:08:31 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <CA+G9fYuQi1+C0Mkhc0SVLKm8E9iEEF8rZ_62qAFZZcUaD9CLQQ@mail.gmail.com>
	<1397035115.64792188@apps.rackspace.com>
	<53453D96.3070109@linux.vnet.ibm.com>
	<1397048671.53348062@apps.rackspace.com>
In-Reply-To: <1397048671.53348062@apps.rackspace.com>
Subject: Re: [LTP] [Ltp-coverage] running LCOV/LTP on Beagle Bone Black -
 Cannot Allocate Memory Error
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
To: shinto.john@smartplayin.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Naresh Kamboju <naresh.kamboju@linaro.org>, ltp-coverage@lists.sourceforge.net

On 09.04.2014 15:04, shinto.john@smartplayin.com wrote:
> This got resolved when i tried this in KERNEL/mm/Makefile
> 
> GCOV_PROFILE := n
> 
> So basically some issue with KERNEL/mm/vmstat.gcno... right?

If you don't need the coverage data for mm/* then this looks like a
feasible workaround.

> Now i am able to do a complete kernel run.

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
