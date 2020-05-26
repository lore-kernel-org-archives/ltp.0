From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 May 2020 04:27:31 -0400 (EDT)
Subject: [LTP] [PATCH RFC 1/4] lib: add new cgroup test API
In-Reply-To: <20200522012327.18991-1-liwang@redhat.com>
References: <20200522012327.18991-1-liwang@redhat.com>
Message-ID: <1156025603.13595880.1590481651127.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----

> +
> +/* cgroup v1 */
> +#define PATH_TMP_CG1_MEM	"/tmp/cgroup1_mem"
> +#define PATH_TMP_CG1_CST	"/tmp/cgroup1_cpuset"

It's only used for mount, so not sure if making it relative to TMPDIR
buys us anything.

> +
> +/* cgroup v1 */
> +void tst_mount_cgroup1(const char *name, const char *option,
> +			const char *mnt_path, const char *new_path)

I'd make all cgroup API start with tst_cgroup*.

Is the intent to provide API for both v1 and v2, or just higher level API
that hides the details?

> +{
> +	if (tst_is_mounted(mnt_path))
> +		goto out;
> +
> +	SAFE_MKDIR(mnt_path, 0777);
> +	if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
> +		if (errno == ENODEV) {
> +			if (rmdir(mnt_path) == -1)
> +				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
> +			tst_brk(TCONF,
> +				 "Cgroup v1 is not configured in kernel");
> +		}

We should probably handle also EBUSY, for cases when controller is already part
of existing hierarchy. E.g. cpu,cpuacct is mounted together, and someone
tries to mount just cpu:
  mount("none", "/mnt/cgroup", "cgroup", MS_MGC_VAL, "cpu") = -1 EBUSY (Device or resource busy)

> +
> +void tst_write_memcg1(long memsz)

This should at least say memmax or something similar, if we add
functions for more knobs later.

I'm thinking if it would be worth having API more parametrized,
something like:

enum tst_cgroup_ctrl {
        TST_CGROUP_MEMCG = 1,
        TST_CGROUP_CPUSET = 2,
};

tst_cgroup_mount(enum tst_cgroup_ctrl)
tst_cgroup_umount(enum tst_cgroup_ctrl)
  // tests wouldn't need to use these ones directly
  // would be probably internal functions

tst_cgroup_version()
  // to get/check cgroup support in setup()

tst_cgroup_create(enum tst_cgroup_ctrl, const char *dir)
  // mounts cgroup if not already mounted
  // creates "dir", sets up subtree_control, etc.

tst_cgroup_cleanup()
  // cleans up everything, removes dirs, umounts what was mounted

tst_cgroup_move_current(enum tst_cgroup_ctrl, const char *dir)
  // writes getpid() to dir/"tasks"

tst_cgroup_mem_set_maxbytes(const char *dir, long memsz)
  // memcg specific function

