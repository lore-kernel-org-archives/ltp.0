Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PDBp4-0003s8-Ri
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 08:02:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDBp3-0002zF-5z
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 08:02:26 +0000
Message-ID: <4CCFC531.9090509@cn.fujitsu.com>
Date: Tue, 02 Nov 2010 16:00:49 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CCFC177.8070102@cn.fujitsu.com>
In-Reply-To: <4CCFC177.8070102@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH] Remove POSIX non-compliant
	API	pthread_getattr_np
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Sorry to make a noise, please ignore this patch.
However, maybe PTS_UNRESOLVED is better if "ssize != stacksize" at the child thread.

Bian Naimeng wrote:
> The pthread_getattr_np is not a POSIX compliant API, it's unnecessary to test it.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> 
> ---
>  .../interfaces/pthread_attr_setstacksize/2-1.c     |   17 ++++-------------
>  1 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c
> index 668fd96..c91c946 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c
> @@ -14,7 +14,6 @@
>   * 4.  In the created thread, read stacksize
>   */
>  
> -/* For pthread_getattr_np(3) -- not a POSIX compliant API */
>  #ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
>  #endif
> @@ -35,21 +34,13 @@
>  size_t stack_size;
>  void *stack_addr;
>  
> -void *thread_func()
> +void *thread_func(void *arg)
>  {
> -	pthread_attr_t attr;
> +	pthread_attr_t *pattr = (pthread_attr_t *)arg;
>  	size_t ssize;
>  	int rc;
>  
> -	if ((rc = pthread_getattr_np(pthread_self(), &attr)) != 0) {
> -		printf(ERROR_PREFIX "pthread_getattr_np: %s\n", strerror(rc));
> -		exit(PTS_FAIL);
> -	}
> -	if ((rc = pthread_attr_init(&attr)) != 0) {
> -		printf(ERROR_PREFIX "pthread_attr_init: %s\n", strerror(rc));
> -		exit(PTS_FAIL);
> -	}
> -	if ((rc = pthread_attr_getstacksize(&attr, &ssize)) != 0) {
> +	if ((rc = pthread_attr_getstacksize(pattr, &ssize)) != 0) {
>  		printf(ERROR_PREFIX "pthread_attr_getstacksize: %s\n",
>  			strerror(rc));
>  		exit(PTS_FAIL);
> @@ -106,7 +97,7 @@ int main()
>                  exit(PTS_UNRESOLVED);
>          }
>  
> -	rc = pthread_create(&new_th, &attr, thread_func, NULL);
> +	rc = pthread_create(&new_th, &attr, thread_func, &attr);
>  	if (rc != 0) {
>                  printf(ERROR_PREFIX "pthread_create: %s\n", strerror(rc));
>                  exit(PTS_FAIL);

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
