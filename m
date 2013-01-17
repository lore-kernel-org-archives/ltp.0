Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Tvpc8-0008Ia-VS
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 13:34:41 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tvpc7-0002MW-FS
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 13:34:40 +0000
Date: Thu, 17 Jan 2013 08:34:32 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <147078656.7580859.1358429672135.JavaMail.root@redhat.com>
In-Reply-To: <50F7E521.5050204@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] max_map_count: Fails due to negative memfree value
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
To: madhura <madhura@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "madhura" <madhura@linux.vnet.ibm.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, January 17, 2013 7:48:49 PM
> Subject: [LTP]  [PATCH] max_map_count: Fails due to negative memfree value
> 
> In situations when memory is occupied to a certain higher limit by
> system processes, the amount of memory available may be in
> negative/low values not suitable for testing.
> Hence its better to have a memory check prior to the test beginning.
> 
> Signed-off-by: Madhura P S <madhura@linux.vnet.ibm.com>
> 
> ---
> ltp-full-20130109/testcases/kernel/mem/tunable/max_map_count.c.org
> 	2013-01-17 17:15:38.957032558 +0530
> +++ ltp-full-20130109/testcases/kernel/mem/tunable/max_map_count.c
> 	2013-01-17 17:16:58.092909326 +0530
> @@ -152,7 +152,7 @@ static void max_map_count_test(void)
>   	pid_t pid;
>   	long max_maps;
>   	long map_count;
> -	long max_iters;
> +	long max_iters = 0;
>   	long memfree;
>   
>   	/*
> @@ -174,7 +174,8 @@ static void max_map_count_test(void)
>   	 */
>   	memfree = read_meminfo("CommitLimit:") -
>   	read_meminfo("Committed_AS:");
>   	/* 64 used as a bias to make sure no overflow happen */
> -	max_iters = memfree / sysconf(_SC_PAGESIZE) * 1024 - 64;
> +	if (memfree > 0)
> +		max_iters = memfree / sysconf(_SC_PAGESIZE) * 1024 - 64;

Generally, the situation (CommitLimit < Committed_AS) can't be hit,
IMO, if yes, that means your system has been some broken(I suppose it's kernel's issue)

so you should here add the below lines to catch the exception:

        else {
               tst_resm(TINFO, "CommmitLimit is %ld, Committed_AS"
                        " is %ld", commit_limit, committed);
               tst_brkm(TBROK, cleanup, "Unexpected error: "
                        "CommitLimit < Committed_AS");
        }

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
