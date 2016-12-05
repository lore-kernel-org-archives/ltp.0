From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 13:56:28 +0100
Subject: [LTP] [PATCH 1/1] network/echo01: fix creating existing
	directory
In-Reply-To: <20161129100103.15756-1-pvorel@suse.cz>
References: <20161129100103.15756-1-pvorel@suse.cz>
Message-ID: <20161205125628.GB22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> $TCtmp directory is created by cmdlib.sh

Okay, looking into the net_cmdlib.sh in includes cmdlib.sh that
implements tst_setup() function that eventually does mkdir -p $TCtmp, so
this looks good.

And I guess that we should remove the TCtmp initialization in the
do_test() function in the echo01 as well, since it's set in the
tst_setup() function anyway.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/tcp_cmds/echo/echo01 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/testcases/network/tcp_cmds/echo/echo01 b/testcases/network/tcp_cmds/echo/echo01
> index 9260f21..18fef9c 100755
> --- a/testcases/network/tcp_cmds/echo/echo01
> +++ b/testcases/network/tcp_cmds/echo/echo01
> @@ -75,7 +75,6 @@ do_setup()
>  
>  do_test()
>  {
> -    mkdir $TCtmp
>      echo  "Creating echo file $ECHOFILE"
>      if ! "$LTPROOT/testcases/bin/$CREATEFILE" $ECHOSIZE "$TCtmp/$ECHOFILE"; then
>          end_testcase "$ECHOFILE not created"
> -- 
> 2.10.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
