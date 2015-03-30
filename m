Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YcWyP-0002NO-KM
	for ltp-list@lists.sourceforge.net; Mon, 30 Mar 2015 10:31:13 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YcWyO-0007nB-Hn
	for ltp-list@lists.sourceforge.net; Mon, 30 Mar 2015 10:31:13 +0000
Message-ID: <55192449.6080303@cn.fujitsu.com>
Date: Mon, 30 Mar 2015 18:24:09 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1427709713-19481-1-git-send-email-liwang@redhat.com>
In-Reply-To: <1427709713-19481-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH] perfcounters: do cleanup for runtest/perfcounters
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On 03/30/2015 06:01 PM, Li Wang wrote:
> These two cases(kernel/performance_counters) had been moved to
> syscalls/perf_enven_open, seems like we should delete the void
> case calling.

Right, thanks!

Regards,
Xiaoguang Wang
> 
> kernel/performance_counters: move tests to syscalls/perf_event_open directory.
> commit ff5bdf7ccc8e133b4cd0a0794509edb6102ca525
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/perfcounters | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/runtest/perfcounters b/runtest/perfcounters
> index 73cd1d2..daa9851 100644
> --- a/runtest/perfcounters
> +++ b/runtest/perfcounters
> @@ -1,5 +1,3 @@
>  # Test some Basic Performance Counters
>  
> -performance_counter01 performance_counter01
> -performance_counter02 performance_counter02
>  
> 


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
