From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jan 2017 14:32:05 +0100
Subject: [LTP] [PATCH v2 1/3] syscalls/getcwd02.c: cleanup && convert to
	new API
In-Reply-To: <1484719408-28782-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170117134335.GA28074@rei.lan>
 <1484719408-28782-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170118133204.GC29948@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (tc->buf != NULL && strcmp(exp_buf, tc->buf)) {
> +		tst_res(TFAIL, "getcwd() returned unexpected directory: %s, "
> +			"expected: %s", tc->buf, exp_buf);
> +		goto end;

I've removed this check because it was redundant. Unless tc->buf is NULL
the tc->buf is the same as res.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
