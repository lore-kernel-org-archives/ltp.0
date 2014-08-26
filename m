Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMDBu-00074z-S3
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 09:37:26 +0000
Date: Tue, 26 Aug 2014 11:36:23 +0200
From: chrubis@suse.cz
Message-ID: <20140826093623.GB25567@rei.suse.cz>
References: <e70bae8bd74a29e9959cae96900a849254b37c9f.1408615314.git.jstancek@redhat.com>
	<20140825130920.GA13575@rei.suse.cz>
	<400651514.12451738.1408972658808.JavaMail.zimbra@redhat.com>
	<20140825140749.GB13778@rei.suse.cz>
	<1251340269.12540621.1408977990485.JavaMail.zimbra@redhat.com>
	<1139993286.12980615.1409044361683.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1139993286.12980615.1409044361683.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] safe_macros: turn functions with off_t parameter
 into static inline
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
> Testing went OK, I came across one new issue on system supporting CPU hotplug in 
> sched_setaffinity01.c / tst_ncpus_max().
> 
> tst_ncpus_max is using sysconf(_SC_NPROCESSORS_CONF), but sched_getaffinity
> cares about all possible cpus, so it fails with EINVAL, because mask is too small.
> 
> I'm thinking we should try to read /sys/devices/system/cpu/possible or even
> /sys/devices/system/cpu/kernel_max (NR_CPUS) and use that value to be safe
> and only fall back to _SC_NPROCESSORS_CONF as last resort.

Sounds good to me.

> There's a big mail thread about this issue, I think Carlos made a nice summary:
>   https://sourceware.org/ml/libc-alpha/2013-07/msg00429.html

I was part of the discussion, the API for getting number of processors
on Linux is currently in mess :(.

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
