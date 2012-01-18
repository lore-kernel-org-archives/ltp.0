Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RnRkG-0002SK-Gk
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 09:23:52 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnRkA-0003mz-NK
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 09:23:52 +0000
Message-ID: <4F168F9B.3070709@imgtec.com>
Date: Wed, 18 Jan 2012 09:23:39 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1326862455-16756-1-git-send-email-YanFeng.Shang@windriver.com>
In-Reply-To: <1326862455-16756-1-git-send-email-YanFeng.Shang@windriver.com>
Subject: Re: [LTP] [PATCH] updated mmap2.c for low memory target
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
To: ltp-list@lists.sourceforge.net

On 01/18/2012 04:54 AM, Shang Yanfeng wrote:
> many low memory boards don't have 1G memory,so add get_free_mem function
> for low memory target,limit 1000M for n32 file system test.
>
> signed-off-by: YanFeng.Shang<YanFeng.Shang@windriver.com>
> ---
>   testcases/kernel/mem/mtest06/mmap2.c |   51 ++++++++++++++++++++++++++-------
>   1 files changed, 40 insertions(+), 11 deletions(-)
>
> +/*******************************************************************************/
> +/* Finction get_free_mem
> +Description: get the free memory .
> +Return: free memory with M
> +/ *******************************************************************************/
> +unsigned long get_free_mem()
> +{
> +	struct sysinfo board_sysinfo;
> +	unsigned long avail_mem;
> +	int error;
> +	error = sysinfo(&board_sysinfo);
> +	printf("\n\ncode error=%d\n",error);
> +	avail_mem = board_sysinfo.freeram/MB;
> +	return avail_mem;
> +}
> +
Hi,
a few comments

Typo Finction should be replaced by Function

Why are you printing the error code unconditionally? This should 
probably need to be replaced by

if(sysinfo(&board_sysinfo))
	perror("sysinfo failed\n");

There is also no need to redeclare the error variable. You can use the 
one which is globally defined by your C library using

extern int error;

But perror should do the trick anyway.

-- 
markos


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
