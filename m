Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ugyt2-0002RR-Da
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 14:59:00 +0000
Date: Mon, 27 May 2013 17:00:14 +0200
From: chrubis@suse.cz
Message-ID: <20130527150014.GA31382@rei.suse.cz>
References: <1369537062-26852-1-git-send-email-jin.li@windriver.com>
	<1369537062-26852-2-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369537062-26852-2-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH] Add test groups into POSIX execution script
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
To: jin.li@windriver.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> fsync, fork, getpid
> 
> Signed-off-by: Jin Li <jin.li@windriver.com>
> ---
>  .../bin/run-posix-option-group-test.sh             |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> index 17f6e49..977d805 100755
> --- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> +++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> @@ -33,6 +33,7 @@ AIO)
>  	echo "Executing asynchronous I/O tests"
>  	run_option_group_tests "$BASEDIR/aio_*"
>  	run_option_group_tests "$BASEDIR/lio_listio"
> +	run_option_group_tests "$BASEDIR/fsync"
>  	;;
>  SIG)
>  	echo "Executing signals tests"
> @@ -65,6 +66,8 @@ MSG)
>  TPS)
>  	echo "Executing process and thread scheduling tests"
>  	run_option_group_tests "$BASEDIR/*sched*"
> +	run_option_group_tests "$BASEDIR/fork"
> +	run_option_group_tests "$BASEDIR/getpid"
>  	;;
>  MEM)
>  	echo "Executing mapped, process and shared memory tests"

The problem with this patch is that the tests in the script are sorted
by codes for the particular POSIX extension while the tests you are
adding are part of the core POSIX (not sure if all of them but at least
most of them).

If you just want to execute all openposix tests run 'make test' in the
testcases/open_posix_testsuite/ directory.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
