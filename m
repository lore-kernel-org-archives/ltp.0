From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Apr 2021 16:55:47 +0200
Subject: [LTP] [PATCH v3] syscalls/chown: Rewrite chown/chown03.c with
 the new api
In-Reply-To: <20210419013427.247615-1-xieziyao@huawei.com>
References: <20210419013427.247615-1-xieziyao@huawei.com>
Message-ID: <YH2Z80HB8viimLOe@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +    SAFE_SETEUID(0);
> +    SAFE_CHOWN(FILENAME, -1, 0);
> +    SAFE_CHMOD(FILENAME, NEW_PERMS);
> +    SAFE_SETEUID(ltpuser->pw_uid);

LTP uses Linux kernel conding style which requires tabs for
indentation, while this code uses four spaces.

You can use checkpatch.pl shipped along with Linux kernel sources to
check coding style before sending patches to the list.

-- 
Cyril Hrubis
chrubis@suse.cz
