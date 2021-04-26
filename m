From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 26 Apr 2021 17:01:53 +0100
Subject: [LTP] [PATCH v3 3/7] Add new CGroups APIs
In-Reply-To: <CAEemH2fmw0_HuetkiFTnyQGsa0HiD3vsUH-oD9XTTMsynOzn+g@mail.gmail.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-4-rpalethorpe@suse.com>
 <CAEemH2fmw0_HuetkiFTnyQGsa0HiD3vsUH-oD9XTTMsynOzn+g@mail.gmail.com>
Message-ID: <87lf95m3v2.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>  Hi Richard,
>
> Thanks for your work, the whole design looks good.
>
> Minor suggestions as below:
>
>
>> +static const char *ltp_cgroup_dir = "ltp";
>> +static const char *ltp_cgroup_drain_dir = "drain";
>> +static char test_cgroup_dir[PATH_MAX/4];
>> +static const char *ltp_mount_prefix = "/tmp/cgroup_";
>> +static const char *ltp_v2_mount = "unified";
>> +
>> +#define first_root                             \
>> +       (roots[0].ver ? roots : roots + 1)
>> +#define for_each_root(r)                       \
>> +       for ((r) = first_root; (r)->ver; (r)++)
>> +#define for_each_v1_root(r)                    \
>> +       for ((r) = roots + 1; (r)->ver; (r)++)
>>
>
> If you go through the whole files you will find, there are some places use
> 'r' to represent the root but other uses 't', even in functions that
> include ?t?
> to represent a tree.
>
> That probably a minor issue to make people get lost:).
>
> So I'd suggest a unified abbreviation in all:
>
> r  --> root
> t  --> tree
>
> if a function has root and tree, plz avoid using abbreviations, just use
> itself.

Yes, I should do something about this naming. I think this is related to
other issues Cyril mentioned in the naming of tree items.

>
>
>
>> +#define for_each_css(css)                      \
>> +       for ((css) = items + 1; (css)->name; (css)++)
>> +
>> +/* Controller items may only be in a single tree. So when (ss) > 0
>> + * we only loop once.
>> + */
>> +#define for_each_tree(cg, css, t)                                      \
>> +       for ((t) = (css) ? (cg)->trees_by_css + (css) : (cg)->trees;    \
>> +            *(t);                                                      \
>> +            (t) = (css) ? (cg)->trees + TST_CGROUP_MAX_TREES : (t) + 1)
>> +
>> +static int has_css(uint32_t css_field, enum tst_cgroup_css type)
>> +{
>> +       return !!(css_field & (1 << type));
>>  }
>>
>>
>
>
>> +struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
>> +                                const char *name)
>>  {
>>
>
> Since we have already got the parent tst_cgroup, it means we know which
> controllers/type has been mounted.
>
> Can we add the required controllers (e.g. "+memory")  to subtree_control
> automatically at here, rather than doing it manually before creating
> children?
> (then we can remove the line#27~30 in tst_cgroup02.c)

It is possible and more consistent with V1 behavior. I suppose users
could remove controllers again if they wanted to test some V2 specific
configuration.

OTOH we could leave this for a later patch when we actually have some
real tests containing child groups? I'm not fully sure what the results
of doing this are and we may just have to reverse it.

-- 
Thank you,
Richard.
