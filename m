From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2015 18:41:33 +0200
Subject: [LTP] [PATCH v3] fcntl/fcntl32.c: add F_SETLEASE and F_WRLCK
 argument test
In-Reply-To: <1442307339-16873-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <55EFA462.5010608@cn.fujitsu.com>
 <1442307339-16873-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20150930164132.GC8256@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int tc;
> +	long type;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	switch ((type = tst_fs_type(cleanup, "."))) {
> +	case TST_NFS_MAGIC:
> +	case TST_RAMFS_MAGIC:
> +	case TST_TMPFS_MAGIC:
> +		tst_brkm(TCONF, cleanup, "%s filesystem does not support "
> +			 "fcntl(2)'s F_SETLEASE operation",
> +			 tst_fs_type_name(type));
> +	default:
> +		break;
> +	}

Same as the second one. I would preffer figuring out that the fcntl() is
unsupported by actually trying to use it.


Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
