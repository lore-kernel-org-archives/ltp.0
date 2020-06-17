From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Jun 2020 20:43:56 +0200
Subject: [LTP] [PATCH] network/nfs_lib.sh: Use double quotes for grep
 pattern
In-Reply-To: <423c55db-a393-d1d9-6de6-28f65f76557a@oracle.com>
References: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
 <20200608145831.GA2746544@x230>
 <423c55db-a393-d1d9-6de6-28f65f76557a@oracle.com>
Message-ID: <20200617184356.GA7422@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Xiao,

> Perhaps this:

> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 59b373e..9c8f163 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -172,8 +172,7 @@ tst_rhost_run()
>         local output=
>         local ret=0
>         if [ -n "${TST_USE_SSH:-}" ]; then
> -               output=`ssh -n -q $user@$RHOST "sh -c \
> -                       '$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> +               output=$(ssh -n -q $user@$RHOST "$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
>         elif [ -n "$TST_USE_NETNS" ]; then
>                 output=`$LTP_NETNS sh -c \
>                         "$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`

Nice! Much simpler than what what I was just going to post (sed replacement).
Would it work for rsh as well? i.e. can it work without sh -c?
I have no working rsh setup.

And removing it from all 3 variants would be great (keeping them to be the same,
also it might allow to also use shell functions, which doesn't work with sh -c
"..."). Why was sh -c "..." used anyway?

BTW I have more tst_net.sh, but I post them after we solve this one (as
replacing quotes with sed, which is in my prepared patchset is ugly).

Kind regards,
Petr
