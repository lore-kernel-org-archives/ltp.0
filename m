Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrqKz-0005j9-0x
	for ltp-list@lists.sourceforge.net; Fri, 12 Aug 2011 11:55:41 +0000
Date: Fri, 12 Aug 2011 13:59:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110812115943.GB27650@saboteur.suse.cz>
References: <1311302222-7280-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1311303451-7570-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1311303451-7570-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] sem_post:8-1:sleep to make sure child_3 get lock
 after child_2
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> 
> If with no sleep, child_3 will preempt and get the lock before child_2
> some time. It may fail the test case.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/sem_post/8-1.c          |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> index 165b094..37ed8a3 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> @@ -174,6 +174,7 @@ int main()
>  	}
>  	fprintf(stderr, "P: child_2: %d forked\n", c_2);
>  
> +	sleep(1);
>  	/* Make sure the two children has been waiting */
>  	/*do {
>  		sleep(1);
> @@ -254,4 +255,4 @@ clean_up:
>  	sem_unlink(semname);
>  	sem_unlink(semname_1);
>  	return retval;
> -}
> \ No newline at end of file

While this makes the probability of preempting smaller, the test still
would fail under some cirscumstances. The correct solution would be
check the semafore for number of waiting processes. And the code is
allready there but was commented out some time ago and I wonder why... 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
