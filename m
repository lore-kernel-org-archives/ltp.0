From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Thu, 31 Dec 2020 13:38:13 +0300
Subject: [LTP] [PATCH v1] include/tst_cgroup.h: Replace hardcoded cgroup
 paths
In-Reply-To: <CAEemH2d88KVzzidLyEmCPm+LrXiE0zG7YvXG=r=AgEy+2jKU-A@mail.gmail.com>
References: <CAEemH2d88KVzzidLyEmCPm+LrXiE0zG7YvXG=r=AgEy+2jKU-A@mail.gmail.com>
Message-ID: <96F5BFE2-CF01-480E-B607-807A87003ABF@getmailspring.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Thanks for the review and pointing to the Richard's update, haven't seen that before.
Regards,
Bogdan

On Dec 31 2020, at 6:01 am, Li Wang <liwang@redhat.com> wrote:
> Hi Bogdan,
>
>
> On Wed, Dec 30, 2020 at 11:49 PM Bogdan Lezhepekov via ltp <ltp@lists.linux.it (mailto:ltp@lists.linux.it)> wrote:
> > Macros PATH_TMP_CG_CST and PATH_TMP_CG_MEM defined cgroup
> > temporary directory paths to be in /tmp that can be a mount point.
> >
> > Enable an option to set PATH_TMP_CG_CST and PATH_TMP_CG_MEM
> > through TMPDIR environment variable keeping old paths as default ones.
> >
> > Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com (mailto:bogdan.lezhepekov@suse.com)>
> > ---
> > include/tst_cgroup.h | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> > index bfd848260..0f7db5487 100644
> > --- a/include/tst_cgroup.h
> > +++ b/include/tst_cgroup.h
> > @@ -7,8 +7,9 @@
> > #ifndef TST_CGROUP_H
> > #define TST_CGROUP_H
> >
> > -#define PATH_TMP_CG_MEM "/tmp/cgroup_mem"
> > -#define PATH_TMP_CG_CST "/tmp/cgroup_cst"
> > +#define PATH_BASE (getenv("TMPDIR") ? getenv("TMPDIR") : "/tmp")
> > +#define PATH_TMP_CG_CST (strcat(PATH_BASE, "/cgroup_cst"))
> > +#define PATH_TMP_CG_MEM (strcat(PATH_BASE, "/cgroup_mem"))
>
>
> As described on strcat() manual page, the potential risk is that buffer overruns might cause an unpredictable problem.
>
> I won't like to merge this patch because, Richard raised a new method to refactor the whole CGroup API. And the patchset is pending on reviewing.
>
> http://lists.linux.it/pipermail/ltp/2020-December/020274.html
>
> --
> Regards,
>
> Li Wang
>
>
>
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201231/3a4f3ac0/attachment.htm>
