From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 15:47:52 +0200
Subject: [LTP] [PATCH v3] syscalls/move_page12: Add new regression test
In-Reply-To: <1558432300-2269-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190520144145.GC28976@rei.lan>
 <1558432300-2269-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190521134752.GB19326@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		if (tcases[n].offline) {
> +			if (do_soft_offline(tcases[n].tpages) == EINVAL) {
> +				SAFE_KILL(cpid, SIGKILL);
> +				SAFE_WAITPID(cpid, &status, 0);
> +				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
> +				tst_res(TFAIL,
					^
					Shouldn't this be TCONF instead?

> +					"madvise() didn't support "
> +					"MADV_SOFT_OFFLINE");
                                             ^
					 LKML coding style prefers not
					 to break up user visible
					 strings, so this string should
					 be on one line even if the line
					 is longer than 80 chars.

> +				return;
> +			}
> +		}

Other than that it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
