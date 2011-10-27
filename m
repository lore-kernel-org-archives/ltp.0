Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RJOWx-0002a4-Mx
	for ltp-list@lists.sourceforge.net; Thu, 27 Oct 2011 11:53:55 +0000
Date: Thu, 27 Oct 2011 13:58:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111027115846.GA14059@saboteur.suse.cz>
References: <20111026141525.GE9338@saboteur.suse.cz>
	<1319680368-6816-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1319680368-6816-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] aio_fsync: merged 4-1 and 4-2
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, lidan <li.dan@cn.fujitsu.com>

Hi!
> As Cyril said, seeing the difference between 4-1.c and 4-2.c these two should be
> merged into one testcase.
> 
> Correct test would check the return value from
> aio_error() and then check that return value from aio_return() match the
> buffer size. Mind that you could call them it exactly once after the
> operation is finished.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Signed-off-by: lidan <li.dan@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/aio_fsync/4-1.c         |   16 ++++-
>  .../conformance/interfaces/aio_fsync/4-2.c         |   81 --------------------
>  2 files changed, 14 insertions(+), 83 deletions(-)
>  delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
> index 5b965e8..afd19c1 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
> @@ -27,6 +27,7 @@ int main()
>  #define BUF_SIZE 111
>  	char buf[BUF_SIZE];
>  	int fd;
> +	int ret = 0;
>  	struct aiocb aiocb_write;
>  	struct aiocb aiocb_fsync;
>  
> @@ -68,13 +69,24 @@ int main()
>  		exit(PTS_FAIL);
>  	}
>  
> -	if (aio_error(&aiocb_fsync) < 0)
> +	while ((ret = aio_error(&aiocb_fsync)) == EINPROGRESS)
> +		usleep(10);

I would add a higher value here. At least 10000 (which would still do
the check hundred times in one second). 

> +	if (ret < 0)
>  	{
>  		printf(TNAME " Error at aio_error() : %s\n", strerror(errno));
>  		exit(PTS_FAIL);
>  	}
>  
> +	/* Upon successful completion, fsync() shall return 0.
> +	 * Otherwise, -1 shall be returned and errno set to indicate the error.
> +	 */
> +	if (aio_return(&aiocb_fsync))
> +	{
> +		printf(TNAME " Error at aio_return() : %s\n", strerror(errno));
> +		exit(PTS_FAIL);
> +	}

Ah, right, we check the return value from aio_fsync() which is 0 or -1
(I've thought that we were checking for the return value from
 aio_write() which should be buffer size).

But the in both cases the error number (eg. errno value) is returned by
the aio_error() call. So in the first case you should use strerror(ret)
and it shouldn't be at all in the second printf().

And for the coding style, the opening curly bracket should really be on
the same line as the if(). I know these tests are inconsistent but that
is one more reason to fix them.

>  	close(fd);
>  	printf ("Test PASSED\n");

And please remove the space after printf here.

>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}

Maybe it would be best to send two patches, one that fixes the coding
style and one that fixes the functionality...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The demand for IT networking professionals continues to grow, and the
demand for specialized networking skills is growing even more rapidly.
Take a complimentary Learning@Cisco Self-Assessment and learn 
about Cisco certifications, training, and career opportunities. 
http://p.sf.net/sfu/cisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
