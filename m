Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SDC9d-0007bU-0g
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 10:00:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SDC9X-0001vW-9p
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 10:00:28 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q2TA0BDG007592
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Mar 2012 18:00:13 +0800
Message-ID: <4F743273.8050403@cn.fujitsu.com>
Date: Thu, 29 Mar 2012 17:59:15 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F73BD76.7050505@cn.fujitsu.com>
In-Reply-To: <4F73BD76.7050505@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]pthread_join:4-1.c:ignore detached thread
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
To: lidan <li.dan@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 03/29/2012 09:40 AM, lidan wrote:

> Case pthread_join/4-1.c aims to check the following assertion
> "If the thread calling pthread_join is canceled, the joined 
> thread remains joinable."
> It uses array scenarii defined in "threads_scenarii.c" which
> sets attribute of some threads as detached.
> This patch ignores the detached threads since once
> a thread has been detached, it can't be joined with
> pthread_join(3) or be made joinable again.


Looks good to me, any other comments?

Thanks,
Wanlong Gao

> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/pthread_join/4-1.c      |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
> index fb8c8d3..16ac7e8 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
> @@ -91,6 +91,9 @@ int main(int argc, char *argv[])
>  	scenar_init();
>  
>  	for (sc = 0; sc < NSCENAR; sc++) {
> +		if (scenarii[sc].detached == 1)
> +			continue;
> +
>  #if VERBOSE > 0
>  		output("-----\n");
>  		output("Starting test with scenario (%i): %s\n",



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
