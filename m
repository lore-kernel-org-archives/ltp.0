From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Feb 2021 13:54:28 +0100
Subject: [LTP] [PATCH 5/5] close_range: Add test
In-Reply-To: <20210211110317.31942-6-rpalethorpe@suse.com>
References: <20210211110317.31942-1-rpalethorpe@suse.com>
 <20210211110317.31942-6-rpalethorpe@suse.com>
Message-ID: <YCUpBDrPMatJGiZD@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static inline void do_close_range(unsigned int fd, unsigned int max_fd,
> +				  unsigned int flags)
> +{
> +	int ret = tst_syscall(__NR_close_range, fd, max_fd, flags);

Can we please add configure test and fallback definition into lapi/ as
we usually do instead of calling the raw syscall here?

-- 
Cyril Hrubis
chrubis@suse.cz
