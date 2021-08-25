From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 15:12:16 +0200
Subject: [LTP] [PATCH 3/7] syscalls/clone03: Convert to new API
In-Reply-To: <20210813072636.21590-1-zhanglianjie@uniontech.com>
References: <20210813072636.21590-1-zhanglianjie@uniontech.com>
Message-ID: <YSZBsKhG3j/iI9O6@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void setup(void)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> +	SAFE_PIPE(pfd);

I guess that it would be probably easier to mmap() a piece of shared
anonymous memory and used that instead of the pipe().

See for example setrlimit06.c

-- 
Cyril Hrubis
chrubis@suse.cz
