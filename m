From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2021 11:28:52 +0100
Subject: [LTP] [PATCH 1/2] syscalls/getpid01: Convert to new API
In-Reply-To: <20210224031227.151844-1-ruansy.fnst@cn.fujitsu.com>
References: <20210224031227.151844-1-ruansy.fnst@cn.fujitsu.com>
Message-ID: <YDYqZMYBVfh8oiYH@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void verify_getpid(void)
>  {
> +	TEST(getpid());
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TTERRNO, "getpid()");
> +	else
> +		tst_res(TPASS, "getpid() returns %ld", TST_RET);

The POSIX actually mandates that getpid() cannot fail and is always
successful. Given that this test seems to be useless and could be
removed or replaced with something more sane.

I guess that what we can do is to check if the return value from
getpid() is greater than 1, since pid 1 is special no other process than
init can have pid == 1. And the value has to be smaller or equal to
/proc/sys/kernel/pid_max as well.

So what would I do here would be:

* read /proc/sys/kernel/pid_max value
* loop 100 times or so
  - fork a child
  - check that the pid in child is > 1 and <= pid_max

-- 
Cyril Hrubis
chrubis@suse.cz
