From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Feb 2016 14:41:48 +0100
Subject: [LTP] [PATCH 2/3] llistxattr/llistxattr02.c: add new testcase
In-Reply-To: <1454058489-25625-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1454058489-25625-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1454058489-25625-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160210134147.GC10106@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct test_case {
> +	const char *path;
> +	size_t size;
> +	int exp_err;
> +} tc[] = {
> +	/* test1 */
> +	{"symlink", 1, ERANGE},
> +	/* test2 */
> +	{"", 20, ENOENT},
> +	/* test3 */
> +	{NULL, 20, EFAULT}

You should use (char *)-1 instead of NULL. AFAIK on sparc there is some
system mapping at NULL and the call will overwrite it.

> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
