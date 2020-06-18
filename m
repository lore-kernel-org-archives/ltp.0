From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jun 2020 11:15:41 +0800
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6)
 failure for Linux v5.6+
In-Reply-To: <20200617154926.32588-1-alexey.kodanev@oracle.com>
References: <20200617154926.32588-1-alexey.kodanev@oracle.com>
Message-ID: <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Alexey Kodanev <alexey.kodanev@oracle.com> wrote:

...

--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -87,11 +87,17 @@ nfs_mount()
>
>         tst_res TINFO "Mounting NFS: $mnt_cmd"
>         if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
> -               tst_rhost_run -s -c "$mnt_cmd"
>

Or, maybe we can have a new function naming as 'tst_kconifg_check' to parse
kernel .config in shell library as well?

i.e
    tst_kconfig_check "NFS_DISABLE_UDP_SUPPORT=y"
    if [$? -qe 0 ]; then
        tst_rhost_run -s -c "$mnt_cmd"
    else
        exit with TCONF ...

What do you think?


> -               return
> +               tst_rhost_run -c "$mnt_cmd"
> +       else
> +               $mnt_cmd > /dev/null
>         fi
>
> -       ROD $mnt_cmd
> +       if [ $? -ne 0 ]; then
> +               if [ "$type" = "udp" -o "$type" = "udp6" ] && tst_kvcmp
> -ge 5.6; then
> +                       tst_brk TCONF "UDP support disabled with the
> kernel config NFS_DISABLE_UDP_SUPPORT?"
> +               fi
> +               tst_brk TBROK "mount command failed"
> +       fi
>  }
>
>  nfs_setup()
> --
> 2.20.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200618/cc395a81/attachment.htm>
