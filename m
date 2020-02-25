From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Feb 2020 13:54:50 +0100
Subject: [LTP] [PATCH] syscalls/kill11: convert to new library
In-Reply-To: <1582271720-27370-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1582271720-27370-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200225125449.GD5077@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +	if (tc->sig != SIGKILL) {
> +		if (sigset(tc->sig, SIG_DFL) == SIG_ERR)
> +			tst_brk(TBROK | TERRNO, "sigset(%d) failed", tc->sig);
>  	}

There is no need to restore the default signal handlers if we haven't
changed them, so I've removed this part as well.

-- 
Cyril Hrubis
chrubis@suse.cz
