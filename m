Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WsXqY-0002wu-20
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 13:36:46 +0000
Date: Thu, 5 Jun 2014 15:36:21 +0200
From: chrubis@suse.cz
Message-ID: <20140605133552.GC13350@rei>
References: <1401240729-15260-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401240729-15260-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH] hugemmap/hugemmap03.c: fix the ppc64 FAILED
 situation procedure
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net, liwan@redhat.com, Li Wang <wangli.ahau@gmail.com>

Hi!
> 	When testing on ppc64 arch, `./hugemmap03 -s 64` failed message as:
> 	  hugemmap03    1  TFAIL  :  mmap into high region failed unexpectedly - expect errno=ENOMEM, got: errno=EINVAL(22): Invalid
> 
> 	But it is not the system issue,  MMAP(2) Programmer's Manual define the mmap() error return value like:
> 	  EINVAL We don't like addr, length, or offset (e.g., they are too large, or not aligned on a page boundary).
> 	  ENOMEM No memory is available, or the process's maximum number of mappings would have been exceeded.
> 	So, we should consider the EINVAL return situation on ppc64.

Which kernel version does this happen on?

Can you capture kernel function trace of the test?

We looked at the test (I've got help from Mel Gorman) and we concluded
that the test has nothing to do with hugepages and that it simply checks
that addresses outside of the process space are rejected by the kernel.
Which should return ENOMEM on ppc64 too (because the high address
constant in the test should be high enough for ppc64 too).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
