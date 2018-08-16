From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Aug 2018 13:54:34 +0200
Subject: [LTP] [PATCH] syscalls/signalfd01.c: Fix compiler warnings
In-Reply-To: <1532087697-28093-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1532087697-28093-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180816115434.GB6547@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		tst_resm(TFAIL,
>  			 "getting incomplete signalfd_siginfo data: "
> -			 "actual-size=%" PRId32 ", expected-size=%" PRId32,
> +			 "actual-size=%zd" PRId32 ", expected-size=%ld" PRId32,
>  			 s, sizeof(struct signalfd_siginfo));

This is obviously wrong, you have to, at least, remove the PRId32
formatting strings here. Also sizeof() returns size_t hence it should
be formatted with %zu.

>  		sfd_for_next = -1;
>  		close(sfd);
> @@ -170,7 +170,7 @@ int do_test1(int ntst, int sig)
>  		goto out;
>  	}
>  
> -	if (fdsi.SIGNALFD_PREFIX(signo) == sig) {
> +	if ((int)fdsi.SIGNALFD_PREFIX(signo) == sig) {

Maybe it would be clearner to defined the sig to be uint32_t rathe than
sprinkle the code with int casts

-- 
Cyril Hrubis
chrubis@suse.cz
