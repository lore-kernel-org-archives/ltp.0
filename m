Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1TtayO-0006bL-Pm
	for ltp-list@lists.sourceforge.net; Fri, 11 Jan 2013 09:32:24 +0000
Received: from mail-pb0-f49.google.com ([209.85.160.49])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TtayM-0001xu-FD
	for ltp-list@lists.sourceforge.net; Fri, 11 Jan 2013 09:32:24 +0000
Received: by mail-pb0-f49.google.com with SMTP id un15so853201pbc.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Jan 2013 01:32:16 -0800 (PST)
Message-ID: <50EFD61C.70808@casparzhang.com>
Date: Fri, 11 Jan 2013 17:06:36 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1357866925-21275-1-git-send-email-yanl.fnst@cn.fujitsu.com>
In-Reply-To: <1357866925-21275-1-git-send-email-yanl.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] add \n in end of output
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
To: Yan Lei <yanl.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 01/11/2013 09:15 AM, Yan Lei wrote:
> Signed-off-by: Yan Lei <yanl.fnst@cn.fujitsu.com>
> ---
>   testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
> index fbefa7b..5828ed2 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
> @@ -48,7 +48,7 @@ int main(void)
>   	}
>
>   	if (pa == MAP_FAILED)
> -		printf("Test FAILED: Expected EINVAL got %s", strerror(errno));
> +		printf("Test FAILED: Expected EINVAL got %s\n", strerror(errno));
>   	else
>   		printf("Test FAILED: mmap() succedded unexpectedly\n");
>
>
Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
