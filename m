From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 May 2020 11:33:24 +0200
Subject: [LTP] [PATCH V2 16/17] syscalls/utimensat: Migrate to new test
 framework
In-Reply-To: <e03c9d77116e9f7f2b6a179644aab18bd9ece9e1.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <e03c9d77116e9f7f2b6a179644aab18bd9ece9e1.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <20200511093324.GC3070@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (tc->rattr != NULL)
> +		run_command("chattr", tc->rattr, tc->pathname);

Can we please use the FS_IOC_GETFLAGS and FS_IOC_SETFLAGS instead?

Have a look at fallocate06.c function toggle_cow()

-- 
Cyril Hrubis
chrubis@suse.cz
