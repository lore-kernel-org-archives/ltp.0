From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Apr 2021 13:58:17 +0200
Subject: [LTP] [PATCH v4] syscalls/chown: Rewrite chown/chown03.c with
 the new api
In-Reply-To: <20210420061954.155049-1-xieziyao@huawei.com>
References: <20210419013427.247615-1-xieziyao@huawei.com>
 <20210420061954.155049-1-xieziyao@huawei.com>
Message-ID: <YIATWfAJEvFhvZ77@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	SAFE_SETEUID(0);
> +	SAFE_CHOWN(FILENAME, -1, 0);
> +	SAFE_CHMOD(FILENAME, NEW_PERMS);
> +	SAFE_SETEUID(ltpuser->pw_uid);
> +
> +	uid_t uid;
> +	gid_t gid;
> +	UID16_CHECK((uid = geteuid()), "chown");
> +	GID16_CHECK((gid = getegid()), "chown");
> +
> +	struct stat stat_buf;
> +	SAFE_STAT(FILENAME, &stat_buf);
> +	check_owner(&stat_buf, uid, 0);

We should check that the S_ISUID and S_ISGID bits are set here as well.

Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
