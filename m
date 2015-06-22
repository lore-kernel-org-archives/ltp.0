Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z70jq-0007ZJ-OC
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 12:22:10 +0000
Date: Mon, 22 Jun 2015 14:20:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150622122056.GA7476@rei.suse.de>
References: <6ad648e0b674845a19073ebd7afcb8ec82f3f891.1434551926.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ad648e0b674845a19073ebd7afcb8ec82f3f891.1434551926.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] kmsg01: avoid infinite run in test_read_block()
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
> diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
> index 4e24298..4307947 100644
> --- a/testcases/kernel/logging/kmsg/kmsg01.c
> +++ b/testcases/kernel/logging/kmsg/kmsg01.c
> @@ -52,7 +52,8 @@
>  #define NUM_READ_MSGS 3
>  #define NUM_READ_RETRY 10
>  #define NUM_OVERWRITE_MSGS 1024
> -#define READ_TIMEOUT 5
> +#define SINGLE_READ_TIMEOUT 2
> +#define READ_TIMEOUT_MS (30*1000)
>  
>  char *TCID = "kmsg01";
>  static void setup(void);
> @@ -196,11 +197,12 @@ static int timed_read(int fd, int timeout_sec)
>   *    -1 on read error, errno reflects read() errno
>   *    -2 on timeout
>   */
> -static int timed_read_kmsg(int fd, int timeout_sec)
> +static int timed_read_kmsg(int fd, int timeout_ms)
>  {
>  	int child, status, ret = 0;
>  	int pipefd[2];
>  	char msg[MAX_MSGSIZE];
> +	long long elapsed_ms = 0;
>  
>  	if (pipe(pipefd) != 0)
>  		tst_brkm(TBROK|TERRNO, cleanup, "pipe failed");
> @@ -231,11 +233,22 @@ static int timed_read_kmsg(int fd, int timeout_sec)
>  	SAFE_CLOSE(cleanup, pipefd[1]);
>  
>  	/* parent reads pipe until it reaches eof or until read times out */
> +	tst_timer_start(CLOCK_MONOTONIC);
>  	do {
> -		TEST(timed_read(pipefd[0], timeout_sec));
> -	} while (TEST_RETURN > 0);
> +		TEST(timed_read(pipefd[0], SINGLE_READ_TIMEOUT));
> +		tst_timer_stop();
> +		elapsed_ms = tst_timer_elapsed_ms();
> +	} while (TEST_RETURN > 0 && elapsed_ms < timeout_ms);
>  	SAFE_CLOSE(cleanup, pipefd[0]);
>  
> +	if (elapsed_ms >= timeout_ms) {
> +		/* this is not necessarily error, kernel or user-space
> +		 * process may generate messages at higher rate than what
> +		 * we would consider as 'blocked', see SINGLE_READ_TIMEOUT */
> +		tst_resm(TWARN, "reads taking too long, giving up");
> +		TEST_RETURN = -2;
> +	}

Maybe this is worth of new return value, since this means that we
timeouted while waiting for timeout.

Apart from that the logic looks fine. The test could be probably cleaned
by using checkpoints instead of pipe and the function used to propagate
exit value from child, but that is probably worth of separate patch.

>  	/* child is blocked, kill it */
>  	if (TEST_RETURN == -2)
>  		kill(child, SIGTERM);
> @@ -261,7 +274,12 @@ static void test_read_nonblock(void)
>  	if (fd < 0)
>  		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
>  
> -	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
> +	if (lseek(fd, 0, SEEK_END) == -1)
> +		tst_resm(TFAIL|TERRNO, "SEEK_END 0 failed");
> +
> +	/* /dev/kmsg opened with O_NONBLOCK will return EAGAIN when
> +	 * no more records are available */
> +	TEST(timed_read_kmsg(fd, READ_TIMEOUT_MS));
>  	if (TEST_RETURN == -1 && TEST_ERRNO == EAGAIN)
>  		tst_resm(TPASS, "non-block read returned EAGAIN");
>  	else
> @@ -279,7 +297,12 @@ static void test_read_block(void)
>  	if (fd < 0)
>  		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
>  
> -	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
> +	if (lseek(fd, 0, SEEK_END) == -1)
> +		tst_resm(TFAIL|TERRNO, "SEEK_END 0 failed");
> +
> +	/* /dev/kmsg opened without O_NONBLOCK will block on read when
> +	 * no more records are available */
> +	TEST(timed_read_kmsg(fd, READ_TIMEOUT_MS));

As far as I can se the timed_read_kmsg() is used only from these two
functions, why don't we add the lseek() there instead?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
