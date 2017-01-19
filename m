From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jan 2017 15:39:03 +0100
Subject: [LTP] [PATCH 1/2] ipc/libnewipc.c: add CREATE_MSG to optimize
 duplicate code
In-Reply-To: <1481860457-23035-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1481860457-23035-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170119143903.GC9193@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int create_msg(const char *file, const int lineno, key_t key, int msgflg);
> +#define CREATE_MSG(key, msgflg) \
> +	create_msg(__FILE__, __LINE__, key, msgflg)

Looking at this, we should rather start tst_safe_sysv_ipc.h and
implement it as SAFE_MSGGET() so that possibly reusable outside the ipc
directory as well.

-- 
Cyril Hrubis
chrubis@suse.cz
