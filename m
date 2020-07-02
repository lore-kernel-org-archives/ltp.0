From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jul 2020 14:16:11 +0800
Subject: [LTP] [PATCH v2 1/2] Add tst_get_hugepage_size() to LTP library
In-Reply-To: <20200701151456.851-1-mdoucha@suse.cz>
References: <20200701151456.851-1-mdoucha@suse.cz>
Message-ID: <CAEemH2e9Lv3a_SF3Jez6HTdC9=KKrNfoR=U11T2Rhkt4hf2C+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 1, 2020 at 11:15 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>
> No changes since v1.
>
>  include/tst_hugepage.h | 5 +++++
>  lib/tst_hugepage.c     | 9 +++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> index 60c03c5c5..e08a2daa2 100644
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -12,6 +12,11 @@
>  extern char *nr_opt; /* -s num   Set the number of the been allocated
> hugepages */
>  extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H
> /var/hugetlbfs */
>
> +/*
> + * Get the default hugepage size. Returns 0 if hugepages are not
> supported.
> + */
> +size_t tst_get_hugepage_size(void);
> +
>  /*
>   * Try the best to request a specified number of huge pages from system,
>   * it will store the reserved hpage number in tst_hugepages.
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index f2bf5d20e..3a8dcca90 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -12,6 +12,15 @@ unsigned long tst_hugepages;
>  char *nr_opt;
>  char *Hopt;
>
> +size_t tst_get_hugepage_size(void)
> +{
> +       if (access(PATH_HUGEPAGES, F_OK)) {
>

The braces here is redundant. Someone who merging the patch can help clean
this.



> +               return 0;
> +       }
> +
> +       return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
> +}
> +
>  unsigned long tst_request_hugepages(unsigned long hpages)
>  {
>         unsigned long val, max_hpages;
> --
> 2.26.2
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200702/c2b85b7a/attachment.htm>
