Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRiAV-0006tn-UX
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 12:38:12 +0000
Date: Thu, 3 Oct 2013 14:38:34 +0200
From: chrubis@suse.cz
Message-ID: <20131003123834.GC3516@rei.Home>
References: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
	<ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] pthread_attr_setschedpolicy/2-1.c: give
 threads a moment to block on mutex
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Use small sleep for lack of better way to check that all threads
> are blocked on mutex "mutex".
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../interfaces/pthread_attr_setschedpolicy/2-1.c   |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
> index 80ce906..1f8825a 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
> @@ -161,6 +161,9 @@ int main(void)
>  	if (rc)
>  		FAIL_AND_EXIT("create_thread HIGH", rc);
>  
> +	/* give threads a moment so they can block on mutex "mutex" */
> +	sleep(2);
> +
>  	rc = pthread_mutex_unlock(&mutex);
>  	if (rc)
>  		FAIL_AND_EXIT("pthread_mutex_unlock()", rc);

Hmm, so you did hit the small window for race condition between the new
thread signals the main thread that it's executed and the next call to
the mutex_lock on the tested mutex?

I do not like this solution much, but this is not easy to do properly.
One posibility is to pinpoint the threads on one cpu via the affinity()
interface (open_posix_testsuite/include/affinity.h) then we can wait in
the main thread until the thread with lowest priority is executed and
safely say that the rest is locked on the mutex allready (as they run
with FIFO scheduling).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
