From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 Jun 2021 11:42:49 +0200
Subject: [LTP] [PATCH] unshare01.sh: Setup parent mount flag before
 unshare testing
In-Reply-To: <6035DD9C.4080308@cn.fujitsu.com>
References: <20210223140323.126555-1-zhaogongyi@huawei.com>
 <YDWugcEDg/z4tRrX@pevik> <6035DD9C.4080308@cn.fujitsu.com>
Message-ID: <YL3qGZasDuppV3LH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang, Zhongyi,

> Hi Zhongyi, Petr

> I don't like the approach which enforces mountpoint to be shared in parent
> mount namespace.
> I think we can tune expected value by checking propagation flag in parent
> mount namespace because of two reasons:
> 1) Make test cover more cases.
> 2) Don't depend on the fixed tmpfs.

> Zhongyi,  could you test the following patch on your enviorment?
> -------------------------------------------------------------------------------------------------
> diff --git a/testcases/commands/unshare/unshare01.sh
> b/testcases/commands/unshare/unshare01.sh
> index bf163a7f4..78ea83fc0 100755
> --- a/testcases/commands/unshare/unshare01.sh
> +++ b/testcases/commands/unshare/unshare01.sh
> @@ -40,6 +40,17 @@ max_mntns_path="/proc/sys/user/max_mnt_namespaces"
>  default_max_userns=-1
>  default_max_mntns=-1

> +parse_propagation_flag()
> +{
> +       mount --bind dir_A dir_B
> +       if grep -w 'dir_B' /proc/self/mountinfo | grep -qw 'shared'; then
> +               echo "mounted"
> +       else
> +               echo "unmounted"
> +       fi
> +       umount dir_B
> +}
> +
>  setup()
>  {
>         # On some distributions(e.g RHEL7.4), the default value of
> @@ -149,7 +160,8 @@ do_test()
>         4) unshare_test "--user --map-root-user" "id -g" "0";;
>         5) unshare_test "--mount" "mount --bind dir_A dir_B" "unmounted";;
>         6) unshare_test "--mount --propagation shared" \
> -                       "mount --bind dir_A dir_B" "mounted";;
> +                       "mount --bind dir_A dir_B" \
> +                       "$(parse_propagation_flag)";;
>         7) unshare_test "--user --map-root-user --mount" \
>                         "mount --bind dir_A dir_B" "unmounted";;
>         8) unshare_test "--user --map-root-user --mount --propagation
> shared" \

Sorry for a big delay in this.
Your changes makes sense to me, ack.

Kind regards,
Petr
