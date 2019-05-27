From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 May 2019 15:41:25 +0200
Subject: [LTP] [PATCH v4] syscalls/prctl05.c: New test for prctl() with
 PR_{SET, GET}_NAME
In-Reply-To: <1558945171-2252-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <7113d89a-3eb8-5671-bb6a-26cc4cbb69bf@163.com>
 <1558945171-2252-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190527134125.GA23658@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor change, thanks.

...

> +	if (strcmp(tc->expname, buf)) {
> +		tst_res(TFAIL,
> +			"prctl(PR_GET_NAME) failed, expected %s, got %s", tc->expname, buf);
> +		return;
> +	}

I've changed this strcmp() to strncmp() to avoid undefined behavior in
unlikely case that kernel failed to terminated the buffer.

-- 
Cyril Hrubis
chrubis@suse.cz
