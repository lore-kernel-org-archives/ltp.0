From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jun 2020 07:51:05 +0200
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6)
 failure for Linux v5.6+
In-Reply-To: <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
References: <20200617154926.32588-1-alexey.kodanev@oracle.com>
 <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
Message-ID: <20200618055105.GA42990@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Alexey,

> Alexey Kodanev <alexey.kodanev@oracle.com> wrote:

> ...

> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > @@ -87,11 +87,17 @@ nfs_mount()

> >         tst_res TINFO "Mounting NFS: $mnt_cmd"
> >         if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
> > -               tst_rhost_run -s -c "$mnt_cmd"


> Or, maybe we can have a new function naming as 'tst_kconifg_check' to parse
> kernel .config in shell library as well?
+1, I was thinking about it for a long time.

> i.e
>     tst_kconfig_check "NFS_DISABLE_UDP_SUPPORT=y"
>     if [$? -qe 0 ]; then
>         tst_rhost_run -s -c "$mnt_cmd"
>     else
>         exit with TCONF ...

> What do you think?
And also have NEEDS_KCONFIGS (space separated).

Kind regards,
Petr
