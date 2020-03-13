From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Mar 2020 09:49:47 +0530
Subject: [LTP] [PATCH] syscalls/clone3: New tests
In-Reply-To: <20200312134300.GB3803@rei.lan>
References: <08f6f9f8af7b8f999136cc2a30744a8d678d2b5f.1584000268.git.viresh.kumar@linaro.org>
 <20200312134300.GB3803@rei.lan>
Message-ID: <20200313041947.2ua6abqerhdo6wfv@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12-03-20, 14:43, Cyril Hrubis wrote:
> Also all pidfd, child_tid, and parent_tid should be tested with invalid
> pointers right?

I tried this but here is the problem ..

- pidfd: Kernel doesn't check this pointer and we get EFAULT.
- child_tid: Kernel checks for valid pointer and doesn't use the
  variable if NULL, so test passes unexpectedly.
- parent_tid: Kernel doesn't verify the pointer, but doesn't return
  the error code properly and so test passes unexpectedly.

And so I wasn't sure on what we should be doing really.

-- 
viresh
