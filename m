From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Apr 2021 14:57:33 +0800
Subject: [LTP] [PATCH v3 3/7] Add new CGroups APIs
In-Reply-To: <20210412145506.26894-4-rpalethorpe@suse.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-4-rpalethorpe@suse.com>
Message-ID: <CAEemH2fmw0_HuetkiFTnyQGsa0HiD3vsUH-oD9XTTMsynOzn+g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 Hi Richard,

Thanks for your work, the whole design looks good.

Minor suggestions as below:


> +static const char *ltp_cgroup_dir = "ltp";
> +static const char *ltp_cgroup_drain_dir = "drain";
> +static char test_cgroup_dir[PATH_MAX/4];
> +static const char *ltp_mount_prefix = "/tmp/cgroup_";
> +static const char *ltp_v2_mount = "unified";
> +
> +#define first_root                             \
> +       (roots[0].ver ? roots : roots + 1)
> +#define for_each_root(r)                       \
> +       for ((r) = first_root; (r)->ver; (r)++)
> +#define for_each_v1_root(r)                    \
> +       for ((r) = roots + 1; (r)->ver; (r)++)
>

If you go through the whole files you will find, there are some places use
'r' to represent the root but other uses 't', even in functions that
include ?t?
to represent a tree.

That probably a minor issue to make people get lost:).

So I'd suggest a unified abbreviation in all:

r  --> root
t  --> tree

if a function has root and tree, plz avoid using abbreviations, just use
itself.



> +#define for_each_css(css)                      \
> +       for ((css) = items + 1; (css)->name; (css)++)
> +
> +/* Controller items may only be in a single tree. So when (ss) > 0
> + * we only loop once.
> + */
> +#define for_each_tree(cg, css, t)                                      \
> +       for ((t) = (css) ? (cg)->trees_by_css + (css) : (cg)->trees;    \
> +            *(t);                                                      \
> +            (t) = (css) ? (cg)->trees + TST_CGROUP_MAX_TREES : (t) + 1)
> +
> +static int has_css(uint32_t css_field, enum tst_cgroup_css type)
> +{
> +       return !!(css_field & (1 << type));
>  }
>
>


> +struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
> +                                const char *name)
>  {
>

Since we have already got the parent tst_cgroup, it means we know which
controllers/type has been mounted.

Can we add the required controllers (e.g. "+memory")  to subtree_control
automatically at here, rather than doing it manually before creating
children?
(then we can remove the line#27~30 in tst_cgroup02.c)


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210416/bbe7cbfd/attachment.htm>
