From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 06 May 2021 09:06:07 +0100
Subject: [LTP] [PATCH v6 3/7] Add new CGroups APIs
In-Reply-To: <CAEemH2dnRA==KvFE73_u4eeqYvWF_+8CjLK=w6D0cv5L+gNBnw@mail.gmail.com>
References: <20210504134100.20666-1-rpalethorpe@suse.com>
 <20210504134100.20666-4-rpalethorpe@suse.com>
 <CAEemH2dnRA==KvFE73_u4eeqYvWF_+8CjLK=w6D0cv5L+gNBnw@mail.gmail.com>
Message-ID: <87tungl21c.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> With my pleasure for patchset:
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks for the reviews!

>
> Also, the below typos should be corrected (someone who merges these
> can help modify).
>
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -147,7 +147,7 @@ static const files_t cgroup_ctrl_files = {
>         /* procs exists on V1, however it was read-only until kernel v3.0. */
>         { "cgroup.procs", "tasks", 0 },
>         { "cgroup.subtree_control", NULL, 0 },
> -       { "cgroup.clone_children", "clone_children", 0 },
> +       { "cgroup.clone_children", "cgroup.clone_children", 0 },

+1

>         { }
>  };
>
> @@ -158,7 +158,7 @@ static const files_t memory_ctrl_files = {
>         { "memory.swap.current", "memory.memsw.usage_in_bytes", CTRL_MEMORY },
>         { "memory.swap.max", "memory.memsw.limit_in_bytes", CTRL_MEMORY },
>         { "memory.kmem.usage_in_bytes", "memory.kmem.usage_in_bytes",
> CTRL_MEMORY },
> -       { "memory.kmem.limit_in_bytes", "memory.kmem.usage_in_bytes",
> CTRL_MEMORY },
> +       { "memory.kmem.limit_in_bytes", "memory.kmem.limit_in_bytes",
> CTRL_MEMORY },
>         { }
>  };


-- 
Thank you,
Richard.
