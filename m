From: xieziyao <xieziyao@huawei.com>
Date: Thu, 22 Apr 2021 02:51:40 +0000
Subject: [LTP] [PATCH v4] syscalls/chown: Rewrite chown/chown03.c with
 the new api
In-Reply-To: <YIATWfAJEvFhvZ77@yuki>
References: <20210419013427.247615-1-xieziyao@huawei.com>
 <20210420061954.155049-1-xieziyao@huawei.com> <YIATWfAJEvFhvZ77@yuki>
Message-ID: <c13fc2e2339e43f7908fb2d3f53cf745@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks, I just made changes on your suggestions.

Please see: https://patchwork.ozlabs.org/project/ltp/patch/20210422024410.175538-1-xieziyao@huawei.com/

Best Regards,
Ziyao

-----Original Message-----
From: Cyril Hrubis [mailto:chrubis@suse.cz] 
Sent: Wednesday, April 21, 2021 7:58 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it; alexey.kodanev@oracle.com
Subject: Re: [LTP][PATCH v4] syscalls/chown: Rewrite chown/chown03.c with the new api

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
