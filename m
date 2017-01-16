From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 14:33:20 +0100
Subject: [LTP] [PATCH] rt_sigtimedwait01: fix probability of failure
In-Reply-To: <5863ACB5.8000606@huawei.com>
References: <584FBAE7.2010100@huawei.com> <20161213104352.GA750@rei.lan>
 <585201FA.9010508@huawei.com> <5863ACB5.8000606@huawei.com>
Message-ID: <20170116133302.GC26610@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	pid = getpid();
>  	WITH_SIGNALS_BLOCKED(if ((cpid = fork()) == 0) {
> @@ -138,6 +139,8 @@ pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
>  		EPRINTF("fork failed.\n");
>  		return cpid;
>  	default:
> +		/* wait cpid finish */

The comment here is redundant and useless.

> +		waitpid(cpid, &status, 0);
>  		return cpid;
>  	}
>  }
> -- 
> 1.8.3.4
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
