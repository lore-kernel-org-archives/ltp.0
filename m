Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WfAxM-0000Gv-P3
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 16:32:32 +0000
Date: Tue, 29 Apr 2014 18:31:37 +0200
From: chrubis@suse.cz
Message-ID: <20140429163137.GG12523@rei>
References: <1395991214.5017.2.camel@G08JYZSD130126>
	<1395991331.5017.4.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395991331.5017.4.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] read/read02.c: add new error number tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
>  static struct test_case_t {
>  	int *fd;
> -	void *buf;
> +	void **buf;
> +	size_t count;
>  	int exp_error;
>  } TC[] = {
> -	{&badfd, buf, EBADF},
> -	{&fd2, buf, EISDIR},
> -	{&fd3, (void *)-1, EFAULT},
> +	{&badfd, (void **)&buf, 1, EBADF},
> +	{&fd2, (void **)&buf, 1, EISDIR},
> +	{&fd3, &outside_buf, 1, EFAULT},
> +	{&fd4, &addr4, 4096, EINVAL},
> +	{&fd4, &addr5, 1, EINVAL},
>  };
>  
>  int TST_TOTAL = ARRAY_SIZE(TC);
> @@ -89,6 +107,11 @@ int main(int ac, char **av)
>  
>  static void setup(void)
>  {
> +	if ((tst_kvercmp(2, 4, 10)) < 0)
> +		tst_brkm(TCONF, NULL, "This test needs kernel 2.4.10 or newer");

Linux 2.4.10 is from 2001 I would say that it's old enough so we can
expect that O_DIRECT is generally available.

> +	tst_require_root(NULL);

Does O_DIRECT require root?
(I haven't found anything in read man page that would suggests so)

>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
> @@ -100,11 +123,19 @@ static void setup(void)
>  	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "A");
>  
>  	fd3 = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
> +
> +	temp = SAFE_MALLOC(cleanup, 4096*10);
> +
> +	addr4 = (char *)(((long)buf & (~4095)) + 1);
> +	addr5 = (char *)((long)buf & (~4095));

You can allocate aligned buffer with memalign() instead.

> +	SAFE_FILE_PRINTF(cleanup, TEST_FILE4, "A");
> +	fd4 = SAFE_OPEN(cleanup, TEST_FILE4, O_RDWR | O_DIRECT, 0777);
>  }
>  
>  static void read_verify(const struct test_case_t *test)
>  {
> -	TEST(read(*test->fd, test->buf, 1));
> +	TEST(read(*test->fd, *test->buf, test->count));
>  
>  	if (TEST_RETURN != -1) {
>  		tst_resm(TFAIL, "call succeeded unexpectedly");
> @@ -127,6 +158,14 @@ static void cleanup(void)
>  {
>  	TEST_CLEANUP;
>  
> +	free(temp);
> +
> +	if (fd4 > 0)
> +		close(fd4);
> +
> +	if (unlink(TEST_FILE4) < 0)
> +		tst_resm(TWARN | TERRNO, "unlink(\"%s\") failed", TEST_FILE4);

There is no need to unlink files if you call tst_rmdir(). You only need
to close filedescriptors.

>  	if (fd3 > 0)
>  		close(fd3);
>  

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
