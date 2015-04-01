Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YdJhu-0003ad-Jy
	for ltp-list@lists.sourceforge.net; Wed, 01 Apr 2015 14:33:26 +0000
Date: Wed, 1 Apr 2015 16:33:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150401143314.GA23093@rei>
References: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATCH] syscalls/utimensat01: "chattr" command error
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
To: cuibixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
>  .../testcases/kernel/syscalls/utimensat/utimensat_tests.sh       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> index b8eba51..972c81f 100755
> --- a/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> +++ b/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> @@ -300,6 +300,15 @@ nuke_sudoers()
>  }
>  
>  sudo $s_arg -u $test_user mkdir -p $TEST_DIR
> +
> +# Make sure chattr command is supported in test dir
> +touch $TEST_DIR/tmp_file
> +chattr +a $TEST_DIR/tmp_file
> +if [ $? -ne 0 ] ; then
> +        tst_resm TBROK "the chattr command is not supported in test dir"
> +        exit 1

This should rather be:
	tst_resm TCONF "..."
	exit 32

Or even better the test should be fixed to use the test.sh library then
this could be changed to:

tst_brkm TCONF "..."

> +fi
> +
>  cd $TEST_DIR
>  chown root $LTPROOT/testcases/bin/$TEST_PROG
>  chmod ugo+x,u+s $LTPROOT/testcases/bin/$TEST_PROG
> -- 
> 1.8.2.2
> 
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the 
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
