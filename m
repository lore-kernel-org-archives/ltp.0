From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 May 2020 03:47:21 -0400 (EDT)
Subject: [LTP] [PATCH v1 1/4] lib: add new cgroup test API
In-Reply-To: <20200527031430.22144-1-liwang@redhat.com>
References: <20200527031430.22144-1-liwang@redhat.com>
Message-ID: <1946678285.13763431.1590565641700.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +
> +static void tst_cgroup1_umount(const char *mnt_path, const char *new_path)
> +{
> +	FILE *fp;
> +	int fd;
> +	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
> +
> +	if (!tst_is_mounted(mnt_path))
> +		return;
> +
> +	/* Move all processes in task to its parent node. */
> +	sprintf(s, "%s/tasks", mnt_path);
> +	fd = open(s, O_WRONLY);
> +	if (fd == -1)
> +		tst_res(TWARN | TERRNO, "open %s", s);
> +
> +	snprintf(s_new, BUFSIZ, "%s/tasks", new_path);
> +	fp = fopen(s_new, "r");
> +	if (fp == NULL)
> +		tst_res(TWARN | TERRNO, "fopen %s", s_new);
> +	if ((fd != -1) && (fp != NULL)) {
> +		while (fgets(value, BUFSIZ, fp) != NULL)
> +			if (write(fd, value, strlen(value) - 1)
> +			    != (ssize_t)strlen(value) - 1)
> +				tst_res(TWARN | TERRNO, "write %s", s);
> +	}
> +	if (fd != -1)
> +		close(fd);
> +	if (fp != NULL)
> +		fclose(fp);
> +	if (rmdir(new_path) == -1)
> +		tst_res(TWARN | TERRNO, "rmdir %s", new_path);
> +	if (umount(mnt_path) == -1)
> +		tst_res(TWARN | TERRNO, "umount %s", mnt_path);
> +	if (rmdir(mnt_path) == -1)
> +		tst_res(TWARN | TERRNO, "rmdir %s", mnt_path);

This sequence looks almost identical to tst_cgroup2_umount(),
would be nice if code could be shared in some way.

