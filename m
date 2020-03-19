From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 19 Mar 2020 21:21:01 +0530
Subject: [LTP] [PATCH V2 2/2] syscalls/clone3: New tests
In-Reply-To: <20200319232426.GD29386@yuki.lan>
References: <cover.1584618969.git.viresh.kumar@linaro.org>
 <c64b9c05053d500a95cc920e332fa229085217b6.1584618969.git.viresh.kumar@linaro.org>
 <20200319230111.GC29386@yuki.lan>
 <20200319151956.3rwix5oint6cmt4f@vireshk-i7>
 <20200319232426.GD29386@yuki.lan>
Message-ID: <20200319155101.4vebj66v7vbv3x6h@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-03-20, 00:24, Cyril Hrubis wrote:
> Huh? All that we have to is to move the code from the child_rx_signal()
> to the do_child() here, the child would setup a handler and call
> pause(), then it checks if correct values have been stored to a global
> varibles. And the same for the parent, the point is that we should do a
> minimal amount of work in the handler itself.
> 
> The problem here is that tst_res() writes to std streams, that have
> locks, so if we happen to get a signal while something writes there as
> well, we deadlock. Also printf()-like functions may call malloc, which
> has locks and may deadlock in the same way. It's unlikely that it will
> ever happen in this test, but that does not excuse us...

Ahh, I somehow read that as you are asking me to do all TPASS, TFAIL
thing in the run() call instead and so went into sharing between
parent child. Sorry about that.

-- 
viresh
