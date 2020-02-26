From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 26 Feb 2020 10:04:35 +0530
Subject: [LTP] [PATCH V3 08/10] syscalls/move_mount: New tests
In-Reply-To: <f1801e95-5200-48ee-a8b9-38e8b90e6593@cn.fujitsu.com>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <e12560056ebc632918426194172a6cba48953d4e.1582612624.git.viresh.kumar@linaro.org>
 <20200225135709.GC62318@gacrux.arch.suse.de>
 <20200226022758.ls35mblsetg4nk6f@vireshk-i7>
 <f1801e95-5200-48ee-a8b9-38e8b90e6593@cn.fujitsu.com>
Message-ID: <20200226043435.m4fkofj5533sd35t@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26-02-20, 11:34, Yang Xu wrote:
> If using TBROK, it will terminate the program. So how can test the remaining
> test?
> Like move_mount02.c, if test "invalid-from-fd"and fsconfig failed, it will
> exit. So how do you test "invalid-from-path"?
> 
> Also, using return after TBROK is meaningless.

I think one of us has surely misunderstood it all :)

What my understanding says is that if you use tst_brk(), then it
breaks the test and returns early. TBROK or TFAIL, both can be used in
tst_brk() or tst_ret() and they only imply what has failed, the test
or some preparatory thing.

-- 
viresh
