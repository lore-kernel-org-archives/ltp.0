From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 20 Jul 2020 15:45:43 +0530
Subject: [LTP] [RFC 0/3] syscalls: Rearrange sigwait syscall tests
In-Reply-To: <cover.1594367611.git.viresh.kumar@linaro.org>
References: <cover.1594367611.git.viresh.kumar@linaro.org>
Message-ID: <20200720101543.txvvfa5m7sua3evv@vireshk-mac-ubuntu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10-07-20, 13:31, Viresh Kumar wrote:
> Hi Cyril,
> 
> As suggested by you I have tried to rearrange stuff here and having some
> difficulty in getting rid of the last few build and runtime errors. And
> so sending this as RFC.
> 
> Problem 1: Build failure.
> ---------
> 
> This fails with the error:
> ltp/libs/libltpsigwait/sigwaitinfo01.c:53: undefined reference to `create_sig_proc'
> 
> create_sig_proc() is defined in lib/ and I am trying to use it in libs/.
> Somehow linking is failing here as there is no local user of the routine
> create_sig_proc() within lib/ directory. If I create a dummy user
> (https://pastebin.com/LiNukt1n) there, then the build passes.
> 
> I don't know how to properly fix this.
> 
> Problem 2: Runtime breakage.
> ---------
> 
> If I build it using the earlier hack then at runtime I have started to
> get following error while running the tests now, right after the first
> test passes:
> 
> tst_test.c:362: BROK: Child (14595) killed by signal SIGTERM
> 
> I don't really understand why this has started to come up now, while it
> didn't happen earlier at all.
> 
> This is rebased over the earlier series which is under review
> (specifically the following patch,
> [PATCH V7 10/19] syscalls/rt_sigtimedwait: Add support for time64 tests).

Ping!

-- 
viresh
