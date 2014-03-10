Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WN07W-0001nT-Ii
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 13:19:54 +0000
Date: Mon, 10 Mar 2014 14:19:37 +0100
From: chrubis@suse.cz
Message-ID: <20140310131937.GB10346@rei>
References: <1394421090-2780-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394421090-2780-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCHv2] containers/netns: Add missed definition for
 check_netns_enabled.c
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> CLONE_NEWNET and CLONE_NEWNS are defined in bit/sched.h, and need __USE_GNU
> defined first. Do the same as par_chld_ipv6.c and two_children_ns.c did, just
> define _GNU_SOURCE directly.
> 
> Also remove duplicate CLONE_NEWNET definition cause we won't run netns test if
> CLONE_NEWNET and CLONE_NEWNS are not defined.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/kernel/containers/libclone/libclone.h         | 4 ----
>  testcases/kernel/containers/netns/check_netns_enabled.c | 3 +++
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
> index 9380cec..50e00f7 100644
> --- a/testcases/kernel/containers/libclone/libclone.h
> +++ b/testcases/kernel/containers/libclone/libclone.h
> @@ -73,10 +73,6 @@
>  #define CLONE_NEWPID            0x20000000
>  #endif
>  
> -#ifndef CLONE_NEWNET
> -#define CLONE_NEWNET		0x40000000
> -#endif

The clone flags has been added to glibc-2.8 in

commit 0ab7632d38f52e2a540b3550f69ec0ed293c0cdb
Author: Ulrich Drepper <drepper@redhat.com>
Date:   Mon Mar 24 16:03:48 2008 +0000

    * sysdeps/unix/sysv/linux/bits/sched.h: Add new CLONE_* flags,

        remove CLONE_STOPPED.


And if I remeber right, we agreed that we should support at least 2.3.3
so that LTP builds on older enterprise distributions. So we should keep
these ifdefs a bit longer. Or is there a good reason to remove it?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
