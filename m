Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1WXrf6-0004HR-CU
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 12:31:28 +0000
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXrf4-0003yq-FS
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 12:31:28 +0000
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Wed, 9 Apr 2014 13:31:20 +0100
Message-ID: <53453D96.3070109@linux.vnet.ibm.com>
Date: Wed, 09 Apr 2014 14:31:18 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <CA+G9fYuQi1+C0Mkhc0SVLKm8E9iEEF8rZ_62qAFZZcUaD9CLQQ@mail.gmail.com>
	<1397035115.64792188@apps.rackspace.com>
In-Reply-To: <1397035115.64792188@apps.rackspace.com>
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
To: shinto.john@smartplayin.com, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage@lists.sourceforge.net

On 09.04.2014 11:18, shinto.john@smartplayin.com wrote:
> now while running "lcov -c -o coverage.info", this runs for ~5 minutes
> without any issues and then is stuck at this below*red *point for long
> time and never exits.
> 
> So i did ctrl-C and tried the "genhtml coverage.info -o out" and it worked.
> 
> I could see the LCOV report(Attached index.html) in "out" folder.
> 
> But looks like complete kernel folders are not there in the LCOV report
> as it was stuck at below point.
> 
> Any comments?
> 
> include/asm-generic/bitops/arch_hweight.h:source file is newer than
> graph file '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gc'
> /home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/arch/arm/include/asm/bitops.h:source
> file is newer than graph file '/home/mallikarjun.bc/LTP'
> include/linux/workqueue.h:source file is newer than graph file
> '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'
> include/linux/nodemask.h:source file is newer than graph file
> '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'
> *include/linux/kernel.h:source file is newer than graph file
> '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'*

Try running top while lcov is stuck and see if there's a process using
up a lot of CPU time. It might be that you are affected by a gcov bug.

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
