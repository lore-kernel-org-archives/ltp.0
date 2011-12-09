Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RYwcg-0005dE-DU
	for ltp-list@lists.sourceforge.net; Fri, 09 Dec 2011 09:20:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RYwcb-0008AX-QM
	for ltp-list@lists.sourceforge.net; Fri, 09 Dec 2011 09:20:06 +0000
Message-ID: <4EE1D27A.6000600@cn.fujitsu.com>
Date: Fri, 09 Dec 2011 17:18:50 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1323419326-13172-1-git-send-email-kai.kang@windriver.com>
	<1323419326-13172-3-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1323419326-13172-3-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH 2/2] pthread_rwlock_unlock/4-2: remove local var
 'rc'
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 12/09/2011 04:28 PM, Kang Kai wrote:

> Local var 'rc' in function main hides the global one. In child thread
> it sets global var 'rc' with funtion return value. But in function main,
> test var 'rc' always succeeds because it tests local var 'rc'.
> 


Good catch.

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../interfaces/pthread_rwlock_unlock/4-2.c         |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
> index 3023886..4928f85 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
> @@ -54,7 +54,6 @@ static void* fn_unlk(void *arg)
>  int main()
>  {
>  	int cnt = 0;
> -	int rc = 0;
>  
>  	pthread_t un_thread;
>  
> @@ -125,4 +124,4 @@ int main()
>  
>  	printf("Test PASSED: Note*: Returned 0 instead of EPERM, but standard specified _may_ fail.\n");
>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}



------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
