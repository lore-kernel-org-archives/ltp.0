Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UejEo-0002zD-1V
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 09:52:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UejEm-0007n4-HA
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 09:52:10 +0000
Message-ID: <519B438A.3020200@cn.fujitsu.com>
Date: Tue, 21 May 2013 17:51:06 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <006901ce5601$42cc89e0$c8659da0$@lge.com>
In-Reply-To: <006901ce5601$42cc89e0$c8659da0$@lge.com>
Subject: Re: [LTP] [PATCH] Makefile: Disable parallel build for
	$(CRITICAL_MAKEFILES)
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
To: Jungsoo Son <jungsoo.son@lge.com>
Cc: ltp-list@lists.sourceforge.net

On 05/21/2013 04:57 PM, Jungsoo Son wrote:
> This patch fixes parallel build error. When use parallel build
> 
> with -j16 or -j8, $(CRITICAL_MAKEFILES) are created as empty file
> 
> because generate-makefiles is called several times. So need to
> 
> disable parallel build.
> 
> The following code can guarantee sequencial building.
> 
> .NOTPARALLEL: $(CRITICAL_MAKEFILES)
> 
>  
> 
> Signed-off-by: jungsoo.son <jungsoo.son@lge.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


> 
> ---
> 
> testcases/open_posix_testsuite/Makefile |    2 ++
> 
> 1 file changed, 2 insertions(+)
> 
>  
> 
> diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
> 
> index 9c61fa4..bce5cf3 100644
> 
> --- a/testcases/open_posix_testsuite/Makefile
> 
> +++ b/testcases/open_posix_testsuite/Makefile
> 
> @@ -110,5 +110,7 @@ $(CRITICAL_MAKEFILES): \
> 
>      $(top_srcdir)/LDLIBS
> 
>          @$(MAKE) generate-makefiles
> 
> +.NOTPARALLEL: $(CRITICAL_MAKEFILES)
> 
> +
> 
> #tests-pretty:
> 
> #        $(MAKE) all | column -t -s:
> 
> -- 
> 
> 1.7.9.5
> 
> 
> 
> ------------------------------------------------------------------------------
> Try New Relic Now & We'll Send You this Cool Shirt
> New Relic is the only SaaS-based application performance monitoring service 
> that delivers powerful full stack analytics. Optimize and monitor your
> browser, app, & servers with just a few lines of code. Try New Relic
> and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
