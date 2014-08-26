Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMDfF-0007NR-Nv
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 10:07:45 +0000
Date: Tue, 26 Aug 2014 12:06:42 +0200
From: chrubis@suse.cz
Message-ID: <20140826100642.GA27928@rei>
References: <0be2f82a131d32b119748e91a840cb038bf82960.1409046964.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0be2f82a131d32b119748e91a840cb038bf82960.1409046964.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] tst_ncpus_max: use kernel_max if available
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> sched_getaffinity() and sched_setaffinity() cares about number of possible
> CPUs the OS or hardware can support, which can be larger than what
> sysconf(_SC_NPROCESSORS_CONF) currently provides (by enumarating
> /sys/devices/system/cpu/cpu* entries).
> 
> Use /sys/devices/system/cpu/kernel_max, if available. This represents
> NR_CPUS-1, a compile time option which specifies "maximum number of CPUs
> which this kernel will support". This should give us cpu mask size
> large enough for any purposes.
> 
> If the kernel_max sysfs file is not available, fall back to
> _SC_NPROCESSORS_CONF.

Looks good to me, acked.

Is this last failure that needed to be fixed before the release or are
there any more?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
