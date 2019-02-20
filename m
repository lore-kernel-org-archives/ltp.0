From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 17:33:29 +0100
Subject: [LTP] [PATCH 3/3] syscalls/ptrace05: Include lapi/signal.h for
 __SIGRT{MIN, MAX}
In-Reply-To: <20190220153412.18090-3-daniel.diaz@linaro.org>
References: <20190220153412.18090-1-daniel.diaz@linaro.org>
 <20190220153412.18090-3-daniel.diaz@linaro.org>
Message-ID: <20190220163329.GA7554@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Daniel,

> MUSL does not include __SIGRTMIN nor __SIGRTMAX. The
> compatibility header can help here.
lib/tst_sig.c and testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c also
use __SIGRTMIN. Don't you have a problem to build it?

+ I'd squash adding of these includes into single commit.


Kind regards,
Petr
