From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Feb 2019 14:22:51 +0100
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
 <20190215121611.GA14270@rei>
 <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
Message-ID: <20190215132251.GB26339@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for the pointers. IIUC, you are referring to following change:
> 
> -       TEST(syncfs(fd));
> +       TEST(tst_syscall(__NR_syncfs, fd));
> 
> If yes, then I will incorporate it.

The most complete solution is configure check + fallback definition.

Have a look at:

include/lapi/execveat.h
m4/ltp-execveat.m4
configure.ac

-- 
Cyril Hrubis
chrubis@suse.cz
