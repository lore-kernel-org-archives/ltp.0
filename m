From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 23 Sep 2020 12:03:17 +0100
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <20200609095102.21153-1-liwang@redhat.com>
References: <20200609095102.21153-1-liwang@redhat.com>
Message-ID: <87pn6cycui.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Many of our LTP tests need Control Group in the configuration,
> this patch makes cgroup unified mounting at setup phase to be
> possible. The method is extracted from mem.h with the purpose
> of extendible for further developing, and trying to compatible
> the current two versions of cgroup,
>
> It's hard to make all APIs be strictly consistent because there
> are many differences between v1 and v2. But it capsulate the detail
> of cgroup mounting in high-level functions, which will be easier
> to use cgroup without considering too much technical thing.   
>
> Btw, test get passed on RHEL7(x86_64), RHEL8(ppc64le),
> Fedora32(x86_64).

This appears to be broken on SUSE.

> +enum tst_cgroup_ver tst_cgroup_version(void)
> +{
> +	if (tst_cgroup_check("cgroup2")) {
> +		if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))

Unfortunately this is backwards: if a cgroup controller is mounted
(e.g. memory) in the v1 separated hierarchy then it is not available in
the cgroup v2 unified hierarchy even though the v2 unified hierarchy
exists.

So ksm{03,04} fails with:

safe_file_ops.c:299: BROK: Failed to close FILE
'/tmp/cgroup_mem/cgroup.subtree_control' at tst_cgroup.c:301: ENOENT (2)

because we have the memory controller (in fact all the controllers)
mounted in the V1 way, but we also have the cgroup2 mounted. If I
unmount the memory controller from V1 then the test passes.

Another potential problem is that it may be possible to remove access to
controllers some other way in which case you have to check
cgroup.controllers to see what is available. OTOH maybe this is not
possible because you mount a new cgroup2 hierarchy?

-- 
Thank you,
Richard.
