From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 14:05:36 +0200
Subject: [LTP] [PATCH V3 1/3] syscalls: select: Merge few tests and
 migrate to new format
In-Reply-To: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
Message-ID: <20201014120536.GC31816@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct select_info {
               ^
	 I've renamed this to struct tcases because we do have a
	 select_info function as well...

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
