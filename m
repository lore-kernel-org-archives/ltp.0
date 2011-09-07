Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1Gte-0000aJ-ML
	for ltp-list@lists.sourceforge.net; Wed, 07 Sep 2011 12:06:26 +0000
Date: Wed, 7 Sep 2011 14:06:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110907120658.GA31361@saboteur.suse.cz>
References: <4E65E013.7020503@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E65E013.7020503@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH] pthread_create/10-1: correct return value
 if test fails
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> This patch fixes return value always being 0 even if test
> fails. Using _exit(value) instead of pthread_exit();.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/pthread_create/10-1.c   |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/10-1.c
> index 265901f..fe0c88d 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/10-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/10-1.c
> @@ -76,16 +76,16 @@ void sig_handler(int sig)
>  		if (created_thread == 1)
>  		{
>  			printf("Test FAILED: Created thread though an invalid attribute was passed to pthread_create().\n");
> -			pthread_exit((void*)PTS_FAIL);
> +			_exit(PTS_FAIL);
>  		}
>  
>  		printf("Test PASSED\n");
> -		pthread_exit((void*)PTS_PASS);
> +		_exit(PTS_PASS);
>  		return;
>  	}
>  
>  	printf("Test FAILED: Did not receive segmentation fault signal, waited 10 seconds.\n");
> -	pthread_exit((void*)PTS_FAIL);
> +	_exit(PTS_FAIL);
>  	return;
>  }
>  
> @@ -124,4 +124,4 @@ int main()
>  
>  	printf("Test FAILED.\n");
>  	return PTS_FAIL;
> -}
> \ No newline at end of file
> +}


Commited, at least the tests correctly reports it's failure now. But it
has some more desing flaws that needs to be fixed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Using storage to extend the benefits of virtualization and iSCSI
Virtualization increases hardware utilization and delivers a new level of
agility. Learn what those decisions are and how to modernize your storage 
and backup environments for virtualization.
http://www.accelacomm.com/jaw/sfnl/114/51434361/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
