Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1So3pB-0001yO-UH
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:35:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1So3pB-0002Qk-3v
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:35:45 +0000
Message-ID: <4FFA435B.2030808@cn.fujitsu.com>
Date: Mon, 09 Jul 2012 10:35:07 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1341309599-10008-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1341309599-10008-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_cond_signal/1-1: fails on routerstation
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

On 07/03/2012 05:59 PM, Kang Kai wrote:
> Case pthread_cond_signal/1-1 fails on routerstation. The OS is Yocto
> linux 1.2 with kernel 3.0.24, and c library is eglibc 2.15.
> 
> The fail log:
>   [Thread 0x0x2c56d4b0] started and locked the mutex
>   [Thread 0x0x2c56d4b0] is waiting for the cond
>   [Thread 0x0x2bd6d4b0] started and locked the mutex
>   [Thread 0x0x2bd6d4b0] is waiting for the cond
>   [Thread 0x0x2b56d4b0] started and locked the mutex
>   [Thread 0x0x2b56d4b0] is waiting for the cond
>   [Main thread] signals a condition
>   [Thread 0x0x2c56d4b0] was wakened and acquired the mutex again
>   [Thread 0x0x2c56d4b0] released the mutex
>   [Main thread] 1 waiters were wakened
>   [Main thread] signals to wake up the next thread
>   [Thread 0x0x2bd6d4b0] was wakened and acquired the mutex again
>   [Thread 0x0x2bd6d4b0] released the mutex
>   [Main thread] signals to wake up the next thread
>   [Main thread] signals to wake up the next thread
>   [Main thread] signals to wake up the next thread
>   [Main thread] signals to wake up the next thread
>   [Main thread] signals to wake up the next thread
>   [Thread 0x0x2b56d4b0] was wakened and acquired the mutex again
>   [Main thread] had to signal the condition 7 times
>   [Main thread] to wake up 3 threads
>   . Test FAILED.
> 
> The main thread call pthread_cond_signal try to signal the child threads
> those are waiting on the condition, then call usleep(100) to relinquish
> the cpu. But 100 useconds is not enough and the main thread continue to
> run. So the case fails.
> 
> Increase the sleep timeto 1000 useconds to make the case pass.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../interfaces/pthread_cond_signal/1-1.c           |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> index bf55b31..910931d 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> @@ -142,7 +142,7 @@ int main()
>  			fprintf(stderr,"Main failed to signal the condition\n");
>  			exit(PTS_UNRESOLVED);
>  		}
> -		usleep(100);
> +		usleep(1000);

Anyway, just add the hard sleep time can resolve nothing.
Maybe you can find a better way.

Thanks,
Wanlong Gao

>  	}
>  
>  	if (i >= THREAD_NUM) {
> @@ -160,4 +160,4 @@ int main()
>  	}
>  	printf("Test PASSED\n");
>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}
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
