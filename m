Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T3kiP-0008Dg-UW
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 09:25:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T3kiL-0003jD-GT
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 09:25:37 +0000
Message-ID: <5033539F.3000400@cn.fujitsu.com>
Date: Tue, 21 Aug 2012 17:23:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1345540824-27133-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1345540824-27133-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_detach/4-3: Fix typo
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

On 08/21/2012 05:20 PM, Kang Kai wrote:
> Fix typo.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>

Pushed, thank you.

Wanlong Gao

> ---
>  .../conformance/interfaces/pthread_detach/4-3.c    |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
> index 5c15e93..dfa6e19 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
> @@ -281,7 +281,7 @@ int main(int argc, char *argv[])
>  
>  	do {
>  		do_it2 = 0;
> -	} while (do_it2 = 0);
> +	} while (do_it2);
>  
>  	ret = pthread_join(th_sig1, NULL);
>  	if (ret)
> 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
