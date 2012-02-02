Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rsz6D-0006ux-6N
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 16:01:25 +0000
Date: Thu, 2 Feb 2012 17:14:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120202161442.GC3605@saboteur.suse.cz>
References: <1324980149-29612-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324980149-29612-1-git-send-email-YanFeng.Shang@windriver.com>
Subject: Re: [LTP] [PATCH] hugeshmat01 isn't adapt to mips with 64bit ELF
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
To: Shang Yanfeng <YanFeng.Shang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Haotian.Zhang@windriver.com, Mike Frysinger <vapier@gentoo.org>

Hi!
> Because userspace memory in mips with 64bit ELF is lower than 2^40,
> so shmat failed.
> 
> signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>
> ---
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> index 6f270ce..67bd4b0 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> @@ -67,7 +67,11 @@ unsigned long huge_pages_shm_to_be_allocated;
>  #define CASE1		20		/* memory location.		   */
>  
>  #if __WORDSIZE==64
> +#if defined(__mips__)
> +#define UNALIGNED      0x1000000eee
> +#else
>  #define UNALIGNED      0x10000000eee
> +#endif
>  #else
>  #define UNALIGNED      0x60000eee
>  #endif

I wonder why we need such #ifdef for 64 bit systems in the first place,
or is the unaligned address 0x60000eee too low for 64 bit system?

Garrett, Mike any clue?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
