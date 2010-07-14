Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1OZ3Ks-0000Go-K9
	for ltp-list@lists.sourceforge.net; Wed, 14 Jul 2010 14:53:22 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZ3Kr-0004AK-FA
	for ltp-list@lists.sourceforge.net; Wed, 14 Jul 2010 14:53:22 +0000
Message-Id: <4C3D7641020000E8000664BA@sinclair.provo.novell.com>
Date: Wed, 14 Jul 2010 08:33:05 -0600
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <9603429.236361279111653386.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: Re: [LTP] Is there a good way to check kernel config in LTP?
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
To: ltp-list <ltp-list@lists.sf.net>, Caspar Zhang <czhang@redhat.com>

>>> On 7/14/2010 at 07:03 AM, in message
<1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2.redhat
com>, Caspar Zhang <czhang@redhat.com> wrote: 
> Hi all, I find a FAIL result in syscalls/swapon03 with RHEL6 kernel,
> on a x86_64 machine, it always fails with the following message:
> 
> swapon03    1  TFAIL  :  Failed swapon for file swapfile30: errno=EPERM(1): 
> Operation not permitted
> swapon03    1  TFAIL  :  Failed to setup swaps
> 
> This is because in some >=2.6.32 kernels, the 
> CONFIG_MEMORY_FAILURE option is enabled by default in kernel. 
> As the NOTES in man 2 swapon says:
> 
> "...Since kernel 2.6.32, the limit is decreased by 1 if the kernel is built 
> with the CONFIG_MEMORY_FAILURE option..."
>

That's not the only option that affects MAX_SWAPFILES now.
 
> so MAX_SWAPFILES is not 30 anymore, it's 29. While LTP defines MAX_SWAPFILES
> to 30 in include/swaponoff.h(hmmm....hardcode, I don't think it's a good 
> idea :-|).
> 
> So the way to solve(maybe) the problem is clear: change MAX_SWAPFILES
> to 29 when CONFIG_MEMORY_FAILURE is enabled. My question is: is there
> a good way to check whether a kernel option is enabled or not? I searched
> in the old discussions in this maillist and found nothing. I want to know if 
> 
> the developers have some new ideas? 
> 

I've seen 28 as the MAX as well, it all depends on the config options.  I've been looking at re-architecting the test to do some sort of repeat test to the max number of successful swap creations and then verifying that the same number is reachable at least 2 times.  MAX_SWAPFILES is never exported to userspace.  It's a compile time #define that depends on the kernel config options.

Murlin




------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
