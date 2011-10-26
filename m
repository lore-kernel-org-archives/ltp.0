Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RJ4Bm-0006Ua-45
	for ltp-list@lists.sourceforge.net; Wed, 26 Oct 2011 14:10:42 +0000
Date: Wed, 26 Oct 2011 16:15:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111026141525.GE9338@saboteur.suse.cz>
References: <1319609427-28098-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1319609427-28098-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] aio_fsync:4-2: wait until the io is in no
	INPROGRESS
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
> If the aio is in INPROGRESS, the aio_return is undefined, and
> may cause Segment Faul.
> So, wait for it.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Signed-off-by: lidan <li.dan@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/aio_fsync/4-2.c         |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
> index bf76109..2be8d4b 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-2.c
> @@ -68,6 +68,7 @@ int main()
>  		exit(PTS_FAIL);
>  	}
>  
> +	while(aio_error(&aiocb_fsync) == EINPROGRESS);
>  	errno = 0;
>  	aio_return(&aiocb_fsync);
>  	if (errno != 0)
> @@ -78,4 +79,4 @@ int main()
>  	close(fd);
>  	printf ("Test PASSED\n");
>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}

Yes that is one of the problems with that testcase, however I would like
to see some usleep() in the while body, because otherwise this is
basically bussy loop which would unnecesarilly eat cputime.

The other problem is that most of the aio functions are not modifying
the errno, which is common misconception (the aio_read and aio_write may
return -1 and set the errno if the error happend while the aio operation
was being initalized). So correct test would check the return value from
aio_error() and then check that return value from aio_return() match the
buffer size. Mind that you could call them it exactly once after the
operation is finished.

And seeing the difference between 4-1.c and 4-2.c these two should be
merged into one testcase.

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
