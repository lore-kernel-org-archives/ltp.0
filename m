From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Apr 2021 17:13:40 +0200
Subject: [LTP] [PATCH v4 2/6] Add new CGroups APIs
In-Reply-To: <20210428142719.8065-3-rpalethorpe@suse.com>
References: <20210428142719.8065-1-rpalethorpe@suse.com>
 <20210428142719.8065-3-rpalethorpe@suse.com>
Message-ID: <YIrNJBgt6hjwsaUj@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've did a careful review of the code and found a few minor things I've
pointed out below. Overall the code looks really great at this point.

>  
> -void tst_cgroup_umount(const char *cgroup_dir)
> +static void cgroup_group_init(struct tst_cgroup_group *cg,
> +			      const char *group_name)
>  {
> -	char *cgroup_new_dir;
> +	memset(cg, 0, sizeof(*cg));
> +	cg->group_name = group_name;

Here we store a pointer to a string that was passed by the caller, which
will cause invalid access if user passed a string on a stack.

I guess that the easiest fix would be to add an 32 char array to the
tst_cgroup_group and strcpy() the string there. We would have to check
that the string is short enough, but that should be it.

> +}
> +
> +static void cgroup_group_add_dir(struct tst_cgroup_group *cg,
> +				 struct cgroup_dir *dir)
> +{
> +	const struct cgroup_ctrl *ctrl;
> +	int i;
> +
> +	if (dir->dir_root->ver == TST_CGROUP_V2)
> +		cg->dirs_by_ctrl[0] = dir;
>  
> -	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> -	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
> -	tst_cgroup_del_path(cgroup_dir);
> +	for_each_ctrl(ctrl) {
> +		if (has_ctrl(dir->ctrl_field, ctrl))
> +			cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
> +	}
> +
> +	for (i = 0; cg->dirs[i]; i++);
> +	cg->dirs[i] = dir;
>  }
>  
> -void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value)
> +struct tst_cgroup_group *
> +tst_cgroup_group_mk(const struct tst_cgroup_group *parent,
> +		    const char *group_name)
>  {
> -	char *cgroup_new_dir;
> -	char knob_path[PATH_MAX];
> +	struct tst_cgroup_group *cg;
> +	struct cgroup_dir *const *dir;
> +	struct cgroup_dir *new_dir;
> +
> +	cg = SAFE_MALLOC(sizeof(*cg));
> +	cgroup_group_init(cg, group_name);
>  
> -	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> -	sprintf(knob_path, "%s/%s", cgroup_new_dir, knob);
> -	SAFE_FILE_PRINTF(knob_path, "%ld", value);
> +	for_each_dir(parent, 0, dir) {
> +		new_dir = SAFE_MALLOC(sizeof(*new_dir));
> +		cgroup_dir_mk(*dir, group_name, new_dir);
> +		cgroup_group_add_dir(cg, new_dir);
> +	}
> +
> +	return cg;
>  }
>  
> -void tst_cgroup_move_current(const char *cgroup_dir)
> +struct tst_cgroup_group *tst_cgroup_group_rm(struct tst_cgroup_group *cg)
>  {
> -	if (tst_cg_ver & TST_CGROUP_V1)
> -		tst_cgroup_set_knob(cgroup_dir, "tasks", getpid());
> +	struct cgroup_dir **dir;
> +
> +	for_each_dir(cg, 0, dir) {
> +		close((*dir)->dir_fd);
> +		SAFE_UNLINKAT((*dir)->dir_parent->dir_fd,
> +			      (*dir)->dir_name,
> +			      AT_REMOVEDIR);
> +		free(*dir);
> +	}
>  
> -	if (tst_cg_ver & TST_CGROUP_V2)
> -		tst_cgroup_set_knob(cgroup_dir, "cgroup.procs", getpid());
> +	free(cg);
> +	return NULL;
>  }
>  
> -void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz)
> +/* Traverse the item tree to find an item. */

This is no longer called item. Maybe we should just remove this comment.

> +static const struct cgroup_file *cgroup_file_find(const char *file,
> +						  const int lineno,
> +						  const char *file_name)
>  {
> -	if (tst_cg_ver & TST_CGROUP_V1)
> -		tst_cgroup_set_knob(cgroup_dir, "memory.limit_in_bytes", memsz);
> +	const struct cgroup_file *cfile;
> +	const struct cgroup_ctrl *ctrl;
> +	char ctrl_name[32];
> +	const char *mem_name;
> +	size_t len = MIN(sizeof(ctrl_name) - 1, strcspn(file_name, "."));

Aren't all the v2 names in the format controller.knob? Can't we just
TBROK if there is '.' in the file_name?

> +	memcpy(ctrl_name, file_name, len);
> +	ctrl_name[len] = '\0';
> +
> +	ctrl = cgroup_find_ctrl(ctrl_name);
> +
> +	if (!ctrl) {
> +		tst_brk_(file, lineno, TBROK,
> +			 "Did not find controller '%s'\n", ctrl_name);
> +		return NULL;
> +	}
> +
> +	file_name += len + 1;
> +
> +	for (cfile = ctrl->files; cfile->file_name; cfile++) {
> +		mem_name = cfile->file_name + len + 1;
> +
> +		if (!strcmp(file_name, mem_name))
> +			break;

Can't we just compare the whole strings here? The prefix is constant and
the same for both, so we may as well avoid this string trickery and just
compare the file_name against cfile->file_name.

> +	}
> +
> +	if (!cfile->file_name) {
> +		tst_brk_(file, lineno, TBROK,
> +			 "Did not find '%s' in '%s'\n",
> +			 file_name, ctrl->ctrl_name);
> +		return NULL;
> +	}
>  
> -	if (tst_cg_ver & TST_CGROUP_V2)
> -		tst_cgroup_set_knob(cgroup_dir, "memory.max", memsz);
> +	return cfile;
>  }
>  
> -int tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir)
> +enum tst_cgroup_ver tst_cgroup_ver(const char *file, const int lineno,
> +				    const struct tst_cgroup_group *cg,
> +				    const char *ctrl_name)
>  {
> -	char *cgroup_new_dir;
> -	char knob_path[PATH_MAX];
> +	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
> +	const struct cgroup_dir *dir;
> +
> +	if (!strcmp(ctrl_name, "cgroup")) {
> +		tst_brk_(file, lineno,
> +			 TBROK,
> +			 "cgroup may be present on both V1 and V2 hierarchies");
> +		return 0;
> +	}
>  
> -	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> +	if (!ctrl) {
> +		tst_brk_(file, lineno,
> +			 TBROK, "Unknown controller '%s'", ctrl_name);
> +		return 0;
> +	}
>  
> -	if (tst_cg_ver & TST_CGROUP_V1) {
> -		sprintf(knob_path, "%s/%s",
> -				cgroup_new_dir, "/memory.memsw.limit_in_bytes");
> +	dir = cg->dirs_by_ctrl[ctrl->ctrl_indx];
>  
> -		if ((access(knob_path, F_OK) == -1)) {
> -			if (errno == ENOENT)
> -				tst_res(TCONF, "memcg swap accounting is disabled");
> -			else
> -				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
> -		} else {
> -			return 1;
> -		}
> +	if (!dir) {
> +		tst_brk_(file, lineno,
> +			 TBROK, "%s controller not attached to CGroup %s",
> +			 ctrl_name, cg->group_name);
> +		return 0;
>  	}
>  
> -	if (tst_cg_ver & TST_CGROUP_V2) {
> -		sprintf(knob_path, "%s/%s",
> -				cgroup_new_dir, "/memory.swap.max");
> +	return dir->dir_root->ver;
> +}
>  
> -		if ((access(knob_path, F_OK) == -1)) {
> -			if (errno == ENOENT)
> -				tst_res(TCONF, "memcg swap accounting is disabled");
> -			else
> -				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
> -		} else {
> -			return 1;
> -		}
> +static const char *cgroup_file_alias(const struct cgroup_file *const cfile,
> +				     const struct cgroup_dir *const dir)
> +{
> +	if (dir->dir_root->ver != TST_CGROUP_V1)
> +		return cfile->file_name;
> +
> +	if (cfile->ctrl_indx == CTRL_CPUSET &&
> +	    dir->dir_root->no_cpuset_prefix &&
> +	    cfile->file_name_v1) {
> +		return strchr(cfile->file_name_v1, '.') + 1;
>  	}

This is quite ugly but I do not think that I can come up with better
solutution.

> -	return 0;
> +	return cfile->file_name_v1;
>  }
>  
> -void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz)
> +int safe_cgroup_has(const char *file, const int lineno,
> +		    const struct tst_cgroup_group *cg, const char *file_name)
>  {
> -	if (tst_cg_ver & TST_CGROUP_V1)
> -		tst_cgroup_set_knob(cgroup_dir, "memory.memsw.limit_in_bytes", memsz);
> +	const struct cgroup_file *const cfile =
> +		cgroup_file_find(file, lineno, file_name);
> +	struct cgroup_dir *const *dir;
> +	const char *alias;
>  
> -	if (tst_cg_ver & TST_CGROUP_V2)
> -		tst_cgroup_set_knob(cgroup_dir, "memory.swap.max", memsz);
> +	if (!cfile)
> +		return 0;
> +
> +	for_each_dir(cg, cfile->ctrl_indx, dir) {
> +		if (!(alias = cgroup_file_alias(cfile, *dir)))
> +		    continue;
> +
> +		if (!faccessat((*dir)->dir_fd, file_name, F_OK, 0))
> +			return 1;
> +
> +		if (errno == ENOENT)
> +			continue;
> +
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "faccessat(%d<%s>, %s, F_OK, 0)",
> +			 (*dir)->dir_fd, tst_decode_fd((*dir)->dir_fd), alias);
> +	}
> +
> +	return 0;
>  }
>  
> -void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
> -	char *retbuf, size_t retbuf_sz)
> +static struct tst_cgroup_group *cgroup_group_from_roots(size_t tree_off)
>  {
> -	int fd;
> -	char *cgroup_new_dir;
> -	char knob_path[PATH_MAX];
> +	struct cgroup_root *root;
> +	struct cgroup_dir *dir;
> +	struct tst_cgroup_group *cg;
>  
> -	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> +	cg = tst_alloc(sizeof(*cg));
> +	cgroup_group_init(cg, NULL);
>  
> -	/*
> -	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
> -	 * please see Documentation/cgroups/cpusets.txt from kernel src
> -	 * for details
> -	 */
> -	sprintf(knob_path, "%s/%s", cgroup_new_dir, filename);
> -	fd = open(knob_path, O_RDONLY);
> -	if (fd == -1) {
> -		if (errno == ENOENT) {
> -			sprintf(knob_path, "%s/cpuset.%s",
> -					cgroup_new_dir, filename);
> -			fd = SAFE_OPEN(knob_path, O_RDONLY);
> -		} else
> -			tst_brk(TBROK | TERRNO, "open %s", knob_path);
> +	for_each_root(root) {
> +		dir = (typeof(dir))(((char *)root) + tree_off);
> +
> +		if (dir->ctrl_field)
> +			cgroup_group_add_dir(cg, dir);
>  	}
>  
> -	memset(retbuf, 0, retbuf_sz);
> -	if (read(fd, retbuf, retbuf_sz) < 0)
> -		tst_brk(TBROK | TERRNO, "read %s", knob_path);
> +	if (cg->dirs[0]) {
> +		cg->group_name = cg->dirs[0]->dir_name;
> +		return cg;
> +	}
> +
> +	tst_brk(TBROK,
> +		"No CGroups found; maybe you forgot to call tst_cgroup_require?");
>  
> -	close(fd);
> +	return cg;
>  }
>  
> -void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf)
> +const struct tst_cgroup_group *tst_cgroup_get_test_group(void)
>  {
> -	int fd;
> -	char *cgroup_new_dir;
> -	char knob_path[PATH_MAX];
> +	return cgroup_group_from_roots(offsetof(struct cgroup_root, test_dir));
> +}
>  
> -	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> +const struct tst_cgroup_group *tst_cgroup_get_drain_group(void)
> +{
> +	return cgroup_group_from_roots(offsetof(struct cgroup_root, drain_dir));
> +}
>  
> -	/*
> -	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
> -	 * please see Documentation/cgroups/cpusets.txt from kernel src
> -	 * for details
> -	 */
> -	sprintf(knob_path, "%s/%s", cgroup_new_dir, filename);
> -	fd = open(knob_path, O_WRONLY);
> -	if (fd == -1) {
> -		if (errno == ENOENT) {
> -			sprintf(knob_path, "%s/cpuset.%s", cgroup_new_dir, filename);
> -			fd = SAFE_OPEN(knob_path, O_WRONLY);
> -		} else
> -			tst_brk(TBROK | TERRNO, "open %s", knob_path);
> +ssize_t safe_cgroup_read(const char *file, const int lineno,
> +			 const struct tst_cgroup_group *cg, const char *file_name,
> +			 char *out, size_t len)
> +{
> +	const struct cgroup_file *const cfile =
> +		cgroup_file_find(file, lineno, file_name);
> +	struct cgroup_dir *const *dir;
> +	const char *alias;
> +	size_t prev_len = 0;
> +	char prev_buf[BUFSIZ];
> +
> +	for_each_dir(cg, cfile->ctrl_indx, dir) {
> +		if (!(alias = cgroup_file_alias(cfile, *dir)))
> +			continue;
> +
> +		if (prev_len)
> +			memcpy(prev_buf, out, prev_len);
> +
> +		TEST(safe_file_readat(file, lineno,
> +				      (*dir)->dir_fd, alias, out, len));
> +		if (TST_RET < 0)
> +			continue;
> +
> +		if (prev_len && memcmp(out, prev_buf, prev_len)) {
> +			tst_brk_(file, lineno, TBROK,
> +				 "%s has different value across roots",
> +				 file_name);
> +			break;
> +		}
> +
> +		prev_len = MIN(sizeof(prev_buf), (size_t)TST_RET);
>  	}
>  
> -	SAFE_WRITE(1, fd, buf, strlen(buf));
> +	out[MAX(TST_RET, 0)] = '\0';
>  
> -	close(fd);
> +	return TST_RET;
> +}
> +
> +void safe_cgroup_printf(const char *file, const int lineno,
> +			const struct tst_cgroup_group *cg,
> +			const char *file_name,
> +			const char *fmt, ...)
> +{
> +	const struct cgroup_file *const cfile =
> +		cgroup_file_find(file, lineno, file_name);
> +	struct cgroup_dir *const *dir;
> +	const char *alias;
> +	va_list va;
> +
> +	for_each_dir(cg, cfile->ctrl_indx, dir) {

So this is a loop because we have to write to all instances of the
generic files such as "tasks" to move the the process consistently
across the hierarchies, right?

Maybe this deserves a comment at the for_each_dir() macro definition.

> +		if (!(alias = cgroup_file_alias(cfile, *dir)))
> +		    continue;
> +
> +		va_start(va, fmt);
> +		safe_file_vprintfat(file, lineno,
> +				    (*dir)->dir_fd, alias, fmt, va);
> +		va_end(va);
> +	}
> +}
> +
> +void safe_cgroup_scanf(const char *file, const int lineno,
> +		       const struct tst_cgroup_group *cg, const char *file_name,
> +		       const char *fmt, ...)
> +{
> +	va_list va;
> +	char buf[BUFSIZ];
> +	ssize_t len = safe_cgroup_read(file, lineno,
> +				       cg, file_name, buf, sizeof(buf));
> +
> +	if (len < 1)
> +		return;
> +
> +	va_start(va, fmt);
> +	if (vsscanf(buf, fmt, va) < 1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "'%s': vsscanf('%s', '%s', ...)", file_name, buf, fmt);
> +	}
> +	va_end(va);

This does not allow user to handle if we convert less than requested
number of conversions including zero. Either we have to return the number of
conversions from this function, or we have to count the conversions in
the fmt and TBROK if we got less as we do in safe_file_ops.c with
count_scanf_conversions() function.

>  }
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
