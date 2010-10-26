Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PAZhS-0006dX-EA
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 02:55:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PAZhQ-0008QQ-LE
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 02:55:46 +0000
Message-ID: <4CC64339.6070704@cn.fujitsu.com>
Date: Tue, 26 Oct 2010 10:55:53 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CC0FE7B.3020001@cn.fujitsu.com>
In-Reply-To: <4CC0FE7B.3020001@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/3] pitest-2: Use time_t instead of unsigned long
 /	int.
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

Hi Garrett,

Would you pick up this patchset?

Gui

Gui Jianfeng wrote:
> The test was using a mish-mash of unsigned long and int types to pass
> data between the thread and evaluate values, so the problem lied in
> potential truncation of data.
> 
> time_t is a 32-bit type or 64-bit type on some OSes, so it's best to
> remain consistent with a single fixed data type instead of moving
> between int (which can be 32-bit or 64-bit, depending on the OS and
> architecture) and unsigned long (which can be 32-bit or 64-bit,
> depending on the OS and architecture).
> 
> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
> ---
>  .../functional/threads/pi_test/pitest-2.c          |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
> index 47b8591..3598021 100644
> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
> @@ -196,7 +196,6 @@ void *thread_sample(void *arg)
>  }
>  void *thread_tb1(void *arg)
>  {
> -	unsigned long timeoutsec;
>  	struct timespec boost_time;
>  	double t0, t1;
>  	int rc;
> @@ -207,8 +206,7 @@ void *thread_tb1(void *arg)
>  	DPRINTF(stdout, "#EVENT %f TB1 Thread Started\n",
>  		seconds_read() - base_time); 
>  	
> -	timeoutsec = *(unsigned long*) arg;
> -	boost_time.tv_sec = time(NULL) + (time_t)timeoutsec;
> +	boost_time.tv_sec = time(NULL) + *(time_t *) arg;
>  	boost_time.tv_nsec = 0;
>  	
>  	t0 = seconds_read();
> @@ -227,7 +225,6 @@ void *thread_tb1(void *arg)
>  
>  void *thread_tb2(void *arg)
>  {
> -	unsigned long timeoutsec;
>  	struct timespec boost_time;
>  	double t0, t1;
>  	int rc;
> @@ -238,8 +235,7 @@ void *thread_tb2(void *arg)
>  	DPRINTF(stdout, "#EVENT %f TB2 Thread Started\n",
>  		seconds_read() - base_time); 
>  	
> -	timeoutsec = *(unsigned long*) arg;
> -	boost_time.tv_sec = time(NULL) + (time_t)timeoutsec;
> +	boost_time.tv_sec = time(NULL) + *(time_t*) arg;
>  	boost_time.tv_nsec = 0;
>  
>  	t0 = seconds_read();
> @@ -323,7 +319,7 @@ int main(int argc, char **argv)
>  	sleep(base_time + multiplier * 30 - seconds_read());
>  
>  	/* Start TB1 thread (boosting thread) */
> -	int timeout = multiplier * 20;
> +	time_t timeout = multiplier * 20;
>  	rc = pthread_create(&threadtb1, &threadattr, thread_tb1, 
>  			    &timeout);
>          if (rc != 0) {

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
