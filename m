Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1T7GdX-00006O-MR
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 02:07:07 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T7GdW-00064V-E1
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 02:07:07 +0000
Received: from zmail13.collab.prod.int.phx2.redhat.com
	(zmail13.collab.prod.int.phx2.redhat.com [10.5.83.15])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q7V270IL008138
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Aug 2012 22:07:00 -0400
Date: Thu, 30 Aug 2012 22:07:00 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <850600673.62700357.1346378820659.JavaMail.root@redhat.com>
In-Reply-To: <92b6d1dd1bba3ce81f5f51612e99a23ed2409b7e.1346244062.git.zliu@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system
 limit
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
To: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, August 29, 2012 8:43:59 PM
> Subject: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system limit
> 
> in 32-bit system, one process only allocate 3Gb memory at
> least, even though there are enough memory and setting

I'm sorry that the above sentences has a typo, 'at least' should be
changed as 'at most', so maintainers, please correct it if you apply the patch.
please let me know if you need me send a V2.

Thanks,
Zhouping

> overcommit_memory=1, the porcess always exit when it arrives
> in 3Gb memory.
> 
> the patch use '__WORDSIZE' macro to avoid the incorrect 'TFAIL'
> without the patch:
>  ---- snip ----
>  min_free_kbytes    0  TINFO  :  set overcommit_memory to 1
>  min_free_kbytes    0  TINFO  :  set min_free_kbytes to 3794
>  memfree is 15478420 kB before eatup mem
>  memfree is 12333408 kB after eatup mem
>  min_free_kbytes    3  TFAIL  :  child unexpectedly failed: 0
>  min_free_kbytes    0  TINFO  :  set min_free_kbytes to 7588
>  ---- snip ----
> 
> after applying the patch:
>  ---- snip ----
>  min_free_kbytes    0  TINFO  :  set overcommit_memory to 1
>  min_free_kbytes    0  TINFO  :  set min_free_kbytes to 3794
>  memfree is 15478420 kB before eatup mem
>  memfree is 12333408 kB after eatup mem
>  min_free_kbytes    0  TINFO  :  Child can't allocate >3Gb memory in
>  32bit system
>  min_free_kbytes    0  TINFO  :  set min_free_kbytes to 7588
>  ---- snip ----
> 
> Reported-by: Shuang Qiu <shuang.qiu@oracle.com>
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/mem/tunable/min_free_kbytes.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c
> b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index dde182c..873b807 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -158,8 +158,19 @@ static void test_tune(unsigned long
> overcommit_policy)
>  				    "child unexpectedly failed: %d", status);
>  		} else if (overcommit_policy == 1) {
>  			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
> +#if __WORDSIZE == 32
> +			{
> +				if (total_mem < 3145728UL)
> +#endif
>  				tst_resm(TFAIL,
>  				    "child unexpectedly failed: %d", status);
> +#if __WORDSIZE == 32
> +	/* in 32-bit system, a process allocate about 3Gb memory at most */
> +				else
> +					tst_resm(TINFO, "Child can't allocate "
> +					    ">3Gb memory in 32bit system");
> +			}
> +#endif
>  		} else {
>  			if (WIFEXITED(status)) {
>  				if (WEXITSTATUS(status) != 0) {
> --
> 1.7.11.2
> 
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
