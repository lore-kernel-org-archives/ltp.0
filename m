From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Jan 2019 14:47:01 +0100
Subject: [LTP] [PATCH] syscalls/vhangup: convert to new lib,
 use direct syscall
In-Reply-To: <20190126015606.236588-1-smuckle@google.com>
References: <20190126015606.236588-1-smuckle@google.com>
Message-ID: <20190131134701.GC18486@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if ((pid = SAFE_FORK()) < 0) {
> +		tst_brk(TBROK | TTERRNO, "fork failed");

I've removed this pid < 0 check, since the whole point of SAFE_* macros
is that the call will either succeed or exit the test.

> +	} else if (pid > 0) {
> +		/* parent */
> +		waitpid(pid, NULL, 0);
> +	} else {
> +		/* child */

And also these useless /* parent */ and /* child */ comments.


And pushed, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
