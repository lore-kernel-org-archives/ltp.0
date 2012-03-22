Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SAhke-0007RL-FE
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 13:08:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAhkd-0000Qy-G8
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 13:08:24 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q2MD8EoF004941
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Mar 2012 21:08:15 +0800
Message-ID: <4F6B2407.3090604@cn.fujitsu.com>
Date: Thu, 22 Mar 2012 21:07:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F6AA2EF.9030403@cn.fujitsu.com>
In-Reply-To: <4F6AA2EF.9030403@cn.fujitsu.com>
Subject: Re: [LTP] [PATCHv2]testfrmw:disable thread cancelability while
 output is running
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

On 03/22/2012 11:56 AM, lidan wrote:

> Function output can be canceled by pthread_cancel(), which,
> maybe, leads to a deadlock as it calls pthread_mutex_lock().
> That's catched in case "pthread_join/4-1.c".
> 
> So,disable thread cancelability until output finishes.


pushed, thanks,

Wanlong Gao

> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/testfrmw/testfrmw.c     |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
> index 034faa9..a9cfbef 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
> @@ -28,6 +28,7 @@
>  
>  #include <time.h>
>  #include <sys/types.h>
> +#include <pthread.h>
>  
>  /* We use a mutex to avoid conflicts in traces */
>  static pthread_mutex_t m_trace = PTHREAD_MUTEX_INITIALIZER;
> @@ -43,7 +44,9 @@ void output(char *string, ...)
>  	char *ts = "[??:??:??]";
>  	struct tm *now;
>  	time_t nw;
> +	int oldstate;
>  
> +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &oldstate);
>  	pthread_mutex_lock(&m_trace);
>  	nw = time(NULL);
>  	now = localtime(&nw);
> @@ -56,6 +59,7 @@ void output(char *string, ...)
>  	vprintf(string, ap);
>  	va_end(ap);
>  	pthread_mutex_unlock(&m_trace);
> +	pthread_setcancelstate(oldstate, NULL);
>  }
>  
>  void output_fini(void)



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
