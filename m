Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1OZ1d1-0007mm-09
	for ltp-list@lists.sourceforge.net; Wed, 14 Jul 2010 13:03:59 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZ1cz-0006Ma-UP
	for ltp-list@lists.sourceforge.net; Wed, 14 Jul 2010 13:03:58 +0000
Date: Wed, 14 Jul 2010 09:03:52 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <9603429.236361279111653386.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] Is there a good way to check kernel config in LTP?
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

Hi all, I find a FAIL result in syscalls/swapon03 with RHEL6 kernel,
on a x86_64 machine, it always fails with the following message:

swapon03    1  TFAIL  :  Failed swapon for file swapfile30: errno=EPERM(1): Operation not permitted
swapon03    1  TFAIL  :  Failed to setup swaps

This is because in some >=2.6.32 kernels, the 
CONFIG_MEMORY_FAILURE option is enabled by default in kernel. 
As the NOTES in man 2 swapon says:

"...Since kernel 2.6.32, the limit is decreased by 1 if the kernel is built 
with the CONFIG_MEMORY_FAILURE option..."

so MAX_SWAPFILES is not 30 anymore, it's 29. While LTP defines MAX_SWAPFILES
to 30 in include/swaponoff.h(hmmm....hardcode, I don't think it's a good idea :-|).

So the way to solve(maybe) the problem is clear: change MAX_SWAPFILES
to 29 when CONFIG_MEMORY_FAILURE is enabled. My question is: is there
a good way to check whether a kernel option is enabled or not? I searched
in the old discussions in this maillist and found nothing. I want to know if 
the developers have some new ideas? 

Thanks,
Caspar

-- 
/---------------------------------------\
| Name: Caspar Zhang                    |
| Team: Kernel-QE                       |
| IRC: caspar @ #kernel-qe, #eng-china  |
| Phone: +86-10-6260-8150               |
| Cellphone: +86-1381-073-0090          |
\---------------------------------------/


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
