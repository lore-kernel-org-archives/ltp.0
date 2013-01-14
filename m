Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TuZ6G-0005HW-4u
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:44:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TuZ6C-0001Rq-Nh
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:44:32 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r0E1iKWt031116
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jan 2013 09:44:20 +0800
Message-ID: <50F36305.7040002@cn.fujitsu.com>
Date: Mon, 14 Jan 2013 09:44:37 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1357866925-21275-1-git-send-email-yanl.fnst@cn.fujitsu.com>
In-Reply-To: <1357866925-21275-1-git-send-email-yanl.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] add \n in end of output
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
To: Yan Lei <yanl.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 01/11/2013 09:15 AM, Yan Lei wrote:
> Signed-off-by: Yan Lei <yanl.fnst@cn.fujitsu.com>

Applied, thank you.

BTW, don't forget to add the file you changed before the title next time.

Wanlong Gao

> ---
>  testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
> index fbefa7b..5828ed2 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
> @@ -48,7 +48,7 @@ int main(void)
>  	}
>  
>  	if (pa == MAP_FAILED)
> -		printf("Test FAILED: Expected EINVAL got %s", strerror(errno));
> +		printf("Test FAILED: Expected EINVAL got %s\n", strerror(errno));
>  	else
>  		printf("Test FAILED: mmap() succedded unexpectedly\n");
>  
> 


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
