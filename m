From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Jun 2020 09:57:11 -0400 (EDT)
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <20200601100459.32511-1-liwang@redhat.com>
References: <20200601100459.32511-1-liwang@redhat.com>
Message-ID: <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	...
> +
> +	tst_cgroup_move_current(PATH_TMP_CG1_MEM);
> +	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG1_MEM, MEMSIZE);

Goal for API is to hide differences between cgroup 1/2, but example above
is passing cgroup specific directory.

My suggestion was to have directory parameter relative to cgroup mount,
I didn't consider there would be need for mounting cgroup more than once
from single process. Is there such need?

Since there's only one global 'tst_cgroup_mnt_path', is there need to have
paths absolute? If we assume that single process will mount cgroup only once,
then all paths could be relative to 'tst_cgroup_mnt_path', and test doesn't
need to even use 'tst_cgroup_mnt_path'.

> +
> +static void tst_cgroup_set_path(const char *cgroup_dir)
> +{
> +	struct tst_cgroup_path *tst_cgroup_path, *a;
> +
> +	if (!cgroup_dir)
> +		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
> +
> +	sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
> +	sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
> +
> +	/* To store cgroup path in the shared 'path' list */
> +	tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct tst_cgroup_path)),
> +			PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);

I'm not sure I understand what is the reason to have tst_cgroup_path. Is it expected,
that mount and umount are called by different processes? It might be easier
to define API as per-process and require same process to call mount and umount.

> +	tst_cgroup_path->mnt_path = SAFE_MALLOC(strlen(tst_cgroup_mnt_path));
> +	tst_cgroup_path->new_path = SAFE_MALLOC(strlen(tst_cgroup_new_path));

Pointers are in shared memory, but content they point to is not, so it's accessible
only from process that called tst_cgroup_set_path().

Can you describe all different scenarios you wanted to support?

