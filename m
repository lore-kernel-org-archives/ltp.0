Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YqLvR-0000An-Ja
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 13:33:17 +0000
Date: Thu, 7 May 2015 15:32:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150507133240.GG28637@rei.suse.de>
References: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430897176-16486-5-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1430897176-16486-5-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 5/5] kernel/syscalls/fallocate: move fclose out of
 if-block
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
> It will encounter resource leak for fp as the old flow,
> while fopen succeeds and the pointer para is NULL.
> This patch aims to avoid this resource leak.
> 
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
> index 1c33d0c..c845cf8 100644
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
> +++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
> @@ -30,8 +30,8 @@ int is_cmdline_para(const char *para)

Looking a the code it would be way easier to change it to:

	if (!para)
		return 0;

Then we will need to close the file only inside of the if condition:

	if ((fp = fopen("/proc/cmdline", "r")) != NULL)) {
		...
		fclose(fp);
	}

>  				return 1;
>  			}
>  		}
> -		fclose(fp);
>  	}
> +	if (fp != NULL)	fclose(fp);

This code is not following LKML coding style. You can use checkpath.pl
(distributed with Linux kernel sources) to check you patches before
submission.

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
