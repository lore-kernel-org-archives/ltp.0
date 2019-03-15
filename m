From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2019 19:31:16 +0530
Subject: [LTP] [PATCH v2 1/3] syscalls/tgkill01: add new test
In-Reply-To: <20190315101810.GB5383@rei>
References: <1552457573-1354-1-git-send-email-sumit.garg@linaro.org>
 <1552457573-1354-2-git-send-email-sumit.garg@linaro.org>
 <20190314122232.GA17823@rei.lan>
 <CAFA6WYPFiJArJvcDGLmxF5XK-q_6Yu24o=st10LE0Lz7d1Lesg@mail.gmail.com>
 <20190314135837.GA2536@rei.lan>
 <CAFA6WYPNLiE1gFDko1uV8wnnyBVdX4CUyo0od7AkkoYgYQ6Dhg@mail.gmail.com>
 <20190315101810.GB5383@rei>
Message-ID: <CAFA6WYN0T1WbxmHy67YKx=B58eqZpC70Cqw4RvW+yPzsmLCV2Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 15 Mar 2019 at 15:48, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > Wouldn't this loop be more appropriate in
> > "tst_safe_checkpoint_wait()"? As at later stage we may have tests that
> > depends on checkpoints being interrupted by signals and could directly
> > use "tst_checkpoint_wait()".
>
> The tst_checkpoint_wait() has a single use in the source tree and that
> is testcases/lib/tst_checkpoint.c which is binary wrapper around
> checkpoints so that we can use them in shell scripts as well, which is
> pretty cool btw. And I think that we should retry on EINTR there as
> well.

Ah, I see.

>
> Also there does not seem to be test relying on checkpoints being
> interrupted by signals and I would like to avoid this pattern ideally as
> asynchronous events such as signals interrupting functions is something
> rather counter intuitive.
>

Ok got it. Should I pick up this change as separate patch in this
patch-set or would you like to commit it and then I would update
patch-set to use these checkpoints?

-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
