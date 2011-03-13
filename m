Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PykQq-000556-LZ
	for ltp-list@lists.sourceforge.net; Sun, 13 Mar 2011 12:30:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PykQo-0003Ms-Cm
	for ltp-list@lists.sourceforge.net; Sun, 13 Mar 2011 12:30:00 +0000
Message-ID: <4D7CB8BB.6080608@redhat.com>
Date: Sun, 13 Mar 2011 20:29:47 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4D7B4202.1020302@cn.fujitsu.com>
In-Reply-To: <4D7B4202.1020302@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ftest06.c: fix error of the child process need
 exit
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 03/12/2011 05:50 PM, Peng Haitao wrote:
> 
> The child process should exit after invoking dotest().
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Confirmed this patch and the other ftest06 patch both work on RHEL6.

Tested-by: Caspar Zhang <czhang@redhat.com>

> ---
>  testcases/kernel/fs/ftest/ftest06.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
> index d8ff8b6..18eae5d 100644
> --- a/testcases/kernel/fs/ftest/ftest06.c
> +++ b/testcases/kernel/fs/ftest/ftest06.c
> @@ -110,9 +110,8 @@ int main(int ac, char *av[])
>  	/*
>  	 * parse standard options
>  	 */
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> +	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -	}
>  
>  	/*
>  	 * Default values for run conditions.
> @@ -162,7 +161,7 @@ int main(int ac, char *av[])
>  		for (k = 0; k < nchild; k++) {
>  			if ((child = fork()) == 0) {
>  				dotest(k, iterations);
> -
> +				tst_exit();
>  			}
>  			if (child < 0) {
>  				tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
> @@ -239,8 +238,6 @@ int main(int ac, char *av[])
>  		}
>  
>  		sync();
> -		cleanup();
> -
>  	}
>  
>  	if (local_flag == FAILED)


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
