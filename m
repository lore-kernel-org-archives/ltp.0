From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 17:48:28 +0200
Subject: [LTP] [PATCH v5 3/7] Add new CGroups APIs
In-Reply-To: <20210430112649.16302-4-rpalethorpe@suse.com>
References: <20210430112649.16302-1-rpalethorpe@suse.com>
 <20210430112649.16302-4-rpalethorpe@suse.com>
Message-ID: <YIwmzFbctS7F4PJu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Found last two very minor issues, otherwise the code looks good.

With the two minor issues fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +static int cgroup_v1_mounted(void)
> +{
> +	return !!roots[1].ver;
> +}
> +
> +static int cgroup_mounted(void)
> +{
> +	return cgroup_v2_mounted() || cgroup_v1_mounted();
> +}
> +
> +static int cgroup_ctrl_on_v2(const struct cgroup_ctrl *const ctrl)
> +{
> +	return ctrl->ctrl_root && ctrl->ctrl_root->ver == TST_CGROUP_V2;
> +}
> +
> +int cgroup_dir_mk(const struct cgroup_dir *const parent,
^
static

> +		  const char *const dir_name,
> +		  struct cgroup_dir *const new)
> +{
> +	char *dpath;
> +
> +	new->dir_root = parent->dir_root;
> +	new->dir_name = dir_name;
> +	new->dir_parent = parent;
> +	new->ctrl_field = parent->ctrl_field;
> +	new->we_created_it = 0;
> +
> +	if (!mkdirat(parent->dir_fd, dir_name, 0777)) {
> +		new->we_created_it = 1;
> +		goto opendir;
> +	}
> +
> +	if (errno == EEXIST)
> +		goto opendir;
> +
> +	dpath = tst_decode_fd(parent->dir_fd);
> +
> +	if (errno == EACCES) {
> +		tst_brk(TCONF | TERRNO,
> +			"Lack permission to make '%s/%s'; premake it or run as root",
> +			dpath, dir_name);
> +	} else {
> +		tst_brk(TBROK | TERRNO,
> +			"mkdirat(%d<%s>, '%s', 0777)",
> +			parent->dir_fd, dpath, dir_name);
>  	}
> -	SAFE_FCLOSE(file);
>  
> -	return cg_check;
> +	return -1;
> +opendir:
> +	new->dir_fd = SAFE_OPENAT(parent->dir_fd, dir_name,
> +				  O_PATH | O_DIRECTORY);
> +
> +	return 0;
>  }

...

> -void tst_cgroup_umount(const char *cgroup_dir)
> +static void cgroup_group_init(struct tst_cgroup_group *const cg,
> +			      const char *const group_name)
>  {
> -	char *cgroup_new_dir;
> +	memset(cg, 0, sizeof(*cg));
> +
> +	if (!group_name)
> +		return;
>  
> -	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> -	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
> -	tst_cgroup_del_path(cgroup_dir);
> +	if (strlen(group_name) > NAME_MAX)
> +		tst_brk(TBROK, "Group name is too long");
> +
> +	strncpy(cg->group_name, group_name, NAME_MAX);

We just checked that it will fit so just strcpy()

>  }

-- 
Cyril Hrubis
chrubis@suse.cz
