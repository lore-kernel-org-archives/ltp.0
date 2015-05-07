Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YqLp7-0004O9-Tr
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 13:26:45 +0000
Date: Thu, 7 May 2015 15:26:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150507132611.GF28637@rei.suse.de>
References: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430897176-16486-4-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1430897176-16486-4-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 4/5] kernel/syscalls/dup2: free fildes to avoid
 memory leak
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/dup2/dup205.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 14218dd..a77ae0d 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -111,6 +111,7 @@ int main(int ac, char *av[])
>  		unlink(pfilname);
>  		for (ifile = fildes[0]; ifile < min + 10; ifile++)
>  			close(fildes[ifile]);
> +		free(fildes);
>  		if (local_flag == PASSED) {
>  			tst_resm(TPASS, "Test passed.");
>  		} else {

Can you also move the allocation and free outside the TEST_LOOPING loop?

Ideally to the cleanup and setup?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
