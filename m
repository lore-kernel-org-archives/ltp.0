Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VU4t9-0006Dz-R8
	for ltp-list@lists.sourceforge.net; Thu, 10 Oct 2013 01:18:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VU4t9-0005jW-12
	for ltp-list@lists.sourceforge.net; Thu, 10 Oct 2013 01:18:03 +0000
Message-ID: <52560024.2040601@cn.fujitsu.com>
Date: Thu, 10 Oct 2013 09:17:24 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1381324269-29300-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1381324269-29300-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] tst_kvercmp2: Criteria for Oracle Linux UEK
	kernels
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

On 10/09/2013 09:11 PM, Stanislav Kholmanskikh wrote:
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  lib/tst_kvercmp.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index a703c47..a950120 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -95,8 +95,12 @@ int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers)
>  
>  	uname(&uval);
>  	kver = uval.release;
> -	if (strstr(kver, ".el5")) {
> +	if (strstr(kver, ".el5uek")) {
> +		cur_dist_name = "OL5UEK";
> +	} else if (strstr(kver, ".el5")) {
>  		cur_dist_name = "RHEL5";
> +	} else if (strstr(kver, ".el6uek")) {
> +		cur_dist_name = "OL6UEK";
>  	} else if (strstr(kver, ".el6")) {
>  		cur_dist_name = "RHEL6";
>  	}
> 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
