From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jun 2018 13:26:12 +0200
Subject: [LTP] [PATCH v2] commands/mkswap01.sh: Fix unexisted
 "/dev/disk/by-*" files on old kernels
In-Reply-To: <1529819983-461-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <CAEemH2c4tC1Lk5bu2Tym9N5ej2yuqR15U+ApO-+vZb8XsKm-Jg@mail.gmail.com>
 <1529819983-461-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180628112611.mbhbs2gnjvc5g3lj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Xiao,


> Before kernel commit c3473c6(e.g. RHEL6), mkswap -L or mkswap -U for loop
> devices can not generate corresponding "/dev/disk/by-*" files.  It is just
> a way to check the success of mkswap rather than a bug, so the test should
> not get TBROK when "/dev/disk/by-*" files are not generated but swapon
> enables loop devices for swapping sucessfully.

> Suggested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/commands/mkswap/mkswap01.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
> index 5ead4cd..4185702 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -64,7 +64,12 @@ mkswap_verify()
>  		local pagesize=$PAGE_SIZE
>  	fi

> -	TST_RETRY_FUNC "check_for_file $dev_file" 0
> +	if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
> +		tst_res TINFO "Waiting for $dev_file to appear"
> +		tst_sleep 100ms
> +	else
> +		TST_RETRY_FUNC "check_for_file $dev_file" 0
> +	fi

>  	swapon $swapfile 2>/dev/null

pushed, thanks!


Kind regards,
Petr
