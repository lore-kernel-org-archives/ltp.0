From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Feb 2019 17:04:02 +0100
Subject: [LTP] [PATCH v2] syscalls/setrlimit06: Add new test for
	RLIMIT_CPU
In-Reply-To: <1548997446-3969-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20190131105343.GA11386@rei>
 <1548997446-3969-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190222160402.GD23713@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +static void verify_setrlimit(void)
> +{
> +	int status;
> +	pid_t pid;
> +

Added *end = 0 here so that it's reset in a case of test looping (the -i parameter).

> +	pid = SAFE_FORK();

-- 
Cyril Hrubis
chrubis@suse.cz
