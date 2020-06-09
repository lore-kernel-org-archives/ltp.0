From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 Jun 2020 06:42:42 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <20200609095102.21153-1-liwang@redhat.com>
References: <20200609095102.21153-1-liwang@redhat.com>
Message-ID: <1111554317.15300411.1591699362992.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Many of our LTP tests need Control Group in the configuration,
> this patch makes cgroup unified mounting at setup phase to be
> possible. The method?is extracted from mem.h with the purpose
> of?extendible for further developing, and trying?to compatible
> the current two versions of cgroup,
> 
> It's hard to make all APIs be strictly consistent because there
> are many differences between v1 and v2. But it?capsulate the detail
> of cgroup mounting in high-level functions, which will be easier
> to use cgroup without considering too much technical thing.
> 
> Btw, test get passed on RHEL7(x86_64), RHEL8(ppc64le), Fedora32(x86_64).
> 

No strong objections to v4, couple comments below (if you spin v5 because
of other reviews).

> +2.2.36 Using Control Group
> +^^^^^^^^^^^^^^^^^^^^^^^^^^

Would be nice if there was short description of each function.

> +static void tst_cgroup_set_path(const char *cgroup_dir)
> +{
> +	char cgroup_new_dir[PATH_MAX];
> +	struct tst_cgroup_path *tst_cgroup_path, *a;
> +
> +	if (!cgroup_dir)
> +		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
> +
> +	sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
> +
> +	/* To store cgroup path in the 'path' list */
> +	tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct tst_cgroup_path)),
> +			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

This looks like it could use just SAFE_MALLOC/SAFE_FREE.

