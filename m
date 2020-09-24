From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Sep 2020 20:53:21 +0800
Subject: [LTP] [PATCH] tst_cgroup: Don't try to use V2 if V1 controllers
 are mounted
In-Reply-To: <20200924111124.5666-1-rpalethorpe@suse.com>
References: <20200924111124.5666-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2eDPzfdUR78d_mSuaDgi=v1RuboDotNwAGrLHCCg1Q41A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Thu, Sep 24, 2020 at 7:11 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> It is not possible to use a controller in V2 cgroups if it has been
> mounted as a V1 controller. So if V1 is mounted we use it regardless
> of if V2 is available.
>
> We have to include a space in tst_is_mounted so that we do not match
> cgroup2.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  lib/tst_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index ba413d874..73ddd4b82 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -44,7 +44,7 @@ enum tst_cgroup_ver tst_cgroup_version(void)
>          enum tst_cgroup_ver cg_ver;
>
>          if (tst_cgroup_check("cgroup2")) {
> -                if (!tst_is_mounted("cgroup2") &&
> tst_is_mounted("cgroup"))
> +                if (tst_is_mounted("cgroup "))
>

Add a space in the suffix still not work as expected.

The reason is that tst_is_mounted("cgroup ") also get non-zero return if
system only mount cgroup_v2, which lead to choose cgroup_v1 in LTP test.

# cat /proc/mounts |grep cgroup
cgroup2 /sys/fs/cgroup cgroup2 rw,seclabel,nosuid,nodev,noexec,relatime 0 0

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200924/04c3bfa6/attachment.htm>
